#!/usr/bin/env python3
"""Quien nombra una direccion, leido del listado.

Para poner nombre a un bloque de datos hace falta saber QUIEN lo lee. Este
guion busca en el listado toda instruccion cuyo operando inmediato de 16 bits
caiga dentro de un rango, y la imprime con su direccion y su etiqueta de
rutina, que es lo que dice para que sirve el bloque.

Uso: refs.py <listado.asm> <ini> <fin>        (fin exclusivo)
     refs.py <listado.asm> <ini>              (una sola direccion)
"""
import re
import sys

# Una linea del listado: "\tld hl,09435h\t\t;940d ..." o "L_4010:".
RE_ETIQ = re.compile(r"^([A-Za-z_][A-Za-z0-9_]*):")
RE_DIR = re.compile(r";([0-9a-f]{4})\b")
RE_HEX = re.compile(r"\b0([0-9a-f]{4})h\b")


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    ini = int(argv[2], 0)
    fin = int(argv[3], 0) if len(argv) > 3 else ini + 1
    rutina = "?"
    salida = []
    for ln in open(argv[1], encoding="utf-8"):
        m = RE_ETIQ.match(ln)
        if m:
            rutina = m.group(1)
            continue
        cuerpo = ln.split(";")[0]
        if not cuerpo.strip():
            continue
        md = RE_DIR.search(ln)
        aqui = md.group(1) if md else "----"
        for mh in RE_HEX.finditer(cuerpo):
            v = int(mh.group(1), 16)
            if ini <= v < fin:
                salida.append("  %s  %-40s  (en %s)" % (aqui, cuerpo.strip(), rutina))
                break
    if not salida:
        print("nadie nombra 0x%04X..0x%04X en el listado" % (ini, fin))
    else:
        print("0x%04X..0x%04X lo nombran %d instrucciones:" % (ini, fin, len(salida)))
        print("\n".join(salida))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
