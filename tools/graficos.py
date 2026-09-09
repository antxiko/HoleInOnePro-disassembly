#!/usr/bin/env python3
"""Dibuja las imagenes de Hole in One Professional desde los bytes del cartucho.

Aqui no hay ni una captura de pantalla ni un retoque: la VRAM se monta en
Python ejecutando las mismas rutinas que corre el Z80.

  - los DOS descompresores: 0x6AFA por rachas y 0x6ABD por parejas
  - el interprete de texto de 0x6822, que escribe el panel
  - el interprete de guiones de hoyo de 0x6F63, con su cabecera-paleta
  - el montador del marcador de 0x49D8

Si alguna de esas rutinas estuviera mal entendida, lo que saldria seria ruido
en vez del campo. Y la prueba no es que las imagenes "se vean bien": la VRAM
montada aqui se puede comparar byte a byte contra la del emulador.

Uso: graficos.py <rom> <org> <carpeta_de_salida>
     graficos.py <rom> <org> comprueba <carpeta_con_vram_NN.bin>
"""
import os
import struct
import sys
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# --------------------------------------------------------------------------
# La paleta del TMS9918. El color 0 es transparente.
# --------------------------------------------------------------------------
PALETA = [
    (0, 0, 0), (0, 0, 0), (62, 184, 73), (116, 208, 125),
    (89, 85, 224), (128, 118, 241), (185, 94, 81), (101, 219, 239),
    (219, 101, 89), (255, 137, 125), (204, 195, 94), (222, 208, 135),
    (58, 162, 65), (183, 102, 181), (204, 204, 204), (255, 255, 255),
]

FONDO = (0x20, 0x20, 0x30)

# Las tablas, tal como las deja INIGRP y como confirma el propio codigo:
#   nombres 0x1800 (y 0x1C00 y 0x3C00, que se ven cambiando el registro 2)
#   color 0x2000   patrones 0x0000   atributos de sprite 0x1B00
#   patrones de sprite 0x3800
NOMBRES, NOMBRES2, NOMBRES3 = 0x1800, 0x1C00, 0x3C00
COLOR, SPRITES = 0x2000, 0x3800

TABLA_HOYOS = 0x716B
ANCHO, ALTO = 20, 24                     # la rejilla de un hoyo
COL_MAPA = 11                            # el mapa empieza en la columna once


# --------------------------------------------------------------------------
# Los dos descompresores del cartucho
# --------------------------------------------------------------------------
def rachas(rom, org, fuente, destino, tope, v):
    """0x6AFA: escape 0xA0..0xAF, (n & 0x0F) + 2 copias del byte siguiente."""
    de = fuente - org
    hl = destino
    while hl != tope:
        x = rom[de]
        if x & 0xF0 == 0xA0:
            n = (x & 0x0F) + 2
            de += 1
            b = rom[de]
            de += 1
            for _ in range(n):
                v[hl] = b
                hl = (hl + 1) & 0xFFFF
        else:
            v[hl] = x
            de += 1
            hl = (hl + 1) & 0xFFFF
    return de + org


def parejas(rom, org, fuente, destino, tope, v):
    """0x6ABD: escape 0x00..0x0F, un PAR de bytes que se alternan."""
    de = fuente - org
    hl = destino
    while hl != tope:
        x = rom[de]
        if x & 0xF0 == 0x00:
            c = x & 0x0F
            de += 1
            b = rom[de]
            de += 1
            a1 = rom[de]
            de += 1
            a2 = rom[de]
            de += 1
            while True:
                for _ in range(b if b else 256):
                    v[hl] = a1
                    v[(hl + 1) & 0xFFFF] = a2
                    hl = (hl + 2) & 0xFFFF
                c -= 1
                if c < 0:
                    break
        else:
            v[hl] = x
            de += 1
            hl = (hl + 1) & 0xFFFF
    return de + org


