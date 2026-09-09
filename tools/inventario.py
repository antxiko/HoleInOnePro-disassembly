#!/usr/bin/env python3
"""Saca el inventario de rutinas del listado, para bautizarlas.

Por cada etiqueta sin nombre propio (L_XXXX) imprime su direccion, cuantas
instrucciones tiene, quien la llama, a quien llama y el comentario que ya
tenga anclado, mas las primeras instrucciones. Es la hoja de trabajo del paso
de nombres: no cambia nada, solo lee.

Uso: inventario.py <listado.asm> [desde] [hasta] [-n instrucciones]
"""
import re
import sys


def carga(fn):
    with open(fn, encoding="utf-8") as f:
        return f.read().splitlines()


def main(argv):
    if len(argv) < 2:
        print(__doc__)
        return 2
    lineas = carga(argv[1])
    desde = int(argv[2], 0) if len(argv) > 2 else 0
    hasta = int(argv[3], 0) if len(argv) > 3 else 0xFFFF
    cuantas = 12
    if "-n" in argv:
        cuantas = int(argv[argv.index("-n") + 1])

    # Donde empieza cada etiqueta y que instrucciones lleva debajo
    et = re.compile(r"^([A-Za-z_][\w]*):\s*(;.*)?$")
    dirn = re.compile(r";([0-9a-f]{4})(?:\s|$)")
    bloques = []
    actual = None
    for i, l in enumerate(lineas):
        m = et.match(l)
        if m:
            actual = dict(nombre=m.group(1), linea=i, cuerpo=[], cab=[])
            bloques.append(actual)
            continue
        if actual is None:
            continue
        if l.strip().startswith(";"):
            if not actual["cuerpo"]:
                actual["cab"].append(l.strip().lstrip("; "))
            continue
        if l.strip():
            actual["cuerpo"].append(l)

    # Quien llama a quien
    llamantes = {}
    for b in bloques:
        for l in b["cuerpo"]:
            for m in re.finditer(r"\b(call|jp|jr)\s+(?:\w+,)?([A-Za-z_][\w]*)", l):
                llamantes.setdefault(m.group(2), set()).add(b["nombre"])

    n = 0
    for b in bloques:
        if not b["nombre"].startswith("L_"):
            continue
        d = int(b["nombre"][2:], 16)
        if not desde <= d <= hasta:
            continue
        n += 1
        quien = sorted(llamantes.get(b["nombre"], ()))
        print("\n=== %s  (%d instr)  <- %s"
              % (b["nombre"], len(b["cuerpo"]),
                 " ".join(quien[:6]) if quien else "NADIE (tabla o entrada)"))
        for c in b["cab"]:
            print("    # %s" % c)
        for l in b["cuerpo"][:cuantas]:
            print("   ", l.strip())
        if len(b["cuerpo"]) > cuantas:
            print("    ... (%d mas)" % (len(b["cuerpo"]) - cuantas))
    print("\n---- %d rutinas sin bautizar en el rango" % n)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
