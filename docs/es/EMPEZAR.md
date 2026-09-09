# Empezar

Un desensamblado comentado de **Hole in One Professional**, el golf que HAL
Laboratory sacó para MSX en 1986: un cartucho de 32 KB que se mapea en las
páginas 1 y 2 (0x4000–0xBFFF). Reensambla dando la ROM exacta, byte a byte, y
cada uno de sus 32.768 bytes está explicado.

## El cartucho no está aquí

Ningún repositorio distribuye el juego. Pon tu propio volcado en la raíz como
`holeinonepro.rom`, 32768 bytes, sha256

    99900247abc5cff8f12fed900e4ebf783c7a7ecf8d689b4a5cccd85a8416451e

`make comprueba` lo verifica.

## Lo que hace falta

- **Python 3** para las herramientas.
- **pasmo** y **z80dasm** para reensamblar y comprobar.
- **openMSX**, sólo si quieres repetir el cotejo de VRAM.

## Reproducirlo

    make comprueba    el sha256 del volcado
    make              trazado, listado, reensamblado byte a byte,
                      comprobaciones de coherencia y tests
    make densidad     cuántas instrucciones llevan comentario
    make imagenes     dibuja las imágenes desde la ROM
    make vram         y las coteja contra la VRAM del emulador
    make web          regenera esta web

`make` sin argumentos es lo que decide: si el listado no vuelve a dar la ROM
byte a byte, falla.

## Qué hay en el repositorio

    src/holeinonepro.asm       el listado, generado
    src/holeinonepro.notes     los comentarios, anclados a dirección
    src/holeinonepro.entries   los puntos de entrada, con su justificación
    src/holeinonepro.nocode    las zonas que NO son código
    tools/                     las herramientas, todas medibles
    tests/                     lo que se afirma, atado al binario

El `.asm` está generado y se regenera. Lo que se edita a mano son las notas: un
fichero de directivas ancladas a dirección, para que los comentarios sobrevivan
a un retrazado.

## El cotejo de VRAM

Es la comprobación que decide si las imágenes valen. Se saca el volcado de
openMSX:

    openmsx -machine C-BIOS_MSX1_EU -cart holeinonepro.rom \
            -script tools/omsx_vram.tcl

y luego `make vram` compara byte a byte la VRAM que monta `tools/graficos.py`
con la de verdad. Salen **28.240 de 28.240** iguales en patrones, color,
sprites y las TRES tablas de nombres. Las 17 casillas que bailan son las
cifras que el juego escribe en marcha: el TOP, los golpes, el número de hoyo, la distancia,
el par, el viento y el desnivel.
