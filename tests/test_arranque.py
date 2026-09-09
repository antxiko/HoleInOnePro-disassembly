#!/usr/bin/env python3
"""Lo medido en el primer tramo del desensamblado, atado al binario.

Todo lo que se afirma aqui se lee de los bytes de la ROM, no del listado: si
manana el listado cambia, estas comprobaciones siguen diciendo la verdad.
"""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import campos as C                                              # noqa: E402

ROM = os.path.join(RAIZ, "holeinonepro.rom")
SHA = "99900247abc5cff8f12fed900e4ebf783c7a7ecf8d689b4a5cccd85a8416451e"


def rom():
    with open(ROM, "rb") as f:
        return C.Rom(f.read(), C.ORG)


class TestArranque(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(
                "falta holeinonepro.rom en la raiz. No se distribuye aqui: "
                "pon tu copia, 32768 bytes, sha256 " + SHA)
        cls.r = rom()

    def test_es_el_cartucho_que_se_documento(self):
        import hashlib
        with open(ROM, "rb") as f:
            d = f.read()
        self.assertEqual(len(d), 32768)
        self.assertEqual(hashlib.sha256(d).hexdigest(), SHA)

    # ------------------------------------------------------------------
    # La cabecera
    # ------------------------------------------------------------------
    def test_la_cabecera_declara_INIT_y_NADA_MAS(self):
        """Y esto es lo que separa a este cartucho del Hole in One de 1984:
        alli STATEMENT valia 0x8010 y registraba el comando CALL GOLF. Aqui
        vale CERO, asi que no hay comando BASIC ni carga de campos de cinta."""
        r = self.r
        self.assertEqual(r.b(0x4000), ord("A"))
        self.assertEqual(r.b(0x4001), ord("B"))
        self.assertEqual(r.w(0x4002), 0x4010, "INIT")
        self.assertEqual(r.w(0x4004), 0x0000, "STATEMENT tiene que ser CERO")
        self.assertEqual(r.w(0x4006), 0x0000, "DEVICE")
        self.assertEqual(r.w(0x4008), 0x0000, "TEXT")

    def test_la_interrupcion_se_engancha_entre_slots(self):
        """L_6603 no mete un JP en H.TIMI: mete un RST 30h (CALSLT), el slot y
        la direccion. Por eso el manejador de verdad esta en 0x665B y el
        trazado estatico no llega solo."""
        r = self.r
        self.assertEqual(r.b(0x6603), 0xF3)                 # di
        self.assertEqual((r.b(0x6604), r.b(0x6605)), (0x3E, 0xF7))   # ld a,0F7h
        self.assertEqual(r.b(0x6606), 0x32)                 # ld (nn),a
        self.assertEqual(r.w(0x6607), 0xFD9F, "H.TIMI")
        self.assertEqual(r.b(0x660F), 0x21)                 # ld hl,nn
        self.assertEqual(r.w(0x6610), 0x665B, "el manejador")
        self.assertEqual(r.w(0x6613), 0xFDA1)

    # ------------------------------------------------------------------
    # La tabla de despacho de los dos jp (hl)
    # ------------------------------------------------------------------
    def test_la_tabla_de_despacho_tiene_diez_entradas(self):
        """Los dos `jp (hl)` de 0xAFAC y 0xAFCE salen de aqui. Donde acaba la
        tabla no se pone a ojo: el puntero once daria 0x0B0C, que esta fuera
        de la ROM."""
        r = self.r
        for i in range(10):
            v = r.w(0xAFAD + i * 2)
            self.assertTrue(0x4000 <= v < 0xC000,
                            "el puntero %d sale de la ROM: 0x%04X" % (i, v))
        self.assertFalse(0x4000 <= r.w(0xAFAD + 10 * 2) < 0xC000,
                         "el puntero once tendria que estar FUERA de la ROM")
        # las tres ultimas entradas apuntan al mismo sitio
        self.assertEqual(r.w(0xAFBB), r.w(0xAFBD))
        self.assertEqual(r.w(0xAFBD), r.w(0xAFBF))

    # ------------------------------------------------------------------
    # Los dos campos
    # ------------------------------------------------------------------
    def test_son_DOS_campos_de_dieciocho_hoyos(self):
        cs = C.todos(self.r)
        self.assertEqual(len(cs), 2)
        for c, campo in enumerate(cs):
            self.assertEqual(len(campo), 18)
            for i, h in enumerate(campo):
                self.assertEqual(len(h["rejilla"]), 480,
                                 "campo %d hoyo %d" % (c + 1, i + 1))
                self.assertIn(h["par"], (3, 4, 5))
                self.assertIsNotNone(h["metros"])
                self.assertIsNotNone(h["bandera"])
                self.assertIsNotNone(h["tee"])

    def test_el_par_y_la_longitud_de_los_dos_campos(self):
        cs = C.todos(self.r)
        medido = [(sum(h["par"] for h in c), sum(h["metros"] for h in c))
                  for c in cs]
        self.assertEqual(medido, [(72, 6166), (72, 6290)])

    def test_los_treinta_y_seis_hoyos_son_distintos(self):
        """El control de que no se esta leyendo dos veces lo mismo."""
        vistos = [bytes(h["rejilla"]) for c in C.todos(self.r) for h in c]
        self.assertEqual(len(set(vistos)), 36)

    def test_la_tabla_acaba_donde_empieza_el_primer_guion(self):
        """36 punteros son 72 bytes: de 0x716B a 0x71B2. Y el primer guion
        tiene que empezar justo detras, en 0x71B3."""
        r = self.r
        self.assertEqual(C.TABLA + 36 * 2, 0x71B3)
        self.assertEqual(r.w(C.TABLA), 0x71B3)

    def test_el_cartucho_lee_los_mismos_tees_que_el_del_84(self):
        """0x70B8 compara el byte del guion contra 0xD9, 0xDD y 0xE3. Leido
        del binario: es lo que demuestra que el formato se mantiene."""
        r = self.r
        self.assertEqual((r.b(0x70BB), r.b(0x70BC)), (0xFE, 0xD9))   # cp 0D9h
        self.assertEqual((r.b(0x70BF), r.b(0x70C0)), (0xFE, 0xDD))   # cp 0DDh
        self.assertEqual((r.b(0x70C3), r.b(0x70C4)), (0xFE, 0xE3))   # cp 0E3h
        # y 0x70D3 resta 0xCB00 y divide por 20: el campo va a 0xCB00 y la
        # rejilla sigue siendo de veinte de ancho
        self.assertEqual(r.b(0x70D3), 0x11)                          # ld de,nn
        self.assertEqual(r.w(0x70D4), 0xCB00)
        self.assertEqual(r.b(0x70D9), 0x11)
        self.assertEqual(r.w(0x70DA), 20)


if __name__ == "__main__":
    unittest.main()