def texto(rom, org, fuente, hl, v, filas, ancho, salto):
    """0x6822: por debajo de 0x20 son rachas, y de ahi para arriba caracteres."""
    de = fuente - org
    for _ in range(filas):
        n = ancho
        while n > 0:
            x = rom[de]
            if x >= 0x20:
                v[hl] = x
                hl += 1
                de += 1
                n -= 1
                continue
            if x < 0x10:
                cuenta, ch = x, 0x20
                de += 1
            else:
                cuenta = x & 0x0F
                de += 1
                ch = rom[de]
                de += 1
            for _ in range(cuenta):
                v[hl] = ch
                hl += 1
            n -= cuenta
        hl += salto
    return de + org


# --------------------------------------------------------------------------
# La VRAM entera, montada como la monta el cartucho
# --------------------------------------------------------------------------
def monta_vram(rom, org):
    v = bytearray(0x4000)
    for base in (0x0000, 0x0800, 0x1000):          # 0x66D4: los tres tercios
        rachas(rom, org, 0x9F85, base, base + 0x800, v)
    for base in (0x2000, 0x2800, 0x3000):
        parejas(rom, org, 0xA5E6, base, base + 0x800, v)
    rachas(rom, org, 0x6898, SPRITES, 0x3AE0, v)   # 0x6649
    # 0x67D7 BORRA la tabla de nombres de 0x1800 con FILVRM antes de nada: en
    # juego solo se escriben el panel (columnas 1 a 10) y el mapa (11 a 30), y
    # las columnas 0 y 31 se quedan a cero. El fondo decorativo de 0xABA1 NO
    # entra aqui: lo pinta 0x66C6, y a esa solo la llama 0x51CB, o sea la
    # pantalla de creditos y de menu.
    rachas(rom, org, 0xACFB, NOMBRES2, 0x1F00, v)  # 0x6734
    hl = rachas(rom, org, 0xAE44, NOMBRES3, 0x3CA0, v)
    hl = 0x3CA0
    for _ in range(18):                            # 0x674E: dieciocho renglones
        rachas(rom, org, 0xAE90, hl, hl + 0x20, v)
        hl += 0x20
    rachas(rom, org, 0xAE9B, hl, 0x3F00, v)
    return v


def fondo_del_menu(rom, org, v):
    """0x66C6: el fondo decorativo, en la tabla de nombres de 0x1800. Solo se
    usa en la pantalla de creditos y en la de menu."""
    rachas(rom, org, 0xABA1, NOMBRES, 0x1B00, v)


def escribe_el_panel(rom, org, v):
    """0x67EF: veinticuatro filas de diez caracteres desde 0x1801. Solo se
    escribe al empezar la vuelta; en el menu y los creditos NO esta."""
    texto(rom, org, 0x69B3, 0x1801, v, 24, 10, 22)


def vram_del_green(rom, org, v):
    """0x9DDD: los patrones y colores de la vista corta."""
    rachas(rom, org, 0xA7D2, 0x1168, 0x1300, v)
    parejas(rom, org, 0xA90C, 0x3168, 0x3300, v)


# --------------------------------------------------------------------------
# El interprete de guiones de hoyo (0x6F63) y la bandera (0x7005)
# --------------------------------------------------------------------------
def hoyo(rom, org, indice, tabla=TABLA_HOYOS, directo=None):
    p = directo if directo else (rom[tabla - org + indice * 2] | (rom[tabla - org + indice * 2 + 1] << 8))
    cab = [rom[p - org], rom[p - org + 1], rom[p - org + 2]]
    hl = p + 3
    rej = bytearray()
    par = tee = bandera = None
    while len(rej) < ANCHO * ALTO:
        x = rom[hl - org]
        if x == 0x21:
            break
        if 0x30 <= x < 0x60:
            rej.extend([cab[(x >> 4) - 3]] * ((x & 0x0F) + 1))
        else:
            if x == 0xE9:
                bandera = len(rej)
            if x in (0xD9, 0xDD, 0xE3):
                par = {0xD9: 3, 0xDD: 4, 0xE3: 5}[x]
                tee = len(rej)
            rej.append(x)
        hl += 1
    metros = "".join(chr(rom[hl - org + 1 + i]) for i in range(3))
    return dict(rejilla=rej, par=par, tee=tee, bandera=bandera,
                metros=int(metros) if metros.isdigit() else None,
                ptr=p, bytes=hl + 4 - p)


