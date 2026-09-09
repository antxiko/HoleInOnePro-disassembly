# El editor

`GAME >>CONSTRUCTION` no es un modo de juego: es un **editor de campos**
completo, y ocupa desde 0xAEA3 hasta el final del cartucho. Con él se dibujan
dieciocho hoyos, se les mide la distancia, se prueban golpeando de verdad y se
graban en cinta.

## De dónde viene

De la cinta. En 1985 HAL sacó *Hole In One Extension Course*, y además de tres
campos llevaba un fichero llamado **CONST**: 12 KB de programa que son el mismo
editor. Los textos de dentro no dejan lugar a dudas —SETCHR, SET=UP, MOVE, SWAP,
CLEAR, SAVE1, SAVE18, LOAD, FILES, DEVICE, NAME:, «GREEN OR TEE NOT FOUND»— y
este cartucho **comparte 3.050 bytes con él en 24 tiras**, incluida la tabla de
palos de 0x4B16 y la hoja de sprites entera.

O sea que el editor de 1985 se metió dentro del cartucho de 1986.

## Tres pantallas

(0xCED9) dice en cuál se está, y cada una tiene su propio cursor —0xCEDA, 0xCEDB
y 0xCEDC—. IY apunta al que toca.

| pantalla | opciones |
|---|---|
| 0 | HOLE · SETCHR · PAR · DIST. · SHOT · MOVE · WIND |
| 1 | la de dibujar |
| 2 | SAVE · LOAD · COPY · SWAP · CLEAR |

La opción elegida se despacha por la tabla de 0xAFAD con un `jp (hl)`, y 0xAFB3
y 0xAFB7 son desplazamientos **dentro de esa misma tabla**: las tres pantallas
comparten el despachador.

## Dónde vive un campo de usuario

Los dieciocho hoyos están en RAM, desde 0xD04B y de 480 en 480 bytes; los
punteros están en la tabla de 0xBEF0. Y de cada hoyo se guardan aparte tres
cosas:

- el **par** (0xCF38 + hoyo),
- si tiene **green y tee** (0xCF26 + hoyo),
- y los **tres dígitos de la distancia** (0xCF48 + 3 × hoyo).

## Pintar

Se pinta casilla a casilla, con la que se haya elegido en SETCHR de entre las
**136** que ofrece la lista de 0xBCD1. La barra suelta una, la Z suelta dos.

Hay dos casillas que no se pueden pisar: de 0xD7 a 0xF7 son green y tee, y 0xB01B
lo comprueba antes de escribir. Para ponerlas están los ocho **sellos** de
0xBD93: tres tees —uno por par, de tres por dos casillas— y cinco greens, de
cuatro por dos y con la bandera dentro. 0xB9B4 comprueba que el sello cabe antes
de soltarlo, y al soltar un tee apunta el par del hoyo y al soltar un green lo
marca como completo.

## Medir la distancia

`DIST.` es lo más curioso del editor. No mide en línea recta: te hace **marcar
hasta tres puntos** —tantos como el par menos dos— y suma el recorrido de tee a
punto, de punto a punto y de punto a bandera (0xB1A7). El total se dobla, se
acota a 999 y se escribe en tres dígitos.

Y ahí hay un detalle bonito: antes de acotar, 0xB1D3 lee el **registro R de
refresco** del Z80 y con su bit 0 suma uno o no. Es un dado gratis, y sirve para
que la cifra no salga siempre par.

Si el hoyo no tiene green o no tiene tee, el editor no deja medir: escribe
«GREEN OR TEE NOT FOUND.» y se queda ahí.

## Probar el hoyo

`SHOT` juega un golpe de verdad sobre el hoyo que se está editando, con la misma
rutina que la partida. Durante el golpe hay tres teclas propias: `0x0B` lleva la
mira a la bandera, `0x2F` la devuelve a donde estaba, y la cruceta cambia el
viento —izquierda y derecha la fuerza, arriba y abajo la dirección—.

## SWAP trae los hoyos del cartucho

`SWAP` no cambia dos hoyos de sitio: **trae un hoyo de los dos campos de la
ROM**. La cruceta pasa por los treinta y seis, y 0xB3F2 pone (0xC000) apuntando
a 0x716B, sale del modo editor un momento para poder interpretar el guion desde
la ROM, monta el hoyo y lo copia al buffer con su par y su distancia.

Así que un campo de usuario puede empezar siendo QUEEN SIDE con dos hoyos
cambiados.

## Y lo que graba es el fichero de 1984

Ésta es la mejor parte. 0xBF14 comprime los dieciocho hoyos al formato de guion
—0xBFAE hace la compresión por rachas contra los tres materiales de 0xBFF2— y le
pone delante estos veintiún bytes:

    push af / push hl
    ld hl,0c066h / ld (0e000h),hl
    ld hl,0c08ah / ld (0e002h),hl
    ld a,001h    / ld (0e004h),a
    pop hl / pop af / ret

Ese trozo no es de este cartucho. Es **exactamente** el que llevan delante los
ficheros SDATA, WDATA y NDATA de la cinta de 1985, y lo que hace es apuntar
0xE000 y 0xE002 —las dos tablas del *Hole in One* de 1984— al campo recién
cargado.

Y las cuentas cuadran. En el fichero de la cinta el trozo está en 0xC050 y las
dos tablas en 0xC066 y 0xC08A, o sea a 0x16 y a 0x3A bytes del principio. Aquí
el trozo se copia a 0xCF81, la tabla de los dieciocho hoyos se llena en 0xCF97 y
la segunda en 0xCFBB: 0x16 y 0x3A. El mismo fichero, byte a byte.

**Un campo hecho con el editor de este cartucho de 1986 se carga en el *Hole in
One* de 1984** con `BLOAD"CAS:",R` y `CALL GOLF`.

## La cinta, y el truco de la página

Grabar y cargar es lo que hace que 0xBE32 llame a 0x72D4, una dirección que en
este cartucho cae en medio de los guiones de campo. El truco está una
instrucción antes: 0xBE16 hace ENASLT con EXPTBL[0] y **la página 1 pasa a ser
la ROM de BASIC**, cuyas rutinas de casete están en 0x6FD7, 0x700B, 0x72D4 y
0x72E9.

La página 2, donde vive todo el editor, no se toca. Por eso el código puede
seguir corriendo mientras su propia primera mitad está fuera del mapa. Al
acabar, 0xBE1B la devuelve con la ranura que `init` guardó en 0xFEDB nada más
arrancar.
