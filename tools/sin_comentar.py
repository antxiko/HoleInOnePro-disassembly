#!/usr/bin/env python3
"""Saca del listado las instrucciones que AUN no llevan comentario.

La segunda pasada de comentado no se hace releyendo el listado entero: se
mira solo lo que falta. Esto imprime, rutina a rutina, las lineas sin
comentario, con su direccion delante, listas para copiar a una directiva C.

Uso: sin_comentar.py <asm> [ini] [fin]
"""
import re
import sys

RE_ETIQ = re.compile(r"^([A-Za-z_][A-Za-z0-9_]*):")
RE_INS = re.compile(r"^\t(.*?)\s*;([0-9a-f]{4})(.*)$")


def main(argv):
    ini = int(argv[2], 0) if len(argv) > 2 else 0
    fin = int(argv[3], 0) if len(argv) > 3 else 0x10000
    rutina = "(cabecera)"
    pendiente = []
    for ln in open(argv[1], encoding="utf-8"):
        m = RE_ETIQ.match(ln)
        if m:
            rutina = m.group(1)
            continue
        m = RE_INS.match(ln)
        if not m:
            continue
        d = int(m.group(2), 16)
        if not (ini <= d < fin):
            continue
        if ";" in m.group(3):
            continue
        if pendiente and pendiente[-1][0] != rutina:
            pass
        pendiente.append((rutina, d, m.group(1)))
    ultima = None
    for rut, d, ins in pendiente:
        if rut != ultima:
            print("--- %s" % rut)
            ultima = rut
        print("C 0x%04x %-24s #" % (d, ins))
    print("# %d instrucciones sin comentar en 0x%04X..0x%04X" % (len(pendiente), ini, fin))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