def pon_el_hoyo(v, rej):
    """Vuelca la rejilla de 20x24 en la tabla de nombres, como 0x713F."""
    for f in range(ALTO):
        for c in range(ANCHO):
            v[NOMBRES + f * 32 + COL_MAPA + c] = rej[f * ANCHO + c]


def numera_el_marcador(rom, org, v):
    """0x49D8: los dieciocho numeros de hoyo y sus pares, en la tabla de 0x1C00."""
    for i in range(18):
        h = hoyo(rom, org, i)
        d = rom[0x4A18 - org + i * 2] | (rom[0x4A18 - org + i * 2 + 1] << 8)
        n = i + 1
        v[d] = 0x30 + n // 10 if n >= 10 else 0x20
        v[d + 1] = 0x30 + n % 10
        v[d + 2] = 0x3A
        v[d + 3] = 0x30 + (h["par"] or 0)


# --------------------------------------------------------------------------
# Dibujo
# --------------------------------------------------------------------------
def png(w, h, px, fn):
    filas = b"".join(b"\x00" + bytes(px[y * w * 3:(y + 1) * w * 3]) for y in range(h))

    def trozo(t, d):
        return (struct.pack(">I", len(d)) + t + d
                + struct.pack(">I", zlib.crc32(t + d) & 0xFFFFFFFF))

    with open(fn, "wb") as f:
        f.write(b"\x89PNG\r\n\x1a\n")
        f.write(trozo(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0)))
        f.write(trozo(b"IDAT", zlib.compress(filas, 9)))
        f.write(trozo(b"IEND", b""))


def lienzo(w, h, color=FONDO):
    px = bytearray(w * h * 3)
    for i in range(w * h):
        px[i * 3:i * 3 + 3] = bytes(color)
    return px


def celda(v, px, W, cx, cy, tercio, tile, esc):
    """Pinta una casilla de 8x8 con su patron y su color."""
    pat = tercio * 0x800 + tile * 8
    col = COLOR + tercio * 0x800 + tile * 8
    for y in range(8):
        b = v[pat + y]
        c = v[col + y]
        tinta, fondo = PALETA[c >> 4], PALETA[c & 15]
        for x in range(8):
            r, g, bl = tinta if b & (0x80 >> x) else fondo
            for dy in range(esc):
                for dx in range(esc):
                    o = ((cy + y * esc + dy) * W + cx + x * esc + dx) * 3
                    px[o], px[o + 1], px[o + 2] = r, g, bl


def pantalla(v, fn, base=NOMBRES, esc=2, fila0=0, filas=24, col0=0, cols=32):
    W, H = cols * 8 * esc, filas * 8 * esc
    px = lienzo(W, H, PALETA[1])
    for f in range(filas):
        for c in range(cols):
            fila = fila0 + f
            celda(v, px, W, c * 8 * esc, f * 8 * esc, fila // 8,
                  v[base + fila * 32 + col0 + c], esc)
    png(W, H, px, fn)


