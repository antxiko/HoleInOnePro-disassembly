#!/usr/bin/env python3
"""Lo que se afirma de las imagenes, atado al binario y a la VRAM del emulador.

La regla de la serie es que ningun dibujo vale por "verse bien". Aqui se
comprueban las tres cosas que sostienen las imagenes:

  1. que los descompresores dan EXACTAMENTE los tamanos que dice el codigo, y
     que los once bloques encajan uno detras de otro sin un byte suelto;
  2. que los textos comprimidos dicen lo que la web dice que dicen;
  3. que la VRAM montada en Python coincide byte a byte con la del emulador,
     si hay un volcado a mano.
"""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import graficos as G                                            # noqa: E402
import textos as T                                              # noqa: E402

ROM = os.path.join(RAIZ, "holeinonepro.rom")
ORG = 0x4000
OMSX = os.path.join(RAIZ, "work", "omsx")
OMSX_MENU = os.path.join(RAIZ, "work", "omsx-menu")


def rom():
    with open(ROM, "rb") as f:
        return f.read()


class TestDescompresores(unittest.TestCase):
    """Los once bloques comprimidos, medidos descomprimiendolos de verdad."""

    # (fuente, destino, tope, modo, fuente_final)
    BLOQUES = [
        (0x6898, 0x3800, 0x3AE0, "a", 0x69B3),
        (0x9F85, 0x0000, 0x0800, "a", 0xA5E6),
        (0xA5E6, 0x2000, 0x2800, "c", 0xA7D2),
        (0xA7D2, 0x1168, 0x1300, "a", 0xA90C),
        (0xA90C, 0x3168, 0x3300, "c", 0xAA0E),
        (0xAA0E, 0x0698, 0x0800, "a", 0xAAFD),
        (0xAAFD, 0x2698, 0x2800, "c", 0xABA1),
        (0xABA1, 0x1800, 0x1B00, "a", 0xACFB),
        (0xACFB, 0x1C00, 0x1F00, "a", 0xAE44),
        (0xAE44, 0x3C00, 0x3CA0, "a", 0xAE90),
        (0xAE90, 0x3CA0, 0x3CC0, "a", 0xAE9B),
        (0xAE9B, 0x3EE0, 0x3F00, "a", 0xAEA3),
    ]

    def test_cada_bloque_acaba_donde_empieza_el_siguiente(self):
        """La prueba de que el formato esta entendido: si un descompresor
        parase un byte antes o despues, la cadena se rompia."""
        d = rom()
        for fuente, destino, tope, modo, fin in self.BLOQUES:
            v = bytearray(0x4000)
            fn = G.parejas if modo == "c" else G.rachas
            sale = fn(d, ORG, fuente, destino, tope, v)
            self.assertEqual(
                sale, fin,
                "0x%04X deberia acabar en 0x%04X y acaba en 0x%04X"
                % (fuente, fin, sale))

    def test_la_cadena_de_graficos_no_deja_un_byte_suelto(self):
        """De 0x9F85 a 0xAEA3 los bloques van pegados."""
        d = rom()
        cadena = [b for b in self.BLOQUES if b[0] >= 0x9F85]
        cadena.sort()
        for (f1, _, _, _, fin1), (f2, _, _, _, _) in zip(cadena, cadena[1:]):
            self.assertEqual(fin1, f2,
                             "entre 0x%04X y 0x%04X hay un hueco" % (f1, f2))


class TestTextos(unittest.TestCase):
    """Los textos comprimidos, expandidos con el interprete de 0x6822."""

    def expande(self, ini, filas, ancho):
        return T.expande(rom(), ORG, ini, filas, ancho)[0]

    def test_los_creditos(self):
        self.assertEqual(self.expande(0x51E5, 4, 21), [
            "@ HAL LABORATORY 1985",
            "                     ",
            "PRODUCER   F>NAKAMURA",
            "PROGRAMMER S>IWATA   ",
        ])

    def test_el_menu(self):
        self.assertEqual(self.expande(0x5224, 4, 21), [
            " PLAYER>>1           ",
            " LEVEL >>AVERAGE     ",
            " GAME  >>STROKE PLAY ",
            " COURSE>>QUEEN SIDE  ",
        ])

    def test_los_diez_rotulos_de_opcion(self):
        esperado = {
            0x5238: "AVERAGE     ", 0x526E: "EXPERT      ",
            0x527A: "PROFESSIONAL", 0x524D: "STROKE PLAY ",
            0x529E: "MATCH PLAY  ", 0x52AA: "TOURNAMENT  ",
            0x52B6: "CONSTRUCTION", 0x5262: "QUEEN SIDE  ",
            0x5286: "KING SIDE   ", 0x5292: "USER        ",
        }
        for d, texto in esperado.items():
            self.assertEqual(self.expande(d, 1, 12)[0], texto,
                             "el rotulo de 0x%04X" % d)

    def test_el_panel_de_la_izquierda(self):
        filas = self.expande(0x69B3, 24, 10)
        self.assertEqual(filas[1][0:5], "*TOP ")
        self.assertEqual(filas[5][0:7], "* SHOTS")
        self.assertEqual(filas[9][0:5], "*HOLE")
        self.assertEqual(filas[11][0:6], "* PAR ")
        self.assertEqual(filas[18][:7], "  POWER")
        self.assertEqual(filas[20][:7], "  CURVE")
        self.assertEqual(filas[23][:5], " CLUB")


