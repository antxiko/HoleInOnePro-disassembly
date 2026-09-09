# El cartucho

32.768 bytes que se mapean en las páginas 1 y 2, o sea de 0x4000 a 0xBFFF.

## La cabecera

Los diez primeros bytes son la cabecera AB del MSX:

    41 42 10 40 00 00 00 00 00 00
    'A''B' INIT  STATEMENT  DEVICE  TEXT

**Sólo declara INIT**, en 0x4010. STATEMENT, DEVICE y TEXT están a cero, y eso
es justo lo que separa a este cartucho del *Hole in One* de 1984: aquél
registraba una sentencia BASIC —`CALL GOLF`— y por eso podía cargar campos de
cinta. Éste no. Los campos de fuera entran por otro sitio: por el editor.

## El reparto

| desde | hasta | qué |
|---|---|---|
| 0x4000 | 0x4010 | la cabecera AB |
| 0x4010 | 0x5009 | arranque, menú, marcador y bucle de la vuelta |
| 0x5009 | 0x5175 | los treinta y cinco golfistas y sus tablas |
| 0x5175 | 0x52DE | los textos de la pantalla de título |
| 0x52DE | 0x63E9 | el golpe: punterí­a, barras, vuelo y física |
| 0x63E9 | 0x6603 | terreno, cálculo y las tablas de trigonometría |
| 0x6603 | 0x6C0D | pantalla, interrupción, mando y reproductor de PSG |
| 0x6C0D | 0x6F49 | la tabla de tonos y las doce pistas |
| 0x6F49 | 0x716B | el montador de hoyos |
| 0x716B | 0x9DDD | **los dos campos**: 36 punteros, 36 guiones y el green |
| 0x9DDD | 0x9F85 | la vista corta y el swing |
| 0x9F85 | 0xAEA3 | todo lo que se decomprime a la VRAM |
| 0xAEA3 | 0xC000 | **el editor de campos** y la cinta |

En cifras: **14.186 bytes de código trazado** y **18.582 de datos con nombre**.
Cero sin explicar.

## Cómo arranca

`init` (0x4010) hace lo de siempre y una cosa más. Primero averigua en qué
ranura está él mismo —RSLREG, la tabla de subranuras de 0xFCC1— y **se guarda el
resultado en 0xFEDB**. Esa nota le hará falta mucho más tarde, cuando la rutina
de cinta cambie la página 1 por la ROM de BASIC y haya que devolverla.

Luego mete su propia segunda mitad en la página 2 con ENASLT, borra de una
tirada 0xC002–0xF300, deja el campo QUEEN SIDE como el de fábrica y el TOP en
0x12 —dieciocho, un golpe por encima del par en cada hoyo—, arranca el PSG,
engancha la interrupción y se va a la exhibición.

## La interrupción, entre ranuras

0x6603 no mete un `jp` en H.TIMI: mete una **llamada entre ranuras**.

    ld a,0f7h        ; 0xF7 es RST 30h, o sea CALSLT
    ld (0fd9fh),a
    ld a,(0fedbh)    ; la ranura, la que init dejó apuntada
    ld (0fda0h),a
    ld hl,0665bh     ; y la dirección
    ld (0fda1h),hl

Tiene que ser así porque el manejador vive dentro del cartucho, y cuando salta
la interrupción no hay ninguna garantía de que el cartucho esté paginado. El
manejador (0x665B) hace dos cosas: marca que ha pasado un cuadro y le da un paso
al reproductor de PSG.

## Tres pantallas en la VRAM

El SCREEN 2 del MSX tiene una tabla de nombres, pero el registro 2 del VDP dice
dónde. Este cartucho monta tres y va cambiando ese registro:

| dirección | qué es | cómo se llega |
|---|---|---|
| 0x1800 | la pantalla de juego | el valor de fábrica, R2=0x06 |
| 0x1C00 | el marcador de dieciocho hoyos | 0x678B, `xor 1` |
| 0x3C00 | la clasificación del torneo | 0x67CC, `xor 9` |

Pulsar F1 o F2 durante la partida no redibuja nada. Enseña otra pantalla que ya
estaba montada, y al soltar la tecla se vuelve a la de antes.

## Los tres tercios, de una sola tabla

El SCREEN 2 son tres tercios independientes, y para que los tres tengan lo mismo
hay que escribirlo tres veces. 0x66D4 hace las seis llamadas —tres de patrones y
tres de color— y las tres de cada clase descomprimen **la misma fuente**: 2 KB de
cartucho por 6 KB de tabla.

Y hay un segundo modo de carga escondido en el mismo sitio. 0x66D4 empieza con un
`or 0AFh`, que son los bytes `F6 AF`. Entrando en **0x66D5** —el segundo byte de
esa instrucción— lo que se ejecuta es `xor a` suelto: A se pone a cero, Z se
levanta y las seis llamadas cargan sólo los 360 bytes de la cola de cada tercio,
que son los tiles **0xD3 a 0xFF**.

Y esos cuarenta y cinco tiles son **el rótulo del título**. Los mismos que en
partida son el tee, el green y la bandera. El cartucho los intercambia entrando
en una instrucción o en la siguiente, y (0xCA40) apunta cuál de los dos juegos
está puesto: por eso pulsar F1 en el menú carga los del juego para poder dibujar
el marcador y luego devuelve los del rótulo.

## Los once bloques comprimidos

Hay dos descompresores, y se distinguen por el byte de escape:

- **0x6AFA**, por rachas: `0xA0`–`0xAF` quiere decir (n & 0x0F) + 2 copias del
  byte siguiente.
- **0x6ABD**, por parejas: `0x00`–`0x0F` quiere decir (n & 0x0F) + 1 vueltas de
  un **par** de bytes que se alternan. Es la de las tablas de color de SCREEN 2,
  donde los bytes van a pares.

Los dos paran cuando el **destino** llega a su tope, no cuando se acaba la
entrada. Así que dónde acaba cada bloque no está escrito en ninguna parte: se
sabe descomprimiéndolo. Hecho eso, los once encajan uno detrás de otro **sin un
byte suelto**, desde 0x9F85 hasta 0xAEA3. Es la mejor prueba de que el formato
está entendido, y hay un test que la vigila.
