#!/usr/bin/env python3
"""Que la web no diga cosas que el repositorio no sostiene.

Las cifras de la portada y de los documentos se escriben a mano. Este fichero
las ata a lo que miden las herramientas, para que no se queden atras cuando el
listado cambie.
"""
import os
import re
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
DOCS = os.path.join(RAIZ, "docs")
ASM = os.path.join(RAIZ, "src", "holeinonepro.asm")


def paginas():
    for carpeta in (DOCS, os.path.join(DOCS, "es")):
        for f in sorted(os.listdir(carpeta)):
            if f.endswith(".md"):
                ruta = os.path.join(carpeta, f)
                with open(ruta, encoding="utf-8") as fh:
                    yield ruta, fh.read()


def herramienta(*args):
    return subprocess.run([sys.executable] + list(args), cwd=RAIZ,
                          capture_output=True, text=True).stdout


class TestCifras(unittest.TestCase):

    def test_la_densidad_publicada_es_la_medida(self):
        salida = herramienta(os.path.join("tools", "densidad.py"), ASM)
        m = re.search(r"(\d+) instrucciones, (\d+) comentarios, ([\d.]+) %", salida)
        self.assertIsNotNone(m, "densidad.py no ha dicho lo de siempre")
        instr, coment, dens = int(m.group(1)), int(m.group(2)), m.group(3)
        for ruta, texto in paginas():
            if "44,4" in texto or "44.4" in texto:
                self.assertEqual(dens, "44.4",
                                 "%s publica 44,4 %% y se mide %s" % (ruta, dens))
        # y las dos cuentas que se citan en EL-CODIGO / THE-CODE
        for ruta, texto in paginas():
            if os.path.basename(ruta) not in ("EL-CODIGO.md", "THE-CODE.md"):
                continue
            self.assertIn(f"{instr:,}".replace(",", "." if "/es/" in
                          ruta.replace("\\", "/") else ","), texto,
                          "%s no publica las %d instrucciones" % (ruta, instr))
            self.assertIn(f"{coment:,}".replace(",", "." if "/es/" in
                          ruta.replace("\\", "/") else ","), texto,
                          "%s no publica los %d comentarios" % (ruta, coment))

    def test_no_queda_ninguna_rutina_floja(self):
        salida = herramienta(os.path.join("tools", "densidad.py"), ASM)
        m = re.search(r"(\d+) rutinas por debajo del 10 %", salida)
        self.assertEqual(int(m.group(1)), 0,
                         "la web publica cero rutinas flojas")

    def test_el_presupuesto_publicado_es_el_medido(self):
        salida = herramienta(os.path.join("tools", "presupuesto.py"), "work", "src")
        m = re.search(r"codigo trazado\s+(\d+)", salida)
        n = re.search(r"datos identificados\s+(\d+)", salida)
        s = re.search(r"sin explicar\s+(\d+)", salida)
        self.assertEqual(int(s.group(1)), 0, "quedan bytes sin explicar")
        cod, dat = int(m.group(1)), int(n.group(1))
        self.assertEqual(cod + dat, 32768)
        for ruta, texto in paginas():
            if os.path.basename(ruta) not in ("EL-CARTUCHO.md", "THE-CARTRIDGE.md",
                                              "EL-CODIGO.md", "THE-CODE.md"):
                continue
            sep = "." if "/es/" in ruta.replace("\\", "/") else ","
            self.assertIn(f"{cod:,}".replace(",", sep), texto,
                          "%s no publica los %d bytes de codigo" % (ruta, cod))
            self.assertIn(f"{dat:,}".replace(",", sep), texto,
                          "%s no publica los %d bytes de datos" % (ruta, dat))


class TestPaginas(unittest.TestCase):

    def test_estan_las_ocho_en_los_dos_idiomas(self):
        en = ["GETTING-STARTED", "THE-GAME", "THE-CARTRIDGE", "THE-CODE",
              "FINDINGS", "THE-EDITOR", "IN-THE-EMULATOR", "OPEN-QUESTIONS"]
        es = ["EMPEZAR", "EL-JUEGO", "EL-CARTUCHO", "EL-CODIGO",
              "HALLAZGOS", "EL-EDITOR", "EN-EL-EMULADOR", "PREGUNTAS-ABIERTAS"]
        for n in en:
            self.assertTrue(os.path.exists(os.path.join(DOCS, n + ".md")), n)
        for n in es:
            self.assertTrue(os.path.exists(os.path.join(DOCS, "es", n + ".md")), n)

    def test_no_hablan_de_otro_juego(self):
        """El fallo clasico de la serie: copiar la web del proyecto anterior y
        dejarse el nombre del juego de antes."""
        otros = ["Hyper Rally", "Time Pilot", "Nemesis", "Goonies", "Twin Bee",
                 "Ping Pong", "Road Fighter", "King's Valley", "Knightmare",
                 "Yie Ar", "Athletic Land", "Antarctic", "Stardust"]
        for ruta, texto in paginas():
            for otro in otros:
                self.assertNotIn(otro, texto, "%s nombra %s" % (ruta, otro))

    def test_las_imagenes_que_se_citan_existen(self):
        img = os.path.join(DOCS, "imagenes")
        sys.path.insert(0, os.path.join(RAIZ, "tools"))
        import make_web as W
        for fich, _, _ in W.GALERIA:
            self.assertTrue(os.path.exists(os.path.join(img, fich)),
                            "falta la imagen %s que la portada cita" % fich)

    def test_los_ficheros_que_se_citan_existen(self):
        """Otro clasico: nombrar en la web un fichero que no esta en el repo."""
        patron = re.compile(r"`(tools/[A-Za-z0-9_]+\.(?:py|tcl|sh)|"
                            r"src/[A-Za-z0-9_]+\.[a-z]+)`")
        for ruta, texto in paginas():
            for nombre in set(patron.findall(texto)):
                self.assertTrue(os.path.exists(os.path.join(RAIZ, nombre)),
                                "%s nombra %s y no existe" % (ruta, nombre))


if __name__ == "__main__":
    unittest.main()
