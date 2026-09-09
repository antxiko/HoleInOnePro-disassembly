#!/usr/bin/env python3
"""Genera la portada de la web de Hole in One Professional, en los dos idiomas.

El diseno es el compartido por la serie (tools/estilo_web.py) y la pagina sale
autocontenida, con las imagenes embebidas como data URI.

Las imagenes NO son ilustraciones: las dibuja tools/graficos.py a partir de los
propios bytes de la ROM, ejecutando en Python los mismos descompresores, el
mismo interprete de texto y el mismo interprete de guiones de hoyo que corre el
Z80. Y estan comprobadas contra la VRAM de openMSX: 13.792 bytes de patrones,
color, sprites y tablas de nombres, sin una sola diferencia. Ninguna se ha
retocado.

Uso: make_web.py <docs/imagenes> <salida.html> <idioma>
"""
import base64
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from estilo_web import ESTILO                                   # noqa: E402

# Las cifras salen de las herramientas del repo, no de escribirlas a ojo:
# 32768 = 14186 + 18582 es lo que imprime tools/presupuesto.py con `make
# sanity`; RUTINAS, INSTR y COMENTARIOS los cuenta tools/densidad.py; y el par,
# los metros y los bytes de los guiones salen de tools/campos.py.
CODIGO = 14186
DATOS = 18582
RUTINAS = 903
INSTR = 7133
COMENTARIOS = 3169
DENSIDAD = 44.4
HOYOS = 36
PAR = 72
METROS_Q = 6166
METROS_K = 6290
GOLFISTAS = 35
VRAM = 13792


def mil(n, idioma):
    return f"{n:,}".replace(",", "." if idioma == "es" else ",")


TXT = {
    "es": dict(
        titulo="Hole in One Professional — desensamblado comentado",
        aviso="<b>Aqu&iacute; no hay ninguna ilustraci&oacute;n ni ninguna "
              "captura de pantalla.</b> Los cr&eacute;ditos, el men&uacute;, "
              "el marcador, los sprites, el swing y <b>los treinta y seis "
              "hoyos</b> est&aacute;n <b>dibujados desde los bytes de la "
              "ROM</b>, ejecutando en Python los mismos descompresores y los "
              "mismos int&eacute;rpretes que corre el Z80. Y no valen por "
              "&laquo;verse bien&raquo;: la VRAM montada as&iacute; se compara "
              "byte a byte contra la de openMSX y coinciden <b>13.792 de "
              "13.792</b>. El listado y las cifras salen del binario y se "
              "reproducen con <code>make</code>.",
        claim="Dos campos de dieciocho hoyos, un editor para hacerte el tuyo y "
              "treinta y cinco profesionales de verdad contra los que jugar, "
              "en 32 KB. Y el rival no calcula el golpe: lo ensaya con la "
              "f&iacute;sica de verdad y lo repite hasta que le sale.",
        ficha=["HAL Laboratory &middot; <b>&copy; HAL 1985</b>",
               "Cartucho de <b>32 KB</b>",
               "MSX1 &middot; <b>p&aacute;ginas 1 y 2</b>",
               "Volcado <b>99900247&hellip;</b>"],
        nav=[("#numbers", "Las cifras"), ("#findings", "Hallazgos"),
             ("#screens", "Lo que dibuja")],
        docnav=[("EMPEZAR.html", "Empezar"), ("EL-JUEGO.html", "El juego"),
                ("EL-CARTUCHO.html", "El cartucho"),
                ("EL-CODIGO.html", "El c\u00f3digo"),
                ("HALLAZGOS.html", "Hallazgos"),
                ("EL-EDITOR.html", "El editor"),
                ("EN-EL-EMULADOR.html", "En el emulador"),
                ("PREGUNTAS-ABIERTAS.html", "Preguntas abiertas")],
        otro=("../", "In English"),
        h_num="El cartucho en cifras", h_find="Lo que apareci&oacute; al desmontarlo",
        h_scr="Lo que el cartucho dibuja",
        cifras=[("100 %", "del binario explicado"),
                ("%.1f %%" % DENSIDAD, "de densidad de comentario"),
                (str(HOYOS), "hoyos en dos campos par %d" % PAR),
                (str(GOLFISTAS), "golfistas reales"),
                (mil(CODIGO, "es"), "bytes de c&oacute;digo"),
                (mil(DATOS, "es"), "bytes de datos"),
                ("0", "bytes sin identificar"),
                ("0", "rutinas sin explicar")],
        nota_scr="Debajo de cada imagen est&aacute; de d&oacute;nde sale y "
                 "qu&eacute; se est&aacute; viendo.",
        pie_leg="Esto es trabajo de documentaci&oacute;n y preservaci&oacute;n: "
                "el c&oacute;digo y los gr&aacute;ficos siguen siendo de sus "
                "autores y de HAL Laboratory, y la imagen del cartucho no se "
                "distribuye.",
    ),
    "en": dict(
        titulo="Hole in One Professional — a commented disassembly",
        aviso="<b>There is not one illustration and not one screen capture "
              "here.</b> The credits, the menu, the scoreboard, the sprites, "
              "the swing and <b>all thirty-six holes</b> are <b>drawn from the "
              "bytes of the ROM</b>, by running in Python the same "
              "decompressors and the same interpreters the Z80 runs. And they "
              "do not count because they &ldquo;look right&rdquo;: the VRAM "
              "built this way is compared byte for byte against openMSX's and "
              "<b>13,792 of 13,792</b> match. The listing and the numbers come "
              "from the binary and are reproducible with <code>make</code>.",
        claim="Two eighteen-hole courses, an editor to build your own and "
              "thirty-five real tour professionals to play against, in 32 KB. "
              "And the opponent does not compute its shot: it rehearses it "
              "with the real physics and retries until it likes the result.",
        ficha=["HAL Laboratory &middot; <b>&copy; HAL 1985</b>",
               "A <b>32 KB</b> cartridge",
               "MSX1 &middot; <b>pages 1 and 2</b>",
               "Dump <b>99900247&hellip;</b>"],
        nav=[("#numbers", "The numbers"), ("#findings", "What turned up"),
             ("#screens", "What it draws")],
        docnav=[("GETTING-STARTED.html", "Getting started"),
                ("THE-GAME.html", "The game"),
                ("THE-CARTRIDGE.html", "The cartridge"),
                ("THE-CODE.html", "The code"),
                ("FINDINGS.html", "Findings"),
                ("THE-EDITOR.html", "The editor"),
                ("IN-THE-EMULATOR.html", "In the emulator"),
                ("OPEN-QUESTIONS.html", "Open questions")],
        otro=("es/", "En castellano"),
        h_num="The cartridge in numbers",
        h_find="What turned up when we took it apart",
        h_scr="What the cartridge draws",
        cifras=[("100%", "of the binary explained"),
                ("%.1f%%" % DENSIDAD, "comment density"),
                (str(HOYOS), "holes across two par-%d courses" % PAR),
                (str(GOLFISTAS), "real tour professionals"),
                (mil(CODIGO, "en"), "bytes of code"),
                (mil(DATOS, "en"), "bytes of data"),
                ("0", "bytes unidentified"),
                ("0", "routines left unexplained")],
        nota_scr="Under each picture is where it comes from and what is on it.",
        pie_leg="This is documentation and preservation work: the code and "
                "artwork still belong to their authors and to HAL Laboratory, "
                "and the cartridge image is not distributed.",
    ),
}