def hoja(v, fn, primero, ultimo, cols=16, esc=3, margen=1, tercio=0):
    n = ultimo - primero
    filas = (n + cols - 1) // cols
    W = cols * (8 * esc + margen) + margen
    H = filas * (8 * esc + margen) + margen
    px = lienzo(W, H)
    for i in range(n):
        cx = margen + (i % cols) * (8 * esc + margen)
        cy = margen + (i // cols) * (8 * esc + margen)
        celda(v, px, W, cx, cy, tercio, primero + i, esc)
    png(W, H, px, fn)


def hoja_de_sprites(v, fn, n=23, cols=8, esc=3, margen=3):
    filas = (n + cols - 1) // cols
    W = cols * (16 * esc + margen) + margen
    H = filas * (16 * esc + margen) + margen
    px = lienzo(W, H)
    for i in range(n):
        cx = margen + (i % cols) * (16 * esc + margen)
        cy = margen + (i // cols) * (16 * esc + margen)
        base = SPRITES + i * 32
        for mitad in range(2):
            for y in range(16):
                b = v[base + mitad * 16 + y]
                for x in range(8):
                    if not b & (0x80 >> x):
                        continue
                    for dy in range(esc):
                        for dx in range(esc):
                            o = ((cy + y * esc + dy) * W
                                 + cx + (mitad * 8 + x) * esc + dx) * 3
                            px[o], px[o + 1], px[o + 2] = PALETA[15]
    png(W, H, px, fn)


def cuatro_filas(rom, org, fuente, v):
    """0x51BF: cuatro filas de veintiun caracteres desde 0x1A46."""
    texto(rom, org, fuente, 0x1A46, v, 4, 21, 11)


def rotulos_del_menu(rom, org, v):
    """0x52DE: el cursor y los cuatro rotulos elegidos, con los valores de
    fabrica: PLAYER 1, AVERAGE, STROKE PLAY y QUEEN SIDE."""
    v[0x1A46] = 0x2F                                   # la flecha del cursor
    for fila, fuente in ((0x1A6F, 0x5238), (0x1A8F, 0x524D), (0x1AAF, 0x5262)):
        texto(rom, org, fuente, fila, v, 1, 12, 0)


def rotulo(rom, org, v, fn, esc=4):
    """El nombre del juego, con la fuente y el marco del propio cartucho.

    Este cartucho NO tiene rotulo de titulo: su portada son los creditos y el
    menu. Asi que el rotulo se monta con sus propias piezas: el recuadro del
    panel -0x27, 0x28 y 0x29 arriba, 0x2A y 0x2B a los lados, 0x24, 0x25 y 0x26
    abajo- y las letras de su fuente, que son ASCII. Y el texto tampoco se
    inventa: HOLE IN ONE es el mensaje de 0x4C0B, el que sale al meterla de un
    golpe, y PROFESSIONAL es el rotulo de nivel de 0x527A.
    """
    filas = [
        [0x27] + [0x28] * 12 + [0x29],
        [0x2A] + list(b" HOLE IN ONE") + [0x2B],
        [0x2A] + list(b"PROFESSIONAL") + [0x2B],
        [0x24] + [0x25] * 12 + [0x26],
    ]
    w = bytearray(v)
    for f, fila in enumerate(filas):
        for c, t in enumerate(fila):
            w[NOMBRES + (f + 1) * 32 + c + 1] = t
    pantalla(w, fn, esc=esc, fila0=1, filas=4, col0=1, cols=14)


def recorta(v, fn, fila0, filas, col0, cols, esc=3, base=NOMBRES):
    pantalla(v, fn, base=base, esc=esc, fila0=fila0, filas=filas,
             col0=col0, cols=cols)


def borra_el_hueco_del_panel(v):
    """0x9E20: siete filas de nueve casillas desde 0x1A21, a espacios."""
    for f in range(7):
        for c in range(9):
            v[0x1A21 + f * 32 + c] = 0x20


def pon_el_hoyo_del_green(rom, org, v, sitio=4):
    """0x715F: el hoyo del green, en la casilla que dice la tabla de 0x7128."""
    col = rom[0x7128 - org + sitio]
    fil = rom[0x7131 - org + sitio]
    v[NOMBRES + fil * 32 + col] = 0xD6


def hoja_del_swing(rom, org, v, fn, esc=3, margen=4):
    """Los siete dibujos del golfista, uno al lado del otro."""
    cw, ch = 4 * 8 * esc, 5 * 8 * esc
    W = 7 * (cw + margen) + margen
    H = ch + 2 * margen
    px = lienzo(W, H)
    for i in range(7):
        hl = 0x9F21 + i
        de = hl + rom[hl - org]
        ox = margen + i * (cw + margen)
        for f in range(5):
            m = rom[de - org]
            de += 1
            for c in range(4):
                if m & 1:
                    tile = 0x94
                else:
                    tile = rom[de - org]
                    de += 1
                m >>= 1
                celda(v, px, W, ox + c * 8 * esc, margen + f * 8 * esc, 2, tile, esc)
    png(W, H, px, fn)


def golfistas(rom, org, v, fn, desde=0, esc=2):
    """Los treinta y cinco nombres, escritos con la fuente del cartucho en su
    propia pantalla de clasificacion. El orden es el de la tabla de 0x5009, no
    el de una partida: la clasificacion de verdad se baraja al empezar."""
    w = bytearray(v)
    de = 0x5009
    for _ in range(desde):                       # se saltan los ya escritos
        while not rom[de - org] & 0x80:
            de += 1
        de += 1
    for i in range(min(18, 35 - desde)):
        hl = 0x3CA3 + i * 0x20
        n = desde + i + 1
        w[hl - 2] = 0x30 + n // 10 if n >= 10 else 0x20
        w[hl - 1] = 0x30 + n % 10
        for k in range(14):
            x = rom[de - org]
            w[hl + 2 + k] = x & 0x7F
            de += 1
            if x & 0x80:
                for j in range(k + 1, 14):
                    w[hl + 2 + j] = 0x20
                break
    pantalla(w, fn, base=NOMBRES3, esc=esc)


def dibujo_del_swing(rom, org, v, indice, fn, esc=4):
    """0x9EF4: cinco filas de cuatro casillas, con una mascara por fila."""
    hl = 0x9F21 + indice
    de = hl + rom[hl - org]
    W, H = 4 * 8 * esc, 5 * 8 * esc
    px = lienzo(W, H, PALETA[1])
    for f in range(5):
        m = rom[de - org]
        de += 1
        for c in range(4):
            if m & 1:
                tile = 0x94
            else:
                tile = rom[de - org]
                de += 1
            m >>= 1
            celda(v, px, W, c * 8 * esc, f * 8 * esc, 2, tile, esc)
    png(W, H, px, fn)


def mosaico(rom, org, v, fn, campo, esc=1, cols=6, margen=6):
    """Los dieciocho hoyos de un campo, en una sola lamina."""
    cw, ch = ANCHO * 8 * esc, ALTO * 8 * esc
    filas = (18 + cols - 1) // cols
    W = cols * (cw + margen) + margen
    H = filas * (ch + margen) + margen
    px = lienzo(W, H)
    for i in range(18):
        h = hoyo(rom, org, campo * 18 + i)
        ox = margen + (i % cols) * (cw + margen)
        oy = margen + (i // cols) * (ch + margen)
        for f in range(ALTO):
            for c in range(ANCHO):
                celda(v, px, W, ox + c * 8 * esc, oy + f * 8 * esc,
                      f // 8, h["rejilla"][f * ANCHO + c], esc)
    png(W, H, px, fn)


# --------------------------------------------------------------------------
# La comprobacion que de verdad decide: contra la VRAM del emulador
# --------------------------------------------------------------------------
# Lo que se compara son las zonas que salen de los descompresores y del
# interprete de texto, o sea lo que este guion afirma saber montar. Lo que el
# juego escribe en marcha -el mapa del hoyo sobre las columnas 11 a 30, los
# numeros del marcador y los sprites- no sale de ninguna tabla y no se compara.
ZONAS = [
    ("patrones tercio 0", 0x0000, 0x0800),
    ("patrones tercio 1", 0x0800, 0x1000),
    ("patrones tercio 2", 0x1000, 0x1800),
    ("color tercio 0", 0x2000, 0x2800),
    ("color tercio 1", 0x2800, 0x3000),
    ("color tercio 2", 0x3000, 0x3800),
    ("patrones de sprite", 0x3800, 0x3AE0),
    ("tabla de nombres 3 (clasificacion)", 0x3C00, 0x3F00),
    ("tabla de nombres 2 (marcador)", 0x1C00, 0x1F00),
]


def comprueba(rom, org, carpeta):
    v = monta_vram(rom, org)
    # El volcado es de una vuelta en marcha, con el hoyo 1 de QUEEN SIDE en
    # pantalla: se monta lo mismo para poder comparar la pantalla ENTERA.
    escribe_el_panel(rom, org, v)
    pon_el_hoyo(v, hoyo(rom, org, 0)["rejilla"])
    volcados = sorted(f for f in os.listdir(carpeta) if f.endswith(".bin"))
    if not volcados:
        print("no hay volcados de VRAM en %s" % carpeta)
        return 1
    peor = None
    for nombre in volcados:
        real = open(os.path.join(carpeta, nombre), "rb").read()
        total = fallos = 0
        detalle = []
        for etiqueta, a, b in ZONAS:
            n = sum(1 for i in range(a, b) if v[i] != real[i])
            total += b - a
            fallos += n
            detalle.append((etiqueta, n, b - a))
        # La tabla de nombres de 0x1800 ENTERA -panel, mapa del hoyo y las dos
        # columnas de los bordes-, menos las seis columnas del panel donde el
        # juego escribe cifras en marcha, que son la 3 a la 8.
        n = p = vn = vp = 0
        for f in range(24):
            for c in range(32):
                distinta = v[NOMBRES + f * 32 + c] != real[NOMBRES + f * 32 + c]
                if 3 <= c <= 8:
                    vp += 1
                    vn += distinta
                else:
                    p += 1
                    n += distinta
        detalle.append(("tabla de nombres 1 (panel y hoyo 1)", n, p))
        total += p
        fallos += n
        vivos = (vn, vp)
        if peor is None or fallos < peor[1]:
            peor = (nombre, fallos, total, detalle, vivos)
    nombre, fallos, total, detalle, vivos = peor
    print("mejor coincidencia: %s" % nombre)
    for etiqueta, n, t in detalle:
        print("  %-38s %5d de %5d distintos" % (etiqueta, n, t))
    print("  ---- LO ESTATICO: %d bytes distintos de %d" % (fallos, total))
    print("  ---- las seis columnas de cifras del panel (3 a 8) tienen %d"
          " distintas de %d," % vivos)
    print("       y son lo que el juego escribe en marcha: el TOP, los golpes de"
          " los dos")
    print("       jugadores, el numero de hoyo, la distancia, el par, el viento"
          " y el desnivel.")
    return 0 if fallos == 0 else 1


def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    rom = open(argv[1], "rb").read()
    org = int(argv[2], 0)
    if argv[3] == "comprueba":
        return comprueba(rom, org, argv[4])
    sal = argv[3]
    os.makedirs(sal, exist_ok=True)

    v = monta_vram(rom, org)

    c = bytearray(v)
    fondo_del_menu(rom, org, c)
    cuatro_filas(rom, org, 0x51E5, c)
    pantalla(c, os.path.join(sal, "creditos.png"))
    m = bytearray(v)
    fondo_del_menu(rom, org, m)
    cuatro_filas(rom, org, 0x5224, m)
    rotulos_del_menu(rom, org, m)
    pantalla(m, os.path.join(sal, "menu.png"))
    recorta(m, os.path.join(sal, "opciones.png"), 18, 4, 5, 22)

    escribe_el_panel(rom, org, v)                 # de aqui en adelante, en juego
    numera_el_marcador(rom, org, v)
    pantalla(v, os.path.join(sal, "marcador.png"), base=NOMBRES2)
    pantalla(v, os.path.join(sal, "clasificacion.png"), base=NOMBRES3)
    hoja(v, os.path.join(sal, "patrones.png"), 0, 256)
    hoja_de_sprites(v, os.path.join(sal, "sprites.png"))
    n = bytearray(v)
    numera_el_marcador(rom, org, n)
    recorta(n, os.path.join(sal, "hal_country_club.png"), 0, 2, 1, 30,
            base=NOMBRES2)
    rotulo(rom, org, v, os.path.join(sal, "rotulo.png"))
    golfistas(rom, org, v, os.path.join(sal, "golfistas_1.png"), 0)
    golfistas(rom, org, v, os.path.join(sal, "golfistas_2.png"), 18)

    # el hoyo 1 de cada campo, en la pantalla entera del juego
    for campo, nom in ((0, "queen"), (1, "king")):
        w = bytearray(v)
        pon_el_hoyo(w, hoyo(rom, org, campo * 18)["rejilla"])
        pantalla(w, os.path.join(sal, "hoyo_1_%s.png" % nom))
        mosaico(rom, org, v, os.path.join(sal, "campo_%s.png" % nom), campo)

    g = bytearray(v)
    vram_del_green(rom, org, g)
    borra_el_hueco_del_panel(g)
    pon_el_hoyo(g, hoyo(rom, org, 0, directo=0x9D6C)["rejilla"])
    pon_el_hoyo_del_green(rom, org, g)
    pantalla(g, os.path.join(sal, "green.png"))
    hoja_del_swing(rom, org, g, os.path.join(sal, "swing.png"))

    print("imagenes en %s" % sal)
    for f in sorted(os.listdir(sal)):
        print("  %s" % f)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