class TestGolfistas(unittest.TestCase):
    """Los treinta y cinco nombres de 0x5009, con el bit 7 de terminador."""

    def leelos(self):
        d = rom()
        nombres, cur, a = [], "", 0x5009
        while a < 0x5130:
            v = d[a - ORG]
            cur += chr(v & 0x7F)
            if v & 0x80:
                nombres.append(cur)
                cur = ""
            a += 1
        return nombres

    def test_son_treinta_y_cinco_y_acaban_justo_en_0x5130(self):
        n = self.leelos()
        self.assertEqual(len(n), 35)
        self.assertEqual(sum(len(x) for x in n), 0x5130 - 0x5009)

    def test_los_que_se_citan_en_la_web(self):
        n = self.leelos()
        for quien in ("J>NICKLAUS", "S>BALLESTEROS", "L>TREVINO", "T>WATSON",
                      "G>NORMAN", "I>AOKI", "T>OZAKI", "N>OZAKI"):
            self.assertIn(quien, n)

    def test_cada_uno_tiene_su_ajuste(self):
        """0x5130 es un byte por golfista, de 0 a 7, y acaba donde empieza la
        tabla de punteros de probabilidad."""
        d = rom()
        ajustes = [d[0x5130 - ORG + i] for i in range(35)]
        self.assertEqual(len(ajustes), 0x5153 - 0x5130)
        self.assertTrue(all(0 <= x <= 7 for x in ajustes))


class TestVram(unittest.TestCase):
    """Contra la VRAM de verdad, si hay un volcado del emulador."""

    def test_la_vram_montada_es_la_del_emulador(self):
        if not os.path.isdir(OMSX) or not [f for f in os.listdir(OMSX)
                                           if f.endswith(".bin")]:
            self.skipTest("no hay volcado de VRAM en work/omsx; se genera con "
                          "tools/omsx_vram.tcl")
        d = rom()
        v = G.monta_vram(d, ORG)
        mejor = None
        for nombre in sorted(f for f in os.listdir(OMSX) if f.endswith(".bin")):
            with open(os.path.join(OMSX, nombre), "rb") as f:
                real = f.read()
            fallos = sum(1 for _, a, b in G.ZONAS
                         for i in range(a, b) if v[i] != real[i])
            if mejor is None or fallos < mejor[1]:
                mejor = (nombre, fallos)
        self.assertEqual(mejor[1], 0,
                         "%d bytes distintos contra %s" % (mejor[1], mejor[0]))


class TestPantallaDeTitulo(unittest.TestCase):
    """El rotulo: la pantalla de titulo entera contra la del emulador."""

    def test_el_rotulo_son_los_tiles_de_0xaa0e(self):
        """416 de las 768 casillas de la pantalla de titulo usan tiles de 0xD3
        en adelante, que son justo los 45 que cubre el bloque de 0xAA0E."""
        d = rom()
        v = bytearray(0x4000)
        G.rachas(d, ORG, 0xABA1, 0x1800, 0x1B00, v)
        altos = sum(1 for i in range(768) if v[0x1800 + i] >= 0xD3)
        self.assertEqual(altos, 416)
        distintos = len({v[0x1800 + i] for i in range(768) if v[0x1800 + i] >= 0xD3})
        self.assertEqual(distintos, 45)
        self.assertEqual((0x800 - 0x698) // 8, 45)

    def test_la_pantalla_de_titulo_es_la_del_emulador(self):
        if not os.path.isdir(OMSX_MENU) or not [f for f in os.listdir(OMSX_MENU)
                                                if f.endswith(".bin")]:
            self.skipTest("no hay volcado de la pantalla de titulo en "
                          "work/omsx-menu; se saca con tools/omsx_menu.tcl")
        d = rom()
        mejor = G.comprueba_el_titulo(d, ORG, OMSX_MENU)
        self.assertIsNotNone(mejor)
        self.assertEqual(mejor[1], 0,
                         "%d bytes distintos contra %s" % (mejor[1], mejor[0]))


if __name__ == "__main__":
    unittest.main()
