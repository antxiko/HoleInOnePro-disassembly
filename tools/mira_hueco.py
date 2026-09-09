#!/usr/bin/env python3
"""Vuelca un hueco del cartucho de tres maneras a la vez, para decidir que es.

Un rango sin explicar puede ser una tabla de punteros, texto, una tabla de
numeros o codigo al que el trazado no llega. Mirarlo en hexadecimal solo no
basta: aqui sale el hexadecimal, el ASCII y -lo que mas decide- si los pares de
bytes caen dentro del cartucho, que es la firma de una tabla de punteros.

Uso: mira_hueco.py <binario> <org> <ini> <fin>   (fin exclusivo)
"""
import sys


def main(argv):
    if len(argv) < 5:
        print(__doc__)
        return 2
    b = open(argv[1], "rb").read()
    org = int(argv[2], 0)
    ini, fin = int(argv[3], 0), int(argv[4], 0)
    t = b[ini - org:fin - org]
    tope = org + len(b)

    for i in range(0, len(t), 16):
        fila = t[i:i + 16]
        hx = " ".join("%02x" % c for c in fila)
        tx = "".join(chr(c) if 32 <= c < 127 else "." for c in fila)
        print("%04X  %-47s  %s" % (ini + i, hx, tx))

    print()
    dentro = 0
    pares = []
    for i in range(0, len(t) - 1, 2):
        v = t[i] | (t[i + 1] << 8)
        pares.append(v)
        if org <= v < tope:
            dentro += 1
    if pares:
        print("como punteros de 16 bits: %d de %d caen dentro del cartucho (%.0f %%)"
              % (dentro, len(pares), 100.0 * dentro / len(pares)))
        print("  " + " ".join("%04X" % v for v in pares[:32]))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
