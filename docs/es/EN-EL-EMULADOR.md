# En el emulador

Lo que se midió con openMSX, y para qué.

## Para qué se usó

Para una sola cosa, pero la que decide: **comprobar que las imágenes de esta web
no son una interpretación**. Todas se dibujan ejecutando en Python los mismos
descompresores y los mismos intérpretes que corre el Z80. Si alguno estuviera mal
entendido, lo que saldría sería ruido —o, peor, algo que se ve bien y está mal—.
La única forma de saberlo es coger la VRAM de verdad y compararla.

## Cómo

`tools/omsx_vram.tcl` no pone **ningún punto de ruptura**: los volcados van por
reloj emulado, para que no dependan de en qué instrucción se pare el emulador.

    openmsx -machine C-BIOS_MSX1_EU -cart holeinonepro.rom \
            -script tools/omsx_vram.tcl

Saca cinco volcados de los 16 KB de VRAM y, con cada uno, los ocho registros del
VDP y una captura. Luego:

    make vram

## Lo que dicen los registros

    02 E2 06 FF 03 36 07 F1

que es exactamente lo que el código dice que monta:

| registro | valor | qué |
|---|---|---|
| R2 | 06 | tabla de nombres en 0x1800 |
| R3 | FF | tabla de color en 0x2000 |
| R4 | 03 | tabla de patrones en 0x0000 |
| R5 | 36 | atributos de sprite en 0x1B00 |
| R6 | 07 | patrones de sprite en 0x3800 |

## El resultado

| zona | distintos | de |
|---|---|---|
| patrones, tercio 0 | 0 | 2.048 |
| patrones, tercio 1 | 0 | 2.048 |
| patrones, tercio 2 | 0 | 2.048 |
| color, tercio 0 | 0 | 2.048 |
| color, tercio 1 | 0 | 2.048 |
| color, tercio 2 | 0 | 2.048 |
| patrones de sprite | 0 | 736 |
| tabla de nombres de 0x3C00 | 0 | 768 |
| **total** | **0** | **13.792** |

Cero diferencias en todo lo que sale de una tabla.

## Los treinta bytes que sí bailan

En el panel de la izquierda hay 30 bytes distintos de 264, y son exactamente los
que el juego escribe en marcha:

    lo que monta este repo      lo que hay en el emulador
    *TOP    +!                  *TOP ;18+!        -> TOP +18
    *1UP    +!                  *1UP  <0+!        -> 1UP ±0
    * 1UP   +!                  * 1UP  0+!        -> SHOTS 1UP 0
    *HOLE   +!                  *HOLE  1+!        -> HOLE 1
    *     ? +!                  * 352 ? +!        -> 352 m
    * PAR   +#                  * PAR 4 +#        -> PAR 4

O sea: el TOP de fábrica, los golpes de los dos jugadores, el número de hoyo, la
distancia, el par, el viento y el desnivel. Ninguno de ellos está en una tabla, y
por eso no se comparan.

Y de paso son otra comprobación: los **352 metros** y el **par 4** que el
emulador enseña son los que `tools/campos.py` saca del guion del hoyo 1 de QUEEN
SIDE, leyendo el par del tile del tee y los metros de los tres dígitos ASCII que
cierran el guion.

## Lo que NO se midió en el emulador

- **El sonido.** Las doce pistas están seguidas byte a byte con el intérprete del
  propio cartucho, y los límites están medidos, pero nadie las ha escuchado
  contra lo que hace el PSG de verdad.
- **El editor.** Los rótulos, los sellos y el formato del fichero salen del
  código; no se ha grabado un campo y vuelto a cargar.
- **El rival.** Que ensaya el golpe está leído del código, no cronometrado.

Está dicho en [Preguntas abiertas](PREGUNTAS-ABIERTAS.html).
