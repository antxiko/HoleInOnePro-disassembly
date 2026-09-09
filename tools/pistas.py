#!/usr/bin/env python3
"""Sigue las doce pistas de PSG con el mismo interprete de 0x6B83.

Los limites de las pistas no estan escritos en ninguna parte: la tabla de
0x6B55 dice donde empieza cada una, y donde acaba solo se sabe siguiendola. Asi
que aqui se recorre byte a byte con las mismas reglas que el codigo:

  bit 7 o 6 puestos   NOTA: (n & 0x3F) * 2 indexa la tabla de tonos, y se
                      escriben DOS registros de PSG seguidos
  bit 5 a cero        ESPERA: el byte es la cuenta de cuadros, y la pista se
                      queda ahi hasta la proxima interrupcion
  0x2D                guarda la forma de envolvente
  0x3D                PARADA: silencia el mezclador
  0x3E                pone a cero los registros 0 a 5
  0x33                SALTO: los dos bytes siguientes son la direccion
  el resto            escritura suelta de un registro, con su valor detras

Lo que se busca es hasta donde llega cada pista y cual es el indice de nota mas
alto que usan las doce, que es lo que dice donde acaba la tabla de tonos.

Uso: pistas.py <binario> <org>
"""
import sys

TABLA = 0x6B55
NUM = 12


def sigue(rom, org, ini, tope):
    """Recorre una pista. Devuelve (ultimo byte usado, nota mas alta, como acaba)."""
    hl = ini
    alta = -1
    vistos = set()
    while True:
        if hl in vistos or not (org <= hl < tope):
            return hl, alta, "bucle" if hl in vistos else "fuera"
        vistos.add(hl)
        v = rom[hl - org]
        if v & 0xC0:
            n = v & 0x3F
            alta = max(alta, n)
            hl += 1
            continue
        if not v & 0x20:
            return hl + 1, alta, "espera 0x%02X" % v
        if v == 0x3D:
            return hl + 1, alta, "PARADA"
        if v == 0x3E:
            hl += 2
            continue
        if v == 0x33:
            hl = rom[hl + 1 - org] | (rom[hl + 2 - org] << 8)
            continue
        hl += 2                                  # 0x2D y las escrituras sueltas


def main(argv):
    rom = open(argv[1], "rb").read()
    org = int(argv[2], 0)
    tope = org + len(rom)
    pt = [rom[TABLA - org + 2 * i] | (rom[TABLA - org + 2 * i + 1] << 8) for i in range(NUM)]
    print("tabla de 0x%04X:" % TABLA)
    for i, p in enumerate(pt):
        print("  pista %2d  0x%04X" % (i, p))

    # Una pista NO acaba donde para el interprete: para y espera a la
    # interrupcion siguiente, asi que hay que seguirla hasta el final. Se
    # recorre entera saltando las esperas.
    alcanzados = {}
    for i, p in enumerate(pt):
        hl, alta, fin = p, -1, ""
        vistos = set()
        while org <= hl < tope and hl not in vistos:
            vistos.add(hl)
            v = rom[hl - org]
            if v & 0xC0:
                alta = max(alta, v & 0x3F)
                hl += 1
            elif not v & 0x20:
                hl += 1                          # espera: sigue en el byte de al lado
            elif v == 0x3D:
                hl += 1
                fin = "PARADA en 0x%04X" % (hl - 1)
                break
            elif v == 0x3E:
                hl += 2
            elif v == 0x33:
                d = rom[hl + 1 - org] | (rom[hl + 2 - org] << 8)
                fin = "SALTO a 0x%04X desde 0x%04X" % (d, hl)
                hl += 3
                break
            else:
                hl += 2
        alcanzados[i] = (p, hl, alta, fin)

    print("\npista  desde   hasta   bytes  nota mas alta  final")
    for i in range(NUM):
        p, fin, alta, com = alcanzados[i]
        print("  %2d  0x%04X  0x%04X  %5d  %13d  %s" % (i, p, fin, fin - p, alta, com))
    print("\nnota mas alta de las doce: %d  ->  la tabla de tonos llega a 0x%04X"
          % (max(a[2] for a in alcanzados.values()),
             0x6C0D + 2 * max(a[2] for a in alcanzados.values()) + 2))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
