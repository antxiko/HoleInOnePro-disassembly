# Hallazgos

Lo que apareció al desmontarlo, con la dirección de cada cosa para que se pueda
comprobar.

## Quién lo hizo, dicho por el propio cartucho

La pantalla de créditos no es una captura: son cuatro filas de veintiún
caracteres que 0x51BF suelta en la tabla de nombres, expandidas del texto
comprimido de 0x51E5.

    © HAL LABORATORY 1985
    PRODUCER   F.NAKAMURA
    PROGRAMMER S.IWATA

La arroba es el símbolo de copyright en la fuente del cartucho, y el `>` es el
punto: se ve en la propia tabla de patrones. El cartucho es de 1986 y sus
créditos dicen 1985.

## El rótulo y el campo se turnan los mismos cuarenta y cinco tiles

La pantalla de título lleva un rótulo que ocupa media pantalla: **HOLE IN ONE**
en bloque sobre un degradado rojo y **Professional** en cursiva sobre verde, con
una bola de golf haciendo de punto. Y no está guardado aparte: son los tiles
**0xD3 a 0xFF**, los mismos cuarenta y cinco que en partida son el tee, el green
y la bandera.

El cartucho los intercambia entrando **en una instrucción o en la siguiente**.
0x66D4 es un `or 0AFh`, o sea los dos bytes `F6 AF`: llamando ahí, Z se va a cero
y las seis llamadas de detrás cargan los 2 KB del bloque grande de 0x9F85, que
traen los tiles del juego. Pero 0x66C6 acaba en un `jr $+3` que cae en
**0x66D5**, el segundo byte de esa misma instrucción, y `0xAF` por su cuenta es
`xor a`: A se pone a cero, **Z se levanta** y entonces las seis cargan sólo los
360 bytes de 0xAA0E y 0xAAFD, que son el rótulo.

(0xCA40) apunta cuál de los dos juegos está puesto, y por eso pulsar F1 en el
menú carga los del juego para poder dibujar el marcador y luego devuelve los del
rótulo. La pantalla de título gasta **416 de sus 768 casillas** en esos cuarenta
y cinco tiles.

## El rival no calcula el golpe: lo ensaya

Es el hallazgo grande. Cuando le toca jugar al ordenador, 0x5B39 le sortea unos
valores de partida —fuerza entre 0x18 y 0x1B, curva entre 0x19 y 0x20, el ángulo
hacia la bandera y un palo sacado de dividir la distancia por ocho— y entonces
entra en el bucle de 0x5BB4, que **juega el golpe entero con la física de
verdad**.

Al acabar mira dónde ha caído la bola y reacciona:

| lo que pasa | qué cambia |
|---|---|
| se va al agua (0x5CB4) | un dado decide si sube o baja el palo, la fuerza, el ángulo o la curva |
| se queda corta (0x5DFA) | abanica el ángulo, o sube un palo y baja un punto de fuerza |
| se pasa (0x5E76) | recorta la fuerza en proporción |
| fuera o en búnker (0x5DB4) | baja un palo |
| **entra** (0x5D95) | se rebaja un punto, para no meterla siempre |

Y vuelve a tirarlo. Hasta que le gusta, o hasta que se le acaban los intentos que
tiene (0xC119, que crece si va perdiendo: de 4 a 6 cuando pierde por tres o más).

Sólo entonces 0x5408 lo repite delante del jugador, moviendo las barras de fuerza
y curva hasta los valores ya decididos. **Lo que se ve no es el golpe: es la
reposición del ensayo.** Durante el ensayo, (0xC118) a uno apaga el mando, la
espera de cuadro y el dibujado, así que las decenas de golpes que se juega el
rival caben entre dos fotogramas.

En el green hace lo mismo con el putt (0x6091), y ahí la fuerza de partida es la
mitad de la distancia más tres.

## El terreno se decide por el píxel

0x629C clasifica lo que hay bajo la bola por el número de casilla: de 0x60 a
0x77 árboles, de 0x94 a 0xB3 búnker, de 0xB4 a 0xD1 agua. Pero las casillas que
están a caballo entre dos terrenos no se pueden resolver así, y para ésas el
cartucho **lee la VRAM**.

- **0x63B1** saca de la tabla de patrones el bit exacto que hay bajo la bola,
  con la máscara que le toca de las ocho de 0x63E9.
- **0x63D3** lee de la tabla de **color** el nibble de ese píxel: el alto si el
  bit está encendido, el bajo si no.

Con eso se separa la calle del rough, el búnker del agua y el talud de lo demás.
La colisión con el decorado la resuelve el dibujo, y no una segunda tabla que
hubiera que mantener a juego con él.

## La honra del golf está programada

En golf, entre dos jugadores, tira el que está más lejos del hoyo. 0x46FA lo
hace: mide las dos distancias con 0x475C —la diferencia en X y en Y, cada una en
valor absoluto y a la mitad para que quepan, y la raíz de la suma de cuadrados— y
le da el turno al que peor está. Si los dos han llegado al green, además pasa a
la vista corta.

