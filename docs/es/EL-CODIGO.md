# El código

Cómo está hecho el listado y por qué se puede confiar en él.

## El listado se genera

Nadie edita el `.asm`. Lo genera `tools/mkasm.py` a partir de tres cosas:

- el **trazado de flujo** (`tools/z80trace.py`), que sigue el código desde los
  puntos de entrada y marca qué bytes son instrucciones;
- el fichero de **notas**, con los comentarios anclados a dirección;
- y las **zonas de datos** declaradas, para que el trazador no se meta en ellas.

Así los comentarios sobreviven a un retrazado: si mañana se descubre que un
bloque era código, se retraza y los comentarios siguen en su sitio.

## Lo que decide: reensamblar

    make verify

ensambla el listado con pasmo y compara el resultado con la ROM. Byte a byte, el
mismo sha256. Sin eso, todo lo demás sobra.

## Lo que el reensamblado NO caza

Reensamblar no distingue entre unos bytes leídos como código y los mismos bytes
leídos como datos: el binario sale igual. Por eso hay tres comprobaciones más:

- **ninguna zona declarada como datos puede salir como código**;
- **ningún punto de entrada puede caer dentro de una zona de datos**;
- y el **presupuesto**: cada uno de los 32.768 bytes tiene que ser código
  alcanzado o un bloque de datos con nombre y explicación. Ahora mismo,
  **cero sin explicar**.

## Los puntos de entrada que no se deducen

El trazado estático no llega a todo. Los que hay que declarar a mano están en
`src/holeinonepro.entries`, cada uno con su justificación:

- **0x665B**, el manejador de interrupción, porque el gancho de H.TIMI es una
  llamada entre ranuras y no un salto.
- **Las diez entradas de la tabla de 0xAFAD**, que dos `jp (hl)` usan para
  despachar los estados del editor.
- **Las ocho rutinillas del menú** (0x40E6–0x4116), a las que no se llega con un
  salto: 0x40A6 saca la dirección de una tabla, la mete en la pila y hace `ret`.
- **Las cuatro de la tabla de 0xB2A4**, el submenú de elegir casilla.
- **Tres rutinas de la zona de cinta** (0xBE0E, 0xBE63, 0xBE7C), que se alcanzan
  metiéndolas en la pila.
- Y **0xB885**, que no la llama nadie: es código muerto, y se declara para que
  salga desensamblado y se pueda leer.

## Los números

| | |
|---|---|
| código trazado | 14.186 bytes (43,3 %) |
| datos identificados | 18.582 bytes (56,7 %) |
| sin explicar | **0** |
| instrucciones | 7.133 |
| comentarios de línea | 3.169 |
| densidad | **44,4 %** |
| rutinas por debajo del 10 % | **0** |
| destinos de `call` sin bautizar | **0** |

Los tres últimos son el listón de la serie, y los tres están cerrados.

## La biblioteca de cálculo

En 0x6485–0x6564 hay una biblioteca pequeña y bien hecha, y en 0x6564 la rutina
que le monta las tablas en RAM al arrancar:

- **cuadrados**: 0xC200 y 0xC300, los cuadrados de 0 a 255 en dos bytes. Se
  calculan llamando 256 veces a la multiplicación.
- **raíz cuadrada** (0x64A2): búsqueda binaria bit a bit contra esa misma tabla.
- **arcotangente**: 0xC500–0xC600, 256 entradas con valores de 0 a 32, o sea de
  0 a 45 grados. En la ROM está **comprimido por longitud de racha**: treinta y
  tres cuentas en 0x65A2 que suman exactamente 256.
- **seno y coseno**: 0xC400–0xC500. En la ROM hay un cuarto de onda de 64 bytes
  (0x65C3) que 0x658C lee **hacia atrás** escribiendo a la vez hacia arriba y
  hacia abajo —o sea, reflejándolo— y luego copia las dos mitades.
- **multiplicación con signo** (0x651F y 0x6524), de 8×8 a 16 bits.

Con eso se hace todo: el ángulo entre dos puntos, la distancia, la
descomposición de la velocidad en sus dos componentes y el rozamiento.

## El sonido

Doce pistas de PSG, con la tabla de punteros en 0x6B55 y el intérprete en
0x6B83, que corre una vez por interrupción.

Las reglas, leídas del código: un byte con el bit 7 o el 6 puestos es una
**nota** —los seis bits de abajo indexan, por dos, la tabla de tonos de
0x6C0D—; con el bit 5 a cero es una **espera** en cuadros; y el resto son
órdenes: `0x2D` guarda la forma de envolvente, `0x33` es un **salto**, `0x3D` es
la **parada** y `0x3E` pone a cero los registros 0 a 5.

Dónde acaba cada pista no está escrito. Siguiéndolas con ese mismo intérprete
(`tools/pistas.py`) salen doce tiras que encajan sin un hueco, y aparecen dos
cosas: **cinco pistas comparten cola** —la 5 desemboca en la 6, la 6 en la 0, la
0 en la 1, la 1 en la 7, y las cinco acaban en la misma parada de 0x6D7A— y la
**11 es la única que da vueltas**, porque acaba en un salto a sí misma. La nota
más alta que usan las doce es la 43, que es justo donde acaba la tabla de tonos.

> Esta lectura reproduce el intérprete del cartucho, pero **no** está
> contrastada con el emulador. Los límites están medidos; que suene lo que aquí
> se dice, no se afirma.
