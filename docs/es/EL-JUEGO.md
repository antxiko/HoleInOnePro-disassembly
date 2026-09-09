# El juego

*Hole in One Professional* es la segunda vuelta de HAL sobre su golf de 1984.
Donde aquél tenía un campo, éste tiene dos; donde aquél cargaba campos de cinta,
éste trae **un editor dentro**; y donde aquél te dejaba jugar solo o contra otro,
éste te sienta enfrente a treinta y cinco profesionales de verdad.

## El menú

Cuatro líneas, y las cuatro salen del binario:

| línea | variable | valores |
|---|---|---|
| PLAYER | 0xC003 | 1 o 2 |
| LEVEL | 0xC007 | AVERAGE · EXPERT · PROFESSIONAL |
| GAME | 0xC005 | STROKE PLAY · MATCH PLAY · TOURNAMENT · CONSTRUCTION |
| COURSE | 0xC004 | QUEEN SIDE · KING SIDE · USER |

`USER` sólo aparece si hay un campo de usuario cargado: 0x40EF y 0x40FD miran
(0xCED3) y, si está a cero, tratan la línea como si tuviera dos valores en vez
de tres.

Y el nivel no es sólo cosmética. Decide la velocidad de las barras de fuerza y
curva (0x560A: uno en AVERAGE, dos en PROFESSIONAL), la anchura de la ventana de
acierto (0x53B1 usa una ventana por palo en AVERAGE y una por cada dos palos de
EXPERT en adelante), la dispersión al salir del rough (0x584C: 0x26 contra 0x40)
y la fuerza del viento (0x7073 le quita el bit 6 en AVERAGE).

## Los dos campos

| campo | par | longitud | pares 3 | pares 4 | pares 5 |
|---|---|---|---|---|---|
| QUEEN SIDE | 72 | 6.166 m | 4 | 10 | 4 |
| KING SIDE | 72 | 6.290 m | 4 | 10 | 4 |

Mismo par y mismo reparto, y sin embargo treinta y seis hoyos distintos. KING
SIDE es más largo y, mirándolos, bastante más duro: más agua, calles más
estrechas y mucho más negro —que es la casilla 0x00, y el juego la trata como
fuera de límites—.

Los treinta y seis guiones ocupan 11.193 bytes en total, 311 de media por hoyo.

## El golpe

Tres pasos, y los tres son la misma máquina con distintos topes:

1. **la puntería**, que la cruceta gira grado a grado (0x54AF);
2. **la fuerza**, una barra que sube y baja entre 0 y 0x1C y que el disparo
   para (0x55E6);
3. **la curva**, otra barra entre 0 y 0x38 (0x5676).

La fuerza que sale de la barra no es la que se usa: la de verdad es
`(0xC641) × 8 + 0x1F`, o sea que hay un mínimo que no se puede quitar. Y lo que
decide si la bola sale recta es la ventana de 0x5495: dos bytes por palo, el
límite de abajo y el de arriba. Si la barra de curva se para por debajo del
primero, la diferencia se guarda como **gancho**; por encima del segundo, como
**slice**. Luego, durante el vuelo, 0x58F0 va torciendo el ángulo un grado cada
tantos cuadros.

Con el putter no hay barra de curva: 0x539F sólo la juega si el palo es menor
que 13.

## Los quince palos

    1W 2W 3W 4W | 3I 4I 5I 6I | 7I 8I 9I | PW SW PT PT

Tres bytes por palo en 0x4B16: el primero agrupa el swing —0x00 las maderas,
0x04 y 0x08 los hierros, 0x0C los wedges y el putter— y los otros dos son las
dos letras del rótulo. La última entrada repite PT, y no es un descuido: en el
campo se puede elegir el palo 13 y en el green el juego fuerza el 14 (0x5589).

Y esa misma tabla, byte a byte, está en el fichero CONST de la cinta *Hole In
One Extension Course* de 1985.

## Los modos

- **STROKE PLAY**: se cuentan golpes y ya está.
- **MATCH PLAY**: se cuentan hoyos ganados. 0x43BD lleva la ventaja (0xC074) y
  quién la tiene (0xC073), y cuando la ventaja pasa de los hoyos que quedan, el
  partido se acaba con su «3 AND 2» escrito a mano en 0x4451.
- **TOURNAMENT**: treinta y seis participantes, treinta y cinco de ellos
  profesionales reales, con clasificación en vivo.
- **CONSTRUCTION**: el editor. Tiene [su propia página](EL-EDITOR.html).

## Las teclas

| tecla | qué hace |
|---|---|
| F1 | enseña el marcador de dieciocho hoyos |
| F2 | la clasificación del torneo (con las flechas se pasa página) |
| F10 y luego F6 | vuelve al menú |
| STOP | cancela el golpe que se está preparando |

F1 y F2 no redibujan nada: cambian el registro 2 del VDP para enseñar otra tabla
de nombres que ya estaba montada.
