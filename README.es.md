# Hole in One Professional — desensamblado comentado

[Read this in English / Leer en inglés](README.md) &middot;
**[La web](https://antxiko.github.io/HoleInOnePro-disassembly/es/)**

Desensamblado completo y comentado de **Hole in One Professional** (HAL
Laboratory, MSX, 1986): un cartucho de 32 KB que se mapea en las páginas 1 y 2.
Reensambla dando la ROM exacta, byte a byte, y cada uno de sus 32.768 bytes está
explicado.

| | |
|---|---|
| binario explicado | **100 %** |
| código trazado | 14.186 bytes |
| datos identificados | 18.582 bytes |
| sin explicar | **0** |
| instrucciones | 7.133 |
| comentarios de línea | 3.169 |
| densidad de comentario | **44,4 %** |
| rutinas por debajo del 10 % | **0** |
| destinos de `call` sin bautizar | **0** |
| VRAM cotejada contra openMSX | **28.240 de 28.240** |
| tests | 26 |

## El cartucho no está aquí

Ningún repositorio distribuye el juego. Pon tu propio volcado en la raíz como
`holeinonepro.rom`, 32768 bytes, sha256

    99900247abc5cff8f12fed900e4ebf783c7a7ecf8d689b4a5cccd85a8416451e

`make comprueba` lo verifica.

## Reproducirlo

    make comprueba    el sha256 del volcado
    make              trazado, listado, reensamblado byte a byte, comprobaciones y tests
    make densidad     cuántas instrucciones llevan comentario
    make imagenes     dibuja las imágenes desde la ROM
    make vram         y las coteja contra la VRAM del emulador
    make web          regenera la web

## Lo que apareció

- **El rival no calcula el golpe: lo ensaya.** 0x5BB4 juega el golpe entero con
  la física de verdad, mira dónde ha caído la bola, cambia palo, fuerza, curva o
  puntería y lo vuelve a tirar, hasta que le gusta. Sólo entonces lo repite
  delante del jugador.
- **El terreno se decide por el píxel**, no por la casilla: 0x63B1 lee de la
  VRAM el bit exacto que hay bajo la bola y 0x63D3 su nibble de color.
- **La honra del golf está programada**: 0x46FA mide las dos distancias y hace
  jugar al que está más lejos del hoyo.
- **Tres pantallas enteras a la vez en la VRAM** (0x1800, 0x1C00 y 0x3C00), que
  se cambian conmutando el registro 2 del VDP.
- **Treinta y cinco profesionales reales** en 0x5009 —Nicklaus, Ballesteros,
  Trevino, Watson, Norman, Aoki, los dos Ozaki— con el terminador en el bit 7
  del último carácter.
- **Un editor de campos completo dentro** (`GAME >>CONSTRUCTION`), que es el
  programa CONST de la cinta *Hole In One Extension Course* de 1985: 3.050
  bytes en común.
- **Y el fichero que graba es el del cartucho de 1984**: la misma cabecera de
  veintiún bytes y las mismas distancias, así que un campo hecho aquí se carga
  en el *Hole in One* del 84 con `CALL GOLF`.

Hay más, con direcciones, en
[la web](https://antxiko.github.io/HoleInOnePro-disassembly/es/).

## Licencia

Las herramientas, los comentarios y la documentación son MIT (ver `LICENSE`). El
juego no: su código, sus gráficos y su sonido siguen siendo de sus autores y de
HAL Laboratory. Ver `AVISO-LEGAL.md`.
