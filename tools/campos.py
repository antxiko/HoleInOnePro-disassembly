#!/usr/bin/env python3
"""Lee los campos de golf de Hole in One Professional.

EL FORMATO ES EL MISMO QUE EL DEL HOLE IN ONE DE 1984, y eso no es una
impresion: el interprete de guiones de aquel cartucho lee estos treinta y seis
guiones enteros, cada uno con sus 480 celdas, su par y sus tres digitos ASCII de
longitud. Ademas lo dice el propio codigo de este:

    0x70B8   recorre el guion buscando 0xD9, 0xDD y 0xE3 -los tres tiles de
             tee, que ademas dicen el par- y apunta donde cae en (0xCEC8)
    0x70D3   resta 0xCB00 y divide por 20, o sea que el campo se monta en
             0xCB00 y la rejilla sigue siendo de veinte de ancho

Y LO QUE CAMBIA: este cartucho trae DOS campos de dieciocho hoyos, no uno.

    0x716B..0x71B2   treinta y seis punteros de dos bytes
    0x71B3..0x9D6C   los treinta y seis guiones

EL FORMATO, tal como lo lee el interprete:

    Los tres primeros bytes de un guion son los MATERIALES del hoyo. En el
    guion, un byte 0x3n, 0x4n o 0x5n repite n+1 veces el primero, el segundo o
    el tercero; cualquier otro byte es una celda literal -y por eso una celda
    literal no puede valer entre 0x30 y 0x5F-. Tres literales marcan sitio:
    0xE9 es la bandera y 0xD9/0xDD/0xE3 el tee. Cierra un 0x21, y detras van
    tres digitos ASCII con la longitud en metros.

Uso: campos.py <rom> <org>
"""
import sys

ORG = 0x4000
TABLA = 0x716B          # los 36 punteros
CAMPOS = 2
HOYOS = 18
ANCHO, ALTO = 20, 24
BANDERA = 0xE9
PAR_DEL_TEE = {0xD9: 3, 0xDD: 4, 0xE3: 5}


class Rom(object):
    def __init__(self, datos, org=ORG):
        self.d, self.org = datos, org

    def b(self, a):
        return self.d[a - self.org]

    def w(self, a):
        return self.d[a - self.org] | (self.d[a - self.org + 1] << 8)


def hoyo(rom, indice, tabla=TABLA):
    """Lee un guion y devuelve su rejilla de 20x24 ya pintada."""
    p = rom.w(tabla + indice * 2)
    cabecera = [rom.b(p), rom.b(p + 1), rom.b(p + 2)]
    paleta = {3: cabecera[0], 4: cabecera[1], 5: cabecera[2]}
    hl = p + 3
    rej = bytearray()
    bandera = tee = par = None
    while len(rej) < ANCHO * ALTO:
        x = rom.b(hl)
        if x == 0x21:
            break
        if 0x30 <= x < 0x60:
            rej.extend([paleta[x >> 4]] * ((x & 0x0F) + 1))
        else:
            if x == BANDERA:
                bandera = len(rej)
            if x in PAR_DEL_TEE:
                par = PAR_DEL_TEE[x]
                tee = len(rej)
            rej.append(x)
        hl += 1
    cola = "".join(chr(rom.b(hl + 1 + i)) for i in range(3))
    metros = int(cola) if cola.isdigit() else None
    return dict(ptr=p, cabecera=cabecera, rejilla=rej, bandera=bandera,
                tee=tee, par=par, metros=metros,
                bytes=(hl + 4 - p) if metros is not None else (hl + 1 - p))


def todos(rom, tabla=TABLA):
    """Los treinta y seis hoyos, en dos campos de dieciocho."""
    return [[hoyo(rom, c * HOYOS + i, tabla) for i in range(HOYOS)]
            for c in range(CAMPOS)]


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    with open(argv[1], "rb") as f:
        rom = Rom(f.read(), int(argv[2], 0))
    for c, campo in enumerate(todos(rom)):
        par = sum(h["par"] for h in campo)
        met = sum(h["metros"] for h in campo)
        print("  campo %d: par %d, %d metros" % (c + 1, par, met))
        for i, h in enumerate(campo):
            print("    hoyo %2d  par %d  %3d metros  guion 0x%04X (%d bytes)"
                  % (i + 1, h["par"], h["metros"], h["ptr"], h["bytes"]))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
