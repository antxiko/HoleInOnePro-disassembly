#!/usr/bin/env python3
"""Los dos descompresores del cartucho, reproducidos byte a byte.

El cartucho guarda la VRAM comprimida por rachas y tiene DOS variantes, que se
distinguen por el byte de escape:

  0x6AFA  escape 0xA0..0xAF: (n & 0x0F) + 2 copias del byte siguiente.
          Es la de los patrones y las tablas de nombres.
  0x6ABD  escape 0x00..0x0F: (n & 0x0F) + 1 vueltas de un PAR de bytes que se
          alternan, repetido tantas veces como diga el byte de cuenta -y una
          cuenta de 0 son 256 vueltas, porque el `djnz` sale con B a cero-.
          Es la de las tablas de color de SCREEN 2, donde los bytes van a pares.

Las dos paran cuando el puntero de destino alcanza el tope, no cuando se acaba
la entrada: por eso este guion pide el tope y devuelve cuantos bytes de ROM ha
consumido, que es lo que dice donde acaba de verdad cada bloque.

Uso: descomprime.py <binario> <org> <fuente> <destino> <tope> [a|color]
"""
import sys


def racha(rom, org, fuente, destino, tope):
    """La de 0x6AFA. Devuelve (bytes escritos, direccion tras la fuente)."""
    de = fuente - org
    out = bytearray()
    hl = destino
    while hl != tope:
        v = rom[de]
        if v & 0xF0 == 0xA0:
            n = (v & 0x0F) + 2
            de += 1
            b = rom[de]
            de += 1
            for _ in range(n):
                out.append(b)
                hl = (hl + 1) & 0xFFFF
        else:
            out.append(v)
            de += 1
            hl = (hl + 1) & 0xFFFF
    return bytes(out), de + org


def pares(rom, org, fuente, destino, tope):
    """La de 0x6ABD. Devuelve (bytes escritos, direccion tras la fuente)."""
    de = fuente - org
    out = bytearray()
    hl = destino
    while hl != tope:
        v = rom[de]
        if v & 0xF0 == 0x00:
            c = v & 0x0F
            de += 1
            b = rom[de]
            de += 1
            a1 = rom[de]
            de += 1
            a2 = rom[de]
            de += 1
            while True:
                n = b if b else 256
                for _ in range(n):
                    out.append(a1)
                    out.append(a2)
                    hl = (hl + 2) & 0xFFFF
                c -= 1
                if c < 0:
                    break
        else:
            out.append(v)
            de += 1
            hl = (hl + 1) & 0xFFFF
    return bytes(out), de + org


def main(argv):
    if len(argv) < 6:
        print(__doc__)
        return 2
    rom = open(argv[1], "rb").read()
    org = int(argv[2], 0)
    fuente, destino, tope = (int(x, 0) for x in argv[3:6])
    modo = argv[6] if len(argv) > 6 else "a"
    fn = pares if modo.startswith("c") else racha
    datos, fin = fn(rom, org, fuente, destino, tope)
    print("fuente 0x%04X..0x%04X  (%d bytes de ROM)" % (fuente, fin, fin - fuente))
    print("destino 0x%04X..0x%04X (%d bytes de VRAM)" % (destino, tope, len(datos)))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
