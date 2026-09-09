; ==========================================================================
; HOLE IN ONE PROFESSIONAL - HAL Laboratory - MSX1 - cartucho de 32 KB en las paginas 1 y 2
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; Etiquetas que no caen en ninguna posicion emitida del listado
; (destinos fuera del binario o dentro de una instruccion).
; ----------------------------------------------------------------------
L_64A8:	equ 0x064a8
L_66D5:	equ 0x066d5
L_6FD7:	equ 0x06fd7
L_700B:	equ 0x0700b

; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
lba7dh:	equ 0x0ba7d

; ----------------------------------------------------------------------
; DATOS cabecera_ab: Cabecera AB: firma 'AB', INIT=0x4010, y STATEMENT, DEVICE
;   y TEXT a cero mas seis bytes de relleno
;   0x4000..0x4010  (16 bytes)
DATA_cabecera_ab:
	defb 041h,042h,010h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............

; ======================================================================
; CODIGO 0x4010..0x40cc  (188 bytes)
; ======================================================================


init:		; Punto de entrada unico: lo llama la BIOS al arrancar
	call 00138h		;4010   ; BIOS RSLREG - Reads the primary slot register | lo primero es averiguar en que ranura esta el propio cartucho
	rrca			;4013   ; RSLREG devuelve los cuatro pares de bits; los dos de la pagina 1 se bajan a los de abajo
	rrca			;4014
	and 003h		;4015   ; y se quedan los dos bits de la ranura primaria
	ld c,a			;4017
	ld b,000h		;4018
	ld hl,0fcc1h		;401a   ; 0xFCC1 es SLTTBL: si la ranura es expandida, dice que subranura hay puesta
	add hl,bc			;401d
	or (hl)			;401e   ; mezcla el numero de ranura con el de subranura
	ld c,a			;401f
	inc hl			;4020   ; cuatro adelante para llegar al byte de la pagina 2
	inc hl			;4021
	inc hl			;4022
	inc hl			;4023
	ld a,(hl)			;4024
	and 00ch		;4025   ; de la pagina 2 solo interesan los dos bits de subranura
	or c			;4027
	ld (0fedbh),a		;4028   ; y el resultado se guarda en 0xFEDB para todo lo que venga despues
	di			;402b   ; a partir de aqui no puede saltar la interrupcion
	ld sp,0f380h		;402c   ; la pila, justo debajo de la RAM de trabajo
	ld a,(0fedbh)		;402f
	ld hl,08000h		;4032   ; mete el propio cartucho en la pagina 2, que es donde vive su segunda mitad
	call 00024h		;4035   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c002h		;4038   ; borra de una tirada 0xC002-0xF300: toda la RAM de trabajo
	ld de,0c003h		;403b
	ld bc,032ffh		;403e
	ld (hl),000h		;4041
	ldir		;4043
	ld hl,0716bh		;4045   ; el campo de fabrica es QUEEN SIDE, o sea la tabla de 0x716B
	ld (0c000h),hl		;4048
	ld a,012h		;404b   ; 0x12 es +18: un golpe por encima del par en cada uno de los dieciocho hoyos
	ld (0c060h),a		;404d
	ld hl,0c0f6h		;4050   ; y 0xC0F6-0xC111 se rellena de espacios, que es donde van los nombres del torneo
	ld de,0c0f7h		;4053
	ld bc,0001bh		;4056
	ld (hl),020h		;4059
	ldir		;405b
	call L_6B21		;405d   ; deja el reproductor de PSG en reposo
	call L_6603		;4060   ; engancha la interrupcion en H.TIMI
	call L_6564		;4063   ; monta en RAM las tablas que la fisica del golpe lee por indice
L_4066:
	call L_6734		;4066   ; la exhibicion: el cartucho juega solo hasta que alguien toca el mando
L_4069:
	ld sp,0f380h		;4069   ; vuelta al menu: la pila se rehace porque se llega aqui desde cualquier sitio
	call esconde_los_sprites		;406c   ; pone el generador de azar en marcha
	call L_5175		;406f   ; los creditos, y detras la exhibicion de los dieciocho hoyos
	ld hl,05224h		;4072   ; 0x5224 es el texto del menu con sus valores de fabrica
	call L_51BF		;4075
	call L_52DE		;4078   ; y pinta los cuatro rotulos elegidos
L_407B:
	call L_6666		;407b   ; espera a que suelten el disparo antes de entrar al menu
	call L_6A4F		;407e
	jr nz,L_407B		;4081
L_4083:
	call L_4CD0		;4083   ; el bucle del menu
	call L_6A4F		;4086   ; disparo: empieza la partida
	jp nz,empieza_la_partida		;4089
	call L_6A6F		;408c   ; lee la cruceta, ya filtrada contra la repeticion
	srl a		;408f   ; el bit 0 dice si hay direccion; lo que queda arriba dice cual
	jr nc,L_4083		;4091
	ld hl,0c002h		;4093   ; 0xC002 es la linea del cursor, de 0 a 3
	jr z,L_40BA		;4096   ; codigo 1: baja el cursor
	dec a			;4098   ; codigo 3: sube el valor de la linea
	jr z,L_40A3		;4099
	dec a			;409b   ; codigo 5: sube el cursor
	jr z,L_40B8		;409c
	ld hl,040cch		;409e   ; cualquier otra direccion baja el valor: tabla de las rutinas que restan
	jr L_40A6		;40a1
L_40A3:
	ld hl,040d4h		;40a3   ; y esta es la de las que suman
L_40A6:
	ld a,(0c002h)		;40a6   ; el indice de las tres tablas es la linea del cursor
	call saca_de_tabla		;40a9   ; saca de la tabla la rutina que toca
	push de			;40ac   ; se guarda en la pila: el RET de abajo saltara a ella
	ld hl,040deh		;40ad   ; y de la tercera tabla, sobre que variable trabaja
	ld a,(0c002h)		;40b0
	call saca_de_tabla		;40b3
	ex de,hl			;40b6   ; HL queda apuntando a la variable
	ret			;40b7   ; y este RET es en realidad el salto a la rutina de la opcion
L_40B8:
	inc (hl)			;40b8   ; subir el cursor es sumar uno, o sea dos INC y el DEC de abajo
	inc (hl)			;40b9
L_40BA:
	dec (hl)			;40ba   ; baja el cursor y lo enmascara: da la vuelta de 3 a 0
	ld a,(hl)			;40bb
	and 003h		;40bc
	ld (hl),a			;40be
L_40BF:
	call L_52DE		;40bf   ; repinta los cuatro rotulos con el valor nuevo
L_40C2:
	call L_6666		;40c2   ; y espera a que suelten la cruceta antes de admitir otra
	call L_6A6F		;40c5
	jr nz,L_40C2		;40c8
	jr L_4083		;40ca

; ----------------------------------------------------------------------
; DATOS menu_baja: Cuatro punteros: la rutina que BAJA el valor de cada linea
;   del menu (0x40E6, 0x40F5, 0x410D y 0x40EF)
;   0x40cc..0x40d4  (8 bytes)
DATA_menu_baja:
	defw 040e6h,040f5h,0410dh,040efh	; 40cc  -> menu_alterna_baja menu_nivel_baja menu_modo_baja menu_campo_baja

; ----------------------------------------------------------------------
; DATOS menu_sube: Cuatro punteros: la rutina que SUBE el valor de cada linea
;   (0x40E8, 0x4103, 0x410F y 0x40FD)
;   0x40d4..0x40dc  (8 bytes)
DATA_menu_sube:
	defw 040e8h,04103h,0410fh,040fdh	; 40d4  -> menu_alterna_sube menu_nivel_sube menu_modo_sube menu_campo_sube

; ----------------------------------------------------------------------
; DATOS menu_cola: Dos bytes que ninguna de las tres tablas alcanza; leidos
;   como puntero darian 0x4E41
;   0x40dc..0x40de  (2 bytes)
DATA_menu_cola:
	defb 041h,04eh	; 40dc

; ----------------------------------------------------------------------
; DATOS menu_variables: Cuatro punteros a RAM: sobre que variable trabaja cada
;   linea (0xC003, 0xC007, 0xC005 y 0xC004)
;   0x40de..0x40e6  (8 bytes)
DATA_menu_variables:
	defw 0c003h,0c007h,0c005h,0c004h	; 40de

; ======================================================================
; CODIGO 0x40e6..0x4842  (1884 bytes)
; ======================================================================


menu_alterna_baja:		; Alterna 1 y 2 jugadores: resta uno y enmascara con 1
	dec (hl)			;40e6   ; restar uno y enmascarar con 1 es alternar entre 1 y 2 jugadores
	dec (hl)			;40e7
menu_alterna_sube:		; Alterna 1 y 2 jugadores: suma uno y enmascara con 1
	inc (hl)			;40e8
	ld a,(hl)			;40e9
	and 001h		;40ea
	ld (hl),a			;40ec
	jr $-46		;40ed   ; vuelve a 0x40BF a repintar
menu_campo_baja:		; Baja COURSE; si no hay campo de usuario cae en la version de dos valores
	ld a,(0ced3h)		;40ef   ; si (0xCED3) esta a cero no hay campo de usuario
	and a			;40f2
	jr z,menu_alterna_baja		;40f3   ; y entonces COURSE solo tiene dos valores: se trata como un alternador
menu_nivel_baja:		; Baja LEVEL entre 0 y 2, dando la vuelta por arriba
	dec (hl)			;40f5   ; baja el nivel
	jp p,L_40BF		;40f6   ; si no se ha pasado por debajo de cero, ya esta
	ld (hl),002h		;40f9   ; y si se ha pasado, da la vuelta a PROFESSIONAL
	jr $-60		;40fb
menu_campo_sube:		; Sube COURSE; si no hay campo de usuario cae en la version de dos valores
	ld a,(0ced3h)		;40fd   ; lo mismo por arriba: sin campo de usuario, COURSE alterna
	and a			;4100
	jr z,menu_alterna_sube		;4101
menu_nivel_sube:		; Sube LEVEL entre 0 y 2, dando la vuelta por abajo
	inc (hl)			;4103   ; sube el nivel
	ld a,(hl)			;4104
	cp 003h		;4105   ; tres niveles: 0, 1 y 2
	jr c,$-72		;4107
	ld (hl),000h		;4109   ; y del tercero se vuelve al primero
	jr $-76		;410b
menu_modo_baja:		; Baja GAME, enmascarado con 3
	dec (hl)			;410d   ; cuatro modos de juego, asi que basta con enmascarar con 3
	dec (hl)			;410e
menu_modo_sube:		; Sube GAME, enmascarado con 3
	inc (hl)			;410f
	ld a,(hl)			;4110
	and 003h		;4111   ; y la mascara le da la vuelta sola en los dos sentidos
	ld (hl),a			;4113
	jr $-85		;4114
empieza_la_partida:		; Arranca la vuelta: pone a cero el estado, elige campo y jugadores, y si GAME es CONSTRUCTION se va al editor
	xor a			;4116   ; borra las banderas de la vuelta anterior
	ld (0c011h),a		;4117
	ld (0c006h),a		;411a
	ld (0c117h),a		;411d
	ld (0c009h),a		;4120
	ld a,004h		;4123   ; 0xC119 es la cadencia del contador de fuerza; 4 es la de fabrica
	ld (0c119h),a		;4125
	ld a,(0c005h)		;4128   ; GAME a 3 es CONSTRUCTION
	cp 003h		;412b
	jp z,L_AEA3		;412d   ; y eso no es una partida: se va al editor de campos
	ld a,(0c004h)		;4130   ; COURSE elige entre los dos campos del cartucho y el de RAM
	and a			;4133
	ld hl,0716bh		;4134   ; 0x716B son los dieciocho punteros de QUEEN SIDE
	jr z,L_4142		;4137
	ld hl,0718fh		;4139   ; 0x718F los de KING SIDE, justo detras
	dec a			;413c
	jr z,L_4142		;413d
	ld hl,0cf97h		;413f   ; y 0xCF97 el campo de usuario, que vive en RAM
L_4142:
	ld (0c000h),hl		;4142   ; (0xC000) queda apuntando al campo elegido para toda la vuelta
	ld a,(0c003h)		;4145   ; PLAYER a 1 quiere decir dos jugadores
	ld (0c008h),a		;4148
	and a			;414b
	jr nz,L_415B		;414c   ; con dos jugadores no hay ordenador que juegue
	ld a,(0c005h)		;414e   ; y en STROKE PLAY tampoco
	and a			;4151
	jr z,L_415B		;4152
	ld a,001h		;4154   ; pero en MATCH PLAY y TOURNAMENT con un jugador el rival lo lleva la maquina
	ld (0c008h),a		;4156
	jr L_415D		;4159
L_415B:
	ld a,0ffh		;415b   ; 0xFF en 0xC116 quiere decir que ningun jugador es la maquina
L_415D:
	ld (0c116h),a		;415d   ; y si lo hay, 0xC116 guarda cual
	ld a,(0c005h)		;4160   ; GAME a 2 es TOURNAMENT
	cp 002h		;4163
	jr nz,L_418B		;4165
	ld hl,052c2h		;4167   ; 0x52C2 es la pantalla del torneo, con las dos lineas de nombre
	call L_51BF		;416a
	ld a,001h		;416d
	ld (0c113h),a		;416f
	call L_BAAF		;4172   ; pide el nombre del jugador 1
	ld a,002h		;4175
	ld (0c113h),a		;4177
	ld a,(0c003h)		;417a   ; y el del 2 solo si hay dos jugadores
	and a			;417d
	jr z,L_4185		;417e
	call L_BAAF		;4180
	jr L_4188		;4183
L_4185:
	call L_4F4A		;4185   ; si no, la maquina se monta su cuadro de rivales
L_4188:
	call L_4CF3		;4188   ; y se ordena la clasificacion de salida
L_418B:
	call L_6636		;418b   ; monta SCREEN 2 y decomprime todo lo que va en VRAM
	call L_6734		;418e   ; la segunda tabla de nombres, la de 0x1C00, con el marcador
	call L_4DEC		;4191
	call L_49D8		;4194   ; y los numeros de hoyo del marcador
	call 00044h		;4197   ; BIOS ENASCR - Displays the screen
	ld a,002h		;419a   ; la musica de la vuelta
	call L_6B2D		;419c
	xor a			;419f   ; a partir de aqui, todos los contadores de la partida a cero
	ld l,a			;41a0
	ld h,a			;41a1
	ld (0c05ch),hl		;41a2
	ld (0c05eh),hl		;41a5
	ld (0c064h),hl		;41a8
	ld (0c066h),hl		;41ab
	ld (0c068h),hl		;41ae
	ld (0c06ah),hl		;41b1
	ld (0c009h),a		;41b4
	ld (0c00ah),a		;41b7
	ld (0cec3h),a		;41ba   ; 0xCEC3 es el hoyo, de 0 a 17
	ld (0c075h),hl		;41bd
	ld (0c074h),a		;41c0
	ld (0c117h),hl		;41c3
	dec a			;41c6   ; 0xFF en 0xC072 y 0xC073: en MATCH PLAY todavia no hay quien vaya ganando
	ld (0c072h),a		;41c7
	ld (0c073h),a		;41ca
	call L_67EF		;41cd   ; escribe el panel de la izquierda
	ld a,(0c008h)		;41d0
	and a			;41d3
	jr nz,L_41E2		;41d4
	ld hl,01862h		;41d6   ; con un solo jugador se tapan las dos lineas del segundo
	call L_4CC8		;41d9
	ld hl,018e2h		;41dc
	call L_4CC8		;41df
L_41E2:
	xor a			;41e2   ; empieza el hoyo: los golpes y el desnivel a cero
	ld l,a			;41e3
	ld h,a			;41e4
	ld (0c014h),hl		;41e5
	ld (0c062h),hl		;41e8
	ld (0c011h),a		;41eb
	ld (0c00bh),hl		;41ee
	ld (0c071h),a		;41f1
	ld (0c11ah),a		;41f4
	call L_4BE7		;41f7   ; borra el rotulo de distancia
	call L_486F		;41fa   ; pinta el marcador
	call monta_el_hoyo		;41fd   ; monta el hoyo en el buffer de RAM
	call L_6843		;4200   ; y lo vuelca a la VRAM con el barrido de arriba abajo
	ld hl,0c00dh		;4203   ; 0xC00D-0xC010 arrancan en la bandera: los dos jugadores salen apuntando a ella
	ld a,(0cec5h)		;4206
	ld (hl),a			;4209
	inc hl			;420a
	ld (hl),a			;420b
	inc hl			;420c
	ld a,(0cec4h)		;420d
	ld (hl),a			;4210
	inc hl			;4211
	ld (hl),a			;4212
	ld de,04caeh		;4213   ; 0x4CAE es DORMY HOLE, que solo se enseña si (0xC076) lo pide
	ld a,(0c076h)		;4216
	and a			;4219
	call nz,L_4BF5		;421a
L_421D:
	call L_46FA		;421d   ; empieza el golpe: decide a quien le toca
	call L_4A75		;4220   ; y pone el rotulo del hoyo y el par
	ld a,(0c009h)		;4223   ; 0xC009 es el jugador que juega
	ld iy,0c00bh		;4226   ; IY apunta a su estado: 0xC00B el jugador 1, 0xC00C el 2
	and a			;422a
	jr z,L_422F		;422b
	inc iy		;422d
L_422F:
	ld a,(iy+000h)		;422f   ; estado 2 es "en el green"
	cp 002h		;4232
	ld a,000h		;4234
	jr nz,L_4239		;4236
	inc a			;4238
L_4239:
	ld (0c011h),a		;4239   ; y entonces (0xC011) se pone a uno: se juega la vista de putt
	inc (iy+057h)		;423c   ; un golpe mas para este jugador
	call L_486F		;423f   ; repinta el marcador
	call L_46ED		;4242   ; y la vista que toque, campo o green
	call L_4A8D		;4245
	call L_4777		;4248   ; coloca la bola donde este
	ld a,(0c009h)		;424b
	call L_4748		;424e   ; apunta a la bandera
	call L_478D		;4251   ; guarda el punto de mira de partida
	call L_479A		;4254   ; y calcula la distancia que queda
	ld a,(iy+009h)		;4257   ; (IY+9) es el palo con el que jugo la ultima vez
	ld (0c621h),a		;425a
	xor a			;425d
	ld (0c117h),a		;425e
	ld a,(0c009h)		;4261   ; si el que juega es la maquina...
	ld hl,0c116h		;4264
	cp (hl)			;4267
	jr nz,L_42A0		;4268
	ld a,(iy+057h)		;426a   ; a partir del septimo golpe la maquina afloja el ritmo del contador
	cp 007h		;426d
	jr c,L_4276		;426f
	ld a,006h		;4271
	ld (0c119h),a		;4273
L_4276:
	ld a,001h		;4276   ; 0xC118 avisa a la rutina del golpe de que no hay que leer el mando
	ld (0c118h),a		;4278
	ld a,(0c011h)		;427b   ; en el green la maquina putea con otra rutina
	and a			;427e
	jr nz,L_428F		;427f
	call el_rival_prepara_el_golpe		;4281   ; la maquina elige palo, direccion y fuerza
	ld hl,0c062h		;4284
	ld a,(0c65fh)		;4287
	ld (0c660h),a		;428a
	jr L_4292		;428d
L_428F:
	call L_6091		;428f   ; y en el green, solo fuerza y direccion
L_4292:
	xor a			;4292
	ld (0c118h),a		;4293
	inc a			;4296
	ld (0c117h),a		;4297
	ld a,(0c667h)		;429a   ; el palo que ha elegido
	ld (0c621h),a		;429d
L_42A0:
	call juega_un_golpe		;42a0   ; la mecanica del golpe: contador de fuerza, curva y salida de la bola
	ld a,(0c621h)		;42a3
	ld (iy+009h),a		;42a6
	ld a,(0c011h)		;42a9   ; en el green se salta todo el vuelo de la bola
	and a			;42ac
	jp nz,L_4491		;42ad
	ld hl,(0c63fh)		;42b0   ; si la bola no se ha movido de donde estaba...
	ld a,(0c60eh)		;42b3
	cp l			;42b6
	jr nz,L_42C0		;42b7
	ld a,(0c611h)		;42b9
	cp h			;42bc
	jp z,L_448C		;42bd   ; ...es que ha entrado: hoyo acabado
L_42C0:
	xor a			;42c0   ; vuelo terminado, a ver donde ha caido
	ld (0c613h),a		;42c1
	call pinta_los_sprites		;42c4   ; recoloca la camara
	call L_6696		;42c7   ; espera un poco
	call L_9E0B		;42ca   ; devuelve la vista normal
	call L_629C		;42cd   ; redibuja la escena
	ld a,(0c633h)		;42d0   ; 0xC633 y 0xC635 son las banderas de "ha entrado" y "se ha ido fuera"
	ld b,a			;42d3
	ld a,(0c635h)		;42d4
	or b			;42d7
	jr nz,L_4326		;42d8
	ld a,(0c638h)		;42da   ; 0xC638 dice que ha caido en el agua
	and a			;42dd
	jr nz,L_42FE		;42de
	ld a,(0c637h)		;42e0   ; 0xC637, que ha llegado al green
	and a			;42e3
	jr nz,L_4353		;42e4
	ld a,(0c636h)		;42e6   ; 0xC636, que ha caido en bunker
	and a			;42e9
	jr nz,L_4307		;42ea
	ld de,04c6bh		;42ec   ; 0x4C6B es FAIRWAY
	ld a,(0c639h)		;42ef   ; y 0xC639 distingue la calle del rough
	and a			;42f2
	jr z,L_42F8		;42f3
	ld de,04c73h		;42f5   ; 0x4C73 es ROUGH
L_42F8:
	call L_4BF5		;42f8
	jp L_4398		;42fb
L_42FE:
	ld de,04c7bh		;42fe   ; 0x4C7B es BUNKER
	call L_4BF5		;4301
	jp L_4398		;4304
L_4307:
	ld a,(0c62ch)		;4307   ; el agua: la bola vuelve al punto de caida marcado
	ld (0c60eh),a		;430a
	ld a,(0c62dh)		;430d
	ld (0c611h),a		;4310
	ld a,001h		;4313   ; y se apunta que hay penalizacion
	ld (0c11ah),a		;4315
	inc (iy+057h)		;4318   ; el golpe de castigo
	ld de,04c83h		;431b   ; 0x4C83 es WATER HAZARD
	call L_4BF5		;431e
	call pinta_los_sprites		;4321
	jr L_4398		;4324
L_4326:
	call 00090h		;4326   ; BIOS GICINI - Initialises PSG and sets initial value for the PLAY statement | fuera de limites: se corta el sonido
	call esconde_la_bola		;4329
	ld a,001h		;432c
	ld (0c11ah),a		;432e
	ld de,04c91h		;4331   ; 0x4C91 es OB
	call L_4BF5		;4334
	ld a,(0c012h)		;4337   ; y la bola vuelve al sitio desde el que se golpeo
	ld (0c60eh),a		;433a
	ld a,(0c013h)		;433d
	ld (0c611h),a		;4340
	inc (iy+057h)		;4343   ; con su golpe de castigo
	xor a			;4346
	ld (0c613h),a		;4347
	ld a,(iy+000h)		;434a
	and a			;434d
	call nz,pinta_los_sprites		;434e
	jr L_4398		;4351
L_4353:
	ld (iy+000h),002h		;4353   ; estado 2: la bola esta en el green
	call L_47DF		;4357   ; pasa el punto de mira a las coordenadas del green
	call L_9E0B		;435a
	ld de,04c96h		;435d   ; 0x4C96 es ON, y detras va el numero de golpes
	call L_4BFD		;4360
	ld a,(iy+057h)		;4363   ; los golpes que ha costado llegar
	ld hl,01a63h		;4366
	call L_4A4B		;4369
	call L_4BF8		;436c
	jr L_4398		;436f
L_4371:
	ld a,(iy+000h)		;4371   ; guarda el punto de caida para el proximo golpe
	and a			;4374
	jr nz,L_437A		;4375
	inc (iy+000h)		;4377
L_437A:
	call L_4777		;437a
	ld a,(0c60eh)		;437d
	ld (hl),a			;4380
	inc hl			;4381
	inc hl			;4382
	ld a,(0c611h)		;4383
	ld (hl),a			;4386
	ret			;4387
L_4388:
	ld a,(0c009h)		;4388   ; compara los dos jugadores: devuelve el signo de la diferencia
	ld hl,0c062h		;438b
	ld de,0c063h		;438e
	and a			;4391
	jr nz,L_4395		;4392
	ex de,hl			;4394
L_4395:
	ld a,(de)			;4395
	cp (hl)			;4396
	ret			;4397
L_4398:
	call L_4371		;4398   ; cierra el golpe y decide si sigue el mismo jugador
	ld a,(0c075h)		;439b   ; si la vuelta ya ha acabado, no hay mas golpes
	and a			;439e
	jr nz,L_43A8		;439f
	ld a,(0c005h)		;43a1   ; en STROKE PLAY se sigue golpeando sin mas
	dec a			;43a4
	jp nz,L_421D		;43a5
L_43A8:
	ld a,(0c071h)		;43a8   ; 0xC071 solo esta puesto en MATCH PLAY
	and a			;43ab
	jp z,L_421D		;43ac
	call L_4388		;43af   ; y hasta que los dos no acaben el hoyo no se cuenta
	jp c,L_421D		;43b2
	ld a,(0c009h)		;43b5   ; quien gana el hoyo es el que menos golpes ha dado
	xor 001h		;43b8
	ld (0c072h),a		;43ba
L_43BD:
	call esconde_los_sprites		;43bd   ; el tanteo del MATCH PLAY: quien va arriba y por cuantos
	ld a,(0c072h)		;43c0
	and a			;43c3
	jp m,L_43ED		;43c4
	ld hl,0c074h		;43c7   ; 0xC074 es la ventaja y 0xC073 quien la tiene
	ld a,(0c073h)		;43ca
	and a			;43cd
	jp m,L_43E5		;43ce
	ld b,a			;43d1
	ld a,(0c072h)		;43d2
	cp b			;43d5   ; si el hoyo lo gana el mismo que iba delante, sube la ventaja
	jr z,L_43E2		;43d6
	dec (hl)			;43d8   ; y si lo gana el otro, baja
	jr nz,L_43ED		;43d9
	ld a,0ffh		;43db   ; al llegar a cero el partido queda igualado
	ld (0c073h),a		;43dd
	jr L_43ED		;43e0
L_43E2:
	inc (hl)			;43e2
	jr L_43ED		;43e3
L_43E5:
	ld (hl),001h		;43e5   ; primer hoyo ganado: se abre la cuenta
	ld a,(0c072h)		;43e7
	ld (0c073h),a		;43ea
L_43ED:
	ld c,004h		;43ed   ; a partir de tres arriba la musica cambia
	ld a,(0c074h)		;43ef
	cp 003h		;43f2
	jr c,L_4400		;43f4
	ld a,(0c073h)		;43f6
	and a			;43f9
	ld c,006h		;43fa
	jr z,L_4400		;43fc
	ld c,002h		;43fe
L_4400:
	ld a,c			;4400
	ld (0c119h),a		;4401   ; la cadencia del contador de fuerza para el proximo golpe
	call L_486F		;4404
	call L_48F7		;4407   ; repinta el marcador de dieciocho casillas
	ld a,(0c075h)		;440a
	and a			;440d
	jr nz,L_446D		;440e
	ld a,(0cec3h)		;4410   ; 0x11 son diecisiete: los hoyos que quedan
	sub 011h		;4413
	jr nc,L_4425		;4415
	ld b,a			;4417
	ld a,(0c074h)		;4418   ; si la ventaja es mayor que los hoyos que quedan, el partido esta decidido
	add a,b			;441b
	jp z,L_4656		;441c
	jp m,L_465B		;441f
	jp L_442B		;4422
L_4425:
	ld a,(0c074h)		;4425
	and a			;4428
	jr z,L_446D		;4429
L_442B:
	ld a,(0c005h)		;442b   ; hay ganador
	dec a			;442e   ; en MATCH PLAY el resultado se escribe con "AND"
	jr z,L_4437		;442f
	call L_4FE6		;4431   ; en los demas modos, la clasificacion del torneo
	jp L_466B		;4434
L_4437:
	ld hl,01ecbh		;4437   ; 0x1ECB y 0x1ED5 son las dos lineas del resultado, en la tercera pantalla
	ld de,01ed5h		;443a
	ld a,(0c073h)		;443d
	and a			;4440
	jr z,L_4444		;4441
	ex de,hl			;4443
L_4444:
	ld a,(0c074h)		;4444   ; la ventaja, en hoyos
	call L_4A4B		;4447
	ld a,(0c075h)		;444a
	and a			;444d
	jr nz,L_446A		;444e
	inc hl			;4450
	ld a,041h		;4451   ; escribe A, N y D: "3 AND 2"
	call L_6893		;4453
	ld a,04eh		;4456
	call L_6893		;4458
	ld a,044h		;445b
	call L_6893		;445d
	ld a,(0cec3h)		;4460   ; y los hoyos que quedaban por jugar
	neg		;4463
	add a,011h		;4465
	call L_4A4B		;4467
L_446A:
	jp L_46BC		;446a
L_446D:
	ld a,(0c074h)		;446d   ; empate: se sigue jugando
	and a			;4470
	jr nz,L_442B		;4471
	ld a,001h		;4473
	ld (0c075h),a		;4475
L_4478:
	ld de,04ca6h		;4478   ; 0x4CA6 es PLAYOFF
	call L_4BF5		;447b
	ld hl,0cec3h		;447e   ; el desempate empieza en el hoyo siguiente
	inc (hl)			;4481
	ld a,(hl)			;4482
	cp 012h		;4483   ; y si ya no quedan, se vuelve al 16
	jr c,L_4489		;4485
	ld (hl),00fh		;4487
L_4489:
	jp L_465F		;4489
L_448C:
	call esconde_la_bola		;448c   ; la bola ha entrado
	jr L_44E3		;448f
L_4491:
	ld a,(0c634h)		;4491   ; estamos en el green
	and a			;4494
	jr nz,L_44C1		;4495
	call L_6696		;4497   ; espera
	call L_9E0B		;449a
	ld a,(0c633h)		;449d   ; si ha entrado, se acabo el hoyo
	and a			;44a0
	jp z,L_4398		;44a1
	call L_4848		;44a4   ; recoloca la vista del green
	xor a			;44a7
	ld (0c011h),a		;44a8
	ld (iy+000h),001h		;44ab   ; el jugador vuelve al estado 1
	ld hl,0c009h		;44af
	push hl			;44b2
	ld a,(hl)			;44b3
	push af			;44b4
	xor 001h		;44b5   ; y se mira el green desde el otro lado un momento
	ld (hl),a			;44b7
	call esconde_la_bola		;44b8
	pop af			;44bb
	pop hl			;44bc
	ld (hl),a			;44bd
	jp L_4398		;44be
L_44C1:
	ld a,(0c009h)		;44c1   ; los sprites del jugador 1 empiezan en 0x1B00 y los del 2 cuatro bytes despues
	and a			;44c4
	ld hl,01b00h		;44c5
	jr z,L_44CE		;44c8
	inc hl			;44ca
	inc hl			;44cb
	inc hl			;44cc
	inc hl			;44cd
L_44CE:
	ld a,(0c63eh)		;44ce   ; coloca el sprite de la bola en el green
	sub 002h		;44d1
	call L_6893		;44d3
	ld a,(0c63dh)		;44d6
	dec a			;44d9
	call L_6893		;44da
	inc hl			;44dd
	ld a,004h		;44de   ; color 4, el de la bola
	call 0004dh		;44e0   ; BIOS WRTVRM - Writes data in VRAM
L_44E3:
	ld a,004h		;44e3   ; pista 4: la de meter la bola
	call L_6B2D		;44e5
	call L_6696		;44e8
	ld (iy+000h),003h		;44eb   ; estado 3: hoyo terminado
	call esconde_la_bola		;44ef
	call L_9E0B		;44f2
	ld a,(0c005h)		;44f5   ; en MATCH PLAY no se acumulan golpes
	dec a			;44f8
	jr z,L_4546		;44f9
	ld a,(0c075h)		;44fb
	and a			;44fe
	jr nz,L_4546		;44ff
	ld a,(iy+057h)		;4501   ; la diferencia entre los golpes dados y el par
	ld hl,0c06ch		;4504
	sub (hl)			;4507
	ld c,a			;4508
	ld b,000h		;4509
	jr nc,L_450E		;450b
	dec b			;450d
L_450E:
	ld hl,0c05ch		;450e   ; se suma al acumulado de la vuelta
	call L_4534		;4511
	ld hl,0c068h		;4514   ; y los golpes se apuntan en la casilla del hoyo
	ld a,(iy+057h)		;4517
	ld c,a			;451a
	ld b,000h		;451b
	call L_4534		;451d
	ld de,0fffch		;4520   ; -4 porque la tabla de golpes empieza cuatro bytes antes
	add hl,de			;4523
	ld a,(0cec3h)		;4524   ; y los hoyos del 10 al 18 van en la segunda mitad de la tabla
	cp 009h		;4527
	jr c,L_452C		;4529
	inc hl			;452b
L_452C:
	ld a,(hl)			;452c
	add a,c			;452d
	ld (hl),a			;452e
	call L_486F		;452f
	jr L_4546		;4532
L_4534:
	ld a,(0c009h)		;4534   ; elige la casilla del jugador que esta jugando
	and a			;4537
	jr z,L_453C		;4538
	inc hl			;453a
	inc hl			;453b
L_453C:
	ld e,(hl)			;453c
	inc hl			;453d
	ld d,(hl)			;453e
	ex de,hl			;453f
	add hl,bc			;4540
	ex de,hl			;4541
	ld (hl),d			;4542
	dec hl			;4543
	ld (hl),e			;4544
	ret			;4545
L_4546:
	ld de,04c0bh		;4546   ; 0x4C0B es HOLE IN ONE
	ld a,(iy+057h)		;4549   ; un solo golpe es hoyo en uno, sin mirar el par
	cp 001h		;454c
	jr z,L_4569		;454e
	ld a,(0c06ch)		;4550   ; si no, el resultado es golpes menos par
	sub (iy+057h)		;4553
	neg		;4556
	add a,003h		;4558   ; mas tres, para que ALBATROSS caiga en el indice 0
	cp 007h		;455a   ; por debajo de -3 o por encima de +3 no hay rotulo
	jr nc,L_4576		;455c
	add a,a			;455e
	ld e,a			;455f
	ld d,000h		;4560
	ld hl,04cbah		;4562   ; la tabla de los siete rotulos
	add hl,de			;4565
	ld e,(hl)			;4566
	inc hl			;4567
	ld d,(hl)			;4568
L_4569:
	call L_4BFD		;4569   ; dibuja el rotulo
	ld a,(de)			;456c   ; y el byte que va detras del texto es la pista que suena
	and a			;456d
	jr z,L_4576		;456e
	call L_6B2D		;4570
	call L_4BF8		;4573
L_4576:
	call L_4BF8		;4576   ; lo deja en pantalla un rato
	call 00090h		;4579   ; BIOS GICINI - Initialises PSG and sets initial value for the PLAY statement | y calla el PSG
	ld a,(0c008h)		;457c   ; con un solo jugador y STROKE PLAY se pasa al hoyo siguiente
	and a			;457f
	jr z,L_45CB		;4580
	ld a,(0c075h)		;4582
	and a			;4585
	jr nz,L_45A0		;4586
	ld a,(0c005h)		;4588
	dec a			;458b
	jr z,L_45A0		;458c
	ld a,(0c009h)		;458e
	ld hl,0c00bh		;4591
	and a			;4594
	jr nz,L_4598		;4595
	inc hl			;4597
L_4598:
	ld a,(hl)			;4598   ; estado 3 es que el otro tambien ha acabado
	cp 003h		;4599
	jr z,L_45CB		;459b
	jp L_4398		;459d
L_45A0:
	ld hl,0c071h		;45a0   ; MATCH PLAY: el hoyo se cierra cuando acaban los dos
	ld a,(hl)			;45a3
	and a			;45a4
	jr nz,L_45BE		;45a5
	inc (hl)			;45a7
	call L_4388		;45a8
	jr c,L_45B5		;45ab
	jr z,L_45B5		;45ad
	call L_4371		;45af
	jp L_421D		;45b2
L_45B5:
	ld a,(0c009h)		;45b5
	ld (0c072h),a		;45b8
	jp L_43BD		;45bb
L_45BE:
	call L_4388		;45be
	jr c,L_45B5		;45c1
	ld a,0ffh		;45c3
	ld (0c072h),a		;45c5
	jp L_43BD		;45c8
L_45CB:
	ld hl,0c062h		;45cb   ; quien ha quedado por delante en este hoyo
	ld a,(hl)			;45ce
	inc hl			;45cf
	cp (hl)			;45d0
	ld a,000h		;45d1
	jr z,L_45DB		;45d3
	jr c,L_45D8		;45d5
	inc a			;45d7
L_45D8:
	ld (0c00ah),a		;45d8
L_45DB:
	call L_48F7		;45db   ; repinta el marcador
	ld a,(0c005h)		;45de   ; en TOURNAMENT hay que actualizar la clasificacion
	cp 002h		;45e1
	jr nz,L_462D		;45e3
	ld a,(0c062h)		;45e5   ; la diferencia con el par de este jugador
	ld hl,0c06ch		;45e8
	sub (hl)			;45eb
	ld (0c0f5h),a		;45ec
	ld a,(0c116h)		;45ef   ; y si juega la maquina, la del rival
	and a			;45f2
	jr nz,L_4602		;45f3
	ld a,(0c00ah)		;45f5
	and a			;45f8
	jr z,L_4602		;45f9
	ld a,(0c063h)		;45fb
	sub (hl)			;45fe
	ld (0c0f5h),a		;45ff
L_4602:
	ld hl,(0c05ch)		;4602   ; compara el acumulado de los dos jugadores
	ld de,(0c05eh)		;4605
	and a			;4609
	sbc hl,de		;460a
	ld c,004h		;460c   ; cuatro es la cadencia normal
	jr z,L_4623		;460e
	jp m,L_461C		;4610
	ld a,l			;4613
	cp 003h		;4614   ; tres golpes o mas de ventaja: cadencia 2
	jr c,L_4623		;4616
	ld c,002h		;4618
	jr L_4623		;461a
L_461C:
	ld a,l			;461c
	cp 0feh		;461d   ; tres golpes o mas por detras: cadencia 6
	jr nc,L_4623		;461f
	ld c,006h		;4621
L_4623:
	ld a,c			;4623
	ld (0c119h),a		;4624
	call L_4EC9		;4627   ; rehace la clasificacion del torneo
	call L_4DEC		;462a
L_462D:
	ld hl,0cec3h		;462d   ; hoyo siguiente
	inc (hl)			;4630
	ld a,(hl)			;4631
	cp 012h		;4632   ; diecisiete es el ultimo
	jr c,L_4649		;4634
	ld a,(0c005h)		;4636   ; en TOURNAMENT queda la clasificacion final
	cp 002h		;4639
	jr nz,L_466B		;463b
	call L_4F90		;463d
	ld a,(0c075h)		;4640
	and a			;4643
	jr z,L_466B		;4644
	jp L_4478		;4646
L_4649:
	xor a			;4649   ; y si quedan hoyos, se monta el siguiente
	ld (0c011h),a		;464a
	call vuelca_el_hoyo		;464d
	call L_6696		;4650
	jp L_41E2		;4653
L_4656:
	ld a,001h		;4656   ; 0xC076 pide el rotulo DORMY HOLE en el proximo hoyo
	ld (0c076h),a		;4658
L_465B:
	ld hl,0cec3h		;465b
	inc (hl)			;465e
L_465F:
	ld a,(0c072h)		;465f   ; el estado de la ventaja para el hoyo que viene
	and a			;4662
	jp m,L_4649		;4663
	ld (0c00ah),a		;4666
	jr L_4649		;4669
L_466B:
	ld hl,(0c060h)		;466b   ; fin de la vuelta: el mejor resultado
	ld de,(0c05ch)		;466e
	rst 20h			;4672   ; RST 20h compara HL con DE
	jp m,L_4677		;4673
	ex de,hl			;4676
L_4677:
	ld a,(0c008h)		;4677   ; y si hay segundo jugador, tambien el suyo
	and a			;467a
	jr z,L_468C		;467b
	ld a,(0c116h)		;467d
	and a			;4680
	jr nz,L_468C		;4681
	ld de,(0c05eh)		;4683
	rst 20h			;4687
	jp m,L_468C		;4688
	ex de,hl			;468b
L_468C:
	ld (0c060h),hl		;468c   ; 0xC060 guarda el mejor de la partida
	call L_486F		;468f
	ld hl,01ecch		;4692   ; escribe el total del jugador 1
	ld de,(0c068h)		;4695
	call L_4A3C		;4699
	inc hl			;469c
	ex de,hl			;469d
	ld hl,(0c05ch)		;469e
	call L_48A8		;46a1
	ld a,(0c008h)		;46a4
	and a			;46a7
	jr z,L_46BC		;46a8
	ld hl,01ed6h		;46aa   ; y el del 2
	ld de,(0c06ah)		;46ad
	call L_4A3C		;46b1
	inc hl			;46b4
	ex de,hl			;46b5
	ld hl,(0c05eh)		;46b6
	call L_48A8		;46b9
L_46BC:
	call L_4BE7		;46bc   ; borra el rotulo de distancia
	ld de,04c9bh		;46bf   ; 0x4C9B es HOLE OUT
	call L_4BF5		;46c2
	call L_6769		;46c5   ; deja mirar la pantalla
	ld a,(0c005h)		;46c8
	cp 002h		;46cb
	jr nz,L_46EA		;46cd
	ld a,(0c0beh)		;46cf   ; en el torneo, si se ha ganado suena la fanfarria
	cp 023h		;46d2
	jr z,L_46DE		;46d4
	cp 024h		;46d6
	jr nz,L_46DE		;46d8
	ld a,(0c003h)		;46da
	dec a			;46dd
L_46DE:
	ld a,00bh		;46de   ; pista 11
	call z,L_6B2D		;46e0
	call L_6799		;46e3
	xor a			;46e6
	call L_6B2D		;46e7
L_46EA:
	jp L_4069		;46ea   ; y vuelta al menu
L_46ED:
	call L_4BAE		;46ed   ; repinta la vista que toque
	ld a,(0c011h)		;46f0
	and a			;46f3
	jp nz,monta_el_hoyo		;46f4   ; la del green
	jp vuelca_el_hoyo		;46f7   ; o la del campo
L_46FA:
	xor a			;46fa   ; a quien le toca: en golf juega el que esta mas lejos
	ld (0c009h),a		;46fb   ; de fabrica, el jugador 1
	ld a,(0c008h)		;46fe   ; sin segundo jugador no hay nada que decidir
	and a			;4701
	ret z			;4702
	ld a,(0c00ah)		;4703   ; si uno de los dos ya ha acabado, juega el otro
	and a			;4706
	jr nz,L_470E		;4707
	ld a,(0c00bh)		;4709
	and a			;470c
	ret z			;470d
L_470E:
	ld a,(0c00ch)		;470e   ; y si el otro tambien, tampoco hay nada que decidir
	and a			;4711
	jr nz,L_471A		;4712
L_4714:
	ld a,001h		;4714
	ld (0c009h),a		;4716
	ret			;4719
L_471A:
	ld hl,(0c00bh)		;471a   ; los dos estados a la vez
	ld a,h			;471d
	cp l			;471e   ; si el segundo va mas adelantado, juega el primero
	jr c,L_4714		;471f
	ret nz			;4721
	cp 002h		;4722   ; los dos en el green: se mide la distancia de verdad
	jr c,L_4738		;4724
	ld a,001h		;4726   ; y se juega la vista del green
	ld (0c011h),a		;4728
	ld hl,0c00eh		;472b
	call L_4748		;472e
	ld hl,0c00dh		;4731
	xor a			;4734
	call L_4748		;4735
L_4738:
	ld a,001h		;4738   ; distancia del jugador 2 al hoyo
	call L_475C		;473a
	ld b,a			;473d
	push bc			;473e
	xor a			;473f   ; y la del 1
	call L_475C		;4740
	pop bc			;4743
	cp b			;4744   ; juega el que este mas lejos
	ret nc			;4745
	jr L_4714		;4746
L_4748:
	ld (0c009h),a		;4748   ; apunta el jugador y su objetivo
	ld a,(hl)			;474b
	ld (0c60eh),a		;474c
	inc hl			;474f
	inc hl			;4750
	ld a,(hl)			;4751
	ld (0c611h),a		;4752
	xor a			;4755
	ld (0c613h),a		;4756
	jp pinta_los_sprites		;4759
L_475C:
	call L_477A		;475c   ; distancia de un jugador a la bandera
	ld a,(bc)			;475f
	sub (hl)			;4760   ; la diferencia en X, en valor absoluto
	jr nc,L_4765		;4761
	neg		;4763
L_4765:
	ld e,a			;4765
	inc bc			;4766
	inc hl			;4767
	inc hl			;4768
	ld a,(bc)			;4769   ; y la diferencia en Y
	sub (hl)			;476a
	jr nc,L_476F		;476b
	neg		;476d
L_476F:
	ld l,a			;476f
	srl e		;4770   ; las dos a la mitad, para que quepan
	srl l		;4772
	jp L_6513		;4774   ; y la raiz de la suma de cuadrados
L_4777:
	ld a,(0c009h)		;4777   ; el jugador que esta jugando
L_477A:
	ld hl,0c00dh		;477a   ; 0xC00D es la posicion objetivo del jugador 1 y 0xC00E la del 2
	and a			;477d
	jr z,L_4781		;477e
	inc hl			;4780
L_4781:
	ld bc,0c63fh		;4781   ; 0xC63F es la bola en la vista del campo
	ld a,(0c011h)		;4784
	and a			;4787
	ret z			;4788
	ld bc,0c63dh		;4789   ; y 0xC63D en la del green
	ret			;478c
L_478D:
	ld a,(0c60eh)		;478d   ; guarda el punto de mira de partida
	ld (0c012h),a		;4790
	ld a,(0c611h)		;4793
	ld (0c013h),a		;4796
	ret			;4799
L_479A:
	ld hl,(0c63fh)		;479a   ; la distancia que queda a la bandera
	ld a,(0c011h)		;479d
	and a			;47a0
	jr z,L_47A6		;47a1
	ld hl,(0c63dh)		;47a3
L_47A6:
	call L_47B0		;47a6
	ld (0c61fh),a		;47a9   ; y se enseña en el panel
	ld (0c660h),a		;47ac
	ret			;47af
L_47B0:
	push hl			;47b0   ; vector de la bola al punto de mira, con signo
	ld l,h			;47b1
	ld h,000h		;47b2
	ld a,(0c013h)		;47b4
	ld e,a			;47b7
	ld d,000h		;47b8
	and a			;47ba
	sbc hl,de		;47bb
	ex (sp),hl			;47bd
	ld h,000h		;47be
	ld a,(0c012h)		;47c0
	ld e,a			;47c3
	ld d,000h		;47c4
	and a			;47c6
	sbc hl,de		;47c7
	pop de			;47c9
	ld a,e			;47ca   ; si las dos componentes tienen el mismo signo cabe tal cual
	xor d			;47cb
	jp m,L_47D4		;47cc
	ld a,l			;47cf
	xor h			;47d0
	jp p,L_47DC		;47d1
L_47D4:
	sra d		;47d4   ; y si no, se dividen las dos por dos para que no desborde
	rr e		;47d6
	sra h		;47d8
	rr l		;47da
L_47DC:
	jp L_64C5		;47dc   ; raiz de la suma de cuadrados
L_47DF:
	ld a,(0c06ch)		;47df   ; el par manda: la escala para pasar del campo al green sale de la tabla de 0x4842
	sub 003h		;47e2
	add a,a			;47e4
	ld e,a			;47e5
	ld d,000h		;47e6
	ld hl,04842h		;47e8
	add hl,de			;47eb
	ld a,(hl)			;47ec
	ld (0c06dh),a		;47ed
	inc hl			;47f0
	ld a,(hl)			;47f1
	ld (0c06eh),a		;47f2
	ld hl,0c63fh		;47f5   ; la componente X del vector
	ld a,(0c60eh)		;47f8
	sub (hl)			;47fb
	ld e,a			;47fc
	ld a,(0c06dh)		;47fd
	call L_6524		;4800   ; escalada por el factor del par
	ld a,(0c63dh)		;4803
	add a,l			;4806
	ld (0c60eh),a		;4807   ; y montada sobre la posicion en el green
	ld hl,0c640h		;480a   ; lo mismo con la Y
	ld a,(0c611h)		;480d
	sub (hl)			;4810
	ld e,a			;4811
	ld a,(0c06eh)		;4812
	call L_6524		;4815
	ld a,(0c63eh)		;4818
	add a,l			;481b
	ld (0c611h),a		;481c
	ld a,(0c008h)		;481f   ; sin rival no hay nada mas que hacer
	and a			;4822
	ret z			;4823
	ld hl,0c00bh		;4824   ; y si el rival no esta en el green, tampoco
	ld a,(0c009h)		;4827
	and a			;482a
	jr nz,L_482E		;482b
	inc hl			;482d
L_482E:
	ld a,(hl)			;482e
	cp 002h		;482f
	ret nz			;4831
	ld a,r		;4832   ; el registro R de refresco hace de moneda al aire
	and 001h		;4834
	ld a,002h		;4836   ; dos pixeles a un lado
	jr nz,L_483C		;4838
	ld a,0feh		;483a   ; o dos al otro
L_483C:
	ld hl,0c60eh		;483c   ; para que los dos no apunten exactamente al mismo sitio
	add a,(hl)			;483f
	ld (hl),a			;4840
	ret			;4841

; ----------------------------------------------------------------------
; DATOS escala_del_green: Dos bytes por par (3, 4 y 5): la escala con la que
;   0x47DF pasa el punto de mira de las coordenadas del campo a las del green
;   0x4842..0x4848  (6 bytes)
DATA_escala_del_green:
	defb 005h,009h	; 4842
	defb 006h,00bh	; 4844
	defb 007h,00dh	; 4846

; ======================================================================
; CODIGO 0x4848..0x49b4  (364 bytes)
; ======================================================================


L_4848:
	call L_478D		;4848   ; prepara la vista del green
	ld hl,(0c63dh)		;484b
	call L_47B0		;484e
	add a,080h		;4851   ; el angulo se guarda con 0x80 de sesgo, o sea 0 grados en el centro
	ld (0c61fh),a		;4853
	ld a,(0c63fh)		;4856   ; y la bola pasa de las coordenadas del campo a las del green
	ld (0c60eh),a		;4859
	ld a,(0c640h)		;485c
	ld (0c611h),a		;485f
L_4862:
	call mueve_la_camara		;4862   ; espera a que la camara acabe de moverse
	call L_629C		;4865
	ld a,(0c637h)		;4868
	and a			;486b
	jr nz,L_4862		;486c
	ret			;486e
L_486F:
	ld a,(0c062h)		;486f   ; repinta las dos lineas de golpes del panel
	ld hl,018c7h		;4872   ; 0x18C7 es la del jugador 1
	call L_4A4B		;4875
	ld a,(0c008h)		;4878
	and a			;487b
	ld a,(0c063h)		;487c
	ld hl,018e7h		;487f   ; y 0x18E7 la del 2, si lo hay
	call nz,L_4A4B		;4882
	ld a,(0c005h)		;4885   ; en MATCH PLAY, en vez de totales va la ventaja
	dec a			;4888
	jr z,L_48DE		;4889
L_488B:
	ld hl,(0c060h)		;488b   ; el TOP, el total del jugador 1 y el del 2
	ld de,01826h		;488e
	call L_48A8		;4891
	ld hl,(0c05ch)		;4894
	ld de,01846h		;4897
	call L_48A8		;489a
	ld a,(0c008h)		;489d
	and a			;48a0
	ret z			;48a1
	ld hl,(0c05eh)		;48a2
	ld de,01866h		;48a5
L_48A8:
	ld a,020h		;48a8   ; borra el signo que hubiera delante
	ex de,hl			;48aa
	call L_6893		;48ab
	ex de,hl			;48ae
	ld a,l			;48af   ; el cero se escribe sin signo
	or h			;48b0
	ld c,03ch		;48b1   ; 0x3C es el signo mas
	jr z,L_48C9		;48b3
	dec c			;48b5
	ld a,h			;48b6   ; si el total es negativo...
	and a			;48b7
	jp p,L_48C3		;48b8
	xor a			;48bb   ; ...se le da la vuelta
	sub l			;48bc
	ld l,a			;48bd
	sbc a,a			;48be
	sub h			;48bf
	ld h,a			;48c0
	ld c,03dh		;48c1   ; y el signo pasa a ser el menos, 0x3D
L_48C3:
	ld a,h			;48c3   ; mas de 255 no cabe: se escribe 99
	and a			;48c4
	jr z,L_48C9		;48c5
	ld l,063h		;48c7
L_48C9:
	ld a,l			;48c9   ; escribe el numero
	ex de,hl			;48ca
	call L_4A4B		;48cb
L_48CE:
	dec hl			;48ce   ; y retrocede hasta el primer hueco para poner ahi el signo
	call 0004ah		;48cf   ; BIOS RDVRM - Reads the content of VRAM
	cp 020h		;48d2
	jr z,L_48DA		;48d4
	cp 03ah		;48d6
	jr c,L_48CE		;48d8
L_48DA:
	ld a,c			;48da
	jp 0004dh		;48db   ; BIOS WRTVRM - Writes data in VRAM
L_48DE:
	ld a,(0c073h)		;48de   ; en MATCH PLAY se escribe la ventaja y de quien es
	and a			;48e1
	ld de,01847h		;48e2
	ld hl,01867h		;48e5
	jr nz,L_48EB		;48e8
	ex de,hl			;48ea
L_48EB:
	push de			;48eb
	ld a,(0c074h)		;48ec
	call L_4A4B		;48ef
	pop hl			;48f2
	xor a			;48f3
	jp L_4A4B		;48f4
L_48F7:
	ld a,(0c075h)		;48f7   ; el marcador de dieciocho casillas
	and a			;48fa
	ret nz			;48fb   ; con la vuelta acabada ya no se toca
	ld a,(0cec3h)		;48fc   ; la casilla del hoyo que se juega
	ld hl,049b4h		;48ff
	call saca_de_tabla		;4902
	ex de,hl			;4905
	ld a,(0c005h)		;4906   ; en MATCH PLAY el marcador es otro
	dec a			;4909
	jr z,L_4961		;490a
	push hl			;490c
	ld a,(0c062h)		;490d   ; los golpes del jugador 1
	call L_494A		;4910
	pop hl			;4913
	inc hl			;4914
	inc hl			;4915
	inc hl			;4916
	inc hl			;4917   ; cuatro columnas mas a la derecha, los del 2
	ld a,(0c008h)		;4918
	and a			;491b
	ld a,(0c063h)		;491c
	call nz,L_494A		;491f
	ld hl,01e49h		;4922   ; 0x1E49 son los hoyos 1 al 9 y 0x1E58 los del 10 al 18
	ld de,0c064h		;4925
	ld a,(0cec3h)		;4928
	cp 009h		;492b
	jr c,L_4933		;492d
	ld hl,01e58h		;492f
	inc de			;4932
L_4933:
	ld a,(de)			;4933   ; el acumulado hasta este hoyo
	push de			;4934
	push hl			;4935
	call L_4A4B		;4936
	pop hl			;4939
	inc hl			;493a
	inc hl			;493b
	inc hl			;493c
	inc hl			;493d
	pop de			;493e
	inc de			;493f
	inc de			;4940
	ld a,(0c008h)		;4941
	and a			;4944
	ld a,(de)			;4945
	call nz,L_4A4B		;4946
	ret			;4949
L_494A:
	ld b,a			;494a   ; delante del numero va un simbolo segun el par
	ld a,(0c06ch)		;494b
	sub b			;494e
	ld a,0d5h		;494f   ; 0xD5 si se ha pasado del par
	jp m,L_495A		;4951
	ld a,094h		;4954   ; 0x94 -un hueco- si lo ha clavado
	jr z,L_495A		;4956
	ld a,0d4h		;4958   ; y 0xD4 si esta por debajo
L_495A:
	call L_6893		;495a
	ld a,b			;495d
	jp L_4A4B		;495e
L_4961:
	push hl			;4961
	ld a,(0c072h)		;4962
	and a			;4965
	jp m,L_4974		;4966
	jr z,L_496F		;4969
	inc hl			;496b
	inc hl			;496c
	inc hl			;496d
	inc hl			;496e
L_496F:
	ld a,0d4h		;496f
	call 0004dh		;4971   ; BIOS WRTVRM - Writes data in VRAM
L_4974:
	pop hl			;4974
	inc hl			;4975
	ld e,l			;4976
	ld d,h			;4977
	inc de			;4978
	inc de			;4979
	inc de			;497a
	inc de			;497b
	ld a,(0c073h)		;497c
	and a			;497f
	push af			;4980
	jr z,L_4984		;4981
	ex de,hl			;4983
L_4984:
	push de			;4984   ; la casilla del hoyo, para el jugador que va delante
	ld a,(0c074h)		;4985   ; la ventaja en hoyos
	call L_4A4B		;4988
	pop hl			;498b
	xor a			;498c   ; y en la del otro, un cero
	call L_4A4B		;498d
	ld hl,01e49h		;4990   ; 0x1E49 son los hoyos 1 al 9 del marcador
	ld de,01e4dh		;4993
	ld a,(0cec3h)		;4996   ; y del decimo en adelante se usa la otra fila
	cp 009h		;4999
	jr c,L_49A3		;499b
	ld hl,01e58h		;499d   ; 0x1E58, la segunda mitad
	ld de,01e5ch		;49a0
L_49A3:
	pop af			;49a3   ; recupera quien iba delante
	jr z,L_49A7		;49a4
	ex de,hl			;49a6   ; y si era el otro, se cambian las dos casillas
L_49A7:
	push de			;49a7
	ld a,(0c074h)		;49a8   ; la ventaja
	call L_4A4B		;49ab
	pop hl			;49ae
	xor a			;49af   ; y un cero para el que va detras
	call L_4A4B		;49b0
	ret			;49b3

; ----------------------------------------------------------------------
; DATOS marcador_golpes_vram: Dieciocho direcciones de VRAM, una por hoyo,
;   donde va el numero de golpes del marcador
;   0x49b4..0x49d8  (36 bytes)
DATA_marcador_golpes_vram:
	defw 01d08h,01d28h,01d48h,01d68h	; 49b4
	defw 01d88h,01da8h,01dc8h,01de8h	; 49bc
	defw 01e08h,01d17h,01d37h,01d57h	; 49c4
	defw 01d77h,01d97h,01db7h,01dd7h	; 49cc
	defw 01df7h,01e17h	; 49d4

; ======================================================================
; CODIGO 0x49d8..0x4a18  (64 bytes)
; ======================================================================


L_49D8:
	ld b,012h		;49d8   ; dieciocho hoyos
L_49DA:
	push bc			;49da
	ld a,b			;49db   ; el hoyo, contado desde uno
	dec a			;49dc
	ld (0cec3h),a		;49dd   ; 0xCEC3 se usa aqui de indice temporal
	push af			;49e0
	call monta_el_hoyo		;49e1   ; monta el hoyo en el buffer, que es de donde sale el par
	pop af			;49e4
	push af			;49e5
	ld hl,04a18h		;49e6   ; la casilla de VRAM de este hoyo
	call saca_de_tabla		;49e9
	ex de,hl			;49ec
	pop af			;49ed
	inc a			;49ee   ; el numero de hoyo se escribe desde uno
	call L_4A4B		;49ef
	call L_4A13		;49f2   ; dos puntos de separacion
	inc hl			;49f5
	ld a,(0c06ch)		;49f6   ; y el par del hoyo, en ASCII
	or 030h		;49f9
	call L_6893		;49fb
	call L_4A08		;49fe   ; deja en blanco las dos casillas de golpes
	call L_4A08		;4a01
	pop bc			;4a04
	djnz L_49DA		;4a05   ; y a por el siguiente
	ret			;4a07
L_4A08:
	call L_4A13		;4a08   ; escribe dos puntos y un hueco, y avanza dos columnas
	ld a,094h		;4a0b
	call L_6893		;4a0d
	inc hl			;4a10
	inc hl			;4a11
	ret			;4a12
L_4A13:
	ld a,03ah		;4a13   ; 0x3A son los dos puntos
	jp L_6893		;4a15

; ----------------------------------------------------------------------
; DATOS marcador_hoyos_vram: Las mismas dieciocho, seis columnas a la
;   izquierda: ahi va el numero de hoyo
;   0x4a18..0x4a3c  (36 bytes)
DATA_marcador_hoyos_vram:
	defw 01d02h,01d22h,01d42h,01d62h	; 4a18
	defw 01d82h,01da2h,01dc2h,01de2h	; 4a20
	defw 01e02h,01d11h,01d31h,01d51h	; 4a28
	defw 01d71h,01d91h,01db1h,01dd1h	; 4a30
	defw 01df1h,01e11h	; 4a38

; ======================================================================
; CODIGO 0x4a3c..0x4b16  (218 bytes)
; ======================================================================


L_4A3C:
	ld a,d			;4a3c   ; version de 16 bits: si pasa de 255 se escribe 255
	and a			;4a3d
	jr z,L_4A42		;4a3e
	ld e,0ffh		;4a40
L_4A42:
	ld a,e			;4a42
	ld de,00064h		;4a43   ; empieza por las centenas
	call L_4A5B		;4a46
	jr L_4A53		;4a49
L_4A4B:
	cp 064h		;4a4b   ; version de 8 bits, acotada a dos cifras
	jr c,L_4A51		;4a4d
	ld a,063h		;4a4f   ; 99 es el tope
L_4A51:
	ld d,000h		;4a51
L_4A53:
	ld e,00ah		;4a53   ; decenas
	call L_4A5B		;4a55
	inc d			;4a58   ; y unidades, que siempre se escriben
	ld e,001h		;4a59
L_4A5B:
	ld b,02fh		;4a5b   ; divide restando, y B cuenta desde el ASCII del cero
L_4A5D:
	inc b			;4a5d
	sub e			;4a5e
	jr nc,L_4A5D		;4a5f
	add a,e			;4a61
	push af			;4a62
	ld a,b			;4a63
	cp 030h		;4a64   ; si la cifra sale cero...
	jr nz,L_4A6F		;4a66
	inc d			;4a68   ; ...y aun no se ha escrito ninguna...
	dec d			;4a69
	jr nz,L_4A6F		;4a6a
	ld a,020h		;4a6c   ; ...se pone un hueco en vez del cero
	dec d			;4a6e
L_4A6F:
	inc d			;4a6f   ; D cuenta las cifras ya escritas
	call L_6893		;4a70   ; y la suelta en la VRAM
	pop af			;4a73
	ret			;4a74
L_4A75:
	ld hl,018c2h		;4a75   ; la flecha que dice a quien le toca jugar
	ld de,018e2h		;4a78
	ld a,(0c009h)		;4a7b   ; el jugador que juega
	and a			;4a7e
	jr z,L_4A82		;4a7f
	ex de,hl			;4a81
L_4A82:
	ld a,02fh		;4a82   ; 0x2F es la flecha
	call 0004dh		;4a84   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;4a87
	ld a,020h		;4a88   ; y un hueco en la linea del otro
	jp 0004dh		;4a8a   ; BIOS WRTVRM - Writes data in VRAM
L_4A8D:
	ld a,(0cec3h)		;4a8d   ; el rotulo del hoyo: numero, par y bandera
	inc a			;4a90   ; se enseña desde uno
	ld hl,01927h		;4a91
	call L_4A4B		;4a94
	ld a,(0c06ch)		;4a97   ; el par de este hoyo
	ld hl,01966h		;4a9a
	call L_4A4B		;4a9d
	ld hl,0cecfh		;4aa0   ; 0xCECF son los tres bytes de la distancia del hoyo, ya en ASCII
	ld de,01943h		;4aa3
	ld bc,00003h		;4aa6
	call 0005ch		;4aa9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	call L_4B47		;4aac   ; el rotulo del viento
	jp L_4B84		;4aaf   ; y el del desnivel
L_4AB2:
	ld a,(0c621h)		;4ab2   ; escribe el palo elegido
	ld e,a			;4ab5   ; tres bytes por palo
	add a,a			;4ab6
	add a,e			;4ab7
	ld e,a			;4ab8
	ld d,000h		;4ab9
	ld hl,04b16h		;4abb   ; la tabla de los quince
	add hl,de			;4abe
	push hl			;4abf
	inc hl			;4ac0   ; las dos letras van detras del byte de grupo
	ld de,01ae7h		;4ac1   ; 0x1AE7 es donde va el nombre del palo
	ld bc,00002h		;4ac4
	call 0005ch		;4ac7   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,04b43h		;4aca   ; y delante, las cuatro letras de CLUB
	ld de,01ae2h		;4acd
	ld bc,00004h		;4ad0
	call 0005ch		;4ad3   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;4ad6
	ld a,(0c007h)		;4ad7   ; en el nivel AVERAGE el swing es mas lento
	and a			;4ada
	ld a,(hl)			;4adb
	jr z,L_4ADF		;4adc
	rra			;4ade   ; a partir de EXPERT se usa la mitad del grupo
L_4ADF:
	add a,01ch		;4adf   ; 0x1C es el primer dibujo de la fila de swings
	ld hl,01b22h		;4ae1
	call L_6893		;4ae4
	ld a,00fh		;4ae7   ; color 15
	call 0004dh		;4ae9   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;4aec
	dec hl			;4aed
	ld a,028h		;4aee   ; 0x28 delante del palo
	call 0004dh		;4af0   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;4af3
	ld a,(0c621h)		;4af4   ; el palo 13 en adelante es el putter
	cp 00dh		;4af7
	ld a,0a7h		;4af9   ; con el putter se dibuja una figura...
	jr c,L_4AFF		;4afb
	ld a,0d1h		;4afd   ; ...y con los demas, otra
L_4AFF:
	call 0004dh		;4aff   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0c621h)		;4b02   ; con el putter, ademas, el panel de abajo cambia
	cp 00dh		;4b05
	jp c,L_6806		;4b07   ; se enseñan seis filas en vez de siete
	ld hl,01a82h		;4b0a   ; y se borran las dos lineas que sobran
	call L_4CC8		;4b0d
	ld hl,01aa2h		;4b10
	jp L_4CC8		;4b13

; ----------------------------------------------------------------------
; DATOS tabla_palos: Quince palos de tres bytes: grupo de swing y las dos
;   letras del rotulo
;   0x4b16..0x4b43  (45 bytes)
DATA_tabla_palos:
	defb 000h,031h,057h	; 4b16
	defb 000h,032h,057h	; 4b19
	defb 000h,033h,057h	; 4b1c
	defb 000h,034h,057h	; 4b1f
	defb 004h,033h,049h	; 4b22
	defb 004h,034h,049h	; 4b25
	defb 004h,035h,049h	; 4b28
	defb 004h,036h,049h	; 4b2b
	defb 008h,037h,049h	; 4b2e
	defb 008h,038h,049h	; 4b31
	defb 008h,039h,049h	; 4b34
	defb 00ch,050h,057h	; 4b37
	defb 00ch,053h,057h	; 4b3a
	defb 00ch,050h,054h	; 4b3d
	defb 00ch,050h,054h	; 4b40

; ----------------------------------------------------------------------
; DATOS texto_club: Las cuatro letras de "CLUB", el rotulo del panel
;   0x4b43..0x4b47  (4 bytes)
DATA_texto_club:
	defb 043h,04ch,055h,042h	; 4b43

; ======================================================================
; CODIGO 0x4b47..0x4c0b  (196 bytes)
; ======================================================================


L_4B47:
	ld hl,01b14h		;4b47   ; la barra del viento
	ld a,(0c625h)		;4b4a   ; 0xC625 lleva la fuerza en los tres bits bajos y la direccion arriba
	and 007h		;4b4d
	add a,a			;4b4f
	add a,a			;4b50
	ld e,a			;4b51
	ld a,(0c625h)		;4b52
	and 078h		;4b55   ; sin viento se dibuja un hueco
	ld a,05fh		;4b57
	jr nz,L_4B5D		;4b59
	ld a,0d1h		;4b5b   ; 0xD1 deja el sprite fuera de pantalla
L_4B5D:
	call L_4B9B		;4b5d
	ld hl,01983h		;4b60   ; dos casillas de la flecha del viento
	call L_4B7C		;4b63
	ld hl,019a3h		;4b66
	call L_4B7C		;4b69
	ld a,(0c625h)		;4b6c   ; la fuerza del viento, en su cifra
	rrca			;4b6f
	rrca			;4b70
	rrca			;4b71
	and 00fh		;4b72
	call L_4A4B		;4b74
	ld a,03fh		;4b77   ; 0x3F cierra el rotulo
	jp 0004dh		;4b79   ; BIOS WRTVRM - Writes data in VRAM
L_4B7C:
	ld a,05fh		;4b7c   ; dos huecos seguidos
	call L_6893		;4b7e
	jp L_6893		;4b81
L_4B84:
	ld a,(0c614h)		;4b84   ; el desnivel del green
	sub 003h		;4b87   ; se enseña centrado en cero
	ld hl,019e5h		;4b89
	call L_4A4B		;4b8c
	ld hl,01b18h		;4b8f   ; y la flecha que dice hacia donde cae
	ld a,(0c615h)		;4b92
	rrca			;4b95
	rrca			;4b96
	rrca			;4b97
	ld e,a			;4b98
	ld a,06fh		;4b99
L_4B9B:
	call L_6893		;4b9b   ; escribe la flecha, su cuerpo y su punta
	ld a,018h		;4b9e
	call L_6893		;4ba0
	ld a,e			;4ba3
	add a,02ch		;4ba4
	call L_6893		;4ba6
	ld a,00fh		;4ba9
	jp 0004dh		;4bab   ; BIOS WRTVRM - Writes data in VRAM
L_4BAE:
	ld hl,01b0ch		;4bae   ; la distancia que queda a la bandera
	ld a,(0c011h)		;4bb1   ; en el green no se enseña
	and a			;4bb4
	jr nz,L_4BE7		;4bb5
	ld a,(0c640h)		;4bb7   ; se parte en dos sprites, uno por cifra
	sub 005h		;4bba
	call L_6893		;4bbc
	ld a,(0c63fh)		;4bbf
	call L_6893		;4bc2
	ld a,014h		;4bc5   ; 0x14 es el separador
	call L_6893		;4bc7
	ld a,00fh		;4bca
	call L_6893		;4bcc
	ld a,(0c640h)		;4bcf
	sub 008h		;4bd2
	call L_6893		;4bd4
	ld a,(0c63fh)		;4bd7
	call L_6893		;4bda
	ld a,010h		;4bdd
	call L_6893		;4bdf
	ld a,009h		;4be2
	jp 0004dh		;4be4   ; BIOS WRTVRM - Writes data in VRAM
L_4BE7:
	ld hl,01b0ch		;4be7   ; borra el rotulo de distancia dejando los sprites fuera de pantalla
	ld a,0d1h		;4bea
	call L_6893		;4bec
	inc hl			;4bef
	inc hl			;4bf0
	inc hl			;4bf1
	jp 0004dh		;4bf2   ; BIOS WRTVRM - Writes data in VRAM
L_4BF5:
	call L_4BFD		;4bf5   ; dibuja el mensaje y espera
L_4BF8:
	ld b,078h		;4bf8   ; 0x78 son ciento veinte cuadros, dos segundos
	jp L_6698		;4bfa
L_4BFD:
	ld hl,01a42h		;4bfd   ; los mensajes son DOS filas de siete
	call L_4C06		;4c00   ; la de arriba, en 0x1A42
	ld hl,01a62h		;4c03   ; y la de abajo, en 0x1A62
L_4C06:
	ld b,007h		;4c06   ; siete caracteres por fila
	jp L_6822		;4c08

; ----------------------------------------------------------------------
; DATOS texto_hoyo_en_uno: "HOLE IN ONE", y detras su pista de PSG (3)
;   0x4c0b..0x4c1a  (15 bytes)
DATA_texto_hoyo_en_uno:
	defb 048h,04fh,04ch,045h,020h,049h,04eh,020h,04fh,04eh,045h,05bh,05bh,020h,003h	; 4c0b  HOLE IN ONE[[ .

; ----------------------------------------------------------------------
; DATOS texto_albatros: "ALBATROSS", y detras su pista de PSG (3)
;   0x4c1a..0x4c29  (15 bytes)
DATA_texto_albatros:
	defb 041h,04ch,042h,041h,03dh,020h,020h,020h,054h,052h,04fh,053h,053h,05bh,003h	; 4c1a  ALBA=   TROSS[.

; ----------------------------------------------------------------------
; DATOS texto_eagle: "EAGLE", y detras su pista de PSG (8)
;   0x4c29..0x4c32  (9 bytes)
DATA_texto_eagle:
	defb 007h,045h,041h,047h,04ch,045h,05bh,05bh,008h	; 4c29  .EAGLE[[.

; ----------------------------------------------------------------------
; DATOS texto_birdie: "BIRDIE", y detras su pista de PSG (9)
;   0x4c32..0x4c3b  (9 bytes)
DATA_texto_birdie:
	defb 007h,042h,049h,052h,044h,049h,045h,05bh,009h	; 4c32  .BIRDIE[.

; ----------------------------------------------------------------------
; DATOS texto_par: "PAR", y detras su pista de PSG (10)
;   0x4c3b..0x4c44  (9 bytes)
DATA_texto_par:
	defb 007h,020h,020h,050h,041h,052h,020h,020h,00ah	; 4c3b  .  PAR  .

; ----------------------------------------------------------------------
; DATOS texto_bogey: "BOGEY", y detras su pista de PSG (7)
;   0x4c44..0x4c4d  (9 bytes)
DATA_texto_bogey:
	defb 007h,020h,042h,04fh,047h,045h,059h,020h,007h	; 4c44  . BOGEY .

; ----------------------------------------------------------------------
; DATOS texto_bogey_doble: "DOUBLE BOGEY", y detras su pista de PSG (7)
;   0x4c4d..0x4c5c  (15 bytes)
DATA_texto_bogey_doble:
	defb 044h,04fh,055h,042h,04ch,045h,020h,020h,020h,042h,04fh,047h,045h,059h,007h	; 4c4d  DOUBLE   BOGEY.

; ----------------------------------------------------------------------
; DATOS texto_bogey_triple: "TRIPLE BOGEY", y detras su pista de PSG (7)
;   0x4c5c..0x4c6b  (15 bytes)
DATA_texto_bogey_triple:
	defb 054h,052h,049h,050h,04ch,045h,020h,020h,020h,042h,04fh,047h,045h,059h,007h	; 4c5c  TRIPLE   BOGEY.

; ----------------------------------------------------------------------
; DATOS texto_calle: "FAIRWAY": donde ha caido la bola
;   0x4c6b..0x4c73  (8 bytes)
DATA_texto_calle:
	defb 007h,046h,041h,049h,052h,057h,041h,059h	; 4c6b  .FAIRWAY

; ----------------------------------------------------------------------
; DATOS texto_rough: "ROUGH"
;   0x4c73..0x4c7b  (8 bytes)
DATA_texto_rough:
	defb 007h,020h,052h,04fh,055h,047h,048h,020h	; 4c73  . ROUGH 

; ----------------------------------------------------------------------
; DATOS texto_bunker: "BUNKER"
;   0x4c7b..0x4c83  (8 bytes)
DATA_texto_bunker:
	defb 007h,020h,042h,055h,04eh,04bh,045h,052h	; 4c7b  . BUNKER

; ----------------------------------------------------------------------
; DATOS texto_agua: "WATER HAZARD"
;   0x4c83..0x4c91  (14 bytes)
DATA_texto_agua:
	defb 057h,041h,054h,045h,052h,020h,020h,020h,048h,041h,05ah,041h,052h,044h	; 4c83  WATER   HAZARD

; ----------------------------------------------------------------------
; DATOS texto_ob: "OB", fuera de limites
;   0x4c91..0x4c96  (5 bytes)
DATA_texto_ob:
	defb 007h,003h,04fh,042h,002h	; 4c91

; ----------------------------------------------------------------------
; DATOS texto_on: "ON", y detras el codigo escribe el numero de golpes
;   0x4c96..0x4c9b  (5 bytes)
DATA_texto_on:
	defb 007h,004h,04fh,04eh,020h	; 4c96

; ----------------------------------------------------------------------
; DATOS texto_hoyo_acabado: "HOLE OUT"
;   0x4c9b..0x4ca6  (11 bytes)
DATA_texto_hoyo_acabado:
	defb 020h,048h,04fh,04ch,045h,002h,003h,04fh,055h,054h,020h	; 4c9b   HOLE..OUT 

; ----------------------------------------------------------------------
; DATOS texto_desempate: "PLAYOFF"
;   0x4ca6..0x4cae  (8 bytes)
DATA_texto_desempate:
	defb 007h,050h,04ch,041h,059h,04fh,046h,046h	; 4ca6  .PLAYOFF

; ----------------------------------------------------------------------
; DATOS texto_dormy: "DORMY HOLE", del MATCH PLAY: quedan tantos hoyos como
;   ventaja
;   0x4cae..0x4cba  (12 bytes)
DATA_texto_dormy:
	defb 044h,04fh,052h,04dh,059h,002h,020h,048h,04fh,04ch,045h,002h	; 4cae  DORMY. HOLE.

; ----------------------------------------------------------------------
; DATOS tabla_resultados: Siete punteros, indice (golpes - par + 3):
;   ALBATROSS, EAGLE, BIRDIE, PAR, BOGEY, DOUBLE BOGEY y TRIPLE BOGEY
;   0x4cba..0x4cc8  (14 bytes)
DATA_tabla_resultados:
	defw 04c1ah,04c29h,04c32h,04c3bh	; 4cba  -> DATA_texto_albatros DATA_texto_eagle DATA_texto_birdie DATA_texto_par
	defw 04c44h,04c4dh,04c5ch	; 4cc2  -> DATA_texto_bogey DATA_texto_bogey_doble DATA_texto_bogey_triple

; ======================================================================
; CODIGO 0x4cc8..0x5009  (833 bytes)
; ======================================================================


L_4CC8:
	ld bc,00007h		;4cc8   ; borra siete casillas
	ld a,020h		;4ccb
	jp 00056h		;4ccd   ; BIOS FILVRM - Fills VRAM with value
L_4CD0:
	push bc			;4cd0   ; el generador de azar: once vueltas sobre 0xC06F
	push hl			;4cd1
	ld b,00bh		;4cd2   ; once, que es lo que hace falta para que se mezcle bien
	ld hl,(0c06fh)		;4cd4
L_4CD7:
	add hl,hl			;4cd7   ; desplaza y realimenta con XOR: un registro de desplazamiento
	rla			;4cd8
	rla			;4cd9
	xor l			;4cda
	rla			;4cdb
	xor l			;4cdc
	srl a		;4cdd
	srl a		;4cdf
	cpl			;4ce1
	and 001h		;4ce2
	or l			;4ce4
	ld l,a			;4ce5
	djnz L_4CD7		;4ce6
	ld (0c06fh),hl		;4ce8   ; la semilla se guarda para la proxima
	pop hl			;4ceb
	pop bc			;4cec
	ret			;4ced
L_4CEE:
	cp b			;4cee   ; resto de dividir A entre B, restando
	ret c			;4cef
	sub b			;4cf0
	jr L_4CEE		;4cf1
L_4CF3:
	ld hl,0c0e1h		;4cf3   ; monta el cuadro del torneo: 0xC077 es el orden de salida y 0xC0BE la clasificacion
	ld de,0c077h		;4cf6
	ld b,024h		;4cf9   ; treinta y seis participantes
L_4CFB:
	ld a,b			;4cfb   ; las dos listas se llenan con 0x23..0x00, una al derecho y otra al reves
	dec a			;4cfc
	ld (hl),a			;4cfd
	ld (de),a			;4cfe
	dec hl			;4cff
	inc de			;4d00
	djnz L_4CFB		;4d01
	ld b,032h		;4d03   ; y se barajan con cincuenta intercambios al azar
L_4D05:
	call L_4D61		;4d05   ; dos posiciones sorteadas...
	ex de,hl			;4d08
	call L_4D61		;4d09
	ld a,(de)			;4d0c   ; ...y se cambian entre si
	ld c,(hl)			;4d0d
	ld (hl),a			;4d0e
	ld a,c			;4d0f
	ld (de),a			;4d10
	djnz L_4D05		;4d11
	ld a,(0c114h)		;4d13   ; 0xC114 es el golfista que ha elegido el jugador
	ld hl,0c078h		;4d16
L_4D19:
	cp (hl)			;4d19   ; se le busca en el orden de salida
	jr z,L_4D1F		;4d1a
	inc hl			;4d1c
	jr L_4D19		;4d1d
L_4D1F:
	ld de,0c078h		;4d1f   ; y se le pone el primero, dejando 0x24 en su hueco
	ld a,(de)			;4d22
	ld c,(hl)			;4d23
	ld (hl),a			;4d24
	ld a,024h		;4d25
	ld (de),a			;4d27
	ld a,c			;4d28
	ld hl,0c0beh		;4d29   ; lo mismo en la clasificacion
L_4D2C:
	cp (hl)			;4d2c
	jr z,L_4D32		;4d2d
	inc hl			;4d2f
	jr L_4D2C		;4d30
L_4D32:
	ld (hl),024h		;4d32
	ld hl,0c016h		;4d34   ; todos los resultados a cero
	ld de,0c017h		;4d37
	ld bc,00049h		;4d3a
	ld (hl),000h		;4d3d
	ldir		;4d3f
	ld b,023h		;4d41   ; y a cada participante se le sortea un numero de 0 a 7
	ld hl,0c09bh		;4d43
L_4D46:
	call L_4CD0		;4d46   ; que sera su dificultad propia para todos los hoyos
	and 007h		;4d49
	ld (hl),a			;4d4b
	inc hl			;4d4c
	djnz L_4D46		;4d4d
	xor a			;4d4f
	ld (0c0f5h),a		;4d50   ; el resultado del jugador todavia no cuenta
	ld hl,0cec3h		;4d53   ; 0xFD son tres hoyos antes del primero
	ld (hl),0fdh		;4d56
L_4D58:
	push hl			;4d58   ; y se simulan tres vueltas en vacio, para que la clasificacion arranque movida
	call L_4EC9		;4d59
	pop hl			;4d5c
	inc (hl)			;4d5d
	jr nz,L_4D58		;4d5e
	ret			;4d60
L_4D61:
	push bc			;4d61   ; una posicion al azar del cuadro
	call L_4CD0		;4d62
	ld b,023h		;4d65   ; modulo treinta y cinco
	call L_4CEE		;4d67
	ld c,a			;4d6a
	ld b,000h		;4d6b
	ld hl,0c078h		;4d6d
	add hl,bc			;4d70
	pop bc			;4d71
	ret			;4d72
L_4D73:
	cp 023h		;4d73   ; el nombre del participante A: 0x23 es el jugador 1, y esta en 0xC0F6
	ld de,0c0f6h		;4d75
	ret z			;4d78
	cp 024h		;4d79   ; 0x24 es el jugador 2, en 0xC104
	ld de,0c104h		;4d7b
	ret z			;4d7e
	ld de,05009h		;4d7f   ; y de 0 a 34, los treinta y cinco profesionales
	inc a			;4d82
L_4D83:
	dec a			;4d83   ; se avanza A nombres
	ret z			;4d84
	push af			;4d85
L_4D86:
	ld a,(de)			;4d86   ; y el final de cada uno es el bit 7 del ultimo caracter
	and a			;4d87
	inc de			;4d88
	jp p,L_4D86		;4d89
	pop af			;4d8c
	jr L_4D83		;4d8d
L_4D8F:
	ld b,000h		;4d8f   ; busca al participante A en la clasificacion
	ld hl,0c0beh		;4d91
L_4D94:
	cp (hl)			;4d94
	jr z,L_4D9B		;4d95
	inc b			;4d97
	inc hl			;4d98
	jr L_4D94		;4d99
L_4D9B:
	ld a,b			;4d9b
L_4D9C:
	and a			;4d9c   ; sube al participante mientras empate con el de arriba
	ret z			;4d9d
	push af			;4d9e
	call L_4EBF		;4d9f   ; el de esta posicion
	call L_4DBE		;4da2
	pop af			;4da5
	push af			;4da6
	push de			;4da7
	dec a			;4da8
	call L_4EBF		;4da9   ; y el de la anterior
	call L_4DBE		;4dac
	pop bc			;4daf
	ld a,b			;4db0
	cp d			;4db1   ; si tienen el mismo resultado, comparten puesto
	jr nz,L_4DBC		;4db2
	ld a,c			;4db4
	cp e			;4db5
	jr nz,L_4DBC		;4db6
	pop af			;4db8
	dec a			;4db9
	jr L_4D9C		;4dba
L_4DBC:
	pop af			;4dbc
	ret			;4dbd
L_4DBE:
	push hl			;4dbe   ; resultado del participante A: 0xC016 con dos bytes por cabeza
	ld hl,0c016h		;4dbf
	add a,a			;4dc2
	ld e,a			;4dc3
	ld d,000h		;4dc4
	add hl,de			;4dc6
	ld e,(hl)			;4dc7
	inc hl			;4dc8
	ld d,(hl)			;4dc9
	pop hl			;4dca
	ret			;4dcb
L_4DCC:
	push bc			;4dcc   ; en que grupo de nueve sale el participante A
	push hl			;4dcd
	ld b,000h		;4dce
	ld hl,0c077h		;4dd0
L_4DD3:
	cp (hl)			;4dd3
	jr z,L_4DDA		;4dd4
	inc hl			;4dd6
	inc b			;4dd7
	jr L_4DD3		;4dd8
L_4DDA:
	ld a,b			;4dda
	ld b,000h		;4ddb
L_4DDD:
	sub 009h		;4ddd   ; nueve por grupo
	jr c,L_4DE4		;4ddf
	inc b			;4de1
	jr L_4DDD		;4de2
L_4DE4:
	ld a,(0c0f4h)		;4de4   ; y se le suma el hoyo por el que va la vuelta
	inc a			;4de7
	add a,b			;4de8
	pop hl			;4de9
	pop bc			;4dea
	ret			;4deb
L_4DEC:
	xor a			;4dec   ; ordena la clasificacion, por burbuja
	ex af,af'			;4ded   ; la bandera de "ha habido cambio" vive en el acumulador alterno
	ld b,023h		;4dee   ; treinta y cinco parejas
	ld hl,0c0beh		;4df0
L_4DF3:
	push hl			;4df3
	ld a,(hl)			;4df4
	call L_4DBE		;4df5   ; el resultado de uno
	inc hl			;4df8
	ld a,(hl)			;4df9
	ex de,hl			;4dfa
	call L_4DBE		;4dfb   ; y el del siguiente
	and a			;4dfe
	sbc hl,de		;4dff   ; si el de abajo es mejor, hay que cambiarlos
	pop hl			;4e01
	jp m,L_4E25		;4e02
	jr nz,L_4E1D		;4e05
	ld a,(hl)			;4e07   ; con el mismo resultado desempata quien va mas adelantado
	call L_4DCC		;4e08
	ld e,a			;4e0b
	inc hl			;4e0c
	ld a,(hl)			;4e0d
	dec hl			;4e0e
	call L_4DCC		;4e0f
	cp e			;4e12
	jr c,L_4E25		;4e13
	jr nz,L_4E1D		;4e15
	ld a,(hl)			;4e17   ; y si tambien empatan, el numero de participante
	inc hl			;4e18
	cp (hl)			;4e19
	dec hl			;4e1a
	jr nc,L_4E25		;4e1b
L_4E1D:
	ld a,(hl)			;4e1d   ; intercambia los dos
	inc hl			;4e1e
	ld c,(hl)			;4e1f
	ld (hl),a			;4e20
	dec hl			;4e21
	ld (hl),c			;4e22
	scf			;4e23   ; y se apunta que ha habido cambio
	ex af,af'			;4e24
L_4E25:
	inc hl			;4e25
	djnz L_4DF3		;4e26
	ex af,af'			;4e28
	jr c,L_4DEC		;4e29   ; mientras haya cambios se vuelve a pasar
L_4E2B:
	ld hl,0c112h		;4e2b   ; la pagina de la clasificacion, desde el primero
	ld (hl),000h		;4e2e
L_4E30:
	ld a,(hl)			;4e30   ; dieciocho lineas por pagina
	ld b,012h		;4e31
	ld hl,03ca3h		;4e33   ; 0x3CA3 es la TERCERA tabla de nombres, la de 0x3C00
L_4E36:
	push af			;4e36
	push bc			;4e37
	call L_4E4D		;4e38
	pop bc			;4e3b
	pop af			;4e3c
	inc a			;4e3d
	djnz L_4E36		;4e3e
	ret			;4e40
L_4E41:
	inc (hl)			;4e41   ; baja una linea, hasta la 19
	ld a,(hl)			;4e42
	cp 013h		;4e43
	jr c,L_4E30		;4e45
L_4E47:
	dec (hl)			;4e47   ; y sube una, sin pasarse del primero
	jp p,L_4E30		;4e48
	jr L_4E41		;4e4b
L_4E4D:
	push af			;4e4d   ; escribe una linea de la clasificacion
	call L_4D9C		;4e4e   ; el puesto, teniendo en cuenta los empates
	inc a			;4e51
	call L_4A4B		;4e52
	pop af			;4e55
	call L_4EBF		;4e56   ; quien es
	push af			;4e59
	cp 023h		;4e5a   ; los profesionales llevan hueco delante...
	ld a,020h		;4e5c
	jr c,L_4E62		;4e5e
	ld a,02fh		;4e60   ; ...y los dos jugadores, una flecha
L_4E62:
	push hl			;4e62
	dec hl			;4e63
	dec hl			;4e64
	dec hl			;4e65
	call 0004dh		;4e66   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;4e69
	pop af			;4e6a
	push af			;4e6b
	call L_4D73		;4e6c   ; el nombre
	inc hl			;4e6f
	inc hl			;4e70
	ld b,00eh		;4e71   ; catorce caracteres como mucho
L_4E73:
	ld a,(de)			;4e73
	push af			;4e74
	and 07fh		;4e75   ; el bit 7 no se dibuja: es solo el terminador
	call L_6893		;4e77
	inc de			;4e7a
	pop af			;4e7b
	dec b			;4e7c
	and a			;4e7d
	jp m,L_4E86		;4e7e   ; y en cuanto aparece, se rellena de espacios
	inc b			;4e81
	djnz L_4E73		;4e82
	jr L_4E8D		;4e84
L_4E86:
	ld a,020h		;4e86
	call L_6893		;4e88
	djnz L_4E86		;4e8b
L_4E8D:
	pop af			;4e8d
	push af			;4e8e
	call L_4DBE		;4e8f   ; el resultado, con su signo
	push hl			;4e92
	ex de,hl			;4e93
	call L_48A8		;4e94
	pop hl			;4e97
	call L_4EBA		;4e98
	pop af			;4e9b
	call L_4DCC		;4e9c   ; y los hoyos que lleva jugados
	cp 012h		;4e9f
	jr nc,L_4EAF		;4ea1   ; dieciocho es la vuelta entera
	and a			;4ea3
	jr z,L_4EAB		;4ea4
	call L_4A4B		;4ea6
	jr L_4EBA		;4ea9
L_4EAB:
	ld b,03dh		;4eab   ; con cero jugados se pone un guion
	jr L_4EB1		;4ead
L_4EAF:
	ld b,046h		;4eaf   ; y con la vuelta acabada, una F de final
L_4EB1:
	ld a,020h		;4eb1
	call L_6893		;4eb3
	ld a,b			;4eb6
	call L_6893		;4eb7
L_4EBA:
	ld de,00006h		;4eba   ; seis columnas hasta la linea siguiente
	add hl,de			;4ebd
	ret			;4ebe
L_4EBF:
	add a,0beh		;4ebf   ; lee la posicion A de la clasificacion
	ld e,a			;4ec1
	ld a,0c0h		;4ec2
	adc a,000h		;4ec4
	ld d,a			;4ec6
	ld a,(de)			;4ec7
	ret			;4ec8
L_4EC9:
	ld a,(0c075h)		;4ec9   ; juega un hoyo para todos los profesionales
	and a			;4ecc   ; con la vuelta acabada no hay nada que simular
	ret nz			;4ecd
	ld a,(0cec3h)		;4ece   ; el hoyo por el que va la partida
	ld (0c0f4h),a		;4ed1
	ld bc,02400h		;4ed4   ; treinta y seis participantes
	ld ix,0c077h		;4ed7   ; y se recorren en el orden de salida
L_4EDB:
	push bc			;4edb
	ld a,(ix+000h)		;4edc
	cp 023h		;4edf   ; 0x23 y 0x24 son los dos jugadores: esos no se simulan
	jr nc,L_4F43		;4ee1
	ld a,c			;4ee3   ; el grupo de nueve en que sale
	ld c,000h		;4ee4
L_4EE6:
	sub 009h		;4ee6
	jr c,L_4EED		;4ee8
	inc c			;4eea
	jr L_4EE6		;4eeb
L_4EED:
	ld a,(0c0f4h)		;4eed   ; el hoyo que le toca a este participante
	add a,c			;4ef0
	cp 012h		;4ef1   ; y si se pasa de dieciocho, todavia no ha llegado
	jr nc,L_4F43		;4ef3
	ld hl,05153h		;4ef5   ; tres tablas de probabilidad
	ld a,(0c0f5h)		;4ef8   ; 0xC0F5 dice si el jugador va por encima o por debajo del par
	and a			;4efb
	jp m,L_4F05		;4efc   ; por debajo: la primera, la mas dura
	jr z,L_4F03		;4eff   ; en el par: la segunda
	inc hl			;4f01   ; y por encima: la tercera, que no deja hacer eagle
	inc hl			;4f02
L_4F03:
	inc hl			;4f03
	inc hl			;4f04
L_4F05:
	ld e,(hl)			;4f05
	inc hl			;4f06
	ld d,(hl)			;4f07
	call L_4CD0		;4f08   ; el dado
	ld c,(ix+000h)		;4f0b   ; y la dificultad propia de este golfista
	ld b,000h		;4f0e
	ld hl,0c09bh		;4f10
	add hl,bc			;4f13
	sub (hl)			;4f14   ; que se le resta
	jr nc,L_4F18		;4f15
	xor a			;4f17
L_4F18:
	ld hl,05130h		;4f18   ; mas su ajuste de la tabla de 0x5130
	add hl,bc			;4f1b
	add a,(hl)			;4f1c
	jr nc,L_4F21		;4f1d
	ld a,0ffh		;4f1f   ; saturando en 255
L_4F21:
	ld hl,0c016h		;4f21   ; su resultado acumulado
	add hl,bc			;4f24
	add hl,bc			;4f25
	ex de,hl			;4f26
L_4F27:
	cp (hl)			;4f27   ; y se busca en que tramo cae el dado
	inc hl			;4f28
	jr z,L_4F30		;4f29
	jr c,L_4F30		;4f2b
	inc hl			;4f2d
	jr L_4F27		;4f2e
L_4F30:
	ld c,(hl)			;4f30   ; el valor del tramo son los golpes sobre el par
	inc c			;4f31
	dec c			;4f32
	ld b,000h		;4f33
	jp p,L_4F39		;4f35
	dec b			;4f38
L_4F39:
	ex de,hl			;4f39   ; que se suman al acumulado
	ld e,(hl)			;4f3a
	inc hl			;4f3b
	ld d,(hl)			;4f3c
	ex de,hl			;4f3d
	add hl,bc			;4f3e
	ex de,hl			;4f3f
	ld (hl),d			;4f40
	dec hl			;4f41
	ld (hl),e			;4f42
L_4F43:
	pop bc			;4f43
	inc c			;4f44   ; siguiente participante
	inc ix		;4f45
	djnz L_4EDB		;4f47
	ret			;4f49
L_4F4A:
	ld a,(0c114h)		;4f4a   ; elegir contra que profesional se juega
	call L_4D73		;4f4d   ; el nombre del elegido
	ld b,00eh		;4f50   ; catorce caracteres
	ld hl,0c104h		;4f52   ; se copia al hueco del jugador 2
L_4F55:
	ld a,(de)			;4f55
	and 07fh		;4f56   ; sin el bit del terminador
	ld (hl),a			;4f58
	ld a,(de)			;4f59
	and a			;4f5a
	jp m,L_4F64		;4f5b
	inc de			;4f5e
	inc hl			;4f5f
	djnz L_4F55		;4f60
	jr L_4F6A		;4f62
L_4F64:
	dec b			;4f64
L_4F65:
	inc hl			;4f65   ; y el resto, espacios
	ld (hl),020h		;4f66
	djnz L_4F65		;4f68
L_4F6A:
	call L_BB43		;4f6a   ; se escribe en pantalla
	ld hl,0c114h		;4f6d
L_4F70:
	call 0009fh		;4f70   ; BIOS CHGET - One character input (waiting) | 0x0D es RETURN: elegido
	cp 00dh		;4f73
	ret z			;4f75
	cp 01eh		;4f76   ; 0x1E y 0x1F son las flechas arriba y abajo
	jr z,L_4F88		;4f78
	cp 01fh		;4f7a
	jr nz,L_4F70		;4f7c
	inc (hl)			;4f7e   ; siguiente de la lista
	ld a,(hl)			;4f7f
	cp 023h		;4f80   ; treinta y cinco, y vuelta a empezar
	jr c,L_4F4A		;4f82
	ld (hl),000h		;4f84
	jr L_4F4A		;4f86
L_4F88:
	dec (hl)			;4f88   ; y hacia atras igual
	jp p,L_4F4A		;4f89
	ld (hl),022h		;4f8c
	jr L_4F4A		;4f8e
L_4F90:
	xor a			;4f90   ; la clasificacion final
L_4F91:
	push af			;4f91   ; busca el primer puesto sin empate
	call L_4D9C		;4f92
	and a			;4f95
	jr nz,L_4F9C		;4f96
	pop af			;4f98
	inc a			;4f99
	jr L_4F91		;4f9a
L_4F9C:
	pop af			;4f9c
	dec a			;4f9d
	ret z			;4f9e
	ld a,023h		;4f9f   ; donde ha quedado el jugador 1
	call L_4D8F		;4fa1
	and a			;4fa4
	jr z,L_4FB8		;4fa5
	ld a,(0c003h)		;4fa7   ; y si hay jugador 2...
	and a			;4faa
	ret z			;4fab
	ld a,024h		;4fac   ; ...donde ha quedado el
	call L_4D8F		;4fae
	and a			;4fb1
	ret nz			;4fb2
	xor a			;4fb3
	ld c,024h		;4fb4
	jr L_4FCE		;4fb6
L_4FB8:
	ld a,(0c003h)		;4fb8
	and a			;4fbb
	jr z,L_4FCA		;4fbc
	ld a,024h		;4fbe
	call L_4D8F		;4fc0
	and a			;4fc3
	jr nz,L_4FCA		;4fc4
	ld a,0ffh		;4fc6
	jr L_4FCE		;4fc8
L_4FCA:
	ld a,001h		;4fca
	ld c,023h		;4fcc
L_4FCE:
	ld (0c116h),a		;4fce   ; 0xC116 se reusa aqui para decir quien ha ganado
	and a			;4fd1
	ld a,001h		;4fd2
	ld (0c075h),a		;4fd4   ; y la vuelta queda cerrada
	ret m			;4fd7
	ld hl,0c0beh		;4fd8
L_4FDB:
	ld a,(hl)			;4fdb
	cp c			;4fdc
	jr nz,L_4FE2		;4fdd
	inc hl			;4fdf
	jr L_4FDB		;4fe0
L_4FE2:
	ld (0c115h),a		;4fe2
	ret			;4fe5
L_4FE6:
	ld a,(0c072h)		;4fe6
	ld hl,0c116h		;4fe9
	cp (hl)			;4fec
	jr nz,L_4FF4		;4fed
	ld a,(0c115h)		;4fef
	jr L_4FF6		;4ff2
L_4FF4:
	add a,023h		;4ff4
L_4FF6:
	ld hl,0c0beh		;4ff6
	push hl			;4ff9
L_4FFA:
	cp (hl)			;4ffa
	jr z,L_5000		;4ffb
	inc hl			;4ffd
	jr L_4FFA		;4ffe
L_5000:
	pop de			;5000
	ld a,(de)			;5001
	ld c,(hl)			;5002
	ld (hl),a			;5003
	ld a,c			;5004
	ld (de),a			;5005
	jp L_4E2B		;5006

; ----------------------------------------------------------------------
; DATOS nombres_de_golfistas: Los 35 rivales del modo TOURNAMENT, en ASCII y
;   pegados: el bit 7 del ultimo caracter marca el final de cada nombre
;   0x5009..0x5130  (295 bytes)
DATA_nombres_de_golfistas:
	defb 043h,03eh,053h,054h,052h,041h,04eh,047h,0c5h,04ch,03eh,057h,041h,044h,04bh,049h	; 5009  C>STRANG.L>WADKI
	defb 04eh,0d3h,043h,03eh,050h,045h,045h,054h,0c5h,052h,03eh,046h,04ch,04fh,059h,0c4h	; 5019  N.C>PEET.R>FLOY.
	defb 043h,03eh,050h,041h,056h,049h,0ceh,04dh,03eh,04fh,04dh,045h,041h,052h,0c1h,043h	; 5029  C>PAVI.M>OMEAR.C
	defb 03eh,053h,054h,041h,044h,04ch,045h,0d2h,042h,03eh,04ch,041h,04eh,047h,045h,0d2h	; 5039  >STADLE.B>LANGE.
	defb 054h,03eh,057h,041h,054h,053h,04fh,0ceh,046h,03eh,05ah,04fh,045h,04ch,04ch,045h	; 5049  T>WATSO.F>ZOELLE
	defb 0d2h,052h,03eh,04dh,041h,04ch,054h,042h,049h,0c5h,048h,03eh,049h,052h,057h,049h	; 5059  .R>MALTBI.H>IRWI
	defb 0ceh,054h,03eh,04bh,049h,054h,0c5h,050h,03eh,053h,054h,045h,057h,041h,052h,0d4h	; 5069  .T>KIT.P>STEWAR.
	defb 04ch,03eh,04dh,049h,05ah,0c5h,048h,03eh,053h,055h,054h,054h,04fh,0ceh,04ah,03eh	; 5079  L>MIZ.H>SUTTO.J>
	defb 053h,049h,04eh,044h,045h,04ch,041h,0d2h,04ah,03eh,04dh,041h,048h,041h,046h,046h	; 5089  SINDELA.J>MAHAFF
	defb 045h,0d9h,053h,03eh,042h,041h,04ch,04ch,045h,053h,054h,045h,052h,04fh,0d3h,050h	; 5099  E.S>BALLESTERO.P
	defb 03eh,04ah,041h,043h,04fh,042h,053h,045h,0ceh,04ch,03eh,052h,049h,04eh,04bh,045h	; 50a9  >JACOBSE.L>RINKE
	defb 0d2h,042h,03eh,045h,041h,053h,054h,057h,04fh,04fh,0c4h,044h,03eh,050h,04fh,04fh	; 50b9  .B>EASTWOO.D>POO
	defb 04ch,045h,0d9h,047h,03eh,042h,055h,052h,04eh,0d3h,053h,03eh,053h,049h,04dh,050h	; 50c9  LE.G>BURN.S>SIMP
	defb 053h,04fh,0ceh,049h,03eh,041h,04fh,04bh,0c9h,04ch,03eh,04eh,045h,04ch,053h,04fh	; 50d9  SO.I>AOK.L>NELSO
	defb 0ceh,04ah,03eh,04eh,049h,043h,04bh,04ch,041h,055h,0d3h,047h,03eh,04eh,04fh,052h	; 50e9  .J>NICKLAU.G>NOR
	defb 04dh,041h,0ceh,04ch,03eh,054h,052h,045h,056h,049h,04eh,0cfh,054h,03eh,04eh,041h	; 50f9  MA.L>TREVIN.T>NA
	defb 04bh,041h,04ah,049h,04dh,0c1h,04dh,03eh,04bh,055h,052h,041h,04dh,04fh,054h,0cfh	; 5109  KAJIM.M>KURAMOT.
	defb 042h,03eh,04ch,049h,045h,054h,05ah,04bh,0c5h,054h,03eh,04fh,05ah,041h,04bh,0c9h	; 5119  B>LIETZK.T>OZAK.
	defb 04eh,03eh,04fh,05ah,041h,04bh,0c9h	; 5129

; ----------------------------------------------------------------------
; DATOS golfistas_ajuste: Un byte por golfista, de 0 a 7, que 0x4F1C suma al
;   azar antes de mirar la tabla de probabilidad: cuanto mas alto, mejor sale
;   la bola
;   0x5130..0x5153  (35 bytes)
DATA_golfistas_ajuste:
	defb 007h,007h,005h,007h,005h,005h,005h,005h,007h,003h,003h,007h,007h,001h,005h,001h	; 5130  ................
	defb 000h,000h,003h,001h,001h,000h,000h,000h,000h,007h,003h,001h,001h,003h,005h,000h	; 5140  ................
	defb 003h,003h,001h	; 5150

; ----------------------------------------------------------------------
; DATOS tabla_probabilidad: Tres punteros a las tres tablas de probabilidad,
;   elegidos por el signo de (0xC0F5)
;   0x5153..0x5159  (6 bytes)
DATA_tabla_probabilidad:
	defw 05159h,05163h,0516dh	; 5153  -> DATA_probabilidad_a DATA_probabilidad_b DATA_probabilidad_c

; ----------------------------------------------------------------------
; DATOS probabilidad_a: Pares (umbral, golpes sobre el par): 0x08 -> +2, 0x24
;   -> +1, 0xB3 -> par, 0xFB -> -1, 0xFF -> -2
;   0x5159..0x5163  (10 bytes)
DATA_probabilidad_a:
	defb 008h,002h	; 5159
	defb 024h,001h	; 515b
	defb 0b3h,000h	; 515d
	defb 0fbh,0ffh	; 515f
	defb 0ffh,0feh	; 5161

; ----------------------------------------------------------------------
; DATOS probabilidad_b: La misma tabla, con el par mas facil: 0x08, 0x31,
;   0xCA, 0xFD, 0xFF
;   0x5163..0x516d  (10 bytes)
DATA_probabilidad_b:
	defb 008h,002h	; 5163
	defb 031h,001h	; 5165
	defb 0cah,000h	; 5167
	defb 0fdh,0ffh	; 5169
	defb 0ffh,0feh	; 516b

; ----------------------------------------------------------------------
; DATOS probabilidad_c: La tercera, de cuatro pares y sin el -2: 0x0D, 0x45,
;   0xD4, 0xFF
;   0x516d..0x5175  (8 bytes)
DATA_probabilidad_c:
	defb 00dh,002h	; 516d
	defb 045h,001h	; 516f
	defb 0d4h,000h	; 5171
	defb 0ffh,0ffh	; 5173

; ======================================================================
; CODIGO 0x5175..0x51e5  (112 bytes)
; ======================================================================


L_5175:
	ld hl,051e5h		;5175
	call L_51BF		;5178
	ld a,002h		;517b
	call L_6B2D		;517d
	ld bc,001e0h		;5180
	call L_66A0		;5183
	ret nc			;5186
	xor a			;5187
	ld (0cec3h),a		;5188
	ld (0c011h),a		;518b
	call L_6636		;518e
	inc a			;5191
	ld (0c008h),a		;5192
	ld hl,00000h		;5195
	ld (0c062h),hl		;5198
	call L_486F		;519b
	call L_488B		;519e
	call 00044h		;51a1   ; BIOS ENASCR - Displays the screen
L_51A4:
	call monta_el_hoyo		;51a4
	call L_6843		;51a7
	call L_4A8D		;51aa
	ld bc,000f0h		;51ad
	call L_66A0		;51b0
	ret nc			;51b3
	ld hl,0cec3h		;51b4
	inc (hl)			;51b7
	ld a,(hl)			;51b8
	cp 012h		;51b9
	jr c,L_51A4		;51bb
	jr L_5175		;51bd
L_51BF:
	push hl			;51bf
	call 00041h		;51c0   ; BIOS DISSCR - Inhibits the screen display
	ld hl,01b00h		;51c3
	ld a,0d0h		;51c6
	call 0004dh		;51c8   ; BIOS WRTVRM - Writes data in VRAM
	call L_66C6		;51cb
	pop de			;51ce
	ld hl,01a46h		;51cf
	ld c,004h		;51d2
L_51D4:
	ld b,015h		;51d4
	call L_6822		;51d6
	push de			;51d9
	ld de,0000bh		;51da
	add hl,de			;51dd
	pop de			;51de
	dec c			;51df
	jr nz,L_51D4		;51e0
	jp 00044h		;51e2   ; BIOS ENASCR - Displays the screen

; ----------------------------------------------------------------------
; DATOS texto_creditos: Cuatro filas: "@ HAL LABORATORY 1985", una en blanco,
;   "PRODUCER F>NAKAMURA" y "PROGRAMMER S>IWATA"
;   0x51e5..0x5224  (63 bytes)
DATA_texto_creditos:
	defb 040h,020h,048h,041h,04ch,020h,04ch,041h,042h,04fh,052h,041h,054h,04fh,052h,059h	; 51e5  @ HAL LABORATORY
	defb 020h,031h,039h,038h,035h,00fh,006h,050h,052h,04fh,044h,055h,043h,045h,052h,020h	; 51f5   1985..PRODUCER 
	defb 020h,020h,046h,03eh,04eh,041h,04bh,041h,04dh,055h,052h,041h,050h,052h,04fh,047h	; 5205    F>NAKAMURAPROG
	defb 052h,041h,04dh,04dh,045h,052h,020h,053h,03eh,049h,057h,041h,054h,041h,003h	; 5215  RAMMER S>IWATA.

; ----------------------------------------------------------------------
; DATOS texto_menu: Las cuatro lineas del menu con sus valores de fabrica;
;   AVERAGE (0x5238), STROKE PLAY (0x524D) y QUEEN SIDE (0x5262) hacen doblete
;   como primera entrada de sus tablas
;   0x5224..0x526e  (74 bytes)
DATA_texto_menu:
	defb 020h,050h,04ch,041h,059h,045h,052h,03eh,03eh,031h,00bh,020h,04ch,045h,056h,045h	; 5224   PLAYER>>1. LEVE
	defb 04ch,020h,03eh,03eh,041h,056h,045h,052h,041h,047h,045h,020h,020h,020h,020h,020h	; 5234  L >>AVERAGE     
	defb 020h,047h,041h,04dh,045h,020h,020h,03eh,03eh,053h,054h,052h,04fh,04bh,045h,020h	; 5244   GAME  >>STROKE 
	defb 050h,04ch,041h,059h,020h,020h,043h,04fh,055h,052h,053h,045h,03eh,03eh,051h,055h	; 5254  PLAY  COURSE>>QU
	defb 045h,045h,04eh,020h,053h,049h,044h,045h,020h,020h	; 5264  EEN SIDE  

; ----------------------------------------------------------------------
; DATOS texto_nivel_experto: "EXPERT"
;   0x526e..0x527a  (12 bytes)
DATA_texto_nivel_experto:
	defb 045h,058h,050h,045h,052h,054h,020h,020h,020h,020h,020h,020h	; 526e  EXPERT      

; ----------------------------------------------------------------------
; DATOS texto_nivel_profesional: "PROFESSIONAL", el rotulo que da nombre al
;   cartucho
;   0x527a..0x5286  (12 bytes)
DATA_texto_nivel_profesional:
	defb 050h,052h,04fh,046h,045h,053h,053h,049h,04fh,04eh,041h,04ch	; 527a  PROFESSIONAL

; ----------------------------------------------------------------------
; DATOS texto_campo_king: "KING SIDE", el segundo campo del cartucho
;   0x5286..0x5292  (12 bytes)
DATA_texto_campo_king:
	defb 04bh,049h,04eh,047h,020h,053h,049h,044h,045h,020h,020h,020h	; 5286  KING SIDE   

; ----------------------------------------------------------------------
; DATOS texto_campo_usuario: "USER", el campo que trae el modo CONSTRUCTION
;   0x5292..0x529e  (12 bytes)
DATA_texto_campo_usuario:
	defb 055h,053h,045h,052h,020h,020h,020h,020h,020h,020h,020h,020h	; 5292  USER        

; ----------------------------------------------------------------------
; DATOS texto_modo_match: "MATCH PLAY"
;   0x529e..0x52aa  (12 bytes)
DATA_texto_modo_match:
	defb 04dh,041h,054h,043h,048h,020h,050h,04ch,041h,059h,020h,020h	; 529e  MATCH PLAY  

; ----------------------------------------------------------------------
; DATOS texto_modo_torneo: "TOURNAMENT"
;   0x52aa..0x52b6  (12 bytes)
DATA_texto_modo_torneo:
	defb 054h,04fh,055h,052h,04eh,041h,04dh,045h,04eh,054h,020h,020h	; 52aa  TOURNAMENT  

; ----------------------------------------------------------------------
; DATOS texto_modo_construccion: "CONSTRUCTION", el editor de campos
;   0x52b6..0x52c2  (12 bytes)
DATA_texto_modo_construccion:
	defb 043h,04fh,04eh,053h,054h,052h,055h,043h,054h,049h,04fh,04eh	; 52b6  CONSTRUCTION

; ----------------------------------------------------------------------
; DATOS texto_pantalla_torneo: La pantalla del torneo: el rotulo TOURNAMENT y
;   las dos lineas " 1UP: " y " 2UP: " donde se teclean los nombres
;   0x52c2..0x52de  (28 bytes)
DATA_texto_pantalla_torneo:
	defb 005h,054h,04fh,055h,052h,04eh,041h,04dh,045h,04eh,054h,006h,00fh,006h,020h,031h	; 52c2  .TOURNAMENT... 1
	defb 055h,050h,03ah,020h,00fh,020h,032h,055h,050h,03ah,020h,00fh	; 52d2  UP: . 2UP: .

; ======================================================================
; CODIGO 0x52de..0x5345  (103 bytes)
; ======================================================================


L_52DE:
	ld hl,01a46h		;52de
	ld de,00020h		;52e1
	ld b,004h		;52e4
L_52E6:
	ld a,020h		;52e6
	call 0004dh		;52e8   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;52eb
	djnz L_52E6		;52ec
	ld a,(0c002h)		;52ee
	ld l,a			;52f1
	ld h,000h		;52f2
	add hl,hl			;52f4
	add hl,hl			;52f5
	add hl,hl			;52f6
	add hl,hl			;52f7
	add hl,hl			;52f8
	ld de,01a46h		;52f9
	add hl,de			;52fc
	ld a,02fh		;52fd
	call 0004dh		;52ff   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0c003h)		;5302
	add a,031h		;5305
	ld hl,01a4fh		;5307
	call 0004dh		;530a   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0c007h)		;530d
	ld hl,05353h		;5310
	call saca_de_tabla		;5313
	ld hl,01a6fh		;5316
	call L_5337		;5319
	ld a,(0c005h)		;531c
	ld hl,05345h		;531f
	call saca_de_tabla		;5322
	ld hl,01a8fh		;5325
	call L_5337		;5328
	ld a,(0c004h)		;532b
	ld hl,0534dh		;532e
	call saca_de_tabla		;5331
	ld hl,01aafh		;5334
L_5337:
	ld b,00ch		;5337
	jp L_6822		;5339
saca_de_tabla:		; Devuelve en DE la entrada A de una tabla de punteros que empieza en HL
	add a,a			;533c   ; dos bytes por entrada
	ld e,a			;533d
	ld d,000h		;533e
	add hl,de			;5340
	ld e,(hl)			;5341   ; y devuelve el puntero en DE
	inc hl			;5342
	ld d,(hl)			;5343
	ret			;5344

; ----------------------------------------------------------------------
; DATOS tabla_rotulos_modo: Cuatro punteros a los rotulos de GAME
;   0x5345..0x534d  (8 bytes)
DATA_tabla_rotulos_modo:
	defw 0524dh,0529eh,052aah,052b6h	; 5345  -> 0x524d DATA_texto_modo_match DATA_texto_modo_torneo DATA_texto_modo_construccion

; ----------------------------------------------------------------------
; DATOS tabla_rotulos_campo: Tres punteros a los rotulos de COURSE
;   0x534d..0x5353  (6 bytes)
DATA_tabla_rotulos_campo:
	defw 05262h,05286h,05292h	; 534d  -> 0x5262 DATA_texto_campo_king DATA_texto_campo_usuario

; ----------------------------------------------------------------------
; DATOS tabla_rotulos_nivel: Tres punteros a los rotulos de LEVEL
;   0x5353..0x5359  (6 bytes)
DATA_tabla_rotulos_nivel:
	defw 05238h,0526eh,0527ah	; 5353  -> 0x5238 DATA_texto_nivel_experto DATA_texto_nivel_profesional

; ======================================================================
; CODIGO 0x5359..0x5495  (316 bytes)
; ======================================================================


juega_un_golpe:		; Un golpe entero: punteria, palo, fuerza, curva y salida de la bola
	call L_680A		;5359   ; repinta la parte de abajo del panel
	call L_4AB2		;535c   ; y el palo elegido
	xor a			;535f   ; las banderas del vuelo, a cero
	ld (0c633h),a		;5360
	ld (0c634h),a		;5363
	ld (0c623h),a		;5366
	ld (0c622h),a		;5369
	ld hl,(0c012h)		;536c   ; 0xC644 es el punto de mira que se mueve con la cruceta
	ld (0c644h),hl		;536f
	ld a,(0c117h)		;5372   ; 0xC117 dice que el golpe lo repite la maquina
	and a			;5375
	jp nz,repite_el_golpe		;5376
	call pinta_los_sprites		;5379   ; dibuja al golfista
	call mueve_la_punteria		;537c   ; y deja mover la punteria
	ld a,(0c009h)		;537f
	call pinta_los_sprites		;5382
	ld b,003h		;5385   ; tres cuadros de respiro
	call L_6698		;5387
	call barra_de_fuerza		;538a   ; la barra de fuerza
	jr c,juega_un_golpe		;538d   ; si se ha cancelado, vuelta a empezar
	ld a,(0c641h)		;538f   ; la fuerza de verdad es la de la barra por ocho...
	add a,a			;5392
	add a,a			;5393
	add a,a			;5394
	add a,01fh		;5395   ; ...mas 0x1F, que es lo que no se puede quitar
	ld (0c61dh),a		;5397
	ld b,003h		;539a   ; otros tres cuadros
	call L_6698		;539c
	ld a,(0c621h)		;539f   ; con el putter no hay barra de curva
	cp 00dh		;53a2
	call c,barra_de_curva		;53a4
L_53A7:
	ld hl,0c641h		;53a7   ; la fuerza no puede quedar negativa
	ld a,(hl)			;53aa
	and a			;53ab
	jp p,L_53B1		;53ac
	ld (hl),000h		;53af
L_53B1:
	ld a,(0c007h)		;53b1   ; en AVERAGE cada palo tiene su ventana...
	and a			;53b4
	ld a,(0c621h)		;53b5
	jr z,L_53BB		;53b8
	rra			;53ba   ; ...y de EXPERT en adelante, una por cada dos palos
L_53BB:
	add a,a			;53bb   ; dos bytes por entrada
	ld e,a			;53bc
	ld d,000h		;53bd
	ld hl,05495h		;53bf   ; la tabla de ventanas
	add hl,de			;53c2
	ld a,(0c641h)		;53c3   ; donde se ha parado la barra de curva
	cp (hl)			;53c6   ; por debajo del limite de abajo es gancho
	jr nc,L_53D4		;53c7
	sub (hl)			;53c9   ; lo que falta
	neg		;53ca
	call L_53FD		;53cc
	ld (0c623h),a		;53cf   ; y se guarda como gancho
	jr L_53E1		;53d2
L_53D4:
	inc hl			;53d4   ; por encima del limite de arriba es slice
	cp (hl)			;53d5
	jr c,L_53E1		;53d6
	jr z,L_53E1		;53d8
	sub (hl)			;53da   ; lo que sobra
	call L_53FD		;53db
	ld (0c622h),a		;53de   ; y se guarda como slice
L_53E1:
	ld a,(0c006h)		;53e1   ; 0xC006 corta la animacion en la exhibicion
	and a			;53e4
	jr nz,L_53EE		;53e5
	ld a,(0c118h)		;53e7   ; y con la maquina jugando tampoco se anima
	and a			;53ea
	call z,L_9E38		;53eb   ; el swing del golfista
L_53EE:
	ld a,(0c60eh)		;53ee   ; guarda de donde sale la bola
	ld (0cf0fh),a		;53f1
	ld a,(0c611h)		;53f4
	ld (0cf10h),a		;53f7
	jp sale_la_bola		;53fa   ; y a volar
L_53FD:
	cp 009h		;53fd   ; nueve es el desvio maximo
	jr c,L_5403		;53ff
	ld a,009h		;5401
L_5403:
	neg		;5403   ; once menos el desvio: cuanto peor el golpe, menor el numero
	add a,00bh		;5405
	ret			;5407
repite_el_golpe:		; Repite el golpe que la maquina ya ha decidido, moviendo las barras hasta sus valores
	call L_5435		;5408   ; mueve la punteria hasta donde ha elegido la maquina
	call L_5461		;540b   ; y la barra de fuerza hasta su valor
	ld a,(0c665h)		;540e   ; la fuerza, con la misma cuenta
	add a,a			;5411
	add a,a			;5412
	add a,a			;5413
	add a,01fh		;5414
	ld (0c61dh),a		;5416
	ld a,(0c667h)		;5419   ; el palo que ha elegido
	ld (0c621h),a		;541c
	cp 00dh		;541f   ; con el putter no hay barra de curva
	jp nc,L_53A7		;5421
	call L_5477		;5424   ; y si no, se mueve tambien esa
	ld a,(0c666h)		;5427
	ld (0c641h),a		;542a
	ld b,03ch		;542d   ; un segundo de espera
	call L_6698		;542f
	jp L_53A7		;5432
L_5435:
	ld a,(0c65fh)		;5435   ; lleva la punteria de donde esta a donde quiere la maquina
	ld b,a			;5438
	ld a,(0c61fh)		;5439   ; el angulo de ahora
	ld c,a			;543c
	sub b			;543d
	ld a,c			;543e
	ld c,0ffh		;543f   ; un paso a la derecha...
	jp p,L_5446		;5441
	ld c,001h		;5444   ; ...o a la izquierda
L_5446:
	push af			;5446
	push bc			;5447
	ld (0c61fh),a		;5448
	call pinta_el_punto_de_mira		;544b   ; redibuja el punto de mira
	call L_6666		;544e
	pop bc			;5451
	pop af			;5452
	cp b			;5453   ; hasta llegar
	jr z,L_5459		;5454
	add a,c			;5456
	jr L_5446		;5457
L_5459:
	ld (0c61fh),a		;5459
	ld b,03ch		;545c   ; y un segundo mirando
	jp L_6698		;545e
L_5461:
	call arranca_la_barra		;5461   ; mueve la barra de fuerza hasta el valor elegido
L_5464:
	call paso_de_la_barra_de_fuerza		;5464   ; un paso de la barra
	ld a,(0c641h)		;5467
	ld b,a			;546a
	ld a,(0c665h)		;546b   ; y para cuando coincide
	cp b			;546e
	jr nz,L_5464		;546f
	ex af,af'			;5471   ; A' cuenta las pasadas que puede dar
	dec a			;5472
	ret z			;5473
	ex af,af'			;5474
	jr L_5464		;5475
L_5477:
	call arranca_la_barra		;5477   ; lo mismo con la barra de curva
	ld a,(0c666h)		;547a   ; la mitad de las veces se arranca desde uno...
	and 001h		;547d
	ld (0c641h),a		;547f   ; ...para que la barra no vaya siempre igual
L_5482:
	call paso_de_la_barra_de_curva		;5482
	ld a,(0c641h)		;5485
	ld b,a			;5488
	ld a,(0c666h)		;5489
	cp b			;548c
	jr nz,L_5482		;548d
	ex af,af'			;548f
	dec a			;5490
	ret z			;5491
	ex af,af'			;5492
	jr L_5482		;5493

; ----------------------------------------------------------------------
; DATOS ventana_del_palo: Trece parejas -limite de abajo y de arriba- de la
;   barra de curva, una por palo. Solo llega hasta el palo 12: los dos putters
;   no tienen entrada
;   0x5495..0x54af  (26 bytes)
DATA_ventana_del_palo:
	defb 01bh,01ch	; 5495
	defb 01bh,01ch	; 5497
	defb 01bh,01ch	; 5499
	defb 01bh,01ch	; 549b
	defb 01ah,01dh	; 549d
	defb 01ah,01dh	; 549f
	defb 01ah,01dh	; 54a1
	defb 01ah,01dh	; 54a3
	defb 019h,01eh	; 54a5
	defb 019h,01eh	; 54a7
	defb 019h,01eh	; 54a9
	defb 018h,01fh	; 54ab
	defb 018h,01fh	; 54ad

; ======================================================================
; CODIGO 0x54af..0x63e9  (3898 bytes)
; ======================================================================


mueve_la_punteria:		; La cruceta gira el punto de mira; el disparo lo acepta
	ld a,(0ca34h)		;54af   ; 0xCA34 es el mando que se esta leyendo
	cp 002h		;54b2   ; el mando 2 se lee de otra manera
	jr z,L_5507		;54b4
	ld b,002h		;54b6   ; dos cuadros
	call L_6698		;54b8
	call parpadea_la_flecha		;54bb   ; el color de la flecha del jugador
	call pinta_el_punto_de_mira		;54be   ; redibuja el punto de mira
	call L_6A4F		;54c1   ; disparo: se acepta la punteria
	ret nz			;54c4
	ld a,(0c006h)		;54c5   ; en la exhibicion la maquina mueve la punteria sola
	and a			;54c8
	call nz,L_B243		;54c9
	call L_BBE5		;54cc   ; y el teclado tambien vale
	jr z,mueve_la_punteria		;54cf
	call L_BBEF		;54d1
	jr z,mueve_la_punteria		;54d4
	call L_6A6F		;54d6   ; la cruceta
	ld b,a			;54d9
	ld hl,0c61fh		;54da
	cp 003h		;54dd   ; codigo 3: gira a la derecha
	jr nz,L_54E2		;54df
	inc (hl)			;54e1
L_54E2:
	cp 007h		;54e2   ; codigo 7: gira a la izquierda
	jr nz,L_54E7		;54e4
	dec (hl)			;54e6
L_54E7:
	call elige_palo		;54e7   ; elige palo; devuelve carry si no se puede golpear
	jr nc,mueve_la_punteria		;54ea
	ld a,b			;54ec
	cp 001h		;54ed   ; codigo 1: palo mas corto
	jr nz,L_54F7		;54ef
	dec (hl)			;54f1
	call acota_el_palo		;54f2
	jr L_5500		;54f5
L_54F7:
	cp 005h		;54f7   ; codigo 5: palo mas largo
	jp nz,mueve_la_punteria		;54f9
	inc (hl)			;54fc
	call acota_el_palo		;54fd
L_5500:
	call L_6A6F		;5500   ; y no se admite otra pulsacion hasta que suelten
	jr nz,L_5500		;5503
	jr mueve_la_punteria		;5505
L_5507:
	call elige_palo		;5507   ; el mando 2: la punteria se mueve como un cursor libre
L_550A:
	call parpadea_la_flecha		;550a
	call L_6A84		;550d   ; lee el mando 2 por el PSG
	ld hl,(0c644h)		;5510   ; la posicion del cursor
	ld a,l			;5513
	add a,c			;5514
	cp 0f8h		;5515   ; topes en X: de 0x58 a 0xF7
	jr c,L_551B		;5517
	ld a,0f7h		;5519
L_551B:
	cp 058h		;551b
	jr nc,L_5521		;551d
	ld a,058h		;551f
L_5521:
	ld l,a			;5521
	ld a,h			;5522
	add a,e			;5523
	cp 0f7h		;5524   ; y en Y: de 0 a 0xBF
	jr c,L_5529		;5526
	xor a			;5528
L_5529:
	cp 0c0h		;5529
	jr c,L_552F		;552b
	ld a,0bfh		;552d
L_552F:
	ld h,a			;552f
	ld (0c644h),hl		;5530
	call L_47B0		;5533   ; el angulo que resulta
	ld (0c61fh),a		;5536
	ld hl,(0c644h)		;5539
	ld a,h			;553c
	ld c,l			;553d
	call L_55B0		;553e
	call L_6A4F		;5541
	jr z,L_550A		;5544
L_5546:
	call pinta_los_sprites		;5546   ; el mando 2 tambien mueve la fuerza del putt
	call elige_palo		;5549
	ret nc			;554c
	call L_6A84		;554d
	ld a,e			;5550   ; el eje vertical
	and a			;5551
	jr z,L_556A		;5552
	add a,a			;5554
	add a,a			;5555
	add a,a			;5556
	add a,a			;5557
	ld b,000h		;5558
	jr nc,L_555D		;555a
	dec b			;555c
L_555D:
	ld de,0c647h		;555d   ; que se suma a 0xC647
	ex de,hl			;5560
	add a,(hl)			;5561
	ld (hl),a			;5562
	ex de,hl			;5563
	ld a,b			;5564
	adc a,(hl)			;5565
	ld (hl),a			;5566
	call acota_el_palo		;5567
L_556A:
	call L_6A4F		;556a
	ret nz			;556d
	jr L_5546		;556e
acota_el_palo:		; Deja el numero de palo entre 0 y 13 y repinta el rotulo
	ld a,(hl)			;5570   ; si se ha pasado por debajo...
	and a			;5571
	jp p,L_5577		;5572
	ld a,00dh		;5575   ; ...se va al ultimo
L_5577:
	cp 00eh		;5577   ; y de catorce en adelante, vuelta al primero
	jr c,L_557C		;5579
	xor a			;557b
L_557C:
	ld (hl),a			;557c
	jp L_4AB2		;557d   ; repinta el rotulo del palo
elige_palo:		; En el green fuerza el putter; en el campo no deja pasar de el
	ld a,(0c011h)		;5580   ; 0xC011 dice que se juega en el green
	and a			;5583
	ld hl,0c621h		;5584
	jr z,L_5590		;5587
	ld (hl),00eh		;5589   ; y alli el palo es siempre el 14, el segundo putter
	call L_4AB2		;558b
	and a			;558e
	ret			;558f
L_5590:
	ld a,(hl)			;5590   ; en el campo el putter es el 13
	cp 00eh		;5591
	ret c			;5593
	dec (hl)			;5594   ; y del 14 se vuelve al 13, con carry: no se golpea
	scf			;5595
	ret			;5596
pinta_el_punto_de_mira:		; Coloca el sprite de la mira segun el angulo (0xC61F)
	ld a,010h		;5597   ; dieciseis de radio
	ld (0c620h),a		;5599
	ld a,(0c61fh)		;559c   ; el angulo
	push af			;559f
	call coseno_por_modulo		;55a0   ; el coseno da el desplazamiento en X...
	ld a,(0c60eh)		;55a3
	add a,l			;55a6
	ld c,a			;55a7
	pop af			;55a8
	call seno_por_modulo		;55a9   ; ...y el seno el de Y
	ld a,(0c611h)		;55ac
	add a,l			;55af
L_55B0:
	ld hl,01b08h		;55b0   ; escribe los cuatro bytes del sprite
	sub 003h		;55b3
	call L_6893		;55b5
	ld a,c			;55b8
	sub 002h		;55b9
	call L_6893		;55bb
	ld a,00ch		;55be   ; dibujo 12
	call L_6893		;55c0
	ld a,00fh		;55c3   ; y color 15
	jp 0004dh		;55c5   ; BIOS WRTVRM - Writes data in VRAM
parpadea_la_flecha:		; Alterna el color de la flecha del jugador que juega
	ld hl,01b03h		;55c8   ; 0x1B03 es el atributo del sprite de la flecha
	ld a,(0c009h)		;55cb
	and a			;55ce
	ld e,00fh		;55cf   ; color 15 para el jugador 1
	jr z,L_55D9		;55d1
	ld e,009h		;55d3   ; y color 9 para el 2
	inc hl			;55d5
	inc hl			;55d6
	inc hl			;55d7
	inc hl			;55d8
L_55D9:
	call 0004ah		;55d9   ; BIOS RDVRM - Reads the content of VRAM | lee el color de ahora
	cp 002h		;55dc   ; si estaba en 2, se pone el suyo...
	ld a,e			;55de
	jr z,L_55E3		;55df
	ld a,002h		;55e1   ; ...y si no, en 2: asi parpadea
L_55E3:
	jp 0004dh		;55e3   ; BIOS WRTVRM - Writes data in VRAM
barra_de_fuerza:		; Sube y baja la barra hasta que el disparo la para
	call arranca_la_barra		;55e6   ; arranca la barra
L_55E9:
	call paso_de_la_barra_de_fuerza		;55e9   ; un paso
	call L_6A4F		;55ec   ; disparo: parada
	ret nz			;55ef
	ld a,007h		;55f0   ; fila 7 de la matriz del teclado
	call 00141h		;55f2   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 010h		;55f5   ; y su bit 4 es la tecla STOP
	scf			;55f7   ; con STOP se cancela el golpe
	ret z			;55f8
	ld a,004h		;55f9   ; el segundo disparo tambien cancela
	call 000d8h		;55fb   ; BIOS GTTRIG - Returns current trigger status
	and a			;55fe
	scf			;55ff
	ret nz			;5600
	jr L_55E9		;5601
arranca_la_barra:		; Deja la barra en cero, elige su velocidad y cuenta las pasadas
	call L_4CD0		;5603   ; de una a cuatro pasadas antes de que se pare sola
	and 003h		;5606
	inc a			;5608
	ex af,af'			;5609
	ld a,(0c007h)		;560a   ; la velocidad sale del nivel
	srl a		;560d
	inc a			;560f
	ld (0c642h),a		;5610   ; en AVERAGE va a uno, en PROFESSIONAL a dos
	ld a,0ffh		;5613   ; arranca subiendo
	ld (0c643h),a		;5615
	inc a			;5618
	ld (0c641h),a		;5619   ; y desde cero
	ret			;561c
paso_de_la_barra_de_fuerza:		; Un paso de la barra, con su rebote arriba y abajo
	ld hl,0c641h		;561d   ; 0xC641 es la barra y 0xC643 el sentido
	ld a,(0c643h)		;5620
	and a			;5623
	jr nz,L_5628		;5624
	inc (hl)			;5626   ; subiendo se suma dos y se resta uno
	inc (hl)			;5627
L_5628:
	dec (hl)			;5628   ; bajando, solo se resta
	ld a,(hl)			;5629
	and a			;562a
	jp p,L_5634		;562b   ; si llega por debajo de cero...
	ld (hl),000h		;562e   ; ...se queda en cero y cambia el sentido
	xor a			;5630
	ld (0c643h),a		;5631
L_5634:
	cp 01dh		;5634   ; y a 0x1D...
	jr c,L_563F		;5636
	ld (hl),01ch		;5638   ; ...se queda en 0x1C y cambia
	ld a,0ffh		;563a
	ld (0c643h),a		;563c
L_563F:
	call L_6666		;563f   ; un cuadro
	ld a,(0c007h)		;5642   ; en AVERAGE, dos: la barra va a la mitad de velocidad
	and a			;5645
	call z,L_6666		;5646
	ld a,(0c641h)		;5649   ; cada casilla de la barra son cuatro pasos
	rrca			;564c
	rrca			;564d
	and 007h		;564e
	ld b,a			;5650
	ld hl,01a68h		;5651   ; 0x1A68 es el extremo derecho de la barra
	jr z,L_565E		;5654
L_5656:
	ld a,05fh		;5656   ; 0x5F es la casilla llena
	call 0004dh		;5658   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;565b
	djnz L_5656		;565c
L_565E:
	ld a,(0c641h)		;565e   ; y el resto son los cuatro dibujos parciales
	and 003h		;5661
	jr z,L_566B		;5663
	add a,05bh		;5665   ; 0x5B es el primero de los cuatro
	call 0004dh		;5667   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;566a
L_566B:
	ld a,l			;566b   ; y de ahi al principio de la barra, todo a cero
	cp 062h		;566c
	ret c			;566e
	xor a			;566f
	call 0004dh		;5670   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;5673
	jr L_566B		;5674
barra_de_curva:		; La segunda barra: el disparo la para
	call arranca_la_barra		;5676   ; arranca la barra
L_5679:
	call paso_de_la_barra_de_curva		;5679   ; un paso
	call L_6A4F		;567c   ; disparo: parada
	ret nz			;567f
	jr L_5679		;5680
paso_de_la_barra_de_curva:		; Un paso de la barra de curva, entre 0 y 0x38
	ld a,(0c643h)		;5682   ; el sentido
	and a			;5685
	ld a,(0c641h)		;5686
	ld hl,0c642h		;5689
	jr nz,L_5690		;568c
	add a,(hl)			;568e   ; subiendo se suma dos veces la velocidad...
	add a,(hl)			;568f
L_5690:
	sub (hl)			;5690   ; ...y siempre se resta una
	and a			;5691
	jp p,L_569D		;5692   ; por debajo de cero se da la vuelta
	push af			;5695
	xor a			;5696
	ld (0c643h),a		;5697
	pop af			;569a
	jr L_56A8		;569b
L_569D:
	cp 038h		;569d   ; y a 0x38 tambien
	jr c,L_56A8		;569f
	push af			;56a1
	ld a,0ffh		;56a2
	ld (0c643h),a		;56a4
	pop af			;56a7
L_56A8:
	ld (0c641h),a		;56a8
	call L_6666		;56ab   ; un cuadro
	ld hl,01b1ch		;56ae   ; la barra de curva es un sprite
	ld a,0afh		;56b1
	call L_6893		;56b3
	ld a,(0c641h)		;56b6   ; la posicion es 0x44 menos el valor
	neg		;56b9
	add a,044h		;56bb
	call L_6893		;56bd
	ld a,018h		;56c0   ; dibujo 24
	call L_6893		;56c2
	ld a,00bh		;56c5   ; y color 11
	jp 0004dh		;56c7   ; BIOS WRTVRM - Writes data in VRAM
rueda_el_putt:		; El putt: la bola rueda por el green hasta pararse
	xor a			;56ca   ; sin rebote
	ld (0c672h),a		;56cb
	call guarda_el_vector		;56ce   ; guarda el vector de salida
	ld a,080h		;56d1   ; y la posicion en coma fija arranca centrada
	ld (0c616h),a		;56d3
	ld (0c618h),a		;56d6
L_56D9:
	call mueve_la_bola		;56d9   ; mueve la bola un paso
	call pinta_los_sprites		;56dc   ; la redibuja
	call distancia_al_hoyo		;56df   ; mira contra el terreno
	ld hl,0c664h		;56e2   ; 0xC664 guarda lo mas cerca que ha pasado del hoyo
	cp (hl)			;56e5
	jr nc,L_56F7		;56e6
	ld (hl),a			;56e8
	ld a,(0c60eh)		;56e9
	ld l,a			;56ec
	ld a,(0c611h)		;56ed
	ld h,a			;56f0
	call L_47B0		;56f1   ; y desde donde
	ld (0c660h),a		;56f4
L_56F7:
	ld a,(0c634h)		;56f7   ; 0xC634 dice que ha chocado con algo
	and a			;56fa
	jr z,L_5735		;56fb
	ld a,(0c630h)		;56fd   ; y 0xC630 que ya ha rebotado una vez
	and a			;5700
	jr nz,L_5735		;5701
	ld a,(0c007h)		;5703   ; el nivel decide cuanto rebota
	add a,a			;5706
	add a,a			;5707
	add a,a			;5708
	ld hl,0c61eh		;5709
	add a,(hl)			;570c
	cp 03ch		;570d   ; por debajo de 0x3C la bola se para
	ret c			;570f
	ld a,001h		;5710   ; se apunta que ha rebotado
	ld (0c672h),a		;5712
	call L_4CD0		;5715   ; y el rebote sale con un angulo sorteado
	ld b,a			;5718
	and 01fh		;5719
	add a,007h		;571b   ; siete grados de base
	bit 7,b		;571d   ; con signo al azar
	jr z,L_5723		;571f
	neg		;5721
L_5723:
	ld hl,0c61fh		;5723
	add a,(hl)			;5726
	ld (hl),a			;5727
	ld hl,0c61eh		;5728   ; y la velocidad se parte por la mitad
	srl (hl)		;572b
	call guarda_el_vector		;572d
	ld a,001h		;5730
	ld (0c630h),a		;5732
L_5735:
	xor a			;5735   ; la bandera de choque se limpia
	ld (0c634h),a		;5736
	ld a,(0c633h)		;5739   ; si la bola ha entrado, se acabo
	and a			;573c
	ret nz			;573d
	call espera_un_cuadro		;573e
	ld a,(0c61eh)		;5741   ; y por debajo de cinco de velocidad, se para
	cp 005h		;5744
	jr nc,L_56D9		;5746
	ret			;5748
guarda_el_vector:		; Descompone la velocidad (0xC61E) y el angulo (0xC61F) en sus dos componentes
	ld a,(0c61eh)		;5749   ; la velocidad
	ld (0c620h),a		;574c
	ld a,(0c61fh)		;574f   ; y el angulo
	push af			;5752
	call coseno_por_modulo		;5753   ; componente X
	ld (0c617h),a		;5756
	pop af			;5759
	call seno_por_modulo		;575a   ; y componente Y
	ld (0c619h),a		;575d
	ret			;5760
espera_un_cuadro:		; Un cuadro, salvo si esta jugando la maquina
	ld a,(0c118h)		;5761   ; con la maquina jugando no se espera
	and a			;5764
	ret nz			;5765
	jp L_6666		;5766
mueve_la_bola:		; Dos pasos de la bola por cuadro, con su rozamiento
	ld b,002h		;5769   ; dos pasos por cuadro
L_576B:
	ld a,(0c617h)		;576b   ; la componente X
	call extiende_el_signo		;576e
	ld hl,(0c60dh)		;5771   ; se suma a la posicion en coma fija
	add hl,de			;5774
	ld (0c60dh),hl		;5775
	ld a,(0c619h)		;5778   ; y la Y igual
	call extiende_el_signo		;577b
	ld hl,(0c610h)		;577e
	add hl,de			;5781
	ld (0c610h),hl		;5782
	djnz L_576B		;5785
	ld hl,0c631h		;5787   ; 0xC631 cuenta los pasos
	inc (hl)			;578a
	ld a,(hl)			;578b
	rrca			;578c   ; y el rozamiento solo se aplica uno de cada dos
	ret nc			;578d
	ld a,010h		;578e   ; dieciseis de modulo
	ld (0c620h),a		;5790
	ld a,(0c61fh)		;5793   ; el angulo contrario al de la marcha
	add a,080h		;5796
	call acumula_una_fuerza		;5798
	ld a,(0c614h)		;579b   ; y el desnivel del green, con su direccion
	ld (0c620h),a		;579e
	ld a,(0c615h)		;57a1
	call acumula_una_fuerza		;57a4
	ld hl,(0c617h)		;57a7   ; de las dos componentes acumuladas...
	ld de,(0c619h)		;57aa
	push hl			;57ae
	push de			;57af
	call L_6510		;57b0   ; ...salen la velocidad nueva...
	ld (0c61eh),a		;57b3
	pop de			;57b6
	pop hl			;57b7
	call L_64C5		;57b8   ; ...y el angulo nuevo
	ld (0c61fh),a		;57bb
	ret			;57be
acumula_una_fuerza:		; Suma a las dos componentes de 0xC616/0xC618 un vector de modulo (0xC620) y angulo A
	push af			;57bf   ; el coseno
	call coseno_por_modulo		;57c0
	add hl,hl			;57c3   ; por dieciseis
	add hl,hl			;57c4
	add hl,hl			;57c5
	add hl,hl			;57c6
	ex de,hl			;57c7
	ld hl,(0c616h)		;57c8
	add hl,de			;57cb   ; que se acumula en X
	ld (0c616h),hl		;57cc
	pop af			;57cf
	call seno_por_modulo		;57d0   ; y el seno igual en Y
	add hl,hl			;57d3
	add hl,hl			;57d4
	add hl,hl			;57d5
	add hl,hl			;57d6
	ex de,hl			;57d7
	ld hl,(0c618h)		;57d8
	add hl,de			;57db
	ld (0c618h),hl		;57dc
	ret			;57df
seno_por_modulo:		; El seno del angulo A por (0xC620), con signo
	call L_6558		;57e0
	jr L_57E8		;57e3
coseno_por_modulo:		; El coseno del angulo A por (0xC620), con signo
	call L_655A		;57e5
L_57E8:
	ld a,(0c620h)		;57e8   ; el modulo
	call L_6552		;57eb
	ld l,a			;57ee
	ld h,000h		;57ef
	and a			;57f1   ; y se extiende el signo a HL
	ret p			;57f2
	dec h			;57f3
	ret			;57f4
extiende_el_signo:		; Pasa A con signo a DE
	and a			;57f5
	ld e,a			;57f6
	ld d,000h		;57f7
	ret p			;57f9
	dec d			;57fa
	ret			;57fb
sale_la_bola:		; Arranca el vuelo: pone la fisica a cero y saca los datos del palo
	ld hl,00000h		;57fc   ; la posicion en coma fija, a cero
	ld (0c612h),hl		;57ff
	ld (0c64ah),hl		;5802
	ld a,080h		;5805   ; 0x80 es el medio pixel: la bola arranca centrada en su casilla
	ld (0c60ch),a		;5807
	ld (0c60fh),a		;580a
	ld (0c60dh),a		;580d
	ld (0c610h),a		;5810
	ld a,001h		;5813   ; 0xC624 es la cuenta atras del efecto
	ld (0c624h),a		;5815
	ld a,(0c011h)		;5818   ; en el campo se recoloca la camara
	and a			;581b
	call z,L_629C		;581c
	ld a,(0c638h)		;581f   ; de donde sale la bola
	ld (0c628h),a		;5822
	ld (0c627h),a		;5825
	xor a			;5828   ; y las banderas de vuelo a cero
	ld (0c62bh),a		;5829
	ld (0c62eh),a		;582c
	ld (0c630h),a		;582f
	ld (0c66ah),a		;5832
	ld (0c66bh),a		;5835
	ld a,(0c639h)		;5838   ; 0xC639 dice que la bola estaba en el rough
	and a			;583b
	jr z,L_586E		;583c
	ld a,(0c011h)		;583e   ; en el green no hay rough
	and a			;5841
	jr nz,L_586E		;5842
	ld a,(0c11ah)		;5844   ; ni cuando se golpea desde el punto de castigo
	and a			;5847
	jr nz,L_5863		;5848
	ld b,026h		;584a   ; 0x26 de dispersion en AVERAGE...
	ld a,(0c007h)		;584c
	cp 002h		;584f   ; ...y 0x40 en PROFESSIONAL
	jr nz,L_5855		;5851
	ld b,040h		;5853
L_5855:
	push bc			;5855
	call L_4CD0		;5856   ; un numero al azar
	pop bc			;5859
	call L_4CEE		;585a
	add a,00ch		;585d   ; que se convierte en un porcentaje por debajo de cien
	cpl			;585f
	ld e,a			;5860
	jr L_5865		;5861
L_5863:
	ld e,0e6h		;5863   ; desde el punto de castigo la perdida es fija
L_5865:
	ld a,(0c61dh)		;5865   ; y la fuerza se recorta en esa proporcion
	call L_651F		;5868
	ld (0c61dh),a		;586b
L_586E:
	ld a,(0c621h)		;586e   ; el palo
	ld c,a			;5871
	ld b,000h		;5872
	ld ix,06437h		;5874   ; y la tabla de los palos, con cuatro columnas
	add ix,bc		;5878
	ld a,(ix+000h)		;587a   ; la primera es el frenado por cuadro
	ld (0c61ch),a		;587d
	ld a,(ix+01ah)		;5880   ; la segunda, el alcance
	call corrige_por_la_fuerza		;5883   ; corregido por el nivel
	ld (0c61ah),a		;5886
	xor a			;5889   ; la altura arranca a cero
	ld (0c61bh),a		;588a
	ld a,(0c621h)		;588d   ; con el putter el alcance se corrige distinto
	cp 00dh		;5890
	ld a,(ix+027h)		;5892
	call nc,corrige_por_la_fuerza		;5895
	ld (0c626h),a		;5898   ; la velocidad de salida
	ld (0c61eh),a		;589b
	ld a,078h		;589e   ; 0x78 de modulo para el primer tramo
	ld (0c620h),a		;58a0
	ld a,(0c621h)		;58a3   ; palo 14: putt en el green
	cp 00eh		;58a6
	jp z,rueda_el_putt		;58a8
	cp 00dh		;58ab   ; palo 13: putt fuera del green
	jp z,rueda_por_el_campo		;58ad
	ld a,(ix+00dh)		;58b0   ; la tercera columna es cuantos cuadros dura la subida
	call corrige_por_la_fuerza		;58b3
	ld b,a			;58b6
L_58B7:
	push bc			;58b7   ; el tramo de subida
	call cuenta_un_paso		;58b8   ; dibuja la bola
	call mueve_la_camara		;58bb   ; mueve la camara
	call silba_la_bola		;58be   ; y los sprites
	call pinta_los_sprites		;58c1
	pop bc			;58c4
	ld a,(0c633h)		;58c5   ; si ha entrado, se acabo
	and a			;58c8
	ret nz			;58c9
	call L_61BA		;58ca   ; mira contra el terreno
	ret c			;58cd
	call espera_un_cuadro		;58ce
	djnz L_58B7		;58d1
L_58D3:
	call cuenta_un_paso		;58d3   ; el tramo de bajada
	call mueve_la_camara		;58d6
	call silba_la_bola		;58d9
	ld a,h			;58dc   ; mientras la altura no sea negativa
	and a			;58dd
	jp m,rueda_por_el_campo		;58de
	ld a,(0c61ch)		;58e1   ; el frenado
	ld e,a			;58e4
	ld d,000h		;58e5
	ld hl,(0c61ah)		;58e7
	and a			;58ea
	sbc hl,de		;58eb
	ld (0c61ah),hl		;58ed
	ld hl,0c624h		;58f0   ; 0xC624 cuenta los cuadros que faltan para torcer un grado
	ld de,0c61fh		;58f3
	ld a,(0c622h)		;58f6   ; con slice se tuerce a un lado...
	and a			;58f9
	jr z,L_5904		;58fa
	dec (hl)			;58fc
	jr nz,L_5910		;58fd
	ld (hl),a			;58ff
	ex de,hl			;5900
	dec (hl)			;5901
	jr L_5910		;5902
L_5904:
	ld a,(0c623h)		;5904   ; ...y con gancho, al otro
	and a			;5907
	jr z,L_5910		;5908
	dec (hl)			;590a
	jr nz,L_5910		;590b
	ld (hl),a			;590d
	ex de,hl			;590e
	inc (hl)			;590f
L_5910:
	ld a,(0c625h)		;5910   ; el viento: los cuatro bits altos de 0xC625 son su direccion
	and 078h		;5913
	jr z,L_5956		;5915
	rrca			;5917
	rrca			;5918
	rrca			;5919
	ld b,a			;591a
	add a,a			;591b   ; tres pasos por unidad de fuerza
	add a,b			;591c
	ld b,a			;591d
	ld a,(0c625h)		;591e   ; y la fuerza, en los tres bits bajos, por 32
	add a,a			;5921
	add a,a			;5922
	add a,a			;5923
	add a,a			;5924
	add a,a			;5925
L_5926:
	push bc			;5926
	push af			;5927
	call L_655A		;5928   ; el coseno del angulo del viento
	call L_6295		;592b
	ld hl,(0c60ch)		;592e   ; que se acumula en la X de la bola
	add hl,de			;5931
	ld (0c60ch),hl		;5932
	ld a,(0c60eh)		;5935
	adc a,d			;5938
	ld (0c60eh),a		;5939
	pop af			;593c
	push af			;593d
	call L_6558		;593e   ; y el seno en la Y
	call L_6295		;5941
	ld hl,(0c60fh)		;5944
	add hl,de			;5947
	ld (0c60fh),hl		;5948
	ld a,(0c611h)		;594b
	adc a,d			;594e
	ld (0c611h),a		;594f
	pop af			;5952
	pop bc			;5953
	djnz L_5926		;5954
L_5956:
	call pinta_los_sprites		;5956   ; redibuja
	ld a,(0c633h)		;5959   ; si ha entrado, se acabo
	and a			;595c
	ret nz			;595d
	call L_61BA		;595e   ; y mira contra el terreno
	ret c			;5961
	call espera_un_cuadro		;5962
	jp L_58D3		;5965
cuenta_un_paso:		; Suma uno a los pasos que lleva la bola en este golpe
	ld hl,(0c64ah)		;5968
	inc hl			;596b
	ld (0c64ah),hl		;596c
	ret			;596f
rueda_por_el_campo:		; El putt fuera del green: la bola rueda con la cuenta de pasos del palo
	ld hl,00000h		;5970   ; la altura, a cero: esto no vuela
	ld (0c612h),hl		;5973
	ld a,(0c626h)		;5976   ; los pasos que da el putt
	ld b,a			;5979
L_597A:
	push bc			;597a
	call cuenta_un_paso		;597b   ; uno mas
	call mueve_la_camara		;597e   ; mueve la camara
	call pinta_los_sprites		;5981   ; y redibuja los sprites
	pop bc			;5984
	ld a,(0c633h)		;5985   ; si ha entrado o se ha ido fuera, se acabo
	ld hl,0c635h		;5988
	or (hl)			;598b
	ret nz			;598c
	call L_61BA		;598d   ; mira contra el terreno
	ret c			;5990
	ld a,(0c63ah)		;5991   ; 0xC63A dice que la bola esta en el aire por un desnivel
	and a			;5994
	jr z,L_599C		;5995
	dec b			;5997   ; y entonces el paso no cuenta
	jr nz,L_599B		;5998
	inc b			;599a
L_599B:
	inc b			;599b
L_599C:
	call espera_un_cuadro		;599c
	djnz L_597A		;599f
	ld a,(0c638h)		;59a1   ; al parar, si no estaba en el agua...
	xor 001h		;59a4
	call z,L_6B2D		;59a6   ; ...suena la pista 1
	ret			;59a9
pinta_los_sprites:		; Monta los tres sprites -bola, sombra y bandera- y los vuelca a 0x1B00
	ld de,0c600h		;59aa   ; 0xC600 son los doce bytes de los atributos de sprite
	ld bc,0c608h		;59ad
	ld a,(0c009h)		;59b0   ; el jugador 1 usa 0xC600 y el 2, 0xC604
	and a			;59b3
	push af			;59b4
	jr z,L_59BA		;59b5
	ld de,0c604h		;59b7
L_59BA:
	ld a,(0c611h)		;59ba   ; la fila de la bola
	sub 002h		;59bd   ; dos arriba, que es donde cae el dibujo
	ld (bc),a			;59bf
	ld hl,0c613h		;59c0   ; y la sombra va a la altura de la bola por debajo
	sub (hl)			;59c3
	ld (de),a			;59c4
	ld a,(hl)			;59c5   ; sin altura no hay sombra...
	and a			;59c6
	jr nz,L_59CC		;59c7
	ld a,0d1h		;59c9   ; ...y 0xD1 la deja fuera de pantalla
	ld (bc),a			;59cb
L_59CC:
	ld a,(0c611h)		;59cc   ; por debajo de la fila 0xC0 la bola se ha salido
	cp 0c0h		;59cf
	call nc,la_bola_ha_entrado		;59d1
	ld a,(0c60eh)		;59d4   ; la columna
	dec a			;59d7
	inc de			;59d8
	ld (de),a			;59d9
	inc bc			;59da
	ld (bc),a			;59db
	cp 058h		;59dc   ; por la izquierda de 0x58 tambien se sale
	call c,la_bola_ha_entrado		;59de
	cp 0f8h		;59e1   ; y por la derecha de 0xF8
	call nc,la_bola_ha_entrado		;59e3
	ld a,(0c613h)		;59e6   ; por encima de ocho de altura la bola se dibuja mas gorda
	cp 008h		;59e9
	ld a,001h		;59eb
	sbc a,000h		;59ed
	rlca			;59ef
	rlca			;59f0
	add a,000h		;59f1
	inc de			;59f3
	ld (de),a			;59f4
	ld a,008h		;59f5
	inc bc			;59f7
	ld (bc),a			;59f8
	pop af			;59f9   ; color 15 para el jugador 1
	ld a,00fh		;59fa
	jr z,L_5A00		;59fc
	ld a,009h		;59fe   ; y color 9 para el 2
L_5A00:
	inc de			;5a00
	ld (de),a			;5a01
	ld a,001h		;5a02
	inc bc			;5a04
	ld (bc),a			;5a05
	ld a,(0c011h)		;5a06   ; en el green los sprites son otros
	and a			;5a09
	jr nz,L_5A62		;5a0a
	call L_629C		;5a0c   ; recoloca la camara
	ld a,(0c63ah)		;5a0f   ; 0xC63A a uno es la bola cayendo por un talud
	and a			;5a12
	jr z,L_5A26		;5a13
	dec a			;5a15   ; a dos, tapada
	jr z,L_5A21		;5a16
	ld hl,0c608h		;5a18   ; y entonces la sombra sube cinco
	ld a,(hl)			;5a1b
	sub 005h		;5a1c
	ld (hl),a			;5a1e
	jr L_5A26		;5a1f
L_5A21:
	ld a,0d1h		;5a21   ; o desaparece
	ld (0c608h),a		;5a23
L_5A26:
	ld a,(0c613h)		;5a26   ; por debajo de doce de altura la bola puede tapar el decorado
	cp 00ch		;5a29
	jr nc,L_5A62		;5a2b
	ld a,(0c611h)		;5a2d   ; se mira que hay bajo ella
	push af			;5a30
	ld hl,0c613h		;5a31
	sub (hl)			;5a34
	ld (0c611h),a		;5a35
	call L_629C		;5a38
	pop af			;5a3b
	ld (0c611h),a		;5a3c
	ld a,(0c63ah)		;5a3f   ; y tambien un poco mas alla
	dec a			;5a42
	push af			;5a43
	call L_629C		;5a44
	pop af			;5a47
	jr nz,L_5A62		;5a48
	ld a,(0c63ah)		;5a4a
	and a			;5a4d
	jr z,L_5A62		;5a4e
	ld hl,0c600h		;5a50   ; si la bola esta tapada, se esconden los dos sprites
	ld a,(0c009h)		;5a53
	and a			;5a56
	jr z,L_5A5C		;5a57
	ld hl,0c604h		;5a59
L_5A5C:
	ld a,0d1h		;5a5c
	ld (hl),a			;5a5e
	ld (0c608h),a		;5a5f
L_5A62:
	ld hl,0c600h		;5a62   ; los doce bytes de golpe a 0x1B00
	ld de,01b00h		;5a65
	ld bc,0000ch		;5a68
	ld a,(0c118h)		;5a6b   ; con la maquina ensayando no se dibuja nada
	and a			;5a6e
	call z,0005ch		;5a6f   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,(0c011h)		;5a72   ; en el campo ya esta
	and a			;5a75
	ret z			;5a76
	call L_6400		;5a77   ; en el green se mira la casilla de debajo
	ld de,001e0h		;5a7a
	add hl,de			;5a7d
	ld a,(hl)			;5a7e
	cp 079h		;5a7f   ; 0x79 es el hoyo
	call z,la_bola_ha_entrado		;5a81
	ld hl,(0c63dh)		;5a84   ; la distancia de la bola al hoyo
	ld a,(0c60eh)		;5a87
	sub l			;5a8a
	ld l,a			;5a8b
	ld a,(0c611h)		;5a8c
	sub h			;5a8f
	ld e,a			;5a90
	call L_6485		;5a91   ; en las dos componentes
	ld a,l			;5a94
	cp 002h		;5a95   ; a menos de dos pixeles en las dos...
	ret nc			;5a97
	ld a,e			;5a98
	cp 002h		;5a99
	ret nc			;5a9b
	ld a,001h		;5a9c   ; ...la bola toca el hoyo
	ld (0c634h),a		;5a9e
	ret			;5aa1
la_bola_ha_entrado:		; Levanta la bandera de hoyo hecho y calla el PSG
	ld a,001h		;5aa2
	ld (0c633h),a		;5aa4
	jp 00090h		;5aa7   ; BIOS GICINI - Initialises PSG and sets initial value for the PLAY statement
esconde_la_bola:		; Deja el sprite del jugador que juega fuera de pantalla
	ld hl,0c600h		;5aaa
	ld a,(0c009h)		;5aad
	and a			;5ab0
	jr z,L_5AB6		;5ab1
	ld hl,0c604h		;5ab3
L_5AB6:
	ld (hl),0d1h		;5ab6
	jr L_5A62		;5ab8
esconde_los_sprites:		; Deja los doce bytes de sprite fuera de pantalla
	ld hl,0c600h		;5aba
	ld de,0c601h		;5abd
	ld bc,0000bh		;5ac0
	ld (hl),0d1h		;5ac3
	ldir		;5ac5
	jr L_5A62		;5ac7
mueve_la_camara:		; Suma a la posicion de la camara el vector de velocidad
	ld a,(0c61fh)		;5ac9   ; el angulo
	push af			;5acc
	call coseno_por_modulo		;5acd   ; la componente X
	call media_velocidad		;5ad0
	ld hl,(0c60dh)		;5ad3   ; que se acumula
	add hl,de			;5ad6
	ld (0c60dh),hl		;5ad7
	pop af			;5ada
	call seno_por_modulo		;5adb   ; y la Y igual
	call media_velocidad		;5ade
	ld hl,(0c610h)		;5ae1
	add hl,de			;5ae4
	ld (0c610h),hl		;5ae5
	ret			;5ae8
media_velocidad:		; Si la bola esta en el agua, el paso vale la mitad
	ex de,hl			;5ae9
	ld a,(0c627h)		;5aea   ; 0xC627 se pone cuando la bola cae al agua
	and a			;5aed
	ret z			;5aee
	sra d		;5aef   ; y entonces el paso se parte por la mitad
	rr e		;5af1
	ret			;5af3
silba_la_bola:		; La altura de la bola se oye: el tono del canal A sale de ella
	ld hl,(0c612h)		;5af4   ; la altura acumulada
	ld de,(0c61ah)		;5af7   ; mas lo que sube este cuadro
	add hl,de			;5afb
	ld (0c612h),hl		;5afc
	ld a,(0c118h)		;5aff   ; con la maquina ensayando no suena nada
	and a			;5b02
	ret nz			;5b03
	push hl			;5b04
	ld a,h			;5b05   ; por debajo de cero no hay tono
	and a			;5b06
	jp p,L_5B0F		;5b07
	ld hl,00000h		;5b0a
	jr L_5B1C		;5b0d
L_5B0F:
	add hl,hl			;5b0f   ; la altura, escalada
	ld l,h			;5b10
	ld h,000h		;5b11
	add hl,hl			;5b13
	add hl,hl			;5b14
	ld de,00200h		;5b15   ; y restada de 0x200: cuanto mas alta la bola, mas agudo
	ex de,hl			;5b18
	and a			;5b19
	sbc hl,de		;5b1a
L_5B1C:
	ld e,l			;5b1c
	xor a			;5b1d
	call 00093h		;5b1e   ; BIOS WRTPSG - Writes data to PSG-register | registro 0 del PSG
	ld e,h			;5b21
	ld a,001h		;5b22   ; y registro 1
	pop hl			;5b24
	jp 00093h		;5b25   ; BIOS WRTPSG - Writes data to PSG-register
corrige_por_la_fuerza:		; Escala un byte de la tabla de palos por la fuerza del golpe
	ld e,a			;5b28
	ld a,(0c61dh)		;5b29   ; la fuerza del golpe
	and a			;5b2c
	jr z,L_5B37		;5b2d
	call L_651F		;5b2f   ; el valor por la fuerza, en tanto por 256
	and a			;5b32   ; y nunca cero
	ret nz			;5b33
	ld a,001h		;5b34
	ret			;5b36
L_5B37:
	ld a,e			;5b37
	ret			;5b38
el_rival_prepara_el_golpe:		; Sortea unos valores de partida y ENSAYA el golpe entero hasta que le sale bien
	ld hl,(0c63fh)		;5b39   ; de donde sale la bola
	ld (0c648h),hl		;5b3c
	xor a			;5b3f   ; los contadores de intentos, a cero
	ld (0c668h),a		;5b40
	ld (0c66dh),a		;5b43
	ld (0c669h),a		;5b46
	ld (0c66eh),a		;5b49
	ld (0c66fh),a		;5b4c
	ld (0c670h),a		;5b4f
	call L_4CD0		;5b52   ; la fuerza de partida, entre 0x18 y 0x1B
	and 003h		;5b55
	add a,018h		;5b57
	ld (0c665h),a		;5b59
	call L_4CD0		;5b5c   ; y la curva, entre 0x19 y 0x20
	and 007h		;5b5f
	add a,019h		;5b61
	ld (0c666h),a		;5b63
	ld hl,(0c648h)		;5b66
	push hl			;5b69
	call L_47B0		;5b6a   ; el angulo hacia la bandera
	ld (0c65fh),a		;5b6d
	pop hl			;5b70
	ld a,(0c012h)		;5b71   ; y la distancia que hay
	ld e,a			;5b74
	ld a,(0c013h)		;5b75
	ld d,a			;5b78
	call distancia_entre		;5b79
	ld (0c662h),a		;5b7c   ; 0xC662 es la distancia al objetivo
	cp 080h		;5b7f   ; por encima de 128 hay que buscar un punto intermedio
	jp nc,busca_un_punto_intermedio		;5b81
L_5B84:
	ld a,(0c662h)		;5b84   ; elige palo por la distancia
	sub 06ch		;5b87   ; 0x6C de margen
	jr c,L_5B8C		;5b89
	xor a			;5b8b
L_5B8C:
	neg		;5b8c
	rra			;5b8e   ; la distancia, dividida por ocho
	rra			;5b8f
	rra			;5b90
	and 01fh		;5b91
	cp 00eh		;5b93   ; y acotada al palo 13
	jr c,L_5B99		;5b95
	ld a,00dh		;5b97
L_5B99:
	ld (0c667h),a		;5b99
	call L_629C		;5b9c   ; mira que terreno hay debajo
	ld a,(0c638h)		;5b9f   ; desde el agua se sube un palo
	and a			;5ba2
	ld a,0feh		;5ba3
	call nz,mueve_el_palo		;5ba5
	ld hl,(0c60dh)		;5ba8   ; guarda la posicion de la camara para poder repetir
	ld (0c656h),hl		;5bab
	ld hl,(0c610h)		;5bae
	ld (0c658h),hl		;5bb1
el_rival_ensaya:		; Juega el golpe con la fisica de verdad y mira como ha quedado
	call L_6666		;5bb4   ; un cuadro
	ld a,(0c65fh)		;5bb7   ; si el angulo se ha ido muy lejos del bueno...
	ld b,a			;5bba
	ld a,(0c660h)		;5bbb
	sub b			;5bbe
	sub 070h		;5bbf
	cp 020h		;5bc1
	jp nc,L_5BCC		;5bc3
	ld a,b			;5bc6   ; ...se vuelve a centrar
	sub 080h		;5bc7
	ld (0c65fh),a		;5bc9
L_5BCC:
	ld hl,(0c656h)		;5bcc   ; la camara vuelve al sitio
	ld (0c60dh),hl		;5bcf
	ld hl,(0c658h)		;5bd2
	ld (0c610h),hl		;5bd5
	ld a,(0c65fh)		;5bd8   ; el angulo del ensayo
	ld (0c61fh),a		;5bdb
	ld a,001h		;5bde   ; 0xC118 avisa de que esto es un ensayo: ni mando, ni espera, ni dibujo
	ld (0c118h),a		;5be0
	ld a,(0c666h)		;5be3   ; la curva
	ld (0c641h),a		;5be6
	ld a,(0c665h)		;5be9   ; la fuerza, con la misma cuenta de siempre
	add a,a			;5bec
	add a,a			;5bed
	add a,a			;5bee
	add a,01fh		;5bef
	ld (0c61dh),a		;5bf1
	ld a,(0c667h)		;5bf4   ; y el palo
	ld (0c621h),a		;5bf7
	ld hl,00000h		;5bfa   ; los resultados del ensayo anterior, a cero
	ld (0c652h),hl		;5bfd
	ld (0c64ch),hl		;5c00
	ld (0c64eh),hl		;5c03
	ld (0c650h),hl		;5c06
	xor a			;5c09
	ld (0c622h),a		;5c0a
	ld (0c623h),a		;5c0d
	ld (0c66ah),a		;5c10
	ld (0c66ch),a		;5c13
	call L_53A7		;5c16   ; y se juega el golpe entero
	ld hl,0c66dh		;5c19   ; un intento mas
	inc (hl)			;5c1c
	call L_629C		;5c1d
	ld hl,(0c648h)		;5c20   ; donde ha acabado la bola
	ld a,(0c60eh)		;5c23
	ld e,a			;5c26
	ld a,(0c611h)		;5c27
	ld d,a			;5c2a
	call distancia_entre		;5c2b   ; y a que distancia del objetivo
	ld (0c662h),a		;5c2e
	ld hl,(0c656h)		;5c31   ; la camara, otra vez a su sitio
	ld (0c60dh),hl		;5c34
	ld hl,(0c658h)		;5c37
	ld (0c610h),hl		;5c3a
	ld a,(0c633h)		;5c3d   ; si ha entrado, ya esta
	and a			;5c40
	jp nz,el_rival_mete_la_bola		;5c41
	ld a,(0c637h)		;5c44   ; y si ha llegado al green, tambien
	and a			;5c47
	ret nz			;5c48
	ld hl,(0c652h)		;5c49   ; 0xC652 son los pasos que se ha pasado
	ld a,h			;5c4c
	or l			;5c4d
	jp nz,L_5CA4		;5c4e
	ld a,(0c66bh)		;5c51   ; 0xC66B, que ha chocado con un arbol
	and a			;5c54
	jp nz,el_rival_choca_con_un_arbol		;5c55
	ld a,(0c66ah)		;5c58   ; 0xC66A, que se ha quedado corta
	and a			;5c5b
	jp nz,L_5DFA		;5c5c
L_5C5F:
	ld a,(0c635h)		;5c5f   ; fuera de limites
	and a			;5c62
	jp nz,L_5DB4		;5c63
	ld a,(0c636h)		;5c66   ; o en bunker
	and a			;5c69
	jp nz,L_5DB4		;5c6a
	ld a,(0c66ch)		;5c6d   ; o demasiado cerca de un obstaculo
	and a			;5c70
	jp nz,L_5ECB		;5c71
L_5C74:
	ld a,(0c638h)		;5c74   ; en el agua
	and a			;5c77
	jp nz,el_rival_cae_al_agua		;5c78
	ld a,(0c66dh)		;5c7b   ; y a partir de siete intentos se conforma
	cp 007h		;5c7e
	ret nc			;5c80
	call L_4CD0		;5c81   ; de diez a trece de margen
	and 003h		;5c84
	add a,00ah		;5c86
	ld b,a			;5c88
	ld a,(0c662h)		;5c89
	cp b			;5c8c   ; si ha quedado mas cerca que eso, vale
	jp c,L_5D41		;5c8d
	ld a,(0c639h)		;5c90   ; desde el rough...
	and a			;5c93
	ret z			;5c94
	ld hl,(0c64ch)		;5c95
	call por_ciento_de_los_pasos		;5c98   ; ...se mira cuanto le falta
	cp 0f0h		;5c9b
	ret c			;5c9d
	call recorta_la_fuerza		;5c9e   ; y se recorta la fuerza
	jp el_rival_ensaya		;5ca1
L_5CA4:
	call un_palo_mas		;5ca4   ; se ha pasado: un palo menos
	ld hl,0c665h		;5ca7
	ld a,(hl)			;5caa
	cp 006h		;5cab   ; con poca fuerza no se puede bajar mas
	jp nc,L_5E76		;5cad
	dec (hl)			;5cb0   ; y si se puede, un punto menos de fuerza
	jp el_rival_ensaya		;5cb1
el_rival_cae_al_agua:		; Ha caido al agua en el ensayo: cambia palo, fuerza o angulo casi al azar
	ld a,(0c667h)		;5cb4   ; con el putter la salida es otra
	cp 00dh		;5cb7
	jp z,L_5D2B		;5cb9
	ld a,(0c66fh)		;5cbc   ; a partir de diez cambios de angulo se rinde
	cp 00ah		;5cbf
	ret nc			;5cc1
	ld a,(0c66dh)		;5cc2   ; y de doce intentos, tambien
	cp 00ch		;5cc5
	ret nc			;5cc7
L_5CC8:
	call L_4CD0		;5cc8   ; un dado
	cp 090h		;5ccb   ; un dado bajo: se replantea entero
	jp c,L_5DD6		;5ccd
	call L_4CD0		;5cd0
	cp 036h		;5cd3   ; cada tramo del dado toca una cosa distinta
	jr c,L_5CFB		;5cd5
	cp 046h		;5cd7
	jr c,L_5D0A		;5cd9
	cp 070h		;5cdb
	jr c,L_5D0F		;5cdd
	cp 090h		;5cdf
	jr c,L_5D17		;5ce1
	cp 0beh		;5ce3
	jr c,L_5D1F		;5ce5
	call L_4CD0		;5ce7   ; sube el angulo entre cuatro y once...
	and 007h		;5cea
	add a,004h		;5cec
	call mueve_el_angulo		;5cee
	call L_4CD0		;5cf1   ; ...y la curva un poco
	and 003h		;5cf4
	call mueve_la_curva		;5cf6
	jr L_5D14		;5cf9
L_5CFB:
	ld a,0fbh		;5cfb   ; o baja el angulo cinco...
	call mueve_el_angulo		;5cfd
	call L_4CD0		;5d00   ; ...y la curva
	or 0fch		;5d03
	call mueve_la_curva		;5d05
	jr L_5D14		;5d08
L_5D0A:
	call un_palo_mas		;5d0a   ; un palo mas
	jr L_5D12		;5d0d
L_5D0F:
	call un_palo_menos		;5d0f   ; o uno menos
L_5D12:
	jr c,L_5CC8		;5d12
L_5D14:
	jp el_rival_ensaya		;5d14
L_5D17:
	call L_4CD0		;5d17   ; uno o dos puntos de fuerza
	and 001h		;5d1a
	inc a			;5d1c
	jr L_5D26		;5d1d
L_5D1F:
	call L_4CD0		;5d1f   ; o de tres a seis
	and 003h		;5d22
	add a,003h		;5d24
L_5D26:
	call mueve_la_fuerza		;5d26
	jr L_5D12		;5d29
L_5D2B:
	ld a,00ch		;5d2b   ; con el putter en el agua se pasa al palo 12
	ld (0c667h),a		;5d2d
	ld a,(0c665h)		;5d30   ; y si la fuerza era mucha, se parte por la mitad
	cp 008h		;5d33
	jp c,el_rival_ensaya		;5d35
	srl a		;5d38
	inc a			;5d3a
	ld (0c665h),a		;5d3b
	jp el_rival_ensaya		;5d3e
L_5D41:
	call un_palo_menos		;5d41   ; se ha quedado corta: un palo menos y un punto mas de fuerza
	ld a,(0c667h)		;5d44
	cp 00ch		;5d47   ; el palo 12 es el ultimo antes del putter
	jr z,L_5D53		;5d49
	ld a,001h		;5d4b
	call mueve_la_fuerza		;5d4d
	jp el_rival_ensaya		;5d50
L_5D53:
	ld a,(0c665h)		;5d53   ; con poca fuerza se deja como esta
	cp 007h		;5d56
	jp c,el_rival_ensaya		;5d58
	cp 014h		;5d5b   ; y con mucha se baja un punto
	jr c,L_5D67		;5d5d
	ld a,0feh		;5d5f
	call mueve_la_fuerza		;5d61
	jp el_rival_ensaya		;5d64
L_5D67:
	ld a,00dh		;5d67   ; o se cambia al putter con dos puntos mas
	ld (0c667h),a		;5d69
	ld a,002h		;5d6c
	call mueve_la_fuerza		;5d6e
	jp el_rival_ensaya		;5d71
el_rival_choca_con_un_arbol:		; Si el golpe ha sido corto, prueba con el putter
	ld a,(0c64ah)		;5d74   ; con menos de doce pasos el golpe era corto
	cp 00ch		;5d77
	jp nc,el_rival_cae_al_agua		;5d79
	ld hl,00000h		;5d7c
	ld (0c652h),hl		;5d7f
	ld (0c64ch),hl		;5d82
	ld (0c64eh),hl		;5d85
	ld a,00ch		;5d88   ; palo 12 y fuerza 0x1A
	ld (0c667h),a		;5d8a
	ld a,01ah		;5d8d
	ld (0c665h),a		;5d8f
	jp L_5C5F		;5d92
el_rival_mete_la_bola:		; El ensayo ha entrado: se rebaja para no meterla siempre
	ld a,001h		;5d95   ; se apunta que ya ha probado
	ld (0c668h),a		;5d97
	xor a			;5d9a   ; y se borra la bandera, que esto era solo un ensayo
	ld (0c633h),a		;5d9b
	ld a,0ffh		;5d9e   ; un punto menos de fuerza
	call mueve_la_fuerza		;5da0
	ld hl,(0c652h)		;5da3
	ld a,h			;5da6
	or l			;5da7
	jr z,L_5DBE		;5da8
	ld a,0ffh		;5daa   ; y si ademas se habia pasado, otro y un palo menos
	call mueve_la_fuerza		;5dac
	ld a,001h		;5daf
	call mueve_el_palo		;5db1
L_5DB4:
	ld a,(0c667h)		;5db4   ; fuera de limites o en bunker: baja un palo
	cp 00dh		;5db7
	jr c,L_5DBE		;5db9
	call un_palo_menos		;5dbb
L_5DBE:
	call L_4CD0		;5dbe   ; un dado
	cp 010h		;5dc1
	jp c,L_5DD6		;5dc3
	ld hl,(0c64ch)		;5dc6   ; si se ha pasado en X...
	ld a,h			;5dc9
	or l			;5dca
	jp nz,L_5E95		;5dcb
L_5DCE:
	ld hl,(0c64eh)		;5dce   ; ...o en Y
	ld a,h			;5dd1
	or l			;5dd2
	jp nz,L_5EB2		;5dd3
L_5DD6:
	ld a,(0c668h)		;5dd6   ; replanteo entero: fuerza 0x1B, palo 0 y curva sorteada
	and a			;5dd9
	jp nz,abanica_el_tiro		;5dda
	inc a			;5ddd
	ld (0c668h),a		;5dde
	ld a,01bh		;5de1
	ld (0c665h),a		;5de3
	xor a			;5de6
	ld (0c66fh),a		;5de7
	ld (0c667h),a		;5dea
	call L_4CD0		;5ded
	and 003h		;5df0
	add a,01bh		;5df2
	ld (0c666h),a		;5df4
	jp el_rival_ensaya		;5df7
L_5DFA:
	ld hl,(0c654h)		;5dfa   ; se ha quedado corto
	call por_ciento_de_los_pasos		;5dfd
	cp 0f0h		;5e00   ; muy corto: se replantea
	jr nc,L_5E22		;5e02
	cp 0e8h		;5e04   ; casi bien: se da por bueno
	jp nc,L_5C5F		;5e06
	ld a,(0c66eh)		;5e09   ; y a partir de veinte retoques del angulo...
	cp 014h		;5e0c
	jr c,L_5E22		;5e0e
	call un_palo_mas		;5e10   ; ...un palo mas y un punto menos de fuerza
	ld a,0ffh		;5e13
	call mueve_la_fuerza		;5e15
	ld a,(0c667h)		;5e18
	cp 00dh		;5e1b
	ld a,0ffh		;5e1d
	call z,mueve_el_palo		;5e1f
L_5E22:
	call L_4CD0		;5e22   ; otro dado, con cuatro salidas
	cp 070h		;5e25
	jr c,L_5E36		;5e27
	cp 090h		;5e29
	jr c,L_5E40		;5e2b
	cp 0b0h		;5e2d
	jr c,L_5E5E		;5e2f
	cp 0d0h		;5e31
	jp c,L_5DD6		;5e33
L_5E36:
	ld hl,0c66eh		;5e36   ; abanica el angulo un poco mas
	inc (hl)			;5e39
	call abanica_el_angulo		;5e3a
	jp el_rival_ensaya		;5e3d
L_5E40:
	ld a,(0c665h)		;5e40   ; sube un palo y un punto de fuerza...
	cp 00ch		;5e43
	jp c,L_5E53		;5e45
	call un_palo_mas		;5e48
	ld a,001h		;5e4b
	call mueve_la_fuerza		;5e4d
	jp el_rival_ensaya		;5e50
L_5E53:
	call un_palo_menos		;5e53   ; ...o baja un palo y un punto
	ld a,0ffh		;5e56
	call mueve_la_fuerza		;5e58
	jp el_rival_ensaya		;5e5b
L_5E5E:
	ld a,(0c66fh)		;5e5e   ; y una vez si y otra no, mueve el angulo dos grados
	and 001h		;5e61
	jp z,L_5E6E		;5e63
	ld a,0feh		;5e66
	call mueve_el_angulo		;5e68
	jp el_rival_ensaya		;5e6b
L_5E6E:
	ld a,002h		;5e6e
	call mueve_el_angulo		;5e70
	jp el_rival_ensaya		;5e73
L_5E76:
	ld hl,(0c652h)		;5e76   ; se ha pasado de largo: recorta la fuerza en proporcion
	call por_ciento_de_los_pasos		;5e79
	call recorta_la_fuerza		;5e7c
	jr nc,L_5E92		;5e7f
L_5E81:
	call un_palo_mas		;5e81   ; y si aun asi no baja, palo abajo y fuerza abajo
	jr nc,L_5E92		;5e84
	ld a,0ffh		;5e86
	call mueve_la_fuerza		;5e88
	jr nc,L_5E92		;5e8b
	ld a,0f6h		;5e8d
	call mueve_el_angulo		;5e8f
L_5E92:
	jp el_rival_ensaya		;5e92
L_5E95:
	call por_ciento_de_los_pasos		;5e95   ; desviado en X
	cp 085h		;5e98
	jp c,L_5DCE		;5e9a
L_5E9D:
	call recorta_la_fuerza		;5e9d
	jp nc,el_rival_ensaya		;5ea0
	call L_4CD0		;5ea3
	cp 020h		;5ea6
	jr c,L_5E81		;5ea8
	ld a,028h		;5eaa
	call mueve_el_angulo		;5eac
	jp el_rival_ensaya		;5eaf
L_5EB2:
	call por_ciento_de_los_pasos		;5eb2   ; desviado en Y
	cp 0f0h		;5eb5
	jp c,L_5DD6		;5eb7
	push af			;5eba
	call L_4CD0		;5ebb
	and 01fh		;5ebe
	add a,0d8h		;5ec0
	ld b,a			;5ec2
	pop af			;5ec3
	cp b			;5ec4
	jp nc,L_5E9D		;5ec5
	jp L_5DD6		;5ec8
L_5ECB:
	ld a,(0c66dh)		;5ecb   ; demasiado cerca de un obstaculo
	cp 00bh		;5ece   ; a partir de once intentos se conforma
	ret nc			;5ed0
	ld a,(0c66fh)		;5ed1
	cp 007h		;5ed4
	jp nc,L_5C74		;5ed6
	call L_4CD0		;5ed9
	cp 060h		;5edc
	jp nc,L_5DD6		;5ede
	jp L_5C74		;5ee1
distancia_al_hoyo:		; Distancia de la bola a la bandera del green
	ld hl,(0c63dh)		;5ee4
	ld a,(0c60eh)		;5ee7
	ld e,a			;5eea
	ld a,(0c611h)		;5eeb
	ld d,a			;5eee
distancia_entre:		; Distancia entre el punto HL y el punto DE, con las dos componentes en valor absoluto
	ld a,e			;5eef   ; la diferencia en X
	sub l			;5ef0
	jr nc,L_5EF5		;5ef1
	neg		;5ef3
L_5EF5:
	ld l,a			;5ef5
	ld a,d			;5ef6   ; y la de Y
	sub h			;5ef7
	jr nc,L_5EFC		;5ef8
	neg		;5efa
L_5EFC:
	ld e,a			;5efc
	call L_6494		;5efd   ; el cuadrado de una
	add hl,de			;5f00   ; mas el de la otra
	jp L_64A2		;5f01   ; y la raiz
abanica_el_tiro:		; Va probando angulos y curvas alternos a un lado y a otro
	ld hl,0c66fh		;5f04   ; 0xC66F cuenta los retoques
	inc (hl)			;5f07
	ld a,(hl)			;5f08
	rrca			;5f09   ; un lado si y otro no
	push af			;5f0a
	rlca			;5f0b
	ld c,a			;5f0c
	add a,a			;5f0d   ; cuatro grados por retoque
	add a,a			;5f0e
	ld b,a			;5f0f
	pop af			;5f10
	ld a,b			;5f11
	jr nc,L_5F1C		;5f12
	neg		;5f14   ; y el impar va al otro lado
	ld d,a			;5f16
	ld a,c			;5f17
	neg		;5f18
	ld c,a			;5f1a
	ld a,d			;5f1b
L_5F1C:
	push bc			;5f1c
	call mueve_el_angulo		;5f1d
	pop bc			;5f20
	ld a,c			;5f21
	call mueve_la_curva		;5f22
	jp el_rival_ensaya		;5f25
abanica_el_angulo:		; Como el anterior, pero solo el angulo
	ld hl,0c66fh		;5f28
	inc (hl)			;5f2b
	ld a,(hl)			;5f2c
	rrca			;5f2d
	push af			;5f2e
	rlca			;5f2f
	add a,a			;5f30
	add a,a			;5f31
	ld b,a			;5f32
	pop af			;5f33
	ld a,b			;5f34
	jr nc,L_5F39		;5f35
	neg		;5f37
L_5F39:
	push af			;5f39
	call mueve_el_angulo		;5f3a
	pop af			;5f3d
	call mueve_la_curva		;5f3e
	ld a,(0c65fh)		;5f41   ; si el angulo se ha ido mas de 64 grados del bueno...
	ld b,a			;5f44
	ld a,(0c660h)		;5f45
	sub b			;5f48
	add a,040h		;5f49
	ret p			;5f4b
	ld a,002h		;5f4c   ; ...sube dos palos
	call mueve_el_palo		;5f4e
	ret nc			;5f51
	ld a,00ch		;5f52   ; y si no puede, se pone el 12
	ld (0c667h),a		;5f54
	ret			;5f57
busca_un_punto_intermedio:		; Con la bandera demasiado lejos, busca a que sitio tirar de paso
	ld a,(0cec4h)		;5f58   ; 0xCEC4 es la fila de la bandera
	ld b,a			;5f5b
	ld a,(0c611h)		;5f5c
	cp b			;5f5f   ; si el objetivo ya no es la bandera, no hay nada que buscar
	jp nz,L_5B84		;5f60
	ld a,(0c670h)		;5f63
	and a			;5f66
	jp nz,L_5B84		;5f67
	inc a			;5f6a   ; solo se busca una vez
	ld (0c670h),a		;5f6b
	ld a,003h		;5f6e   ; tres barridos como mucho
	ld (0c671h),a		;5f70
L_5F73:
	call L_4CD0		;5f73   ; un radio sorteado entre 0x53 y 0x62
	and 00fh		;5f76
	add a,053h		;5f78
	ld (0c65eh),a		;5f7a
	ld a,(0c65fh)		;5f7d   ; desde el angulo a la bandera
	ld c,a			;5f80
	ld b,000h		;5f81
L_5F83:
	call sirve_este_punto		;5f83   ; se prueba ese punto
	jp c,L_5F97		;5f86
	ld a,b			;5f89   ; si vale, ese es el objetivo
	add a,c			;5f8a
	ld (0c61fh),a		;5f8b
	ld (0c65fh),a		;5f8e
	ld (0c660h),a		;5f91
	jp L_5B84		;5f94
L_5F97:
	dec b			;5f97   ; y si no, un grado a la izquierda
	ld a,b			;5f98
	cp 0a0h		;5f99   ; hasta 96 grados
	jr nc,L_5F83		;5f9b
	ld a,(0c65fh)		;5f9d
	ld c,a			;5fa0
	ld b,000h		;5fa1
L_5FA3:
	call sirve_este_punto		;5fa3   ; y luego lo mismo hacia la derecha
	jr c,L_5FB6		;5fa6
	ld a,b			;5fa8
	add a,c			;5fa9
	ld (0c65fh),a		;5faa
	ld (0c61fh),a		;5fad
	ld (0c660h),a		;5fb0
	jp L_5B84		;5fb3
L_5FB6:
	inc b			;5fb6
	ld a,b			;5fb7
	cp 060h		;5fb8   ; otros 96
	jr c,L_5FA3		;5fba
	ld a,(0c671h)		;5fbc   ; y si no sale, otro radio
	dec a			;5fbf
	ld (0c671h),a		;5fc0
	jp nz,L_5F73		;5fc3
	jp L_5B84		;5fc6
sirve_este_punto:		; Mira si el punto a distancia (0xC65E) y angulo B+C cae en terreno bueno
	ld a,(0c65eh)		;5fc9   ; el radio
	ld (0c620h),a		;5fcc
	push bc			;5fcf
	ld a,c			;5fd0
	add a,b			;5fd1
	push af			;5fd2
	call coseno_por_modulo		;5fd3   ; el coseno
	ld a,h			;5fd6
	and a			;5fd7
	ld a,(0c60eh)		;5fd8   ; sumado a la X de la bola
	jr nz,L_5FE0		;5fdb
	add a,l			;5fdd
	jr L_5FE7		;5fde
L_5FE0:
	ld e,a			;5fe0
	ld a,l			;5fe1
	neg		;5fe2
	ld l,a			;5fe4
	ld a,e			;5fe5
	sub l			;5fe6
L_5FE7:
	jp c,L_6026		;5fe7   ; si se sale del campo, no vale
	ld e,a			;5fea
	ld a,(0c65eh)		;5feb
	ld (0c620h),a		;5fee
	pop af			;5ff1
	push de			;5ff2
	call seno_por_modulo		;5ff3   ; el seno
	pop de			;5ff6
	ld a,h			;5ff7
	and a			;5ff8
	ld a,(0c611h)		;5ff9
	jr nz,L_6001		;5ffc
	add a,l			;5ffe
	jr L_6008		;5fff
L_6001:
	ld d,a			;6001
	ld a,l			;6002
	neg		;6003
	ld l,a			;6005
	ld a,d			;6006
	sub l			;6007
L_6008:
	jp c,L_6027		;6008
	ld d,a			;600b
	ex de,hl			;600c
	push hl			;600d
	call L_63F1		;600e   ; la casilla del campo que hay ahi
	ld a,(hl)			;6011
	pop hl			;6012
	pop bc			;6013
	ret c			;6014
	cp 078h		;6015   ; 0x78 es la bandera: esa siempre vale
	ret z			;6017
	cp 07ah		;6018   ; por debajo de 0x7A no vale
	ret c			;601a
	cp 094h		;601b   ; de 0x7A a 0x93 es calle
	jr c,L_6024		;601d
	cp 0d9h		;601f   ; de 0x94 a 0xD8 no vale
	ret c			;6021
	cp 0e9h		;6022   ; y de 0xD9 a 0xE8, tampoco
L_6024:
	ccf			;6024
	ret			;6025
L_6026:
	pop af			;6026
L_6027:
	pop bc			;6027
	scf			;6028
	ret			;6029
por_ciento_de_los_pasos:		; Que parte de los pasos del golpe representa HL, en tanto por 256
	ld a,h			;602a   ; con cero no hay nada que dividir
	or l			;602b
	ret z			;602c
	ex de,hl			;602d
	ld hl,(0c64ah)		;602e   ; los pasos que ha dado el golpe
	ex de,hl			;6031
	ld a,h			;6032
	ld h,l			;6033
	ld l,000h		;6034
	ld c,0ffh		;6036
L_6038:
	inc c			;6038   ; division por restas
	and a			;6039
	sbc hl,de		;603a
	sbc a,000h		;603c
	jr nc,L_6038		;603e
	ld a,c			;6040
	ret			;6041
un_palo_menos:		; Baja un palo del ensayo
	ld a,0ffh		;6042
	jr mueve_el_palo		;6044
un_palo_mas:		; Sube un palo del ensayo
	ld a,001h		;6046
mueve_el_palo:		; Suma A al palo del ensayo, sin pasar de 13
	ld b,a			;6048
	ld a,(0c667h)		;6049
	add a,b			;604c
	ld b,a			;604d
	ld a,00dh		;604e   ; el putter es el tope
	cp b			;6050
	ret c			;6051   ; y si se pasa, no se cambia
	ld a,b			;6052
	ld (0c667h),a		;6053
	and a			;6056
	ret			;6057
mueve_el_angulo:		; Suma A al angulo del ensayo
	ld b,a			;6058
	ld a,(0c65fh)		;6059
	add a,b			;605c
	ld (0c65fh),a		;605d
	ret			;6060
mueve_la_fuerza:		; Suma A a la fuerza del ensayo, sin pasar de 0x1B
	ld b,a			;6061
	ld a,(0c665h)		;6062
	add a,b			;6065
	dec a			;6066   ; uno menos, que la cuenta va desde uno
	ld b,a			;6067
	ld a,01bh		;6068   ; 0x1B es el tope
	cp b			;606a
	ret c			;606b
	ld a,b			;606c
	ld (0c665h),a		;606d
	and a			;6070
	ret			;6071
mueve_la_curva:		; Suma A a la curva del ensayo, sin pasar de 0x37
	ld b,a			;6072
	ld a,(0c666h)		;6073
	add a,b			;6076
	ld b,a			;6077
	ld a,037h		;6078   ; 0x37 es el tope
	cp b			;607a
	ret c			;607b
	ld a,b			;607c
	ld (0c666h),a		;607d
	and a			;6080
	ret			;6081
recorta_la_fuerza:		; Deja la fuerza del ensayo en el tanto por 256 que diga A
	ld e,a			;6082
	ld a,(0c665h)		;6083
	cp 006h		;6086   ; por debajo de seis no se toca
	ret c			;6088
	call L_651F		;6089   ; y si no, se escala
	ld (0c665h),a		;608c
	and a			;608f
	ret			;6090
L_6091:
	xor a			;6091
	ld (0c66dh),a		;6092
	ld hl,(0c63dh)		;6095
	push hl			;6098
	call L_47B0		;6099
	ld (0c65fh),a		;609c
	ld (0c661h),a		;609f
	pop hl			;60a2
	call distancia_al_hoyo		;60a3
	ld (0c662h),a		;60a6
	srl a		;60a9
	add a,003h		;60ab
	cp 01ah		;60ad
	jr c,L_60B3		;60af
	ld a,01ah		;60b1
L_60B3:
	ld (0c665h),a		;60b3
	ld hl,(0c60dh)		;60b6
	ld (0c656h),hl		;60b9
	ld hl,(0c610h)		;60bc
	ld (0c658h),hl		;60bf
	jr L_60D6		;60c2
L_60C4:
	ld hl,(0c656h)		;60c4
	ld (0c60dh),hl		;60c7
	ld hl,(0c658h)		;60ca
	ld (0c610h),hl		;60cd
	call distancia_al_hoyo		;60d0
	ld (0c664h),a		;60d3
L_60D6:
	ld a,(0c65fh)		;60d6
	ld (0c61fh),a		;60d9
	ld a,001h		;60dc
	ld (0c118h),a		;60de
	ld a,(0c666h)		;60e1
	ld (0c641h),a		;60e4
	ld a,(0c665h)		;60e7
	add a,a			;60ea
	add a,a			;60eb
	add a,a			;60ec
	add a,01fh		;60ed
	ld (0c61dh),a		;60ef
	ld a,00eh		;60f2
	ld (0c667h),a		;60f4
	ld (0c621h),a		;60f7
	xor a			;60fa
	ld (0c633h),a		;60fb
	ld (0c672h),a		;60fe
	call L_53A7		;6101
	ld hl,0c66dh		;6104
	inc (hl)			;6107
	call distancia_al_hoyo		;6108
	ld (0c663h),a		;610b
	ld hl,(0c656h)		;610e
	ld (0c60dh),hl		;6111
	ld hl,(0c658h)		;6114
	ld (0c610h),hl		;6117
	ld a,(0c634h)		;611a
	and a			;611d
	ret nz			;611e
	ld a,(0c672h)		;611f
	and a			;6122
	jp nz,L_617C		;6123
	ld a,(0c633h)		;6126
	and a			;6129
	jp nz,L_6157		;612a
	ld a,(0c66dh)		;612d
	ld hl,0c119h		;6130
	cp (hl)			;6133
	ret nc			;6134
	ld a,(0c663h)		;6135
	cp 008h		;6138
	jr c,L_6150		;613a
	ld a,(0c665h)		;613c
	cp 018h		;613f
	jr c,L_6146		;6141
	dec a			;6143
	jr L_6147		;6144
L_6146:
	inc a			;6146
L_6147:
	ld (0c665h),a		;6147
	call L_61A1		;614a
	jp L_60C4		;614d
L_6150:
	call L_61A1		;6150
	jp nc,L_60C4		;6153
	ret			;6156
L_6157:
	ld a,(0c665h)		;6157
	cp 005h		;615a
	jr c,L_6169		;615c
	sub 002h		;615e
	ld (0c665h),a		;6160
	call L_61A1		;6163
	jp L_60C4		;6166
L_6169:
	call L_61A1		;6169
	jr c,L_6171		;616c
	jp L_60C4		;616e
L_6171:
	ld a,(0c65fh)		;6171
	sub 080h		;6174
	ld (0c65fh),a		;6176
	jp L_60C4		;6179
L_617C:
	ld a,(0c665h)		;617c
	cp 00bh		;617f
	jr c,L_6193		;6181
	cp 014h		;6183
	jr c,L_618B		;6185
	sub 004h		;6187
	jr L_618D		;6189
L_618B:
	sub 003h		;618b
L_618D:
	ld (0c665h),a		;618d
	jp L_60C4		;6190
L_6193:
	sub 002h		;6193
	jr nc,L_618D		;6195
	ld a,007h		;6197
	ld (0c665h),a		;6199
	call L_61A1		;619c
	jr L_618D		;619f
L_61A1:
	ld a,(0c660h)		;61a1
	ld b,a			;61a4
	ld a,(0c661h)		;61a5
	sub b			;61a8
	cp 001h		;61a9
	ret c			;61ab
	cp 0ffh		;61ac
	ccf			;61ae
	ret c			;61af
	ld b,a			;61b0
	ld a,(0c65fh)		;61b1
	add a,b			;61b4
	ld (0c65fh),a		;61b5
	and a			;61b8
	ret			;61b9
L_61BA:
	push bc			;61ba
	call L_629C		;61bb
	ld a,(0c638h)		;61be
	and a			;61c1
	jr z,L_61C9		;61c2
	ld (0c628h),a		;61c4
	jr L_61F5		;61c7
L_61C9:
	ld a,(0c628h)		;61c9
	and a			;61cc
	jr z,L_61F1		;61cd
	ld a,(0c613h)		;61cf
	cp 002h		;61d2
	jr nc,L_61F1		;61d4
	ld a,(0c629h)		;61d6
	ld (0c60eh),a		;61d9
	ld a,(0c62ah)		;61dc
	ld (0c611h),a		;61df
	ld a,001h		;61e2
	ld (0c66bh),a		;61e4
	call pinta_los_sprites		;61e7
	pop bc			;61ea
	xor a			;61eb
	call L_6B2D		;61ec
	scf			;61ef
	ret			;61f0
L_61F1:
	xor a			;61f1
	ld (0c628h),a		;61f2
L_61F5:
	ld a,(0c60eh)		;61f5
	ld (0c629h),a		;61f8
	ld a,(0c611h)		;61fb
	ld (0c62ah),a		;61fe
	pop bc			;6201
	ld a,(0c636h)		;6202
	and a			;6205
	jr z,L_622D		;6206
	ld a,(0c62bh)		;6208
	and a			;620b
	ld a,(0c636h)		;620c
	ld (0c62bh),a		;620f
	jr nz,L_6220		;6212
	ld a,(0c629h)		;6214
	ld (0c62ch),a		;6217
	ld a,(0c62ah)		;621a
	ld (0c62dh),a		;621d
L_6220:
	ld hl,(0c612h)		;6220
	ld a,l			;6223
	or h			;6224
	ret nz			;6225
	ld a,006h		;6226
	call L_6B2D		;6228
	scf			;622b
	ret			;622c
L_622D:
	ld (0c62bh),a		;622d
	ld hl,0c62eh		;6230
	ld a,(hl)			;6233
	and a			;6234
	jr z,L_6239		;6235
	dec (hl)			;6237
	ret			;6238
L_6239:
	ld a,(0c613h)		;6239
	cp 00ch		;623c
	ret nc			;623e
	ld a,(0c63ah)		;623f
	and a			;6242
	ret z			;6243
	dec a			;6244
	ret z			;6245
	ld a,(0c611h)		;6246
	push af			;6249
	ld hl,0c613h		;624a
	sub (hl)			;624d
	sub 001h		;624e
	ld (0c611h),a		;6250
	push bc			;6253
	call L_629C		;6254
	pop bc			;6257
	pop af			;6258
	ld (0c611h),a		;6259
	ld a,(0c63ah)		;625c
	dec a			;625f
	ret nz			;6260
	ld b,001h		;6261
	ld a,b			;6263
	ld (0c66ah),a		;6264
	ld hl,(0c64ah)		;6267
	ld (0c654h),hl		;626a
	ld a,(0c61fh)		;626d
	add a,080h		;6270
	ld (0c61fh),a		;6272
	ld hl,0fe00h		;6275
	ld (0c61ah),hl		;6278
	ld a,(0c629h)		;627b
	ld (0c60eh),a		;627e
	ld a,(0c62ah)		;6281
	ld (0c611h),a		;6284
	ld a,005h		;6287
	ld (0c62eh),a		;6289
	push bc			;628c
	ld a,001h		;628d
	call L_6B2D		;628f
	pop bc			;6292
	and a			;6293
	ret			;6294
L_6295:
	ld a,d			;6295
	and a			;6296
	ret z			;6297
	ld a,e			;6298
	cpl			;6299
	ld e,a			;629a
	ret			;629b
L_629C:
	xor a			;629c
	ld (0c635h),a		;629d
	ld (0c636h),a		;62a0
	ld (0c637h),a		;62a3
	ld (0c638h),a		;62a6
	ld (0c639h),a		;62a9
	ld (0c63ah),a		;62ac
	ld (0c66ch),a		;62af
	call L_6400		;62b2
	ld a,(hl)			;62b5
	cp 00dh		;62b6
	jr c,L_62E3		;62b8
	jr z,L_62EA		;62ba
	cp 010h		;62bc
	jr c,L_6311		;62be
	cp 060h		;62c0
	ret c			;62c2
	cp 078h		;62c3
	jr c,L_633C		;62c5
	cp 094h		;62c7
	jr c,L_62F1		;62c9
	cp 0b4h		;62cb
	jr c,L_6309		;62cd
	cp 0d2h		;62cf
	jr c,L_6317		;62d1
	cp 0e9h		;62d3
	jr c,L_632B		;62d5
	cp 0f8h		;62d7
	ret c			;62d9
	cp 0fah		;62da
	ret nc			;62dc
L_62DD:
	ld a,001h		;62dd
	ld (0c635h),a		;62df
	ret			;62e2
L_62E3:
	call L_63B1		;62e3
	jr nz,L_62F6		;62e6
	jr L_62DD		;62e8
L_62EA:
	call L_63B1		;62ea
	jr nz,L_62DD		;62ed
	jr L_62F6		;62ef
L_62F1:
	call L_63B1		;62f1
	jr z,L_6302		;62f4
L_62F6:
	ld a,001h		;62f6
	ld (0c639h),a		;62f8
	ld hl,(0c64ah)		;62fb
	ld (0c64eh),hl		;62fe
	ret			;6301
L_6302:
	ld hl,(0c64ah)		;6302
	ld (0c64ch),hl		;6305
	ret			;6308
L_6309:
	call L_63B1		;6309
	call L_63A8		;630c
	jr z,L_62F6		;630f
L_6311:
	ld a,001h		;6311
	ld (0c636h),a		;6313
	ret			;6316
L_6317:
	call L_63B1		;6317
	call L_63A8		;631a
	jr z,L_62F6		;631d
L_631F:
	ld a,001h		;631f
	ld (0c638h),a		;6321
	ld hl,(0c64ah)		;6324
	ld (0c650h),hl		;6327
	ret			;632a
L_632B:
	call L_63B1		;632b
	jr nz,L_62F6		;632e
	ld a,001h		;6330
	ld (0c637h),a		;6332
	ld hl,(0c64ah)		;6335
	ld (0c652h),hl		;6338
	ret			;633b
L_633C:
	ld (0c62fh),a		;633c
	ld a,001h		;633f
	ld (0c66ch),a		;6341
	call L_63B1		;6344
	jr z,L_635A		;6347
	call L_63D3		;6349
	cp 001h		;634c
	jr nz,L_635A		;634e
	ld a,002h		;6350
	ld (0c63ah),a		;6352
	call L_6400		;6355
	jr L_6395		;6358
L_635A:
	call L_6400		;635a
	push hl			;635d
	call L_63B1		;635e
	call L_63D3		;6361
	cp 00ch		;6364
	jr z,L_63A1		;6366
	cp 001h		;6368
	jr z,L_63A1		;636a
	cp 006h		;636c
	jr z,L_63A1		;636e
	pop hl			;6370
	ld a,(0c63bh)		;6371
	and a			;6374
	jr z,L_6395		;6375
	cp 007h		;6377
	jr z,L_6395		;6379
	push hl			;637b
	dec a			;637c
	ld (0c63bh),a		;637d
	call L_63B1		;6380
	jr z,L_6394		;6383
	pop hl			;6385
	push hl			;6386
	ld a,(0c63bh)		;6387
	add a,002h		;638a
	ld (0c63bh),a		;638c
	call L_63B1		;638f
	jr nz,L_63A1		;6392
L_6394:
	pop hl			;6394
L_6395:
	ld a,(hl)			;6395
	cp 066h		;6396
	ret c			;6398
	cp 070h		;6399
	jp c,L_62F6		;639b
	jp L_631F		;639e
L_63A1:
	ld a,001h		;63a1
	ld (0c63ah),a		;63a3
	jr L_6394		;63a6
L_63A8:
	call L_63D3		;63a8
	cp 002h		;63ab
	ret z			;63ad
	cp 003h		;63ae
	ret			;63b0
L_63B1:
	push hl			;63b1
	ld hl,063e9h		;63b2
	ld a,(0c63bh)		;63b5
	ld c,a			;63b8
	ld b,000h		;63b9
	add hl,bc			;63bb
	ld b,(hl)			;63bc
	pop hl			;63bd
	ld l,(hl)			;63be
	ld h,000h		;63bf
	add hl,hl			;63c1
	add hl,hl			;63c2
	add hl,hl			;63c3
	ld a,(0c63ch)		;63c4
	add a,l			;63c7
	ld l,a			;63c8
	ex de,hl			;63c9
	ld hl,(0f3cbh)		;63ca
	add hl,de			;63cd
	call 0004ah		;63ce   ; BIOS RDVRM - Reads the content of VRAM
	and b			;63d1
	ret			;63d2
L_63D3:
	push af			;63d3
	ld hl,(0f3c9h)		;63d4
	add hl,de			;63d7
	call 0004ah		;63d8   ; BIOS RDVRM - Reads the content of VRAM
	ld c,a			;63db
	pop af			;63dc
	jr z,L_63E5		;63dd
	ld a,c			;63df
	rrca			;63e0
	rrca			;63e1
	rrca			;63e2
	rrca			;63e3
	ld c,a			;63e4
L_63E5:
	ld a,c			;63e5
	and 00fh		;63e6
	ret			;63e8

; ----------------------------------------------------------------------
; DATOS mascaras_de_bit: Las ocho mascaras de un bit, para sacar el pixel que
;   toca de un patron de la VRAM
;   0x63e9..0x63f1  (8 bytes)
DATA_mascaras_de_bit:
	defb 080h,040h,020h,010h,008h,004h,002h,001h	; 63e9  .@ .....

; ======================================================================
; CODIGO 0x63f1..0x6437  (70 bytes)
; ======================================================================


L_63F1:
	ld a,h			;63f1
	cp 0c0h		;63f2
	ccf			;63f4
	ret c			;63f5
	ld a,l			;63f6
	cp 058h		;63f7
	ret c			;63f9
	cp 0f0h		;63fa
	ccf			;63fc
	ret c			;63fd
	jr L_6407		;63fe
L_6400:
	ld a,(0c611h)		;6400
	ld h,a			;6403
	ld a,(0c60eh)		;6404
L_6407:
	sub 058h		;6407
	push af			;6409
	and 007h		;640a
	ld (0c63bh),a		;640c
	ld a,h			;640f
	push af			;6410
	and 007h		;6411
	ld (0c63ch),a		;6413
	pop af			;6416
	and 0f8h		;6417
	ld l,a			;6419
	ld h,000h		;641a
	srl l		;641c
	srl l		;641e
	add a,l			;6420
	ld l,a			;6421
	ld a,000h		;6422
	adc a,h			;6424
	ld h,a			;6425
	add hl,hl			;6426
	pop af			;6427
	and 0f8h		;6428
	rra			;642a
	rra			;642b
	rra			;642c
	ld e,a			;642d
	ld d,000h		;642e
	add hl,de			;6430
	ld de,0cb00h		;6431
	add hl,de			;6434
	and a			;6435
	ret			;6436

; ----------------------------------------------------------------------
; DATOS frenado_del_palo: Trece bytes, uno por palo: cuanto pierde la bola de
;   velocidad en cada cuadro de la bajada
;   0x6437..0x6444  (13 bytes)
DATA_frenado_del_palo:
	defb 002h,002h,002h,003h,003h,004h,006h,008h,00ah,00ch,00eh,013h,01eh	; 6437  .............

; ----------------------------------------------------------------------
; DATOS subida_del_palo: Trece bytes: cuantos cuadros dura el tramo de subida
;   de cada palo
;   0x6444..0x6451  (13 bytes)
DATA_subida_del_palo:
	defb 068h,060h,058h,05ch,04ch,04ch,04ch,048h,03ch,032h,02dh,023h,01ch	; 6444  h`X\LLLH<2-#.

; ----------------------------------------------------------------------
; DATOS alcance_del_palo: Trece bytes: el alcance de cada palo, que 0x5B28
;   escala luego por la fuerza del golpe
;   0x6451..0x645e  (13 bytes)
DATA_alcance_del_palo:
	defb 031h,032h,033h,042h,044h,04bh,05ah,06ch,090h,0b4h,0c8h,0e2h,0ffh	; 6451  123BDKZl.....

; ----------------------------------------------------------------------
; DATOS salida_del_palo: QUINCE bytes -aqui si estan los dos putters, 0x1E y
;   0x7F-: la velocidad con la que sale la bola
;   0x645e..0x646d  (15 bytes)
DATA_salida_del_palo:
	defb 014h,011h,00eh,00bh,008h,007h,006h,005h,004h,003h,002h,001h,001h,01eh,07fh	; 645e  ...............

; ======================================================================
; CODIGO 0x646d..0x65a2  (309 bytes)
; ======================================================================


L_646D:
	push bc			;646d
	ld a,e			;646e
	sub l			;646f
	jr nc,L_6474		;6470
	neg		;6472
L_6474:
	ld e,a			;6474
	ld a,d			;6475
	sub h			;6476
	jr nc,L_647B		;6477
	neg		;6479
L_647B:
	ld l,a			;647b
	call L_6513		;647c
	pop bc			;647f
	add a,c			;6480
	ld c,a			;6481
	ret nc			;6482
	inc b			;6483
	ret			;6484
L_6485:
	ld a,l			;6485
	and a			;6486
	jp p,L_648D		;6487
	neg		;648a
	ld l,a			;648c
L_648D:
	ld a,e			;648d
	and a			;648e
	ret p			;648f
	neg		;6490
	ld e,a			;6492
	ret			;6493
L_6494:
	ld h,0c2h		;6494
	ld d,h			;6496
	ld a,(hl)			;6497
	inc h			;6498
	ld h,(hl)			;6499
	ld l,a			;649a
	ld a,(de)			;649b
	ld c,a			;649c
	inc d			;649d
	ld a,(de)			;649e
	ld d,a			;649f
	ld e,c			;64a0
	ret			;64a1
L_64A2:
	xor a			;64a2
	ld b,080h		;64a3
	ex de,hl			;64a5
L_64A6:
	sub b			;64a6
	cp 080h		;64a7
	ld l,a			;64a9
	ld h,0c2h		;64aa
	ld a,e			;64ac
	sub (hl)			;64ad
	ld c,a			;64ae
	inc h			;64af
	ld a,d			;64b0
	sbc a,(hl)			;64b1
	jr nc,L_64BD		;64b2
	or c			;64b4
	ld a,l			;64b5
	ret z			;64b6
	srl b		;64b7
	jr nz,L_64A6		;64b9
	dec a			;64bb
	ret			;64bc
L_64BD:
	or c			;64bd
	ld a,l			;64be
	ret z			;64bf
	srl b		;64c0
	jr nz,$-26		;64c2
	ret			;64c4
L_64C5:
	ld a,e			;64c5
	rla			;64c6
	ld a,l			;64c7
	rla			;64c8
	rla			;64c9
	and 003h		;64ca
	ex af,af'			;64cc
	call L_6485		;64cd
	ld a,e			;64d0
	cp l			;64d1
	jr z,L_6506		;64d2
	jr c,L_64D7		;64d4
	ex de,hl			;64d6
L_64D7:
	push af			;64d7
	ld bc,00800h		;64d8
	ld a,e			;64db
L_64DC:
	sla c		;64dc
	add a,a			;64de
	jr c,L_64E4		;64df
	cp l			;64e1
	jr c,L_64E6		;64e2
L_64E4:
	sub l			;64e4
	inc c			;64e5
L_64E6:
	djnz L_64DC		;64e6
	pop af			;64e8
	ld b,0c5h		;64e9
	ld a,(bc)			;64eb
	jr nc,L_64F2		;64ec
	sub 040h		;64ee
	neg		;64f0
L_64F2:
	ld c,a			;64f2
	ex af,af'			;64f3
	jr z,L_64FE		;64f4
	dec a			;64f6
	jr z,L_6502		;64f7
	dec a			;64f9
	ld a,080h		;64fa
	jr z,L_6502		;64fc
L_64FE:
	sub c			;64fe
	add a,080h		;64ff
	ret			;6501
L_6502:
	add a,c			;6502
	add a,080h		;6503
	ret			;6505
L_6506:
	and a			;6506
	jr z,L_650D		;6507
	ld a,020h		;6509
	jr L_64F2		;650b
L_650D:
	ld a,040h		;650d
	ret			;650f
L_6510:
	call L_6485		;6510
L_6513:
	call L_6494		;6513
	add hl,de			;6516
	call L_64A2		;6517
	and a			;651a
	ret p			;651b
	ld a,07fh		;651c
	ret			;651e
L_651F:
	ld l,a			;651f
	xor a			;6520
	ex af,af'			;6521
	jr L_652A		;6522
L_6524:
	ld l,a			;6524
	xor e			;6525
	ex af,af'			;6526
	call L_6485		;6527
L_652A:
	ld a,e			;652a
	cp l			;652b
	jr c,L_6530		;652c
	ex de,hl			;652e
	ld a,e			;652f
L_6530:
	ld e,l			;6530
	ld h,000h		;6531
	ld d,h			;6533
	ld b,008h		;6534
L_6536:
	add a,a			;6536
	jr c,L_6543		;6537
	djnz L_6536		;6539
	ld l,h			;653b
	jr L_6545		;653c
L_653E:
	add hl,hl			;653e
	rla			;653f
	jr nc,L_6543		;6540
	add hl,de			;6542
L_6543:
	djnz L_653E		;6543
L_6545:
	ex af,af'			;6545
	jp p,L_6550		;6546
	xor a			;6549
	sub l			;654a
	ld l,a			;654b
	sbc a,a			;654c
	sub h			;654d
	ld h,a			;654e
	ret			;654f
L_6550:
	ld a,h			;6550
	ret			;6551
L_6552:
	ld l,a			;6552
	ld a,d			;6553
	and a			;6554
	ex af,af'			;6555
	jr L_652A		;6556
L_6558:
	sub 040h		;6558
L_655A:
	ld l,a			;655a
	ld h,0c4h		;655b
	ld e,(hl)			;655d
	ld d,000h		;655e
	and a			;6560
	ret p			;6561
	dec d			;6562
	ret			;6563
L_6564:
	ld hl,0c200h		;6564
L_6567:
	push hl			;6567
	ld a,l			;6568
	ld e,a			;6569
	call L_651F		;656a
	ex de,hl			;656d
	pop hl			;656e
	ld (hl),e			;656f
	inc h			;6570
	ld (hl),d			;6571
	dec h			;6572
	inc l			;6573
	jr nz,L_6567		;6574
	xor a			;6576
	ld de,0c500h		;6577
	ld hl,065a2h		;657a
L_657D:
	ld b,(hl)			;657d
L_657E:
	ld (de),a			;657e
	inc e			;657f
	djnz L_657E		;6580
	inc hl			;6582
	inc a			;6583
	cp 021h		;6584
	jr nz,L_657D		;6586
	and a			;6588
	ld bc,06602h		;6589
	ld de,0c440h		;658c
	ld hl,0c43fh		;658f
L_6592:
	ld a,(bc)			;6592
	ld (de),a			;6593
	ld (hl),a			;6594
	dec bc			;6595
	inc de			;6596
	jr z,L_659C		;6597
	dec l			;6599
	jr L_6592		;659a
L_659C:
	ld bc,00080h		;659c
	ldir		;659f
	ret			;65a1

; ----------------------------------------------------------------------
; DATOS rachas_de_la_curva: Treinta y dos cuentas de racha que 0x657D expande
;   a 0xC500: el arcotangente, comprimido por longitud de racha
;   0x65a2..0x65c2  (32 bytes)
DATA_rachas_de_la_curva:
	defb 004h,006h,006h,007h,006h,006h,007h,006h,007h,006h,007h,007h,007h,007h,007h,007h	; 65a2  ................
	defb 007h,008h,007h,008h,008h,009h,008h,009h,009h,00ah,009h,00ah,00bh,00bh,00bh,00ch	; 65b2  ................

; ----------------------------------------------------------------------
; DATOS tabla_del_seno: Sesenta y cinco pasos de un cuarto de onda, de 0x00 a
;   0xFF, que 0x658C refleja hasta llenar 0xC3C0-0xC4C0
;   0x65c2..0x6603  (65 bytes)
DATA_tabla_del_seno:
	defb 006h,000h,006h,00dh,013h,019h,01fh,026h,02ch,032h,038h,03eh,044h,04ah,050h,056h	; 65c2  .......&,28>DJPV
	defb 05ch,062h,068h,06dh,073h,079h,07eh,084h,089h,08eh,093h,098h,09dh,0a2h,0a7h,0ach	; 65d2  \bhmsy~.........
	defb 0b1h,0b5h,0b9h,0beh,0c2h,0c6h,0cah,0ceh,0d1h,0d5h,0d8h,0dch,0dfh,0e2h,0e5h,0e7h	; 65e2  ................
	defb 0eah,0edh,0efh,0f1h,0f3h,0f5h,0f7h,0f8h,0fah,0fbh,0fch,0fdh,0feh,0ffh,0ffh,0ffh	; 65f2  ................
	defb 0ffh	; 6602

; ======================================================================
; CODIGO 0x6603..0x6898  (661 bytes)
; ======================================================================


L_6603:
	di			;6603
	ld a,0f7h		;6604
	ld (0fd9fh),a		;6606
	ld a,(0fedbh)		;6609
	ld (0fda0h),a		;660c
	ld hl,L_665B		;660f
	ld (0fda1h),hl		;6612
	ei			;6615
	ld hl,0f87fh		;6616
	ld (hl),000h		;6619
	ld de,0f880h		;661b
	ld bc,0009fh		;661e
	ldir		;6621
	ld hl,0f87fh		;6623
	ld a,0f1h		;6626
	ld de,00010h		;6628
	ld b,00ah		;662b
L_662D:
	ld (hl),a			;662d
	inc a			;662e
	add hl,de			;662f
	djnz L_662D		;6630
	xor a			;6632
	ld (0f3dbh),a		;6633
L_6636:
	ld a,001h		;6636
	ld (0f3ebh),a		;6638
	ld hl,0f3e0h		;663b
	set 1,(hl)		;663e
	call 00072h		;6640   ; BIOS INIGRP - Switches to SCREEN 2 (high resolution screen with 256*192 pixels)
	call 00041h		;6643   ; BIOS DISSCR - Inhibits the screen display
	call L_67D7		;6646
	ld de,06898h		;6649
	ld hl,03800h		;664c
	ld bc,03ae0h		;664f
	call L_6AFA		;6652
	call L_66D4		;6655
	jp L_67EF		;6658
L_665B:
	ld hl,0ca33h		;665b
	ld (hl),001h		;665e
	push af			;6660
	call L_6B6D		;6661
	pop af			;6664
	ret			;6665
L_6666:
	ld hl,0ca33h		;6666
	ld (hl),000h		;6669
L_666B:
	ld a,(hl)			;666b
	and a			;666c
	jr z,L_666B		;666d
	ld a,(0c006h)		;666f
	and a			;6672
	ret nz			;6673
	ld a,(0ced2h)		;6674
	and a			;6677
	ret nz			;6678
	call 0009ch		;6679   ; BIOS CHSNS - Tests the status of the keyboard buffer
	ret z			;667c
	push bc			;667d
	push de			;667e
	push hl			;667f
	call 0009fh		;6680   ; BIOS CHGET - One character input (waiting)
	cp 0f1h		;6683
	call z,L_6769		;6685
	cp 0f2h		;6688
	call z,L_6799		;668a
	cp 0fah		;668d
	call z,L_66BD		;668f
	pop hl			;6692
	pop de			;6693
	pop bc			;6694
	ret			;6695
L_6696:
	ld b,03ch		;6696
L_6698:
	push hl			;6698
L_6699:
	call L_6666		;6699
	djnz L_6699		;669c
	pop hl			;669e
	ret			;669f
L_66A0:
	call L_6666		;66a0
	ld hl,0ca34h		;66a3
	ld (hl),000h		;66a6
	call L_6A4F		;66a8
	ret nz			;66ab
	inc (hl)			;66ac
	call L_6A4F		;66ad
	ret nz			;66b0
	inc (hl)			;66b1
	call L_6A4F		;66b2
	ret nz			;66b5
	dec bc			;66b6
	ld a,c			;66b7
	or b			;66b8
	jr nz,L_66A0		;66b9
	scf			;66bb
	ret			;66bc
L_66BD:
	call 0009fh		;66bd   ; BIOS CHGET - One character input (waiting)
	cp 0f6h		;66c0
	ret nz			;66c2
	jp L_4069		;66c3
L_66C6:
	ld hl,01800h		;66c6
	ld bc,01b00h		;66c9
	ld de,0aba1h		;66cc
	call L_6AFA		;66cf
	jr $+3		;66d2
L_66D4:
	or 0afh		;66d4
	push af			;66d6
	call 00041h		;66d7   ; BIOS DISSCR - Inhibits the screen display
	pop af			;66da
	ld (0ca40h),a		;66db
	ld hl,00000h		;66de
	call L_6702		;66e1
	ld hl,00800h		;66e4
	call L_6702		;66e7
	ld hl,01000h		;66ea
	call L_6702		;66ed
	ld hl,02000h		;66f0
	call L_671B		;66f3
	ld hl,02800h		;66f6
	call L_671B		;66f9
	ld hl,03000h		;66fc
	jp L_671B		;66ff
L_6702:
	push af			;6702
	jr z,L_670A		;6703
	call L_6AF2		;6705
	pop af			;6708
	ret			;6709
L_670A:
	ld c,l			;670a
	ld a,h			;670b
	add a,008h		;670c
	ld b,a			;670e
	ld de,00698h		;670f
	add hl,de			;6712
	ld de,0aa0eh		;6713
	call L_6AFA		;6716
	pop af			;6719
	ret			;671a
L_671B:
	push af			;671b
	jr z,L_6723		;671c
	call L_6AB5		;671e
	pop af			;6721
	ret			;6722
L_6723:
	ld c,l			;6723
	ld a,h			;6724
	add a,008h		;6725
	ld b,a			;6727
	ld de,00698h		;6728
	add hl,de			;672b
	ld de,0aafdh		;672c
	call L_6ABD		;672f
	pop af			;6732
	ret			;6733
L_6734:
	ld hl,01c00h		;6734
	ld bc,01f00h		;6737
	ld de,0acfbh		;673a
	call L_6AFA		;673d
	ld hl,03c00h		;6740
	ld bc,03ca0h		;6743
	ld de,0ae44h		;6746
	call L_6AFA		;6749
	ld b,012h		;674c
L_674E:
	push bc			;674e
	ld a,l			;674f
	add a,020h		;6750
	ld c,a			;6752
	ld a,h			;6753
	adc a,000h		;6754
	ld b,a			;6756
	ld de,0ae90h		;6757
	call L_6AFA		;675a
	pop bc			;675d
	djnz L_674E		;675e
	ld bc,03f00h		;6760
	ld de,0ae9bh		;6763
	jp L_6AFA		;6766
L_6769:
	ld a,(0ca40h)		;6769
	and a			;676c
	push af			;676d
	call z,L_66D4		;676e
	call L_678B		;6771
	ld hl,01b00h		;6774
	call 0004ah		;6777   ; BIOS RDVRM - Reads the content of VRAM
	push af			;677a
	ld a,0d0h		;677b
	call 0004dh		;677d   ; BIOS WRTVRM - Writes data in VRAM
	call 0009fh		;6780   ; BIOS CHGET - One character input (waiting)
	pop af			;6783
	call 0004dh		;6784   ; BIOS WRTVRM - Writes data in VRAM
	pop af			;6787
	call z,L_66D4+1		;6788
L_678B:
	ld a,(0f3e1h)		;678b
	xor 001h		;678e
	ld b,a			;6790
	ld c,002h		;6791
	call 00047h		;6793   ; BIOS WRTVDP - Writes data in the VDP-register
	jp 00044h		;6796   ; BIOS ENASCR - Displays the screen
L_6799:
	ld a,(0c005h)		;6799
	cp 002h		;679c
	ret nz			;679e
	call L_67CC		;679f
	ld hl,01b00h		;67a2
	call 0004ah		;67a5   ; BIOS RDVRM - Reads the content of VRAM
	push af			;67a8
	push hl			;67a9
	ld a,0d0h		;67aa
	call 0004dh		;67ac   ; BIOS WRTVRM - Writes data in VRAM
L_67AF:
	call 0009fh		;67af   ; BIOS CHGET - One character input (waiting)
	ld hl,0c112h		;67b2
	cp 01eh		;67b5
	jr nz,L_67BE		;67b7
	call L_4E47		;67b9
	jr L_67AF		;67bc
L_67BE:
	cp 01fh		;67be
	jr nz,L_67C7		;67c0
	call L_4E41		;67c2
	jr L_67AF		;67c5
L_67C7:
	pop hl			;67c7
	pop af			;67c8
	call 0004dh		;67c9   ; BIOS WRTVRM - Writes data in VRAM
L_67CC:
	ld a,(0f3e1h)		;67cc
	xor 009h		;67cf
	ld b,a			;67d1
	ld c,002h		;67d2
	jp 00047h		;67d4   ; BIOS WRTVDP - Writes data in the VDP-register
L_67D7:
	xor a			;67d7
	ld bc,00300h		;67d8
	ld hl,01800h		;67db
	call 00056h		;67de   ; BIOS FILVRM - Fills VRAM with value
	ld hl,0c673h		;67e1
	ld de,0c674h		;67e4
	ld bc,003bfh		;67e7
	ld (hl),000h		;67ea
	ldir		;67ec
	ret			;67ee
L_67EF:
	ld hl,01801h		;67ef
	ld de,069b3h		;67f2
	ld c,018h		;67f5
L_67F7:
	ld b,00ah		;67f7
	call L_6822		;67f9
	push de			;67fc
	ld de,00016h		;67fd
	add hl,de			;6800
	pop de			;6801
	dec c			;6802
	jr nz,L_67F7		;6803
	ret			;6805
L_6806:
	ld c,006h		;6806
	jr L_680C		;6808
L_680A:
	ld c,007h		;680a
L_680C:
	ld hl,01a21h		;680c
	ld de,06a28h		;680f
L_6812:
	ld b,009h		;6812
	call L_6822		;6814
	inc de			;6817
	push de			;6818
	ld de,00017h		;6819
	add hl,de			;681c
	pop de			;681d
	dec c			;681e
	jr nz,L_6812		;681f
	ret			;6821
L_6822:
	push bc			;6822
L_6823:
	ld a,(de)			;6823
	cp 020h		;6824
	jr nc,L_683B		;6826
	ld c,a			;6828
	res 4,c		;6829
	cp 010h		;682b
	ld a,020h		;682d
	jr c,L_6833		;682f
	inc de			;6831
	ld a,(de)			;6832
L_6833:
	dec c			;6833
L_6834:
	call L_6893		;6834
	dec b			;6837
	dec c			;6838
	jr nz,L_6834		;6839
L_683B:
	call L_6893		;683b
	inc de			;683e
	djnz L_6823		;683f
	pop bc			;6841
	ret			;6842
L_6843:
	ld a,(0fcabh)		;6843
	and a			;6846
	jp nz,vuelca_el_hoyo		;6847
	ld hl,0cb00h		;684a
	ld de,0c673h		;684d
	ld bc,001e0h		;6850
	ldir		;6853
	ld b,019h		;6855
	ld de,0c853h		;6857
L_685A:
	push bc			;685a
	push de			;685b
	ld b,018h		;685c
	ld hl,0180bh		;685e
L_6861:
	push bc			;6861
	ld bc,(00007h)		;6862
	ld b,014h		;6866
	call 00053h		;6868   ; BIOS SETWRT - Enables VDP to write
	ex de,hl			;686b
L_686C:
	outi		;686c
	jr nz,L_686C		;686e
	ex de,hl			;6870
	ld bc,00020h		;6871
	add hl,bc			;6874
	pop bc			;6875
	djnz L_6861		;6876
	pop de			;6878
	ld hl,0ffech		;6879
	add hl,de			;687c
	ex de,hl			;687d
	call L_6666		;687e
	call L_6666		;6881
	pop bc			;6884
	djnz L_685A		;6885
	ld hl,0c673h		;6887
	ld de,0c853h		;688a
	ld bc,001e0h		;688d
	ldir		;6890
	ret			;6892
L_6893:
	call 0004dh		;6893   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6896
	ret			;6897

; ----------------------------------------------------------------------
; DATOS sprites_comprimidos: Los sprites, comprimidos por rachas: 736 bytes
;   que van a 0x3800-0x3AE0
;   0x6898..0x69b3  (283 bytes)
DATA_sprites_comprimidos:
	defb 000h,060h,060h,0afh,000h,0aah,000h,060h,0f0h,0f0h,060h,0afh,000h,0a9h,000h,000h	; 6898  .``....`..`.....
	defb 060h,0f0h,060h,0afh,000h,0a9h,000h,020h,020h,0d8h,020h,020h,0afh,000h,0a8h,000h	; 68a8  `.`....  .  ....
	defb 0c0h,0e0h,0c0h,0afh,000h,0aah,000h,0a3h,080h,0afh,000h,0a8h,000h,010h,010h,038h	; 68b8  ...............8
	defb 038h,07ch,07ch,0feh,0feh,0afh,000h,0a5h,000h,0a6h,018h,0afh,000h,0a5h,000h,0a6h	; 68c8  8||.............
	defb 03ch,0afh,000h,0a5h,000h,0a6h,07eh,0afh,000h,0a5h,000h,0a6h,0ffh,0afh,000h,0a5h	; 68d8  <.....~.........
	defb 000h,000h,000h,001h,003h,007h,00fh,0a6h,001h,0a2h,000h,080h,0c0h,0e0h,0f0h,0a6h	; 68e8  ................
	defb 080h,000h,000h,0a1h,000h,001h,0a1h,000h,001h,003h,007h,00eh,01ch,008h,0a4h,000h	; 68f8  ................
	defb 0f8h,0f8h,078h,0f8h,0d8h,088h,0a5h,000h,0a5h,000h,03fh,03fh,0a9h,000h,020h,030h	; 6908  ..x.......??.. 0
	defb 038h,0fch,0fch,038h,030h,020h,0a2h,000h,0a1h,000h,008h,01ch,00eh,007h,003h,001h	; 6918  8..80 ..........
	defb 0a1h,000h,001h,0a8h,000h,088h,0d8h,0f8h,078h,0f8h,0f8h,0a1h,000h,000h,000h,0a6h	; 6928  ........x.......
	defb 001h,00fh,007h,003h,001h,0a2h,000h,0a6h,080h,0f0h,0e0h,0c0h,080h,000h,000h,0a5h	; 6938  ................
	defb 000h,011h,01bh,01fh,01eh,01fh,01fh,0a4h,000h,010h,038h,070h,0e0h,0c0h,080h,0a1h	; 6948  ..........8p....
	defb 000h,080h,0a1h,000h,0a2h,000h,004h,00ch,01ch,03fh,03fh,01ch,00ch,004h,0a9h,000h	; 6958  .........??.....
	defb 0fch,0fch,0a5h,000h,0a1h,000h,01fh,01fh,01eh,01fh,01bh,011h,0a8h,000h,080h,0a1h	; 6968  ................
	defb 000h,080h,0c0h,0e0h,070h,038h,010h,0a1h,000h,0ffh,0ffh,0a6h,0c0h,0ffh,0ffh,0a2h	; 6978  ....p8..........
	defb 000h,0f0h,0f0h,0a6h,030h,0f0h,0f0h,0a2h,000h,0e7h,081h,081h,000h,000h,081h,081h	; 6988  ....0...........
	defb 0e7h,0a6h,000h,0a6h,000h,0a6h,000h,0ffh,0ffh,0aah,0c0h,0a2h,0ffh,0aah,000h,0ffh	; 6998  ................
	defb 0ffh,0ffh,0ffh,0aah,000h,0a2h,0ffh,0aah,003h,0ffh,0ffh	; 69a8  ...........

; ----------------------------------------------------------------------
; DATOS texto_del_panel: El panel de la izquierda: 24 filas de 10 caracteres a
;   0x1801, con TOP, 1UP, 2UP, SHOTS, HOLE, PAR, POWER, CURVE y CLUB. 0x6A28
;   es donde empieza su fila 17, y 0x680C redibuja desde ahi las seis o siete
;   de abajo
;   0x69b3..0x6a4f  (156 bytes)
DATA_texto_del_panel:
	defb 027h,017h,028h,029h,021h,02ah,054h,04fh,050h,004h,02bh,021h,02ah,031h,055h,050h	; 69b3  '.()!*TOP.+!*1UP
	defb 004h,02bh,021h,02ah,032h,055h,050h,004h,02bh,021h,02ch,017h,02dh,02eh,022h,02ah	; 69c3  .+!*2UP.+!,.-."*
	defb 020h,053h,048h,04fh,054h,053h,020h,02bh,021h,02ah,020h,031h,055h,050h,003h,02bh	; 69d3   SHOTS +!* 1UP.+
	defb 021h,02ah,020h,032h,055h,050h,003h,02bh,021h,02ch,017h,02dh,02eh,021h,02ah,048h	; 69e3  !* 2UP.+!,.-.!*H
	defb 04fh,04ch,045h,003h,02bh,021h,02ah,005h,03fh,020h,02bh,021h,02ah,020h,050h,041h	; 69f3  OLE.+!*.? +!* PA
	defb 052h,003h,02bh,023h,02ah,020h,05fh,05fh,004h,02bh,021h,02ah,020h,05fh,05fh,004h	; 6a03  R.+#* __.+!* __.
	defb 02bh,021h,02ah,020h,0d8h,0d8h,004h,02bh,021h,02ah,020h,0d8h,0d8h,004h,02bh,021h	; 6a13  +!* ...+!* ...+!
	defb 024h,017h,025h,026h,021h,009h,022h,002h,050h,04fh,057h,045h,052h,002h,021h,020h	; 6a23  $.%&!.".POWER.! 
	defb 017h,000h,020h,021h,002h,043h,055h,052h,056h,045h,002h,021h,020h,0d2h,015h,094h	; 6a33  .. !.CURVE.! ...
	defb 0d3h,020h,021h,009h,021h,020h,043h,04ch,055h,042h,004h,021h	; 6a43  . !.! CLUB.!

; ======================================================================
; CODIGO 0x6a4f..0x6b55  (262 bytes)
; ======================================================================


L_6A4F:
	push bc			;6a4f
L_6A50:
	ld a,(0ca34h)		;6a50
	call 000d8h		;6a53   ; BIOS GTTRIG - Returns current trigger status
	push af			;6a56
	ld a,(0ca34h)		;6a57
	call 000d8h		;6a5a   ; BIOS GTTRIG - Returns current trigger status
	pop bc			;6a5d
	cp b			;6a5e
	jr nz,L_6A50		;6a5f
	and a			;6a61
	jr z,L_6A6A		;6a62
	ld a,(0ca35h)		;6a64
	cpl			;6a67
	and a			;6a68
	ld a,b			;6a69
L_6A6A:
	ld (0ca35h),a		;6a6a
	pop bc			;6a6d
	ret			;6a6e
L_6A6F:
	call L_6A7C		;6a6f
	push af			;6a72
	call L_6A7C		;6a73
	pop bc			;6a76
	cp b			;6a77
	jr nz,L_6A6F		;6a78
	and a			;6a7a
	ret			;6a7b
L_6A7C:
	ld a,(0ca34h)		;6a7c
	and 001h		;6a7f
	jp 000d5h		;6a81   ; BIOS GTSTCK - Returns the joystick status
L_6A84:
	push af			;6a84
	ld a,00fh		;6a85
	ld e,0cfh		;6a87
	call 00093h		;6a89   ; BIOS WRTPSG - Writes data to PSG-register
	call L_6AA6		;6a8c
	ld c,a			;6a8f
	ld a,00fh		;6a90
	ld e,0efh		;6a92
	call 00093h		;6a94   ; BIOS WRTPSG - Writes data to PSG-register
	call L_6AA6		;6a97
	ld e,a			;6a9a
	push de			;6a9b
	ld a,00fh		;6a9c
	ld e,0cfh		;6a9e
	call 00093h		;6aa0   ; BIOS WRTPSG - Writes data to PSG-register
	pop de			;6aa3
	pop af			;6aa4
	ret			;6aa5
L_6AA6:
	ld a,00eh		;6aa6
	call 00096h		;6aa8   ; BIOS RDPSG - Reads value from PSG-register
	and 00fh		;6aab
	xor 008h		;6aad
	bit 3,a		;6aaf
	ret z			;6ab1
	or 0f0h		;6ab2
	ret			;6ab4
L_6AB5:
	ld de,0a5e6h		;6ab5
	ld a,h			;6ab8
	add a,008h		;6ab9
	ld b,a			;6abb
	ld c,l			;6abc
L_6ABD:
	ld a,h			;6abd
	cp b			;6abe
	jr nz,L_6AC4		;6abf
	ld a,l			;6ac1
	cp c			;6ac2
	ret z			;6ac3
L_6AC4:
	ld a,(de)			;6ac4
	and 0f0h		;6ac5
	cp 000h		;6ac7
	jr z,L_6AD2		;6ac9
	ld a,(de)			;6acb
	call L_6893		;6acc
	inc de			;6acf
	jr L_6ABD		;6ad0
L_6AD2:
	push bc			;6ad2
	ld a,(de)			;6ad3
	and 00fh		;6ad4
	ld c,a			;6ad6
	inc de			;6ad7
	ld a,(de)			;6ad8
	ld b,a			;6ad9
	inc de			;6ada
	ld a,(de)			;6adb
	ex af,af'			;6adc
	inc de			;6add
	ld a,(de)			;6ade
	inc de			;6adf
	ex af,af'			;6ae0
L_6AE1:
	call L_6893		;6ae1
	ex af,af'			;6ae4
	call L_6893		;6ae5
	ex af,af'			;6ae8
	djnz L_6AE1		;6ae9
	dec c			;6aeb
	jp p,L_6AE1		;6aec
	pop bc			;6aef
	jr L_6ABD		;6af0
L_6AF2:
	ld de,09f85h		;6af2
	ld a,h			;6af5
	add a,008h		;6af6
	ld b,a			;6af8
	ld c,l			;6af9
L_6AFA:
	ld a,h			;6afa
	cp b			;6afb
	jr nz,L_6B01		;6afc
	ld a,l			;6afe
	cp c			;6aff
	ret z			;6b00
L_6B01:
	ld a,(de)			;6b01
	and 0f0h		;6b02
	cp 0a0h		;6b04
	jr z,L_6B0F		;6b06
	ld a,(de)			;6b08
	call L_6893		;6b09
	inc de			;6b0c
	jr L_6AFA		;6b0d
L_6B0F:
	push bc			;6b0f
	ld a,(de)			;6b10
	and 00fh		;6b11
	ld b,a			;6b13
	inc b			;6b14
	inc b			;6b15
	inc de			;6b16
	ld a,(de)			;6b17
	inc de			;6b18
L_6B19:
	call L_6893		;6b19
	djnz L_6B19		;6b1c
	pop bc			;6b1e
	jr L_6AFA		;6b1f
L_6B21:
	xor a			;6b21
	ld (0ca46h),a		;6b22
	dec a			;6b25
	ld (0ca41h),a		;6b26
	ld (0ca47h),a		;6b29
	ret			;6b2c
L_6B2D:
	ld e,a			;6b2d
	ld a,(0c118h)		;6b2e
	and a			;6b31
	ret nz			;6b32
	ld a,e			;6b33
	ld a,e			;6b34
	ld (0ca41h),a		;6b35
	add a,a			;6b38
	ld b,000h		;6b39
	ld c,a			;6b3b
	ld hl,06b55h		;6b3c
	add hl,bc			;6b3f
	ld e,(hl)			;6b40
	inc hl			;6b41
	ld d,(hl)			;6b42
	di			;6b43
	ld (0ca42h),de		;6b44
	ld hl,0ca66h		;6b48
	ld (0ca44h),hl		;6b4b
	ld a,001h		;6b4e
	ld (0ca46h),a		;6b50
	ei			;6b53
	ret			;6b54

; ----------------------------------------------------------------------
; DATOS tabla_de_pistas: Doce punteros de 16 bits: donde empieza cada pista de
;   PSG
;   0x6b55..0x6b6d  (24 bytes)
DATA_tabla_de_pistas:
	defw 06d48h,06d50h,06c66h,06ce8h	; 6b55  -> DATA_pista_0 DATA_pista_1 DATA_pista_2 DATA_pista_3
	defw 06cd8h,06d1ah,06d3ch,06d5ah	; 6b5d  -> DATA_pista_4 DATA_pista_5 DATA_pista_6 DATA_pista_7
	defw 06d7bh,06d97h,06dbch,06ddfh	; 6b65  -> DATA_pista_8 DATA_pista_9 DATA_pista_10 DATA_pista_11

; ======================================================================
; CODIGO 0x6b6d..0x6c0d  (160 bytes)
; ======================================================================


L_6B6D:
	ld hl,0ca46h		;6b6d
	ld a,(hl)			;6b70
	and a			;6b71
	jr nz,L_6B7A		;6b72
	ld a,0ffh		;6b74
	ld (0ca41h),a		;6b76
	ret			;6b79
L_6B7A:
	dec (hl)			;6b7a
	ret nz			;6b7b
	ld hl,(0ca42h)		;6b7c
	ld ix,(0ca44h)		;6b7f
L_6B83:
	ld a,(hl)			;6b83
	and 0c0h		;6b84
	jr z,L_6BA8		;6b86
	rlca			;6b88
	rlca			;6b89
	dec a			;6b8a
	add a,a			;6b8b
	push af			;6b8c
	ld a,(hl)			;6b8d
	and 03fh		;6b8e
	add a,a			;6b90
	exx			;6b91
	ld b,000h		;6b92
	ld c,a			;6b94
	ld hl,06c0dh		;6b95
	add hl,bc			;6b98
	ld e,(hl)			;6b99
	pop af			;6b9a
	call 00093h		;6b9b   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;6b9e
	inc hl			;6b9f
	ld e,(hl)			;6ba0
	call 00093h		;6ba1   ; BIOS WRTPSG - Writes data to PSG-register
	exx			;6ba4
	inc hl			;6ba5
	jr L_6B83		;6ba6
L_6BA8:
	ld a,(hl)			;6ba8
	and 020h		;6ba9
	jr nz,L_6BC4		;6bab
	ld a,(hl)			;6bad
L_6BAE:
	ld (0ca46h),a		;6bae
	inc hl			;6bb1
	ld (0ca42h),hl		;6bb2
	ld (0ca44h),ix		;6bb5
	ld a,(0ca47h)		;6bb9
	and a			;6bbc
	ld e,a			;6bbd
	ld a,00dh		;6bbe
	call p,00093h		;6bc0   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6bc3
L_6BC4:
	ld a,(hl)			;6bc4
	bit 4,a		;6bc5
	jr nz,L_6BDE		;6bc7
	inc hl			;6bc9
	cp 02dh		;6bca
	jr z,L_6BD7		;6bcc
	and 00fh		;6bce
	ld e,(hl)			;6bd0
	call 00093h		;6bd1   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6bd4
	jr L_6B83		;6bd5
L_6BD7:
	ld a,(hl)			;6bd7
	ld (0ca47h),a		;6bd8
	inc hl			;6bdb
	jr L_6B83		;6bdc
L_6BDE:
	cp 03dh		;6bde
	jr nz,L_6BEC		;6be0
	ld e,0bfh		;6be2
	ld a,007h		;6be4
	call 00093h		;6be6   ; BIOS WRTPSG - Writes data to PSG-register
	xor a			;6be9
	jr L_6BAE		;6bea
L_6BEC:
	cp 03eh		;6bec
	jr nz,L_6BFF		;6bee
	ld e,000h		;6bf0
	ld a,000h		;6bf2
L_6BF4:
	call 00093h		;6bf4   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;6bf7
	cp 006h		;6bf8
	jr nz,L_6BF4		;6bfa
	inc hl			;6bfc
L_6BFD:
	jr L_6B83		;6bfd
L_6BFF:
	cp 033h		;6bff
	jr nz,L_6C0A		;6c01
	inc hl			;6c03
	ld e,(hl)			;6c04
	inc hl			;6c05
	ld d,(hl)			;6c06
	ex de,hl			;6c07
	jr L_6BFD		;6c08
L_6C0A:
	jp L_6B83		;6c0a

; ----------------------------------------------------------------------
; DATOS tabla_de_tonos: Cuarenta y cuatro notas (indices 0 a 43), pareja de
;   registros fino y grueso por nota
;   0x6c0d..0x6c65  (88 bytes)
DATA_tabla_de_tonos:
	defw 0007eh,0008eh,000a0h,000a9h	; 6c0d
	defw 000beh,00501h,004b9h,00475h	; 6c15
	defw 000d5h,003f1h,003c0h,0038ah	; 6c1d
	defw 00357h,00327h,002f9h,002cfh	; 6c25
	defw 002a6h,00280h,0025ch,0023ah	; 6c2d
	defw 0021ah,001f8h,001e0h,001c5h	; 6c35
	defw 001abh,00193h,0017ch,00167h	; 6c3d
	defw 00153h,00140h,0012eh,0011dh	; 6c45
	defw 0010dh,000fch,000f0h,000e2h	; 6c4d
	defw 00000h,000c9h,00086h,00054h	; 6c55
	defw 00050h,0004bh,000b3h,00435h	; 6c5d

; ----------------------------------------------------------------------
; DATOS tono_sobrante: Un byte que ninguna de las doce pistas alcanza: la nota
;   mas alta que usan es la 43
;   0x6c65..0x6c66  (1 bytes)
DATA_tono_sobrante:
	defb 03dh	; 6c65

; ----------------------------------------------------------------------
; DATOS pista_2: Pista 2, la del menu y la vuelta; para con un 0x3D en 0x6CD6
;   0x6c66..0x6cd7  (113 bytes)
DATA_pista_2:
	defb 027h,0b8h,028h,010h,029h,010h,02ah,010h,02ch,010h,02dh,000h,061h,09dh,0c5h,00ah	; 6c66  '.(.).*.,.-.a...
	defb 062h,09fh,0d1h,00ah,048h,0a1h,0c5h,00ah,042h,088h,0d1h,014h,048h,0a1h,0d1h,00ah	; 6c76  b...H...B...H...
	defb 044h,0a2h,0c9h,00ah,043h,088h,0d5h,00ah,042h,084h,0cah,00ah,041h,083h,0d6h,00ah	; 6c86  D...C...B...A...
	defb 040h,084h,0cah,00ah,041h,0a5h,0d5h,014h,043h,0a5h,0d5h,00ah,065h,09fh,0d0h,00ah	; 6c96  @...A...C...e...
	defb 05fh,099h,0d5h,00ah,061h,09dh,0ceh,00ah,062h,0dah,00ah,048h,0cdh,00ah,044h,0d9h	; 6ca6  _...a...b..H..D.
	defb 00ah,048h,0a1h,0cch,00ah,044h,09dh,0d5h,00ah,043h,0a1h,0d8h,00ah,042h,0ddh,00ah	; 6cb6  .H...D...C...B..
	defb 041h,0a2h,0d3h,00ah,044h,09dh,0c7h,00ah,043h,0a2h,0cch,00ah,042h,0a1h,0d1h,014h	; 6cc6  A...D...C...B...
	defb 03dh	; 6cd6

; ----------------------------------------------------------------------
; DATOS pista_sobrante: Un byte de relleno entre la pista 2 y la 4
;   0x6cd7..0x6cd8  (1 bytes)
DATA_pista_sobrante:
	defb 03dh	; 6cd7

; ----------------------------------------------------------------------
; DATOS pista_4: Pista 4, la mas corta: la de meter la bola
;   0x6cd8..0x6ce8  (16 bytes)
DATA_pista_4:
	defb 027h,0beh,028h,010h,02ch,00ah,02dh,000h,041h,010h,008h,006h,004h,004h,004h,03dh	; 6cd8  '.(.,.-.A......=

; ----------------------------------------------------------------------
; DATOS pista_3: Pista 3, la del hoyo en uno y el albatros
;   0x6ce8..0x6d1a  (50 bytes)
DATA_pista_3:
	defb 027h,0b8h,028h,010h,029h,010h,02ah,010h,02ch,010h,02dh,000h,055h,091h,0c5h,008h	; 6ce8  '.(.).*.,.-.U...
	defb 059h,095h,008h,05ch,099h,008h,061h,09dh,0d1h,008h,065h,0a1h,008h,043h,0a5h,008h	; 6cf8  Y..\..a...e..C..
	defb 067h,0a5h,0e1h,008h,068h,084h,0e2h,008h,02ch,030h,069h,0aah,0e3h,014h,02dh,0ffh	; 6d08  g...h...,0i...-.
	defb 014h,03dh	; 6d18

; ----------------------------------------------------------------------
; DATOS pista_5: Pista 5; sigue en la 6
;   0x6d1a..0x6d3c  (34 bytes)
DATA_pista_5:
	defb 027h,0aeh,028h,00fh,029h,010h,02ch,012h,02dh,000h,064h,026h,007h,000h,027h,0aeh	; 6d1a  '.(.).,.-.d&..'.
	defb 029h,010h,028h,00dh,064h,026h,010h,02ch,00ah,02dh,00dh,000h,02ch,032h,064h,02dh	; 6d2a  ).(.d&.,.-..,2d-
	defb 000h,000h	; 6d3a

; ----------------------------------------------------------------------
; DATOS pista_6: Pista 6; sigue en la 0
;   0x6d3c..0x6d48  (12 bytes)
DATA_pista_6:
	defb 027h,0b7h,028h,010h,026h,002h,02ch,019h,064h,02dh,000h,000h	; 6d3c  '.(.&.,.d-..

; ----------------------------------------------------------------------
; DATOS pista_0: Pista 0; sigue en la 1
;   0x6d48..0x6d50  (8 bytes)
DATA_pista_0:
	defb 064h,02ch,004h,026h,01bh,02dh,000h,000h	; 6d48  d,.&.-..

; ----------------------------------------------------------------------
; DATOS pista_1: Pista 1, la de la bola parada; sigue en la 7
;   0x6d50..0x6d5a  (10 bytes)
DATA_pista_1:
	defb 027h,0bdh,02ch,00ah,029h,010h,02dh,000h,089h,000h	; 6d50  '.,.).-...

; ----------------------------------------------------------------------
; DATOS pista_7: Pista 7, la del bogey; aqui acaban las cinco que comparten
;   cola
;   0x6d5a..0x6d7b  (33 bytes)
DATA_pista_7:
	defb 027h,0b8h,028h,010h,029h,00dh,02ah,00ah,02ch,020h,02dh,000h,04dh,0a4h,0c6h,008h	; 6d5a  '.(.).*., -.M...
	defb 052h,0cdh,008h,056h,0c6h,008h,05ah,097h,0d3h,010h,02ch,030h,059h,096h,0d2h,01fh	; 6d6a  R..V..Z...,0Y...
	defb 03dh	; 6d7a

; ----------------------------------------------------------------------
; DATOS pista_8: Pista 8, la del eagle
;   0x6d7b..0x6d97  (28 bytes)
DATA_pista_8:
	defb 027h,0b8h,028h,010h,029h,010h,02ah,00ch,02ch,018h,02dh,000h,05eh,099h,0d6h,006h	; 6d7b  '.(.).*.,.-.^...
	defb 062h,0d2h,006h,065h,09eh,0d6h,006h,066h,0a5h,0ddh,01fh,03dh	; 6d8b  b..e...f...=

; ----------------------------------------------------------------------
; DATOS pista_9: Pista 9, la del birdie
;   0x6d97..0x6dbc  (37 bytes)
DATA_pista_9:
	defb 027h,0b8h,028h,00fh,029h,00dh,02ah,00dh,05dh,095h,0d1h,006h,048h,09dh,0d5h,006h	; 6d97  '.(.).*.]...H...
	defb 061h,098h,0ddh,006h,044h,091h,0d6h,006h,064h,0a4h,0dah,006h,062h,09fh,0dch,006h	; 6da7  a...D...d...b...
	defb 048h,0a1h,0ddh,01fh,03dh	; 6db7

; ----------------------------------------------------------------------
; DATOS pista_10: Pista 10, la del par
;   0x6dbc..0x6ddf  (35 bytes)
DATA_pista_10:
	defb 027h,0b8h,028h,00fh,029h,00dh,02ah,00ch,042h,0a1h,0d1h,006h,048h,0ddh,006h,040h	; 6dbc  '.(.).*.B...H..@
	defb 088h,0d8h,006h,042h,0a1h,0ddh,006h,048h,0d8h,006h,040h,088h,0cch,006h,042h,0a1h	; 6dcc  ...B...H..@...B.
	defb 0d1h,010h,03dh	; 6ddc

; ----------------------------------------------------------------------
; DATOS pista_11: Pista 11, la mas larga (362 bytes) y la unica que da
;   vueltas: acaba en un salto a si misma
;   0x6ddf..0x6f49  (362 bytes)
DATA_pista_11:
	defb 027h,0b8h,028h,00fh,029h,00ch,02ah,00dh,048h,0a1h,0d1h,00ch,03eh,00ch,042h,0a1h	; 6ddf  '.(.).*.H...>.B.
	defb 0d1h,00ch,03eh,00ch,043h,088h,0d2h,00ch,0e4h,00ch,0ceh,00ch,044h,09eh,0e4h,006h	; 6def  ..>.C.......D...
	defb 048h,006h,062h,09fh,0d3h,006h,064h,0a4h,006h,044h,0a2h,006h,064h,0a4h,006h,042h	; 6dff  H.b...d..D..d..B
	defb 0a2h,0d3h,006h,03eh,006h,044h,0a2h,0ceh,006h,064h,0a4h,0cdh,006h,043h,0a2h,0cch	; 6e0f  ...>.D...d...C..
	defb 00ch,03eh,006h,048h,0a2h,0d8h,004h,03eh,002h,048h,0a2h,0d8h,00ch,03eh,00ch,040h	; 6e1f  .>.H...>.H...>.@
	defb 088h,0d1h,00ch,03eh,00ch,041h,0aah,0c9h,00ch,03eh,00ch,042h,084h,0cah,00ch,03eh	; 6e2f  ...>.A...>.B...>
	defb 00ch,043h,0a0h,0cbh,006h,03eh,006h,044h,0a0h,0d7h,006h,03eh,006h,048h,0a1h,0d8h	; 6e3f  .C...>.D...>.H..
	defb 003h,03eh,003h,048h,0a1h,0d8h,003h,03eh,003h,063h,0a1h,0d8h,003h,03eh,003h,048h	; 6e4f  .>.H...>.c...>.H
	defb 0a1h,0d8h,003h,03eh,003h,065h,0a2h,0cch,003h,03eh,003h,044h,0a2h,0cch,003h,03eh	; 6e5f  ...>.e...>.D...>
	defb 003h,06ah,0a2h,0cch,003h,03eh,003h,043h,0a2h,0cch,003h,03eh,003h,042h,0a1h,0d1h	; 6e6f  .j...>.C...>.B..
	defb 00ch,03eh,006h,05dh,095h,0c5h,004h,03eh,002h,05dh,095h,0c5h,00ch,03eh,00ch,05fh	; 6e7f  .>.]...>.]...>._
	defb 096h,0cch,00ch,03eh,00ch,05eh,09bh,0c5h,00ch,03eh,00ch,05dh,09ah,0cah,004h,064h	; 6e8f  ...>.^...>.]...d
	defb 0a4h,002h,0e4h,006h,044h,09dh,004h,064h,0a4h,008h,061h,09dh,0cbh,004h,064h,0a4h	; 6e9f  ....D..d..a...d.
	defb 002h,0e4h,006h,060h,09dh,004h,064h,0a4h,008h,05fh,09bh,0cch,004h,03eh,008h,062h	; 6eaf  ...`..d.._...>.b
	defb 09bh,0c6h,004h,03eh,008h,061h,09bh,0c5h,004h,03eh,008h,05dh,095h,0cfh,006h,05eh	; 6ebf  ...>.a...>.]...^
	defb 0a4h,0e4h,006h,05fh,096h,0ceh,004h,0e4h,008h,0cah,004h,0e4h,008h,05dh,09ah,0c9h	; 6ecf  ..._.........]..
	defb 004h,03eh,008h,0ebh,004h,0e4h,008h,061h,098h,0c7h,00ch,03eh,00ch,060h,09dh,0cbh	; 6edf  .>.....a...>.`..
	defb 00ch,03eh,00ch,05fh,09ch,0cch,004h,03eh,008h,043h,09fh,004h,064h,0a4h,008h,043h	; 6eef  .>._...>.C..d..C
	defb 09fh,0cdh,004h,03eh,008h,042h,09fh,0cdh,004h,03eh,008h,043h,09dh,0ceh,004h,03eh	; 6eff  ...>.B...>.C...>
	defb 008h,061h,09dh,0ceh,004h,03eh,008h,063h,09dh,0c7h,004h,03eh,008h,043h,09dh,0d3h	; 6f0f  .a...>.c...>.C..
	defb 004h,03eh,008h,044h,09ch,0d8h,004h,0e4h,002h,0d7h,004h,0e4h,002h,0d6h,004h,0e4h	; 6f1f  .>.D............
	defb 002h,0d3h,004h,0e4h,002h,0cch,004h,0e4h,002h,0cdh,004h,03eh,002h,065h,0a2h,0ceh	; 6f2f  ...........>.e..
	defb 004h,03eh,002h,0d0h,004h,0e4h,002h,033h,0dfh,06dh	; 6f3f  .>.....3.m

; ======================================================================
; CODIGO 0x6f49..0x70f2  (425 bytes)
; ======================================================================


monta_el_hoyo:		; Interpreta el guion del hoyo -o el del green- y lo suelta en el buffer de RAM
	ld a,(0c011h)		;6f49   ; 0xC011 dice si se juega la vista del green
	and a			;6f4c
	jr z,L_6F54		;6f4d
	ld hl,09d6ch		;6f4f   ; y entonces el guion es siempre el mismo
	jr L_6F63		;6f52
L_6F54:
	ld a,(0cec3h)		;6f54   ; si no, el hoyo por el que va la vuelta
	ld hl,(0c000h)		;6f57   ; sobre la tabla del campo elegido
	add a,a			;6f5a
	ld e,a			;6f5b
	ld d,000h		;6f5c
	add hl,de			;6f5e
	ld e,(hl)			;6f5f
	inc hl			;6f60
	ld d,(hl)			;6f61
	ex de,hl			;6f62
L_6F63:
	ld de,0cec0h		;6f63   ; los tres bytes de cabecera, que son la paleta del hoyo
	call lee_tres_del_guion		;6f66
	ld de,0cb00h		;6f69   ; el hoyo se monta en 0xCB00
	ld a,(0c011h)		;6f6c
	and a			;6f6f
	jr z,L_6F75		;6f70
	ld de,0cce0h		;6f72   ; y el green en 0xCCE0
L_6F75:
	call lee_del_guion		;6f75   ; un opcode
	cp 021h		;6f78   ; 0x21 cierra el guion
	jr z,L_6FCE		;6f7a
	cp 030h		;6f7c   ; por debajo de 0x30 es una casilla tal cual
	jr c,L_6FA4		;6f7e
	cp 060h		;6f80   ; y de 0x60 para arriba, tambien
	jr nc,L_6FA4		;6f82
	and 00fh		;6f84   ; el nibble bajo, mas uno, es la cuenta
	ld b,a			;6f86
	inc b			;6f87
	call lee_del_guion		;6f88   ; y el alto dice cual de los tres materiales
	push hl			;6f8b
	push de			;6f8c
	and 0f0h		;6f8d
	rrca			;6f8f
	rrca			;6f90
	rrca			;6f91
	rrca			;6f92
	ld hl,0cebdh		;6f93   ; 0xCEBD son tres bytes antes de la cabecera: por eso el 3, el 4 y el 5 caen encima de ella
	ld e,a			;6f96
	ld d,000h		;6f97
	add hl,de			;6f99
	pop de			;6f9a
	ld a,(hl)			;6f9b
L_6F9C:
	ld (de),a			;6f9c   ; y se repite la cuenta
	inc de			;6f9d
	djnz L_6F9C		;6f9e
	pop hl			;6fa0
	inc hl			;6fa1
	jr L_6F75		;6fa2
L_6FA4:
	ld (de),a			;6fa4   ; casilla literal
	cp 0e9h		;6fa5   ; 0xE9 es la bandera...
	jr nz,L_6FAD		;6fa7
	ld (0cec6h),de		;6fa9   ; ...y se apunta donde ha caido
L_6FAD:
	cp 0d9h		;6fad   ; 0xD9 es el tee de par 3
	jr nz,L_6FB5		;6faf
	ld a,003h		;6fb1
	jr L_6FC3		;6fb3
L_6FB5:
	cp 0ddh		;6fb5   ; 0xDD el de par 4
	jr nz,L_6FBD		;6fb7
	ld a,004h		;6fb9
	jr L_6FC3		;6fbb
L_6FBD:
	cp 0e3h		;6fbd   ; y 0xE3 el de par 5
	jr nz,L_6FCA		;6fbf
	ld a,005h		;6fc1
L_6FC3:
	ld (0c06ch),a		;6fc3   ; o sea que el tee DICE el par
	ld (0cec8h),de		;6fc6   ; y tambien se apunta donde esta
L_6FCA:
	inc hl			;6fca
	inc de			;6fcb
	jr L_6F75		;6fcc
L_6FCE:
	ld a,(0c011h)		;6fce   ; con el green ya esta
	and a			;6fd1
	jp nz,vuelca_el_green		;6fd2
	inc hl			;6fd5
	ld de,0cecfh		;6fd6   ; detras del 0x21 van los tres digitos de la longitud
	call lee_tres_del_guion		;6fd9
	ld a,(0c006h)		;6fdc   ; en el editor no se sortea nada
	and a			;6fdf
	ret nz			;6fe0
L_6FE1:
	ld hl,(0cec6h)		;6fe1   ; donde ha quedado la bandera
	call casilla_a_pixeles		;6fe4   ; pasado a pixeles
	add a,007h		;6fe7
	ld (0cec5h),a		;6fe9
	ld a,c			;6fec
	add a,002h		;6fed
	ld (0cec4h),a		;6fef
	ld hl,(0cec8h)		;6ff2   ; y lo mismo con el tee
	call casilla_a_pixeles		;6ff5
	ld l,a			;6ff8
	ld h,c			;6ff9
	ld (0cecah),hl		;6ffa
	ld a,(0c006h)		;6ffd   ; en el editor la bandera va siempre al sitio 4, el del centro
	and a			;7000
	ld a,004h		;7001
	jr nz,L_700D		;7003
	call L_4CD0		;7005   ; y en partida se sortea entre nueve
	ld b,009h		;7008
	call L_4CEE		;700a
L_700D:
	ld (0cecch),a		;700d   ; dieciocho bytes por par...
	ld e,a			;7010
	ld d,000h		;7011
	ld a,(0c06ch)		;7013   ; ...y el par sale del tee
	sub 003h		;7016
	ld c,a			;7018
	add a,a			;7019
	add a,a			;701a
	add a,a			;701b
	add a,c			;701c
	add a,a			;701d
	add a,e			;701e   ; mas el sitio sorteado
	ld e,a			;701f
	ld hl,070f2h		;7020   ; la tabla de los nueve sitios
	add hl,de			;7023
	ld a,(0cecah)		;7024
	add a,(hl)			;7027   ; la X de la bandera
	ld (0c63fh),a		;7028
	ld a,(0cecbh)		;702b
	ld e,009h		;702e   ; nueve mas alla estan las Y
	add hl,de			;7030
	add a,(hl)			;7031
	ld (0c640h),a		;7032
	ld de,07128h		;7035   ; y la misma cuenta para las coordenadas del green
	ld a,(0cecch)		;7038
	ld l,a			;703b
	ld h,000h		;703c
	add hl,de			;703e
	ld e,(hl)			;703f
	push hl			;7040
	pop ix		;7041
	ld a,(ix+009h)		;7043   ; la fila del green
	ld b,a			;7046
	add a,a			;7047
	add a,a			;7048
	add a,a			;7049
	ld l,a			;704a
	ld h,000h		;704b
	add hl,hl			;704d
	add hl,hl			;704e
	ld d,000h		;704f
	add hl,de			;7051
	ld (0cecdh),hl		;7052   ; la casilla del hoyo dentro del green
	ld a,e			;7055
	add a,a			;7056
	add a,a			;7057
	add a,a			;7058
	add a,003h		;7059
	ld (0c63dh),a		;705b   ; centrada en su casilla
	ld a,b			;705e
	add a,a			;705f
	add a,a			;7060
	add a,a			;7061
	add a,003h		;7062
	ld (0c63eh),a		;7064
	ld a,(0c006h)		;7067   ; en el editor no hay ni viento ni desnivel
	and a			;706a
	ret nz			;706b
	call L_4CD0		;706c   ; el viento se sortea entero
	ld hl,0c625h		;706f
	ld (hl),a			;7072
	ld a,(0c007h)		;7073   ; y en AVERAGE se le quita el bit 6, o sea que sopla menos
	and a			;7076
	jr nz,L_707B		;7077
	res 6,(hl)		;7079
L_707B:
	call L_4CD0		;707b   ; la direccion del desnivel del green
	and 0e0h		;707e
	ld (0c615h),a		;7080
	ld a,(0c007h)		;7083   ; y su fuerza, que crece con el nivel
	inc a			;7086
	ld b,a			;7087
	add a,a			;7088
	add a,b			;7089
	ld b,a			;708a
	push bc			;708b
	call L_4CD0		;708c
	pop bc			;708f
	call L_4CEE		;7090
	add a,004h		;7093   ; con un minimo de cuatro
	ld (0c614h),a		;7095
	ret			;7098
lee_del_guion:		; Un byte del guion; en el editor se lee de la VRAM en vez de la ROM
	ld a,(0c006h)		;7099   ; 0xC006 dice que se esta en el editor
	and a			;709c
	ld a,(hl)			;709d
	ret z			;709e
	jp 0004ah		;709f   ; BIOS RDVRM - Reads the content of VRAM | y alli el guion lo lleva la propia pantalla
lee_tres_del_guion:		; Los tres bytes de cabecera, o los tres digitos de la longitud
	ld b,003h		;70a2
L_70A4:
	call lee_del_guion		;70a4
	ld (de),a			;70a7
	inc hl			;70a8
	inc de			;70a9
	djnz L_70A4		;70aa
	ret			;70ac
busca_bandera_y_tee:		; Recorre el buffer ya montado y apunta donde estan la bandera y el tee
	ld hl,0cb00h		;70ad   ; las 480 casillas del hoyo
	ld bc,001e0h		;70b0
L_70B3:
	ld a,(hl)			;70b3
	cp 0e9h		;70b4   ; 0xE9 es la bandera
	jr nz,L_70BB		;70b6
L_70B8:
	ld (0cec6h),hl		;70b8
L_70BB:
	cp 0d9h		;70bb   ; 0xD9, 0xDD y 0xE3 son los tres tees
	jr z,L_70C7		;70bd
	cp 0ddh		;70bf
	jr z,L_70C7		;70c1
	cp 0e3h		;70c3
	jr nz,L_70CA		;70c5
L_70C7:
	ld (0cec8h),hl		;70c7
L_70CA:
	inc hl			;70ca
	dec bc			;70cb
	ld a,b			;70cc
	or c			;70cd
	jr nz,L_70B3		;70ce
	jp L_6FE1		;70d0
casilla_a_pixeles:		; Pasa una direccion del buffer a coordenadas de pantalla
	ld de,0cb00h		;70d3   ; el buffer empieza en 0xCB00
	and a			;70d6
	sbc hl,de		;70d7
	ld de,00014h		;70d9   ; y la rejilla es de veinte de ancho
	ld c,0ffh		;70dc
L_70DE:
	and a			;70de   ; la division, restando
	sbc hl,de		;70df
	inc c			;70e1
	jr nc,L_70DE		;70e2
	ld a,c			;70e4
	add a,a			;70e5   ; la fila, por ocho
	add a,a			;70e6
	add a,a			;70e7
	ld c,a			;70e8
	ld a,l			;70e9
	add a,014h		;70ea   ; la columna, mas veinte y por ocho
	add a,a			;70ec
	add a,a			;70ed
	add a,a			;70ee
	add a,058h		;70ef   ; y 0x58 de margen por la izquierda, que es donde acaba el panel
	ret			;70f1

; ----------------------------------------------------------------------
; DATOS sitios_de_la_bandera: Nueve posiciones de bandera por cada par (3, 4 y
;   5): primero las nueve X y detras las nueve Y, dieciocho bytes por par
;   0x70f2..0x7128  (54 bytes)
DATA_sitios_de_la_bandera:
	defb 005h,00bh,011h,005h,00bh,011h,005h,00bh,011h	; 70f2  .........
	defb 003h,003h,003h,007h,007h,007h,00bh,00bh,00bh	; 70fb  .........
	defb 006h,00bh,010h,006h,00bh,010h,006h,00bh,010h	; 7104  .........
	defb 004h,004h,004h,007h,007h,007h,00ah,00ah,00ah	; 710d  .........
	defb 006h,00bh,010h,006h,00bh,010h,006h,00bh,010h	; 7116  .........
	defb 004h,004h,004h,007h,007h,007h,00ah,00ah,00ah	; 711f  .........

; ----------------------------------------------------------------------
; DATOS sitios_en_el_green: Los mismos nueve sitios en las coordenadas del
;   green: nueve X y nueve Y
;   0x7128..0x713a  (18 bytes)
DATA_sitios_en_el_green:
	defb 010h,014h,018h,010h,014h,018h,010h,014h,018h	; 7128  .........
	defb 007h,007h,007h,00bh,00bh,00bh,00fh,00fh,00fh	; 7131  .........

; ======================================================================
; CODIGO 0x713a..0x716b  (49 bytes)
; ======================================================================


vuelca_el_green:		; Vuelca el buffer del green a la VRAM
	ld de,0cce0h		;713a
	jr L_7142		;713d
vuelca_el_hoyo:		; Vuelca las 480 casillas del buffer a la VRAM, veinte columnas por veinticuatro filas
	ld de,0cb00h		;713f
L_7142:
	ld hl,0180bh		;7142   ; 0x180B es la columna once: las diez primeras son el panel
	ld c,018h		;7145   ; veinticuatro filas
L_7147:
	ld b,014h		;7147   ; de veinte casillas
L_7149:
	ld a,(de)			;7149
	call 0004dh		;714a   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;714d
	inc hl			;714e
	djnz L_7149		;714f
	push de			;7151
	ld de,0000ch		;7152   ; y doce columnas hasta la fila siguiente
	add hl,de			;7155
	pop de			;7156
	dec c			;7157
	jr nz,L_7147		;7158
	ld a,(0c011h)		;715a   ; en el campo ya esta
	and a			;715d
	ret z			;715e
	ld hl,(0cecdh)		;715f   ; en el green, ademas, se pinta el hoyo
	ld de,01800h		;7162
	add hl,de			;7165
	ld a,0d6h		;7166   ; 0xD6 es su dibujo
	jp 0004dh		;7168   ; BIOS WRTVRM - Writes data in VRAM

; ----------------------------------------------------------------------
; DATOS campo_queen_side: Los dieciocho punteros del campo QUEEN SIDE, par 72
;   y 6.166 metros
;   0x716b..0x718f  (36 bytes)
DATA_campo_queen_side:
	defw 071b3h,072ceh,073d2h,074f9h	; 716b  -> DATA_guiones_de_los_hoyos 0x72ce 0x73d2 0x74f9
	defw 0760eh,07769h,078c2h,079dah	; 7173
	defw 07adbh,07c42h,07d80h,07ebah	; 717b
	defw 07fcah,08117h,08253h,0834fh	; 7183
	defw 0847ah,085cdh	; 718b

; ----------------------------------------------------------------------
; DATOS campo_king_side: Los dieciocho punteros del campo KING SIDE, par 72 y
;   6.290 metros
;   0x718f..0x71b3  (36 bytes)
DATA_campo_king_side:
	defw 08711h,0886eh,0898dh,08b0fh	; 718f
	defw 08c74h,08da6h,08e81h,08fe2h	; 7197
	defw 0911ch,0927eh,093ech,09505h	; 719f
	defw 09635h,09773h,098a5h,099c2h	; 71a7
	defw 09afdh,09c1fh	; 71af

; ----------------------------------------------------------------------
; DATOS guiones_de_los_hoyos: Los treinta y seis guiones, uno detras de otro y
;   sin un byte suelto: 0x71B3 es el hoyo 1 de QUEEN SIDE y 0x9C1F el 18 de
;   KING SIDE
;   0x71b3..0x9d6c  (11193 bytes)
DATA_guiones_de_los_hoyos:
	defb 094h,079h,078h,039h,0a1h,045h,0c0h,0d1h,040h,039h,0b3h,040h,066h,040h,066h,0ddh	; 71b3  .yx9.E..@9.@f@f.
	defb 0deh,0dfh,0cbh,098h,039h,09bh,068h,067h,068h,067h,0e0h,0e1h,0e2h,098h,030h,034h	; 71c3  ....9.hghg....04
	defb 095h,031h,0abh,0a7h,066h,069h,066h,069h,0a8h,0a9h,0ach,0a8h,031h,031h,095h,033h	; 71d3  .1..fifi....11.3
	defb 09bh,066h,040h,067h,040h,067h,040h,0aah,034h,035h,09bh,066h,067h,066h,068h,06ah	; 71e3  .f@g@g@.45.fgfhj
	defb 07eh,050h,07bh,0a2h,030h,00eh,031h,033h,095h,0a3h,040h,067h,068h,067h,069h,06bh	; 71f3  ~P{.0.13..@ghgik
	defb 082h,050h,093h,0aeh,030h,00fh,095h,030h,034h,09fh,066h,06ah,069h,0b7h,0b8h,066h	; 7203  .P..0..04.fji..f
	defb 051h,085h,0a0h,033h,031h,095h,030h,09bh,06ah,067h,069h,0b7h,0b5h,0bch,061h,051h	; 7213  Q..31.0.jgi...aQ
	defb 081h,0b2h,095h,032h,032h,09bh,068h,06bh,068h,0b7h,0b5h,0beh,0bah,060h,050h,07dh	; 7223  ...22.hkh....`P}
	defb 098h,034h,095h,030h,09bh,040h,069h,068h,069h,0b9h,0bah,086h,08ah,061h,085h,098h	; 7233  .4.0.@ihi....a..
	defb 035h,030h,09bh,041h,066h,069h,066h,040h,07ah,051h,07dh,09ch,030h,095h,032h,0b1h	; 7243  50.Afif@zQ}.0.2.
	defb 0abh,09bh,042h,067h,066h,067h,07ah,051h,07dh,098h,034h,09bh,06ch,06eh,042h,06ah	; 7253  ..BgfgzQ}.4.lnBj
	defb 040h,067h,07ah,051h,085h,09ch,031h,00eh,031h,0b3h,040h,06dh,06fh,042h,06bh,040h	; 7263  @gzQ..1.1.@moBk@
	defb 07eh,051h,085h,068h,0a0h,031h,00fh,032h,0a9h,0a5h,040h,044h,082h,051h,081h,069h	; 7273  ~Q.h.1.2..@D.Q.i
	defb 0b2h,037h,0b0h,044h,092h,050h,085h,040h,068h,09ah,038h,044h,07ch,050h,081h,040h	; 7283  .7.D.P.@h.8D|P.@
	defb 069h,066h,0a6h,0aah,032h,00eh,00eh,031h,049h,067h,041h,0a6h,0aah,030h,00fh,00fh	; 7293  if..2..1IgA..0..
	defb 031h,04ch,06ch,06eh,041h,06ch,06eh,040h,041h,0eeh,0e9h,0eah,0f6h,046h,06dh,06fh	; 72a3  1LlnAln@A....Fmo
	defb 0f8h,0f9h,06dh,06fh,040h,041h,0efh,0ebh,0ebh,0f7h,040h,00dh,047h,0f8h,0f9h,041h	; 72b3  ..mo@A....@.G..A
	defb 047h,00dh,044h,00dh,044h,04fh,043h,021h,033h,035h,032h,094h,0b5h,079h,099h,050h	; 72c3  G.D.DOC!352..y.P
	defb 0b9h,0beh,043h,0beh,0beh,0bah,068h,0b9h,0beh,0beh,0beh,043h,0b3h,0e3h,0e4h,0e5h	; 72d3  ..C...h....C....
	defb 0b9h,041h,0bah,086h,08eh,08eh,063h,087h,052h,0b9h,042h,0b3h,0e6h,0e7h,0e8h,066h	; 72e3  .A....c.R.B....f
	defb 0bbh,0bch,050h,092h,078h,078h,078h,07dh,0b7h,0bdh,0b8h,068h,0b9h,041h,030h,0a9h	; 72f3  ..P.xxx}...h.A0.
	defb 0ach,0a5h,067h,0bbh,040h,0b8h,088h,08fh,08fh,089h,0b7h,041h,0bch,069h,068h,0b9h	; 7303  ..g.@......A.ih.
	defb 040h,033h,099h,0b9h,0beh,0beh,0bdh,0bdh,0bfh,0bfh,076h,074h,040h,0bah,066h,069h	; 7313  @3........vt@.fi
	defb 066h,0b9h,034h,0a9h,0ach,0a5h,0ceh,042h,077h,075h,0bch,07eh,061h,050h,067h,050h	; 7323  f.4....Bwu.~aPgP
	defb 037h,09dh,0bbh,043h,0bch,07ch,078h,07bh,050h,066h,031h,00eh,034h,0a1h,0b9h,040h	; 7333  7..C.|x{Pf1.4..@
	defb 073h,042h,0d1h,092h,078h,07fh,067h,031h,00fh,034h,095h,09dh,0bbh,042h,070h,0bch	; 7343  sB..x.g1.4...Bp.
	defb 092h,060h,091h,068h,038h,0a1h,0ceh,042h,071h,0bch,084h,061h,091h,069h,036h,00eh	; 7353  .`.h8..Bq..a.i6.
	defb 031h,09dh,0b9h,042h,0bch,082h,078h,091h,050h,035h,095h,00fh,031h,0a1h,050h,0ceh	; 7363  1..B..x.P5..1.P.
	defb 041h,0bch,084h,078h,091h,06ah,039h,095h,099h,050h,0b9h,0beh,0bah,07ch,078h,081h	; 7373  A..x.j9..P...|x.
	defb 06bh,03bh,0a9h,0a5h,051h,06ch,06eh,051h,034h,095h,037h,0a9h,0a5h,06dh,06fh,050h	; 7383  k;..QlnQ4.7..moP
	defb 098h,03fh,0a9h,0ach,0a8h,030h,03dh,095h,034h,037h,00eh,038h,095h,030h,030h,00eh	; 7393  .?...0=.47.8.00.
	defb 035h,00fh,03ah,030h,00fh,03ah,0b1h,0b1h,0b1h,095h,032h,03ah,0abh,0a7h,052h,0a6h	; 73a3  5.:0.:....2:..R.
	defb 0aah,031h,036h,095h,031h,0a3h,06ch,0eeh,0e9h,0eah,0f2h,066h,050h,0a6h,0aah,039h	; 73b3  .16.1.l....fP..9
	defb 09fh,06dh,0efh,0ebh,0ebh,0f3h,067h,052h,039h,09dh,058h,021h,034h,037h,032h,0b5h	; 73c3  .m....gR9.X!472.
	defb 079h,094h,052h,09bh,068h,066h,040h,068h,066h,043h,0a2h,055h,051h,09bh,040h,069h	; 73d3  y.R.hf@hfC.UQ.@i
	defb 067h,040h,069h,067h,068h,066h,068h,06ah,09eh,055h,050h,0a3h,0ddh,0deh,0dfh,0a4h	; 73e3  g@ighfhj.UP.....
	defb 0a8h,0a9h,040h,069h,067h,069h,067h,066h,0a2h,095h,053h,050h,0a1h,0e0h,0e1h,0e2h	; 73f3  ..@igigf..SP....
	defb 0a0h,050h,0b3h,040h,08ah,078h,08bh,087h,067h,09eh,051h,095h,051h,050h,095h,0a9h	; 7403  .P.@.x..g.Q.QP..
	defb 0ach,0a8h,051h,09bh,040h,08ch,060h,078h,078h,07bh,066h,09ah,053h,055h,09bh,042h	; 7413  ..Q.@.`xx{f.SU.B
	defb 069h,07ch,078h,078h,067h,066h,09ah,052h,053h,0abh,0a7h,041h,0b7h,0bdh,0bdh,0b8h	; 7423  i|xxgf.RS..A....
	defb 092h,078h,083h,067h,066h,0a6h,0aah,050h,051h,0abh,0a7h,042h,0b7h,032h,0bch,060h	; 7433  .x.gf..PQ..B.2.`
	defb 078h,093h,068h,067h,041h,09ah,050h,09bh,043h,0b7h,030h,074h,031h,0bah,061h,078h	; 7443  x.hgA.P.C.0t1.ax
	defb 093h,069h,068h,042h,09bh,043h,0b7h,031h,075h,030h,0bah,07ah,078h,062h,093h,066h	; 7453  .ihB.C.1u0.zxb.f
	defb 069h,06ah,041h,044h,0bbh,032h,0bah,066h,092h,078h,063h,085h,067h,066h,06bh,041h	; 7463  ijAD.2.f.xc.gfkA
	defb 043h,0b7h,032h,0bch,040h,067h,092h,078h,078h,081h,068h,067h,042h,042h,0b7h,033h	; 7473  C.2.@g.xx.hgBB.3
	defb 0bch,041h,07ch,078h,07dh,066h,069h,068h,042h,041h,0b7h,035h,0bfh,0d1h,042h,067h	; 7483  .A|x}fihBA.5..Bg
	defb 040h,069h,042h,041h,0bbh,031h,076h,074h,033h,0bfh,0bdh,0b8h,045h,040h,0b7h,032h	; 7493  @iBA.1vt3...E@.2
	defb 077h,075h,036h,0b8h,044h,040h,0bbh,037h,073h,032h,0b4h,0bdh,0d1h,042h,040h,0b9h	; 74a3  wu6.D@.7s2...B@.
	defb 03eh,0b8h,041h,041h,0bbh,036h,0beh,0beh,0beh,034h,0bfh,0d1h,040h,0b7h,0b4h,034h	; 74b3  >.AA.6...4..@..4
	defb 0b4h,0bah,042h,0b9h,035h,040h,0bbh,031h,070h,032h,0bah,0eeh,0e9h,0eah,0f2h,040h	; 74c3  ..B.5@.1p2.....@
	defb 0bbh,031h,072h,031h,040h,0bbh,031h,071h,031h,0bch,040h,0efh,0ebh,0ebh,0f3h,040h	; 74d3  .1r1@.1q1.@....@
	defb 0bbh,034h,040h,0b9h,0b4h,034h,0b8h,043h,0b7h,035h,041h,0bbh,035h,0bdh,0b8h,040h	; 74e3  .4@..4.C.5A.5..@
	defb 0b7h,036h,021h,033h,037h,036h,094h,079h,06bh,03dh,0a1h,044h,032h,097h,031h,0abh	; 74f3  .6!376.yk=.D2.1.
	defb 0adh,036h,0a9h,0a5h,042h,033h,096h,030h,09dh,06ah,0a2h,034h,00eh,031h,099h,041h	; 7503  .6..B3.0.j.4.1.A
	defb 035h,0a1h,050h,09eh,034h,00fh,032h,0a9h,0a5h,035h,0b3h,06ah,06ah,09ah,039h,035h	; 7513  5.P.4.2..5.jj.95
	defb 0b3h,051h,06ah,09ah,034h,0a3h,0a2h,031h,030h,00eh,032h,095h,0a3h,06ah,040h,050h	; 7523  .Qj.4..10.2..j@P
	defb 040h,0a6h,0aah,032h,09fh,09ch,031h,030h,00fh,095h,032h,0afh,050h,0b7h,0bdh,0b8h	; 7533  @..2..10..2.P...
	defb 040h,06ah,0a6h,0aah,0abh,040h,0a0h,0abh,0adh,035h,09fh,0d0h,0b5h,072h,0b4h,0b8h	; 7543  @j...@...5...r..
	defb 050h,06ah,06ah,040h,0a0h,0abh,0a4h,0a8h,034h,09bh,06ah,0ceh,0beh,0beh,0b4h,0b5h	; 7553  Pjj@....4.j.....
	defb 0b8h,051h,06ah,09ah,0a9h,031h,033h,0b3h,06ah,050h,066h,0d9h,0d8h,0dah,0b9h,0bch	; 7563  .Qj..13.jPf.....
	defb 06ah,06ah,050h,040h,0aah,030h,097h,031h,0abh,0aah,0abh,050h,040h,067h,0dbh,0d7h	; 7573  jjP@.0.1...P@g..
	defb 0dch,0b7h,0bah,051h,040h,0a8h,0b0h,031h,031h,099h,040h,06ah,040h,06ah,06ah,0c2h	; 7583  ...Q@..11.@j@jj.
	defb 0bdh,0bfh,0bah,040h,0a4h,0ach,0a8h,033h,030h,095h,09bh,040h,050h,06ah,051h,068h	; 7593  ...@...30..@PjQh
	defb 066h,041h,098h,036h,030h,0a3h,06ah,098h,09dh,050h,0a8h,0a5h,069h,067h,06ah,09ch	; 75a3  fA.60.j..P..igj.
	defb 033h,095h,032h,030h,0afh,050h,0a2h,0a1h,098h,031h,0a9h,0a5h,050h,0aeh,095h,036h	; 75b3  3.20.P...1..P..6
	defb 030h,0afh,06ah,09ah,035h,099h,0a0h,032h,00eh,033h,030h,0afh,050h,040h,09ah,038h	; 75c3  0.j.5..2.30.P@.8
	defb 095h,00fh,033h,030h,09fh,098h,099h,098h,033h,0b1h,039h,030h,0ach,034h,0abh,0a7h	; 75d3  ..30....3.90.4..
	defb 040h,0a6h,0aah,037h,035h,09bh,044h,0a2h,030h,00eh,034h,034h,09bh,040h,06ah,0ech	; 75e3  @..75.D.0.44.@j.
	defb 0e9h,0eah,0f2h,09eh,030h,00fh,034h,033h,0a3h,041h,050h,0edh,0ebh,0ebh,0f3h,040h	; 75f3  ....0.43.AP....@
	defb 0b2h,035h,033h,09fh,047h,0b2h,035h,021h,031h,036h,037h,094h,079h,078h,042h,0a0h	; 7603  .53.G.5!167.yxB.
	defb 033h,0a9h,0a5h,042h,066h,041h,068h,042h,041h,098h,036h,0a9h,0a5h,040h,067h,0d0h	; 7613  3..BfAhBA.6..@g.
	defb 0c1h,06bh,0cch,0d1h,066h,040h,098h,039h,0a9h,0a5h,0cah,0ddh,0deh,0dfh,0cbh,067h	; 7623  .k..f@.9.......g
	defb 09ch,095h,032h,0abh,0adh,0aah,035h,099h,0e0h,0e1h,0e2h,066h,06ah,0a0h,032h,0a3h	; 7633  ..2...5....fj.2.
	defb 042h,0a6h,0aah,0b1h,031h,095h,030h,0a9h,0a5h,040h,067h,06bh,0a2h,032h,09fh,041h	; 7643  B...1.0..@gk.2.A
	defb 066h,068h,066h,040h,09ah,034h,099h,040h,068h,09eh,031h,0a3h,041h,068h,067h,069h	; 7653  fhf@.4.@h.1.Ahgi
	defb 067h,040h,066h,09ah,034h,09dh,069h,040h,0b2h,030h,0afh,041h,069h,040h,0b7h,0bdh	; 7663  g@f.4.i@.0.Ai@..
	defb 0b8h,067h,040h,09ah,033h,0a1h,040h,040h,0b2h,030h,0a1h,040h,07ah,050h,07fh,0bbh	; 7673  .g@.3.@@.0.@zP..
	defb 0b5h,0bch,082h,083h,066h,09ah,095h,032h,09dh,040h,0a2h,030h,0a3h,040h,092h,050h	; 7683  ....f..2.@.0.@.P
	defb 083h,0b9h,0b5h,0bch,092h,093h,067h,068h,0a2h,032h,0afh,040h,0a0h,095h,0a1h,040h	; 7693  ......gh.2.@...@
	defb 092h,050h,060h,07bh,0b9h,0bah,092h,093h,066h,069h,0aeh,032h,0afh,09ch,031h,0b3h	; 76a3  .P`{....fi.2..1.
	defb 040h,084h,050h,061h,050h,08bh,08ah,060h,093h,069h,066h,09eh,032h,0afh,0aeh,032h	; 76b3  @.PaP..`.if.2..2
	defb 09dh,080h,054h,061h,093h,0c7h,067h,066h,0b2h,031h,0afh,09eh,095h,031h,0a1h,040h	; 76c3  ..Ta..gf.1...1.@
	defb 07ch,054h,07dh,0cbh,066h,067h,0b2h,031h,0afh,040h,0a2h,032h,09dh,040h,088h,08ch	; 76d3  |T}.fg.1.@.2.@..
	defb 060h,08dh,089h,066h,040h,067h,040h,0b2h,031h,09fh,066h,09eh,095h,031h,0a1h,041h	; 76e3  `..f@g@.1.f..1.A
	defb 068h,067h,066h,068h,067h,068h,040h,09ch,095h,030h,0b3h,040h,067h,066h,0b2h,032h	; 76f3  hgfhgh@..0.@gf.2
	defb 09dh,040h,069h,068h,067h,069h,066h,069h,040h,0a0h,031h,0a3h,040h,068h,067h,0a2h	; 7703  .@ihgifi@.1.@hg.
	defb 032h,0a1h,041h,069h,06ah,068h,067h,040h,098h,031h,095h,09fh,066h,069h,068h,09eh	; 7713  2.Aijhg@.1..fih.
	defb 095h,032h,0a9h,0a5h,040h,06bh,069h,0a4h,0a8h,032h,09bh,040h,067h,040h,069h,068h	; 7723  .2..@ki..2.@g@ih
	defb 0a2h,034h,0a9h,0ach,0a8h,032h,0abh,0a7h,042h,066h,06ah,069h,0a0h,039h,09bh,0f0h	; 7733  .4...2..Bfji.9..
	defb 0e9h,0eah,0f4h,040h,067h,06bh,098h,031h,00eh,036h,0a3h,040h,0f1h,0ebh,0ebh,0f5h	; 7743  ...@gk.1.6.@....
	defb 040h,0a4h,0a8h,031h,095h,00fh,032h,00eh,032h,0afh,066h,044h,038h,00fh,032h,0a1h	; 7753  @..1..2.2.fD8.2.
	defb 067h,044h,021h,033h,031h,035h,079h,094h,078h,035h,0a4h,0ach,0ach,0ach,0ach,0ach	; 7763  gD!315y.x5......
	defb 0ach,0ach,0a5h,034h,033h,0a4h,0a8h,048h,099h,033h,030h,068h,030h,09ch,041h,0abh	; 7773  ...43..H.30h0.A.
	defb 0adh,0adh,0aah,095h,0abh,0adh,0adh,0aah,040h,099h,032h,030h,069h,06ah,0aeh,040h	; 7783  ........@.20ij.@
	defb 09bh,038h,09ah,040h,09dh,031h,0b8h,030h,06bh,0aeh,040h,0afh,030h,0ddh,0deh,0dfh	; 7793  .8.@.1.0k.@.0...
	defb 031h,07ah,050h,07bh,0aeh,040h,0afh,031h,0bch,031h,0aeh,040h,0afh,030h,0e0h,0e1h	; 77a3  1zP{.@.1.1.@.0..
	defb 0e2h,031h,07ch,050h,07dh,0aeh,040h,0afh,031h,0bah,031h,09eh,0aah,09fh,032h,0d0h	; 77b3  .1|P}.@.1.1...2.
	defb 0bfh,0d1h,032h,09eh,0b1h,0afh,031h,09ch,0ach,0ach,09dh,031h,0d0h,0bfh,0bfh,0b4h	; 77c3  ..2...1....1....
	defb 0b4h,0b4h,0bfh,0bfh,0d1h,031h,0a4h,0ach,09dh,0aeh,042h,0a9h,0a5h,0ceh,0beh,0b4h	; 77d3  .....1....B.....
	defb 0b4h,0b4h,0b4h,0b4h,0beh,0bah,0a4h,0a8h,041h,0afh,003h,09ah,043h,099h,030h,0ceh	; 77e3  ........A...C.0.
	defb 0beh,0beh,0beh,0bah,030h,098h,043h,09bh,000h,003h,09ah,042h,0b3h,030h,066h,08eh	; 77f3  ....0.C....B.0f.
	defb 066h,08eh,066h,030h,0b2h,042h,09bh,004h,000h,000h,003h,0a2h,041h,0b3h,07eh,061h	; 7803  f.f0.B......A.~a
	defb 060h,063h,060h,061h,07fh,0b2h,041h,0a3h,004h,000h,002h,000h,005h,09eh,041h,0a3h	; 7813  `c`a..A.......A.
	defb 082h,050h,061h,050h,061h,050h,083h,0a2h,041h,09fh,006h,000h,030h,006h,005h,09ch	; 7823  .PaPaP..A...0...
	defb 041h,09fh,056h,09eh,041h,09dh,006h,000h,09dh,002h,008h,0a0h,040h,0a3h,07ah,053h	; 7833  A.V.A.......@.zS
	defb 060h,051h,07bh,0a2h,040h,0a3h,006h,000h,0a1h,031h,0a0h,040h,09fh,051h,062h,051h	; 7843  `Q{.@....1.@.QbQ
	defb 061h,051h,062h,09eh,040h,0a3h,006h,000h,095h,09dh,030h,0a0h,0a3h,07ah,051h,063h	; 7853  aQb.@.....0..zQc
	defb 054h,063h,07bh,0a2h,0a3h,006h,000h,040h,0afh,030h,09eh,09fh,084h,055h,060h,051h	; 7863  Tc{....@.0...U`Q
	defb 093h,09eh,09fh,00ch,00ah,095h,0a1h,032h,07ch,055h,061h,051h,07dh,033h,040h,095h	; 7873  .......2|UaQ}3@.
	defb 099h,032h,0c8h,0c8h,0c8h,032h,0c8h,0c8h,0c8h,034h,09ah,041h,099h,030h,06ah,0b6h	; 7883  .2...2...4.A.0j.
	defb 0b6h,0b6h,032h,0b6h,0b6h,0b6h,034h,030h,09ah,095h,040h,0a9h,069h,033h,00dh,030h	; 7893  ..2...40..@.i3.0
	defb 0ech,0e9h,0eah,0f2h,033h,030h,068h,09ah,041h,0a9h,0a5h,031h,00dh,031h,0edh,0ebh	; 78a3  ....30h.A..1.1..
	defb 0ebh,0f3h,033h,030h,069h,030h,0a2h,041h,095h,099h,03bh,021h,032h,037h,038h,079h	; 78b3  ..30i0.A..;!278y
	defb 000h,078h,049h,005h,030h,0d0h,0c1h,030h,0cch,0d1h,032h,049h,001h,030h,0cah,0e3h	; 78c3  .xI.0..0..2I.0..
	defb 0e4h,0e5h,0cbh,032h,047h,009h,00bh,066h,068h,066h,0e6h,0e7h,0e8h,066h,066h,031h	; 78d3  ...2G..fhf...ff1
	defb 043h,008h,008h,009h,00bh,0d0h,0c1h,067h,069h,067h,0c0h,0c1h,066h,067h,067h,004h	; 78e3  C......gig..fgg.
	defb 007h,042h,001h,066h,068h,068h,0cch,0cdh,08ah,051h,08bh,066h,068h,067h,030h,004h	; 78f3  .B.fhh...Q.fhg0.
	defb 041h,041h,001h,068h,067h,069h,069h,086h,08ah,060h,060h,062h,060h,067h,069h,004h	; 7903  AA.hgii..``b`gi.
	defb 007h,042h,040h,005h,066h,069h,086h,08ah,051h,08dh,067h,069h,069h,069h,030h,004h	; 7913  .B@.fi..Q.giii0.
	defb 044h,040h,001h,067h,082h,052h,07dh,004h,007h,007h,007h,007h,007h,045h,005h,068h	; 7923  D@.g.R}......E.h
	defb 082h,052h,07dh,004h,044h,008h,045h,005h,069h,092h,051h,07dh,004h,043h,008h,001h	; 7933  .R}.D.E.i.Q}.C..
	defb 066h,002h,044h,001h,066h,092h,050h,093h,066h,006h,042h,005h,030h,066h,067h,030h	; 7943  f.D.f.P.f.B.0fg0
	defb 006h,043h,066h,067h,051h,093h,067h,002h,043h,003h,067h,004h,007h,044h,067h,030h	; 7953  .CfgQ.g.C.g..Dg0
	defb 092h,050h,093h,066h,068h,002h,043h,007h,043h,008h,008h,001h,030h,0c6h,084h,051h	; 7963  .P.fh.C.C...0..Q
	defb 063h,067h,066h,006h,046h,001h,066h,031h,030h,0ceh,0d1h,052h,07bh,067h,002h,045h	; 7973  cgf.F.f10..R{g.E
	defb 001h,068h,067h,031h,030h,066h,0ceh,0cch,0cfh,051h,07bh,030h,002h,008h,008h,008h	; 7983  .hg10f...Q{0....
	defb 008h,001h,030h,069h,032h,030h,067h,068h,066h,07ch,052h,07fh,030h,066h,033h,0f8h	; 7993  ..0i20ghf|R.0f3.
	defb 0f9h,032h,031h,069h,067h,066h,088h,08ch,08dh,081h,030h,067h,068h,030h,0f8h,0f9h	; 79a3  .21igf....0gh0..
	defb 034h,032h,06ah,067h,068h,034h,069h,031h,00dh,034h,032h,06bh,068h,069h,066h,03ch	; 79b3  42jgh4i1.42khif<
	defb 033h,069h,030h,069h,03ch,03ch,0f0h,0e9h,0eah,0f4h,032h,03ch,0f1h,0ebh,0ebh,0f5h	; 79c3  3i0i<<....2<....
	defb 032h,03fh,033h,021h,034h,036h,039h,079h,000h,094h,0b9h,0beh,0beh,0b5h,0b5h,0b5h	; 79d3  2?3!469y........
	defb 0b5h,0b5h,0bah,03ah,032h,0b9h,0beh,0beh,0beh,0bah,030h,004h,007h,007h,007h,007h	; 79e3  ...:2.....0.....
	defb 007h,003h,033h,0b0h,0a9h,0a5h,034h,004h,046h,007h,007h,007h,003h,051h,095h,0a9h	; 79f3  ..3...4.F....Q..
	defb 0a5h,032h,002h,008h,008h,008h,047h,054h,0a9h,0a5h,031h,068h,06ah,068h,002h,008h	; 7a03  .2....GT..1hjh..
	defb 045h,056h,09dh,066h,069h,06bh,069h,0c0h,0d1h,002h,044h,056h,0a1h,067h,0c6h,0d9h	; 7a13  EV.fiki...DV.g..
	defb 0d8h,0dah,0b6h,066h,006h,043h,055h,095h,0b3h,068h,0cah,0dbh,0d7h,0dch,066h,067h	; 7a23  ...f.CU..h....fg
	defb 006h,043h,052h,00eh,052h,0a3h,069h,066h,030h,0c0h,0c1h,069h,004h,044h,051h,095h	; 7a33  .CR.R.if0..i.DQ.
	defb 00fh,052h,09fh,066h,067h,030h,004h,007h,007h,045h,054h,095h,09bh,06ah,067h,068h	; 7a43  .R.fg0...ET..jgh
	defb 066h,006h,047h,054h,09bh,066h,06bh,068h,069h,069h,002h,047h,052h,0abh,0a7h,068h	; 7a53  f.GT.fkhii.GR..h
	defb 067h,066h,069h,066h,031h,00ch,00ah,008h,008h,043h,051h,09bh,030h,068h,069h,030h	; 7a63  gfif1....CQ.0hi0
	defb 067h,068h,067h,098h,0b0h,0a9h,0a5h,031h,00ch,00ah,008h,008h,0abh,0a7h,031h,069h	; 7a73  ghg....1......1i
	defb 066h,030h,06ah,069h,098h,095h,052h,0b0h,0b0h,0a9h,0a5h,031h,034h,067h,030h,06bh	; 7a83  f0ji..R....14g0k
	defb 030h,0b2h,057h,099h,030h,033h,068h,030h,066h,031h,0a6h,0aah,056h,0b3h,030h,033h	; 7a93  0.W.03h0f1..V.03
	defb 069h,030h,067h,033h,09ah,054h,0abh,0a7h,030h,032h,0eeh,0e9h,0eah,0f6h,00dh,032h	; 7aa3  i0g3.T..02.....2
	defb 068h,0a6h,0aah,0b1h,0b1h,09bh,032h,032h,0efh,0ebh,0ebh,0f7h,031h,00dh,030h,069h	; 7ab3  h.....22....1.0i
	defb 037h,003h,03fh,032h,040h,007h,007h,007h,003h,03eh,044h,007h,007h,007h,007h,003h	; 7ac3  7.?2@....>D.....
	defb 039h,049h,003h,038h,021h,032h,030h,038h,079h,094h,0b5h,043h,0abh,0adh,0adh,0aah	; 7ad3  9I.8!208y..C....
	defb 04bh,042h,09bh,068h,066h,031h,0a6h,0aah,042h,00eh,045h,040h,095h,09bh,030h,069h	; 7ae3  KB.hf1..B.E@..0i
	defb 067h,031h,0f8h,0f9h,09ah,095h,040h,00fh,045h,040h,0a3h,030h,0c2h,0c3h,031h,068h	; 7af3  g1....@.E@.0..1h
	defb 030h,0f8h,0f9h,09ah,045h,00eh,040h,040h,0afh,0c6h,0ddh,0deh,0dfh,0c7h,069h,066h	; 7b03  0...E.@@......if
	defb 06ah,031h,09ah,095h,042h,095h,00fh,040h,040h,0a1h,0cah,0e0h,0e1h,0e2h,0cbh,066h	; 7b13  j1..B..@@......f
	defb 067h,06bh,032h,0a6h,0aah,0b1h,043h,041h,099h,0c2h,0bdh,0c3h,06ah,067h,068h,032h	; 7b23  gk2...CA....jgh2
	defb 086h,087h,030h,068h,0a6h,0aah,0b1h,0b1h,042h,0a9h,0a5h,030h,06bh,030h,069h,031h	; 7b33  ..0h....B..0k0i1
	defb 07ah,078h,078h,07bh,069h,030h,068h,031h,0adh,0aah,0b1h,0b1h,040h,0b0h,0b0h,0a9h	; 7b43  zxx{i0h1....@...
	defb 0a5h,031h,07ch,078h,078h,07dh,06ah,068h,069h,066h,030h,030h,06ah,068h,030h,0a6h	; 7b53  .1|xx}jhif00jh0.
	defb 0aah,0b1h,0b1h,041h,0a9h,0a5h,088h,089h,066h,06bh,069h,06ah,067h,030h,066h,06bh	; 7b63  ...A....fkijg0fk
	defb 069h,086h,08eh,087h,066h,066h,0a6h,0aah,0b1h,040h,0a9h,0a5h,067h,030h,066h,06bh	; 7b73  i...ff...@..g0fk
	defb 068h,030h,067h,066h,030h,092h,062h,078h,067h,067h,068h,030h,06ah,0a6h,0aah,040h	; 7b83  h0gf0.bxggh0j..@
	defb 0b0h,0a5h,067h,030h,069h,030h,06ah,067h,066h,084h,063h,060h,07fh,0c8h,069h,066h	; 7b93  ..g0i0jgf.c`..if
	defb 06bh,068h,066h,0a6h,0aah,040h,0a5h,032h,06bh,068h,067h,0c6h,084h,061h,083h,0ceh	; 7ba3  khf..@.2khg..a..
	defb 0d1h,067h,066h,069h,067h,06ah,066h,0a6h,040h,0a9h,031h,068h,069h,068h,0ceh,0d1h	; 7bb3  .gfigjf.@.1hih..
	defb 078h,078h,07bh,0cah,066h,067h,06ah,068h,06bh,067h,068h,0a6h,040h,0a9h,0a5h,069h	; 7bc3  xx{.fgjhkgh.@..i
	defb 066h,069h,066h,0ceh,0cfh,078h,078h,08bh,067h,06ah,06bh,069h,066h,06ah,069h,030h	; 7bd3  fif..xx.gjkifji0
	defb 0a6h,0aah,040h,030h,067h,030h,067h,066h,030h,07ch,078h,078h,093h,06bh,066h,06ah	; 7be3  ..@0g0gf0|xx.kfj
	defb 067h,06bh,066h,032h,0a6h,0bfh,0bdh,0b8h,030h,067h,068h,066h,07ch,08ch,07dh,030h	; 7bf3  gkf2....0ghf|.}0
	defb 067h,06bh,031h,067h,033h,051h,0b4h,0bdh,0d1h,069h,067h,06ah,068h,03ah,050h,076h	; 7c03  gk1g3Q...igjh:Pv
	defb 074h,051h,0bfh,0d1h,06bh,069h,066h,036h,0f8h,0f9h,030h,050h,077h,075h,053h,0bfh	; 7c13  tQ..kif6..0PwuS.
	defb 0b8h,067h,036h,00dh,031h,058h,0b8h,033h,0f0h,0e9h,0eah,0f4h,00dh,030h,055h,072h	; 7c23  .g6.1X.3.....0Ur
	defb 051h,0bch,033h,0f1h,0ebh,0ebh,0f5h,031h,058h,0bah,039h,021h,033h,034h,032h,094h	; 7c33  Q.3....1X.9!342.
	defb 079h,0b0h,03fh,033h,031h,0abh,0adh,0aah,030h,0abh,0adh,0aah,030h,0abh,0aah,037h	; 7c43  y.?31...0...0..7
	defb 030h,0a3h,0ddh,0deh,0dfh,0a2h,09dh,0c8h,09ch,0a3h,0c9h,09ch,030h,0adh,035h,030h	; 7c53  0...........0.50
	defb 0a1h,0e0h,0e1h,0e2h,0a0h,0afh,0cbh,0a0h,0afh,0cah,0a0h,0a3h,0c7h,0a2h,030h,0b1h	; 7c63  ..............0.
	defb 032h,031h,099h,040h,066h,09ah,09fh,040h,09ah,09fh,068h,09ah,09fh,0cbh,0a0h,0a3h	; 7c73  21.@f..@..h.....
	defb 0c8h,0a2h,031h,032h,09dh,067h,07ah,078h,060h,08bh,087h,069h,042h,09ah,09fh,0cah	; 7c83  ..12.gzx`..iB...
	defb 0aeh,031h,030h,095h,030h,0afh,068h,08ch,060h,061h,060h,078h,087h,0cch,0bdh,0bfh	; 7c93  .10.0.h.`a`x....
	defb 0d1h,041h,0a0h,031h,032h,0a1h,069h,066h,067h,068h,067h,060h,078h,07bh,0b9h,0b5h	; 7ca3  .A.12.ifghg`x{..
	defb 0b5h,0d1h,06eh,0b2h,031h,033h,099h,067h,066h,069h,066h,067h,078h,060h,07bh,0b9h	; 7cb3  ..n.13.gfifgx`{.
	defb 0b5h,0bch,06fh,0b2h,031h,034h,09dh,067h,068h,067h,068h,07ch,061h,078h,07fh,0bbh	; 7cc3  ..o.14.ghgh|ax..
	defb 0bch,09ch,032h,032h,095h,030h,0a1h,068h,069h,066h,069h,066h,084h,078h,083h,0b9h	; 7cd3  ..22.0.hifif.x..
	defb 0bah,0a0h,030h,095h,030h,034h,0b3h,069h,066h,067h,068h,067h,090h,078h,062h,040h	; 7ce3  ..0.04.ifghg.xb@
	defb 09ch,030h,095h,031h,034h,0a3h,066h,067h,068h,069h,068h,090h,078h,063h,06eh,0a0h	; 7cf3  .0.14.fghih.xcn.
	defb 033h,030h,00eh,032h,0afh,067h,06ah,069h,066h,069h,082h,078h,085h,06fh,0b2h,033h	; 7d03  30.2.gjifi.x.o.3
	defb 095h,00fh,032h,09fh,068h,06bh,068h,067h,07eh,078h,085h,06eh,09ch,034h,033h,0b3h	; 7d13  ..2.hkhg~x.n.43.
	defb 066h,069h,068h,069h,040h,082h,078h,081h,06fh,0a0h,095h,033h,032h,095h,0a3h,067h	; 7d23  fihi@.x.o..32..g
	defb 066h,069h,040h,07ah,078h,085h,06eh,09ch,035h,033h,09fh,040h,067h,040h,080h,078h	; 7d33  fi@zx.n.53.@g@.x
	defb 08dh,081h,06fh,0a0h,035h,032h,0a3h,045h,06ch,06eh,09ch,032h,00eh,032h,032h,0afh	; 7d43  ..o.52.Eln.2.22.
	defb 040h,0eeh,0e9h,0eah,0f6h,040h,06dh,06fh,0a0h,032h,00fh,095h,031h,032h,0a1h,040h	; 7d53  @....@mo.2..12.@
	defb 0efh,0ebh,0ebh,0f7h,041h,098h,097h,036h,032h,095h,0a9h,0a5h,042h,0a4h,0a8h,038h	; 7d63  ....A..62...B..8
	defb 030h,097h,033h,052h,034h,095h,034h,03fh,033h,021h,033h,033h,035h,094h,079h,000h	; 7d73  0.3R4.4?3!335.y.
	defb 068h,041h,0cch,0d1h,068h,040h,066h,044h,006h,055h,069h,0e3h,0e4h,0e5h,0cbh,069h	; 7d83  hA..h@fD.Ui....i
	defb 07ah,061h,078h,078h,08bh,087h,040h,00ch,00ah,054h,099h,0e6h,0e7h,0e8h,040h,066h	; 7d93  zaxx..@..T....@f
	defb 07ch,078h,078h,060h,062h,078h,08bh,087h,040h,002h,053h,030h,0b0h,0a9h,0ach,0a5h	; 7da3  |xx`bx..@.S0....
	defb 067h,041h,06eh,067h,063h,060h,078h,078h,08bh,087h,002h,052h,031h,095h,031h,0b0h	; 7db3  gAngc`xx...R1.1.
	defb 0a9h,0a5h,06fh,040h,06eh,069h,08ch,060h,078h,078h,07fh,002h,051h,030h,00eh,035h	; 7dc3  ..o@ni.`xx..Q0.5
	defb 0a9h,0a5h,06fh,040h,06eh,069h,060h,078h,083h,066h,006h,050h,030h,00fh,037h,0a9h	; 7dd3  ..o@ni`x.f.P0.7.
	defb 0a5h,06fh,06eh,067h,078h,093h,067h,002h,050h,037h,095h,032h,099h,06fh,040h,084h	; 7de3  .ongx.g.P7.2.o@.
	defb 078h,07fh,040h,002h,03ch,099h,040h,07ch,078h,091h,066h,040h,039h,095h,031h,097h	; 7df3  x.@.<.@|x.f@9.1.
	defb 09dh,0c6h,078h,081h,067h,068h,03dh,0a1h,0cah,093h,066h,040h,069h,03ch,095h,0b3h	; 7e03  ..x.gh=...f@i<..
	defb 07eh,093h,067h,066h,040h,03dh,0a3h,082h,093h,0c7h,067h,06ah,033h,00eh,037h,096h	; 7e13  ~.gf@=....gj3.7.
	defb 09fh,092h,093h,0cbh,068h,06bh,033h,00fh,031h,095h,033h,0abh,0a7h,07ah,060h,093h	; 7e23  ....hk3.1.3..z`.
	defb 066h,069h,040h,037h,0b1h,0abh,0adh,0a7h,086h,08ah,078h,061h,062h,067h,041h,030h	; 7e33  fi@7......xabgA0
	defb 095h,032h,0abh,0adh,0a7h,086h,08eh,08ah,078h,078h,078h,060h,060h,069h,041h,0a4h	; 7e43  .2......xxx``iA.
	defb 032h,0abh,0a7h,040h,086h,08ah,078h,078h,078h,078h,078h,062h,061h,067h,041h,098h	; 7e53  2..@..xxxxxbagA.
	defb 030h,031h,09bh,041h,080h,078h,078h,078h,060h,078h,062h,060h,069h,041h,0a4h,0a8h	; 7e63  01.A.xxx`xb`iA..
	defb 00eh,030h,030h,0a3h,043h,092h,078h,078h,061h,060h,069h,067h,041h,098h,095h,030h	; 7e73  .00.C.xxa`igA..0
	defb 00fh,030h,030h,09fh,0eeh,0e9h,0eah,0f6h,08ch,08dh,08fh,089h,067h,041h,0a4h,0a8h	; 7e83  .00.........gA..
	defb 095h,030h,00eh,031h,0b3h,040h,0efh,0ebh,0ebh,0f7h,043h,00dh,0a4h,0a8h,033h,00fh	; 7e93  .0.1.@....C...3.
	defb 031h,030h,0a9h,0a5h,045h,0a4h,0a8h,038h,031h,095h,0a9h,0ach,0ach,0ach,0ach,0a8h	; 7ea3  10..E..81.......
	defb 032h,095h,036h,021h,035h,035h,030h,079h,094h,000h,03fh,031h,098h,040h,039h,068h	; 7eb3  2.6!550y..?1.@9h
	defb 068h,033h,0a4h,0a8h,040h,09bh,037h,06ah,066h,067h,069h,0a4h,0ach,0a8h,0b0h,0b1h	; 7ec3  h3..@.7jfgi.....
	defb 0abh,0a7h,030h,036h,066h,06bh,067h,0a4h,0a8h,040h,0b1h,0abh,0a7h,066h,032h,034h	; 7ed3  ..06fkg..@...f24
	defb 068h,066h,067h,030h,098h,040h,0abh,0a7h,032h,067h,068h,031h,033h,066h,069h,067h	; 7ee3  hfg0.@..2gh13fig
	defb 030h,098h,040h,09bh,0c2h,0cch,0bdh,0bfh,0b8h,030h,069h,031h,032h,06ah,067h,068h	; 7ef3  0.@......0i12jgh
	defb 068h,09ch,095h,0a3h,0d9h,0d8h,0dah,0b9h,0b5h,0bch,066h,032h,032h,06bh,06ah,069h	; 7f03  h.........f22kji
	defb 06bh,0a0h,040h,0a1h,0dbh,0d7h,0dch,0b7h,0b5h,0bah,067h,032h,032h,066h,06bh,066h	; 7f13  k.@.......g22fkf
	defb 030h,0b2h,041h,0a9h,0a5h,0cch,0b5h,0bah,030h,0a4h,0a8h,0b0h,0b0h,031h,068h,067h	; 7f23  0.A.....0....1hg
	defb 06ah,067h,09ch,040h,0abh,0aah,040h,095h,0a9h,0ach,0ach,0a8h,043h,031h,069h,068h	; 7f33  jg.@..@.....C1ih
	defb 06bh,030h,0a0h,0a3h,030h,068h,09ah,048h,032h,069h,030h,098h,040h,09fh,066h,069h	; 7f43  k0..0h.H2i0.@.fi
	defb 066h,09ah,040h,095h,045h,032h,0a4h,0a8h,040h,09bh,066h,067h,066h,067h,068h,09ah	; 7f53  f.@.E2..@.fgfgh.
	defb 046h,031h,098h,040h,0abh,0a7h,068h,067h,06ah,067h,068h,069h,030h,0a6h,0aah,040h	; 7f63  F1.@..hgjghi0..@
	defb 095h,042h,0a4h,0a8h,0abh,0a7h,031h,069h,030h,06bh,068h,069h,030h,066h,030h,066h	; 7f73  .B....1i0khi0f0f
	defb 09ah,043h,095h,09bh,034h,068h,030h,069h,068h,066h,067h,030h,067h,068h,0a6h,0aah	; 7f83  .C..4h0ihfg0gh..
	defb 0b1h,0b1h,09bh,035h,069h,031h,069h,067h,032h,069h,033h,038h,068h,031h,0f0h,0e9h	; 7f93  ...5i1ig2i38h1..
	defb 0eah,0f4h,033h,038h,069h,031h,0f1h,0ebh,0ebh,0f5h,033h,03ah,00dh,037h,038h,06ah	; 7fa3  ..38i1....3:.78j
	defb 031h,00dh,034h,004h,007h,038h,06bh,033h,004h,007h,007h,007h,051h,03ch,004h,055h	; 7fb3  1.4..8k3....Q<.U
	defb 03ch,006h,055h,021h,031h,037h,030h,079h,069h,094h,054h,09bh,03dh,051h,00eh,050h	; 7fc3  <.U!170yi.T.=Q.P
	defb 0b3h,030h,066h,066h,066h,066h,066h,066h,066h,066h,035h,051h,00fh,095h,050h,09dh	; 7fd3  .0ffffffff5Q..P.
	defb 047h,066h,034h,054h,0a1h,030h,068h,068h,068h,068h,032h,067h,066h,033h,051h,0b1h	; 7fe3  Gf4T.0hhhh2gf3Q.
	defb 0b1h,0b1h,050h,099h,043h,0cch,0d1h,030h,066h,067h,033h,0abh,0a7h,031h,0a6h,0aah	; 7ff3  ..P.C..0fg3..1..
	defb 050h,0b0h,09dh,0ddh,0deh,0dfh,0cbh,030h,067h,068h,033h,034h,066h,09ah,050h,0a1h	; 8003  P......0gh34f.P.
	defb 0e0h,0e1h,0e2h,031h,066h,040h,033h,033h,06ah,067h,030h,09ah,050h,0b0h,0b0h,0b0h	; 8013  ...1f@33jg0.P...
	defb 0a9h,0a5h,067h,030h,068h,032h,032h,068h,06bh,086h,08eh,087h,0a6h,0adh,0adh,0adh	; 8023  ..g0h22hk.......
	defb 0aah,050h,0a9h,0a5h,040h,032h,031h,06ah,040h,082h,078h,078h,08dh,030h,066h,031h	; 8033  .P..@21j@.xx.0f1
	defb 066h,09ah,051h,09dh,032h,030h,06ah,06bh,07ah,078h,08dh,089h,030h,066h,067h,030h	; 8043  f.Q.20jkzx..0fg0
	defb 066h,067h,098h,050h,095h,09fh,032h,030h,06bh,07eh,078h,085h,0b7h,0b8h,066h,067h	; 8053  fg.P..20k~x...fg
	defb 030h,066h,067h,098h,050h,0abh,0a7h,033h,030h,06ah,082h,078h,091h,0bbh,0bch,067h	; 8063  0fg.P..30j.x...g
	defb 030h,066h,067h,09ch,095h,050h,0a9h,0ach,0a5h,032h,030h,06bh,078h,078h,083h,0cbh	; 8073  0fg..P...20kxx..
	defb 0bah,030h,068h,067h,030h,0a6h,0aah,0b1h,0b1h,0b1h,050h,099h,031h,068h,07eh,078h	; 8083  .0hg0.....P.1h~x
	defb 078h,060h,08bh,087h,066h,040h,068h,068h,068h,068h,068h,066h,066h,09ah,095h,09dh	; 8093  x`..f@hhhhhff...
	defb 030h,040h,090h,078h,078h,061h,078h,078h,063h,07bh,046h,068h,0b2h,0a1h,030h,030h	; 80a3  0@.xxaxxc{Fh..00
	defb 07ch,078h,078h,078h,078h,078h,078h,085h,0d0h,0cch,0cfh,033h,040h,0a2h,050h,099h	; 80b3  |xxxxxx....3@.P.
	defb 031h,088h,060h,060h,078h,078h,08dh,0b7h,0bch,066h,030h,066h,066h,066h,066h,066h	; 80c3  1.``xx...f0fffff
	defb 09eh,050h,095h,032h,067h,067h,032h,0b9h,0bah,067h,030h,067h,067h,067h,067h,067h	; 80d3  .P.2gg2..g0ggggg
	defb 030h,09ah,050h,030h,06ch,06eh,030h,06eh,03dh,09ah,030h,06dh,06fh,030h,06fh,031h	; 80e3  0.P0ln0n=.0mo0o1
	defb 06ch,06eh,03ah,031h,0f8h,0f9h,030h,00dh,030h,06dh,06fh,033h,0f0h,0e9h,0eah,0f4h	; 80f3  ln:1..0.0mo3....
	defb 032h,030h,0f8h,0f9h,032h,00dh,034h,00dh,0f1h,0ebh,0ebh,0f5h,032h,03fh,032h,098h	; 8103  20..2.4.....2?2.
	defb 021h,033h,037h,038h,079h,094h,078h,034h,068h,066h,030h,068h,06ah,039h,031h,0d0h	; 8113  !378y.x4hf0hj91.
	defb 0c1h,030h,069h,067h,066h,069h,06bh,068h,038h,030h,068h,0b6h,0ddh,0deh,0dfh,030h	; 8123  .0igfikh80h....0
	defb 067h,066h,068h,069h,068h,068h,036h,030h,069h,066h,0e0h,0e1h,0e2h,0c9h,030h,067h	; 8133  gfhihh60if....0g
	defb 069h,066h,069h,069h,066h,035h,030h,06ah,067h,068h,066h,0cch,0cdh,07ah,062h,07bh	; 8143  ifiif50jghf..zb{
	defb 067h,066h,06ah,067h,068h,034h,030h,06bh,066h,069h,067h,068h,030h,092h,063h,050h	; 8153  gfjgh40kfigh0.cP
	defb 07bh,067h,06bh,068h,069h,034h,0a9h,0a5h,067h,030h,068h,069h,068h,07ch,052h,07bh	; 8163  {gkhi4..g0hih|R{
	defb 066h,069h,066h,06ah,033h,041h,0a9h,030h,069h,066h,069h,066h,07ch,051h,093h,067h	; 8173  fifj3A.0ifif|Q.g
	defb 066h,067h,06bh,068h,032h,042h,0a1h,030h,067h,068h,067h,066h,07ch,050h,093h,068h	; 8183  fgkh2B.0ghgf|P.h
	defb 067h,030h,068h,069h,032h,042h,0a3h,066h,030h,069h,068h,067h,068h,084h,085h,069h	; 8193  g0hi2B.f0ihgh..i
	defb 0cch,0d1h,069h,066h,032h,042h,09fh,067h,030h,066h,069h,068h,069h,066h,098h,0b0h	; 81a3  ..if2B.g0fihif..
	defb 099h,0cbh,066h,067h,06ah,031h,041h,0a3h,06ch,031h,067h,066h,069h,066h,067h,0b2h	; 81b3  ..fgj1A.l1gfifg.
	defb 041h,099h,067h,066h,06bh,031h,041h,0afh,06dh,08ah,060h,08bh,067h,066h,067h,068h	; 81c3  A.gfk1A.m.`.gfgh
	defb 0b2h,041h,0b3h,068h,067h,066h,031h,040h,095h,099h,030h,08ch,061h,050h,07bh,069h	; 81d3  .A.hgf1@..0.aP{i
	defb 066h,069h,0b2h,041h,0b3h,069h,068h,067h,031h,042h,0a9h,0a5h,08ch,051h,08bh,067h	; 81e3  fi.A.ihg1B...Q.g
	defb 06ah,0a2h,041h,0b3h,066h,069h,032h,044h,099h,07ch,051h,08bh,06bh,09eh,095h,040h	; 81f3  j.A.fi2D.|Q.k..@
	defb 0b3h,067h,066h,032h,045h,09dh,084h,051h,08bh,030h,09ah,0b1h,09bh,030h,067h,032h	; 8203  .gf2E..Q.0...0g2
	defb 043h,00eh,040h,0a1h,030h,08ch,050h,08dh,038h,042h,095h,00fh,041h,099h,038h,066h	; 8213  C.@.0.P.8B..A.8f
	defb 031h,047h,09dh,037h,067h,031h,046h,095h,0a1h,030h,068h,038h,041h,00eh,044h,0b3h	; 8223  1G.7g1F..0h8A.D.
	defb 030h,069h,066h,030h,0f0h,0e9h,0eah,0f4h,032h,040h,095h,00fh,044h,09bh,031h,067h	; 8233  0if0....2@..D.1g
	defb 030h,0f1h,0ebh,0ebh,0f5h,030h,00dh,030h,045h,0abh,0a7h,03bh,021h,033h,035h,030h	; 8243  0....0.0E..;!350
	defb 079h,000h,007h,035h,06ah,03ch,035h,06bh,06ah,066h,06ah,034h,004h,053h,050h,003h	; 8253  y..5j<5kjfj4.SP.
	defb 033h,068h,06bh,067h,06bh,030h,004h,052h,044h,041h,050h,003h,030h,066h,069h,0ddh	; 8263  3hkgk0.RDAP.0fi.
	defb 0deh,0dfh,004h,048h,042h,005h,030h,067h,06ah,0e0h,0e1h,0e2h,006h,048h,042h,001h	; 8273  ...HB.0gj....HB.
	defb 030h,068h,06bh,068h,0c0h,0c1h,00ch,00ah,047h,041h,005h,030h,068h,069h,066h,069h	; 8283  0hkh....GA.0hifi
	defb 068h,092h,078h,07bh,006h,046h,041h,005h,030h,069h,066h,067h,066h,069h,084h,078h	; 8293  h.x{.FA.0ifgfi.x
	defb 078h,002h,046h,042h,003h,030h,067h,06ah,067h,066h,0c6h,078h,078h,07fh,006h,045h	; 82a3  x.FB.0gjgf.xx..E
	defb 042h,005h,030h,066h,069h,066h,067h,0ceh,0c1h,078h,091h,006h,045h,042h,005h,068h	; 82b3  B.0fifg..x..EB.h
	defb 067h,06ah,067h,032h,08ch,081h,006h,045h,042h,001h,069h,066h,06bh,06ah,032h,066h	; 82c3  gjg2...EB.ifkj2f
	defb 030h,006h,045h,041h,005h,031h,067h,068h,06bh,068h,030h,068h,067h,068h,002h,045h	; 82d3  0.EA.1ghkh0hgh.E
	defb 041h,005h,031h,06ah,069h,066h,069h,068h,069h,06ah,069h,030h,002h,008h,008h,008h	; 82e3  A.1jifihiji0....
	defb 008h,001h,042h,003h,030h,06bh,030h,067h,06ah,069h,066h,06bh,068h,036h,043h,003h	; 82f3  ..B.0k0gjifkh6C.
	defb 030h,066h,06ah,06bh,066h,069h,066h,069h,068h,035h,041h,008h,008h,001h,068h,067h	; 8303  0fjkfifih5A...hg
	defb 06bh,068h,067h,066h,067h,066h,069h,035h,009h,00bh,032h,069h,030h,068h,069h,066h	; 8313  khgfgfi5..2i0hif
	defb 067h,066h,067h,036h,034h,068h,030h,069h,030h,067h,030h,067h,037h,032h,066h,030h	; 8323  gfg64h0i0g0g72f0
	defb 069h,03dh,032h,067h,032h,0ech,0e9h,0eah,0f2h,031h,0f8h,0f9h,034h,036h,0edh,0ebh	; 8333  i=2g2....1..46..
	defb 0ebh,0f3h,00dh,037h,03fh,033h,03fh,033h,021h,032h,037h,039h,079h,094h,0b0h,033h	; 8343  ...7?3?3!279y..3
	defb 068h,039h,068h,033h,032h,068h,06bh,0a4h,0a8h,055h,0a5h,030h,069h,066h,032h,032h	; 8353  h9h32hk..U.0if22
	defb 069h,098h,095h,047h,0a9h,0a5h,069h,068h,031h,032h,09ch,042h,0abh,0adh,0aah,045h	; 8363  i..G..ih12.B...E
	defb 099h,069h,031h,031h,066h,0a0h,041h,0a3h,0d9h,0d8h,0dah,0a6h,0adh,0aah,043h,09dh	; 8373  .i11f.A.......C.
	defb 031h,031h,067h,0a2h,041h,0a1h,0dbh,0d7h,0dch,0c7h,066h,030h,0a2h,040h,00eh,040h	; 8383  11g.A.....f0.@.@
	defb 0afh,068h,030h,032h,09eh,041h,0a3h,0c0h,0cch,0c1h,0b6h,067h,068h,0aeh,040h,00fh	; 8393  .h02.A.....gh.@.
	defb 040h,0afh,069h,030h,032h,066h,0a6h,0adh,0a7h,066h,08ah,08bh,087h,030h,069h,0aeh	; 83a3  @.i02f...f...0i.
	defb 042h,0afh,066h,030h,032h,069h,066h,086h,08ah,061h,078h,060h,060h,068h,030h,0a0h	; 83b3  B.f02if..ax``h0.
	defb 042h,09fh,067h,030h,032h,06ah,067h,088h,08ch,078h,07dh,067h,069h,06bh,098h,095h	; 83c3  B.g02jg..x}gik..
	defb 041h,09bh,032h,031h,066h,06bh,031h,0a4h,0a8h,053h,042h,09bh,066h,032h,031h,067h	; 83d3  A.21fk1..SB.f21g
	defb 068h,031h,0a0h,046h,0a3h,068h,067h,032h,032h,069h,031h,09ah,0abh,0adh,0aah,0b1h	; 83e3  h1.F.hg22i1.....
	defb 095h,041h,0a1h,069h,033h,030h,0f8h,0f9h,033h,066h,031h,066h,0a6h,0aah,041h,099h	; 83f3  .A.i30..3f1f..A.
	defb 033h,031h,0f8h,0f9h,031h,068h,067h,031h,067h,068h,030h,0a2h,040h,095h,099h,032h	; 8403  31..1hg1gh0.@..2
	defb 035h,069h,033h,06bh,068h,09eh,042h,09dh,031h,030h,09ch,052h,099h,031h,0ech,0e9h	; 8413  5i3kh.B.10.R.1..
	defb 0eah,0f4h,069h,030h,0b2h,041h,0a1h,031h,030h,0a0h,040h,00eh,041h,09dh,030h,0edh	; 8423  ..i0.A.10.@.A.0.
	defb 0ebh,0ebh,0f5h,030h,09ch,095h,041h,095h,068h,030h,030h,0b2h,040h,00fh,00eh,040h	; 8433  ...0..A.h00.@..@
	defb 0a1h,035h,0a0h,042h,0a3h,069h,030h,030h,09ah,041h,00fh,041h,099h,033h,098h,095h	; 8443  .5.B.i00.A.A.3..
	defb 042h,09fh,066h,030h,031h,09ah,044h,053h,043h,09bh,066h,067h,030h,032h,09ah,04ah	; 8453  B.f01.DSC.fg02.J
	defb 09bh,030h,067h,031h,033h,0a6h,0aah,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0abh,0a7h	; 8463  .0g13...........
	defb 034h,03fh,033h,021h,031h,038h,035h,000h,079h,0b5h,035h,003h,043h,068h,040h,066h	; 8473  4?3!185.y.5.Ch@f
	defb 041h,0c2h,0c3h,040h,098h,036h,003h,041h,068h,069h,066h,067h,0c6h,0e3h,0e4h,0e5h	; 8483  A..@.6.Ahifg....
	defb 09ch,094h,036h,005h,040h,068h,069h,066h,067h,040h,0cah,0e6h,0e7h,0e8h,0a0h,094h	; 8493  ..6.@hifg@......
	defb 037h,003h,069h,06ah,067h,040h,0a4h,0ach,0a8h,0b0h,0b0h,094h,094h,037h,005h,06ah	; 84a3  7.ijg@.......7.j
	defb 06bh,040h,098h,094h,094h,094h,094h,094h,094h,094h,037h,005h,06bh,040h,098h,094h	; 84b3  k@........7.k@..
	defb 094h,094h,094h,094h,094h,094h,094h,037h,005h,066h,09ch,094h,094h,094h,094h,094h	; 84c3  .......7.f......
	defb 094h,094h,094h,094h,037h,001h,067h,0aeh,094h,094h,094h,0abh,0aah,094h,094h,094h	; 84d3  ....7.g.........
	defb 09bh,036h,001h,086h,087h,09eh,094h,094h,09bh,0b7h,0b8h,0a6h,0adh,0a7h,0b7h,035h	; 84e3  .6.............5
	defb 001h,07ah,078h,093h,040h,0a6h,0a7h,0b7h,076h,072h,0bdh,0bdh,0bfh,050h,034h,001h	; 84f3  .zx.@...vr...P4.
	defb 07ah,078h,078h,07dh,0b7h,0bfh,0bdh,050h,077h,050h,074h,072h,070h,050h,033h,001h	; 8503  zxx}...PwPtrpP3.
	defb 07ah,060h,078h,07dh,0b7h,073h,076h,072h,076h,073h,074h,075h,050h,071h,050h,032h	; 8513  z`x}.svrvstuPqP2
	defb 005h,07eh,078h,061h,07dh,0b7h,073h,072h,077h,070h,077h,074h,075h,050h,074h,051h	; 8523  .~xa}.srwpwtuPtQ
	defb 032h,005h,082h,078h,07dh,0b7h,073h,074h,050h,070h,071h,050h,075h,050h,070h,075h	; 8533  2..x}.stPpqPuPpu
	defb 051h,032h,001h,092h,085h,0b7h,074h,076h,075h,074h,071h,074h,052h,071h,052h,030h	; 8543  Q2....tvutqtRqR0
	defb 009h,00bh,07ah,060h,091h,0bbh,075h,077h,050h,075h,076h,075h,056h,001h,040h,07ah	; 8553  ..z`..uwPuvuV.@z
	defb 078h,061h,083h,0b9h,0beh,052h,077h,057h,066h,07eh,078h,078h,078h,078h,08bh,066h	; 8563  xa...RwWf~xxxx.f
	defb 0b9h,0beh,051h,074h,073h,055h,067h,080h,078h,078h,078h,078h,078h,063h,07fh,040h	; 8573  ..QtsUg.xxxxxc.@
	defb 0b9h,0beh,075h,056h,040h,068h,088h,08fh,08ch,078h,078h,078h,081h,066h,068h,040h	; 8583  ..uV@h...xxx.fh@
	defb 0b9h,0beh,0beh,0beh,0beh,0beh,0beh,0beh,040h,069h,066h,040h,068h,088h,08fh,089h	; 8593  ........@if@h...
	defb 06ah,067h,069h,06ah,047h,041h,067h,068h,069h,066h,068h,066h,06bh,041h,06bh,066h	; 85a3  jgijGAghifhfkAkf
	defb 041h,0f0h,0e9h,0eah,0f4h,040h,042h,069h,040h,067h,069h,067h,043h,067h,041h,0f1h	; 85b3  A....@Bi@gigCgA.
	defb 0ebh,0ebh,0f5h,040h,04fh,043h,021h,035h,032h,032h,094h,079h,078h,040h,068h,041h	; 85c3  ...@OC!522.yx@hA
	defb 068h,066h,066h,040h,06ah,044h,06ah,044h,068h,069h,0f8h,0f9h,069h,067h,067h,040h	; 85d3  hff@jDjDhi..igg@
	defb 06bh,041h,068h,040h,068h,06bh,068h,043h,069h,066h,040h,00dh,00dh,040h,0a4h,0a8h	; 85e3  kAh@hkhCif@..@..
	defb 0b0h,099h,066h,069h,066h,069h,068h,069h,066h,040h,068h,040h,040h,067h,00dh,0c2h	; 85f3  ..fifihif@h@@g..
	defb 0c3h,09ch,032h,09bh,067h,066h,067h,040h,069h,040h,067h,068h,069h,040h,003h,040h	; 8603  ..2.gfg@i@ghi@.@
	defb 0ddh,0deh,0dfh,0aeh,095h,030h,0a3h,08ah,050h,061h,052h,08bh,087h,069h,066h,040h	; 8613  .....0..PaR..if@
	defb 000h,003h,0e0h,0e1h,0e2h,0a0h,031h,0a1h,08ch,056h,07bh,067h,068h,000h,000h,003h	; 8623  ......1..V{gh...
	defb 040h,098h,00eh,032h,099h,0c2h,0bdh,0d1h,084h,051h,060h,050h,07fh,069h,000h,000h	; 8633  @..2.....Q`P.i..
	defb 005h,09ch,030h,00fh,033h,099h,0b9h,0b5h,0d1h,084h,050h,061h,050h,091h,040h,000h	; 8643  ..0.3.....PaP.@.
	defb 000h,005h,0aeh,095h,034h,095h,099h,0b9h,0bch,080h,052h,091h,066h,000h,000h,005h	; 8653  ....4.....R.f...
	defb 0aeh,037h,099h,0ceh,0cfh,092h,051h,081h,067h,000h,000h,005h,0aeh,038h,099h,040h	; 8663  .7....Q.g....8.@
	defb 084h,050h,085h,068h,040h,000h,000h,001h,0a0h,039h,0a9h,0a5h,041h,069h,040h,000h	; 8673  .P.h@....9..Ai@.
	defb 001h,098h,038h,00eh,032h,0a9h,0a5h,041h,001h,098h,031h,00eh,036h,00fh,034h,0b0h	; 8683  ..8.2..A..1.6.4.
	defb 0a9h,09ch,032h,00fh,031h,0abh,0adh,0aah,039h,0aeh,033h,0abh,0a7h,066h,068h,040h	; 8693  ..2.1...9.3..fh@
	defb 09ah,038h,0aeh,032h,09bh,0f8h,0f9h,067h,069h,0a4h,0a8h,038h,09eh,095h,031h,0a9h	; 86a3  .8.2...gi..8..1.
	defb 0ach,0ach,0a8h,0b0h,034h,0b1h,0b1h,0b1h,032h,040h,0a2h,039h,0abh,0a7h,066h,041h	; 86b3  ....4...2@.9..fA
	defb 0a6h,0aah,030h,040h,09eh,0b1h,037h,09bh,066h,068h,067h,041h,068h,040h,09ah,041h	; 86c3  ..0@..7.fhgAh@.A
	defb 068h,0a6h,0aah,0b1h,0b1h,0b1h,0abh,0adh,0a7h,068h,067h,069h,042h,069h,041h,003h	; 86d3  h........hgiBiA.
	defb 040h,069h,06ah,066h,040h,068h,041h,06ah,068h,069h,041h,0ech,0e9h,0eah,0f2h,041h	; 86e3  @ijf@hAjhiA....A
	defb 000h,003h,040h,06bh,067h,040h,069h,066h,040h,06bh,069h,041h,00dh,0edh,0ebh,0ebh	; 86f3  ..@kg@if@kiA....
	defb 0f3h,041h,000h,000h,007h,007h,003h,041h,067h,04bh,021h,034h,031h,038h,079h,000h	; 8703  .A.....AgK!418y.
	defb 094h,03ah,066h,033h,068h,031h,004h,007h,003h,034h,068h,030h,066h,030h,067h,030h	; 8713  .:f3h1...4h0f0g0
	defb 0ddh,0deh,0dfh,069h,068h,004h,040h,041h,007h,003h,032h,069h,066h,067h,066h,030h	; 8723  ...ih.@A..2ifgf0
	defb 0c8h,0e0h,0e1h,0e2h,0c7h,069h,006h,040h,043h,003h,031h,068h,067h,068h,067h,066h	; 8733  .....i.@C.1hghgf
	defb 0ceh,0cfh,030h,0c0h,0cdh,066h,006h,040h,044h,003h,030h,069h,066h,069h,066h,067h	; 8743  ..0..f.@D.0ififg
	defb 07ah,078h,07bh,030h,066h,067h,006h,040h,044h,005h,031h,067h,068h,067h,07ah,078h	; 8753  zx{0fg.@D.1ghgzx
	defb 078h,085h,066h,067h,068h,002h,040h,044h,005h,031h,066h,069h,07ah,078h,078h,078h	; 8763  x.fgh.@D.1fizxxx
	defb 081h,067h,066h,069h,030h,006h,044h,001h,030h,068h,067h,07ah,078h,078h,078h,07dh	; 8773  .gfi0.D.0hgzxxx}
	defb 068h,030h,067h,066h,030h,006h,043h,001h,030h,066h,069h,07eh,078h,060h,078h,07dh	; 8783  h0gf0.C.0fi~x`x}
	defb 066h,069h,066h,066h,067h,030h,006h,042h,005h,030h,066h,067h,066h,082h,078h,061h	; 8793  fiffg0.B.0fgf.xa
	defb 085h,066h,067h,066h,067h,067h,030h,004h,040h,042h,001h,030h,067h,068h,067h,078h	; 87a3  .fgfgg0.@B.0ghgx
	defb 078h,078h,0c7h,067h,068h,067h,066h,030h,004h,041h,041h,001h,031h,066h,069h,066h	; 87b3  xx.ghgf0.AA.1fif
	defb 078h,078h,078h,0bbh,068h,069h,066h,067h,066h,006h,041h,040h,005h,032h,067h,066h	; 87c3  xxx.hifgf.A@.2gf
	defb 067h,062h,078h,078h,0cbh,069h,06ah,067h,066h,067h,002h,041h,009h,00bh,033h,067h	; 87d3  gbxx.ijgfg.A..3g
	defb 068h,063h,078h,078h,07bh,066h,06bh,066h,067h,066h,030h,002h,040h,032h,06ch,06eh	; 87e3  hcxx{fkfgf0.@2ln
	defb 030h,068h,069h,060h,078h,078h,093h,067h,066h,067h,066h,067h,066h,031h,032h,06dh	; 87f3  0hi`xx.gfgfgf12m
	defb 06fh,030h,069h,066h,061h,078h,078h,093h,068h,067h,066h,067h,066h,067h,068h,030h	; 8803  o0ifaxx.hgfgfgh0
	defb 0a4h,0a8h,0b0h,0b0h,0b0h,099h,030h,067h,07ch,078h,078h,093h,069h,068h,067h,066h	; 8813  ......0g|xx.ihgf
	defb 067h,066h,069h,030h,055h,0a9h,0a5h,030h,07ch,078h,078h,07bh,069h,030h,067h,066h	; 8823  gfi0U..0|xx{i0gf
	defb 067h,031h,051h,00eh,054h,099h,030h,088h,08ch,07dh,032h,067h,066h,031h,051h,00fh	; 8833  g1Q.T.0..}2gf1Q.
	defb 054h,0b3h,037h,067h,031h,055h,0b1h,0abh,0a7h,03ah,051h,0b1h,0b1h,0abh,0a7h,030h	; 8843  T.7g1U...:Q....0
	defb 0f8h,0f9h,031h,00dh,030h,0f0h,0e9h,0eah,0f4h,032h,0abh,0a7h,032h,0f8h,0f9h,035h	; 8853  ..1.0....2..2..5
	defb 0f1h,0ebh,0ebh,0f5h,032h,03fh,033h,021h,033h,036h,030h,094h,079h,0b1h,04fh,040h	; 8863  ....2?3!360.y.O@
	defb 09ah,031h,043h,066h,042h,068h,044h,0f8h,0f9h,041h,0a2h,030h,043h,067h,041h,068h	; 8873  .1CfBhD..A.0CgAh
	defb 069h,040h,068h,040h,066h,044h,09eh,030h,046h,069h,040h,066h,069h,068h,067h,066h	; 8883  i@h@fD.0Fi@fihgf
	defb 041h,06ch,06eh,040h,0b2h,0a5h,042h,068h,042h,068h,067h,066h,069h,066h,067h,040h	; 8893  Aln@..BhBhgfifg@
	defb 066h,06dh,06fh,09ch,030h,030h,0a9h,0a5h,040h,069h,066h,041h,069h,040h,067h,066h	; 88a3  fmo.00..@ifAi@gf
	defb 067h,040h,066h,067h,040h,06eh,0a0h,030h,032h,099h,040h,067h,066h,040h,0c2h,0c3h	; 88b3  g@fg@n.02.@gf@..
	defb 040h,067h,040h,06ah,067h,068h,040h,06fh,0b2h,030h,033h,0a9h,0a5h,067h,066h,0d9h	; 88c3  @g@jgh@o.03..gf.
	defb 0d8h,0dah,040h,068h,06bh,066h,069h,06eh,040h,0b2h,095h,035h,099h,067h,0dbh,0d7h	; 88d3  ..@hkfin@..5.g..
	defb 0dch,0c9h,069h,040h,067h,040h,06fh,098h,031h,095h,034h,095h,099h,041h,0c0h,0cdh	; 88e3  ..i@g@o.1.4..A..
	defb 040h,098h,0b0h,0b0h,0b0h,030h,095h,030h,032h,00eh,033h,0b0h,0b0h,0b0h,0b0h,09dh	; 88f3  @....0.02.3.....
	defb 0a2h,035h,032h,00fh,036h,095h,0a1h,09eh,095h,031h,00eh,031h,036h,00eh,034h,09dh	; 8903  .52.6....1.16.4.
	defb 0a2h,031h,00fh,031h,036h,00fh,095h,033h,0a1h,09eh,034h,03dh,09dh,0a2h,033h,030h	; 8913  .1.16..3..4=..30
	defb 095h,03bh,0a1h,09eh,033h,034h,058h,09bh,040h,09ah,051h,030h,031h,0abh,0adh,0a7h	; 8923  .;..34X.@.Q01...
	defb 040h,066h,040h,066h,068h,040h,066h,043h,066h,040h,066h,09ah,0abh,0a7h,06ch,041h	; 8933  @f@fh@fCf@f...lA
	defb 068h,067h,066h,067h,069h,068h,067h,043h,067h,068h,067h,040h,040h,06ch,06dh,041h	; 8943  hgfgihgCghg@@lmA
	defb 069h,066h,067h,068h,066h,069h,040h,0f0h,0e9h,0eah,0f4h,040h,069h,068h,040h,040h	; 8953  ifghfi@....@ih@@
	defb 06dh,042h,066h,067h,066h,069h,067h,06ah,068h,0f1h,0ebh,0ebh,0f5h,040h,06ah,069h	; 8963  mBfgfigjh....@ji
	defb 040h,044h,067h,068h,067h,068h,066h,06bh,069h,044h,06bh,041h,045h,069h,040h,069h	; 8973  @DghghfkiDkAEi@i
	defb 067h,045h,00dh,042h,04fh,043h,021h,031h,039h,036h,079h,000h,094h,036h,098h,09bh	; 8983  gE.BOC!196y..6..
	defb 039h,004h,032h,0d0h,0c5h,0c2h,0c3h,09ah,099h,068h,033h,004h,007h,007h,007h,007h	; 8993  9.2......h3.....
	defb 040h,031h,066h,0b6h,0ddh,0deh,0dfh,030h,050h,069h,066h,068h,031h,002h,008h,043h	; 89a3  @1f....0Pifh1..C
	defb 030h,066h,067h,0c6h,0e0h,0e1h,0e2h,098h,09bh,066h,067h,069h,066h,032h,002h,042h	; 89b3  0fg......fgif2.B
	defb 030h,067h,066h,0ceh,0cfh,098h,0b0h,09bh,030h,067h,066h,066h,067h,068h,032h,006h	; 89c3  0gf.....0gffgh2.
	defb 041h,030h,068h,067h,066h,098h,050h,09bh,07ah,08bh,087h,067h,067h,066h,069h,068h	; 89d3  A0hgf.P.z..ggfih
	defb 031h,006h,041h,06ah,069h,066h,067h,0b2h,0b3h,030h,092h,078h,078h,07bh,066h,067h	; 89e3  1.Ajifg..0.xx{fg
	defb 066h,069h,06ah,030h,006h,041h,06bh,068h,067h,066h,0b2h,0b3h,030h,060h,078h,078h	; 89f3  fij0.Akhgf..0`xx
	defb 093h,069h,066h,067h,068h,06bh,030h,006h,041h,030h,069h,066h,067h,09ah,050h,099h	; 8a03  .ifghk0.A0ifg.P.
	defb 067h,060h,078h,078h,07bh,067h,066h,069h,030h,004h,042h,030h,066h,067h,066h,030h	; 8a13  g`xx{gfi0.B0fgf0
	defb 0b2h,0b3h,068h,067h,07ch,078h,078h,0c7h,067h,068h,030h,006h,042h,066h,067h,066h	; 8a23  ..hg|xx.gh0.Bfgf
	defb 067h,066h,0a2h,0b3h,069h,066h,0c6h,092h,078h,0cbh,066h,069h,030h,006h,042h,067h	; 8a33  gf..if..x.fi0.Bg
	defb 066h,067h,066h,067h,0aeh,0b3h,066h,067h,0cah,092h,078h,07bh,067h,068h,030h,002h	; 8a43  fgfg..fg..x{gh0.
	defb 042h,066h,067h,066h,067h,068h,0aeh,0b3h,067h,066h,066h,092h,078h,093h,066h,069h	; 8a53  Bfgfgh..gff.x.fi
	defb 06ah,030h,006h,041h,067h,066h,067h,066h,069h,0aeh,0b3h,030h,067h,067h,092h,078h	; 8a63  j0.Agfgfi..0gg.x
	defb 060h,067h,068h,06bh,030h,006h,041h,030h,067h,068h,067h,066h,09eh,050h,09dh,066h	; 8a73  `ghk0.A0ghgf.P.f
	defb 07ah,078h,078h,061h,066h,069h,06ah,030h,002h,041h,099h,030h,069h,066h,067h,066h	; 8a83  zxxafij0.A.0ifgf
	defb 09ah,0a1h,067h,090h,078h,078h,060h,067h,068h,06bh,031h,006h,040h,050h,0a9h,0a5h	; 8a93  ..g.xx`ghk1.@P..
	defb 067h,030h,067h,066h,09ah,099h,07ch,078h,060h,061h,066h,069h,032h,002h,040h,09ah	; 8aa3  g0gf..|x`afi2.@.
	defb 051h,0b0h,0b0h,099h,067h,06ah,09ah,099h,088h,061h,060h,067h,034h,002h,030h,09ah	; 8ab3  Q...gj...a`g4.0.
	defb 053h,099h,06bh,030h,09ah,050h,099h,067h,030h,066h,034h,030h,066h,09ah,0b1h,0b1h	; 8ac3  S.k0.P.g0f40f...
	defb 0b1h,050h,0b0h,0b0h,099h,09ah,050h,099h,030h,067h,034h,030h,067h,066h,032h,0a6h	; 8ad3  .P....P.0g40gf2.
	defb 0aah,051h,0b0h,051h,0b0h,0a9h,0a5h,033h,031h,067h,0eeh,0e9h,0eah,0f6h,030h,0a6h	; 8ae3  .Q.Q...31g....0.
	defb 0aah,0b1h,0b1h,0b1h,052h,0a9h,0a5h,031h,032h,0efh,0ebh,0ebh,0f7h,035h,09ah,0b1h	; 8af3  ....R..12....5..
	defb 0b1h,051h,099h,030h,03fh,09ah,051h,099h,021h,033h,034h,039h,079h,000h,078h,0d0h	; 8b03  .Q.0?.Q.!349y.x.
	defb 0c1h,032h,066h,030h,006h,043h,008h,046h,0b6h,0e3h,0e4h,0e5h,0c7h,067h,06ah,006h	; 8b13  .2f0.C.F.....gj.
	defb 041h,009h,00bh,068h,00ch,00ah,044h,099h,0e6h,0e7h,0e8h,0cbh,068h,06bh,002h,008h	; 8b23  A..h..D.....hk..
	defb 001h,030h,066h,069h,066h,030h,002h,043h,09ah,0a9h,0ach,0ach,0a5h,069h,066h,086h	; 8b33  .0fif0.C.....if.
	defb 08eh,08eh,087h,067h,066h,067h,066h,030h,006h,042h,030h,0a6h,0adh,0adh,0aah,099h	; 8b43  ...gfgf0.B0.....
	defb 067h,08ch,052h,07bh,067h,030h,067h,030h,006h,042h,066h,068h,066h,068h,066h,09ah	; 8b53  g.R{g0g0.Bfhfhf.
	defb 0a9h,0a5h,088h,08fh,08fh,089h,030h,07ah,050h,07bh,002h,042h,067h,069h,067h,069h	; 8b63  ......0zP{.Bgigi
	defb 067h,068h,09ah,094h,0b0h,0b0h,0b0h,0a9h,0a5h,07ch,060h,050h,07bh,002h,041h,007h	; 8b73  gh.......|`P{.A.
	defb 007h,007h,007h,003h,069h,066h,0a6h,0adh,0adh,0adh,0aah,094h,099h,067h,092h,050h	; 8b83  ....if.......g.P
	defb 07bh,002h,040h,044h,003h,067h,0b7h,0bdh,0bdh,0c1h,030h,0b2h,0b3h,030h,092h,050h	; 8b93  {.@D.g....0..0.P
	defb 093h,030h,006h,044h,005h,066h,0b9h,0beh,0bah,0a4h,0a8h,094h,09bh,030h,092h,060h	; 8ba3  .0.D.f.......0.`
	defb 093h,068h,002h,044h,005h,067h,0a4h,0ach,0a8h,0b1h,0abh,0a7h,066h,030h,092h,061h	; 8bb3  .h.D.g......f0.a
	defb 093h,069h,030h,044h,001h,098h,094h,0abh,0adh,0a7h,066h,066h,067h,07ah,051h,085h	; 8bc3  .i0D......ffgzQ.
	defb 066h,030h,043h,005h,068h,0b2h,0b3h,030h,0c6h,066h,067h,067h,07ah,052h,081h,067h	; 8bd3  f0C.h..0.fggzR.g
	defb 030h,043h,001h,069h,0a2h,094h,099h,0cah,067h,031h,092h,051h,07dh,0c9h,066h,030h	; 8be3  0C.i....g1.Q}.f0
	defb 042h,001h,068h,066h,09eh,094h,094h,0a9h,0ach,0ach,0a5h,088h,08fh,089h,0cch,0cdh	; 8bf3  B.hf............
	defb 067h,030h,040h,009h,00bh,030h,069h,067h,068h,0a6h,0aah,0b1h,0b1h,0b1h,094h,0b0h	; 8c03  g0@..0igh.......
	defb 0a9h,0a5h,030h,068h,031h,00bh,033h,066h,069h,066h,030h,086h,08eh,087h,0a6h,0aah	; 8c13  ..0h1.3fif0.....
	defb 094h,094h,099h,069h,031h,034h,067h,068h,067h,07ah,051h,093h,030h,066h,09ah,094h	; 8c23  ...i14ghgzQ.0f..
	defb 0b3h,066h,031h,035h,069h,030h,092h,051h,07dh,068h,067h,030h,0b2h,0b3h,067h,031h	; 8c33  .f15i0.Q}hg0..g1
	defb 037h,07ch,050h,07dh,066h,069h,030h,098h,094h,09bh,032h,03ah,067h,0a4h,0a8h,094h	; 8c43  7|P}fi0...2:g...
	defb 09bh,033h,032h,0eeh,0e9h,0eah,0f6h,033h,098h,094h,0abh,0a7h,034h,032h,0efh,0ebh	; 8c53  .32....3....42..
	defb 0ebh,0f7h,031h,0a4h,0a8h,0abh,0a7h,036h,037h,098h,0abh,0a7h,038h,021h,034h,038h	; 8c63  ..1....67...8!48
	defb 038h,094h,079h,000h,03fh,033h,034h,0abh,0adh,0aah,030h,095h,034h,095h,033h,032h	; 8c73  8.y.?34...0.4.32
	defb 095h,0a3h,0ddh,0deh,0dfh,09ah,03ah,033h,0a1h,0e0h,0e1h,0e2h,066h,0a2h,031h,00eh	; 8c83  ......:3....f.1.
	defb 035h,095h,030h,095h,032h,0b0h,0b0h,0a9h,067h,09eh,031h,00fh,095h,035h,033h,00eh	; 8c93  5.0.2...g.1..53.
	defb 031h,0a3h,07ah,07bh,0a6h,0aah,034h,00eh,031h,031h,00eh,030h,00fh,095h,030h,0a1h	; 8ca3  1.z{..4.11.0..0.
	defb 07ch,078h,08bh,066h,0a6h,0aah,032h,00fh,031h,031h,00fh,095h,033h,09dh,084h,078h	; 8cb3  |x.f..2.11..3..x
	defb 061h,068h,066h,0a6h,0aah,033h,037h,0a1h,080h,078h,078h,063h,067h,041h,0a6h,0aah	; 8cc3  ahf..37..xxcgA..
	defb 0b1h,0abh,032h,0b1h,0b1h,0b1h,032h,099h,07ch,078h,078h,08bh,066h,066h,043h,0b1h	; 8cd3  ..2...2.|xx.ffC.
	defb 0abh,0a7h,066h,041h,0a6h,0aah,030h,095h,099h,088h,08ch,078h,061h,061h,066h,042h	; 8ce3  ..fA..0....xaafB
	defb 041h,066h,067h,068h,040h,066h,040h,09ah,031h,0a9h,0a5h,084h,078h,060h,067h,068h	; 8cf3  Afgh@f@.1...x`gh
	defb 041h,041h,067h,06ah,069h,066h,067h,066h,066h,09ah,0b1h,0abh,0a7h,082h,078h,061h	; 8d03  AAgjifgff.....xa
	defb 066h,069h,041h,041h,066h,06bh,068h,067h,066h,067h,067h,086h,08eh,08eh,08ah,078h	; 8d13  fiAAfkhgfgg....x
	defb 078h,060h,067h,068h,041h,041h,067h,066h,069h,068h,067h,07ah,078h,060h,078h,060h	; 8d23  x`ghAAgfihgzx`x`
	defb 078h,078h,060h,061h,066h,069h,041h,042h,067h,066h,069h,07ah,078h,060h,067h,066h	; 8d33  xx`afiABgfizx`gf
	defb 067h,078h,078h,061h,060h,067h,068h,041h,043h,067h,040h,07ch,060h,067h,066h,067h	; 8d43  gxxa`ghACg@|`gfg
	defb 07ah,078h,078h,078h,061h,066h,069h,041h,042h,066h,068h,041h,067h,066h,067h,040h	; 8d53  zxxxafiABfhAgfg@
	defb 07ch,078h,078h,060h,07dh,067h,042h,041h,066h,067h,069h,041h,066h,067h,042h,066h	; 8d63  |xx`}gBAfgiAfgBf
	defb 066h,067h,043h,004h,040h,066h,067h,043h,067h,043h,067h,067h,042h,004h,007h,050h	; 8d73  fgC.@fgCgCggB..P
	defb 040h,067h,04bh,004h,007h,007h,052h,041h,0eeh,0e9h,0eah,0f2h,00dh,042h,004h,007h	; 8d83  @gK...RA.....B..
	defb 007h,007h,055h,041h,0efh,0ebh,0ebh,0f3h,041h,004h,007h,059h,046h,004h,05bh,021h	; 8d93  ..UA....A..YF.[!
	defb 033h,035h,033h,094h,0b5h,079h,03fh,033h,03bh,095h,036h,038h,095h,039h,031h,095h	; 8da3  353..y?3;.68.91.
	defb 036h,0b1h,0b1h,034h,095h,031h,033h,00eh,032h,0abh,0a7h,0c0h,0d1h,0a6h,0aah,035h	; 8db3  6..4.13.2......5
	defb 033h,00fh,095h,030h,0a3h,0d9h,0d8h,0dah,0cbh,0f8h,0f9h,0a2h,034h,036h,0a1h,0dbh	; 8dc3  3..0........46..
	defb 0d7h,0dch,06ch,06eh,050h,0a0h,095h,033h,035h,096h,095h,09dh,06ch,06eh,06dh,06fh	; 8dd3  ..lnP..35...lnmo
	defb 098h,035h,035h,097h,030h,0a1h,06dh,06fh,050h,098h,095h,035h,032h,097h,031h,095h	; 8de3  .55.0.moP..52.1.
	defb 096h,095h,09dh,050h,0b7h,00eh,036h,034h,096h,030h,095h,030h,09fh,0b7h,040h,00fh	; 8df3  ...P..64.0.0..@.
	defb 00eh,035h,034h,097h,030h,097h,09bh,0b7h,041h,030h,00fh,095h,034h,030h,00eh,033h	; 8e03  .54.0...A0..40.3
	defb 097h,0a3h,050h,0bbh,041h,034h,00eh,031h,030h,00fh,032h,096h,030h,0afh,0b7h,042h	; 8e13  ..P.A4.10.2.0..B
	defb 034h,00fh,095h,030h,035h,097h,0afh,0bbh,042h,00eh,036h,033h,096h,097h,095h,0a1h	; 8e23  4..05...B.63....
	defb 0b9h,0beh,041h,00fh,031h,00eh,033h,035h,096h,030h,099h,06ch,0b9h,0beh,032h,00fh	; 8e33  ..A.1.35.0.l..2.
	defb 033h,034h,097h,030h,097h,0b3h,06dh,051h,09ah,036h,034h,096h,097h,095h,0a3h,0ech	; 8e43  34.0..mQ.64.....
	defb 0e9h,0eah,0f2h,09ah,035h,032h,00eh,032h,096h,0afh,0edh,0ebh,0ebh,0f3h,050h,0b2h	; 8e53  ....52.2......P.
	defb 034h,031h,095h,00fh,031h,096h,030h,0a1h,053h,098h,032h,095h,031h,036h,096h,030h	; 8e63  41..1.0.S.2.16.0
	defb 0a9h,0ach,0ach,0a8h,036h,03dh,095h,034h,03fh,033h,021h,031h,039h,039h,094h,079h	; 8e73  ....6=.4?3!199.y
	defb 000h,041h,066h,042h,066h,04ah,004h,007h,040h,066h,067h,041h,066h,067h,066h,045h	; 8e83  .AfBfJ..@fgAfgfE
	defb 004h,007h,007h,007h,051h,040h,067h,0ddh,0deh,0dfh,067h,066h,067h,066h,040h,068h	; 8e93  ....Q@g...gfgf@h
	defb 041h,004h,055h,066h,0c6h,0e0h,0e1h,0e2h,066h,067h,066h,067h,068h,069h,041h,006h	; 8ea3  A.Uf....fgfghiA.
	defb 055h,067h,0bbh,0bdh,0bdh,0c1h,067h,066h,067h,066h,069h,066h,040h,066h,006h,055h	; 8eb3  Ug....gfgfif@f.U
	defb 066h,0b9h,0beh,0bah,086h,08ah,061h,06ah,067h,068h,067h,066h,067h,006h,055h,067h	; 8ec3  f.....ajghgfg.Ug
	defb 068h,040h,066h,092h,078h,078h,065h,07bh,069h,040h,067h,040h,002h,055h,040h,069h	; 8ed3  h@f.xxe{i@g@.U@i
	defb 066h,067h,092h,078h,078h,078h,078h,078h,08bh,087h,0cch,0d1h,00ch,00ah,053h,041h	; 8ee3  fg.xxxxx......SA
	defb 067h,066h,07ch,060h,078h,078h,078h,078h,078h,060h,08bh,0cbh,066h,068h,002h,052h	; 8ef3  gf|`xxxxx`..fh.R
	defb 099h,040h,068h,067h,066h,067h,060h,060h,060h,078h,078h,061h,078h,08bh,067h,069h	; 8f03  .@hgfg```xxax.gi
	defb 040h,006h,051h,030h,099h,069h,040h,067h,066h,067h,067h,067h,0b7h,0bdh,0d1h,092h	; 8f13  @.Q0.i@gfggg....
	defb 078h,083h,066h,040h,006h,051h,031h,0b0h,0b0h,099h,067h,06ah,066h,0cch,0b5h,0b5h	; 8f23  x.f@.Q1...gjf...
	defb 0bch,092h,078h,093h,067h,040h,006h,051h,034h,099h,06bh,067h,066h,0b9h,0b5h,0bch	; 8f33  ..x.g@.Q4.kgf...
	defb 092h,078h,093h,066h,040h,002h,051h,032h,00eh,031h,099h,040h,067h,066h,0b9h,0bah	; 8f43  .x.f@.Q2.1.@gf..
	defb 092h,078h,062h,067h,066h,040h,00ch,00ah,032h,00fh,031h,095h,099h,040h,067h,066h	; 8f53  .xbgf@..2.1..@gf
	defb 07eh,078h,078h,063h,066h,067h,066h,041h,037h,099h,040h,067h,090h,078h,078h,064h	; 8f63  ~xxcfgfA7.@g.xxd
	defb 067h,066h,067h,041h,095h,036h,0b3h,040h,066h,090h,078h,078h,061h,066h,067h,042h	; 8f73  gfgA.6.@f.xxafgB
	defb 037h,0b3h,040h,067h,080h,078h,078h,078h,067h,066h,042h,035h,00eh,031h,09dh,066h	; 8f83  7.@g.xxxgfB5.1.f
	defb 040h,07ch,078h,07dh,040h,067h,066h,041h,0a6h,0adh,0adh,0aah,031h,00fh,095h,030h	; 8f93  @|x}@gfA....1..0
	defb 0a1h,067h,066h,044h,067h,041h,042h,066h,09ah,034h,099h,067h,043h,00dh,042h,040h	; 8fa3  .gfDgABf.4.gC.B@
	defb 068h,066h,067h,06ah,0a2h,033h,095h,099h,040h,0ech,0e9h,0eah,0f4h,041h,098h,040h	; 8fb3  hfgj.3..@....A.@
	defb 069h,067h,040h,067h,0a0h,034h,095h,099h,0edh,0ebh,0ebh,0f5h,040h,098h,030h,0a4h	; 8fc3  ig@g.4......@.0.
	defb 0ach,0ach,0ach,0a8h,037h,0a9h,0ach,0ach,0ach,0a8h,031h,021h,033h,037h,034h,079h	; 8fd3  ....7.....1!374y
	defb 000h,078h,034h,066h,066h,030h,066h,030h,066h,032h,004h,044h,003h,030h,0d0h,0cfh	; 8fe3  .x4ff0f0f2.D.0..
	defb 030h,067h,067h,066h,067h,066h,067h,068h,031h,006h,044h,005h,068h,0b6h,0ddh,0deh	; 8ff3  0ggfgfgh1.D.h...
	defb 0dfh,0c7h,067h,068h,067h,066h,069h,031h,006h,044h,005h,069h,0c8h,0e0h,0e1h,0e2h	; 9003  ..ghgfi1.D.i....
	defb 0cbh,066h,069h,066h,067h,068h,031h,006h,044h,040h,003h,0ceh,0cch,0c3h,066h,030h	; 9013  .fifgh1.D@....f0
	defb 067h,068h,067h,066h,069h,030h,004h,045h,041h,003h,030h,068h,067h,07ah,050h,063h	; 9023  ghgfi0.EA.0hgzPc
	defb 07bh,067h,031h,006h,045h,042h,003h,069h,068h,053h,07bh,066h,031h,002h,044h,042h	; 9033  {g1.EB.ihS{f1.DB
	defb 005h,06ah,069h,07ch,060h,052h,061h,066h,031h,002h,043h,042h,005h,06bh,068h,066h	; 9043  .ji|`Raf1.CB.khf
	defb 067h,088h,08ch,051h,061h,066h,031h,002h,042h,042h,005h,066h,069h,067h,066h,0cch	; 9053  g..Qaf1.BB.figf.
	defb 0d1h,07ch,050h,060h,061h,066h,031h,002h,041h,042h,005h,067h,066h,068h,067h,066h	; 9063  .|P`af1.AB.gfhgf
	defb 0ceh,0cfh,050h,061h,050h,061h,066h,031h,002h,040h,042h,001h,066h,067h,069h,066h	; 9073  ..PaPaf1.@B.fgif
	defb 067h,066h,07ah,053h,061h,066h,031h,006h,041h,001h,068h,067h,06ah,066h,067h,066h	; 9083  gfzSaf1.A.hgjfgf
	defb 067h,060h,053h,060h,067h,066h,030h,006h,040h,005h,030h,069h,068h,06bh,067h,066h	; 9093  g`S`gf0.@.0ihkgf
	defb 067h,066h,067h,060h,052h,061h,066h,067h,030h,002h,040h,005h,030h,068h,069h,066h	; 90a3  gfg`Rafg0.@.0hif
	defb 068h,067h,066h,067h,066h,061h,053h,067h,066h,031h,040h,005h,030h,069h,066h,067h	; 90b3  hgfgfaSgf1@.0ifg
	defb 069h,066h,067h,07ah,061h,053h,07dh,066h,067h,066h,030h,040h,005h,031h,067h,066h	; 90c3  ifgzaS}fgf0@.1gf
	defb 06ah,067h,08ah,054h,07dh,066h,067h,066h,067h,030h,040h,001h,032h,067h,06bh,07ch	; 90d3  jg.T}fgfg0@.2gk|
	defb 053h,08dh,089h,066h,067h,030h,067h,031h,005h,03ah,066h,066h,067h,066h,068h,032h	; 90e3  S..fg0g1.:ffgfh2
	defb 005h,039h,066h,067h,067h,066h,067h,069h,032h,001h,036h,00dh,031h,067h,068h,068h	; 90f3  .9fggfgi2.6.1ghh
	defb 067h,034h,032h,0eeh,0e9h,0eah,0f2h,031h,00dh,031h,069h,069h,035h,032h,0efh,0ebh	; 9103  g42....1.1ii52..
	defb 0ebh,0f3h,03ch,03fh,033h,021h,033h,036h,039h,079h,094h,000h,042h,0b1h,0b1h,0b1h	; 9113  ..<?3!369y..B...
	defb 0b1h,043h,099h,030h,066h,030h,0c2h,0c3h,030h,066h,030h,0b1h,0abh,0a7h,06ch,06eh	; 9123  .C.0f0..0f0...ln
	defb 031h,0a6h,0aah,042h,099h,067h,0e3h,0e4h,0e5h,066h,067h,030h,030h,0f8h,0f9h,06dh	; 9133  1..B.g...fg00..m
	defb 06fh,033h,0a6h,0aah,041h,099h,0e6h,0e7h,0e8h,067h,031h,0f8h,0f9h,031h,086h,08ah	; 9143  o3..A....g1..1..
	defb 078h,060h,07bh,031h,09ah,041h,0b0h,0b0h,0b0h,0b0h,0b0h,099h,030h,00dh,031h,092h	; 9153  x`{1.A......0.1.
	defb 078h,078h,061h,078h,07fh,031h,0a6h,0aah,045h,031h,00dh,030h,092h,078h,078h,078h	; 9163  xxax.1..E1.0.xxx
	defb 078h,081h,066h,030h,066h,030h,0a6h,0aah,043h,033h,060h,078h,078h,078h,093h,066h	; 9173  x.f0f0..C3`xxx.f
	defb 067h,066h,067h,068h,066h,06ah,0a6h,0aah,0b1h,040h,004h,007h,003h,030h,067h,060h	; 9183  gfghfj...@...0g`
	defb 078h,078h,078h,061h,066h,067h,066h,069h,067h,06bh,066h,031h,0a6h,052h,003h,030h	; 9193  xxxafgfigkf1.R.0
	defb 067h,060h,062h,078h,078h,061h,068h,067h,066h,068h,066h,067h,066h,031h,053h,003h	; 91a3  g`bxxahgfhfgf1S.
	defb 066h,067h,069h,060h,078h,078h,063h,066h,067h,069h,067h,068h,067h,066h,030h,053h	; 91b3  fgi`xxcfgighgf0S
	defb 005h,067h,068h,030h,067h,0b7h,0b8h,07ch,061h,066h,066h,068h,069h,068h,067h,030h	; 91c3  .gh0g..|affhihg0
	defb 053h,005h,066h,069h,066h,066h,0b9h,0beh,0b8h,092h,061h,067h,069h,030h,069h,031h	; 91d3  S.fiff....agi0i1
	defb 053h,005h,067h,066h,067h,067h,066h,068h,0b6h,092h,060h,0b7h,0bdh,0b8h,032h,051h	; 91e3  S.gfggfh..`...2Q
	defb 008h,008h,001h,030h,067h,068h,066h,067h,069h,066h,092h,061h,0b9h,0b5h,0bch,032h	; 91f3  ...0ghfgif.a...2
	defb 050h,001h,034h,069h,067h,066h,066h,067h,060h,078h,07bh,0b9h,0bah,032h,001h,031h	; 9203  P.4igffg`x{..2.1
	defb 098h,0b0h,0b0h,0b0h,099h,030h,067h,067h,066h,061h,078h,078h,066h,033h,032h,0b2h	; 9213  .....0ggfaxxf32.
	defb 043h,0b0h,0a9h,0a5h,067h,07ch,078h,07dh,067h,068h,066h,031h,031h,068h,0a6h,0aah	; 9223  C...g|x}ghf11h..
	defb 045h,0a9h,0a5h,032h,069h,067h,0a4h,0a8h,031h,069h,066h,068h,0a6h,0aah,0b1h,0b1h	; 9233  E..2ig..1ifh....
	defb 0b1h,042h,0b0h,0b0h,0b0h,0ach,0a8h,041h,031h,066h,067h,069h,032h,066h,0a6h,0aah	; 9243  .B.....A1fgi2f..
	defb 0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0abh,0a7h,031h,067h,033h,066h,067h,03ah,031h	; 9253  .........1g3fg:1
	defb 0eeh,0e9h,0eah,0f6h,066h,067h,038h,004h,007h,007h,031h,0efh,0ebh,0ebh,0f7h,067h	; 9263  ....fg8...1....g
	defb 037h,004h,007h,052h,03eh,006h,053h,021h,035h,030h,032h,094h,079h,000h,044h,068h	; 9273  7..R>.S!502.y.Dh
	defb 06ah,066h,042h,066h,040h,068h,002h,054h,041h,066h,041h,069h,06bh,067h,041h,066h	; 9283  jfBf@h.TAfAikgAf
	defb 067h,06ah,069h,068h,002h,053h,040h,068h,067h,066h,0c6h,0ddh,0deh,0dfh,0c7h,066h	; 9293  gjih.S@hgf.....f
	defb 067h,06ah,06bh,066h,069h,06ah,002h,052h,066h,069h,066h,067h,0cah,0e0h,0e1h,0e2h	; 92a3  gjkfij.Rfifg....
	defb 0cbh,067h,040h,06bh,066h,067h,066h,06bh,068h,002h,051h,067h,066h,067h,040h,066h	; 92b3  .g@kfgfkh.Qgfg@f
	defb 08ah,091h,0a4h,0a8h,0b0h,0a9h,0a5h,067h,040h,067h,040h,069h,040h,006h,050h,040h	; 92c3  .......g@g@i@.P@
	defb 067h,040h,07ah,061h,078h,081h,0b2h,033h,0b0h,0b0h,0a9h,0a5h,040h,066h,002h,050h	; 92d3  g@zax..3....@f.P
	defb 099h,041h,092h,078h,07dh,066h,0a6h,0aah,036h,099h,067h,06ah,002h,030h,09dh,040h	; 92e3  .A.x}f..6.gj.0.@
	defb 092h,093h,066h,067h,066h,040h,09ah,035h,0b3h,066h,06bh,040h,095h,0a1h,040h,092h	; 92f3  ..fgf@.5.fk@..@.
	defb 093h,067h,068h,067h,066h,066h,09ah,034h,09bh,067h,066h,040h,030h,0b3h,040h,092h	; 9303  .ghgff.4.gf@0.@.
	defb 093h,066h,069h,068h,067h,067h,068h,0a2h,031h,095h,0a3h,07ah,07bh,067h,068h,031h	; 9313  .fihggh.1..z{gh1
	defb 09dh,092h,093h,067h,068h,069h,066h,066h,067h,0aeh,032h,0a1h,092h,093h,066h,069h	; 9323  ...ghiffg.2...fi
	defb 030h,095h,0afh,092h,093h,066h,069h,066h,067h,067h,066h,0aeh,032h,0b3h,092h,062h	; 9333  0....fifggf.2..b
	defb 067h,068h,031h,0afh,084h,093h,067h,066h,067h,06ah,066h,067h,0aeh,031h,095h,0a3h	; 9343  gh1...gfgjfg.1..
	defb 092h,063h,066h,069h,031h,0a1h,090h,078h,07fh,067h,066h,06bh,067h,040h,09eh,032h	; 9353  .cfi1..x.gfkg@.2
	defb 09fh,092h,060h,067h,06ah,031h,0b3h,090h,078h,083h,040h,067h,066h,042h,09ah,0b1h	; 9363  ..`gj1..x.@gfB..
	defb 09bh,07ah,078h,061h,066h,06bh,031h,0b3h,080h,078h,078h,08bh,087h,067h,044h,07ah	; 9373  .zxafk1..xx..gDz
	defb 078h,078h,060h,067h,06ah,030h,00eh,030h,09dh,07ch,078h,078h,078h,08bh,087h,043h	; 9383  xx`gj0.0.|xxx..C
	defb 092h,078h,060h,061h,068h,06bh,030h,00fh,095h,0a1h,040h,07ch,078h,078h,078h,078h	; 9393  .x`ahk0...@|xxxx
	defb 07bh,042h,092h,078h,061h,068h,069h,040h,033h,099h,040h,088h,08ch,078h,078h,07dh	; 93a3  {B.xahi@3.@..xx}
	defb 042h,07ch,078h,060h,069h,066h,040h,034h,0a9h,0a5h,042h,066h,044h,067h,066h,067h	; 93b3  B|x`if@4..BfDgfg
	defb 040h,036h,0a9h,0a5h,040h,067h,066h,044h,067h,041h,033h,00eh,033h,099h,040h,067h	; 93c3  @6..@gfDgA3.3.@g
	defb 040h,00dh,0f0h,0e9h,0eah,0f4h,041h,033h,00fh,033h,095h,09dh,042h,0f1h,0ebh,0ebh	; 93d3  @.....A3.3..B...
	defb 0f5h,041h,039h,0a1h,048h,021h,033h,039h,030h,079h,000h,094h,034h,066h,031h,0a4h	; 93e3  .A9.H!390y..4f1.
	defb 0a8h,052h,09fh,031h,066h,068h,031h,033h,066h,067h,030h,098h,052h,095h,09bh,032h	; 93f3  .R.1fh13fg0.R..2
	defb 067h,069h,030h,066h,032h,068h,067h,030h,098h,095h,052h,09bh,034h,0f8h,0f9h,067h	; 9403  gi0f2hg0..R.4..g
	defb 032h,069h,030h,098h,053h,09bh,031h,06ch,06eh,030h,066h,031h,068h,032h,066h,09ch	; 9413  2i0.S.1ln0f1h2f.
	defb 095h,052h,09bh,032h,06dh,06fh,030h,067h,030h,00dh,069h,032h,067h,0a0h,052h,0a3h	; 9423  .R.2mo0g0.i2g.R.
	defb 030h,0c2h,0cch,0d1h,098h,0b0h,099h,031h,068h,030h,031h,066h,09ch,053h,09fh,0d9h	; 9433  0......1h01f.S..
	defb 0d8h,0dah,0cbh,0b2h,050h,0b3h,031h,069h,030h,031h,067h,0a0h,052h,0b3h,030h,0dbh	; 9443  ....P.1i01g.R.0.
	defb 0d7h,0dch,098h,051h,09bh,033h,030h,066h,030h,0b2h,053h,0a9h,0ach,0ach,0a8h,051h	; 9453  ...Q.30f0.S....Q
	defb 09bh,032h,004h,007h,030h,067h,066h,0b2h,054h,0b1h,0b1h,0b1h,0abh,0a7h,032h,004h	; 9463  .2..0gf.T.....2.
	defb 041h,031h,067h,09ah,053h,09bh,086h,08eh,066h,068h,030h,004h,007h,007h,042h,032h	; 9473  A1g.S...fh0...B2
	defb 068h,0a6h,0adh,0adh,0a7h,08ah,078h,062h,067h,069h,004h,045h,031h,068h,069h,066h	; 9483  h.....xbgi.E1hif
	defb 030h,086h,08ah,078h,060h,069h,030h,004h,046h,031h,069h,06ah,067h,07ah,078h,078h	; 9493  0..x`i0.F1ijgzxx
	defb 060h,067h,066h,004h,047h,031h,066h,06bh,030h,092h,078h,060h,067h,068h,067h,006h	; 94a3  `gf.G1fk0.x`ghg.
	defb 047h,030h,066h,067h,066h,030h,07ch,07dh,067h,066h,069h,066h,006h,047h,030h,067h	; 94b3  G0fgf0|}gfif.G0g
	defb 066h,067h,033h,067h,068h,067h,006h,047h,030h,066h,067h,066h,034h,069h,06ah,006h	; 94c3  fg3ghg.G0fgf4ij.
	defb 047h,030h,067h,068h,067h,030h,0eeh,0e9h,0eah,0f2h,066h,06bh,002h,047h,031h,069h	; 94d3  G0ghg0....fk.G1i
	defb 066h,030h,0efh,0ebh,0ebh,0f3h,067h,068h,030h,002h,046h,032h,067h,034h,066h,069h	; 94e3  f0....gh0.F2g4fi
	defb 031h,006h,045h,038h,067h,032h,006h,045h,03ch,002h,045h,03dh,006h,044h,021h,031h	; 94f3  1.E8g2.E<.E=.D!1
	defb 038h,036h,079h,094h,000h,057h,001h,03ah,055h,008h,001h,033h,068h,036h,00ah,008h	; 9503  86y..W.:U..3h6..
	defb 008h,008h,008h,001h,031h,068h,030h,068h,066h,069h,030h,066h,034h,034h,068h,0c2h	; 9513  ....1h0hfi0f44h.
	defb 0c3h,069h,066h,069h,067h,068h,066h,067h,030h,068h,032h,033h,066h,069h,0ddh,0deh	; 9523  .ifighfg0h23fi..
	defb 0dfh,067h,066h,06ah,069h,067h,031h,069h,0a4h,0a8h,0b0h,0b0h,0a9h,0a5h,030h,067h	; 9533  .gfjig1i......0g
	defb 066h,0e0h,0e1h,0e2h,066h,067h,06bh,0a4h,0ach,0a8h,0b0h,0b0h,042h,0b1h,0b1h,040h	; 9543  f...fgk.....B..@
	defb 0a9h,0a5h,067h,0c0h,0bdh,0c1h,067h,0a4h,0a8h,044h,096h,041h,031h,09ah,041h,0b0h	; 9553  ..g...g..D.A1.A.
	defb 0a9h,0ach,0ach,0a8h,049h,032h,09ah,0b1h,044h,095h,048h,007h,007h,003h,031h,09ah	; 9563  ....I2..D.H...1.
	defb 0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,046h,052h,003h,032h,068h,032h,068h,030h,0a6h	; 9573  .......FR.2h2h0.
	defb 0aah,044h,053h,007h,003h,030h,069h,066h,0c4h,0d1h,069h,066h,030h,066h,0a2h,043h	; 9583  .DS..0if..if0f.C
	defb 055h,007h,003h,067h,0cch,0cdh,066h,067h,068h,067h,0aeh,040h,095h,041h,056h,005h	; 9593  U..g..fghg.@.AV.
	defb 07eh,083h,066h,067h,066h,069h,06ah,0aeh,043h,056h,005h,090h,093h,067h,066h,067h	; 95a3  ~.fgfij.CV...gfg
	defb 066h,06bh,0aeh,043h,056h,001h,082h,093h,0c7h,067h,066h,067h,068h,0aeh,095h,042h	; 95b3  fk.CV....gfgh..B
	defb 055h,001h,07ah,078h,093h,0cbh,066h,067h,066h,069h,0a0h,043h,054h,001h,07ah,078h	; 95c3  U.zx..fgfi.CT.zx
	defb 078h,093h,030h,067h,068h,067h,030h,0b2h,043h,052h,009h,00bh,030h,092h,078h,078h	; 95d3  x.0ghg0.CR..0.xx
	defb 085h,030h,066h,069h,068h,09ch,043h,09bh,008h,009h,00bh,032h,060h,078h,078h,081h	; 95e3  .0fih.C....2`xx.
	defb 066h,067h,06ah,069h,0a0h,042h,09bh,030h,032h,066h,031h,067h,060h,07dh,066h,067h	; 95f3  fgji.B.02f1g`}fg
	defb 068h,06bh,09ch,040h,0abh,0adh,0a7h,031h,032h,067h,031h,066h,067h,066h,067h,068h	; 9603  hk.@...12g1fgfgh
	defb 069h,030h,0a0h,0a3h,0f0h,0e9h,0eah,0f4h,030h,035h,067h,030h,067h,030h,069h,030h	; 9613  i0......05g0g0i0
	defb 098h,040h,09fh,0f1h,0ebh,0ebh,0f5h,030h,039h,0a4h,0a8h,040h,0a3h,035h,021h,033h	; 9623  .@.....09..@.5!3
	defb 031h,033h,000h,079h,0adh,043h,068h,06ah,066h,040h,0a4h,0ach,0ach,0ach,0ach,0a5h	; 9633  13.y.Chjf@......
	defb 044h,098h,040h,0d0h,0c1h,040h,069h,06bh,067h,098h,0abh,053h,0aah,0a9h,0a5h,041h	; 9643  D.@..@ikg..S...A
	defb 098h,094h,066h,0cah,0ddh,0deh,0dfh,066h,09ch,0a3h,040h,066h,040h,068h,040h,066h	; 9653  ..f....f..@f@h@f
	defb 0a6h,0aah,0b0h,0b0h,094h,09bh,067h,068h,0e0h,0e1h,0e2h,067h,0a0h,09fh,066h,067h	; 9663  ......gh...g..fg
	defb 068h,069h,068h,067h,066h,040h,0a6h,050h,0a7h,040h,068h,069h,0cch,0c3h,0a4h,0a8h	; 9673  hihgf@.P.@hi....
	defb 09bh,040h,067h,040h,069h,066h,067h,040h,067h,040h,066h,041h,004h,069h,066h,040h	; 9683  .@g@ifg@g@fA.if@
	defb 098h,0abh,0a7h,044h,067h,066h,086h,08eh,087h,067h,066h,004h,030h,068h,067h,09ch	; 9693  ...Dgf...gf.0hg.
	defb 0a3h,066h,040h,004h,007h,007h,007h,003h,040h,067h,092h,078h,078h,07fh,067h,006h	; 96a3  .f@.....@g.xx.g.
	defb 030h,069h,040h,0a0h,09fh,067h,040h,006h,033h,003h,040h,092h,078h,078h,083h,004h	; 96b3  0i@..g@.3.@.xx..
	defb 031h,0a4h,0a8h,09bh,06ah,040h,004h,035h,003h,07ch,078h,078h,093h,006h,031h,094h	; 96c3  1...j@.5.|xx..1.
	defb 09bh,066h,06bh,040h,006h,035h,005h,040h,07ch,078h,093h,006h,031h,09bh,040h,067h	; 96d3  .fk@.5.@|x..1.@g
	defb 041h,006h,035h,005h,040h,0c6h,092h,093h,006h,031h,044h,006h,034h,008h,001h,066h	; 96e3  A.5.@....1D.4..f
	defb 0cah,092h,093h,002h,031h,043h,004h,034h,005h,040h,066h,067h,066h,092h,093h,066h	; 96f3  ....1C.4.@fgf..f
	defb 00ch,00ah,042h,004h,035h,001h,066h,067h,066h,067h,060h,093h,067h,068h,040h,041h	; 9703  ..B.5.fgfg`.gh@A
	defb 004h,035h,005h,06ah,067h,068h,067h,066h,061h,078h,07bh,069h,066h,004h,007h,036h	; 9713  .5.jghgfax{if..6
	defb 005h,06bh,066h,069h,068h,067h,092h,078h,093h,066h,067h,038h,005h,040h,067h,066h	; 9723  .kfihg.x.fg8.@gf
	defb 069h,066h,092h,078h,060h,067h,066h,038h,005h,041h,067h,066h,067h,092h,060h,061h	; 9733  if.x`gf8.Agfg.`a
	defb 068h,067h,039h,003h,041h,067h,040h,08ch,061h,066h,069h,040h,039h,005h,044h,066h	; 9743  hg9.Ag@.afi@9.Df
	defb 067h,041h,039h,005h,040h,00dh,042h,067h,042h,039h,001h,041h,0eeh,0e9h,0eah,0f2h	; 9753  gA9.@.BgB9.A....
	defb 042h,038h,005h,042h,0efh,0ebh,0ebh,0f3h,042h,038h,001h,049h,021h,034h,030h,035h	; 9763  B8.B....B8.I!405
	defb 079h,094h,000h,047h,0b1h,0b1h,045h,09bh,030h,0c0h,0d1h,045h,0abh,0a7h,031h,0a6h	; 9773  y..G..E.0..E..1.
	defb 0adh,0aah,0b1h,0abh,0a7h,0e3h,0e4h,0e5h,0cbh,040h,095h,042h,0a3h,07ah,078h,08bh	; 9783  .........@.B.zx.
	defb 087h,066h,0c0h,0d1h,030h,066h,068h,0e6h,0e7h,0e8h,030h,044h,0a1h,07ch,078h,078h	; 9793  .f..0fh...0D.|xx
	defb 078h,061h,07bh,0cbh,066h,067h,069h,030h,0c0h,0c1h,004h,045h,099h,07ch,078h,078h	; 97a3  xa{.fgi0...E.|xx
	defb 078h,060h,030h,067h,004h,007h,007h,007h,007h,050h,046h,099h,07ch,078h,060h,067h	; 97b3  x`0g.....PF.|x`g
	defb 066h,068h,006h,054h,041h,00eh,043h,09bh,030h,068h,067h,068h,067h,069h,006h,054h	; 97c3  fh.TA.C.0hghgi.T
	defb 041h,00fh,095h,041h,0b3h,030h,066h,069h,066h,069h,066h,004h,055h,045h,0b3h,030h	; 97d3  A..A.0fifif.UE.0
	defb 067h,068h,067h,066h,067h,006h,055h,042h,0b1h,042h,099h,066h,069h,066h,067h,004h	; 97e3  ghgfg.UB.B.fifg.
	defb 056h,040h,0abh,0a7h,066h,09ah,041h,0b3h,067h,066h,067h,004h,057h,0a3h,08ah,078h	; 97f3  V@..f.A.gfg.W..x
	defb 061h,08bh,09ah,0b1h,09bh,030h,067h,068h,006h,056h,001h,0a1h,08ch,078h,078h,078h	; 9803  a....0gh.V...xxx
	defb 08bh,066h,031h,066h,069h,006h,055h,005h,030h,040h,099h,088h,08fh,08ch,078h,061h	; 9813  .f1fi.U.0@....xa
	defb 08bh,030h,067h,068h,002h,055h,001h,030h,041h,0b0h,0a9h,0a5h,088h,08ch,08dh,031h	; 9823  .0gh.U.0A......1
	defb 069h,066h,00ch,00ah,008h,008h,009h,00bh,031h,040h,095h,042h,0a9h,0a5h,032h,068h	; 9833  if......1@.B..2h
	defb 067h,066h,066h,035h,044h,0abh,0aah,099h,031h,069h,066h,067h,067h,035h,041h,0b1h	; 9843  gff5D...1ifgg5A.
	defb 0abh,0a7h,066h,030h,09ah,099h,031h,067h,031h,0a4h,0a8h,0b0h,0a9h,0a5h,030h,0adh	; 9853  ..f0..1g1.....0.
	defb 0a7h,031h,068h,067h,031h,09ah,0a9h,0ach,0ach,0ach,0a8h,040h,0b1h,0b1h,041h,099h	; 9863  .1hg1......@..A.
	defb 030h,0f8h,0f9h,030h,069h,068h,031h,066h,0a6h,0adh,0adh,0adh,0adh,0a7h,031h,0a6h	; 9873  0..0ih1f......1.
	defb 0aah,040h,030h,00dh,031h,066h,069h,031h,067h,066h,038h,09ah,031h,00dh,030h,067h	; 9883  .@0.1fi1gf8.1.0g
	defb 0ech,0e9h,0eah,0f2h,067h,039h,034h,0edh,0ebh,0ebh,0f3h,03ah,03fh,033h,021h,034h	; 9893  ....g94....:?3!4
	defb 034h,035h,000h,094h,079h,034h,001h,050h,066h,068h,056h,004h,007h,007h,030h,033h	; 98a3  45..y4.PfhV...03
	defb 005h,050h,066h,067h,069h,068h,066h,050h,004h,007h,007h,007h,033h,033h,001h,050h	; 98b3  .PfgihfP....33.P
	defb 067h,051h,069h,067h,050h,006h,036h,032h,001h,09ch,0b0h,09dh,0d9h,0d8h,0dah,0c7h	; 98c3  gQigP.62........
	defb 068h,006h,036h,031h,001h,050h,0a0h,040h,0a1h,0dbh,0d7h,0dch,0cbh,069h,006h,036h	; 98d3  h.61.P.@.....i.6
	defb 009h,00bh,066h,09ch,040h,095h,040h,09dh,066h,08eh,08eh,087h,00ch,00ah,035h,050h	; 98e3  ..f.@.@.f.....5P
	defb 066h,067h,0a0h,042h,0a1h,067h,092h,078h,060h,051h,006h,034h,068h,067h,068h,0b2h	; 98f3  fg.B.g.x`Q.4hgh.
	defb 042h,095h,099h,084h,078h,061h,066h,050h,006h,034h,069h,06ah,069h,0b2h,044h,099h	; 9903  B...xafP.4iji.D.
	defb 078h,093h,067h,066h,002h,034h,068h,06bh,068h,0b2h,043h,095h,0b3h,060h,093h,066h	; 9913  x.gf.4hkh.C..`.f
	defb 067h,050h,006h,033h,069h,066h,069h,0b2h,044h,0b3h,069h,060h,067h,051h,006h,033h	; 9923  gP.3ifi.D.i`gQ.3
	defb 066h,067h,066h,0a2h,045h,09dh,067h,068h,050h,004h,034h,067h,066h,067h,09eh,045h	; 9933  fgf.E.ghP.4gfg.E
	defb 0a1h,050h,069h,050h,006h,034h,066h,067h,068h,066h,09ah,045h,099h,051h,006h,034h	; 9943  .PiP.4fghf.E.Q.4
	defb 067h,050h,069h,067h,066h,09ah,045h,099h,050h,002h,034h,050h,066h,050h,066h,067h	; 9953  gPigf.E.P.4PfPfg
	defb 066h,0a6h,0adh,0adh,0adh,0aah,041h,09dh,050h,002h,033h,050h,067h,066h,067h,068h	; 9963  f.....A.P.3Pgfgh
	defb 067h,06ah,053h,09ah,040h,0a1h,066h,050h,00ch,00ah,031h,051h,067h,050h,069h,066h	; 9973  gjS.@.fP..1QgPif
	defb 06bh,0ech,0e9h,0eah,0f2h,050h,0a2h,0b3h,067h,052h,00ch,00ah,054h,067h,050h,0edh	; 9983  k....P..gR..TgP.
	defb 0ebh,0ebh,0f3h,050h,0a0h,0b3h,050h,066h,053h,058h,0a4h,0ach,0a8h,041h,09dh,067h	; 9993  ...P..PfSX...A.g
	defb 053h,051h,098h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,043h,095h,0a1h,054h,0a4h,0a8h,04ch	; 99a3  SQ.......C..T..L
	defb 099h,053h,045h,095h,047h,095h,099h,052h,04fh,0b3h,052h,021h,032h,031h,035h,079h	; 99b3  .SE.G..RO.R!215y
	defb 000h,094h,034h,098h,050h,09bh,066h,068h,031h,0a6h,0aah,055h,032h,066h,09ch,050h	; 99c3  ..4.P.fh1..U2f.P
	defb 09bh,068h,067h,069h,06ah,068h,031h,0a6h,0aah,053h,032h,067h,0a0h,0a3h,030h,069h	; 99d3  .hgijh1..S2g..0i
	defb 0d0h,0c1h,06bh,069h,066h,032h,0a6h,0adh,0adh,0a7h,031h,068h,09ch,050h,0a1h,030h	; 99e3  ..kif2....1h.P.0
	defb 066h,0bch,0ddh,0deh,0dfh,067h,066h,030h,06ch,06eh,0f8h,0f9h,030h,003h,030h,069h	; 99f3  f....gf0ln..0.0i
	defb 0a0h,095h,050h,099h,067h,0b6h,0e0h,0e1h,0e2h,066h,067h,030h,06dh,06fh,032h,040h	; 9a03  ..P.g....fg0mo2@
	defb 003h,030h,0a2h,052h,0a9h,0a5h,030h,0cch,0c1h,067h,036h,040h,005h,030h,09eh,095h	; 9a13  .0.R..0..g6@.0..
	defb 053h,099h,032h,004h,007h,007h,003h,032h,040h,005h,030h,068h,09ah,053h,09bh,030h	; 9a23  S.2....2@.0h.S.0
	defb 004h,007h,043h,007h,007h,003h,041h,003h,069h,066h,0a6h,0aah,0b1h,09bh,030h,004h	; 9a33  ..C...A.if....0.
	defb 048h,041h,005h,030h,061h,078h,08bh,066h,068h,004h,049h,041h,005h,07eh,078h,078h	; 9a43  HA.0ax.fh.IA.~xx
	defb 093h,067h,069h,006h,049h,041h,005h,090h,078h,078h,093h,066h,004h,04ah,041h,005h	; 9a53  .gi.IA..xx.f.JA.
	defb 090h,078h,078h,060h,067h,006h,04ah,041h,005h,066h,08ch,078h,061h,004h,044h,008h	; 9a63  .xx`g.JA.f.xa.D.
	defb 008h,008h,008h,042h,041h,001h,067h,0c6h,078h,078h,006h,042h,008h,001h,066h,030h	; 9a73  ...BA.g.xx.B..f0
	defb 066h,068h,002h,041h,009h,00bh,030h,066h,0cah,078h,078h,002h,008h,008h,001h,066h	; 9a83  fh.A..0f.xx....f
	defb 068h,067h,066h,067h,069h,066h,00ch,00ah,031h,068h,067h,066h,092h,078h,08bh,087h	; 9a93  hgfgif..1hgf.x..
	defb 030h,068h,067h,069h,066h,067h,068h,066h,067h,031h,031h,069h,066h,067h,060h,078h	; 9aa3  0hgifghfg11ifg`x
	defb 078h,078h,07bh,069h,031h,067h,030h,069h,067h,032h,031h,068h,067h,068h,067h,062h	; 9ab3  xx{i1g0ig21hghgb
	defb 078h,078h,093h,036h,066h,031h,031h,069h,06ah,069h,066h,067h,062h,078h,07dh,036h	; 9ac3  xx.6f11ijifgbx}6
	defb 067h,031h,007h,003h,030h,06bh,030h,067h,068h,069h,035h,0f0h,0e9h,0eah,0f4h,031h	; 9ad3  g1..0k0ghi5....1
	defb 041h,007h,007h,003h,030h,069h,035h,00dh,0f1h,0ebh,0ebh,0f5h,031h,044h,003h,035h	; 9ae3  A...0i5.....1D.5
	defb 00dh,036h,044h,005h,03ch,004h,021h,033h,037h,032h,094h,079h,000h,038h,09bh,049h	; 9af3  .6D.<.!372.y.8.I
	defb 036h,095h,0b3h,040h,0d0h,0d1h,043h,004h,007h,007h,007h,030h,00eh,030h,095h,033h	; 9b03  6..@..C....0.0.3
	defb 09bh,040h,0cah,0ddh,0deh,0dfh,040h,004h,053h,030h,00fh,032h,0b1h,0b1h,09bh,041h	; 9b13  .@....@.S0.2...A
	defb 0c8h,0e0h,0e1h,0e2h,0c9h,006h,053h,033h,09bh,066h,040h,086h,08ah,078h,0ceh,0cfh	; 9b23  ......S3.f@..x..
	defb 066h,0cch,0cdh,006h,053h,031h,095h,09bh,040h,067h,07ah,078h,078h,07dh,066h,068h	; 9b33  f...S1..@gzxx}fh
	defb 067h,040h,004h,054h,031h,0b3h,041h,07ah,078h,078h,07dh,040h,067h,069h,004h,007h	; 9b43  g@.T1.Azxx}@gi..
	defb 055h,031h,09bh,040h,066h,092h,078h,091h,004h,007h,007h,007h,057h,030h,09bh,040h	; 9b53  U1.@f.x.....W0.@
	defb 066h,067h,092h,078h,081h,006h,05ah,09bh,040h,068h,067h,066h,060h,093h,066h,002h	; 9b63  fg.x..Z.@hgf`.f.
	defb 058h,008h,008h,040h,066h,069h,066h,067h,061h,093h,067h,066h,002h,052h,008h,008h	; 9b73  X..@fifga.gf.R..
	defb 008h,009h,00bh,041h,040h,067h,068h,067h,066h,060h,093h,066h,067h,066h,002h,008h	; 9b83  ...A@ghgf`.fgf..
	defb 001h,046h,041h,069h,068h,067h,061h,093h,067h,066h,067h,066h,040h,066h,046h,041h	; 9b93  .FAihga.gfgf@fFA
	defb 066h,069h,066h,092h,093h,066h,067h,066h,067h,066h,067h,043h,0a4h,0a8h,0b0h,040h	; 9ba3  fif..fgfgfgC...@
	defb 068h,067h,068h,067h,092h,093h,067h,068h,067h,040h,067h,040h,0a4h,0a8h,0b0h,0b0h	; 9bb3  hghg..ghg@g@....
	defb 032h,040h,069h,06ah,069h,066h,092h,060h,066h,069h,040h,0a4h,0a8h,0b0h,034h,095h	; 9bc3  2@ijif.`fi@...4.
	defb 030h,041h,06bh,068h,067h,092h,061h,067h,040h,098h,095h,031h,095h,035h,041h,066h	; 9bd3  0Akhg.ag@..1.5Af
	defb 069h,060h,078h,085h,066h,09ch,03ah,041h,067h,040h,061h,07dh,040h,067h,0aeh,095h	; 9be3  i`x.f.:Ag@a}@g..
	defb 039h,045h,066h,040h,0aeh,03ah,045h,067h,040h,0a0h,034h,00eh,034h,041h,0eeh,0e9h	; 9bf3  9Ef@.:Eg@.4.4A..
	defb 0eah,0f2h,040h,098h,095h,034h,00fh,095h,033h,041h,0efh,0ebh,0ebh,0f3h,09ch,03ch	; 9c03  ..@..4..3A.....<
	defb 045h,0a0h,030h,0abh,0adh,0adh,0aah,037h,021h,033h,034h,030h,094h,079h,000h,041h	; 9c13  E.0....7!340.y.A
	defb 0c2h,0c3h,041h,0a2h,0a1h,042h,002h,057h,0c6h,0e3h,0e4h,0e5h,066h,040h,0a0h,0a3h	; 9c23  ..A..B.W....f@..
	defb 041h,068h,040h,002h,008h,055h,0cah,0e6h,0e7h,0e8h,067h,098h,030h,09fh,040h,066h	; 9c33  Ah@..U....g.0.@f
	defb 069h,066h,040h,068h,002h,054h,040h,0c0h,0c3h,066h,09ch,030h,09bh,066h,040h,067h	; 9c43  if@h.T@..f.0.f@g
	defb 066h,067h,066h,069h,066h,006h,053h,042h,067h,0a0h,09bh,08ah,061h,08bh,087h,067h	; 9c53  fgfif.SBg...a..g
	defb 068h,067h,068h,067h,002h,053h,041h,0a4h,0a8h,09bh,066h,07ch,060h,078h,078h,07bh	; 9c63  hghg.SA...f|`xx{
	defb 069h,066h,069h,068h,040h,002h,052h,040h,098h,030h,09bh,040h,067h,066h,069h,060h	; 9c73  ifih@.R@.0.@gfi`
	defb 078h,078h,07bh,067h,066h,069h,068h,040h,00ch,00ah,008h,09ch,030h,09bh,041h,068h	; 9c83  xx{gfih@....0.Ah
	defb 067h,066h,067h,07ch,078h,078h,07bh,067h,040h,069h,043h,0aeh,0b3h,042h,069h,068h	; 9c93  gfg|xx{g@iC..Bih
	defb 067h,066h,066h,07ch,062h,0cch,0bdh,0bdh,0bfh,0b8h,042h,09eh,030h,099h,042h,069h	; 9ca3  gff|b.....B.0.Bi
	defb 068h,067h,067h,066h,061h,066h,0b9h,0beh,0beh,0bah,082h,083h,040h,040h,09ah,030h	; 9cb3  hggfaf......@@.0
	defb 0a9h,0a5h,041h,069h,041h,067h,066h,069h,066h,08ah,078h,060h,078h,093h,040h,041h	; 9cc3  ..AiAgfif.x`x.@A
	defb 0a6h,0aah,030h,0a9h,0ach,0ach,0ach,0ach,0a5h,067h,066h,067h,062h,078h,061h,078h	; 9cd3  ..0......gfgbxax
	defb 085h,040h,043h,0a6h,0adh,0adh,0adh,0adh,0aah,030h,09dh,067h,066h,063h,060h,078h	; 9ce3  .@C......0.gfc`x
	defb 078h,081h,0a4h,042h,0f8h,0f9h,040h,066h,041h,068h,0a2h,0a1h,040h,067h,062h,061h	; 9cf3  x..B..@fAh..@gba
	defb 078h,07dh,098h,030h,040h,0f8h,0f9h,042h,067h,068h,066h,069h,0a0h,0b3h,040h,066h	; 9d03  x}.0@..Bghfi..@f
	defb 063h,078h,07dh,098h,095h,030h,041h,0f8h,0f9h,042h,069h,067h,098h,095h,030h,09dh	; 9d13  cx}..0A..Big..0.
	defb 067h,041h,098h,032h,0a9h,0a5h,044h,0a4h,0a8h,032h,0afh,041h,09ch,033h,030h,00eh	; 9d23  gA.2..D..2.A.30.
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,034h,0a1h,041h,09eh,033h,030h,00fh,039h,0b3h,042h,0a6h	; 9d33  .....4.A.30.9.B.
	defb 0aah,0b1h,0b1h,03bh,0b3h,046h,095h,03ah,0a3h,046h,033h,00eh,032h,095h,032h,09fh	; 9d43  ...;.F.:.F3.2.2.
	defb 040h,00dh,0f0h,0e9h,0eah,0f4h,040h,032h,095h,00fh,035h,09bh,042h,0f1h,0ebh,0ebh	; 9d53  @.....@2..5.B...
	defb 0f5h,040h,039h,09bh,048h,021h,034h,033h,034h	; 9d63  .@9.H!434

; ----------------------------------------------------------------------
; DATOS guion_del_green: El guion del GREEN, el mismo para los treinta y seis
;   hoyos: 0x6F4F lo elige cuando (0xC011) dice que se juega la vista corta, y
;   se monta en 0xCCE0 en vez de en 0xCB00
;   0x9d6c..0x9ddd  (113 bytes)
DATA_guion_del_green:
	defb 0d8h,079h,0ffh,04fh,043h,04fh,043h,043h,010h,011h,036h,012h,013h,044h,042h,0fah	; 9d6c  .y.OCOCC..6..DB.
	defb 03ah,0fbh,043h,041h,0fah,03ch,0fbh,042h,040h,018h,03eh,019h,041h,040h,01ch,03eh	; 9d7c  :.CA.<.B@.>.A@.>
	defb 01dh,041h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h	; 9d8c  .A.?0P@.?0P@.?0P
	defb 040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h	; 9d9c  @.?0P@.?0P@.?0P@
	defb 0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h,040h	; 9dac  .?0P@.?0P@.?0P@@
	defb 01eh,03eh,01fh,041h,040h,01ah,03eh,01bh,041h,041h,0fch,03ch,0fdh,042h,042h,0fch	; 9dbc  .>.A@.>.AA.<.BB.
	defb 03ah,0fdh,043h,043h,014h,015h,036h,016h,017h,044h,04fh,043h,04fh,043h,04fh,043h	; 9dcc  :.CC..6..DOCOCOC
	defb 021h	; 9ddc

; ======================================================================
; CODIGO 0x9ddd..0x9ec0  (227 bytes)
; ======================================================================


L_9DDD:
	ld hl,01b1ch		;9ddd
	ld a,0d1h		;9de0
	call L_6893		;9de2
	inc hl			;9de5
	inc hl			;9de6
	inc hl			;9de7
	call 0004dh		;9de8   ; BIOS WRTVRM - Writes data in VRAM
	ld a,094h		;9deb
	ld (0ced2h),a		;9ded
	call L_9E20		;9df0
	ld de,0a7d2h		;9df3
	ld hl,01168h		;9df6
	ld bc,01300h		;9df9
	call L_6AFA		;9dfc
	ld de,0a90ch		;9dff
	ld hl,03168h		;9e02
	ld bc,03300h		;9e05
	jp L_6ABD		;9e08
L_9E0B:
	xor a			;9e0b
	ld (0ced2h),a		;9e0c
	ld a,020h		;9e0f
	call L_9E20		;9e11
	ld hl,01000h		;9e14
	call L_6AF2		;9e17
	ld hl,03000h		;9e1a
	jp L_6AB5		;9e1d
L_9E20:
	ld c,a			;9e20
	ld hl,01a21h		;9e21
	ld de,00020h		;9e24
	ld b,007h		;9e27
L_9E29:
	push bc			;9e29
	push hl			;9e2a
	ld a,c			;9e2b
	ld bc,00009h		;9e2c
	call 00056h		;9e2f   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;9e32
	add hl,de			;9e33
	pop bc			;9e34
	djnz L_9E29		;9e35
	ret			;9e37
L_9E38:
	call L_9DDD		;9e38
	call L_629C		;9e3b
	ld a,(0c011h)		;9e3e
	and a			;9e41
	jr nz,L_9E5F		;9e42
	ld a,(0c638h)		;9e44
	and a			;9e47
	jr nz,L_9E5F		;9e48
	ld hl,01a83h		;9e4a
	ld de,00020h		;9e4d
	ld a,05dh		;9e50
	call 0004dh		;9e52   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;9e55
	inc a			;9e56
	call 0004dh		;9e57   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;9e5a
	inc a			;9e5b
	call 0004dh		;9e5c   ; BIOS WRTVRM - Writes data in VRAM
L_9E5F:
	ld c,078h		;9e5f
	ld a,(0c639h)		;9e61
	and a			;9e64
	jr z,L_9E69		;9e65
	ld c,079h		;9e67
L_9E69:
	ld a,(0c638h)		;9e69
	and a			;9e6c
	jr z,L_9E71		;9e6d
	ld c,0b5h		;9e6f
L_9E71:
	ld a,(0c011h)		;9e71
	and a			;9e74
	jr z,L_9E79		;9e75
	ld c,0d8h		;9e77
L_9E79:
	ld a,c			;9e79
	ld hl,01ae1h		;9e7a
	ld bc,00009h		;9e7d
	call 00056h		;9e80   ; BIOS FILVRM - Fills VRAM with value
	ld hl,09eefh		;9e83
	ld a,(0c621h)		;9e86
	cp 00dh		;9e89
	jr nc,L_9EA5		;9e8b
	ld hl,09ee4h		;9e8d
	cp 00bh		;9e90
	jr nc,L_9EA5		;9e92
	ld a,(0c61dh)		;9e94
	cp 088h		;9e97
	jr c,L_9EA5		;9e99
	ld hl,09ed3h		;9e9b
	cp 0e8h		;9e9e
	jr c,L_9EA5		;9ea0
	ld hl,09ec0h		;9ea2
L_9EA5:
	push hl			;9ea5
	ld a,(hl)			;9ea6
	call L_9EF4		;9ea7
	pop hl			;9eaa
	push hl			;9eab
	ld a,(hl)			;9eac
	cp 003h		;9ead
	ld a,005h		;9eaf
	call z,L_6B2D		;9eb1
	pop hl			;9eb4
	inc hl			;9eb5
	ld b,(hl)			;9eb6
	inc hl			;9eb7
	call L_6698		;9eb8
	ld a,(hl)			;9ebb
	inc a			;9ebc
	jr nz,L_9EA5		;9ebd
	ret			;9ebf

; ----------------------------------------------------------------------
; DATOS guion_del_swing_lento: Pares (dibujo, cuadros) terminados en 0xFF: el
;   swing entero, nueve tiempos
;   0x9ec0..0x9ed3  (19 bytes)
DATA_guion_del_swing_lento:
	defb 002h,008h	; 9ec0
	defb 001h,00ch	; 9ec2
	defb 000h,011h	; 9ec4
	defb 001h,005h	; 9ec6
	defb 002h,002h	; 9ec8
	defb 003h,002h	; 9eca
	defb 004h,003h	; 9ecc
	defb 005h,005h	; 9ece
	defb 006h,001h	; 9ed0
	defb 0ffh	; 9ed2

; ----------------------------------------------------------------------
; DATOS guion_del_swing_medio: Ocho tiempos
;   0x9ed3..0x9ee4  (17 bytes)
DATA_guion_del_swing_medio:
	defb 002h,008h	; 9ed3
	defb 001h,00ch	; 9ed5
	defb 000h,011h	; 9ed7
	defb 001h,006h	; 9ed9
	defb 002h,003h	; 9edb
	defb 003h,003h	; 9edd
	defb 004h,005h	; 9edf
	defb 005h,001h	; 9ee1
	defb 0ffh	; 9ee3

; ----------------------------------------------------------------------
; DATOS guion_del_swing_corto: Cinco tiempos
;   0x9ee4..0x9eef  (11 bytes)
DATA_guion_del_swing_corto:
	defb 002h,008h	; 9ee4
	defb 001h,00fh	; 9ee6
	defb 002h,004h	; 9ee8
	defb 003h,005h	; 9eea
	defb 004h,001h	; 9eec
	defb 0ffh	; 9eee

; ----------------------------------------------------------------------
; DATOS guion_del_putt: Dos tiempos: el golpe del putter
;   0x9eef..0x9ef4  (5 bytes)
DATA_guion_del_putt:
	defb 002h,018h	; 9eef
	defb 003h,001h	; 9ef1
	defb 0ffh	; 9ef3

; ======================================================================
; CODIGO 0x9ef4..0x9f21  (45 bytes)
; ======================================================================


L_9EF4:
	ld hl,09f21h		;9ef4
	ld e,a			;9ef7
	ld d,000h		;9ef8
	add hl,de			;9efa
	ld e,(hl)			;9efb
	add hl,de			;9efc
	ex de,hl			;9efd
	ld hl,01a45h		;9efe
	ld b,005h		;9f01
L_9F03:
	ld c,004h		;9f03
	ld a,(de)			;9f05
	inc de			;9f06
L_9F07:
	rra			;9f07
	push af			;9f08
	jr nc,L_9F0F		;9f09
	ld a,094h		;9f0b
	jr L_9F11		;9f0d
L_9F0F:
	ld a,(de)			;9f0f
	inc de			;9f10
L_9F11:
	call L_6893		;9f11
	pop af			;9f14
	dec c			;9f15
	jr nz,L_9F07		;9f16
	push de			;9f18
	ld de,0001ch		;9f19
	add hl,de			;9f1c
	pop de			;9f1d
	djnz L_9F03		;9f1e
	ret			;9f20

; ----------------------------------------------------------------------
; DATOS tabla_del_swing: Siete desplazamientos de un byte: donde empieza cada
;   dibujo del swing, contados desde su propia casilla
;   0x9f21..0x9f28  (7 bytes)
DATA_tabla_del_swing:
	defb 007h,013h,01fh,028h,032h,040h,04eh	; 9f21

; ----------------------------------------------------------------------
; DATOS dibujos_del_swing: Los siete dibujos del golfista, de cuatro por cinco
;   casillas. Cada fila empieza por una mascara de cuatro bits: un bit a uno
;   es hueco y uno a cero se lleva la casilla siguiente de la tira
;   0x9f28..0x9f85  (93 bytes)
DATA_dibujos_del_swing:
	defb 009h,02dh,02eh,00ch,02fh,030h,00ch,031h,032h,00dh,033h,00dh,034h,00eh,035h,00ch	; 9f28  .-../0.12.3.4.5.
	defb 036h,030h,00ch,037h,038h,00dh,039h,009h,03ah,049h,00fh,00dh,03bh,00dh,05ah,00dh	; 9f38  60.78.9.:I..;.Z.
	defb 05bh,00ch,05ch,03ah,00fh,00dh,03bh,00dh,03ch,009h,03dh,03eh,009h,03ah,03fh,007h	; 9f48  [.\:..;.<.=>.:?.
	defb 040h,001h,03bh,042h,043h,009h,044h,045h,009h,046h,047h,009h,048h,049h,008h,04ah	; 9f58  @.;BC.DE.FG.HI.J
	defb 04bh,04ch,009h,04dh,04eh,00dh,04fh,009h,057h,058h,009h,059h,049h,00fh,008h,050h	; 9f68  KL.MN.O.WX.YI..P
	defb 051h,052h,008h,053h,054h,055h,008h,056h,057h,058h,009h,059h,049h	; 9f78  QR.STU.VWX.YI

; ----------------------------------------------------------------------
; DATOS patrones_comprimidos: La tabla de patrones entera, 2.048 bytes a
;   0x0000; 0x66D4 la suelta en los tres tercios de la pantalla
;   0x9f85..0xa5e6  (1633 bytes)
DATA_patrones_comprimidos:
	defb 0a6h,000h,001h,003h,00fh,0a1h,01fh,03fh,0ffh,080h,0c0h,0f0h,0a1h,0f8h,0fch,0ffh	; 9f85  .......?........
	defb 07fh,0a0h,03fh,01fh,007h,003h,001h,000h,0feh,0a0h,0fch,0f8h,0f0h,0c0h,080h,0a0h	; 9f95  ..?.............
	defb 000h,0a0h,001h,0a1h,003h,0a0h,001h,0a0h,000h,080h,0a2h,0c0h,080h,07eh,030h,0abh	; 9fa5  .............~0.
	defb 000h,03ch,0a2h,000h,007h,01fh,03fh,07fh,0a2h,000h,0e0h,0f8h,0fch,0feh,003h,01fh	; 9fb5  .<....?.........
	defb 03fh,0a3h,0ffh,0c0h,0f8h,0fch,0a3h,0ffh,000h,01eh,012h,032h,07eh,0ffh,099h,066h	; 9fc5  ?..........2~..f
	defb 0a0h,004h,0a0h,00ch,0a0h,01ch,03ch,03eh,004h,0ffh,07fh,080h,008h,022h,0a4h,000h	; 9fd5  ......<>....."..
	defb 007h,01fh,03fh,0ffh,003h,01fh,07fh,0a3h,0ffh,080h,0f8h,0fch,0a3h,0ffh,0a2h,000h	; 9fe5  ..?.............
	defb 0e0h,0f8h,0fch,0a0h,0ffh,07fh,01fh,003h,0a2h,000h,0a3h,0ffh,07fh,00fh,003h,0a3h	; 9ff5  ................
	defb 0ffh,0feh,0f0h,080h,0ffh,0fch,0f8h,0c0h,0a2h,000h,0a0h,001h,0a0h,003h,007h,0a1h	; a005  ................
	defb 00fh,0a0h,080h,0c0h,0a1h,0e0h,0a0h,0f0h,0a1h,00fh,007h,0a0h,003h,0a0h,001h,0a1h	; a015  ................
	defb 0f0h,0a0h,0e0h,0c0h,0a0h,080h,00fh,0a0h,01fh,03fh,0a1h,07fh,0ffh,0a1h,0f8h,0a0h	; a025  .........?......
	defb 0fch,0a0h,0feh,0a0h,0ffh,0a2h,07fh,03fh,0a0h,01fh,0ffh,0a1h,0feh,0a1h,0fch,0f8h	; a035  .......?........
	defb 0a6h,000h,0afh,07eh,0a5h,07eh,073h,078h,07fh,03fh,01fh,0a1h,000h,0ffh,000h,0a1h	; a045  ...~.~sx.?......
	defb 0ffh,0a1h,000h,0ceh,01eh,0feh,0fch,0f8h,0a2h,000h,01fh,03fh,07fh,078h,073h,0a0h	; a055  ...........?.xs.
	defb 074h,000h,0a1h,0ffh,000h,0ffh,0a1h,000h,0f8h,0fch,0feh,01eh,0ceh,06eh,02eh,0a6h	; a065  t............n..
	defb 074h,0a6h,02eh,073h,078h,0a0h,07fh,078h,073h,0a0h,074h,0ffh,000h,0a0h,0ffh,000h	; a075  t..sx..xs.t.....
	defb 0ffh,0a0h,000h,0ceh,01eh,0a0h,0feh,01eh,0ceh,0a0h,02eh,03ch,07eh,0e7h,0a0h,0c3h	; a085  ...........<~...
	defb 0e7h,07eh,03ch,03eh,0a3h,073h,03eh,000h,01ch,0a0h,03ch,0a1h,01ch,03eh,000h,03eh	; a095  .~<>.s>...<..>.>
	defb 067h,007h,01eh,030h,060h,07fh,000h,03eh,067h,007h,01eh,007h,067h,03eh,000h,00eh	; a0a5  g..0`..>g...g>..
	defb 01eh,03eh,0a0h,06eh,07fh,00eh,000h,03fh,0a0h,038h,03eh,003h,063h,03eh,000h,03eh	; a0b5  .>.n...?.8>.c>.>
	defb 073h,070h,07eh,0a0h,073h,03eh,000h,07fh,063h,006h,00ch,0a1h,01ch,000h,03eh,0a0h	; a0c5  sp~.s>..c.....>.
	defb 073h,03eh,0a0h,073h,03eh,000h,03eh,0a0h,073h,03fh,003h,063h,03eh,0a0h,000h,0a0h	; a0d5  s>.s>.>.s?.c>...
	defb 018h,0a0h,000h,0a0h,018h,0a0h,000h,0a0h,008h,03eh,0a0h,008h,0a0h,000h,0a0h,008h	; a0e5  .........>......
	defb 03eh,0a0h,008h,000h,03eh,0a2h,000h,03eh,0a7h,000h,0a0h,018h,0a1h,000h,07eh,0a2h	; a0f5  >...>..>......~.
	defb 06bh,000h,03ch,042h,09dh,0a0h,0b1h,09dh,042h,03ch,01ch,03eh,0a0h,073h,07fh,0a0h	; a105  k.<B....B<.>.s..
	defb 073h,000h,07eh,0a0h,073h,07eh,0a0h,073h,07eh,000h,03eh,0a0h,073h,070h,0a0h,073h	; a115  s.~.s~.s~.>.sp.s
	defb 03eh,000h,07ch,076h,0a1h,073h,076h,07ch,000h,07fh,071h,070h,07ch,070h,071h,07fh	; a125  >.|v.sv|..qp|pq.
	defb 000h,07fh,071h,070h,07ch,0a1h,070h,000h,03eh,073h,070h,077h,0a0h,073h,03eh,000h	; a135  ..qp|.p.>spw.s>.
	defb 0a1h,073h,07fh,0a1h,073h,000h,03eh,0a3h,01ch,03eh,000h,01fh,0a1h,007h,0a0h,067h	; a145  .s..s.>..>.....g
	defb 03eh,000h,073h,076h,07ch,078h,07ch,076h,073h,000h,0a3h,070h,071h,07fh,000h,063h	; a155  >.sv|x|vs..pq..c
	defb 077h,07fh,06bh,0a1h,063h,000h,073h,07bh,07fh,077h,0a1h,073h,000h,03eh,0a3h,073h	; a165  w.k.c.s{.w.s.>.s
	defb 03eh,000h,07eh,0a1h,073h,07eh,0a0h,070h,000h,03eh,0a1h,073h,07fh,072h,03dh,000h	; a175  >.~.s~.p.>.s.r=.
	defb 07eh,0a1h,073h,07eh,076h,073h,000h,03eh,073h,070h,03eh,007h,067h,03eh,000h,07fh	; a185  ~.s~vs.>sp>.g>..
	defb 0a4h,01ch,000h,0a4h,073h,03eh,000h,0a3h,073h,03eh,01ch,000h,0a0h,063h,0a1h,06bh	; a195  ....s>..s>...c.k
	defb 07fh,036h,000h,0a0h,073h,032h,01ch,032h,0a0h,073h,000h,0a0h,073h,032h,0a2h,01ch	; a1a5  .6..s2.2.s..s2..
	defb 000h,07fh,047h,00eh,01ch,038h,071h,07fh,000h,018h,0a0h,03ch,018h,000h,0a0h,018h	; a1b5  ..G..8q....<....
	defb 000h,0a6h,003h,0a6h,00fh,0a6h,03fh,0a6h,0ffh,000h,0a0h,018h,034h,07eh,05ah,0efh	; a1c5  ......?.....4~Z.
	defb 0f7h,0bdh,0cfh,07eh,0a0h,018h,0e7h,07eh,0a2h,000h,018h,03ch,06ah,0dfh,0f7h,0efh	; a1d5  ...~...~...<j...
	defb 0bbh,07eh,018h,0e7h,07eh,0a5h,000h,03ch,06ah,0fbh,0efh,0b3h,07eh,0e7h,07eh,0a2h	; a1e5  .~..~..<j...~.~.
	defb 000h,0a0h,018h,034h,076h,05ah,0efh,0b7h,0bdh,0d7h,07eh,0a0h,018h,0e7h,07eh,0a2h	; a1f5  ...4vZ....~...~.
	defb 000h,018h,03ch,06ah,0dfh,0f7h,0efh,0bbh,07eh,018h,0e7h,07eh,0a5h,000h,03ch,06ah	; a205  ..<j....~..~..<j
	defb 0fbh,0efh,0b3h,07eh,0e7h,07eh,0a2h,000h,024h,05eh,0fbh,0ddh,0c9h,090h,0a1h,018h	; a215  ...~.~..$^......
	defb 0a1h,00ch,006h,0f8h,01fh,0a0h,000h,024h,07ah,0dfh,0dbh,093h,009h,018h,0a1h,030h	; a225  .......$z......0
	defb 060h,01fh,0f8h,0a1h,000h,008h,03ch,076h,07ah,0dfh,0edh,0b7h,0ddh,072h,0ffh,07eh	; a235  `.....<vz....r.~
	defb 0a1h,000h,03ch,056h,0fah,0f5h,0b5h,0bbh,04eh,07eh,034h,07eh,0bdh,0d6h,051h,038h	; a245  ..<V....N~4~..Q8
	defb 0c7h,07ch,0a0h,000h,060h,0f0h,0a0h,0b0h,0f2h,0b7h,0bdh,0bbh,0feh,0a0h,0f0h,09fh	; a255  .|..`...........
	defb 0f0h,0a1h,000h,00ch,01eh,0a0h,016h,05eh,0a0h,0f6h,07eh,0a0h,01eh,0f3h,01eh,0a8h	; a265  .......^..~.....
	defb 000h,0a7h,0ffh,0a0h,0fch,0a1h,0f0h,0c0h,080h,0ffh,07fh,0a0h,03fh,00fh,0a1h,007h	; a275  ............?...
	defb 0c0h,0a1h,0f0h,0f8h,0a0h,0feh,0ffh,0a0h,001h,007h,0a0h,00fh,01fh,07fh,0a1h,0ffh	; a285  ................
	defb 0a0h,0feh,0a0h,0fch,0a0h,0f8h,0a0h,0ffh,07fh,0a0h,03fh,07fh,03fh,01fh,0f8h,0a0h	; a295  ..........?.?...
	defb 0fch,0a0h,0feh,0fch,0a0h,0ffh,01fh,0a1h,03fh,07fh,0a1h,0ffh,0a0h,0f8h,0e0h,0f0h	; a2a5  ........?.......
	defb 0e0h,0a0h,0c0h,080h,00fh,01fh,0a1h,007h,0a1h,001h,080h,0a0h,0c0h,0a2h,0f0h,0f8h	; a2b5  ................
	defb 0a0h,001h,003h,0a1h,007h,00fh,01fh,0a3h,0ffh,0feh,0f0h,0c0h,0a3h,0ffh,03fh,00fh	; a2c5  ..............?.
	defb 007h,0c0h,0f0h,0fch,0a3h,0ffh,003h,00fh,03fh,0a4h,0ffh,0fch,0f0h,0c0h,0a2h,000h	; a2d5  ........?.......
	defb 0ffh,03fh,00fh,003h,0a6h,000h,0c0h,0f0h,0fch,0ffh,0a2h,000h,003h,00fh,03fh,0a3h	; a2e5  .?............?.
	defb 0ffh,0a6h,000h,0a2h,0ffh,0f0h,0e0h,0a1h,0f0h,0e0h,0a0h,0f0h,00fh,007h,0a1h,00fh	; a2f5  ................
	defb 007h,0a0h,00fh,000h,080h,000h,0a0h,0c0h,080h,0a1h,000h,001h,0a0h,003h,000h,001h	; a305  ................
	defb 0aah,000h,010h,048h,001h,020h,0a0h,000h,01ch,03eh,07fh,0ffh,0feh,0ffh,07ch,02ah	; a315  ...H. ...>....|*
	defb 000h,01ch,03ch,0a0h,07eh,06eh,008h,022h,0feh,0fch,0f8h,0a0h,0f0h,0e0h,080h,000h	; a325  ..<.~n."........
	defb 03fh,01fh,0a0h,00fh,0a0h,007h,003h,0a0h,000h,080h,09ch,0d8h,0c0h,0fch,0feh,0ffh	; a335  ?...............
	defb 001h,037h,027h,0a0h,003h,0a0h,01fh,0a1h,0ffh,0f8h,0feh,0fch,0f4h,0e0h,0f8h,0a0h	; a345  .7'.............
	defb 0ffh,07fh,01fh,00fh,01fh,0a0h,00fh,0f0h,0a0h,0f8h,0f0h,0fch,0feh,0a0h,0ffh,01fh	; a355  ................
	defb 00fh,01fh,0a0h,03fh,01fh,07fh,0ffh,0f0h,0a0h,0c0h,0e0h,0a0h,0c0h,0a0h,080h,0a0h	; a365  ...?............
	defb 00fh,003h,007h,0a1h,003h,001h,080h,0a0h,0c0h,080h,0e0h,0a0h,0f0h,0e0h,001h,0a0h	; a375  ................
	defb 003h,001h,007h,00fh,007h,00fh,0a2h,0ffh,0f8h,0fch,0f8h,0c0h,0a1h,0ffh,0cfh,00fh	; a385  ................
	defb 01fh,001h,003h,080h,0f4h,0e0h,0fch,0a2h,0ffh,003h,01fh,00fh,09fh,0a2h,0ffh,0feh	; a395  ................
	defb 0f0h,0f8h,080h,010h,002h,040h,000h,0ffh,00fh,03fh,033h,080h,008h,021h,0a0h,000h	; a3a5  .....@...?3..!..
	defb 008h,040h,002h,0e0h,0ech,0fch,0ffh,010h,000h,084h,030h,063h,00fh,03fh,0a2h,0ffh	; a3b5  .@........0c.?..
	defb 073h,000h,040h,002h,0a0h,010h,000h,042h,000h,073h,0a1h,0ffh,0f0h,0a0h,0e0h,0f0h	; a3c5  s.@....B.s......
	defb 0f8h,0f0h,0e0h,0f0h,0a0h,007h,00fh,0a0h,01fh,007h,0a0h,00fh,07eh,00ch,041h,008h	; a3d5  ............~.A.
	defb 020h,0a4h,000h,010h,000h,084h,000h,076h,000h,0a0h,080h,000h,080h,0c0h,080h,0a0h	; a3e5   ......v........
	defb 000h,0a0h,001h,000h,001h,003h,001h,0a8h,000h,020h,002h,008h,000h,040h,002h,010h	; a3f5  ......... ...@..
	defb 0a0h,081h,0c3h,0a3h,0ffh,0a1h,0f8h,0fch,0f8h,0e0h,0a0h,080h,0a0h,007h,003h,0a0h	; a405  ................
	defb 01fh,00fh,0a0h,001h,080h,0c0h,0e0h,0a1h,0f0h,0fch,0ffh,0a0h,001h,007h,003h,00fh	; a415  ................
	defb 03fh,07fh,0ffh,080h,0a0h,0c0h,080h,0a0h,000h,0a0h,080h,001h,0a0h,003h,001h,0a0h	; a425  ?...............
	defb 000h,0a0h,001h,0ffh,0a0h,03ch,0a9h,000h,020h,076h,0a6h,000h,0ffh,0a0h,087h,0a0h	; a435  .....<.. v......
	defb 000h,080h,0f0h,0feh,0a0h,0e1h,0a1h,000h,001h,003h,00fh,0ffh,0a0h,0e0h,000h,080h	; a445  ................
	defb 0c0h,0a1h,0ffh,0a0h,01fh,000h,001h,003h,007h,0a0h,0ffh,0f8h,0f0h,0a0h,0e0h,0f0h	; a455  ................
	defb 0a1h,0ffh,00fh,0a1h,007h,00fh,01fh,0ffh,0e1h,0c1h,080h,081h,0a1h,003h,000h,0c7h	; a465  ................
	defb 087h,003h,0c1h,0c0h,0a0h,000h,080h,0a1h,0ffh,0c3h,081h,000h,0a0h,001h,0a2h,0ffh	; a475  ................
	defb 0a0h,0e1h,0c0h,080h,0a2h,001h,0a0h,000h,081h,0c3h,0a1h,080h,0a0h,000h,081h,0c3h	; a485  ................
	defb 0a0h,0ffh,0a0h,0f0h,0a1h,000h,080h,0e0h,080h,000h,0a0h,001h,003h,007h,00fh,03fh	; a495  ...............?
	defb 0a0h,080h,0a0h,0c0h,0e0h,0f8h,0a0h,0ffh,087h,007h,0a0h,000h,001h,003h,00fh,0a0h	; a4a5  ................
	defb 0ffh,0a0h,0fch,0f0h,0e0h,0c0h,0a0h,080h,0ffh,0a0h,03fh,007h,0a0h,003h,0a0h,001h	; a4b5  ..........?.....
	defb 000h,006h,01eh,0a0h,07eh,01eh,006h,0a0h,000h,060h,078h,0a0h,07eh,078h,060h,0a0h	; a4c5  ....~....`x.~x`.
	defb 000h,03ch,07eh,066h,066h,07eh,03ch,0a0h,000h,018h,018h,03ch,03ch,07eh,07eh,0a1h	; a4d5  .<~ff~<....<<~~.
	defb 000h,018h,0a0h,03ch,018h,0a7h,000h,0ffh,0a6h,000h,0fch,0f0h,0c0h,0a0h,080h,0a1h	; a4e5  ...<............
	defb 000h,07fh,01fh,007h,0a0h,003h,0a1h,001h,0a0h,000h,0a0h,080h,0c0h,0f0h,0fch,0ffh	; a4f5  ................
	defb 0a0h,001h,0a0h,003h,007h,01fh,07fh,0a0h,0ffh,0feh,0f8h,0e0h,0c0h,0a1h,080h,0ffh	; a505  ................
	defb 001h,0a4h,000h,0a0h,0ffh,03fh,00fh,007h,0a1h,003h,0a0h,080h,0c0h,0e0h,0f8h,0feh	; a515  .....?..........
	defb 0a0h,0ffh,0a3h,000h,001h,0a0h,0ffh,0a0h,003h,007h,00fh,03fh,0a3h,0ffh,0fch,0f0h	; a525  ...........?....
	defb 0a0h,0e0h,0a0h,0c0h,0a0h,0ffh,0a4h,000h,0a0h,0ffh,07fh,01fh,0a0h,00fh,0a0h,007h	; a535  ................
	defb 0c0h,0a0h,0e0h,0f0h,0fch,0a1h,0ffh,0a3h,000h,0a1h,0ffh,007h,0a0h,00fh,01fh,07fh	; a545  ................
	defb 0a1h,0ffh,000h,040h,0e0h,040h,0e0h,0a2h,000h,002h,007h,002h,007h,0a9h,000h,0fch	; a555  ...@.@..........
	defb 0a3h,0f8h,0a3h,0f0h,0a3h,0e0h,0ffh,0feh,0a0h,0fch,0a0h,0f8h,0a0h,0f0h,0a0h,0e0h	; a565  ................
	defb 0a0h,0c0h,0a0h,080h,0a0h,000h,0a1h,0e0h,0a1h,0f0h,0a1h,0f8h,0a1h,0fch,0a1h,0feh	; a575  ................
	defb 0ffh,03fh,0a3h,01fh,0a3h,00fh,0a3h,007h,0ffh,07fh,0a0h,03fh,0a0h,01fh,0a0h,00fh	; a585  .?.........?....
	defb 0a0h,007h,0a0h,003h,0a0h,001h,0a0h,000h,0a1h,007h,0a1h,00fh,0a1h,01fh,0a1h,03fh	; a595  ...............?
	defb 0a1h,07fh,0ffh,003h,00fh,03fh,0a0h,0ffh,049h,0a0h,07fh,0c0h,0f0h,0fch,0a0h,0ffh	; a5a5  .....?..I.......
	defb 092h,0a0h,0feh,0a0h,001h,007h,0a0h,00fh,03fh,0a0h,07fh,080h,0a0h,0c0h,0f0h,0f8h	; a5b5  ........?.......
	defb 0a0h,0fch,0feh,0a0h,07fh,0a0h,03fh,00fh,0a0h,007h,001h,0feh,0a0h,0fch,0a0h,0f0h	; a5c5  ......?.........
	defb 0c0h,080h,0a1h,000h,001h,000h,001h,003h,001h,0a1h,000h,080h,000h,080h,0c0h,080h	; a5d5  ................
	defb 000h	; a5e5

; ----------------------------------------------------------------------
; DATOS colores_comprimidos: La tabla de color, 2.048 bytes a 0x2000,
;   comprimida a pares
;   0xa5e6..0xa7d2  (492 bytes)
DATA_colores_comprimidos:
	defb 000h,004h,0f1h,0f1h,000h,030h,031h,021h,0b3h,0f2h,0f3h,0f2h,0e3h,092h,051h,012h	; a5e6  .....01!......Q.
	defb 000h,004h,084h,084h,0f4h,0f4h,0b4h,000h,002h,0f4h,0f4h,0f4h,000h,040h,0c3h,0c2h	; a5f6  .............@..
	defb 000h,004h,0fch,0f1h,000h,006h,0d1h,0d1h,0b1h,091h,091h,0b1h,0b1h,091h,091h,0b1h	; a606  ................
	defb 000h,002h,0d1h,0d1h,000h,02ch,0a1h,0a1h,08ch,081h,000h,002h,089h,089h,08ch,081h	; a616  .....,..........
	defb 000h,0b0h,0fch,0f1h,000h,010h,081h,081h,000h,003h,0c3h,0c3h,000h,002h,0c1h,0c1h	; a626  ................
	defb 0c3h,063h,063h,016h,013h,000h,003h,0c3h,0c3h,0c3h,000h,002h,0c1h,0c1h,0c3h,063h	; a636  .cc............c
	defb 016h,013h,000h,004h,0c3h,0c3h,0c3h,0c1h,0c1h,0c1h,0c3h,016h,013h,000h,002h,0c3h	; a646  ................
	defb 0c3h,000h,002h,0c2h,0c3h,0c2h,000h,002h,0c1h,0c1h,0c3h,062h,063h,016h,013h,000h	; a656  ...........bc...
	defb 003h,0c2h,0c3h,0c2h,000h,002h,0c1h,0c1h,0c3h,062h,016h,012h,000h,004h,0c3h,0c2h	; a666  .........b......
	defb 0c3h,0c1h,0c1h,0c1h,0c3h,016h,013h,000h,003h,0c2h,0c3h,0c1h,0c1h,0c2h,000h,004h	; a676  ................
	defb 063h,062h,016h,012h,000h,002h,0c3h,0c2h,0c1h,0c1h,0c3h,000h,003h,062h,063h,016h	; a686  cb...........bc.
	defb 013h,0c2h,000h,004h,0cbh,0cbh,0c1h,0c1h,0c1h,01bh,01bh,000h,003h,0cbh,0cbh,0cbh	; a696  ................
	defb 0c1h,0c1h,0c1h,01bh,0cbh,0cbh,0c1h,0c1h,0c1h,0cbh,016h,01bh,000h,004h,0cbh,0cbh	; a6a6  ................
	defb 0c3h,0c3h,0cbh,0cbh,0cbh,01ch,01bh,000h,006h,0cbh,0cbh,0cbh,01ch,01bh,0cbh,0cbh	; a6b6  ................
	defb 000h,004h,033h,033h,000h,06ch,033h,023h,000h,004h,074h,074h,000h,004h,0f4h,0f4h	; a6c6  ..33.l3#..tt....
	defb 000h,003h,034h,024h,03fh,0f4h,000h,002h,034h,024h,034h,02fh,0f4h,0f4h,000h,042h	; a6d6  ..4$?...4$4/...B
	defb 034h,024h,000h,002h,0f4h,0f4h,000h,002h,034h,024h,000h,004h,0f4h,0f4h,000h,002h	; a6e6  4$......4$......
	defb 034h,024h,0f4h,0f4h,0f4h,000h,004h,024h,034h,024h,000h,004h,0f4h,0f4h,000h,00bh	; a6f6  4$.....$4$......
	defb 034h,024h,000h,006h,0f4h,0f4h,0f4h,000h,008h,024h,034h,024h,000h,004h,03bh,03bh	; a706  4$.......$4$..;;
	defb 000h,004h,0abh,0abh,000h,004h,03bh,02bh,031h,000h,003h,02bh,03bh,02bh,031h,000h	; a716  ......;+1..+;+1.
	defb 014h,02bh,03bh,021h,01bh,000h,006h,02bh,03bh,02bh,031h,000h,004h,02bh,03bh,021h	; a726  .+;!...+;+1..+;!
	defb 01bh,000h,002h,02bh,03bh,02bh,031h,01bh,000h,003h,03bh,02bh,03bh,021h,01bh,000h	; a736  ...+;+1...;+;!..
	defb 003h,02bh,03bh,021h,01bh,000h,003h,02bh,03bh,021h,000h,003h,03bh,02bh,03bh,021h	; a746  .+;!...+;!..;+;!
	defb 000h,003h,03bh,02bh,031h,000h,002h,02bh,03bh,02bh,01bh,02bh,031h,02bh,03bh,02bh	; a756  ..;+1..+;+.+1+;+
	defb 01bh,000h,003h,02bh,03bh,021h,01bh,000h,003h,02bh,03bh,02bh,031h,000h,003h,02bh	; a766  ...+;!...+;+1..+
	defb 03bh,01bh,000h,003h,03bh,02bh,01bh,000h,003h,02bh,03bh,021h,01bh,000h,002h,02bh	; a776  ;...;+...+;!...+
	defb 03bh,02bh,01bh,000h,007h,02bh,03bh,02bh,031h,01bh,000h,003h,03bh,02bh,03bh,021h	; a786  ;+...+;+1...;+;!
	defb 000h,003h,03bh,02bh,03bh,021h,000h,003h,03bh,02bh,000h,010h,094h,094h,000h,004h	; a796  ..;+;!..;+......
	defb 01ch,01ch,000h,048h,03ch,02ch,03ch,0ach,0ach,0ach,01ch,000h,002h,02ch,03ch,0ach	; a7a6  ...H<,<......,<.
	defb 0ach,0ach,01ch,000h,035h,02ch,03ch,02ch,000h,002h,083h,082h,071h,0b1h,0b1h,0b1h	; a7b6  ....5,<,....q...
	defb 000h,002h,083h,082h,071h,0b1h,0b1h,0b1h,000h,018h,0c3h,0c2h	; a7c6  ....q.......

; ----------------------------------------------------------------------
; DATOS patrones_del_green: Los patrones de la vista del green: 0x9DF3 los
;   suelta en 0x1168-0x1300
;   0xa7d2..0xa90c  (314 bytes)
DATA_patrones_del_green:
	defb 0a0h,000h,001h,002h,00ch,010h,060h,080h,000h,0c0h,0e0h,060h,0a2h,000h,003h,01ch	; a7d2  ......`....`....
	defb 018h,01ch,00ch,0a0h,006h,003h,03ch,07eh,0feh,0ffh,0c7h,0c3h,0e7h,018h,003h,001h	; a7e2  ......<~........
	defb 0a4h,000h,0a0h,0fch,01ch,06ch,0a2h,03ch,03eh,0a0h,07fh,0a0h,02ch,0a2h,06ch,0cch	; a7f2  .....l.<>...,.l.
	defb 0a0h,0c6h,0a0h,0c3h,0a0h,0c7h,0a3h,000h,060h,0e0h,0c0h,0a0h,080h,0a2h,040h,0a2h	; a802  ........`.....@.
	defb 020h,0a0h,010h,019h,0a0h,01fh,000h,03ch,07eh,0feh,0bah,0f6h,0eeh,0deh,0a0h,03eh	; a812   ......<~......>
	defb 0a0h,07fh,0a1h,036h,0a0h,066h,0a0h,063h,0a4h,0c3h,03ch,0a0h,07eh,0a0h,0ffh,0c3h	; a822  ...6.f.c..<.~...
	defb 0e7h,018h,03eh,07dh,07fh,05eh,03dh,02dh,01fh,017h,03fh,07bh,07fh,0a2h,01bh,033h	; a832  ..>}.^=-..?{...3
	defb 000h,0a3h,080h,0a2h,040h,0a1h,020h,038h,098h,080h,0a0h,000h,0a0h,006h,002h,004h	; a842  ....@. 8........
	defb 0a0h,008h,03ch,07eh,07fh,0ffh,0fbh,0e3h,0e7h,018h,0a4h,000h,001h,003h,010h,0a0h	; a852  ..<~............
	defb 020h,040h,0a0h,080h,0a0h,000h,03eh,03fh,027h,038h,0a2h,01fh,0f7h,09fh,0f8h,0e0h	; a862   @....>?'8......
	defb 0a1h,000h,080h,03fh,0a0h,07fh,0a3h,00dh,0a0h,0c0h,0a4h,080h,00dh,0a0h,01bh,033h	; a872  ...?...........3
	defb 073h,0e3h,0a0h,0c3h,0a4h,000h,0a0h,080h,000h,01ch,01bh,0a5h,000h,080h,070h,00eh	; a882  s.............p.
	defb 001h,0a5h,000h,0f0h,0a0h,078h,03ch,07eh,07fh,0ffh,0fdh,0f1h,0f3h,00dh,078h,0a1h	; a892  .....x<~......x.
	defb 068h,0e8h,0d0h,0e0h,080h,0a0h,01fh,01eh,0a0h,01fh,0a0h,00fh,01fh,003h,0a1h,007h	; a8a2  h...............
	defb 002h,0a0h,005h,008h,01eh,03fh,07fh,0ffh,0f9h,0e1h,0f3h,0edh,0a3h,000h,0a1h,080h	; a8b2  .....?..........
	defb 0a0h,008h,0a2h,010h,0a0h,020h,07fh,03fh,01fh,00fh,0a0h,007h,00fh,01fh,080h,0a4h	; a8c2  ..... .?........
	defb 000h,0e0h,020h,030h,038h,018h,0a2h,000h,03fh,0fch,0f8h,0a2h,00dh,01bh,0c0h,080h	; a8d2  .. 08...?.......
	defb 0a4h,000h,01bh,033h,0a0h,063h,0a2h,0c3h,07eh,0a1h,0ffh,0dfh,0dbh,06ah,036h,03ah	; a8e2  ...3.c..~....j6:
	defb 077h,07fh,0a0h,076h,0a1h,0b6h,0a1h,001h,0a0h,002h,0a0h,006h,000h,060h,0ech,08eh	; a8f2  w..v.........`..
	defb 0a0h,0b2h,0a1h,054h,0a0h,0feh,0a9h,0beh,0a1h,0feh	; a902  ...T......

; ----------------------------------------------------------------------
; DATOS colores_del_green: Y sus colores, en 0x3168-0x3300
;   0xa90c..0xaa0e  (258 bytes)
DATA_colores_del_green:
	defb 000h,008h,0f4h,0f4h,0f4h,000h,003h,0b4h,0b4h,0b4h,000h,002h,0d4h,0d4h,0dbh,0dbh	; a90c  ................
	defb 0dbh,000h,004h,0b4h,0b4h,0b4h,000h,003h,084h,084h,084h,000h,002h,074h,074h,000h	; a91c  .............tt.
	defb 002h,0a4h,0a4h,0a4h,000h,003h,0b4h,0b4h,064h,064h,000h,00ah,0f4h,0f4h,000h,002h	; a92c  ........dd......
	defb 0b4h,0b4h,000h,003h,084h,084h,084h,000h,002h,074h,074h,000h,005h,0b4h,0b4h,0b4h	; a93c  .........tt.....
	defb 064h,064h,000h,002h,0d4h,0d4h,0d4h,0dbh,0dbh,0b4h,000h,003h,084h,084h,084h,000h	; a94c  dd..............
	defb 002h,074h,074h,000h,004h,0b4h,0b4h,000h,005h,0f4h,0f4h,0f4h,064h,064h,000h,004h	; a95c  .tt.........dd..
	defb 0f4h,0f4h,000h,002h,0d4h,0d4h,0dbh,0dbh,0dbh,000h,004h,0b4h,0b4h,0b4h,000h,004h	; a96c  ................
	defb 0f4h,0f4h,000h,003h,084h,084h,084h,074h,000h,003h,0b4h,0b4h,0b4h,000h,002h,074h	; a97c  .......t.......t
	defb 074h,000h,002h,0b4h,0b4h,0b4h,074h,074h,074h,000h,005h,0b4h,0b4h,0b4h,064h,064h	; a98c  t.....ttt.....dd
	defb 000h,003h,0b4h,0b4h,084h,084h,000h,008h,0f4h,0f4h,000h,004h,0b4h,0b4h,000h,002h	; a99c  ................
	defb 0d4h,0d4h,0dbh,0dbh,0dbh,000h,004h,0b4h,0b4h,0b4h,000h,003h,084h,084h,084h,074h	; a9ac  ...............t
	defb 000h,003h,0b4h,0b4h,0b4h,0f4h,0d4h,0d4h,0d4h,000h,002h,0dbh,0dbh,0b4h,000h,004h	; a9bc  ................
	defb 084h,084h,000h,004h,0f4h,0f4h,000h,003h,084h,084h,084h,074h,000h,003h,084h,084h	; a9cc  ...........t....
	defb 084h,074h,000h,004h,0f4h,0f4h,074h,07fh,07fh,000h,002h,0b4h,0b4h,0b4h,074h,054h	; a9dc  .t....t.......tT
	defb 0a4h,000h,005h,0b4h,0b4h,0b4h,064h,064h,000h,004h,084h,084h,074h,074h,074h,000h	; a9ec  ......dd....ttt.
	defb 002h,0b4h,0b4h,0b4h,000h,008h,0f4h,0f4h,094h,094h,000h,005h,0b4h,0b4h,0b4h,064h	; a9fc  ...............d
	defb 064h,064h	; aa0c

; ----------------------------------------------------------------------
; DATOS patrones_del_texto: Los 360 bytes de patrones que llevan la fuente:
;   0x670A los repone en 0x0698 de cada tercio sin tocar el resto
;   0xaa0e..0xaafd  (239 bytes)
DATA_patrones_del_texto:
	defb 007h,01fh,03fh,0a0h,07fh,0a0h,0ffh,0feh,0c0h,0f0h,0f8h,0a0h,0fch,0a1h,0feh,0a0h	; aa0e  ..?.............
	defb 0ffh,0a0h,07fh,03fh,01fh,0a0h,007h,0a0h,0feh,0a0h,0fch,0f8h,0f0h,0a0h,0c0h,0a5h	; aa1e  ...?............
	defb 0ffh,0feh,0a5h,0ffh,000h,0adh,0feh,000h,03fh,07fh,0a4h,0ffh,000h,0c0h,0e0h,0f0h	; aa2e  ........?.......
	defb 0f8h,0fch,0feh,0a0h,0ffh,07fh,03fh,01fh,00fh,007h,003h,001h,007h,01fh,03ch,070h	; aa3e  ......?.......<p
	defb 060h,0e1h,0c3h,0c7h,0c0h,0f0h,078h,01ch,00ch,00eh,086h,0c6h,0c3h,0e1h,060h,070h	; aa4e  `.....x.......`p
	defb 03ch,01fh,0a0h,007h,086h,00eh,00ch,01ch,078h,0f0h,0a0h,0c0h,0a0h,0ffh,0a1h,0c0h	; aa5e  <.......x.......
	defb 0a0h,0c7h,0c6h,0a0h,0ffh,0a1h,000h,0a0h,0ffh,000h,0a6h,0c6h,0a0h,0feh,0a1h,006h	; aa6e  ................
	defb 0a0h,0feh,000h,0a3h,0c6h,0a0h,0feh,000h,0a0h,0c7h,0a1h,0c0h,0a0h,0c7h,0c6h,0a0h	; aa7e  ................
	defb 0ffh,0a1h,0c0h,0a0h,0ffh,000h,0a0h,0feh,0a4h,0c6h,0a0h,0ffh,0a1h,000h,0a0h,0ffh	; aa8e  ................
	defb 001h,0a5h,0c6h,0c7h,0a5h,000h,0a0h,001h,003h,006h,00ch,038h,0a0h,0ffh,0afh,000h	; aa9e  ...........8....
	defb 000h,003h,00fh,01fh,0a0h,03fh,0a0h,07fh,0feh,0a5h,0ffh,000h,080h,0e0h,0f0h,0a0h	; aaae  .....?..........
	defb 0f8h,0a0h,0fch,0a0h,0f9h,0a0h,09fh,0ffh,0a0h,0f3h,07fh,0a0h,0e7h,0ffh,0a0h,03ch	; aabe  ...............<
	defb 0ffh,0a0h,0e7h,0a5h,0feh,0fch,06fh,037h,03fh,01ch,00fh,003h,000h,0c0h,000h,0c3h	; aace  ......o7?.......
	defb 09fh,0feh,0ffh,0c7h,0feh,07ch,0ech,0d8h,0f8h,070h,0e0h,080h,001h,007h,0feh,0a2h	; aade  .....|...p......
	defb 0c6h,0feh,07ch,0feh,0a5h,000h,07ch,003h,0a5h,000h,0c0h,0afh,000h,0ach,000h	; aaee  ..|...|........

; ----------------------------------------------------------------------
; DATOS colores_del_texto: Y sus colores, en 0x2698 de cada tercio
;   0xaafd..0xaba1  (164 bytes)
DATA_colores_del_texto:
	defb 000h,003h,0f9h,0e9h,0f9h,0e1h,000h,002h,0f9h,0e9h,0f9h,0e1h,0f1h,0e1h,000h,003h	; aafd  ................
	defb 0f6h,0e6h,0f6h,016h,000h,002h,0f1h,0e1h,0f6h,0e6h,0f6h,016h,000h,010h,0f1h,0e1h	; ab0d  ................
	defb 000h,008h,0f9h,0e9h,000h,004h,0f8h,0e8h,000h,00bh,0fch,0fch,0fch,01ch,000h,003h	; ab1d  ................
	defb 0fch,0fch,0fch,01ch,000h,007h,0fch,0fch,0fch,0f1h,000h,007h,0fch,0fch,0fch,0f1h	; ab2d  ................
	defb 000h,003h,0fch,0fch,0fch,0f1h,000h,007h,0fch,0fch,0fch,0f1h,000h,007h,0fch,0fch	; ab3d  ................
	defb 0fch,0f1h,000h,00bh,0fch,0fch,0fch,0f1h,000h,004h,01ch,01ch,0f1h,000h,00fh,0fch	; ab4d  ................
	defb 0fch,0fch,000h,003h,0feh,0feh,0feh,0fch,000h,004h,0feh,0feh,000h,004h,0fch,0fch	; ab5d  ................
	defb 000h,002h,0ech,0ech,0e1h,0e1h,0e1h,0c1h,0efh,0efh,000h,002h,0ech,0ech,0e1h,011h	; ab6d  ................
	defb 000h,002h,0ech,0ech,0e1h,0e1h,0e1h,0c1h,000h,003h,0fch,0fch,0fch,01ch,0f1h,000h	; ab7d  ................
	defb 003h,0fch,0fch,0fch,000h,008h,01ch,01ch,000h,004h,019h,019h,000h,004h,018h,018h	; ab8d  ................
	defb 000h,004h,016h,016h	; ab9d

; ----------------------------------------------------------------------
; DATOS pantalla_de_juego: La tabla de nombres de 0x1800: el panel y el campo
;   0xaba1..0xacfb  (346 bytes)
DATA_pantalla_de_juego:
	defb 0afh,000h,0adh,000h,0afh,0fdh,0afh,0fdh,0fdh,0d9h,0fdh,0d9h,0d3h,0d8h,0d4h,0d9h	; aba1  ................
	defb 0a0h,0fdh,0d3h,0d8h,0dah,0fdh,0d9h,0dbh,0dch,0d9h,0fdh,0d3h,0d8h,0d4h,0dbh,0dch	; abb1  ................
	defb 0d9h,0d3h,0d8h,0dah,0a0h,0fdh,0a1h,0feh,0d9h,0feh,0a0h,0d9h,0feh,0a0h,0d9h,0a0h	; abc1  ................
	defb 0feh,0d9h,0a1h,0feh,0a0h,0d9h,0ddh,0d9h,0feh,0d9h,0feh,0a0h,0d9h,0ddh,0a0h,0d9h	; abd1  ................
	defb 0a5h,0feh,0d7h,0d8h,0a0h,0d9h,0feh,0a0h,0d9h,0a0h,0feh,0d7h,0dah,0a0h,0feh,0a0h	; abe1  ................
	defb 0d9h,0feh,0d9h,0feh,0d9h,0feh,0a0h,0d9h,0feh,0d9h,0d7h,0dah,0a4h,0feh,0d9h,0feh	; abf1  ................
	defb 0a0h,0d9h,0feh,0a0h,0d9h,0a0h,0feh,0d9h,0a1h,0feh,0a0h,0d9h,0feh,0d9h,0feh,0d9h	; ac01  ................
	defb 0feh,0a0h,0d9h,0feh,0a0h,0d9h,0a2h,0feh,0a1h,0ffh,0dah,0ffh,0dah,0d5h,0d8h,0d6h	; ac11  ................
	defb 0d5h,0d8h,0dah,0d5h,0d8h,0dah,0ffh,0a0h,0dah,0ffh,0dah,0ffh,0d5h,0d8h,0d6h,0dah	; ac21  ................
	defb 0ffh,0dah,0d5h,0d8h,0dah,0afh,0ffh,0afh,0ffh,0afh,0efh,0a0h,0efh,0fah,0aah,0efh	; ac31  ................
	defb 0a0h,0eeh,0e2h,0eah,0dfh,0a3h,0eeh,0deh,0e5h,0a5h,0eeh,0f9h,0a7h,0eeh,0e9h,0a2h	; ac41  ................
	defb 0eeh,0e4h,0ech,0e4h,0deh,0e5h,0f0h,0f1h,0f2h,0e7h,0e5h,0deh,0eah,0dfh,0deh,0e5h	; ac51  ................
	defb 0deh,0e5h,0e9h,0deh,0eah,0dfh,0deh,0eah,0dfh,0deh,0eah,0dfh,0e4h,0a2h,0eeh,0e4h	; ac61  ................
	defb 0e8h,0e1h,0e4h,0eeh,0f3h,0f4h,0f5h,0e4h,0eeh,0ebh,0edh,0e1h,0e4h,0ech,0e4h,0eeh	; ac71  ................
	defb 0e4h,0ebh,0ech,0a0h,0e4h,0eeh,0e4h,0ebh,0eeh,0a0h,0e4h,0a2h,0eeh,0e6h,0a0h,0eeh	; ac81  ................
	defb 0e6h,0eeh,0f6h,0f7h,0f8h,0e6h,0eeh,0e0h,0a0h,0e3h,0e1h,0e8h,0e1h,0eeh,0e6h,0e0h	; ac91  ................
	defb 0e3h,0e1h,0e6h,0eeh,0e6h,0e0h,0e5h,0a0h,0e6h,0a7h,0eeh,0fbh,0efh,0fch,0afh,0eeh	; aca1  ................
	defb 0a3h,0eeh,0afh,000h,0afh,000h,0afh,000h,0afh,000h,027h,0afh,028h,0a4h,028h,029h	; acb1  ..........'.(.()
	defb 0a5h,000h,02ah,0afh,020h,0a4h,020h,02bh,0a5h,000h,02ah,0afh,020h,0a4h,020h,02bh	; acc1  ..*. . +..*. . +
	defb 0a5h,000h,02ah,0afh,020h,0a4h,020h,02bh,0a5h,000h,02ah,0afh,020h,0a4h,020h,02bh	; acd1  ..*. . +..*. . +
	defb 0a5h,000h,02ah,0afh,020h,0a4h,020h,02bh,0a5h,000h,02ah,0afh,020h,0a4h,020h,02bh	; ace1  ..*. . +..*. . +
	defb 0a5h,000h,024h,0afh,025h,0a4h,025h,026h,0a1h,000h	; acf1  ..$.%.%&..

; ----------------------------------------------------------------------
; DATOS pantalla_del_marcador: La tabla de nombres de 0x1C00: el marcador de
;   dieciocho hoyos
;   0xacfb..0xae44  (329 bytes)
DATA_pantalla_del_marcador:
	defb 000h,027h,0afh,028h,0a9h,028h,029h,0a0h,000h,02ah,0a4h,020h,048h,041h,04ch,020h	; acfb  .'.(.()..*. HAL 
	defb 043h,04fh,055h,04eh,054h,052h,059h,020h,043h,04ch,055h,042h,0a4h,020h,02bh,0a0h	; ad0b  COUNTRY CLUB. +.
	defb 000h,024h,0afh,025h,0a9h,025h,026h,0a0h,000h,027h,0abh,028h,029h,027h,0abh,028h	; ad1b  .$.%.%&..'.()'.(
	defb 029h,0a0h,000h,02ah,0a2h,020h,04fh,020h,055h,020h,054h,0a2h,020h,02bh,02ah,0a2h	; ad2b  )..*. O U T. +*.
	defb 020h,049h,0a0h,020h,04eh,0a3h,020h,02bh,0a0h,000h,02ch,0abh,02dh,02eh,02ch,0abh	; ad3b   I. N. +..,.-.,.
	defb 02dh,02eh,0a0h,000h,02ah,048h,04ch,020h,050h,041h,052h,020h,031h,050h,0a0h,020h	; ad4b  -...*HL PAR 1P. 
	defb 032h,050h,02bh,02ah,048h,04ch,020h,050h,041h,052h,020h,031h,050h,0a0h,020h,032h	; ad5b  2P+*HL PAR 1P. 2
	defb 050h,02bh,0a0h,000h,02ch,0abh,02dh,02eh,02ch,0abh,02dh,02eh,0a0h,000h,02ah,0abh	; ad6b  P+..,.-.,.-...*.
	defb 020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh	; ad7b   +*. +..*. +*. +
	defb 0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh	; ad8b  ..*. +*. +..*. +
	defb 02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h	; ad9b  *. +..*. +*. +..
	defb 02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh	; adab  *. +*. +..*. +*.
	defb 020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh	; adbb   +..*. +*. +..*.
	defb 020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ch,0abh,02dh,02eh,02ch,0abh,02dh,02eh	; adcb   +*. +..,.-.,.-.
	defb 0a0h,000h,02ah,053h,043h,04fh,052h,045h,03ah,0a1h,020h,03ah,0a1h,020h,02bh,02ah	; addb  ..*SCORE:. :. +*
	defb 053h,043h,04fh,052h,045h,03ah,0a1h,020h,03ah,0a1h,020h,02bh,0a0h,000h,024h,0abh	; adeb  SCORE:. :. +..$.
	defb 025h,026h,024h,0abh,025h,026h,0a0h,000h,027h,0afh,028h,0a9h,028h,029h,0a0h,000h	; adfb  %&$.%&..'.(.()..
	defb 02ah,020h,054h,04fh,054h,041h,04ch,0a0h,020h,03ah,020h,050h,04ch,041h,059h,045h	; ae0b  * TOTAL. : PLAYE
	defb 052h,031h,020h,03ah,020h,050h,04ch,041h,059h,045h,052h,032h,020h,02bh,0a0h,000h	; ae1b  R1 : PLAYER2 +..
	defb 02ah,0a0h,020h,053h,043h,04fh,052h,045h,020h,03ah,0a7h,020h,03ah,0a7h,020h,02bh	; ae2b  *. SCORE :. :. +
	defb 0a0h,000h,024h,0afh,025h,0a9h,025h,026h,000h	; ae3b  ..$.%.%&.

; ----------------------------------------------------------------------
; DATOS pantalla_del_torneo: Los cinco primeros renglones de la tabla de
;   nombres de 0x3C00, la de la clasificacion
;   0xae44..0xae90  (76 bytes)
DATA_pantalla_del_torneo:
	defb 000h,027h,0afh,028h,0a9h,028h,029h,0a0h,000h,02ah,0a4h,020h,048h,041h,04ch,020h	; ae44  .'.(.()..*. HAL 
	defb 043h,04fh,055h,04eh,054h,052h,059h,020h,043h,04ch,055h,042h,0a4h,020h,02bh,0a0h	; ae54  COUNTRY CLUB. +.
	defb 000h,02ch,0afh,02dh,0a9h,02dh,02eh,0a0h,000h,02ah,052h,041h,04eh,04bh,0a2h,020h	; ae64  .,.-.-...*RANK. 
	defb 050h,04ch,041h,059h,045h,052h,0a2h,020h,053h,043h,04fh,052h,045h,020h,048h,04fh	; ae74  PLAYER. SCORE HO
	defb 04ch,045h,02bh,0a0h,000h,02ch,0afh,02dh,0a9h,02dh,02eh,000h	; ae84  LE+..,.-.-..

; ----------------------------------------------------------------------
; DATOS renglon_del_torneo: Un solo renglon de 32 casillas, que 0x674E repite
;   dieciocho veces para las dieciocho lineas de la clasificacion
;   0xae90..0xae9b  (11 bytes)
DATA_renglon_del_torneo:
	defb 000h,02ah,0a2h,020h,021h,0afh,020h,0a4h,020h,02bh,000h	; ae90  .*. !. . +.

; ----------------------------------------------------------------------
; DATOS ultimo_renglon_del_torneo: El renglon de abajo del todo de la
;   clasificacion
;   0xae9b..0xaea3  (8 bytes)
DATA_ultimo_renglon_del_torneo:
	defb 000h,024h,0ach,025h,0ach,025h,026h,000h	; ae9b  .$.%.%&.

; ======================================================================
; CODIGO 0xaea3..0xafad  (266 bytes)
; ======================================================================


L_AEA3:
	ld a,001h		;aea3
	ld (0c006h),a		;aea5
	call L_6636		;aea8
	call L_B45A		;aeab
	ld a,(0ced3h)		;aeae
	and a			;aeb1
	call nz,L_BE85		;aeb2
	call 00156h		;aeb5   ; BIOS KILBUF - Clears keyboard buffer
	ld hl,(0fd9fh)		;aeb8
	ld (0ffb1h),hl		;aebb
	ld hl,0be7ch		;aebe
	ld (0ffb3h),hl		;aec1
	ld hl,0ced9h		;aec4
	ld de,0cedah		;aec7
	ld bc,0004ch		;aeca
	ld (hl),000h		;aecd
	ldir		;aecf
	xor a			;aed1
	ld (0c625h),a		;aed2
	ld (0c621h),a		;aed5
	inc a			;aed8
	ld (0cee0h),a		;aed9
	ld (0cee1h),a		;aedc
	ld a,0a0h		;aedf
	ld (0c60eh),a		;aee1
	ld (0cf0fh),a		;aee4
	ld a,060h		;aee7
	ld (0c611h),a		;aee9
	ld (0cf10h),a		;aeec
	call L_67D7		;aeef
	call 00044h		;aef2   ; BIOS ENASCR - Displays the screen
	ld hl,0b46ch		;aef5
	ld de,0c853h		;aef8
	ld bc,00003h		;aefb
	ldir		;aefe
L_AF00:
	ld sp,0f380h		;af00
	ld a,(0ceddh)		;af03
	and a			;af06
	jr z,L_AF10		;af07
	sub 003h		;af09
	jr c,L_AF5D		;af0b
	ld (0ced9h),a		;af0d
L_AF10:
	xor a			;af10
	ld (0ceddh),a		;af11
	ld (0cedfh),a		;af14
	ld a,(0cee1h)		;af17
	ld (0cee0h),a		;af1a
	call L_B954		;af1d
	ld iy,0cedah		;af20
	ld a,(0ced9h)		;af24
	and a			;af27
	jr nz,L_AF37		;af28
	call L_B46F		;af2a
	ld a,003h		;af2d
	ld hl,0afadh		;af2f
	ld de,01842h		;af32
	jr L_AF53		;af35
L_AF37:
	inc iy		;af37
	dec a			;af39
	jr nz,L_AF46		;af3a
	call L_B488		;af3c
	ld a,002h		;af3f
	ld hl,0afb3h		;af41
	jr L_AF50		;af44
L_AF46:
	inc iy		;af46
	call L_B4C3		;af48
	ld a,005h		;af4b
	ld hl,0afb7h		;af4d
L_AF50:
	ld de,018c2h		;af50
L_AF53:
	ld (0ceech),a		;af53
	ld (0ceedh),hl		;af56
	ld (0cef1h),de		;af59
L_AF5D:
	ld de,0afc1h		;af5d
	call L_B4F0		;af60
	ld a,(iy+000h)		;af63
	ld bc,02000h		;af66
	call L_B650		;af69
	ld a,(0ceech)		;af6c
	ld c,a			;af6f
	ld a,(0ceddh)		;af70
	and a			;af73
	ld b,a			;af74
	ld a,(iy+000h)		;af75
	jr z,L_AF91		;af78
	dec b			;af7a
	jr z,L_AF89		;af7b
	dec b			;af7d
	jp nz,L_AF00		;af7e
	dec a			;af81
	jp p,L_AF8E		;af82
	ld a,c			;af85
	dec a			;af86
	jr L_AF8E		;af87
L_AF89:
	inc a			;af89
	cp c			;af8a
	jr nz,L_AF8E		;af8b
	xor a			;af8d
L_AF8E:
	ld (iy+000h),a		;af8e
L_AF91:
	ld bc,02f00h		;af91
	call L_B650		;af94
	xor a			;af97
	ld (0ceddh),a		;af98
	ld d,a			;af9b
	ld hl,L_AF5D		;af9c
	push hl			;af9f
	ld hl,(0ceedh)		;afa0
	ld e,(iy+000h)		;afa3
	add hl,de			;afa6
	add hl,de			;afa7
	ld a,(hl)			;afa8
	inc hl			;afa9
	ld h,(hl)			;afaa
	ld l,a			;afab
	jp (hl)			;afac

; ----------------------------------------------------------------------
; DATOS tabla_de_estados: Diez punteros: el despachador de 0xAFAC y 0xAFCE
;   salta por aqui. 0xAFB3 y 0xAFB7 son desplazamientos DENTRO de esta misma
;   tabla, o sea sub-menus del editor
;   0xafad..0xafc1  (20 bytes)
DATA_tabla_de_estados:
	defw 0afcfh,0b0adh,0b117h,0b21ah	; afad  -> L_AFCF L_B0AD L_B117 L_B21A
	defw 0b2d7h,0b304h,0b35ch,0b37ch	; afb5  -> L_B2D7 L_B304 L_B35C L_B37C
	defw 0b37ch,0b37ch	; afbd  -> L_B37C L_B37C

; ----------------------------------------------------------------------
; DATOS cuatro_de_0xafc1: Los cuatro bytes que 0xAF5D pasa a 0xB4F0
;   0xafc1..0xafc5  (4 bytes)
DATA_cuatro_de_0xafc1:
	defb 00ch,00bh,00ah,000h	; afc1

; ======================================================================
; CODIGO 0xafc5..0xb09e  (217 bytes)
; ======================================================================


L_AFC5:
	dec c			;afc5
	ld b,000h		;afc6
	add hl,bc			;afc8
	add hl,bc			;afc9
	ld e,(hl)			;afca
	inc hl			;afcb
	ld d,(hl)			;afcc
	ex de,hl			;afcd
	jp (hl)			;afce
L_AFCF:
	call L_B528		;afcf
L_AFD2:
	ld hl,(0ceefh)		;afd2
	ld de,00207h		;afd5
	add hl,de			;afd8
	ld (0cee2h),hl		;afd9
	xor a			;afdc
	ld (0cee8h),a		;afdd
L_AFE0:
	call L_B6A0		;afe0
	call L_B73C		;afe3
L_AFE6:
	call L_BB7D		;afe6
	ld c,000h		;afe9
	cp 020h		;afeb
	jr z,L_B016		;afed
	cp 058h		;afef
	jr z,L_B016		;aff1
	cp 05ah		;aff3
	jr z,L_B016		;aff5
	cp 02fh		;aff7
	jp z,L_B0A7		;aff9
	cp 00ch		;affc
	jr z,L_B054		;affe
	call L_BBF9		;b000
	jr z,L_B007		;b003
	jr L_AFE6		;b005
L_B007:
	call L_BBE5		;b007
	jr z,L_B011		;b00a
	call L_B6C2		;b00c
	jr L_AFE0		;b00f
L_B011:
	call L_B668		;b011
	jr L_AFD2		;b014
L_B016:
	push af			;b016
	call L_B8BE		;b017
	ld a,(hl)			;b01a
	cp 0d7h		;b01b
	jr c,L_B023		;b01d
	cp 0f8h		;b01f
	jr c,L_B027		;b021
L_B023:
	call L_B8A9		;b023
	ld (hl),a			;b026
L_B027:
	call L_B954		;b027
	pop af			;b02a
	cp 05ah		;b02b
	jr z,L_B040		;b02d
	cp 020h		;b02f
	jr z,L_B04D		;b031
	ld c,003h		;b033
	call L_B668		;b035
L_B038:
	ld c,003h		;b038
	call L_B6C2		;b03a
	jp L_AFD2		;b03d
L_B040:
	ld c,002h		;b040
	call L_B668		;b042
L_B045:
	ld c,002h		;b045
	call L_B6C2		;b047
	jp L_AFD2		;b04a
L_B04D:
	call L_BBE5		;b04d
	jr z,L_B045		;b050
	jr L_B038		;b052
L_B054:
	ld de,0b09eh		;b054
	call L_BC23		;b057
	call L_BB7D		;b05a
	cp 00dh		;b05d
	jr nz,L_B090		;b05f
	ld a,(0cee1h)		;b061
	push af			;b064
	ld h,a			;b065
	ld l,017h		;b066
	call L_B834		;b068
	call L_B8A9		;b06b
	ld bc,01418h		;b06e
	call L_BA2B		;b071
	pop af			;b074
	call L_B871		;b075
	ld (hl),000h		;b078
	call L_B87B		;b07a
	ld (hl),000h		;b07d
	call L_B864		;b07f
	ld de,0b46ch		;b082
	ld b,003h		;b085
L_B087:
	ld a,(de)			;b087
	ld (hl),a			;b088
	inc de			;b089
	inc hl			;b08a
	djnz L_B087		;b08b
	call L_B954		;b08d
L_B090:
	ld bc,00109h		;b090
	ld hl,018c1h		;b093
	ld d,020h		;b096
	call L_B908		;b098
	jp L_AFD2		;b09b

; ----------------------------------------------------------------------
; DATOS rotulo_seguro: "SURE>>" en 0x18C2, la pregunta antes de borrar
;   0xb09e..0xb0a7  (9 bytes)
DATA_rotulo_seguro:
	defb 0c2h,018h,053h,055h,052h,045h,03eh,03eh,040h	; b09e  ..SURE>>@

; ======================================================================
; CODIGO 0xb0a7..0xb2a4  (509 bytes)
; ======================================================================


L_B0A7:
	call L_B806		;b0a7
	jp L_AFD2		;b0aa
L_B0AD:
	call L_B539		;b0ad
	xor a			;b0b0
L_B0B1:
	push af			;b0b1
	ld a,(0cee9h)		;b0b2
	ld bc,02001h		;b0b5
	ld de,01902h		;b0b8
	call L_B654		;b0bb
	pop af			;b0be
	ld (0cee9h),a		;b0bf
	ld a,(0cee9h)		;b0c2
	push af			;b0c5
	ld bc,05f01h		;b0c6
	ld de,01902h		;b0c9
	call L_B654		;b0cc
	pop af			;b0cf
	ld c,001h		;b0d0
	cp 003h		;b0d2
	jr c,L_B0D7		;b0d4
	inc c			;b0d6
L_B0D7:
	ld a,c			;b0d7
	ld (0cee8h),a		;b0d8
L_B0DB:
	call L_B73C		;b0db
L_B0DE:
	call L_BB7D		;b0de
	ld c,000h		;b0e1
	cp 020h		;b0e3
	jr z,L_B109		;b0e5
	and a			;b0e7
	call L_BBF9		;b0e8
	jr z,L_B0EF		;b0eb
	jr L_B0DE		;b0ed
L_B0EF:
	call L_BBE5		;b0ef
	jr z,L_B0F9		;b0f2
	call L_B6C2		;b0f4
	jr L_B0DB		;b0f7
L_B0F9:
	ld a,(0cee9h)		;b0f9
	dec a			;b0fc
	dec c			;b0fd
	jr z,L_B105		;b0fe
	dec c			;b100
	jr nz,L_B0DE		;b101
	inc a			;b103
	inc a			;b104
L_B105:
	and 007h		;b105
	jr L_B0B1		;b107
L_B109:
	call L_B9B4		;b109
	call L_B954		;b10c
	ld hl,01842h		;b10f
	ld (0cef1h),hl		;b112
	jr L_B0DE		;b115
L_B117:
	call L_B229		;b117
	call L_B58B		;b11a
	ld a,(0cf19h)		;b11d
	ld c,a			;b120
	and a			;b121
	jr nz,L_B131		;b122
	ld de,0bdc8h		;b124
	ld b,004h		;b127
	call L_BC37		;b129
L_B12C:
	call L_BB7D		;b12c
	jr L_B12C		;b12f
L_B131:
	xor a			;b131
	ld hl,0cf13h		;b132
	ld b,006h		;b135
L_B137:
	ld (hl),a			;b137
	inc hl			;b138
	djnz L_B137		;b139
	push bc			;b13b
	ld (0cee9h),a		;b13c
	ld (0c613h),a		;b13f
	call busca_bandera_y_tee		;b142
	ld hl,(0cec4h)		;b145
	ld (0cf11h),hl		;b148
	ld a,h			;b14b
	ld (0c60eh),a		;b14c
	ld a,l			;b14f
	ld (0c611h),a		;b150
	call pinta_los_sprites		;b153
	pop bc			;b156
	ld b,c			;b157
	dec b			;b158
	dec b			;b159
	ld ix,0cf13h		;b15a
L_B15E:
	push bc			;b15e
	ld a,(0cee9h)		;b15f
	ld bc,05f00h		;b162
	ld de,01964h		;b165
	call L_B654		;b168
	pop bc			;b16b
L_B16C:
	call L_BB7D		;b16c
	cp 020h		;b16f
	jr z,L_B181		;b171
	call L_BBF9		;b173
	jr z,L_B17A		;b176
	jr L_B16C		;b178
L_B17A:
	push bc			;b17a
	call L_B7AF		;b17b
	pop bc			;b17e
	jr L_B16C		;b17f
L_B181:
	ld hl,(0cf11h)		;b181
	ex de,hl			;b184
	ld (ix+000h),e		;b185
	inc ix		;b188
	ld (ix+000h),d		;b18a
	inc ix		;b18d
	push bc			;b18f
	ld hl,0cee9h		;b190
	ld a,(hl)			;b193
	inc (hl)			;b194
	ld bc,02000h		;b195
	ld de,01964h		;b198
	call L_B654		;b19b
	pop bc			;b19e
	djnz L_B15E		;b19f
	call L_B1A7		;b1a1
	jp L_B117		;b1a4
L_B1A7:
	ld bc,00000h		;b1a7
	ld hl,(0cf13h)		;b1aa
	ld de,(0cec4h)		;b1ad
	call L_646D		;b1b1
	ld hl,(0cf15h)		;b1b4
	ld a,l			;b1b7
	or h			;b1b8
	jr z,L_B1D0		;b1b9
	ld de,(0cf13h)		;b1bb
	call L_646D		;b1bf
	ld hl,(0cf17h)		;b1c2
	ld a,l			;b1c5
	or h			;b1c6
	jr z,L_B1D0		;b1c7
	ld de,(0cf15h)		;b1c9
	call L_646D		;b1cd
L_B1D0:
	ld l,c			;b1d0
	ld h,b			;b1d1
	add hl,hl			;b1d2
	ld a,r		;b1d3
	rrca			;b1d5
	jr nc,L_B1D9		;b1d6
	inc hl			;b1d8
L_B1D9:
	ld de,003e8h		;b1d9
	rst 20h			;b1dc
	jr c,L_B1E2		;b1dd
	ld hl,003e7h		;b1df
L_B1E2:
	ld a,(0cee1h)		;b1e2
	ld c,a			;b1e5
	add a,a			;b1e6
	add a,c			;b1e7
	ld c,a			;b1e8
	ld b,000h		;b1e9
	ld ix,0cf48h		;b1eb
	add ix,bc		;b1ef
	ld de,00064h		;b1f1
	call L_B201		;b1f4
	ld de,0000ah		;b1f7
	call L_B201		;b1fa
	ld de,00001h		;b1fd
	inc b			;b200
L_B201:
	ld a,02fh		;b201
L_B203:
	inc a			;b203
	and a			;b204
	sbc hl,de		;b205
	jr nc,L_B203		;b207
	add hl,de			;b209
	inc b			;b20a
	cp 030h		;b20b
	jr nz,L_B214		;b20d
	dec b			;b20f
	jr nz,L_B214		;b210
	ld a,020h		;b212
L_B214:
	ld (ix+000h),a		;b214
	inc ix		;b217
	ret			;b219
L_B21A:
	call L_B229		;b21a
	call L_478D		;b21d
	call L_B278		;b220
	call juega_un_golpe		;b223
	jp L_AF00		;b226
L_B229:
	call L_B82E		;b229
L_B22C:
	ld de,0cccch		;b22c
	ld b,018h		;b22f
L_B231:
	push bc			;b231
	ld bc,00014h		;b232
	ldir		;b235
	ex de,hl			;b237
	push de			;b238
	ld de,0ffd8h		;b239
	add hl,de			;b23c
	pop de			;b23d
	ex de,hl			;b23e
	pop bc			;b23f
	djnz L_B231		;b240
	ret			;b242
L_B243:
	call 0009ch		;b243   ; BIOS CHSNS - Tests the status of the keyboard buffer
	ret z			;b246
	call 0009fh		;b247   ; BIOS CHGET - One character input (waiting)
	cp 00bh		;b24a
	jr nz,L_B265		;b24c
	call busca_bandera_y_tee		;b24e
	ld a,(0cec5h)		;b251
	ld (0c60eh),a		;b254
	ld a,(0cec4h)		;b257
L_B25A:
	ld (0c611h),a		;b25a
	call pinta_los_sprites		;b25d
	call L_478D		;b260
	jr L_B27B		;b263
L_B265:
	cp 02fh		;b265
	jr nz,L_B274		;b267
	ld a,(0cf0fh)		;b269
	ld (0c60eh),a		;b26c
	ld a,(0cf10h)		;b26f
	jr L_B25A		;b272
L_B274:
	cp 02bh		;b274
	jr nz,L_B285		;b276
L_B278:
	call busca_bandera_y_tee		;b278
L_B27B:
	ld hl,(0c63fh)		;b27b
	call L_47B0		;b27e
	ld (0c61fh),a		;b281
	ret			;b284
L_B285:
	call L_BBF9		;b285
	jr nz,L_B294		;b288
	call L_BBE5		;b28a
	jr z,L_B29B		;b28d
	call L_BBEF		;b28f
	jr z,$+26		;b292
L_B294:
	call L_BBC2		;b294
	ret z			;b297
	pop hl			;b298
	pop hl			;b299
	ret			;b29a
L_B29B:
	ld hl,0b2a4h		;b29b
	call L_AFC5		;b29e
	jp L_4B47		;b2a1

; ----------------------------------------------------------------------
; DATOS tabla_del_setchr: Cuatro punteros del submenu de elegir casilla, que
;   0xB29B pasa al mismo despachador de 0xAFC5
;   0xb2a4..0xb2ac  (8 bytes)
DATA_tabla_del_setchr:
	defw 0b2cbh,0b2cfh,0b2b5h,0b2b9h	; b2a4  -> L_B2CB L_B2CF L_B2B5 L_B2B9

; ======================================================================
; CODIGO 0xb2ac..0xb46c  (448 bytes)
; ======================================================================


L_B2AC:
	dec c			;b2ac
	jp z,L_BC0D		;b2ad
	dec c			;b2b0
	jp z,L_BC13		;b2b1
	ret			;b2b4
L_B2B5:
	ld b,001h		;b2b5
	jr L_B2BB		;b2b7
L_B2B9:
	ld b,0ffh		;b2b9
L_B2BB:
	ld a,(0c625h)		;b2bb
	ld c,a			;b2be
	add a,b			;b2bf
	and 007h		;b2c0
	ld b,a			;b2c2
	ld a,c			;b2c3
	and 0f8h		;b2c4
	add a,b			;b2c6
L_B2C7:
	ld (0c625h),a		;b2c7
	ret			;b2ca
L_B2CB:
	ld b,008h		;b2cb
	jr L_B2D1		;b2cd
L_B2CF:
	ld b,0f8h		;b2cf
L_B2D1:
	ld a,(0c625h)		;b2d1
	add a,b			;b2d4
	jr L_B2C7		;b2d5
L_B2D7:
	call L_B229		;b2d7
L_B2DA:
	xor a			;b2da
	ld (0c613h),a		;b2db
	call pinta_los_sprites		;b2de
L_B2E1:
	call L_BB7D		;b2e1
	cp 00bh		;b2e4
	jr z,L_B2F4		;b2e6
	call L_BBF9		;b2e8
	jr z,L_B2EF		;b2eb
	jr L_B2E1		;b2ed
L_B2EF:
	call L_B7AF		;b2ef
	jr L_B2E1		;b2f2
L_B2F4:
	call busca_bandera_y_tee		;b2f4
	ld hl,(0cec4h)		;b2f7
	ld a,h			;b2fa
	ld (0c60eh),a		;b2fb
	ld a,l			;b2fe
	ld (0c611h),a		;b2ff
	jr L_B2DA		;b302
L_B304:
	call L_B345		;b304
	jr nz,L_B30E		;b307
L_B309:
	call L_BB7D		;b309
	jr L_B309		;b30c
L_B30E:
	call L_B5E8		;b30e
	call L_BA91		;b311
	ld a,(0ceddh)		;b314
	and a			;b317
	ret nz			;b318
	call L_BF14		;b319
	push hl			;b31c
	ld a,012h		;b31d
	ld bc,08e75h		;b31f
L_B322:
	ld hl,0cf97h		;b322
	ld e,(hl)			;b325
	inc hl			;b326
	ld d,(hl)			;b327
	ex de,hl			;b328
	add hl,bc			;b329
	ex de,hl			;b32a
	ld (hl),d			;b32b
	dec hl			;b32c
	ld (hl),e			;b32d
	inc hl			;b32e
	inc hl			;b32f
	dec a			;b330
	jr nz,L_B322		;b331
	ld hl,0cf81h		;b333
	pop de			;b336
	ld a,001h		;b337
	call L_BDF1		;b339
	call c,L_B5F4		;b33c
	call L_BE85		;b33f
	jp L_AF00		;b342
L_B345:
	ld hl,0cf27h		;b345
	ld bc,00024h		;b348
	xor a			;b34b
	cpir		;b34c
	ret nz			;b34e
	call L_B937		;b34f
	ld b,004h		;b352
	ld de,0bdc8h		;b354
	call L_BC37		;b357
	xor a			;b35a
	ret			;b35b
L_B35C:
	call L_B5E8		;b35c
	call L_BA91		;b35f
	ld a,(0ceddh)		;b362
	and a			;b365
	ret nz			;b366
	ld hl,0cf81h		;b367
	call L_BE24		;b36a
	jr c,L_B376		;b36d
	call L_BE85		;b36f
	pop hl			;b372
	jp L_AF00		;b373
L_B376:
	call L_B5F4		;b376
	jp L_AF00		;b379
L_B37C:
	call L_B937		;b37c
	ld de,0bde8h		;b37f
	call L_BC23		;b382
	call L_BB7D		;b385
	cp 00dh		;b388
	jr nz,L_B37C		;b38a
	ld a,(0cedch)		;b38c
	cp 002h		;b38f
	jr z,L_B3DA		;b391
	cp 004h		;b393
	jp z,L_B43D		;b395
	call L_B82E		;b398
	ld de,0c673h		;b39b
	ld bc,001e0h		;b39e
	call L_B3CC		;b3a1
	ld a,(0cee1h)		;b3a4
	push af			;b3a7
	call L_B864		;b3a8
	ld de,0c853h		;b3ab
	ld bc,00003h		;b3ae
	call L_B3CC		;b3b1
	pop af			;b3b4
	push af			;b3b5
	call L_B871		;b3b6
	ld bc,00001h		;b3b9
	call L_B3CC		;b3bc
	pop af			;b3bf
	call L_B87B		;b3c0
	ld bc,00001h		;b3c3
	call L_B3CC		;b3c6
	jp L_B60B		;b3c9
L_B3CC:
	ld a,(de)			;b3cc
	push af			;b3cd
	ld a,(hl)			;b3ce
	ld (de),a			;b3cf
	pop af			;b3d0
	ld (hl),a			;b3d1
	inc de			;b3d2
	inc hl			;b3d3
	dec bc			;b3d4
	ld a,b			;b3d5
	or c			;b3d6
	jr nz,L_B3CC		;b3d7
	ret			;b3d9
L_B3DA:
	ld hl,0cec3h		;b3da
	call L_BBE5		;b3dd
	jr nz,L_B3EA		;b3e0
	dec (hl)			;b3e2
	jp p,L_B3F2		;b3e3
	ld (hl),023h		;b3e6
	jr L_B3F2		;b3e8
L_B3EA:
	inc (hl)			;b3ea
	ld a,(hl)			;b3eb
	cp 024h		;b3ec
	jr c,L_B3F2		;b3ee
	ld (hl),000h		;b3f0
L_B3F2:
	ld hl,0716bh		;b3f2
	ld (0c000h),hl		;b3f5
	xor a			;b3f8
	ld (0c006h),a		;b3f9
	call monta_el_hoyo		;b3fc
	ld a,001h		;b3ff
	ld (0c006h),a		;b401
	call L_B82E		;b404
	ex de,hl			;b407
	ld hl,0cccch		;b408
	ld b,018h		;b40b
L_B40D:
	push bc			;b40d
	ld bc,00014h		;b40e
	ldir		;b411
	push de			;b413
	ld de,0ffd8h		;b414
	add hl,de			;b417
	pop de			;b418
	pop bc			;b419
	djnz L_B40D		;b41a
	ld a,(0cee1h)		;b41c
	push af			;b41f
	call L_B864		;b420
	ex de,hl			;b423
	ld hl,0cecfh		;b424
	ld bc,00003h		;b427
	ldir		;b42a
	pop af			;b42c
	push af			;b42d
	call L_B871		;b42e
	ld a,(0c06ch)		;b431
	ld (hl),a			;b434
	pop af			;b435
	call L_B87B		;b436
	ld (hl),001h		;b439
	jr L_B457		;b43b
L_B43D:
	ld hl,0cf27h		;b43d
	ld d,h			;b440
	ld e,l			;b441
	inc de			;b442
	ld (hl),000h		;b443
	ld bc,02219h		;b445
	ldir		;b448
	call L_B45A		;b44a
	ld hl,00100h		;b44d
	ld (0cedfh),hl		;b450
	ld a,h			;b453
	ld (0cee1h),a		;b454
L_B457:
	jp L_B60B		;b457
L_B45A:
	ld de,0cf4bh		;b45a
	ld b,012h		;b45d
L_B45F:
	push bc			;b45f
	ld hl,0b46ch		;b460
	ld bc,00003h		;b463
	ldir		;b466
	pop bc			;b468
	djnz L_B45F		;b469
	ret			;b46b

; ----------------------------------------------------------------------
; DATOS casilla_en_blanco: Los tres caracteres de una casilla de marcador
;   vacia: dos espacios y un cero
;   0xb46c..0xb46f  (3 bytes)
DATA_casilla_en_blanco:
	defb 020h,020h,030h	; b46c

; ======================================================================
; CODIGO 0xb46f..0xb501  (146 bytes)
; ======================================================================


L_B46F:
	call L_B4E4		;b46f
	ld de,0b501h		;b472
	call L_B4F0		;b475
	ld b,000h		;b478
	call L_B939		;b47a
	ld b,004h		;b47d
	ld de,0bc3dh		;b47f
	call L_BC37		;b482
	jp L_B623		;b485
L_B488:
	call L_B4E4		;b488
	ld de,0b50fh		;b48b
	call L_B4F0		;b48e
	ld b,000h		;b491
	call L_B939		;b493
	ld b,005h		;b496
	ld de,0bc71h		;b498
	call L_BC37		;b49b
	ld b,003h		;b49e
	ld de,0bc5ch		;b4a0
	call L_BC37		;b4a3
	ld bc,00109h		;b4a6
	ld hl,01921h		;b4a9
	ld d,03dh		;b4ac
	call L_B908		;b4ae
	ld hl,019e1h		;b4b1
	call L_B908		;b4b4
	call L_B60B		;b4b7
	call L_680A		;b4ba
	call L_4AB2		;b4bd
	jp L_4B47		;b4c0
L_B4C3:
	call L_B4E4		;b4c3
	ld de,0b51bh		;b4c6
	call L_B4F0		;b4c9
	ld b,000h		;b4cc
	call L_B939		;b4ce
	ld b,005h		;b4d1
	ld de,0bc71h		;b4d3
	call L_BC37		;b4d6
	ld b,005h		;b4d9
	ld de,0bcadh		;b4db
	call L_BC37		;b4de
	jp L_B60B		;b4e1
L_B4E4:
	ld a,(0cee1h)		;b4e4
	ld h,a			;b4e7
	ld l,000h		;b4e8
	ld (0cedfh),hl		;b4ea
	jp L_B954		;b4ed
L_B4F0:
	ld a,(de)			;b4f0
	add a,a			;b4f1
	add a,a			;b4f2
	push af			;b4f3
	ld l,a			;b4f4
	ld h,01bh		;b4f5
	ld a,0d1h		;b4f7
	call 0004dh		;b4f9   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;b4fc
	pop af			;b4fd
	jr nz,L_B4F0		;b4fe
	ret			;b500

; ----------------------------------------------------------------------
; DATOS sprites_a_esconder_1: Los planos de sprite que hay que apartar en la
;   pantalla principal del editor, cerrados con un cero
;   0xb501..0xb50f  (14 bytes)
DATA_sprites_a_esconder_1:
	defb 00dh,00ch,00bh,00ah,009h,008h,007h,006h,005h,004h,003h,002h,001h,000h	; b501  ..............

; ----------------------------------------------------------------------
; DATOS sprites_a_esconder_2: Los de la pantalla de dibujar
;   0xb50f..0xb51b  (12 bytes)
DATA_sprites_a_esconder_2:
	defb 00dh,00ch,00bh,00ah,009h,007h,006h,004h,003h,002h,001h,000h	; b50f  ............

; ----------------------------------------------------------------------
; DATOS sprites_a_esconder_3: Los de la pantalla de grabar
;   0xb51b..0xb528  (13 bytes)
DATA_sprites_a_esconder_3:
	defb 00ch,00bh,00ah,009h,008h,007h,006h,005h,004h,003h,002h,001h,000h	; b51b  .............

; ======================================================================
; CODIGO 0xb528..0xb603  (219 bytes)
; ======================================================================


L_B528:
	ld b,007h		;b528
	call L_B939		;b52a
	ld de,0bcd1h		;b52d
	ld hl,018e2h		;b530
	ld bc,00811h		;b533
	jp L_B91D		;b536
L_B539:
	ld b,007h		;b539
	call L_B939		;b53b
	ld bc,00109h		;b53e
	ld hl,018e1h		;b541
	ld d,03dh		;b544
	call L_B908		;b546
	ld bc,00333h		;b549
	ld hl,01903h		;b54c
L_B54F:
	ld de,0bc50h		;b54f
	call L_BC29		;b552
	ld de,0001eh		;b555
	add hl,de			;b558
	ld a,c			;b559
	call 0004dh		;b55a   ; BIOS WRTVRM - Writes data in VRAM
	inc c			;b55d
	inc de			;b55e
	add hl,de			;b55f
	djnz L_B54F		;b560
	ld de,0bd59h		;b562
	ld hl,01906h		;b565
	ld bc,00306h		;b568
	call L_B91D		;b56b
	ld b,005h		;b56e
	ld a,031h		;b570
	ld hl,019c3h		;b572
	ld de,00040h		;b575
L_B578:
	call 0004dh		;b578   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;b57b
	inc a			;b57c
	djnz L_B578		;b57d
	ld de,0bd6bh		;b57f
	ld hl,019c4h		;b582
	ld bc,0040ah		;b585
	jp L_B91D		;b588
L_B58B:
	call L_B4E4		;b58b
	ld b,007h		;b58e
	call L_B939		;b590
	ld bc,00109h		;b593
	ld hl,018e1h		;b596
	ld d,03dh		;b599
	call L_B908		;b59b
	ld hl,01a41h		;b59e
	call L_B908		;b5a1
	xor a			;b5a4
	ld (0cf19h),a		;b5a5
	ld a,(0cee1h)		;b5a8
	ld b,a			;b5ab
	call L_B87B		;b5ac
	ld a,(hl)			;b5af
	and a			;b5b0
	ret z			;b5b1
	ld a,b			;b5b2
	call L_B871		;b5b3
	ld a,(hl)			;b5b6
	and a			;b5b7
	ret z			;b5b8
	ld (0cf19h),a		;b5b9
	sub 002h		;b5bc
	ld b,a			;b5be
	ld de,0bdaeh		;b5bf
	call L_BC37		;b5c2
	ld de,0bda3h		;b5c5
	call L_BC23		;b5c8
	call L_BC23		;b5cb
	ld hl,019e3h		;b5ce
	call L_B63C		;b5d1
	ld hl,01927h		;b5d4
L_B5D7:
	push de			;b5d7
	push hl			;b5d8
	ld a,(0cee1h)		;b5d9
	call L_B871		;b5dc
	ld a,(hl)			;b5df
	add a,030h		;b5e0
	pop hl			;b5e2
	call 0004dh		;b5e3   ; BIOS WRTVRM - Writes data in VRAM
	pop de			;b5e6
	ret			;b5e7
L_B5E8:
	call L_B937		;b5e8
	ld de,0bdc0h		;b5eb
	call L_BC23		;b5ee
	jp L_BB69		;b5f1
L_B5F4:
	call L_B937		;b5f4
	ld de,0b603h		;b5f7
	call L_BC23		;b5fa
	call 00156h		;b5fd   ; BIOS KILBUF - Clears keyboard buffer
	jp 0009fh		;b600   ; BIOS CHGET - One character input (waiting)

; ----------------------------------------------------------------------
; DATOS rotulo_error: "ERROR" en 0x1A83
;   0xb603..0xb60b  (8 bytes)
DATA_rotulo_error:
	defb 083h,01ah,045h,052h,052h,04fh,052h,040h	; b603  ..ERROR@

; ======================================================================
; CODIGO 0xb60b..0xb7a3  (408 bytes)
; ======================================================================


L_B60B:
	ld a,(0ced9h)		;b60b
	and a			;b60e
	jr z,L_B61D		;b60f
	ld hl,01867h		;b611
	call L_B5D7		;b614
	ld hl,01843h		;b617
	call L_B63C		;b61a
L_B61D:
	call L_B623		;b61d
	jp L_B954		;b620
L_B623:
	push hl			;b623
	push de			;b624
	push bc			;b625
	ld hl,01807h		;b626
	ld a,(0ced9h)		;b629
	and a			;b62c
	jr z,L_B632		;b62d
	ld hl,01827h		;b62f
L_B632:
	ld a,(0cee1h)		;b632
	call L_4A4B		;b635
	pop bc			;b638
	pop de			;b639
	pop hl			;b63a
	ret			;b63b
L_B63C:
	push hl			;b63c
	ld a,(0cee1h)		;b63d
	call L_B864		;b640
	ex de,hl			;b643
	pop hl			;b644
	ld b,003h		;b645
L_B647:
	ld a,(de)			;b647
	call 0004dh		;b648   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;b64b
	inc hl			;b64c
	djnz L_B647		;b64d
	ret			;b64f
L_B650:
	ld de,(0cef1h)		;b650
L_B654:
	push af			;b654
	push hl			;b655
	ld l,a			;b656
	ld h,000h		;b657
	inc c			;b659
	dec c			;b65a
	jr z,L_B65E		;b65b
	add hl,hl			;b65d
L_B65E:
	call L_B898		;b65e
	ld a,b			;b661
	call 0004dh		;b662   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;b665
	pop af			;b666
	ret			;b667
L_B668:
	ld hl,(0ceefh)		;b668
	dec c			;b66b
	jr z,L_B68C		;b66c
	dec c			;b66e
	jr z,L_B696		;b66f
	dec c			;b671
	jr z,L_B680		;b672
	dec c			;b674
	ret nz			;b675
	dec h			;b676
	ld a,h			;b677
	and a			;b678
	jp p,L_B688		;b679
	ld h,007h		;b67c
	jr L_B688		;b67e
L_B680:
	inc h			;b680
	ld a,h			;b681
	cp 008h		;b682
	jr c,L_B688		;b684
	ld h,000h		;b686
L_B688:
	ld (0ceefh),hl		;b688
	ret			;b68b
L_B68C:
	dec l			;b68c
	ld a,l			;b68d
	and a			;b68e
	jp p,L_B688		;b68f
	ld l,010h		;b692
	jr L_B688		;b694
L_B696:
	inc l			;b696
	ld a,l			;b697
	cp 011h		;b698
	jr c,L_B688		;b69a
	ld l,000h		;b69c
	jr L_B688		;b69e
L_B6A0:
	push de			;b6a0
	push hl			;b6a1
	ld hl,(0cee2h)		;b6a2
	add hl,hl			;b6a5
	add hl,hl			;b6a6
	add hl,hl			;b6a7
	dec h			;b6a8
	dec h			;b6a9
	ld d,h			;b6aa
	ld a,l			;b6ab
	sub 003h		;b6ac
	ld hl,01b28h		;b6ae
	call 0004dh		;b6b1   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;b6b4
	ld a,d			;b6b5
	call 0004dh		;b6b6   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;b6b9
	ld a,04ch		;b6ba
	call 0004dh		;b6bc   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;b6bf
	pop de			;b6c0
	ret			;b6c1
L_B6C2:
	ld a,(0cee8h)		;b6c2
	ld hl,(0cee6h)		;b6c5
	dec c			;b6c8
	jr z,L_B6FF		;b6c9
	dec c			;b6cb
	jr z,L_B716		;b6cc
	dec c			;b6ce
	jr z,L_B6E1		;b6cf
	dec c			;b6d1
	ret nz			;b6d2
	inc h			;b6d3
	dec h			;b6d4
	jr z,L_B6DA		;b6d5
	dec h			;b6d7
	jr L_B6FB		;b6d8
L_B6DA:
	and a			;b6da
	jr nz,L_B6FB		;b6db
	ld h,013h		;b6dd
	jr L_B6FF		;b6df
L_B6E1:
	ld b,014h		;b6e1
	inc h			;b6e3
	ld c,a			;b6e4
	and a			;b6e5
	jr z,L_B6EE		;b6e6
	ld b,012h		;b6e8
	dec a			;b6ea
	jr z,L_B6EE		;b6eb
	dec b			;b6ed
L_B6EE:
	ld a,h			;b6ee
	cp b			;b6ef
	jr c,L_B6FB		;b6f0
	dec h			;b6f2
	ld a,c			;b6f3
	and a			;b6f4
	jr nz,L_B6FB		;b6f5
	ld h,000h		;b6f7
	jr L_B716		;b6f9
L_B6FB:
	ld (0cee6h),hl		;b6fb
	ret			;b6fe
L_B6FF:
	ld b,000h		;b6ff
	dec l			;b701
	ld a,l			;b702
	and a			;b703
	jp p,L_B709		;b704
	inc l			;b707
	inc b			;b708
L_B709:
	ld (0cee6h),hl		;b709
	ld hl,(0cedfh)		;b70c
	inc b			;b70f
	dec b			;b710
	jr z,L_B730		;b711
	inc l			;b713
	jr L_B730		;b714
L_B716:
	ld b,018h		;b716
	inc l			;b718
	and a			;b719
	jr z,L_B71D		;b71a
	dec b			;b71c
L_B71D:
	ld a,l			;b71d
	cp b			;b71e
	ld b,000h		;b71f
	jr c,L_B725		;b721
	dec l			;b723
	inc b			;b724
L_B725:
	ld (0cee6h),hl		;b725
	ld hl,(0cedfh)		;b728
	inc b			;b72b
	dec b			;b72c
	jr z,L_B730		;b72d
	dec l			;b72f
L_B730:
	call L_B8D0		;b730
	call L_B623		;b733
	inc b			;b736
	dec b			;b737
	call nz,L_B954		;b738
	ret			;b73b
L_B73C:
	push bc			;b73c
	push de			;b73d
	push hl			;b73e
	ld hl,(0cee6h)		;b73f
	ld de,0b7a3h		;b742
	ld a,(0cee8h)		;b745
	and a			;b748
	jr z,L_B769		;b749
	push af			;b74b
	ld a,l			;b74c
	cp 017h		;b74d
	jr c,L_B752		;b74f
	dec l			;b751
L_B752:
	ld a,h			;b752
	cp 011h		;b753
	jr c,L_B759		;b755
	ld h,011h		;b757
L_B759:
	pop af			;b759
	ld de,0b7a7h		;b75a
	dec a			;b75d
	jr z,L_B769		;b75e
	ld de,0b7abh		;b760
	ld a,h			;b763
	cp 011h		;b764
	jr c,L_B769		;b766
	dec h			;b768
L_B769:
	ld (0cee6h),hl		;b769
	add hl,hl			;b76c
	add hl,hl			;b76d
	add hl,hl			;b76e
	ld a,h			;b76f
	add a,058h		;b770
	ld b,a			;b772
	ld c,l			;b773
	dec c			;b774
	ld hl,01b2ch		;b775
	ld a,c			;b778
	call 0004dh		;b779   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;b77c
	ld a,b			;b77d
	call 0004dh		;b77e   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;b781
	ld a,(de)			;b782
	call 0004dh		;b783   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;b786
	inc hl			;b787
	inc hl			;b788
	ld a,(de)			;b789
	cp 0d1h		;b78a
	jr z,L_B78F		;b78c
	add a,c			;b78e
L_B78F:
	call 0004dh		;b78f   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;b792
	inc hl			;b793
	ld a,(de)			;b794
	add a,b			;b795
	call 0004dh		;b796   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;b799
	inc hl			;b79a
	ld a,(de)			;b79b
	call 0004dh		;b79c   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;b79f
	pop de			;b7a0
	pop bc			;b7a1
	ret			;b7a2

; ----------------------------------------------------------------------
; DATOS sprites_del_cursor: Tres atributos de sprite de cuatro bytes: fila,
;   columna, dibujo y color del cursor del editor
;   0xb7a3..0xb7af  (12 bytes)
DATA_sprites_del_cursor:
	defb 050h,0d1h,000h,000h	; b7a3
	defb 054h,000h,008h,058h	; b7a7
	defb 054h,000h,010h,058h	; b7ab

; ======================================================================
; CODIGO 0xb7af..0xba81  (722 bytes)
; ======================================================================


L_B7AF:
	ld b,001h		;b7af
	call L_BBE5		;b7b1
	jr nz,L_B7B8		;b7b4
	ld b,008h		;b7b6
L_B7B8:
	ld a,(0c611h)		;b7b8
	ld l,a			;b7bb
	ld a,(0c60eh)		;b7bc
	sub 058h		;b7bf
	ld h,a			;b7c1
	dec c			;b7c2
	jr z,L_B7F1		;b7c3
	dec c			;b7c5
	jr z,L_B7FC		;b7c6
	dec c			;b7c8
	jr z,L_B7E7		;b7c9
	dec c			;b7cb
	ret nz			;b7cc
	ld a,h			;b7cd
	cp b			;b7ce
	jr c,L_B7D4		;b7cf
	sub b			;b7d1
	jr L_B7D5		;b7d2
L_B7D4:
	xor a			;b7d4
L_B7D5:
	ld h,a			;b7d5
L_B7D6:
	ld a,h			;b7d6
	add a,058h		;b7d7
	ld h,a			;b7d9
	ld (0c60eh),a		;b7da
	ld a,l			;b7dd
	ld (0c611h),a		;b7de
	ld (0cf11h),hl		;b7e1
	jp pinta_los_sprites		;b7e4
L_B7E7:
	ld a,h			;b7e7
	add a,b			;b7e8
	cp 0a0h		;b7e9
	jr c,L_B7D5		;b7eb
	ld a,09fh		;b7ed
	jr L_B7D5		;b7ef
L_B7F1:
	ld a,l			;b7f1
	cp b			;b7f2
	jr c,L_B7F8		;b7f3
	sub b			;b7f5
	jr L_B7F9		;b7f6
L_B7F8:
	xor a			;b7f8
L_B7F9:
	ld l,a			;b7f9
	jr L_B7D6		;b7fa
L_B7FC:
	ld a,l			;b7fc
	add a,b			;b7fd
	cp 0c0h		;b7fe
	jr c,L_B7F9		;b800
	ld a,0bfh		;b802
	jr L_B7F9		;b804
L_B806:
	push bc			;b806
	push hl			;b807
	call L_B8BE		;b808
	ld a,(hl)			;b80b
	ld hl,0bcd1h		;b80c
	ld bc,08800h		;b80f
L_B812:
	cp (hl)			;b812
	jr z,L_B81B		;b813
	inc hl			;b815
	inc c			;b816
	djnz L_B812		;b817
	jr L_B82B		;b819
L_B81B:
	ld l,000h		;b81b
	ld a,c			;b81d
L_B81E:
	cp 008h		;b81e
	jr c,L_B827		;b820
	sub 008h		;b822
	inc l			;b824
	jr L_B81E		;b825
L_B827:
	ld h,a			;b827
	ld (0ceefh),hl		;b828
L_B82B:
	pop hl			;b82b
	pop bc			;b82c
	ret			;b82d
L_B82E:
	ld a,(0cee1h)		;b82e
	ld h,a			;b831
	ld l,000h		;b832
L_B834:
	push bc			;b834
	push de			;b835
	ld c,l			;b836
	ld b,000h		;b837
	ld l,h			;b839
	dec l			;b83a
	ld h,b			;b83b
	add hl,hl			;b83c
	add hl,hl			;b83d
	add hl,hl			;b83e
	ld d,h			;b83f
	ld e,l			;b840
	add hl,hl			;b841
	add hl,de			;b842
	add hl,bc			;b843
	call L_B89F		;b844
	ld de,0d04bh		;b847
	add hl,de			;b84a
	pop de			;b84b
	pop bc			;b84c
	ret			;b84d
L_B84E:
	push af			;b84e
	ld hl,(0cedfh)		;b84f
	ld a,(0cee6h)		;b852
	neg		;b855
	add a,l			;b857
	add a,017h		;b858
	cp 018h		;b85a
	jr c,L_B861		;b85c
	inc h			;b85e
	sub 018h		;b85f
L_B861:
	ld l,a			;b861
	pop af			;b862
	ret			;b863
L_B864:
	push de			;b864
	ld d,a			;b865
	add a,a			;b866
	add a,d			;b867
	ld l,a			;b868
	ld h,000h		;b869
	ld de,0cf48h		;b86b
	add hl,de			;b86e
	pop de			;b86f
	ret			;b870
L_B871:
	push de			;b871
	ld l,a			;b872
	ld h,000h		;b873
	ld de,0cf38h		;b875
	add hl,de			;b878
	pop de			;b879
	ret			;b87a
L_B87B:
	push de			;b87b
	ld l,a			;b87c
	ld h,000h		;b87d
	ld de,0cf26h		;b87f
	add hl,de			;b882
	pop de			;b883
	ret			;b884
L_B885:
	push hl			;b885
	ld hl,(0cef9h)		;b886
	ld a,h			;b889
	add a,a			;b88a
	ld h,a			;b88b
	add a,a			;b88c
	add a,a			;b88d
	add a,h			;b88e
	add a,l			;b88f
	and a			;b890
	jr z,L_B895		;b891
	cp 013h		;b893
L_B895:
	ccf			;b895
	pop hl			;b896
	ret			;b897
L_B898:
	add hl,hl			;b898
	add hl,hl			;b899
	add hl,hl			;b89a
	add hl,hl			;b89b
	add hl,hl			;b89c
	add hl,de			;b89d
	ret			;b89e
L_B89F:
	push de			;b89f
	add hl,hl			;b8a0
	add hl,hl			;b8a1
	ld d,h			;b8a2
	ld e,l			;b8a3
	add hl,hl			;b8a4
	add hl,hl			;b8a5
	add hl,de			;b8a6
	pop de			;b8a7
	ret			;b8a8
L_B8A9:
	push de			;b8a9
	push hl			;b8aa
	ld hl,(0ceefh)		;b8ab
	ld e,h			;b8ae
	ld d,000h		;b8af
	ld h,d			;b8b1
	add hl,hl			;b8b2
	add hl,hl			;b8b3
	add hl,hl			;b8b4
	add hl,de			;b8b5
	ld de,0bcd1h		;b8b6
	add hl,de			;b8b9
	ld a,(hl)			;b8ba
	pop hl			;b8bb
	pop de			;b8bc
	ret			;b8bd
L_B8BE:
	push af			;b8be
	push de			;b8bf
	call L_B84E		;b8c0
	call L_B834		;b8c3
	ld a,(0cee7h)		;b8c6
	ld e,a			;b8c9
	ld d,000h		;b8ca
	add hl,de			;b8cc
	pop de			;b8cd
	pop af			;b8ce
	ret			;b8cf
L_B8D0:
	ld a,h			;b8d0
	and a			;b8d1
	jr z,L_B8EB		;b8d2
	cp 012h		;b8d4
	jr nc,L_B8F0		;b8d6
	ld a,l			;b8d8
	and a			;b8d9
	jp m,L_B8E6		;b8da
	cp 018h		;b8dd
	jr c,L_B8F9		;b8df
	inc h			;b8e1
	ld l,000h		;b8e2
	jr L_B8F9		;b8e4
L_B8E6:
	dec h			;b8e6
	ld l,017h		;b8e7
	jr nz,L_B8F9		;b8e9
L_B8EB:
	ld hl,00100h		;b8eb
	jr L_B8F9		;b8ee
L_B8F0:
	ld h,012h		;b8f0
	ld a,l			;b8f2
	and a			;b8f3
	jp m,L_B8E6		;b8f4
	ld l,000h		;b8f7
L_B8F9:
	ld a,(0cee6h)		;b8f9
	cp l			;b8fc
	ld a,h			;b8fd
	jr nc,L_B901		;b8fe
	inc a			;b900
L_B901:
	ld (0cee1h),a		;b901
	ld (0cedfh),hl		;b904
	ret			;b907
L_B908:
	push bc			;b908
	push hl			;b909
L_B90A:
	push bc			;b90a
	push hl			;b90b
	ld a,d			;b90c
	ld b,000h		;b90d
	call 00056h		;b90f   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;b912
	ld bc,00020h		;b913
	add hl,bc			;b916
	pop bc			;b917
	djnz L_B90A		;b918
	pop hl			;b91a
	pop bc			;b91b
	ret			;b91c
L_B91D:
	push bc			;b91d
	push de			;b91e
	push hl			;b91f
L_B920:
	push bc			;b920
	push hl			;b921
L_B922:
	ld a,(de)			;b922
	call 0004dh		;b923   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;b926
	inc hl			;b927
	djnz L_B922		;b928
	pop hl			;b92a
	ld bc,00020h		;b92b
	add hl,bc			;b92e
	pop bc			;b92f
	dec c			;b930
	jr nz,L_B920		;b931
	pop hl			;b933
	pop de			;b934
	pop bc			;b935
	ret			;b936
L_B937:
	ld b,012h		;b937
L_B939:
	push bc			;b939
	push de			;b93a
	push hl			;b93b
	ld l,b			;b93c
	ld h,000h		;b93d
	ld de,01801h		;b93f
	call L_B898		;b942
	ld a,018h		;b945
	sub b			;b947
	ld b,a			;b948
	ld c,009h		;b949
	ld d,020h		;b94b
	call L_B908		;b94d
	pop hl			;b950
	pop de			;b951
	pop bc			;b952
	ret			;b953
L_B954:
	push bc			;b954
	push de			;b955
	push hl			;b956
	ld hl,(0cedfh)		;b957
	call L_B834		;b95a
	ld de,01aebh		;b95d
	ld b,018h		;b960
L_B962:
	push bc			;b962
	ld bc,00014h		;b963
	push de			;b966
	call 0005ch		;b967   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;b96a
	ld bc,0ffe0h		;b96b
	add hl,bc			;b96e
	ex de,hl			;b96f
	pop bc			;b970
	djnz L_B962		;b971
	ld hl,0180ah		;b973
	ld bc,01801h		;b976
	ld d,021h		;b979
	call L_B908		;b97b
	ld hl,0181fh		;b97e
	call L_B908		;b981
	ld a,(0cedfh)		;b984
	ld b,a			;b987
	ld c,023h		;b988
	ld de,0180ah		;b98a
	call L_B9A2		;b98d
	dec c			;b990
	ld a,b			;b991
	sub 001h		;b992
	jr nc,L_B998		;b994
	ld a,017h		;b996
L_B998:
	ld de,0180ah		;b998
	call L_B9A2		;b99b
	pop hl			;b99e
	pop de			;b99f
	pop bc			;b9a0
	ret			;b9a1
L_B9A2:
	ld l,a			;b9a2
	ld h,000h		;b9a3
	call L_B898		;b9a5
	ld a,c			;b9a8
	call 0004dh		;b9a9   ; BIOS WRTVRM - Writes data in VRAM
	ld de,00015h		;b9ac
	add hl,de			;b9af
	ld a,c			;b9b0
	jp 0004dh		;b9b1   ; BIOS WRTVRM - Writes data in VRAM
L_B9B4:
	ld hl,(0cee6h)		;b9b4
	ex de,hl			;b9b7
	ld hl,(0cedfh)		;b9b8
	ld a,e			;b9bb
	inc a			;b9bc
	cp l			;b9bd
	ret z			;b9be
	call L_B84E		;b9bf
	call L_B834		;b9c2
	ld e,d			;b9c5
	ld d,000h		;b9c6
	add hl,de			;b9c8
	ld (0cef1h),hl		;b9c9
	ld a,(0cee8h)		;b9cc
	ld de,lba7dh		;b9cf
	call L_BA71		;b9d2
	call L_BA51		;b9d5
	ret c			;b9d8
	ld a,(0cee1h)		;b9d9
	ld h,a			;b9dc
	ld l,017h		;b9dd
	call L_B834		;b9df
	ld a,(0cee8h)		;b9e2
	ld de,0ba85h		;b9e5
	call L_BA71		;b9e8
	push bc			;b9eb
	ld bc,01418h		;b9ec
	call L_BA51		;b9ef
	pop bc			;b9f2
	jr nc,L_B9FD		;b9f3
	ld hl,(0cef3h)		;b9f5
	ld a,079h		;b9f8
	call L_BA2B		;b9fa
L_B9FD:
	ld a,(0cee9h)		;b9fd
	add a,a			;ba00
	ld l,a			;ba01
	ld h,000h		;ba02
	ld de,0bd93h		;ba04
	add hl,de			;ba07
	ld e,(hl)			;ba08
	inc hl			;ba09
	ld d,(hl)			;ba0a
	ld hl,(0cef1h)		;ba0b
	call L_BA3D		;ba0e
	ld a,(0cee1h)		;ba11
	ld l,a			;ba14
	ld h,000h		;ba15
	ld de,0cf38h		;ba17
	ld a,(0cee9h)		;ba1a
	cp 003h		;ba1d
	jr c,L_BA24		;ba1f
	ld de,0cf26h		;ba21
L_BA24:
	add a,003h		;ba24
	add hl,de			;ba26
	ld (hl),a			;ba27
	jp L_B954		;ba28
L_BA2B:
	push bc			;ba2b
L_BA2C:
	push bc			;ba2c
	push hl			;ba2d
L_BA2E:
	ld (hl),a			;ba2e
	inc hl			;ba2f
	djnz L_BA2E		;ba30
	pop hl			;ba32
	ld bc,0ffech		;ba33
	add hl,bc			;ba36
	pop bc			;ba37
	dec c			;ba38
	jr nz,L_BA2C		;ba39
	pop bc			;ba3b
	ret			;ba3c
L_BA3D:
	push bc			;ba3d
L_BA3E:
	push bc			;ba3e
	push hl			;ba3f
L_BA40:
	ld a,(de)			;ba40
	ld (hl),a			;ba41
	inc de			;ba42
	inc hl			;ba43
	djnz L_BA40		;ba44
	pop hl			;ba46
	ld bc,0ffech		;ba47
	add hl,bc			;ba4a
	pop bc			;ba4b
	dec c			;ba4c
	jr nz,L_BA3E		;ba4d
	pop bc			;ba4f
	ret			;ba50
L_BA51:
	push bc			;ba51
L_BA52:
	push bc			;ba52
	push hl			;ba53
L_BA54:
	ld a,(hl)			;ba54
	cp d			;ba55
	jr c,L_BA5B		;ba56
	cp e			;ba58
	jr c,L_BA6A		;ba59
L_BA5B:
	inc hl			;ba5b
	djnz L_BA54		;ba5c
	pop hl			;ba5e
	ld bc,0ffech		;ba5f
	add hl,bc			;ba62
	pop bc			;ba63
	dec c			;ba64
	jr nz,L_BA52		;ba65
	and a			;ba67
	jr L_BA6F		;ba68
L_BA6A:
	ld (0cef3h),hl		;ba6a
	pop hl			;ba6d
	pop bc			;ba6e
L_BA6F:
	pop bc			;ba6f
	ret			;ba70
L_BA71:
	push hl			;ba71
	add a,a			;ba72
	add a,a			;ba73
	ld l,a			;ba74
	ld h,000h		;ba75
	add hl,de			;ba77
	ld e,(hl)			;ba78
	inc hl			;ba79
	ld d,(hl)			;ba7a
	inc hl			;ba7b
	ld c,(hl)			;ba7c
L_BA7D:
	inc hl			;ba7d
	ld b,(hl)			;ba7e
	pop hl			;ba7f
	ret			;ba80

; ----------------------------------------------------------------------
; DATOS dibujos_del_cursor: Cuatro grupos de cuatro: los dibujos y colores con
;   los que parpadea el cursor
;   0xba81..0xba91  (16 bytes)
DATA_dibujos_del_cursor:
	defb 0f8h,0e9h,002h,003h	; ba81
	defb 0e9h,0d7h,002h,004h	; ba85
	defb 0e9h,0d7h,002h,003h	; ba89
	defb 0f8h,0e9h,002h,004h	; ba8d

; ======================================================================
; CODIGO 0xba91..0xbc3d  (428 bytes)
; ======================================================================


L_BA91:
	xor a			;ba91
	ld (0ceddh),a		;ba92
	ld (0c113h),a		;ba95
	ld hl,00213h		;ba98
	ld (0cee2h),hl		;ba9b
	ld hl,0f866h		;ba9e
	ld a,020h		;baa1
	ld b,008h		;baa3
L_BAA5:
	ld (hl),a			;baa5
	inc hl			;baa6
	djnz L_BAA5		;baa7
	ld ix,0f866h		;baa9
	jr L_BACE		;baad
L_BAAF:
	xor a			;baaf
	ld (0ceddh),a		;bab0
	ld hl,00c14h		;bab3
	ld ix,0c0f6h		;bab6
	ld a,(0c113h)		;baba
	dec a			;babd
	jr z,L_BAC5		;babe
	inc l			;bac0
	ld ix,0c104h		;bac1
L_BAC5:
	ld (0cee2h),hl		;bac5
	ld hl,00c1ah		;bac8
	ld (0cef7h),hl		;bacb
L_BACE:
	call L_BB43		;bace
	call L_B6A0		;bad1
L_BAD4:
	call L_BB7D		;bad4
	cp 00dh		;bad7
	jr z,L_BB24		;bad9
	cp 008h		;badb
	jr z,L_BB2C		;badd
	cp 02eh		;badf
	jr z,L_BAF5		;bae1
	cp 030h		;bae3
	jr c,L_BAD4		;bae5
	cp 03ah		;bae7
	jr c,L_BAF7		;bae9
	cp 041h		;baeb
	jr c,L_BAD4		;baed
	cp 05bh		;baef
	jr nc,L_BAD4		;baf1
	jr L_BAF7		;baf3
L_BAF5:
	ld a,03eh		;baf5
L_BAF7:
	ld (ix+000h),a		;baf7
	ld hl,(0cef7h)		;bafa
	ld a,(0cee3h)		;bafd
	cp h			;bb00
	jr nz,L_BB13		;bb01
	ld a,(0c113h)		;bb03
	and a			;bb06
	jr z,L_BB13		;bb07
	push ix		;bb09
	pop hl			;bb0b
	ld b,00dh		;bb0c
L_BB0E:
	inc hl			;bb0e
	ld (hl),020h		;bb0f
	djnz L_BB0E		;bb11
L_BB13:
	ld hl,(0cef7h)		;bb13
	ld a,(0cee3h)		;bb16
	inc a			;bb19
	cp l			;bb1a
	jr nc,L_BACE		;bb1b
	inc ix		;bb1d
L_BB1F:
	ld (0cee3h),a		;bb1f
	jr L_BACE		;bb22
L_BB24:
	ld a,0c0h		;bb24
	ld hl,01b28h		;bb26
	jp 0004dh		;bb29   ; BIOS WRTVRM - Writes data in VRAM
L_BB2C:
	ld (ix+000h),020h		;bb2c
	ld hl,(0cef7h)		;bb30
	ld a,(0cee3h)		;bb33
	dec a			;bb36
	cp h			;bb37
	jp c,L_BACE		;bb38
	dec ix		;bb3b
	ld (ix+000h),020h		;bb3d
	jr L_BB1F		;bb41
L_BB43:
	ld a,(0c113h)		;bb43
	and a			;bb46
	jr nz,L_BB54		;bb47
	ld hl,0f866h		;bb49
	ld de,01a62h		;bb4c
	ld bc,00008h		;bb4f
	jr L_BB66		;bb52
L_BB54:
	ld bc,0000eh		;bb54
	ld hl,0c0f6h		;bb57
	ld de,01a8ch		;bb5a
	dec a			;bb5d
	jr z,L_BB66		;bb5e
	ld hl,0c104h		;bb60
	ld de,01aach		;bb63
L_BB66:
	jp 0005ch		;bb66   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_BB69:
	ld bc,00106h		;bb69
	ld a,002h		;bb6c
	ld (0cef8h),a		;bb6e
	add a,c			;bb71
	ld (0cef7h),a		;bb72
	ld d,03dh		;bb75
	ld hl,01a82h		;bb77
	jp L_B908		;bb7a
L_BB7D:
	call 0009fh		;bb7d   ; BIOS CHGET - One character input (waiting)
	cp 061h		;bb80
	jr c,L_BB8B		;bb82
	cp 07bh		;bb84
	jr nc,L_BB8B		;bb86
	sub 020h		;bb88
	ret			;bb8a
L_BB8B:
	cp 01bh		;bb8b
	jr z,L_BBA7		;bb8d
	push af			;bb8f
	call L_BBC2		;bb90
	jp nz,L_AF00		;bb93
	call L_BBEF		;bb96
	jr z,L_BB9D		;bb99
	pop af			;bb9b
	ret			;bb9c
L_BB9D:
	pop af			;bb9d
	cp 01eh		;bb9e
	jr z,L_BC0D		;bba0
	cp 01fh		;bba2
	jr z,L_BC13		;bba4
	ret			;bba6
L_BBA7:
	ld a,(0ced9h)		;bba7
	cp 002h		;bbaa
	ret nz			;bbac
	call L_B345		;bbad
	jp z,0009fh		;bbb0   ; BIOS CHGET - One character input (waiting)
	ld a,001h		;bbb3
	ld (0ced3h),a		;bbb5
	call L_BF14		;bbb8
	xor a			;bbbb
	ld (0c006h),a		;bbbc
	jp L_4066		;bbbf
L_BBC2:
	cp 0f1h		;bbc2
	jr c,L_BBCE		;bbc4
	cp 0f4h		;bbc6
	jr nc,L_BBCE		;bbc8
	sub 0eeh		;bbca
	jr L_BBE0		;bbcc
L_BBCE:
	cp 018h		;bbce
	jr z,L_BBD5		;bbd0
	xor a			;bbd2
	jr L_BBE0		;bbd3
L_BBD5:
	call L_BBE5		;bbd5
	jr nz,L_BBDE		;bbd8
	ld a,002h		;bbda
	jr L_BBE0		;bbdc
L_BBDE:
	ld a,001h		;bbde
L_BBE0:
	ld (0ceddh),a		;bbe0
	and a			;bbe3
	ret			;bbe4
L_BBE5:
	push bc			;bbe5
	ld a,006h		;bbe6
	call 00141h		;bbe8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 001h		;bbeb
	pop bc			;bbed
	ret			;bbee
L_BBEF:
	push bc			;bbef
	ld a,006h		;bbf0
	call 00141h		;bbf2   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 002h		;bbf5
	pop bc			;bbf7
	ret			;bbf8
L_BBF9:
	ld c,001h		;bbf9
	cp 01eh		;bbfb
	ret z			;bbfd
	inc c			;bbfe
	cp 01fh		;bbff
	ret z			;bc01
	inc c			;bc02
	cp 01ch		;bc03
	ret z			;bc05
	inc c			;bc06
	cp 01dh		;bc07
	ret z			;bc09
	ld c,000h		;bc0a
	ret			;bc0c
L_BC0D:
	ld a,(0cee1h)		;bc0d
	inc a			;bc10
	jr L_BC17		;bc11
L_BC13:
	ld a,(0cee1h)		;bc13
	dec a			;bc16
L_BC17:
	ld h,a			;bc17
	ld l,000h		;bc18
	call L_B8D0		;bc1a
	call L_B60B		;bc1d
	jp L_AF00		;bc20
L_BC23:
	ld a,(de)			;bc23
	ld l,a			;bc24
	inc de			;bc25
	ld a,(de)			;bc26
	ld h,a			;bc27
	inc de			;bc28
L_BC29:
	ld a,(de)			;bc29
	cp 040h		;bc2a
	jr z,L_BC35		;bc2c
	call 0004dh		;bc2e   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;bc31
	inc hl			;bc32
	jr L_BC29		;bc33
L_BC35:
	inc de			;bc35
	ret			;bc36
L_BC37:
	call L_BC23		;bc37
	djnz L_BC37		;bc3a
	ret			;bc3c

; ----------------------------------------------------------------------
; DATOS rotulo_hoyo: "HOLE:" en 0x1802
;   0xbc3d..0xbc45  (8 bytes)
DATA_rotulo_hoyo:
	defb 002h,018h,048h,04fh,04ch,045h,03ah,040h	; bc3d  ..HOLE:@

; ----------------------------------------------------------------------
; DATOS rotulo_setchr: "SETCHR" en 0x1843: elegir con que casilla se pinta
;   0xbc45..0xbc4e  (9 bytes)
DATA_rotulo_setchr:
	defb 043h,018h,053h,045h,054h,043h,048h,052h,040h	; bc45  C.SETCHR@

; ----------------------------------------------------------------------
; DATOS rotulo_par: "PAR" en 0x1863
;   0xbc4e..0xbc54  (6 bytes)
DATA_rotulo_par:
	defb 063h,018h,050h,041h,052h,040h	; bc4e

; ----------------------------------------------------------------------
; DATOS rotulo_distancia: "DIST>" en 0x1883
;   0xbc54..0xbc5c  (8 bytes)
DATA_rotulo_distancia:
	defb 083h,018h,044h,049h,053h,054h,03eh,040h	; bc54  ..DIST>@

; ----------------------------------------------------------------------
; DATOS rotulo_shot: "SHOT" en 0x18C3: probar el hoyo golpeando
;   0xbc5c..0xbc63  (7 bytes)
DATA_rotulo_shot:
	defb 0c3h,018h,053h,048h,04fh,054h,040h	; bc5c

; ----------------------------------------------------------------------
; DATOS rotulo_move: "MOVE" en 0x18E3
;   0xbc63..0xbc6a  (7 bytes)
DATA_rotulo_move:
	defb 0e3h,018h,04dh,04fh,056h,045h,040h	; bc63

; ----------------------------------------------------------------------
; DATOS rotulo_viento: "WIND" en 0x1963
;   0xbc6a..0xbc71  (7 bytes)
DATA_rotulo_viento:
	defb 063h,019h,057h,049h,04eh,044h,040h	; bc6a

; ----------------------------------------------------------------------
; DATOS marco_arriba: La fila de arriba del recuadro del panel, en 0x1801
;   0xbc71..0xbc7d  (12 bytes)
DATA_marco_arriba:
	defb 001h,018h,027h,028h,028h,028h,028h,028h,028h,028h,029h,040h	; bc71  ..'((((((()@

; ----------------------------------------------------------------------
; DATOS marco_hoyo: La linea "HOLE" del recuadro, en 0x1821
;   0xbc7d..0xbc89  (12 bytes)
DATA_marco_hoyo:
	defb 021h,018h,02ah,048h,04fh,04ch,045h,020h,020h,020h,02bh,040h	; bc7d  !.*HOLE   +@

; ----------------------------------------------------------------------
; DATOS marco_interrogante: La linea del interrogante, en 0x1841
;   0xbc89..0xbc95  (12 bytes)
DATA_marco_interrogante:
	defb 041h,018h,02ah,020h,020h,020h,020h,020h,03fh,020h,02bh,040h	; bc89  A.*     ? +@

; ----------------------------------------------------------------------
; DATOS marco_par: La linea "PAR" del recuadro, en 0x1861
;   0xbc95..0xbca1  (12 bytes)
DATA_marco_par:
	defb 061h,018h,02ah,020h,050h,041h,052h,020h,020h,020h,02bh,040h	; bc95  a.* PAR   +@

; ----------------------------------------------------------------------
; DATOS marco_abajo: La fila de abajo del recuadro, en 0x1881
;   0xbca1..0xbcad  (12 bytes)
DATA_marco_abajo:
	defb 081h,018h,024h,025h,025h,025h,025h,025h,025h,025h,026h,040h	; bca1  ..$%%%%%%%&@

; ----------------------------------------------------------------------
; DATOS rotulo_save: "SAVE" en 0x18C3
;   0xbcad..0xbcb4  (7 bytes)
DATA_rotulo_save:
	defb 0c3h,018h,053h,041h,056h,045h,040h	; bcad

; ----------------------------------------------------------------------
; DATOS rotulo_load: "LOAD" en 0x18E3
;   0xbcb4..0xbcbb  (7 bytes)
DATA_rotulo_load:
	defb 0e3h,018h,04ch,04fh,041h,044h,040h	; bcb4

; ----------------------------------------------------------------------
; DATOS rotulo_copy: "COPY" en 0x1903
;   0xbcbb..0xbcc2  (7 bytes)
DATA_rotulo_copy:
	defb 003h,019h,043h,04fh,050h,059h,040h	; bcbb

; ----------------------------------------------------------------------
; DATOS rotulo_swap: "SWAP" en 0x1923
;   0xbcc2..0xbcc9  (7 bytes)
DATA_rotulo_swap:
	defb 023h,019h,053h,057h,041h,050h,040h	; bcc2

; ----------------------------------------------------------------------
; DATOS rotulo_clear: "CLEAR" en 0x1943
;   0xbcc9..0xbcd1  (8 bytes)
DATA_rotulo_clear:
	defb 043h,019h,043h,04ch,045h,041h,052h,040h	; bcc9  C.CLEAR@

; ----------------------------------------------------------------------
; DATOS casillas_del_editor: Las 136 casillas con las que se puede pintar, en
;   el orden en que salen al elegir: 0xB528 las enseña y 0xB8A9 saca de aqui
;   la que toca
;   0xbcd1..0xbd59  (136 bytes)
DATA_casillas_del_editor:
	defb 07ah,07bh,086h,08ah,08bh,087h,07eh,07fh,07ch,07dh,088h,08ch,08dh,089h,082h,083h	; bcd1  z{....~.|}......
	defb 092h,093h,090h,091h,08eh,08fh,084h,085h,009h,00bh,00ch,00ah,078h,079h,080h,081h	; bce1  ............xy..
	defb 001h,002h,003h,004h,005h,006h,007h,008h,000h,094h,0b2h,0b3h,0aeh,0afh,09ch,09dh	; bcf1  ................
	defb 097h,096h,0b0h,0b1h,0ach,0adh,0a0h,0a1h,098h,099h,0a4h,0a8h,0a9h,0a5h,0a2h,0a3h	; bd01  ................
	defb 09ah,09bh,0a6h,0aah,0abh,0a7h,09eh,09fh,0b7h,0bdh,0bfh,0b8h,0d0h,0d1h,0c6h,0c7h	; bd11  ................
	defb 0bbh,0b5h,0b4h,0bch,0c8h,0b6h,0cah,0cbh,0b9h,0beh,0bah,0c9h,0ceh,0cfh,0c2h,0c3h	; bd21  ................
	defb 0c4h,0c5h,0cch,0cdh,0c0h,0c1h,079h,079h,060h,062h,064h,066h,068h,06ah,06ch,06eh	; bd31  ......yy`bdfhjln
	defb 061h,063h,065h,067h,069h,06bh,06dh,06fh,076h,074h,070h,073h,00eh,00dh,0f8h,0f9h	; bd41  acegikmovtps....
	defb 077h,075h,071h,072h,00fh,095h,079h,079h	; bd51  wuqr..yy

; ----------------------------------------------------------------------
; DATOS tee_de_par_3: El sello del tee de par 3: seis casillas, tres por dos,
;   empezando por 0xD9
;   0xbd59..0xbd5f  (6 bytes)
DATA_tee_de_par_3:
	defb 0d9h,0d8h,0dah	; bd59
	defb 0dbh,0d7h,0dch	; bd5c

; ----------------------------------------------------------------------
; DATOS tee_de_par_4: El sello del tee de par 4, que empieza por 0xDD
;   0xbd5f..0xbd65  (6 bytes)
DATA_tee_de_par_4:
	defb 0ddh,0deh,0dfh	; bd5f
	defb 0e0h,0e1h,0e2h	; bd62

; ----------------------------------------------------------------------
; DATOS tee_de_par_5: El sello del tee de par 5, que empieza por 0xE3
;   0xbd65..0xbd6b  (6 bytes)
DATA_tee_de_par_5:
	defb 0e3h,0e4h,0e5h	; bd65
	defb 0e6h,0e7h,0e8h	; bd68

; ----------------------------------------------------------------------
; DATOS green_1: Sello de green: ocho casillas, cuatro por dos, con la bandera
;   0xE9 dentro
;   0xbd6b..0xbd73  (8 bytes)
DATA_green_1:
	defb 0ech,0e9h,0eah,0f2h	; bd6b
	defb 0edh,0ebh,0ebh,0f3h	; bd6f

; ----------------------------------------------------------------------
; DATOS green_2: El segundo green
;   0xbd73..0xbd7b  (8 bytes)
DATA_green_2:
	defb 0ech,0e9h,0eah,0f4h	; bd73
	defb 0edh,0ebh,0ebh,0f5h	; bd77

; ----------------------------------------------------------------------
; DATOS green_3: El tercero
;   0xbd7b..0xbd83  (8 bytes)
DATA_green_3:
	defb 0f0h,0e9h,0eah,0f4h	; bd7b
	defb 0f1h,0ebh,0ebh,0f5h	; bd7f

; ----------------------------------------------------------------------
; DATOS green_4: El cuarto
;   0xbd83..0xbd8b  (8 bytes)
DATA_green_4:
	defb 0eeh,0e9h,0eah,0f2h	; bd83
	defb 0efh,0ebh,0ebh,0f3h	; bd87

; ----------------------------------------------------------------------
; DATOS green_5: El quinto
;   0xbd8b..0xbd93  (8 bytes)
DATA_green_5:
	defb 0eeh,0e9h,0eah,0f6h	; bd8b
	defb 0efh,0ebh,0ebh,0f7h	; bd8f

; ----------------------------------------------------------------------
; DATOS tabla_de_sellos: Ocho punteros: los tres tees y los cinco greens
;   0xbd93..0xbda3  (16 bytes)
DATA_tabla_de_sellos:
	defw 0bd59h,0bd5fh,0bd65h,0bd6bh	; bd93  -> DATA_tee_de_par_3 DATA_tee_de_par_4 DATA_tee_de_par_5 DATA_green_1
	defw 0bd73h,0bd7bh,0bd83h,0bd8bh	; bd9b  -> DATA_green_2 DATA_green_3 DATA_green_4 DATA_green_5

; ----------------------------------------------------------------------
; DATOS rotulo_par_dos_puntos: "PAR:" en 0x1923
;   0xbda3..0xbdaa  (7 bytes)
DATA_rotulo_par_dos_puntos:
	defb 023h,019h,050h,041h,052h,03ah,040h	; bda3

; ----------------------------------------------------------------------
; DATOS rotulo_interrogante: El interrogante en 0x19E7
;   0xbdaa..0xbdae  (4 bytes)
DATA_rotulo_interrogante:
	defb 0e7h,019h,03fh,040h	; bdaa

; ----------------------------------------------------------------------
; DATOS rotulo_1st: "1ST" en 0x1965
;   0xbdae..0xbdb4  (6 bytes)
DATA_rotulo_1st:
	defb 065h,019h,031h,053h,054h,040h	; bdae

; ----------------------------------------------------------------------
; DATOS rotulo_2nd: "2ND" en 0x1985
;   0xbdb4..0xbdba  (6 bytes)
DATA_rotulo_2nd:
	defb 085h,019h,032h,04eh,044h,040h	; bdb4

; ----------------------------------------------------------------------
; DATOS rotulo_3rd: "3RD" en 0x19A5
;   0xbdba..0xbdc0  (6 bytes)
DATA_rotulo_3rd:
	defb 0a5h,019h,033h,052h,044h,040h	; bdba

; ----------------------------------------------------------------------
; DATOS rotulo_nombre: "NAME:" en 0x1A42, al grabar
;   0xbdc0..0xbdc8  (8 bytes)
DATA_rotulo_nombre:
	defb 042h,01ah,04eh,041h,04dh,045h,03ah,040h	; bdc0  B.NAME:@

; ----------------------------------------------------------------------
; DATOS rotulo_green: "GREEN" en 0x1A62
;   0xbdc8..0xbdd0  (8 bytes)
DATA_rotulo_green:
	defb 062h,01ah,047h,052h,045h,045h,04eh,040h	; bdc8  b.GREEN@

; ----------------------------------------------------------------------
; DATOS rotulo_o_tee: "OR TEE" en 0x1A83
;   0xbdd0..0xbdd9  (9 bytes)
DATA_rotulo_o_tee:
	defb 083h,01ah,04fh,052h,020h,054h,045h,045h,040h	; bdd0  ..OR TEE@

; ----------------------------------------------------------------------
; DATOS rotulo_no: "NOT" en 0x1AA2
;   0xbdd9..0xbddf  (6 bytes)
DATA_rotulo_no:
	defb 0a2h,01ah,04eh,04fh,054h,040h	; bdd9

; ----------------------------------------------------------------------
; DATOS rotulo_encontrado: "FOUND>" en 0x1AC3: el aviso de que al hoyo le
;   falta green o tee
;   0xbddf..0xbde8  (9 bytes)
DATA_rotulo_encontrado:
	defb 0c3h,01ah,046h,04fh,055h,04eh,044h,03eh,040h	; bddf  ..FOUND>@

; ----------------------------------------------------------------------
; DATOS rotulo_seguro_2: "SURE>>" en 0x1A62
;   0xbde8..0xbdf1  (9 bytes)
DATA_rotulo_seguro_2:
	defb 062h,01ah,053h,055h,052h,045h,03eh,03eh,040h	; bde8  b.SURE>>@

; ======================================================================
; CODIGO 0xbdf1..0xbe6c  (123 bytes)
; ======================================================================


L_BDF1:
	ld (0cf25h),sp		;bdf1
	ld (0cf21h),hl		;bdf5
	ld (0f87dh),de		;bdf8
	ld (0fcbfh),hl		;bdfc
	call L_BE16		;bdff
	ld hl,L_BE0E		;be02
	push hl			;be05
	ld hl,(0cf21h)		;be06
	push hl			;be09
	push hl			;be0a
	jp L_6FD7		;be0b
L_BE0E:
	call 000e7h		;be0e   ; BIOS TAPIOF - Stops reading from the tape
	call L_BE1B		;be11
	and a			;be14
	ret			;be15
L_BE16:
	ld a,(0fcc1h)		;be16
	jr L_BE1E		;be19
L_BE1B:
	ld a,(0fedbh)		;be1b
L_BE1E:
	ld hl,04000h		;be1e
	jp 00024h		;be21   ; BIOS ENASLT - Switches to specified slot and page definitively
L_BE24:
	ld (0cf25h),sp		;be24
	ld (0cf21h),hl		;be28
	call L_BE16		;be2b
	call L_BE45		;be2e
L_BE31:
	push bc			;be31
	call 072d4h		;be32
	ld (hl),a			;be35
	inc hl			;be36
	pop bc			;be37
	dec bc			;be38
	ld a,c			;be39
	or b			;be3a
	jr nz,L_BE31		;be3b
	call 000e7h		;be3d   ; BIOS TAPIOF - Stops reading from the tape
	call L_BE1B		;be40
	and a			;be43
	ret			;be44
L_BE45:
	ld c,0d0h		;be45
	call L_70B8		;be47
	call 072e9h		;be4a
	call L_700B		;be4d
	push hl			;be50
	call L_700B		;be51
	push hl			;be54
	call L_700B		;be55
	pop hl			;be58
	pop de			;be59
	and a			;be5a
	sbc hl,de		;be5b
	ld c,l			;be5d
	ld b,h			;be5e
	ld hl,(0cf21h)		;be5f
	ret			;be62
L_BE63:
	ld a,(hl)			;be63
	and a			;be64
	ret z			;be65
	call 000a2h		;be66   ; BIOS CHPUT - Displays one character
	inc hl			;be69
	jr L_BE63		;be6a

; ----------------------------------------------------------------------
; DATOS texto_pulsa_una_tecla: "Push any Key !!", terminado en cero, que
;   0xBE63 escribe por CHPUT: es texto de BASIC, no del juego
;   0xbe6c..0xbe7c  (16 bytes)
DATA_texto_pulsa_una_tecla:
	defb 050h,075h,073h,068h,020h,061h,06eh,079h,020h,04bh,065h,079h,020h,021h,021h,000h	; be6c  Push any Key !!.

; ======================================================================
; CODIGO 0xbe7c..0xbef0  (116 bytes)
; ======================================================================


L_BE7C:
	ld sp,(0cf25h)		;be7c
	call L_BE1B		;be80
	scf			;be83
	ret			;be84
L_BE85:
	call 00041h		;be85   ; BIOS DISSCR - Inhibits the screen display
	ld hl,0cfcdh		;be88
	ld de,00000h		;be8b
	ld bc,0223eh		;be8e
	call 0005ch		;be91   ; BIOS LDIRVM - Block transfers to VRAM from memory
	xor a			;be94
	ld (0cec3h),a		;be95
	ld hl,00000h		;be98
L_BE9B:
	call L_6F63		;be9b
	push hl			;be9e
	ld a,(0cec3h)		;be9f
	ld c,a			;bea2
	ld b,000h		;bea3
	ld hl,0cf39h		;bea5
	add hl,bc			;bea8
	ld a,(0c06ch)		;bea9
	ld (hl),a			;beac
	ld hl,0cf27h		;bead
	add hl,bc			;beb0
	ld (hl),001h		;beb1
	ld hl,0cf4bh		;beb3
	add hl,bc			;beb6
	add hl,bc			;beb7
	add hl,bc			;beb8
	ex de,hl			;beb9
	ld hl,0cecfh		;beba
	push bc			;bebd
	ld bc,00003h		;bebe
	ldir		;bec1
	pop bc			;bec3
	ld hl,0bef0h		;bec4
	add hl,bc			;bec7
	add hl,bc			;bec8
	ld e,(hl)			;bec9
	inc hl			;beca
	ld d,(hl)			;becb
	ld hl,0cccch		;becc
	ld b,018h		;becf
L_BED1:
	push bc			;bed1
	ld bc,00014h		;bed2
	ldir		;bed5
	ld bc,0ffd8h		;bed7
	add hl,bc			;beda
	pop bc			;bedb
	djnz L_BED1		;bedc
	pop hl			;bede
	ld a,(0cec3h)		;bedf
	inc a			;bee2
	ld (0cec3h),a		;bee3
	cp 012h		;bee6
	jr c,L_BE9B		;bee8
	call L_6636		;beea
	jp 00044h		;beed   ; BIOS ENASCR - Displays the screen

; ----------------------------------------------------------------------
; DATOS buffers_de_los_hoyos: Dieciocho punteros a RAM, de 0xD04B en adelante
;   y de 480 en 480: donde el editor guarda las 480 casillas de cada hoyo
;   0xbef0..0xbf14  (36 bytes)
DATA_buffers_de_los_hoyos:
	defw 0d04bh,0d22bh,0d40bh,0d5ebh	; bef0
	defw 0d7cbh,0d9abh,0db8bh,0dd6bh	; bef8
	defw 0df4bh,0e12bh,0e30bh,0e4ebh	; bf00
	defw 0e6cbh,0e8abh,0ea8bh,0ec6bh	; bf08
	defw 0ee4bh,0f02bh	; bf10

; ======================================================================
; CODIGO 0xbf14..0xbf78  (100 bytes)
; ======================================================================


L_BF14:
	ld hl,0cfcdh		;bf14
	xor a			;bf17
	ld (0cec3h),a		;bf18
L_BF1B:
	push hl			;bf1b
	ld a,(0cec3h)		;bf1c
	add a,a			;bf1f
	ld c,a			;bf20
	ld b,000h		;bf21
	ld hl,0bef0h		;bf23
	add hl,bc			;bf26
	ld e,(hl)			;bf27
	inc hl			;bf28
	ld d,(hl)			;bf29
	ex de,hl			;bf2a
	call L_B22C		;bf2b
	pop hl			;bf2e
	push hl			;bf2f
	ex de,hl			;bf30
	ld hl,0cf97h		;bf31
	ld a,(0cec3h)		;bf34
	add a,a			;bf37
	ld c,a			;bf38
	ld b,000h		;bf39
	add hl,bc			;bf3b
	ld (hl),e			;bf3c
	inc hl			;bf3d
	ld (hl),d			;bf3e
	pop hl			;bf3f
	call L_BF8E		;bf40
	push hl			;bf43
	ld a,(0cec3h)		;bf44
	inc a			;bf47
	call L_B864		;bf48
	pop de			;bf4b
	ld bc,00003h		;bf4c
	ldir		;bf4f
	ex de,hl			;bf51
	ld a,(0cec3h)		;bf52
	inc a			;bf55
	ld (0cec3h),a		;bf56
	cp 012h		;bf59
	jr c,L_BF1B		;bf5b
	push hl			;bf5d
	ld hl,0bf78h		;bf5e
	ld de,0cf81h		;bf61
	ld bc,00015h		;bf64
	ldir		;bf67
	ld hl,0cfbbh		;bf69
	ld de,0cfbch		;bf6c
	ld bc,00011h		;bf6f
	ld (hl),002h		;bf72
	ldir		;bf74
	pop hl			;bf76
	ret			;bf77

; ----------------------------------------------------------------------
; DATOS cabecera_del_fichero: Los veintiun bytes que van delante del campo
;   grabado: apuntan 0xE000 y 0xE002 a las tablas del fichero. Es el mismo
;   trozo que llevan los campos de la cinta de 1985
;   0xbf78..0xbf8e  (22 bytes)
DATA_cabecera_del_fichero:
	defb 0f5h,0e5h,021h,066h,0c0h,022h,000h,0e0h	; bf78  ..!f."..
	defb 021h,08ah,0c0h,022h,002h,0e0h,03eh,001h	; bf80  !.."..>.
	defb 032h,004h,0e0h,0e1h,0f1h,0c9h	; bf88

; ======================================================================
; CODIGO 0xbf8e..0xbff2  (100 bytes)
; ======================================================================


L_BF8E:
	ld (0ced4h),hl		;bf8e
	ld hl,0bff2h		;bf91
	ld b,(hl)			;bf94
	inc hl			;bf95
	ld c,(hl)			;bf96
	inc hl			;bf97
	ld d,(hl)			;bf98
	exx			;bf99
	ld de,(0ced4h)		;bf9a
	ld hl,0bff2h		;bf9e
	ld bc,00003h		;bfa1
	ldir		;bfa4
	ld hl,0cb00h		;bfa6
	ld b,018h		;bfa9
L_BFAB:
	push bc			;bfab
	ld b,014h		;bfac
L_BFAE:
	ld a,(hl)			;bfae
	exx			;bfaf
	cp b			;bfb0
	jr z,L_BFC7		;bfb1
	cp c			;bfb3
	jr z,L_BFCC		;bfb4
	cp d			;bfb6
	jr z,L_BFD1		;bfb7
	exx			;bfb9
	ld (de),a			;bfba
	inc hl			;bfbb
	inc de			;bfbc
	djnz L_BFAE		;bfbd
L_BFBF:
	pop bc			;bfbf
	djnz L_BFAB		;bfc0
	ex de,hl			;bfc2
	ld (hl),021h		;bfc3
	inc hl			;bfc5
	ret			;bfc6
L_BFC7:
	exx			;bfc7
	ld c,02fh		;bfc8
	jr L_BFD4		;bfca
L_BFCC:
	exx			;bfcc
	ld c,03fh		;bfcd
	jr L_BFD4		;bfcf
L_BFD1:
	exx			;bfd1
	ld c,04fh		;bfd2
L_BFD4:
	ld a,(hl)			;bfd4
L_BFD5:
	cp (hl)			;bfd5
	jr nz,L_BFE9		;bfd6
	inc c			;bfd8
	inc hl			;bfd9
	push af			;bfda
	ld a,c			;bfdb
	and 00fh		;bfdc
	cp 00fh		;bfde
	jr z,L_BFE7		;bfe0
	pop af			;bfe2
	djnz L_BFD5		;bfe3
	jr L_BFE9		;bfe5
L_BFE7:
	pop af			;bfe7
	dec b			;bfe8
L_BFE9:
	ld a,c			;bfe9
	ld (de),a			;bfea
	inc de			;bfeb
	ld a,b			;bfec
	and a			;bfed
	jr nz,L_BFAE		;bfee
	jr L_BFBF		;bff0

; ----------------------------------------------------------------------
; DATOS cola_del_cartucho: Tres bytes y once de relleno a 0xFF: el final de
;   los 32 KB
;   0xbff2..0xc000  (14 bytes)
DATA_cola_del_cartucho:
	defb 079h,094h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff2  y.............