HALLAZGOS = {
    "es": [
        ("El rival no calcula el golpe: lo ENSAYA",
         "<p>Lo que hace el ordenador cuando le toca jugar no es resolver una "
         "ecuaci&oacute;n. 0x5B39 le sortea unos valores de partida &mdash;una "
         "fuerza entre 0x18 y 0x1B, una curva entre 0x19 y 0x20, el "
         "&aacute;ngulo hacia la bandera y un palo sacado de dividir la "
         "distancia por ocho&mdash; y entonces entra en el bucle de 0x5BB4, "
         "que <b>juega el golpe entero con la f&iacute;sica de verdad</b>: la "
         "misma rutina, el mismo viento, el mismo terreno.</p>"
         "<p>Al acabar mira d&oacute;nde ha ca&iacute;do la bola. Si se ha ido "
         "al agua, cambia el palo o la fuerza y <b>lo vuelve a tirar</b>. Si "
         "se ha pasado, recorta. Si ha entrado, se rebaja un punto para no "
         "meterla siempre. Y as&iacute; hasta que le gusta, o hasta que se le "
         "acaban los intentos que le deja (0xC119, que crece si va "
         "perdiendo).</p>"
         "<p>Solo entonces 0x5408 lo repite delante del jugador, moviendo las "
         "barras de fuerza y curva hasta los valores que ya ha decidido. Lo "
         "que se ve no es el golpe: es la reposici&oacute;n del ensayo. "
         "Durante el ensayo, (0xC118) a uno apaga el mando, la espera de "
         "cuadro y el dibujado, as&iacute; que las decenas de golpes que se "
         "juega el rival caben entre dos fotogramas.</p>"),
        ("El terreno se decide por el p&iacute;xel, no por la casilla",
         "<p>0x629C clasifica lo que hay bajo la bola por el n&uacute;mero de "
         "casilla: de 0x60 a 0x77 son &aacute;rboles, de 0x94 a 0xB3 b&uacute;"
         "nker, de 0xB4 a 0xD1 agua. Pero las casillas que est&aacute;n a "
         "caballo entre dos terrenos no se pueden resolver as&iacute;, y para "
         "esas el cartucho <b>lee la VRAM</b>.</p>"
         "<p>0x63B1 saca de la tabla de patrones el <b>bit exacto</b> que hay "
         "bajo la bola, con la m&aacute;scara que le toca de las ocho de "
         "0x63E9. Y 0x63D3 lee de la tabla de <b>color</b> el nibble que le "
         "corresponde a ese p&iacute;xel: el alto si el bit est&aacute; "
         "encendido, el bajo si no. Con eso se separa la calle del rough, el "
         "b&uacute;nker del agua y el talud de lo dem&aacute;s.</p>"
         "<p>O sea que la colisi&oacute;n con el decorado la resuelve el "
         "<b>dibujo</b>, y no una segunda tabla que hubiera que mantener a "
         "juego con &eacute;l.</p>"),
        ("La honra del golf est&aacute; programada",
         "<p>En golf, entre dos jugadores, tira el que est&aacute; m&aacute;s "
         "lejos del hoyo. 0x46FA lo hace: mide las dos distancias con "
         "0x475C&mdash;la diferencia en X y en Y, cada una en valor absoluto y "
         "a la mitad para que quepan, y la ra&iacute;z de la suma de "
         "cuadrados&mdash; y le da el turno al que peor est&aacute;.</p>"
         "<p>Con un detalle: si los dos han llegado al green, adem&aacute;s "
         "pasa a la vista corta. Y si uno de los dos ya ha acabado el hoyo, no "
         "hay nada que decidir.</p>"),
        ("Tres pantallas enteras a la vez en la VRAM",
         "<p>El SCREEN 2 del MSX tiene una tabla de nombres, pero el registro "
         "2 del VDP dice d&oacute;nde est&aacute;. Este cartucho monta "
         "<b>tres</b> y va cambiando ese registro: 0x1800 es la pantalla de "
         "juego, 0x1C00 el marcador de dieciocho hoyos y 0x3C00 la "
         "clasificaci&oacute;n del torneo.</p>"
         "<p>0x678B hace un <code>xor 1</code> sobre la copia en RAM del "
         "registro &mdash;que vale 0x400, justo la distancia entre 0x1800 y "
         "0x1C00&mdash; y 0x67CC un <code>xor 9</code>, que lleva a 0x3C00. "
         "Pulsar F1 o F2 durante la partida no redibuja nada: <b>ense&ntilde;a "
         "otra pantalla que ya estaba montada</b>, y al soltar la tecla se "
         "vuelve a la de antes sin haber perdido un byte.</p>"),
        ("Treinta y cinco profesionales de verdad, y una tirada de dados",
         "<p>En 0x5009 hay treinta y cinco nombres del circuito de mediados de "
         "los ochenta, guardados uno detr&aacute;s de otro sin puntero ni "
         "longitud: el <b>bit 7 del &uacute;ltimo car&aacute;cter</b> marca "
         "d&oacute;nde acaba cada uno. Nicklaus, Ballesteros, Trevino, Watson, "
         "Norman, Aoki, los dos Ozaki, Nakajima, Kuramoto&hellip;</p>"
         "<p>El torneo no los simula golpe a golpe: por cada hoyo, 0x4EC9 "
         "tira un dado, le resta la dificultad propia que a cada uno se le "
         "sorte&oacute; al empezar (0xC09B), le suma su <b>ajuste fijo</b> de "
         "la tabla de 0x5130 &mdash;un byte de 0 a 7 por golfista&mdash; y "
         "mira en qu&eacute; tramo cae. Los tramos dan +2, +1, par, &minus;1 y "
         "&minus;2, y hay <b>tres tablas</b> de tramos: la que se usa depende "
         "de si el jugador va por debajo, en el par o por encima. Contra un "
         "jugador que va bien, el circuito aprieta.</p>"),
        ("Cada hoyo declara sus tres materiales y luego pinta con ellos",
         "<p>Un hoyo entero ocupa unos <b>311 bytes</b> de media, y el truco "
         "est&aacute; en los tres primeros. El cartucho los copia a 0xCEC0 y "
         "ah&iacute; se quedan: son la paleta del hoyo. Despu&eacute;s, en el "
         "gui&oacute;n, un byte <code>0x3n</code>, <code>0x4n</code> o "
         "<code>0x5n</code> repite <i>n</i>+1 veces el primero, el segundo o "
         "el tercero.</p>"
         "<p>Y lo que engancha las dos cosas es una resta de tres: el "
         "&iacute;ndice sale del <b>nibble alto</b> del opcode y la tabla de "
         "la que se lee empieza en <b>0xCEBD</b>, tres bytes antes de la "
         "cabecera, justo para que el 3, el 4 y el 5 caigan encima de ella. "
         "No hay tabla de paleta: hay un desplazamiento que hace que la "
         "cabecera del hoyo <i>sea</i> la paleta.</p>"
         "<p>Es el mismo formato, byte a byte, que el <i>Hole in One</i> de "
         "1984. El int&eacute;rprete de aquel cartucho lee estos treinta y "
         "seis gui&oacute;nes enteros.</p>"),
        ("La bandera no est&aacute; en el gui&oacute;n del hoyo",
         "<p>El gui&oacute;n trae el green, pero no d&oacute;nde se clava la "
         "bandera. Eso se <b>sortea en cada partida</b>: 0x7005 tira un dado "
         "m&oacute;dulo nueve y la tabla de 0x70F2 da las coordenadas, en una "
         "rejilla de tres por tres que es distinta para cada par &mdash;m"
         "&aacute;s cerrada en los pares 3 que en los 4 y 5&mdash;.</p>"
         "<p>Lo mismo con el viento y con el desnivel del green: los tres se "
         "sortean al montar el hoyo, y el nivel elegido en el men&uacute; "
         "decide cu&aacute;nto. En AVERAGE, 0x7073 le quita al viento el bit 6, "
         "o sea que sopla la mitad.</p>"),
        ("El fichero que graba el editor es el del cartucho de 1984",
         "<p>El modo <code>GAME &gt;&gt;CONSTRUCTION</code> no es un juego: es "
         "un <b>editor de campos</b> completo, con SETCHR para elegir con "
         "qu&eacute; casilla se pinta, SHOT para probar el hoyo de verdad, y "
         "SAVE, LOAD, COPY, SWAP y CLEAR.</p>"
         "<p>Y lo que graba no es un formato propio. Los veintiun bytes que "
         "0xBF14 pone delante del fichero son <b>exactamente</b> los que "
         "llevan delante los ficheros SDATA, WDATA y NDATA de la cinta "
         "<i>Hole In One Extension Course</i> de 1985, y las distancias "
         "cuadran: 0x16 y 0x3A del principio a las dos tablas, igual que "
         "all&iacute;. O sea que un campo hecho con este cartucho de 1986 se "
         "carga en el <i>Hole in One</i> de 1984 con <code>BLOAD</code> y "
         "<code>CALL GOLF</code>.</p>"),
        ("El <code>call 0x72D4</code> que no apunta a este cartucho",
         "<p>En 0xBE32 hay un <code>call 072d4h</code>, y 0x72D4 cae en medio "
         "de los gui&oacute;nes de campo. No es un error de trazado: es que "
         "<b>esa direcci&oacute;n ya no es el cartucho</b> cuando se ejecuta."
         "</p>"
         "<p>0xBE16 hace <code>ENASLT</code> con EXPTBL[0] y la <b>p&aacute;"
         "gina 1</b> pasa a ser la ROM de BASIC; 0x6FD7, 0x700B, 0x72D4 y "
         "0x72E9 son sus rutinas de casete. La p&aacute;gina 2, donde vive "
         "todo este c&oacute;digo, no se toca, y por eso puede seguir "
         "corriendo mientras su propia primera mitad est&aacute; fuera. Al "
         "acabar, 0xBE1B la devuelve con la ranura que <code>init</code> "
         "guard&oacute; en 0xFEDB.</p>"),
        ("Diecinueve bytes que no llama nadie",
         "<p>0xB885 es una rutina completa &mdash;monta 10&times;H+L de "
         "(0xCEF9) y devuelve carry si el resultado es cero o pasa de 18, o "
         "sea que comprueba un n&uacute;mero de hoyo&mdash; y <b>sus dos "
         "bytes no aparecen en ning&uacute;n sitio de la ROM</b>. La rutina de "
         "antes acaba en un <code>ret</code>, as&iacute; que tampoco se cae "
         "dentro. Es c&oacute;digo muerto del editor.</p>"),
    ],
    "en": [
        ("The opponent does not compute its shot: it REHEARSES it",
         "<p>What the computer does on its turn is not solve an equation. "
         "0x5B39 rolls it some starting values &mdash; a power between 0x18 "
         "and 0x1B, a curve between 0x19 and 0x20, the angle to the flag and a "
         "club obtained by dividing the distance by eight &mdash; and then it "
         "enters the loop at 0x5BB4, which <b>plays the whole shot with the "
         "real physics</b>: same routine, same wind, same terrain.</p>"
         "<p>When it ends it looks at where the ball landed. Into the water? "
         "change the club or the power and <b>hit it again</b>. Too long? trim "
         "it. Holed out? knock a point off, so it does not hole every one. And "
         "so on until it likes the result, or until it runs out of the tries "
         "it is allowed (0xC119, which grows when it is losing).</p>"
         "<p>Only then does 0x5408 replay it in front of the player, walking "
         "the power and curve bars up to the values already decided. What you "
         "see is not the shot: it is the re-enactment of the rehearsal. During "
         "the rehearsal, (0xC118) set to one switches off the joystick, the "
         "frame wait and the drawing, so the dozens of shots the opponent "
         "plays fit between two frames.</p>"),
        ("The terrain is decided by the pixel, not by the tile",
         "<p>0x629C classifies what is under the ball by tile number: 0x60 to "
         "0x77 are trees, 0x94 to 0xB3 bunker, 0xB4 to 0xD1 water. But tiles "
         "that straddle two terrains cannot be resolved that way, and for "
         "those the cartridge <b>reads the VRAM</b>.</p>"
         "<p>0x63B1 pulls the <b>exact bit</b> under the ball out of the "
         "pattern table, with the right one of the eight masks at 0x63E9. And "
         "0x63D3 reads from the <b>colour</b> table the nibble belonging to "
         "that pixel: the high one if the bit is set, the low one if not. That "
         "is what separates fairway from rough, bunker from water, and a bank "
         "from everything else.</p>"
         "<p>So collision against the scenery is settled by the <b>drawing</b>, "
         "and not by a second table someone would have to keep in step with "
         "it.</p>"),
        ("Golf's honour rule is in the code",
         "<p>In golf, between two players, the one farther from the hole plays "
         "first. 0x46FA does exactly that: it measures both distances with "
         "0x475C &mdash; the difference in X and in Y, each in absolute value "
         "and halved so they fit, then the root of the sum of squares &mdash; "
         "and gives the turn to whoever is worse off.</p>"
         "<p>With a detail: if both have reached the green it also switches to "
         "the close-up view. And if one of the two has already holed out, "
         "there is nothing to decide.</p>"),
        ("Three whole screens at once in the VRAM",
         "<p>The MSX's SCREEN 2 has one name table, but VDP register 2 says "
         "where it is. This cartridge builds <b>three</b> and flips that "
         "register: 0x1800 is the playing screen, 0x1C00 the eighteen-hole "
         "scorecard and 0x3C00 the tournament leaderboard.</p>"
         "<p>0x678B does an <code>xor 1</code> on the RAM copy of the register "
         "&mdash; worth 0x400, exactly the gap between 0x1800 and 0x1C00 "
         "&mdash; and 0x67CC an <code>xor 9</code>, which lands on 0x3C00. "
         "Pressing F1 or F2 mid-round redraws nothing: it <b>shows another "
         "screen that was already built</b>, and letting go returns to the "
         "previous one without a byte lost.</p>"),
        ("Thirty-five real professionals, and a roll of the dice",
         "<p>At 0x5009 there are thirty-five names from the mid-eighties tour, "
         "stored one after another with no pointer and no length: <b>bit 7 of "
         "the last character</b> marks where each one ends. Nicklaus, "
         "Ballesteros, Trevino, Watson, Norman, Aoki, both Ozakis, Nakajima, "
         "Kuramoto&hellip;</p>"
         "<p>The tournament does not simulate them shot by shot: for each "
         "hole, 0x4EC9 rolls a die, subtracts the personal difficulty each was "
         "dealt at the start (0xC09B), adds their <b>fixed adjustment</b> from "
         "the table at 0x5130 &mdash; one byte from 0 to 7 per golfer &mdash; "
         "and looks up which band it falls in. The bands give +2, +1, par, "
         "&minus;1 and &minus;2, and there are <b>three tables</b> of bands: "
         "which one is used depends on whether the player is under, on, or "
         "over par. Against a player who is going well, the field tightens."
         "</p>"),
        ("Every hole declares its three materials and then paints with them",
         "<p>A whole hole takes some <b>311 bytes</b> on average, and the "
         "trick is in the first three. The cartridge copies them to 0xCEC0 and "
         "there they stay: they are the hole's palette. Then, in the script, a "
         "<code>0x3n</code>, <code>0x4n</code> or <code>0x5n</code> byte "
         "repeats the first, second or third of them <i>n</i>+1 times.</p>"
         "<p>What links the two is a subtraction of three: the index comes "
         "from the opcode's <b>high nibble</b> and the table it reads from "
         "starts at <b>0xCEBD</b>, three bytes before the header, exactly so "
         "that 3, 4 and 5 land on it. There is no palette table: there is an "
         "offset that makes the hole's header <i>be</i> the palette.</p>"
         "<p>It is the same format, byte for byte, as the 1984 <i>Hole in "
         "One</i>. That cartridge's interpreter reads all thirty-six of these "
         "scripts whole.</p>"),
        ("The flag is not in the hole's script",
         "<p>The script carries the green, but not where the flag is planted. "
         "That is <b>rolled every round</b>: 0x7005 throws a die modulo nine "
         "and the table at 0x70F2 gives the coordinates, on a three-by-three "
         "grid that differs per par &mdash; tighter on the par 3s than on the "
         "4s and 5s.</p>"
         "<p>Same for the wind and the green's slope: all three are rolled "
         "when the hole is built, and the level chosen in the menu decides how "
         "much. On AVERAGE, 0x7073 clears bit 6 of the wind, so it blows half "
         "as hard.</p>"),
        ("The file the editor saves is the 1984 cartridge's",
         "<p><code>GAME &gt;&gt;CONSTRUCTION</code> is not a game mode: it is "
         "a full <b>course editor</b>, with SETCHR to pick which tile you "
         "paint with, SHOT to actually try the hole, and SAVE, LOAD, COPY, "
         "SWAP and CLEAR.</p>"
         "<p>And what it saves is not a format of its own. The twenty-one "
         "bytes 0xBF14 puts in front of the file are <b>exactly</b> the ones "
         "in front of the SDATA, WDATA and NDATA files on the 1985 <i>Hole In "
         "One Extension Course</i> tape, and the offsets line up: 0x16 and "
         "0x3A from the start to the two tables, just as there. Which means a "
         "course built on this 1986 cartridge loads into the 1984 <i>Hole in "
         "One</i> with <code>BLOAD</code> and <code>CALL GOLF</code>.</p>"),
        ("The <code>call 0x72D4</code> that does not point into this cartridge",
         "<p>At 0xBE32 there is a <code>call 072d4h</code>, and 0x72D4 lands "
         "in the middle of the course scripts. It is not a tracing error: that "
         "<b>address is no longer the cartridge</b> when it executes.</p>"
         "<p>0xBE16 does an <code>ENASLT</code> with EXPTBL[0] and <b>page "
         "1</b> becomes the BASIC ROM; 0x6FD7, 0x700B, 0x72D4 and 0x72E9 are "
         "its cassette routines. Page 2, where all this code lives, is not "
         "touched, which is why it can keep running while its own first half "
         "is swapped out. When it is done, 0xBE1B brings it back using the "
         "slot <code>init</code> stored at 0xFEDB.</p>"),
        ("Nineteen bytes nobody calls",
         "<p>0xB885 is a complete routine &mdash; it builds 10&times;H+L from "
         "(0xCEF9) and returns carry if the result is zero or over 18, that "
         "is, it validates a hole number &mdash; and <b>its two bytes appear "
         "nowhere in the ROM</b>. The routine before it ends in a "
         "<code>ret</code>, so nothing falls into it either. It is dead code "
         "from the editor.</p>"),
    ],
}

