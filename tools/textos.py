#!/usr/bin/env python3
"""Expande los textos comprimidos del cartucho con el mismo bucle que 0x6822.

El cartucho no guarda las pantallas de texto tal cual: guarda una tira de bytes
que 0x6822 va soltando en la tabla de nombres. La regla, leida de esa rutina:

  byte >= 0x20            un caracter, tal cual
  byte 0x10..0x1F         repite el byte SIGUIENTE (n & 0x0F) veces
  byte < 0x10             repite un espacio n veces

y el llamador dice cuantas filas (C) y cuantos caracteres por fila (B). Aqui se
reproduce igual, para poder citar los textos SIN copiarlos a mano.

Uso: textos.py <binario> <org> <ini> <filas> <anchura>
"""
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def expande(b, org, ini, filas, ancho):
    """Devuelve (lista de filas, direccion del primer byte no consumido)."""
    de = ini - org
    salida = []
    for _ in range(filas):
        fila = []
        n = ancho
        while n > 0:
            v = b[de]
            if v >= 0x20:
                fila.append(chr(v) if v < 127 else "·")
                de += 1
                n -= 1
                continue
            if v < 0x10:
                cuenta, ch = v, " "
                de += 1
            else:
                cuenta = v & 0x0F
                de += 1
                ch = chr(b[de]) if b[de] < 127 else "·"
                de += 1
            fila.append(ch * cuenta)
            n -= cuenta
        salida.append("".join(fila))
    return salida, de + org


def main(argv):
    if len(argv) < 6:
        print(__doc__)
        return 2
    b = open(argv[1], "rb").read()
    org = int(argv[2], 0)
    ini = int(argv[3], 0)
    filas, ancho = int(argv[4], 0), int(argv[5], 0)
    fs, fin = expande(b, org, ini, filas, ancho)
    for i, f in enumerate(fs):
        print("%2d |%s|" % (i, f))
    print("\nconsumidos 0x%04X..0x%04X (%d bytes) para %d filas de %d"
          % (ini, fin, fin - ini, filas, ancho))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