## Los treinta y cinco profesionales

En 0x5009, uno detrás de otro y sin puntero ni longitud: el **bit 7 del último
carácter** marca dónde acaba cada nombre.

    C.STRANGE  L.WADKINS  C.PEETE     R.FLOYD    C.PAVIN
    M.OMEARA   C.STADLER  B.LANGER    T.WATSON   F.ZOELLER
    R.MALTBIE  H.IRWIN    T.KITE      P.STEWART  L.MIZE
    H.SUTTON   J.SINDELAR J.MAHAFFEY  S.BALLESTEROS  P.JACOBSEN
    L.RINKER   B.EASTWOOD D.POOLEY    G.BURNS    S.SIMPSON
    I.AOKI     L.NELSON   J.NICKLAUS  G.NORMAN   L.TREVINO
    T.NAKAJIMA M.KURAMOTO B.LIETZKE   T.OZAKI    N.OZAKI

Y el torneo no los simula golpe a golpe. Por cada hoyo, 0x4EC9 tira un dado, le
resta la dificultad propia que a cada uno se le sorteó al empezar la vuelta
(0xC09B), le suma su **ajuste fijo** de la tabla de 0x5130 —un byte de 0 a 7 por
golfista— y mira en qué tramo cae. Los tramos dan +2, +1, par, −1 y −2, y hay
**tres tablas** de tramos: la que se usa depende de si el jugador va por debajo,
en el par o por encima. Contra un jugador que va bien, el circuito aprieta.

Con un jugador solo en TOURNAMENT, 0x4F4A te deja además **elegir contra qué
profesional juegas**, pasando la lista con las flechas.

## Una sola tirada decide el tee y la bandera del green

0x7005 tira un dado módulo nueve, y con ese número decide **dos cosas a la vez**.

Con la tabla de **0x70F2** coloca **la bola dentro de la caja del tee**: 0x7024
suma la entrada a (0xCECA), que son las coordenadas del tee en píxeles, y el
resultado va a 0xC63F y 0xC640, que es la bola en la vista del campo. Los
desplazamientos van de 3 a 17 píxeles, justo lo que mide la caja del tee —tres
casillas por dos—, y la rejilla es distinta para cada par.

Y con la tabla de **0x7128**, el **mismo número** coloca **el hoyo dentro del
green**: 0x7043 monta con él la casilla de 0xCECD, que es donde 0x715F escribe el
tile 0xD6, y las coordenadas del hoyo en 0xC63D y 0xC63E. Así que de dónde sales
y dónde está la bandera cuando llegas son la misma tirada.

La bandera de la vista larga, en cambio, **sí** viene en el guion: es el tile
0xE9, y 0x6FA5 apunta dónde cae. Lo que se sortea, además del tee, son el viento
y el desnivel del green, y el nivel decide cuánto.

## La cabecera del hoyo es su paleta

Un hoyo ocupa 311 bytes de media, y el truco está en los tres primeros. El
cartucho los copia a 0xCEC0 y ahí se quedan. Después, en el guion, un byte
`0x3n`, `0x4n` o `0x5n` repite *n*+1 veces el primero, el segundo o el tercero.

Lo que engancha las dos cosas es una resta de tres: el índice sale del **nibble
alto** del opcode y la tabla de la que se lee empieza en **0xCEBD**, tres bytes
antes de la cabecera, justo para que el 3, el 4 y el 5 caigan encima de ella. No
hay tabla de paleta: hay un desplazamiento que hace que la cabecera del hoyo
*sea* la paleta.

Es el mismo formato, byte a byte, que el *Hole in One* de 1984.

## El `call 0x72D4` que no apunta aquí

En 0xBE32 hay un `call 072d4h`, y 0x72D4 cae en medio de los guiones de campo.
No es un error de trazado: esa dirección **ya no es el cartucho** cuando se
ejecuta.

    L_BE16   ld a,(0fcc1h)   ; EXPTBL[0], la ranura de la ROM principal
             ld hl,04000h
             jp 00024h       ; ENASLT: la página 1 pasa a ser la BASIC ROM

0x6FD7, 0x700B, 0x72D4 y 0x72E9 son rutinas de casete de la ROM de BASIC. La
página 2, donde vive todo ese código, no se toca, y por eso puede seguir
corriendo mientras su propia primera mitad está fuera. Al acabar, 0xBE1B la
devuelve con la ranura que `init` guardó en 0xFEDB.

## Diecinueve bytes que no llama nadie

0xB885 es una rutina completa —monta 10×H+L de (0xCEF9) y devuelve carry si el
resultado es cero o pasa de 18, o sea que comprueba un número de hoyo— y **sus
dos bytes no aparecen en ningún sitio de la ROM**. La rutina de antes acaba en
un `ret`, así que tampoco se cae dentro. Es código muerto del editor.