GALERIA = [
    ("rotulo.png",
     "<b>El cartucho no tiene r&oacute;tulo de t&iacute;tulo</b>: su portada "
     "son los cr&eacute;ditos y el men&uacute;. As&iacute; que el de la "
     "cabecera de esta p&aacute;gina est&aacute; montado con sus propias "
     "piezas &mdash;el recuadro del panel, con sus ocho casillas de esquina y "
     "lado, y las letras de su fuente&mdash; y con sus propios textos: "
     "<i>HOLE IN ONE</i> es el mensaje de 0x4C0B, el que sale al meterla de un "
     "golpe, y <i>PROFESSIONAL</i> el r&oacute;tulo de nivel de 0x527A",
     "<b>The cartridge has no title wordmark</b>: its front page is the "
     "credits and the menu. So the one in this page's header is built from its "
     "own pieces &mdash; the panel's frame, with its eight corner and side "
     "tiles, and the letters of its font &mdash; and from its own text: "
     "<i>HOLE IN ONE</i> is the message at 0x4C0B, the one that comes up when "
     "you ace a hole, and <i>PROFESSIONAL</i> the level label at 0x527A"),
    ("creditos.png",
     "<b>La portada del cartucho</b>, montada con sus propios pasos: el fondo "
     "de 0xABA1 descomprimido y encima las cuatro filas de veintiun caracteres "
     "que 0x51BF suelta desde 0x1A46. Dice qui&eacute;n lo hizo: "
     "<b>&copy; HAL LABORATORY 1985</b>, producido por <b>F. NAKAMURA</b> y "
     "programado por <b>S. IWATA</b>. La arroba es el s&iacute;mbolo de "
     "copyright de esta fuente, y el <code>&gt;</code> es el punto",
     "<b>The cartridge's front page</b>, built with its own steps: the "
     "decompressed background from 0xABA1 and, on top, the four rows of "
     "twenty-one characters 0x51BF lays down from 0x1A46. It says who made it: "
     "<b>&copy; HAL LABORATORY 1985</b>, produced by <b>F. NAKAMURA</b> and "
     "programmed by <b>S. IWATA</b>. The at sign is this font's copyright "
     "symbol, and <code>&gt;</code> is its full stop"),
    ("menu.png",
     "El men&uacute;, con sus valores de f&aacute;brica. Cuatro l&iacute;neas "
     "y tres tablas paralelas: 0x40CC dice qu&eacute; rutina baja el valor, "
     "0x40D4 cu&aacute;l lo sube y 0x40DE sobre qu&eacute; variable de RAM "
     "trabaja. El salto no es un <code>jp</code>: la direcci&oacute;n se mete "
     "en la pila y el <code>ret</code> hace de salto",
     "The menu, with its factory settings. Four lines and three parallel "
     "tables: 0x40CC says which routine lowers the value, 0x40D4 which raises "
     "it and 0x40DE which RAM variable it works on. The jump is not a "
     "<code>jp</code>: the address is pushed and the <code>ret</code> does the "
     "jumping"),
    ("hoyo_1_queen.png",
     "<b>El hoyo 1 de QUEEN SIDE</b>, par 4 y 352 metros, con el panel a la "
     "izquierda tal como lo escribe 0x67EF y el mapa entrando por la columna "
     "once. La calle sube entre &aacute;rboles con el mar a la derecha; abajo "
     "est&aacute; el tee, con los coches aparcados",
     "<b>Hole 1 of QUEEN SIDE</b>, par 4 and 352 metres, with the panel on the "
     "left exactly as 0x67EF writes it and the map starting at column eleven. "
     "The fairway climbs between trees with the sea to the right; the tee is "
     "at the bottom, with the buggies parked"),
    ("campo_queen.png",
     "<b>QUEEN SIDE entero</b>: los dieciocho hoyos, par 72 y 6.166 metros, "
     "dibujados uno a uno con el mismo int&eacute;rprete de gui&oacute;nes que "
     "corre el Z80. Cuatro pares 3, diez pares 4 y cuatro pares 5. F&iacute;"
     "jate en el hoyo 10, que tiene forma de pie, y en el 16, que dibuja un "
     "tres",
     "<b>QUEEN SIDE in full</b>: the eighteen holes, par 72 and 6,166 metres, "
     "drawn one by one with the same script interpreter the Z80 runs. Four par "
     "3s, ten par 4s and four par 5s. Look at hole 10, shaped like a foot, and "
     "hole 16, which draws a figure three"),
    ("campo_king.png",
     "<b>KING SIDE</b>, el segundo campo: tambi&eacute;n par 72 y con el mismo "
     "reparto de pares, pero <b>6.290 metros</b> y a simple vista mucho "
     "m&aacute;s duro. M&aacute;s agua, calles m&aacute;s estrechas y mucho "
     "m&aacute;s negro, que es la casilla 0x00 y el juego la trata como fuera "
     "de l&iacute;mites",
     "<b>KING SIDE</b>, the second course: also par 72 with the same spread of "
     "pars, but <b>6,290 metres</b> and visibly much harder. More water, "
     "narrower fairways and a lot more black, which is tile 0x00 and the game "
     "treats it as out of bounds"),
    ("marcador.png",
     "<b>La segunda tabla de nombres</b>, la de 0x1C00: el marcador de "
     "dieciocho hoyos con la ida y la vuelta. Los n&uacute;meros de hoyo y los "
     "pares no est&aacute;n en la tabla: los escribe 0x49D8 leyendo el par del "
     "tile del tee de cada gui&oacute;n. Aqu&iacute; est&aacute;n puestos con "
     "esa misma cuenta, y caen exactos en las casillas que apunta la tabla de "
     "0x4A18",
     "<b>The second name table</b>, at 0x1C00: the eighteen-hole scorecard "
     "with its OUT and IN halves. The hole numbers and pars are not in the "
     "table: 0x49D8 writes them, reading each hole's par off the tee tile in "
     "its script. Here they are placed by that same arithmetic, and they land "
     "exactly on the cells the table at 0x4A18 points to"),
    ("golfistas_1.png",
     "<b>La tercera tabla de nombres</b>, la de 0x3C00, con los primeros "
     "dieciocho de los treinta y cinco profesionales de 0x5009, escritos con "
     "la fuente del propio cartucho. El orden es el de la tabla, no el de una "
     "partida: en el torneo se barajan al empezar",
     "<b>The third name table</b>, at 0x3C00, with the first eighteen of the "
     "thirty-five professionals at 0x5009, written in the cartridge's own "
     "font. The order is the table's, not a round's: the tournament shuffles "
     "them at the start"),
    ("golfistas_2.png",
     "Y los diecisiete restantes. Ballesteros, Nicklaus, Norman, Trevino, "
     "Aoki, Nakajima, Kuramoto y los dos Ozaki: el circuito de mediados de los "
     "ochenta, europeo, americano y japon&eacute;s",
     "And the remaining seventeen. Ballesteros, Nicklaus, Norman, Trevino, "
     "Aoki, Nakajima, Kuramoto and both Ozakis: the mid-eighties tour, "
     "European, American and Japanese"),
    ("swing.png",
     "<b>Los siete tiempos del swing</b>, sacados de 0x9F21. Cada dibujo son "
     "cuatro por cinco casillas y cada fila empieza por una m&aacute;scara de "
     "cuatro bits: un bit a uno es hueco y uno a cero se lleva la casilla "
     "siguiente de la tira. Los gui&oacute;nes de 0x9EC0 los encadenan, y en "
     "el tercero &mdash;el del impacto&mdash; suena la pista 5",
     "<b>The seven frames of the swing</b>, from 0x9F21. Each frame is four by "
     "five tiles and every row starts with a four-bit mask: a bit set is a "
     "gap, a bit clear takes the next tile off the strip. The scripts at "
     "0x9EC0 chain them, and on the third &mdash; the impact &mdash; track 5 "
     "plays"),
    ("green.png",
     "<b>La vista corta.</b> El gui&oacute;n del green es uno solo para los "
     "treinta y seis hoyos (0x9D6C) y se monta en 0xCCE0 en vez de en 0xCB00; "
     "los patrones y colores que lo dibujan se descomprimen encima de los del "
     "campo, y por eso las seis filas de abajo del panel se borran antes. El "
     "hoyo se pone donde diga la tabla de 0x7128, que es la misma rejilla de "
     "nueve sitios pero en coordenadas de green",
     "<b>The close-up view.</b> There is one green script for all thirty-six "
     "holes (0x9D6C) and it is built at 0xCCE0 instead of 0xCB00; the patterns "
     "and colours that draw it decompress on top of the course's, which is why "
     "the panel's bottom six rows are blanked first. The hole goes wherever "
     "the table at 0x7128 says, the same nine-position grid but in green "
     "coordinates"),
    ("patrones.png",
     "<b>La tabla de patrones entera</b>, 256 casillas de 2 KB que se "
     "descomprimen desde 0x9F85 y se copian a los tres tercios de la pantalla. "
     "Est&aacute;n el marco del panel, la fuente &mdash;con el "
     "<code>&copy;</code> en la arroba y el punto en el <code>&gt;</code>"
     "&mdash;, la hierba, el agua, la arena, los &aacute;rboles, el golfista y "
     "la casa club",
     "<b>The whole pattern table</b>, 256 tiles of 2 KB decompressed from "
     "0x9F85 and copied into all three thirds of the screen. Here are the "
     "panel frame, the font &mdash; with <code>&copy;</code> on the at sign "
     "and the full stop on <code>&gt;</code> &mdash;, grass, water, sand, "
     "trees, the golfer and the clubhouse"),
    ("sprites.png",
     "Los veintitr&eacute;s sprites, descomprimidos desde 0x6898 a 0x3800. La "
     "bola en cinco tama&ntilde;os &mdash;crece con la altura, que es como se "
     "ve que est&aacute; en el aire&mdash;, su sombra, la bandera, las ocho "
     "flechas del viento y los cuadros del cursor del editor",
     "The twenty-three sprites, decompressed from 0x6898 to 0x3800. The ball "
     "in five sizes &mdash; it grows with height, which is how you see it is "
     "airborne &mdash;, its shadow, the flag, the eight wind arrows and the "
     "editor's cursor boxes"),
    ("hal_country_club.png",
     "Y el banner del marcador, que es lo m&aacute;s parecido a un t&iacute;"
     "tulo que hay en la ROM: <b>HAL COUNTRY CLUB</b>",
     "And the scorecard's banner, which is the closest thing to a title in the "
     "ROM: <b>HAL COUNTRY CLUB</b>"),
    ("clasificacion.png",
     "La pantalla de la clasificaci&oacute;n del torneo tal como sale de la "
     "ROM, antes de que nadie escriba en ella. RANK, PLAYER, SCORE y HOLE, y "
     "dieciocho renglones que 0x674E monta repitiendo dieciocho veces el mismo "
     "bloque de treinta y dos casillas",
     "The tournament leaderboard screen as it comes out of the ROM, before "
     "anyone writes on it. RANK, PLAYER, SCORE and HOLE, and eighteen rows "
     "0x674E builds by repeating the same thirty-two-cell block eighteen "
     "times"),
]


