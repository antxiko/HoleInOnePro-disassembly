# Preguntas abiertas

Lo que no está cerrado, dicho como lo que es.

## La ventana de curva del putter se sale de la tabla

La tabla de 0x5495 tiene **trece** parejas —límite de abajo y de arriba de la
barra de curva—, una por palo, y el cartucho tiene **quince** palos: los dos
últimos son el putter.

En el nivel AVERAGE el índice es el palo por dos, así que con el palo 13 la
lectura cae en 0x54AF y con el 14 en 0x54B1, o sea **dentro del código** que
empieza justo detrás de la tabla. Los bytes que salen son (0x3A, 0x34) y
(0xCA, 0xFE), y como la barra no pasa de 0x1C, la comparación siempre da el
mismo lado.

Está medido y es lo que hace el código. Lo que **no** está comprobado es si eso
se nota jugando: 0x539F no juega la barra de curva con el putter, así que puede
que el valor que sale de ahí no llegue a usarse nunca. Haría falta seguirlo en
el emulador.

En EXPERT y PROFESSIONAL el índice es el palo entre dos, y entonces sí cae
dentro de la tabla.

## Las tres primeras tablas de palos también son de trece

Lo mismo pasa en 0x6437. Hay cuatro tablas seguidas: frenado (0x6437),
duración de la subida (0x6444) y alcance (0x6451) tienen **trece** entradas, y
la de velocidad de salida (0x645E) tiene **quince** —ahí sí están los dos
putters, 0x1E y 0x7F—.

0x587A y 0x5880 leen las dos primeras para cualquier palo, incluidos los
putters, así que con el putter leen de la tabla de al lado. Pero 0x58A3 se va
por otro camino antes de usarlas, y no está comprobado que lo que quedó en
(0xC61C) y (0xC61A) llegue a importar.

## El sonido no está escuchado

Las doce pistas están seguidas con el intérprete del propio cartucho y sus
límites encajan sin un hueco, pero nadie ha comparado lo que suena con lo que
esta lectura dice que debería sonar. Los límites son medidos; la música, no.

## El editor no se ha probado entero

Los rótulos, los sellos, la lista de casillas y el formato del fichero salen del
código y del binario. Lo que no se ha hecho es grabar un campo con el editor,
cargarlo en el *Hole in One* de 1984 y jugarlo. Que el fichero tiene la misma
cabecera y las mismas distancias está medido byte a byte; que se juegue, no.

## Los dos bytes de 0x40DC

Entre las tres tablas del menú hay dos bytes que ninguna alcanza. Leídos como
puntero darían 0x4E41, que es una dirección de código pero no una a la que lleve
nada. Puede ser una entrada de una versión anterior del menú, o relleno.

## El byte suelto de la tabla de tonos

La tabla de tonos de 0x6C0D tiene sitio para 44 notas y la más alta que usan las
doce pistas es la 43. Queda un byte, 0x6C65, que nadie lee. Igual que el de
0x6CD7, entre la pista 2 y la 4.

## Y una que sí está cerrada

Al empezar este desensamblado quedaba abierto por qué 0xBE32 hace `call
072d4h`, una dirección que cae dentro de los guiones de campo. Ya no: la
instrucción de antes cambia la página 1 por la ROM de BASIC, y 0x72D4 es una
rutina de casete **suya**. Está contado en [Hallazgos](HALLAZGOS.html).