def img64(ruta):
    with open(ruta, "rb") as f:
        return "data:image/png;base64," + base64.b64encode(f.read()).decode()


def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    imgdir, salida, idioma = argv[1:4]
    t = TXT[idioma]

    # EL LOGOTIPO. Este cartucho no tiene rotulo de titulo: su portada son los
    # creditos y el menu. Asi que el de la cabecera se monta con sus propias
    # piezas -el recuadro del panel y las letras de su fuente- y con sus propios
    # textos: HOLE IN ONE es el mensaje de 0x4C0B y PROFESSIONAL el rotulo de
    # nivel de 0x527A. Lo dibuja graficos.py desde la ROM. Si el PNG no esta,
    # el trabajo NO esta hecho: se cae al texto, y eso se ve.
    ruta_logo = os.path.join(imgdir, "rotulo.png")
    cabecera = (f'<img src="{img64(ruta_logo)}" alt="Hole in One Professional">'
                if os.path.exists(ruta_logo) else "<h1>Hole in One Professional</h1>")

    nav = "".join(f'<a href="{h}">{x}</a>' for h, x in t["nav"])
    nav += "".join(f'<a href="{h}">{x}</a>' for h, x in t["docnav"])
    nav += (f'<a href="{t["otro"][0]}" style="margin-left:auto;color:var(--oro)">'
            f'{t["otro"][1]}</a>')

    cifras = "".join(f'<div class="cifra"><b>{v}</b><span>{e}</span></div>'
                     for v, e in t["cifras"])
    halls = "".join(f'<div class="hall"><h3>{tit}</h3>{cuerpo}</div>'
                    for tit, cuerpo in HALLAZGOS[idioma])
    imgs = ""
    faltan = []
    for fich, es, en in GALERIA:
        ruta = os.path.join(imgdir, fich)
        if not os.path.exists(ruta):
            faltan.append(fich)
            continue
        pie = es if idioma == "es" else en
        imgs += (f'<figure><img src="{img64(ruta)}" alt="{pie}">'
                 f'<figcaption>{pie}</figcaption></figure>')
    if faltan:
        print("  (faltan %d imagenes: %s)" % (len(faltan), " ".join(faltan)))

    html = f"""<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{t['titulo']}</title>
<style>{ESTILO}</style>
<header class="top">
  {cabecera}
  <p class="claim">{t['claim']}</p>
  <p class="ficha">{' · '.join(t['ficha'])}</p>
</header>
<p class="ficha" style="border:1px solid var(--oro);padding:.8em 1em;margin:1.5em 0">
{t['aviso']}</p>
<nav>{nav}</nav>
<section id="numbers">
  <h2>{t['h_num']}</h2>
  <div class="cifras">{cifras}</div>
</section>
<section id="findings"><h2>{t['h_find']}</h2>{halls}</section>
<section id="screens">
  <h2>{t['h_scr']}</h2>
  <p class="n">{t['nota_scr']}</p>
  <div class="galeria">{imgs}</div>
</section>
<footer><p>{t['pie_leg']}</p></footer>
"""
    with open(salida, "w", encoding="utf-8") as f:
        f.write(html)
    print("  %s: %d KB (%s)" % (salida, len(html) // 1024, idioma))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
