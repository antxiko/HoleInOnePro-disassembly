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
; DATOS sin identificar  0x4000..0x4010  (16 bytes)
DATA_4000:
	defb 041h,042h,010h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............

; ======================================================================
; CODIGO 0x4010..0x40cc  (188 bytes)
; ======================================================================


L_4010:
	call 00138h		;4010   ; BIOS RSLREG - Reads the primary slot register
	rrca			;4013
	rrca			;4014
	and 003h		;4015
	ld c,a			;4017
	ld b,000h		;4018
	ld hl,0fcc1h		;401a
	add hl,bc			;401d
	or (hl)			;401e
	ld c,a			;401f
	inc hl			;4020
	inc hl			;4021
	inc hl			;4022
	inc hl			;4023
	ld a,(hl)			;4024
	and 00ch		;4025
	or c			;4027
	ld (0fedbh),a		;4028
	di			;402b
	ld sp,0f380h		;402c
	ld a,(0fedbh)		;402f
	ld hl,08000h		;4032
	call 00024h		;4035   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c002h		;4038
	ld de,0c003h		;403b
	ld bc,032ffh		;403e
	ld (hl),000h		;4041
	ldir		;4043
	ld hl,0716bh		;4045
	ld (0c000h),hl		;4048
	ld a,012h		;404b
	ld (0c060h),a		;404d
	ld hl,0c0f6h		;4050
	ld de,0c0f7h		;4053
	ld bc,0001bh		;4056
	ld (hl),020h		;4059
	ldir		;405b
	call L_6B21		;405d
	call L_6603		;4060
	call L_6564		;4063
L_4066:
	call L_6734		;4066
L_4069:
	ld sp,0f380h		;4069
	call L_5ABA		;406c
	call L_5175		;406f
	ld hl,05224h		;4072
	call L_51BF		;4075
	call L_52DE		;4078
L_407B:
	call L_6666		;407b
	call L_6A4F		;407e
	jr nz,L_407B		;4081
L_4083:
	call L_4CD0		;4083
	call L_6A4F		;4086
	jp nz,L_4116		;4089
	call L_6A6F		;408c
	srl a		;408f
	jr nc,L_4083		;4091
	ld hl,0c002h		;4093
	jr z,L_40BA		;4096
	dec a			;4098
	jr z,L_40A3		;4099
	dec a			;409b
	jr z,L_40B8		;409c
	ld hl,040cch		;409e
	jr L_40A6		;40a1
L_40A3:
	ld hl,040d4h		;40a3
L_40A6:
	ld a,(0c002h)		;40a6
	call L_533C		;40a9
	push de			;40ac
	ld hl,040deh		;40ad
	ld a,(0c002h)		;40b0
	call L_533C		;40b3
	ex de,hl			;40b6
	ret			;40b7
L_40B8:
	inc (hl)			;40b8
	inc (hl)			;40b9
L_40BA:
	dec (hl)			;40ba
	ld a,(hl)			;40bb
	and 003h		;40bc
	ld (hl),a			;40be
	call L_52DE		;40bf
L_40C2:
	call L_6666		;40c2
	call L_6A6F		;40c5
	jr nz,L_40C2		;40c8
	jr L_4083		;40ca

; ----------------------------------------------------------------------
; DATOS sin identificar  0x40cc..0x4116  (74 bytes)
DATA_40CC:
	defb 0e6h,040h,0f5h,040h,00dh,041h,0efh,040h,0e8h,040h,003h,041h,00fh,041h,0fdh,040h	; 40cc  .@.@.A.@.@.A.A.@
	defb 041h,04eh,003h,0c0h,007h,0c0h,005h,0c0h,004h,0c0h,035h,035h,034h,07eh,0e6h,001h	; 40dc  AN........554~..
	defb 077h,018h,0d0h,03ah,0d3h,0ceh,0a7h,028h,0f1h,035h,0f2h,0bfh,040h,036h,002h,018h	; 40ec  w..:...(.5..@6..
	defb 0c2h,03ah,0d3h,0ceh,0a7h,028h,0e5h,034h,07eh,0feh,003h,038h,0b6h,036h,000h,018h	; 40fc  .:...(.4~..8.6..
	defb 0b2h,035h,035h,034h,07eh,0e6h,003h,077h,018h,0a9h	; 410c  .554~..w..

; ======================================================================
; CODIGO 0x4116..0x4842  (1836 bytes)
; ======================================================================


L_4116:
	xor a			;4116
	ld (0c011h),a		;4117
	ld (0c006h),a		;411a
	ld (0c117h),a		;411d
	ld (0c009h),a		;4120
	ld a,004h		;4123
	ld (0c119h),a		;4125
	ld a,(0c005h)		;4128
	cp 003h		;412b
	jp z,L_AEA3		;412d
	ld a,(0c004h)		;4130
	and a			;4133
	ld hl,0716bh		;4134
	jr z,L_4142		;4137
	ld hl,0718fh		;4139
	dec a			;413c
	jr z,L_4142		;413d
	ld hl,0cf97h		;413f
L_4142:
	ld (0c000h),hl		;4142
	ld a,(0c003h)		;4145
	ld (0c008h),a		;4148
	and a			;414b
	jr nz,L_415B		;414c
	ld a,(0c005h)		;414e
	and a			;4151
	jr z,L_415B		;4152
	ld a,001h		;4154
	ld (0c008h),a		;4156
	jr L_415D		;4159
L_415B:
	ld a,0ffh		;415b
L_415D:
	ld (0c116h),a		;415d
	ld a,(0c005h)		;4160
	cp 002h		;4163
	jr nz,L_418B		;4165
	ld hl,052c2h		;4167
	call L_51BF		;416a
	ld a,001h		;416d
	ld (0c113h),a		;416f
	call L_BAAF		;4172
	ld a,002h		;4175
	ld (0c113h),a		;4177
	ld a,(0c003h)		;417a
	and a			;417d
	jr z,L_4185		;417e
	call L_BAAF		;4180
	jr L_4188		;4183
L_4185:
	call L_4F4A		;4185
L_4188:
	call L_4CF3		;4188
L_418B:
	call L_6636		;418b
	call L_6734		;418e
	call L_4DEC		;4191
	call L_49D8		;4194
	call 00044h		;4197   ; BIOS ENASCR - Displays the screen
	ld a,002h		;419a
	call L_6B2D		;419c
	xor a			;419f
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
	ld (0cec3h),a		;41ba
	ld (0c075h),hl		;41bd
	ld (0c074h),a		;41c0
	ld (0c117h),hl		;41c3
	dec a			;41c6
	ld (0c072h),a		;41c7
	ld (0c073h),a		;41ca
	call L_67EF		;41cd
	ld a,(0c008h)		;41d0
	and a			;41d3
	jr nz,L_41E2		;41d4
	ld hl,01862h		;41d6
	call L_4CC8		;41d9
	ld hl,018e2h		;41dc
	call L_4CC8		;41df
L_41E2:
	xor a			;41e2
	ld l,a			;41e3
	ld h,a			;41e4
	ld (0c014h),hl		;41e5
	ld (0c062h),hl		;41e8
	ld (0c011h),a		;41eb
	ld (0c00bh),hl		;41ee
	ld (0c071h),a		;41f1
	ld (0c11ah),a		;41f4
	call L_4BE7		;41f7
	call L_486F		;41fa
	call L_6F49		;41fd
	call L_6843		;4200
	ld hl,0c00dh		;4203
	ld a,(0cec5h)		;4206
	ld (hl),a			;4209
	inc hl			;420a
	ld (hl),a			;420b
	inc hl			;420c
	ld a,(0cec4h)		;420d
	ld (hl),a			;4210
	inc hl			;4211
	ld (hl),a			;4212
	ld de,04caeh		;4213
	ld a,(0c076h)		;4216
	and a			;4219
	call nz,L_4BF5		;421a
L_421D:
	call L_46FA		;421d
	call L_4A75		;4220
	ld a,(0c009h)		;4223
	ld iy,0c00bh		;4226
	and a			;422a
	jr z,L_422F		;422b
	inc iy		;422d
L_422F:
	ld a,(iy+000h)		;422f
	cp 002h		;4232
	ld a,000h		;4234
	jr nz,L_4239		;4236
	inc a			;4238
L_4239:
	ld (0c011h),a		;4239
	inc (iy+057h)		;423c
	call L_486F		;423f
	call L_46ED		;4242
	call L_4A8D		;4245
	call L_4777		;4248
	ld a,(0c009h)		;424b
	call L_4748		;424e
	call L_478D		;4251
	call L_479A		;4254
	ld a,(iy+009h)		;4257
	ld (0c621h),a		;425a
	xor a			;425d
	ld (0c117h),a		;425e
	ld a,(0c009h)		;4261
	ld hl,0c116h		;4264
	cp (hl)			;4267
	jr nz,L_42A0		;4268
	ld a,(iy+057h)		;426a
	cp 007h		;426d
	jr c,L_4276		;426f
	ld a,006h		;4271
	ld (0c119h),a		;4273
L_4276:
	ld a,001h		;4276
	ld (0c118h),a		;4278
	ld a,(0c011h)		;427b
	and a			;427e
	jr nz,L_428F		;427f
	call L_5B39		;4281
	ld hl,0c062h		;4284
	ld a,(0c65fh)		;4287
	ld (0c660h),a		;428a
	jr L_4292		;428d
L_428F:
	call L_6091		;428f
L_4292:
	xor a			;4292
	ld (0c118h),a		;4293
	inc a			;4296
	ld (0c117h),a		;4297
	ld a,(0c667h)		;429a
	ld (0c621h),a		;429d
L_42A0:
	call L_5359		;42a0
	ld a,(0c621h)		;42a3
	ld (iy+009h),a		;42a6
	ld a,(0c011h)		;42a9
	and a			;42ac
	jp nz,L_4491		;42ad
	ld hl,(0c63fh)		;42b0
	ld a,(0c60eh)		;42b3
	cp l			;42b6
	jr nz,L_42C0		;42b7
	ld a,(0c611h)		;42b9
	cp h			;42bc
	jp z,L_448C		;42bd
L_42C0:
	xor a			;42c0
	ld (0c613h),a		;42c1
	call L_59AA		;42c4
	call L_6696		;42c7
	call L_9E0B		;42ca
	call L_629C		;42cd
	ld a,(0c633h)		;42d0
	ld b,a			;42d3
	ld a,(0c635h)		;42d4
	or b			;42d7
	jr nz,L_4326		;42d8
	ld a,(0c638h)		;42da
	and a			;42dd
	jr nz,L_42FE		;42de
	ld a,(0c637h)		;42e0
	and a			;42e3
	jr nz,L_4353		;42e4
	ld a,(0c636h)		;42e6
	and a			;42e9
	jr nz,L_4307		;42ea
	ld de,04c6bh		;42ec
	ld a,(0c639h)		;42ef
	and a			;42f2
	jr z,L_42F8		;42f3
	ld de,04c73h		;42f5
L_42F8:
	call L_4BF5		;42f8
	jp L_4398		;42fb
L_42FE:
	ld de,04c7bh		;42fe
	call L_4BF5		;4301
	jp L_4398		;4304
L_4307:
	ld a,(0c62ch)		;4307
	ld (0c60eh),a		;430a
	ld a,(0c62dh)		;430d
	ld (0c611h),a		;4310
	ld a,001h		;4313
	ld (0c11ah),a		;4315
	inc (iy+057h)		;4318
	ld de,04c83h		;431b
	call L_4BF5		;431e
	call L_59AA		;4321
	jr L_4398		;4324
L_4326:
	call 00090h		;4326   ; BIOS GICINI - Initialises PSG and sets initial value for the PLAY statement
	call L_5AAA		;4329
	ld a,001h		;432c
	ld (0c11ah),a		;432e
	ld de,04c91h		;4331
	call L_4BF5		;4334
	ld a,(0c012h)		;4337
	ld (0c60eh),a		;433a
	ld a,(0c013h)		;433d
	ld (0c611h),a		;4340
	inc (iy+057h)		;4343
	xor a			;4346
	ld (0c613h),a		;4347
	ld a,(iy+000h)		;434a
	and a			;434d
	call nz,L_59AA		;434e
	jr L_4398		;4351
L_4353:
	ld (iy+000h),002h		;4353
	call L_47DF		;4357
	call L_9E0B		;435a
	ld de,04c96h		;435d
	call L_4BFD		;4360
	ld a,(iy+057h)		;4363
	ld hl,01a63h		;4366
	call L_4A4B		;4369
	call L_4BF8		;436c
	jr L_4398		;436f
L_4371:
	ld a,(iy+000h)		;4371
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
	ld a,(0c009h)		;4388
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
	call L_4371		;4398
	ld a,(0c075h)		;439b
	and a			;439e
	jr nz,L_43A8		;439f
	ld a,(0c005h)		;43a1
	dec a			;43a4
	jp nz,L_421D		;43a5
L_43A8:
	ld a,(0c071h)		;43a8
	and a			;43ab
	jp z,L_421D		;43ac
	call L_4388		;43af
	jp c,L_421D		;43b2
	ld a,(0c009h)		;43b5
	xor 001h		;43b8
	ld (0c072h),a		;43ba
L_43BD:
	call L_5ABA		;43bd
	ld a,(0c072h)		;43c0
	and a			;43c3
	jp m,L_43ED		;43c4
	ld hl,0c074h		;43c7
	ld a,(0c073h)		;43ca
	and a			;43cd
	jp m,L_43E5		;43ce
	ld b,a			;43d1
	ld a,(0c072h)		;43d2
	cp b			;43d5
	jr z,L_43E2		;43d6
	dec (hl)			;43d8
	jr nz,L_43ED		;43d9
	ld a,0ffh		;43db
	ld (0c073h),a		;43dd
	jr L_43ED		;43e0
L_43E2:
	inc (hl)			;43e2
	jr L_43ED		;43e3
L_43E5:
	ld (hl),001h		;43e5
	ld a,(0c072h)		;43e7
	ld (0c073h),a		;43ea
L_43ED:
	ld c,004h		;43ed
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
	ld (0c119h),a		;4401
	call L_486F		;4404
	call L_48F7		;4407
	ld a,(0c075h)		;440a
	and a			;440d
	jr nz,L_446D		;440e
	ld a,(0cec3h)		;4410
	sub 011h		;4413
	jr nc,L_4425		;4415
	ld b,a			;4417
	ld a,(0c074h)		;4418
	add a,b			;441b
	jp z,L_4656		;441c
	jp m,L_465B		;441f
	jp L_442B		;4422
L_4425:
	ld a,(0c074h)		;4425
	and a			;4428
	jr z,L_446D		;4429
L_442B:
	ld a,(0c005h)		;442b
	dec a			;442e
	jr z,L_4437		;442f
	call L_4FE6		;4431
	jp L_466B		;4434
L_4437:
	ld hl,01ecbh		;4437
	ld de,01ed5h		;443a
	ld a,(0c073h)		;443d
	and a			;4440
	jr z,L_4444		;4441
	ex de,hl			;4443
L_4444:
	ld a,(0c074h)		;4444
	call L_4A4B		;4447
	ld a,(0c075h)		;444a
	and a			;444d
	jr nz,L_446A		;444e
	inc hl			;4450
	ld a,041h		;4451
	call L_6893		;4453
	ld a,04eh		;4456
	call L_6893		;4458
	ld a,044h		;445b
	call L_6893		;445d
	ld a,(0cec3h)		;4460
	neg		;4463
	add a,011h		;4465
	call L_4A4B		;4467
L_446A:
	jp L_46BC		;446a
L_446D:
	ld a,(0c074h)		;446d
	and a			;4470
	jr nz,L_442B		;4471
	ld a,001h		;4473
	ld (0c075h),a		;4475
L_4478:
	ld de,04ca6h		;4478
	call L_4BF5		;447b
	ld hl,0cec3h		;447e
	inc (hl)			;4481
	ld a,(hl)			;4482
	cp 012h		;4483
	jr c,L_4489		;4485
	ld (hl),00fh		;4487
L_4489:
	jp L_465F		;4489
L_448C:
	call L_5AAA		;448c
	jr L_44E3		;448f
L_4491:
	ld a,(0c634h)		;4491
	and a			;4494
	jr nz,L_44C1		;4495
	call L_6696		;4497
	call L_9E0B		;449a
	ld a,(0c633h)		;449d
	and a			;44a0
	jp z,L_4398		;44a1
	call L_4848		;44a4
	xor a			;44a7
	ld (0c011h),a		;44a8
	ld (iy+000h),001h		;44ab
	ld hl,0c009h		;44af
	push hl			;44b2
	ld a,(hl)			;44b3
	push af			;44b4
	xor 001h		;44b5
	ld (hl),a			;44b7
	call L_5AAA		;44b8
	pop af			;44bb
	pop hl			;44bc
	ld (hl),a			;44bd
	jp L_4398		;44be
L_44C1:
	ld a,(0c009h)		;44c1
	and a			;44c4
	ld hl,01b00h		;44c5
	jr z,L_44CE		;44c8
	inc hl			;44ca
	inc hl			;44cb
	inc hl			;44cc
	inc hl			;44cd
L_44CE:
	ld a,(0c63eh)		;44ce
	sub 002h		;44d1
	call L_6893		;44d3
	ld a,(0c63dh)		;44d6
	dec a			;44d9
	call L_6893		;44da
	inc hl			;44dd
	ld a,004h		;44de
	call 0004dh		;44e0   ; BIOS WRTVRM - Writes data in VRAM
L_44E3:
	ld a,004h		;44e3
	call L_6B2D		;44e5
	call L_6696		;44e8
	ld (iy+000h),003h		;44eb
	call L_5AAA		;44ef
	call L_9E0B		;44f2
	ld a,(0c005h)		;44f5
	dec a			;44f8
	jr z,L_4546		;44f9
	ld a,(0c075h)		;44fb
	and a			;44fe
	jr nz,L_4546		;44ff
	ld a,(iy+057h)		;4501
	ld hl,0c06ch		;4504
	sub (hl)			;4507
	ld c,a			;4508
	ld b,000h		;4509
	jr nc,L_450E		;450b
	dec b			;450d
L_450E:
	ld hl,0c05ch		;450e
	call L_4534		;4511
	ld hl,0c068h		;4514
	ld a,(iy+057h)		;4517
	ld c,a			;451a
	ld b,000h		;451b
	call L_4534		;451d
	ld de,0fffch		;4520
	add hl,de			;4523
	ld a,(0cec3h)		;4524
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
	ld a,(0c009h)		;4534
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
	ld de,04c0bh		;4546
	ld a,(iy+057h)		;4549
	cp 001h		;454c
	jr z,L_4569		;454e
	ld a,(0c06ch)		;4550
	sub (iy+057h)		;4553
	neg		;4556
	add a,003h		;4558
	cp 007h		;455a
	jr nc,L_4576		;455c
	add a,a			;455e
	ld e,a			;455f
	ld d,000h		;4560
	ld hl,04cbah		;4562
	add hl,de			;4565
	ld e,(hl)			;4566
	inc hl			;4567
	ld d,(hl)			;4568
L_4569:
	call L_4BFD		;4569
	ld a,(de)			;456c
	and a			;456d
	jr z,L_4576		;456e
	call L_6B2D		;4570
	call L_4BF8		;4573
L_4576:
	call L_4BF8		;4576
	call 00090h		;4579   ; BIOS GICINI - Initialises PSG and sets initial value for the PLAY statement
	ld a,(0c008h)		;457c
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
	ld a,(hl)			;4598
	cp 003h		;4599
	jr z,L_45CB		;459b
	jp L_4398		;459d
L_45A0:
	ld hl,0c071h		;45a0
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
	ld hl,0c062h		;45cb
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
	call L_48F7		;45db
	ld a,(0c005h)		;45de
	cp 002h		;45e1
	jr nz,L_462D		;45e3
	ld a,(0c062h)		;45e5
	ld hl,0c06ch		;45e8
	sub (hl)			;45eb
	ld (0c0f5h),a		;45ec
	ld a,(0c116h)		;45ef
	and a			;45f2
	jr nz,L_4602		;45f3
	ld a,(0c00ah)		;45f5
	and a			;45f8
	jr z,L_4602		;45f9
	ld a,(0c063h)		;45fb
	sub (hl)			;45fe
	ld (0c0f5h),a		;45ff
L_4602:
	ld hl,(0c05ch)		;4602
	ld de,(0c05eh)		;4605
	and a			;4609
	sbc hl,de		;460a
	ld c,004h		;460c
	jr z,L_4623		;460e
	jp m,L_461C		;4610
	ld a,l			;4613
	cp 003h		;4614
	jr c,L_4623		;4616
	ld c,002h		;4618
	jr L_4623		;461a
L_461C:
	ld a,l			;461c
	cp 0feh		;461d
	jr nc,L_4623		;461f
	ld c,006h		;4621
L_4623:
	ld a,c			;4623
	ld (0c119h),a		;4624
	call L_4EC9		;4627
	call L_4DEC		;462a
L_462D:
	ld hl,0cec3h		;462d
	inc (hl)			;4630
	ld a,(hl)			;4631
	cp 012h		;4632
	jr c,L_4649		;4634
	ld a,(0c005h)		;4636
	cp 002h		;4639
	jr nz,L_466B		;463b
	call L_4F90		;463d
	ld a,(0c075h)		;4640
	and a			;4643
	jr z,L_466B		;4644
	jp L_4478		;4646
L_4649:
	xor a			;4649
	ld (0c011h),a		;464a
	call L_713F		;464d
	call L_6696		;4650
	jp L_41E2		;4653
L_4656:
	ld a,001h		;4656
	ld (0c076h),a		;4658
L_465B:
	ld hl,0cec3h		;465b
	inc (hl)			;465e
L_465F:
	ld a,(0c072h)		;465f
	and a			;4662
	jp m,L_4649		;4663
	ld (0c00ah),a		;4666
	jr L_4649		;4669
L_466B:
	ld hl,(0c060h)		;466b
	ld de,(0c05ch)		;466e
	rst 20h			;4672
	jp m,L_4677		;4673
	ex de,hl			;4676
L_4677:
	ld a,(0c008h)		;4677
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
	ld (0c060h),hl		;468c
	call L_486F		;468f
	ld hl,01ecch		;4692
	ld de,(0c068h)		;4695
	call L_4A3C		;4699
	inc hl			;469c
	ex de,hl			;469d
	ld hl,(0c05ch)		;469e
	call L_48A8		;46a1
	ld a,(0c008h)		;46a4
	and a			;46a7
	jr z,L_46BC		;46a8
	ld hl,01ed6h		;46aa
	ld de,(0c06ah)		;46ad
	call L_4A3C		;46b1
	inc hl			;46b4
	ex de,hl			;46b5
	ld hl,(0c05eh)		;46b6
	call L_48A8		;46b9
L_46BC:
	call L_4BE7		;46bc
	ld de,04c9bh		;46bf
	call L_4BF5		;46c2
	call L_6769		;46c5
	ld a,(0c005h)		;46c8
	cp 002h		;46cb
	jr nz,L_46EA		;46cd
	ld a,(0c0beh)		;46cf
	cp 023h		;46d2
	jr z,L_46DE		;46d4
	cp 024h		;46d6
	jr nz,L_46DE		;46d8
	ld a,(0c003h)		;46da
	dec a			;46dd
L_46DE:
	ld a,00bh		;46de
	call z,L_6B2D		;46e0
	call L_6799		;46e3
	xor a			;46e6
	call L_6B2D		;46e7
L_46EA:
	jp L_4069		;46ea
L_46ED:
	call L_4BAE		;46ed
	ld a,(0c011h)		;46f0
	and a			;46f3
	jp nz,L_6F49		;46f4
	jp L_713F		;46f7
L_46FA:
	xor a			;46fa
	ld (0c009h),a		;46fb
	ld a,(0c008h)		;46fe
	and a			;4701
	ret z			;4702
	ld a,(0c00ah)		;4703
	and a			;4706
	jr nz,L_470E		;4707
	ld a,(0c00bh)		;4709
	and a			;470c
	ret z			;470d
L_470E:
	ld a,(0c00ch)		;470e
	and a			;4711
	jr nz,L_471A		;4712
L_4714:
	ld a,001h		;4714
	ld (0c009h),a		;4716
	ret			;4719
L_471A:
	ld hl,(0c00bh)		;471a
	ld a,h			;471d
	cp l			;471e
	jr c,L_4714		;471f
	ret nz			;4721
	cp 002h		;4722
	jr c,L_4738		;4724
	ld a,001h		;4726
	ld (0c011h),a		;4728
	ld hl,0c00eh		;472b
	call L_4748		;472e
	ld hl,0c00dh		;4731
	xor a			;4734
	call L_4748		;4735
L_4738:
	ld a,001h		;4738
	call L_475C		;473a
	ld b,a			;473d
	push bc			;473e
	xor a			;473f
	call L_475C		;4740
	pop bc			;4743
	cp b			;4744
	ret nc			;4745
	jr L_4714		;4746
L_4748:
	ld (0c009h),a		;4748
	ld a,(hl)			;474b
	ld (0c60eh),a		;474c
	inc hl			;474f
	inc hl			;4750
	ld a,(hl)			;4751
	ld (0c611h),a		;4752
	xor a			;4755
	ld (0c613h),a		;4756
	jp L_59AA		;4759
L_475C:
	call L_477A		;475c
	ld a,(bc)			;475f
	sub (hl)			;4760
	jr nc,L_4765		;4761
	neg		;4763
L_4765:
	ld e,a			;4765
	inc bc			;4766
	inc hl			;4767
	inc hl			;4768
	ld a,(bc)			;4769
	sub (hl)			;476a
	jr nc,L_476F		;476b
	neg		;476d
L_476F:
	ld l,a			;476f
	srl e		;4770
	srl l		;4772
	jp L_6513		;4774
L_4777:
	ld a,(0c009h)		;4777
L_477A:
	ld hl,0c00dh		;477a
	and a			;477d
	jr z,L_4781		;477e
	inc hl			;4780
L_4781:
	ld bc,0c63fh		;4781
	ld a,(0c011h)		;4784
	and a			;4787
	ret z			;4788
	ld bc,0c63dh		;4789
	ret			;478c
L_478D:
	ld a,(0c60eh)		;478d
	ld (0c012h),a		;4790
	ld a,(0c611h)		;4793
	ld (0c013h),a		;4796
	ret			;4799
L_479A:
	ld hl,(0c63fh)		;479a
	ld a,(0c011h)		;479d
	and a			;47a0
	jr z,L_47A6		;47a1
	ld hl,(0c63dh)		;47a3
L_47A6:
	call L_47B0		;47a6
	ld (0c61fh),a		;47a9
	ld (0c660h),a		;47ac
	ret			;47af
L_47B0:
	push hl			;47b0
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
	ld a,e			;47ca
	xor d			;47cb
	jp m,L_47D4		;47cc
	ld a,l			;47cf
	xor h			;47d0
	jp p,L_47DC		;47d1
L_47D4:
	sra d		;47d4
	rr e		;47d6
	sra h		;47d8
	rr l		;47da
L_47DC:
	jp L_64C5		;47dc
L_47DF:
	ld a,(0c06ch)		;47df
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
	ld hl,0c63fh		;47f5
	ld a,(0c60eh)		;47f8
	sub (hl)			;47fb
	ld e,a			;47fc
	ld a,(0c06dh)		;47fd
	call L_6524		;4800
	ld a,(0c63dh)		;4803
	add a,l			;4806
	ld (0c60eh),a		;4807
	ld hl,0c640h		;480a
	ld a,(0c611h)		;480d
	sub (hl)			;4810
	ld e,a			;4811
	ld a,(0c06eh)		;4812
	call L_6524		;4815
	ld a,(0c63eh)		;4818
	add a,l			;481b
	ld (0c611h),a		;481c
	ld a,(0c008h)		;481f
	and a			;4822
	ret z			;4823
	ld hl,0c00bh		;4824
	ld a,(0c009h)		;4827
	and a			;482a
	jr nz,L_482E		;482b
	inc hl			;482d
L_482E:
	ld a,(hl)			;482e
	cp 002h		;482f
	ret nz			;4831
	ld a,r		;4832
	and 001h		;4834
	ld a,002h		;4836
	jr nz,L_483C		;4838
	ld a,0feh		;483a
L_483C:
	ld hl,0c60eh		;483c
	add a,(hl)			;483f
	ld (hl),a			;4840
	ret			;4841

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4842..0x4848  (6 bytes)
DATA_4842:
	defb 005h,009h,006h,00bh,007h,00dh	; 4842

; ======================================================================
; CODIGO 0x4848..0x49b4  (364 bytes)
; ======================================================================


L_4848:
	call L_478D		;4848
	ld hl,(0c63dh)		;484b
	call L_47B0		;484e
	add a,080h		;4851
	ld (0c61fh),a		;4853
	ld a,(0c63fh)		;4856
	ld (0c60eh),a		;4859
	ld a,(0c640h)		;485c
	ld (0c611h),a		;485f
L_4862:
	call L_5AC9		;4862
	call L_629C		;4865
	ld a,(0c637h)		;4868
	and a			;486b
	jr nz,L_4862		;486c
	ret			;486e
L_486F:
	ld a,(0c062h)		;486f
	ld hl,018c7h		;4872
	call L_4A4B		;4875
	ld a,(0c008h)		;4878
	and a			;487b
	ld a,(0c063h)		;487c
	ld hl,018e7h		;487f
	call nz,L_4A4B		;4882
	ld a,(0c005h)		;4885
	dec a			;4888
	jr z,L_48DE		;4889
L_488B:
	ld hl,(0c060h)		;488b
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
	ld a,020h		;48a8
	ex de,hl			;48aa
	call L_6893		;48ab
	ex de,hl			;48ae
	ld a,l			;48af
	or h			;48b0
	ld c,03ch		;48b1
	jr z,L_48C9		;48b3
	dec c			;48b5
	ld a,h			;48b6
	and a			;48b7
	jp p,L_48C3		;48b8
	xor a			;48bb
	sub l			;48bc
	ld l,a			;48bd
	sbc a,a			;48be
	sub h			;48bf
	ld h,a			;48c0
	ld c,03dh		;48c1
L_48C3:
	ld a,h			;48c3
	and a			;48c4
	jr z,L_48C9		;48c5
	ld l,063h		;48c7
L_48C9:
	ld a,l			;48c9
	ex de,hl			;48ca
	call L_4A4B		;48cb
L_48CE:
	dec hl			;48ce
	call 0004ah		;48cf   ; BIOS RDVRM - Reads the content of VRAM
	cp 020h		;48d2
	jr z,L_48DA		;48d4
	cp 03ah		;48d6
	jr c,L_48CE		;48d8
L_48DA:
	ld a,c			;48da
	jp 0004dh		;48db   ; BIOS WRTVRM - Writes data in VRAM
L_48DE:
	ld a,(0c073h)		;48de
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
	ld a,(0c075h)		;48f7
	and a			;48fa
	ret nz			;48fb
	ld a,(0cec3h)		;48fc
	ld hl,049b4h		;48ff
	call L_533C		;4902
	ex de,hl			;4905
	ld a,(0c005h)		;4906
	dec a			;4909
	jr z,L_4961		;490a
	push hl			;490c
	ld a,(0c062h)		;490d
	call L_494A		;4910
	pop hl			;4913
	inc hl			;4914
	inc hl			;4915
	inc hl			;4916
	inc hl			;4917
	ld a,(0c008h)		;4918
	and a			;491b
	ld a,(0c063h)		;491c
	call nz,L_494A		;491f
	ld hl,01e49h		;4922
	ld de,0c064h		;4925
	ld a,(0cec3h)		;4928
	cp 009h		;492b
	jr c,L_4933		;492d
	ld hl,01e58h		;492f
	inc de			;4932
L_4933:
	ld a,(de)			;4933
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
	ld b,a			;494a
	ld a,(0c06ch)		;494b
	sub b			;494e
	ld a,0d5h		;494f
	jp m,L_495A		;4951
	ld a,094h		;4954
	jr z,L_495A		;4956
	ld a,0d4h		;4958
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
	push de			;4984
	ld a,(0c074h)		;4985
	call L_4A4B		;4988
	pop hl			;498b
	xor a			;498c
	call L_4A4B		;498d
	ld hl,01e49h		;4990
	ld de,01e4dh		;4993
	ld a,(0cec3h)		;4996
	cp 009h		;4999
	jr c,L_49A3		;499b
	ld hl,01e58h		;499d
	ld de,01e5ch		;49a0
L_49A3:
	pop af			;49a3
	jr z,L_49A7		;49a4
	ex de,hl			;49a6
L_49A7:
	push de			;49a7
	ld a,(0c074h)		;49a8
	call L_4A4B		;49ab
	pop hl			;49ae
	xor a			;49af
	call L_4A4B		;49b0
	ret			;49b3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x49b4..0x49d8  (36 bytes)
DATA_49B4:
	defb 008h,01dh,028h,01dh,048h,01dh,068h,01dh,088h,01dh,0a8h,01dh,0c8h,01dh,0e8h,01dh	; 49b4  ..(.H.h.........
	defb 008h,01eh,017h,01dh,037h,01dh,057h,01dh,077h,01dh,097h,01dh,0b7h,01dh,0d7h,01dh	; 49c4  ....7.W.w.......
	defb 0f7h,01dh,017h,01eh	; 49d4

; ======================================================================
; CODIGO 0x49d8..0x4a18  (64 bytes)
; ======================================================================


L_49D8:
	ld b,012h		;49d8
L_49DA:
	push bc			;49da
	ld a,b			;49db
	dec a			;49dc
	ld (0cec3h),a		;49dd
	push af			;49e0
	call L_6F49		;49e1
	pop af			;49e4
	push af			;49e5
	ld hl,04a18h		;49e6
	call L_533C		;49e9
	ex de,hl			;49ec
	pop af			;49ed
	inc a			;49ee
	call L_4A4B		;49ef
	call L_4A13		;49f2
	inc hl			;49f5
	ld a,(0c06ch)		;49f6
	or 030h		;49f9
	call L_6893		;49fb
	call L_4A08		;49fe
	call L_4A08		;4a01
	pop bc			;4a04
	djnz L_49DA		;4a05
	ret			;4a07
L_4A08:
	call L_4A13		;4a08
	ld a,094h		;4a0b
	call L_6893		;4a0d
	inc hl			;4a10
	inc hl			;4a11
	ret			;4a12
L_4A13:
	ld a,03ah		;4a13
	jp L_6893		;4a15

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4a18..0x4a3c  (36 bytes)
DATA_4A18:
	defb 002h,01dh,022h,01dh,042h,01dh,062h,01dh,082h,01dh,0a2h,01dh,0c2h,01dh,0e2h,01dh	; 4a18  ..".B.b.........
	defb 002h,01eh,011h,01dh,031h,01dh,051h,01dh,071h,01dh,091h,01dh,0b1h,01dh,0d1h,01dh	; 4a28  ....1.Q.q.......
	defb 0f1h,01dh,011h,01eh	; 4a38

; ======================================================================
; CODIGO 0x4a3c..0x4b16  (218 bytes)
; ======================================================================


L_4A3C:
	ld a,d			;4a3c
	and a			;4a3d
	jr z,L_4A42		;4a3e
	ld e,0ffh		;4a40
L_4A42:
	ld a,e			;4a42
	ld de,00064h		;4a43
	call L_4A5B		;4a46
	jr L_4A53		;4a49
L_4A4B:
	cp 064h		;4a4b
	jr c,L_4A51		;4a4d
	ld a,063h		;4a4f
L_4A51:
	ld d,000h		;4a51
L_4A53:
	ld e,00ah		;4a53
	call L_4A5B		;4a55
	inc d			;4a58
	ld e,001h		;4a59
L_4A5B:
	ld b,02fh		;4a5b
L_4A5D:
	inc b			;4a5d
	sub e			;4a5e
	jr nc,L_4A5D		;4a5f
	add a,e			;4a61
	push af			;4a62
	ld a,b			;4a63
	cp 030h		;4a64
	jr nz,L_4A6F		;4a66
	inc d			;4a68
	dec d			;4a69
	jr nz,L_4A6F		;4a6a
	ld a,020h		;4a6c
	dec d			;4a6e
L_4A6F:
	inc d			;4a6f
	call L_6893		;4a70
	pop af			;4a73
	ret			;4a74
L_4A75:
	ld hl,018c2h		;4a75
	ld de,018e2h		;4a78
	ld a,(0c009h)		;4a7b
	and a			;4a7e
	jr z,L_4A82		;4a7f
	ex de,hl			;4a81
L_4A82:
	ld a,02fh		;4a82
	call 0004dh		;4a84   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;4a87
	ld a,020h		;4a88
	jp 0004dh		;4a8a   ; BIOS WRTVRM - Writes data in VRAM
L_4A8D:
	ld a,(0cec3h)		;4a8d
	inc a			;4a90
	ld hl,01927h		;4a91
	call L_4A4B		;4a94
	ld a,(0c06ch)		;4a97
	ld hl,01966h		;4a9a
	call L_4A4B		;4a9d
	ld hl,0cecfh		;4aa0
	ld de,01943h		;4aa3
	ld bc,00003h		;4aa6
	call 0005ch		;4aa9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	call L_4B47		;4aac
	jp L_4B84		;4aaf
L_4AB2:
	ld a,(0c621h)		;4ab2
	ld e,a			;4ab5
	add a,a			;4ab6
	add a,e			;4ab7
	ld e,a			;4ab8
	ld d,000h		;4ab9
	ld hl,04b16h		;4abb
	add hl,de			;4abe
	push hl			;4abf
	inc hl			;4ac0
	ld de,01ae7h		;4ac1
	ld bc,00002h		;4ac4
	call 0005ch		;4ac7   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,04b43h		;4aca
	ld de,01ae2h		;4acd
	ld bc,00004h		;4ad0
	call 0005ch		;4ad3   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;4ad6
	ld a,(0c007h)		;4ad7
	and a			;4ada
	ld a,(hl)			;4adb
	jr z,L_4ADF		;4adc
	rra			;4ade
L_4ADF:
	add a,01ch		;4adf
	ld hl,01b22h		;4ae1
	call L_6893		;4ae4
	ld a,00fh		;4ae7
	call 0004dh		;4ae9   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;4aec
	dec hl			;4aed
	ld a,028h		;4aee
	call 0004dh		;4af0   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;4af3
	ld a,(0c621h)		;4af4
	cp 00dh		;4af7
	ld a,0a7h		;4af9
	jr c,L_4AFF		;4afb
	ld a,0d1h		;4afd
L_4AFF:
	call 0004dh		;4aff   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0c621h)		;4b02
	cp 00dh		;4b05
	jp c,L_6806		;4b07
	ld hl,01a82h		;4b0a
	call L_4CC8		;4b0d
	ld hl,01aa2h		;4b10
	jp L_4CC8		;4b13

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4b16..0x4b47  (49 bytes)
DATA_4B16:
	defb 000h,031h,057h,000h,032h,057h,000h,033h,057h,000h,034h,057h,004h,033h,049h,004h	; 4b16  .1W.2W.3W.4W.3I.
	defb 034h,049h,004h,035h,049h,004h,036h,049h,008h,037h,049h,008h,038h,049h,008h,039h	; 4b26  4I.5I.6I.7I.8I.9
	defb 049h,00ch,050h,057h,00ch,053h,057h,00ch,050h,054h,00ch,050h,054h,043h,04ch,055h	; 4b36  I.PW.SW.PT.PTCLU
	defb 042h	; 4b46

; ======================================================================
; CODIGO 0x4b47..0x4c0b  (196 bytes)
; ======================================================================


L_4B47:
	ld hl,01b14h		;4b47
	ld a,(0c625h)		;4b4a
	and 007h		;4b4d
	add a,a			;4b4f
	add a,a			;4b50
	ld e,a			;4b51
	ld a,(0c625h)		;4b52
	and 078h		;4b55
	ld a,05fh		;4b57
	jr nz,L_4B5D		;4b59
	ld a,0d1h		;4b5b
L_4B5D:
	call L_4B9B		;4b5d
	ld hl,01983h		;4b60
	call L_4B7C		;4b63
	ld hl,019a3h		;4b66
	call L_4B7C		;4b69
	ld a,(0c625h)		;4b6c
	rrca			;4b6f
	rrca			;4b70
	rrca			;4b71
	and 00fh		;4b72
	call L_4A4B		;4b74
	ld a,03fh		;4b77
	jp 0004dh		;4b79   ; BIOS WRTVRM - Writes data in VRAM
L_4B7C:
	ld a,05fh		;4b7c
	call L_6893		;4b7e
	jp L_6893		;4b81
L_4B84:
	ld a,(0c614h)		;4b84
	sub 003h		;4b87
	ld hl,019e5h		;4b89
	call L_4A4B		;4b8c
	ld hl,01b18h		;4b8f
	ld a,(0c615h)		;4b92
	rrca			;4b95
	rrca			;4b96
	rrca			;4b97
	ld e,a			;4b98
	ld a,06fh		;4b99
L_4B9B:
	call L_6893		;4b9b
	ld a,018h		;4b9e
	call L_6893		;4ba0
	ld a,e			;4ba3
	add a,02ch		;4ba4
	call L_6893		;4ba6
	ld a,00fh		;4ba9
	jp 0004dh		;4bab   ; BIOS WRTVRM - Writes data in VRAM
L_4BAE:
	ld hl,01b0ch		;4bae
	ld a,(0c011h)		;4bb1
	and a			;4bb4
	jr nz,L_4BE7		;4bb5
	ld a,(0c640h)		;4bb7
	sub 005h		;4bba
	call L_6893		;4bbc
	ld a,(0c63fh)		;4bbf
	call L_6893		;4bc2
	ld a,014h		;4bc5
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
	ld hl,01b0ch		;4be7
	ld a,0d1h		;4bea
	call L_6893		;4bec
	inc hl			;4bef
	inc hl			;4bf0
	inc hl			;4bf1
	jp 0004dh		;4bf2   ; BIOS WRTVRM - Writes data in VRAM
L_4BF5:
	call L_4BFD		;4bf5
L_4BF8:
	ld b,078h		;4bf8
	jp L_6698		;4bfa
L_4BFD:
	ld hl,01a42h		;4bfd
	call L_4C06		;4c00
	ld hl,01a62h		;4c03
L_4C06:
	ld b,007h		;4c06
	jp L_6822		;4c08

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4c0b..0x4cc8  (189 bytes)
DATA_4C0B:
	defb 048h,04fh,04ch,045h,020h,049h,04eh,020h,04fh,04eh,045h,05bh,05bh,020h,003h,041h	; 4c0b  HOLE IN ONE[[ .A
	defb 04ch,042h,041h,03dh,020h,020h,020h,054h,052h,04fh,053h,053h,05bh,003h,007h,045h	; 4c1b  LBA=   TROSS[..E
	defb 041h,047h,04ch,045h,05bh,05bh,008h,007h,042h,049h,052h,044h,049h,045h,05bh,009h	; 4c2b  AGLE[[..BIRDIE[.
	defb 007h,020h,020h,050h,041h,052h,020h,020h,00ah,007h,020h,042h,04fh,047h,045h,059h	; 4c3b  .  PAR  .. BOGEY
	defb 020h,007h,044h,04fh,055h,042h,04ch,045h,020h,020h,020h,042h,04fh,047h,045h,059h	; 4c4b   .DOUBLE   BOGEY
	defb 007h,054h,052h,049h,050h,04ch,045h,020h,020h,020h,042h,04fh,047h,045h,059h,007h	; 4c5b  .TRIPLE   BOGEY.
	defb 007h,046h,041h,049h,052h,057h,041h,059h,007h,020h,052h,04fh,055h,047h,048h,020h	; 4c6b  .FAIRWAY. ROUGH 
	defb 007h,020h,042h,055h,04eh,04bh,045h,052h,057h,041h,054h,045h,052h,020h,020h,020h	; 4c7b  . BUNKERWATER   
	defb 048h,041h,05ah,041h,052h,044h,007h,003h,04fh,042h,002h,007h,004h,04fh,04eh,020h	; 4c8b  HAZARD..OB...ON 
	defb 020h,048h,04fh,04ch,045h,002h,003h,04fh,055h,054h,020h,007h,050h,04ch,041h,059h	; 4c9b   HOLE..OUT .PLAY
	defb 04fh,046h,046h,044h,04fh,052h,04dh,059h,002h,020h,048h,04fh,04ch,045h,002h,01ah	; 4cab  OFFDORMY. HOLE..
	defb 04ch,029h,04ch,032h,04ch,03bh,04ch,044h,04ch,04dh,04ch,05ch,04ch	; 4cbb  L)L2L;LDLML\L

; ======================================================================
; CODIGO 0x4cc8..0x5009  (833 bytes)
; ======================================================================


L_4CC8:
	ld bc,00007h		;4cc8
	ld a,020h		;4ccb
	jp 00056h		;4ccd   ; BIOS FILVRM - Fills VRAM with value
L_4CD0:
	push bc			;4cd0
	push hl			;4cd1
	ld b,00bh		;4cd2
	ld hl,(0c06fh)		;4cd4
L_4CD7:
	add hl,hl			;4cd7
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
	ld (0c06fh),hl		;4ce8
	pop hl			;4ceb
	pop bc			;4cec
	ret			;4ced
L_4CEE:
	cp b			;4cee
	ret c			;4cef
	sub b			;4cf0
	jr L_4CEE		;4cf1
L_4CF3:
	ld hl,0c0e1h		;4cf3
	ld de,0c077h		;4cf6
	ld b,024h		;4cf9
L_4CFB:
	ld a,b			;4cfb
	dec a			;4cfc
	ld (hl),a			;4cfd
	ld (de),a			;4cfe
	dec hl			;4cff
	inc de			;4d00
	djnz L_4CFB		;4d01
	ld b,032h		;4d03
L_4D05:
	call L_4D61		;4d05
	ex de,hl			;4d08
	call L_4D61		;4d09
	ld a,(de)			;4d0c
	ld c,(hl)			;4d0d
	ld (hl),a			;4d0e
	ld a,c			;4d0f
	ld (de),a			;4d10
	djnz L_4D05		;4d11
	ld a,(0c114h)		;4d13
	ld hl,0c078h		;4d16
L_4D19:
	cp (hl)			;4d19
	jr z,L_4D1F		;4d1a
	inc hl			;4d1c
	jr L_4D19		;4d1d
L_4D1F:
	ld de,0c078h		;4d1f
	ld a,(de)			;4d22
	ld c,(hl)			;4d23
	ld (hl),a			;4d24
	ld a,024h		;4d25
	ld (de),a			;4d27
	ld a,c			;4d28
	ld hl,0c0beh		;4d29
L_4D2C:
	cp (hl)			;4d2c
	jr z,L_4D32		;4d2d
	inc hl			;4d2f
	jr L_4D2C		;4d30
L_4D32:
	ld (hl),024h		;4d32
	ld hl,0c016h		;4d34
	ld de,0c017h		;4d37
	ld bc,00049h		;4d3a
	ld (hl),000h		;4d3d
	ldir		;4d3f
	ld b,023h		;4d41
	ld hl,0c09bh		;4d43
L_4D46:
	call L_4CD0		;4d46
	and 007h		;4d49
	ld (hl),a			;4d4b
	inc hl			;4d4c
	djnz L_4D46		;4d4d
	xor a			;4d4f
	ld (0c0f5h),a		;4d50
	ld hl,0cec3h		;4d53
	ld (hl),0fdh		;4d56
L_4D58:
	push hl			;4d58
	call L_4EC9		;4d59
	pop hl			;4d5c
	inc (hl)			;4d5d
	jr nz,L_4D58		;4d5e
	ret			;4d60
L_4D61:
	push bc			;4d61
	call L_4CD0		;4d62
	ld b,023h		;4d65
	call L_4CEE		;4d67
	ld c,a			;4d6a
	ld b,000h		;4d6b
	ld hl,0c078h		;4d6d
	add hl,bc			;4d70
	pop bc			;4d71
	ret			;4d72
L_4D73:
	cp 023h		;4d73
	ld de,0c0f6h		;4d75
	ret z			;4d78
	cp 024h		;4d79
	ld de,0c104h		;4d7b
	ret z			;4d7e
	ld de,05009h		;4d7f
	inc a			;4d82
L_4D83:
	dec a			;4d83
	ret z			;4d84
	push af			;4d85
L_4D86:
	ld a,(de)			;4d86
	and a			;4d87
	inc de			;4d88
	jp p,L_4D86		;4d89
	pop af			;4d8c
	jr L_4D83		;4d8d
L_4D8F:
	ld b,000h		;4d8f
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
	and a			;4d9c
	ret z			;4d9d
	push af			;4d9e
	call L_4EBF		;4d9f
	call L_4DBE		;4da2
	pop af			;4da5
	push af			;4da6
	push de			;4da7
	dec a			;4da8
	call L_4EBF		;4da9
	call L_4DBE		;4dac
	pop bc			;4daf
	ld a,b			;4db0
	cp d			;4db1
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
	push hl			;4dbe
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
	push bc			;4dcc
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
	sub 009h		;4ddd
	jr c,L_4DE4		;4ddf
	inc b			;4de1
	jr L_4DDD		;4de2
L_4DE4:
	ld a,(0c0f4h)		;4de4
	inc a			;4de7
	add a,b			;4de8
	pop hl			;4de9
	pop bc			;4dea
	ret			;4deb
L_4DEC:
	xor a			;4dec
	ex af,af'			;4ded
	ld b,023h		;4dee
	ld hl,0c0beh		;4df0
L_4DF3:
	push hl			;4df3
	ld a,(hl)			;4df4
	call L_4DBE		;4df5
	inc hl			;4df8
	ld a,(hl)			;4df9
	ex de,hl			;4dfa
	call L_4DBE		;4dfb
	and a			;4dfe
	sbc hl,de		;4dff
	pop hl			;4e01
	jp m,L_4E25		;4e02
	jr nz,L_4E1D		;4e05
	ld a,(hl)			;4e07
	call L_4DCC		;4e08
	ld e,a			;4e0b
	inc hl			;4e0c
	ld a,(hl)			;4e0d
	dec hl			;4e0e
	call L_4DCC		;4e0f
	cp e			;4e12
	jr c,L_4E25		;4e13
	jr nz,L_4E1D		;4e15
	ld a,(hl)			;4e17
	inc hl			;4e18
	cp (hl)			;4e19
	dec hl			;4e1a
	jr nc,L_4E25		;4e1b
L_4E1D:
	ld a,(hl)			;4e1d
	inc hl			;4e1e
	ld c,(hl)			;4e1f
	ld (hl),a			;4e20
	dec hl			;4e21
	ld (hl),c			;4e22
	scf			;4e23
	ex af,af'			;4e24
L_4E25:
	inc hl			;4e25
	djnz L_4DF3		;4e26
	ex af,af'			;4e28
	jr c,L_4DEC		;4e29
L_4E2B:
	ld hl,0c112h		;4e2b
	ld (hl),000h		;4e2e
L_4E30:
	ld a,(hl)			;4e30
	ld b,012h		;4e31
	ld hl,03ca3h		;4e33
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
	inc (hl)			;4e41
	ld a,(hl)			;4e42
	cp 013h		;4e43
	jr c,L_4E30		;4e45
L_4E47:
	dec (hl)			;4e47
	jp p,L_4E30		;4e48
	jr L_4E41		;4e4b
L_4E4D:
	push af			;4e4d
	call L_4D9C		;4e4e
	inc a			;4e51
	call L_4A4B		;4e52
	pop af			;4e55
	call L_4EBF		;4e56
	push af			;4e59
	cp 023h		;4e5a
	ld a,020h		;4e5c
	jr c,L_4E62		;4e5e
	ld a,02fh		;4e60
L_4E62:
	push hl			;4e62
	dec hl			;4e63
	dec hl			;4e64
	dec hl			;4e65
	call 0004dh		;4e66   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;4e69
	pop af			;4e6a
	push af			;4e6b
	call L_4D73		;4e6c
	inc hl			;4e6f
	inc hl			;4e70
	ld b,00eh		;4e71
L_4E73:
	ld a,(de)			;4e73
	push af			;4e74
	and 07fh		;4e75
	call L_6893		;4e77
	inc de			;4e7a
	pop af			;4e7b
	dec b			;4e7c
	and a			;4e7d
	jp m,L_4E86		;4e7e
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
	call L_4DBE		;4e8f
	push hl			;4e92
	ex de,hl			;4e93
	call L_48A8		;4e94
	pop hl			;4e97
	call L_4EBA		;4e98
	pop af			;4e9b
	call L_4DCC		;4e9c
	cp 012h		;4e9f
	jr nc,L_4EAF		;4ea1
	and a			;4ea3
	jr z,L_4EAB		;4ea4
	call L_4A4B		;4ea6
	jr L_4EBA		;4ea9
L_4EAB:
	ld b,03dh		;4eab
	jr L_4EB1		;4ead
L_4EAF:
	ld b,046h		;4eaf
L_4EB1:
	ld a,020h		;4eb1
	call L_6893		;4eb3
	ld a,b			;4eb6
	call L_6893		;4eb7
L_4EBA:
	ld de,00006h		;4eba
	add hl,de			;4ebd
	ret			;4ebe
L_4EBF:
	add a,0beh		;4ebf
	ld e,a			;4ec1
	ld a,0c0h		;4ec2
	adc a,000h		;4ec4
	ld d,a			;4ec6
	ld a,(de)			;4ec7
	ret			;4ec8
L_4EC9:
	ld a,(0c075h)		;4ec9
	and a			;4ecc
	ret nz			;4ecd
	ld a,(0cec3h)		;4ece
	ld (0c0f4h),a		;4ed1
	ld bc,02400h		;4ed4
	ld ix,0c077h		;4ed7
L_4EDB:
	push bc			;4edb
	ld a,(ix+000h)		;4edc
	cp 023h		;4edf
	jr nc,L_4F43		;4ee1
	ld a,c			;4ee3
	ld c,000h		;4ee4
L_4EE6:
	sub 009h		;4ee6
	jr c,L_4EED		;4ee8
	inc c			;4eea
	jr L_4EE6		;4eeb
L_4EED:
	ld a,(0c0f4h)		;4eed
	add a,c			;4ef0
	cp 012h		;4ef1
	jr nc,L_4F43		;4ef3
	ld hl,05153h		;4ef5
	ld a,(0c0f5h)		;4ef8
	and a			;4efb
	jp m,L_4F05		;4efc
	jr z,L_4F03		;4eff
	inc hl			;4f01
	inc hl			;4f02
L_4F03:
	inc hl			;4f03
	inc hl			;4f04
L_4F05:
	ld e,(hl)			;4f05
	inc hl			;4f06
	ld d,(hl)			;4f07
	call L_4CD0		;4f08
	ld c,(ix+000h)		;4f0b
	ld b,000h		;4f0e
	ld hl,0c09bh		;4f10
	add hl,bc			;4f13
	sub (hl)			;4f14
	jr nc,L_4F18		;4f15
	xor a			;4f17
L_4F18:
	ld hl,05130h		;4f18
	add hl,bc			;4f1b
	add a,(hl)			;4f1c
	jr nc,L_4F21		;4f1d
	ld a,0ffh		;4f1f
L_4F21:
	ld hl,0c016h		;4f21
	add hl,bc			;4f24
	add hl,bc			;4f25
	ex de,hl			;4f26
L_4F27:
	cp (hl)			;4f27
	inc hl			;4f28
	jr z,L_4F30		;4f29
	jr c,L_4F30		;4f2b
	inc hl			;4f2d
	jr L_4F27		;4f2e
L_4F30:
	ld c,(hl)			;4f30
	inc c			;4f31
	dec c			;4f32
	ld b,000h		;4f33
	jp p,L_4F39		;4f35
	dec b			;4f38
L_4F39:
	ex de,hl			;4f39
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
	inc c			;4f44
	inc ix		;4f45
	djnz L_4EDB		;4f47
	ret			;4f49
L_4F4A:
	ld a,(0c114h)		;4f4a
	call L_4D73		;4f4d
	ld b,00eh		;4f50
	ld hl,0c104h		;4f52
L_4F55:
	ld a,(de)			;4f55
	and 07fh		;4f56
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
	inc hl			;4f65
	ld (hl),020h		;4f66
	djnz L_4F65		;4f68
L_4F6A:
	call L_BB43		;4f6a
	ld hl,0c114h		;4f6d
L_4F70:
	call 0009fh		;4f70   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;4f73
	ret z			;4f75
	cp 01eh		;4f76
	jr z,L_4F88		;4f78
	cp 01fh		;4f7a
	jr nz,L_4F70		;4f7c
	inc (hl)			;4f7e
	ld a,(hl)			;4f7f
	cp 023h		;4f80
	jr c,L_4F4A		;4f82
	ld (hl),000h		;4f84
	jr L_4F4A		;4f86
L_4F88:
	dec (hl)			;4f88
	jp p,L_4F4A		;4f89
	ld (hl),022h		;4f8c
	jr L_4F4A		;4f8e
L_4F90:
	xor a			;4f90
L_4F91:
	push af			;4f91
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
	ld a,023h		;4f9f
	call L_4D8F		;4fa1
	and a			;4fa4
	jr z,L_4FB8		;4fa5
	ld a,(0c003h)		;4fa7
	and a			;4faa
	ret z			;4fab
	ld a,024h		;4fac
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
	ld (0c116h),a		;4fce
	and a			;4fd1
	ld a,001h		;4fd2
	ld (0c075h),a		;4fd4
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
; DATOS sin identificar  0x5009..0x5175  (364 bytes)
DATA_5009:
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
	defb 04eh,03eh,04fh,05ah,041h,04bh,0c9h,007h,007h,005h,007h,005h,005h,005h,005h,007h	; 5129  N>OZAK..........
	defb 003h,003h,007h,007h,001h,005h,001h,000h,000h,003h,001h,001h,000h,000h,000h,000h	; 5139  ................
	defb 007h,003h,001h,001h,003h,005h,000h,003h,003h,001h,059h,051h,063h,051h,06dh,051h	; 5149  ..........YQcQmQ
	defb 008h,002h,024h,001h,0b3h,000h,0fbh,0ffh,0ffh,0feh,008h,002h,031h,001h,0cah,000h	; 5159  ..$.........1...
	defb 0fdh,0ffh,0ffh,0feh,00dh,002h,045h,001h,0d4h,000h,0ffh,0ffh	; 5169  ......E.....

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
	call L_6F49		;51a4
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
; DATOS sin identificar  0x51e5..0x52de  (249 bytes)
DATA_51E5:
	defb 040h,020h,048h,041h,04ch,020h,04ch,041h,042h,04fh,052h,041h,054h,04fh,052h,059h	; 51e5  @ HAL LABORATORY
	defb 020h,031h,039h,038h,035h,00fh,006h,050h,052h,04fh,044h,055h,043h,045h,052h,020h	; 51f5   1985..PRODUCER 
	defb 020h,020h,046h,03eh,04eh,041h,04bh,041h,04dh,055h,052h,041h,050h,052h,04fh,047h	; 5205    F>NAKAMURAPROG
	defb 052h,041h,04dh,04dh,045h,052h,020h,053h,03eh,049h,057h,041h,054h,041h,003h,020h	; 5215  RAMMER S>IWATA. 
	defb 050h,04ch,041h,059h,045h,052h,03eh,03eh,031h,00bh,020h,04ch,045h,056h,045h,04ch	; 5225  PLAYER>>1. LEVEL
	defb 020h,03eh,03eh,041h,056h,045h,052h,041h,047h,045h,020h,020h,020h,020h,020h,020h	; 5235   >>AVERAGE      
	defb 047h,041h,04dh,045h,020h,020h,03eh,03eh,053h,054h,052h,04fh,04bh,045h,020h,050h	; 5245  GAME  >>STROKE P
	defb 04ch,041h,059h,020h,020h,043h,04fh,055h,052h,053h,045h,03eh,03eh,051h,055h,045h	; 5255  LAY  COURSE>>QUE
	defb 045h,04eh,020h,053h,049h,044h,045h,020h,020h,045h,058h,050h,045h,052h,054h,020h	; 5265  EN SIDE  EXPERT 
	defb 020h,020h,020h,020h,020h,050h,052h,04fh,046h,045h,053h,053h,049h,04fh,04eh,041h	; 5275       PROFESSIONA
	defb 04ch,04bh,049h,04eh,047h,020h,053h,049h,044h,045h,020h,020h,020h,055h,053h,045h	; 5285  LKING SIDE   USE
	defb 052h,020h,020h,020h,020h,020h,020h,020h,020h,04dh,041h,054h,043h,048h,020h,050h	; 5295  R        MATCH P
	defb 04ch,041h,059h,020h,020h,054h,04fh,055h,052h,04eh,041h,04dh,045h,04eh,054h,020h	; 52a5  LAY  TOURNAMENT 
	defb 020h,043h,04fh,04eh,053h,054h,052h,055h,043h,054h,049h,04fh,04eh,005h,054h,04fh	; 52b5   CONSTRUCTION.TO
	defb 055h,052h,04eh,041h,04dh,045h,04eh,054h,006h,00fh,006h,020h,031h,055h,050h,03ah	; 52c5  URNAMENT... 1UP:
	defb 020h,00fh,020h,032h,055h,050h,03ah,020h,00fh	; 52d5   . 2UP: .

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
	call L_533C		;5313
	ld hl,01a6fh		;5316
	call L_5337		;5319
	ld a,(0c005h)		;531c
	ld hl,05345h		;531f
	call L_533C		;5322
	ld hl,01a8fh		;5325
	call L_5337		;5328
	ld a,(0c004h)		;532b
	ld hl,0534dh		;532e
	call L_533C		;5331
	ld hl,01aafh		;5334
L_5337:
	ld b,00ch		;5337
	jp L_6822		;5339
L_533C:
	add a,a			;533c
	ld e,a			;533d
	ld d,000h		;533e
	add hl,de			;5340
	ld e,(hl)			;5341
	inc hl			;5342
	ld d,(hl)			;5343
	ret			;5344

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5345..0x5359  (20 bytes)
DATA_5345:
	defb 04dh,052h,09eh,052h,0aah,052h,0b6h,052h,062h,052h,086h,052h,092h,052h,038h,052h	; 5345  MR.R.R.RbR.R.R8R
	defb 06eh,052h,07ah,052h	; 5355

; ======================================================================
; CODIGO 0x5359..0x5495  (316 bytes)
; ======================================================================


L_5359:
	call L_680A		;5359
	call L_4AB2		;535c
	xor a			;535f
	ld (0c633h),a		;5360
	ld (0c634h),a		;5363
	ld (0c623h),a		;5366
	ld (0c622h),a		;5369
	ld hl,(0c012h)		;536c
	ld (0c644h),hl		;536f
	ld a,(0c117h)		;5372
	and a			;5375
	jp nz,L_5408		;5376
	call L_59AA		;5379
	call L_54AF		;537c
	ld a,(0c009h)		;537f
	call L_59AA		;5382
	ld b,003h		;5385
	call L_6698		;5387
	call L_55E6		;538a
	jr c,L_5359		;538d
	ld a,(0c641h)		;538f
	add a,a			;5392
	add a,a			;5393
	add a,a			;5394
	add a,01fh		;5395
	ld (0c61dh),a		;5397
	ld b,003h		;539a
	call L_6698		;539c
	ld a,(0c621h)		;539f
	cp 00dh		;53a2
	call c,L_5676		;53a4
L_53A7:
	ld hl,0c641h		;53a7
	ld a,(hl)			;53aa
	and a			;53ab
	jp p,L_53B1		;53ac
	ld (hl),000h		;53af
L_53B1:
	ld a,(0c007h)		;53b1
	and a			;53b4
	ld a,(0c621h)		;53b5
	jr z,L_53BB		;53b8
	rra			;53ba
L_53BB:
	add a,a			;53bb
	ld e,a			;53bc
	ld d,000h		;53bd
	ld hl,05495h		;53bf
	add hl,de			;53c2
	ld a,(0c641h)		;53c3
	cp (hl)			;53c6
	jr nc,L_53D4		;53c7
	sub (hl)			;53c9
	neg		;53ca
	call L_53FD		;53cc
	ld (0c623h),a		;53cf
	jr L_53E1		;53d2
L_53D4:
	inc hl			;53d4
	cp (hl)			;53d5
	jr c,L_53E1		;53d6
	jr z,L_53E1		;53d8
	sub (hl)			;53da
	call L_53FD		;53db
	ld (0c622h),a		;53de
L_53E1:
	ld a,(0c006h)		;53e1
	and a			;53e4
	jr nz,L_53EE		;53e5
	ld a,(0c118h)		;53e7
	and a			;53ea
	call z,L_9E38		;53eb
L_53EE:
	ld a,(0c60eh)		;53ee
	ld (0cf0fh),a		;53f1
	ld a,(0c611h)		;53f4
	ld (0cf10h),a		;53f7
	jp L_57FC		;53fa
L_53FD:
	cp 009h		;53fd
	jr c,L_5403		;53ff
	ld a,009h		;5401
L_5403:
	neg		;5403
	add a,00bh		;5405
	ret			;5407
L_5408:
	call L_5435		;5408
	call L_5461		;540b
	ld a,(0c665h)		;540e
	add a,a			;5411
	add a,a			;5412
	add a,a			;5413
	add a,01fh		;5414
	ld (0c61dh),a		;5416
	ld a,(0c667h)		;5419
	ld (0c621h),a		;541c
	cp 00dh		;541f
	jp nc,L_53A7		;5421
	call L_5477		;5424
	ld a,(0c666h)		;5427
	ld (0c641h),a		;542a
	ld b,03ch		;542d
	call L_6698		;542f
	jp L_53A7		;5432
L_5435:
	ld a,(0c65fh)		;5435
	ld b,a			;5438
	ld a,(0c61fh)		;5439
	ld c,a			;543c
	sub b			;543d
	ld a,c			;543e
	ld c,0ffh		;543f
	jp p,L_5446		;5441
	ld c,001h		;5444
L_5446:
	push af			;5446
	push bc			;5447
	ld (0c61fh),a		;5448
	call L_5597		;544b
	call L_6666		;544e
	pop bc			;5451
	pop af			;5452
	cp b			;5453
	jr z,L_5459		;5454
	add a,c			;5456
	jr L_5446		;5457
L_5459:
	ld (0c61fh),a		;5459
	ld b,03ch		;545c
	jp L_6698		;545e
L_5461:
	call L_5603		;5461
L_5464:
	call L_561D		;5464
	ld a,(0c641h)		;5467
	ld b,a			;546a
	ld a,(0c665h)		;546b
	cp b			;546e
	jr nz,L_5464		;546f
	ex af,af'			;5471
	dec a			;5472
	ret z			;5473
	ex af,af'			;5474
	jr L_5464		;5475
L_5477:
	call L_5603		;5477
	ld a,(0c666h)		;547a
	and 001h		;547d
	ld (0c641h),a		;547f
L_5482:
	call L_5682		;5482
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
; DATOS sin identificar  0x5495..0x54af  (26 bytes)
DATA_5495:
	defb 01bh,01ch,01bh,01ch,01bh,01ch,01bh,01ch,01ah,01dh,01ah,01dh,01ah,01dh,01ah,01dh	; 5495  ................
	defb 019h,01eh,019h,01eh,019h,01eh,018h,01fh,018h,01fh	; 54a5  ..........

; ======================================================================
; CODIGO 0x54af..0x63e9  (3898 bytes)
; ======================================================================


L_54AF:
	ld a,(0ca34h)		;54af
	cp 002h		;54b2
	jr z,L_5507		;54b4
	ld b,002h		;54b6
	call L_6698		;54b8
	call L_55C8		;54bb
	call L_5597		;54be
	call L_6A4F		;54c1
	ret nz			;54c4
	ld a,(0c006h)		;54c5
	and a			;54c8
	call nz,L_B243		;54c9
	call L_BBE5		;54cc
	jr z,L_54AF		;54cf
	call L_BBEF		;54d1
	jr z,L_54AF		;54d4
	call L_6A6F		;54d6
	ld b,a			;54d9
	ld hl,0c61fh		;54da
	cp 003h		;54dd
	jr nz,L_54E2		;54df
	inc (hl)			;54e1
L_54E2:
	cp 007h		;54e2
	jr nz,L_54E7		;54e4
	dec (hl)			;54e6
L_54E7:
	call L_5580		;54e7
	jr nc,L_54AF		;54ea
	ld a,b			;54ec
	cp 001h		;54ed
	jr nz,L_54F7		;54ef
	dec (hl)			;54f1
	call L_5570		;54f2
	jr L_5500		;54f5
L_54F7:
	cp 005h		;54f7
	jp nz,L_54AF		;54f9
	inc (hl)			;54fc
	call L_5570		;54fd
L_5500:
	call L_6A6F		;5500
	jr nz,L_5500		;5503
	jr L_54AF		;5505
L_5507:
	call L_5580		;5507
L_550A:
	call L_55C8		;550a
	call L_6A84		;550d
	ld hl,(0c644h)		;5510
	ld a,l			;5513
	add a,c			;5514
	cp 0f8h		;5515
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
	cp 0f7h		;5524
	jr c,L_5529		;5526
	xor a			;5528
L_5529:
	cp 0c0h		;5529
	jr c,L_552F		;552b
	ld a,0bfh		;552d
L_552F:
	ld h,a			;552f
	ld (0c644h),hl		;5530
	call L_47B0		;5533
	ld (0c61fh),a		;5536
	ld hl,(0c644h)		;5539
	ld a,h			;553c
	ld c,l			;553d
	call L_55B0		;553e
	call L_6A4F		;5541
	jr z,L_550A		;5544
L_5546:
	call L_59AA		;5546
	call L_5580		;5549
	ret nc			;554c
	call L_6A84		;554d
	ld a,e			;5550
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
	ld de,0c647h		;555d
	ex de,hl			;5560
	add a,(hl)			;5561
	ld (hl),a			;5562
	ex de,hl			;5563
	ld a,b			;5564
	adc a,(hl)			;5565
	ld (hl),a			;5566
	call L_5570		;5567
L_556A:
	call L_6A4F		;556a
	ret nz			;556d
	jr L_5546		;556e
L_5570:
	ld a,(hl)			;5570
	and a			;5571
	jp p,L_5577		;5572
	ld a,00dh		;5575
L_5577:
	cp 00eh		;5577
	jr c,L_557C		;5579
	xor a			;557b
L_557C:
	ld (hl),a			;557c
	jp L_4AB2		;557d
L_5580:
	ld a,(0c011h)		;5580
	and a			;5583
	ld hl,0c621h		;5584
	jr z,L_5590		;5587
	ld (hl),00eh		;5589
	call L_4AB2		;558b
	and a			;558e
	ret			;558f
L_5590:
	ld a,(hl)			;5590
	cp 00eh		;5591
	ret c			;5593
	dec (hl)			;5594
	scf			;5595
	ret			;5596
L_5597:
	ld a,010h		;5597
	ld (0c620h),a		;5599
	ld a,(0c61fh)		;559c
	push af			;559f
	call L_57E5		;55a0
	ld a,(0c60eh)		;55a3
	add a,l			;55a6
	ld c,a			;55a7
	pop af			;55a8
	call L_57E0		;55a9
	ld a,(0c611h)		;55ac
	add a,l			;55af
L_55B0:
	ld hl,01b08h		;55b0
	sub 003h		;55b3
	call L_6893		;55b5
	ld a,c			;55b8
	sub 002h		;55b9
	call L_6893		;55bb
	ld a,00ch		;55be
	call L_6893		;55c0
	ld a,00fh		;55c3
	jp 0004dh		;55c5   ; BIOS WRTVRM - Writes data in VRAM
L_55C8:
	ld hl,01b03h		;55c8
	ld a,(0c009h)		;55cb
	and a			;55ce
	ld e,00fh		;55cf
	jr z,L_55D9		;55d1
	ld e,009h		;55d3
	inc hl			;55d5
	inc hl			;55d6
	inc hl			;55d7
	inc hl			;55d8
L_55D9:
	call 0004ah		;55d9   ; BIOS RDVRM - Reads the content of VRAM
	cp 002h		;55dc
	ld a,e			;55de
	jr z,L_55E3		;55df
	ld a,002h		;55e1
L_55E3:
	jp 0004dh		;55e3   ; BIOS WRTVRM - Writes data in VRAM
L_55E6:
	call L_5603		;55e6
L_55E9:
	call L_561D		;55e9
	call L_6A4F		;55ec
	ret nz			;55ef
	ld a,007h		;55f0
	call 00141h		;55f2   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 010h		;55f5
	scf			;55f7
	ret z			;55f8
	ld a,004h		;55f9
	call 000d8h		;55fb   ; BIOS GTTRIG - Returns current trigger status
	and a			;55fe
	scf			;55ff
	ret nz			;5600
	jr L_55E9		;5601
L_5603:
	call L_4CD0		;5603
	and 003h		;5606
	inc a			;5608
	ex af,af'			;5609
	ld a,(0c007h)		;560a
	srl a		;560d
	inc a			;560f
	ld (0c642h),a		;5610
	ld a,0ffh		;5613
	ld (0c643h),a		;5615
	inc a			;5618
	ld (0c641h),a		;5619
	ret			;561c
L_561D:
	ld hl,0c641h		;561d
	ld a,(0c643h)		;5620
	and a			;5623
	jr nz,L_5628		;5624
	inc (hl)			;5626
	inc (hl)			;5627
L_5628:
	dec (hl)			;5628
	ld a,(hl)			;5629
	and a			;562a
	jp p,L_5634		;562b
	ld (hl),000h		;562e
	xor a			;5630
	ld (0c643h),a		;5631
L_5634:
	cp 01dh		;5634
	jr c,L_563F		;5636
	ld (hl),01ch		;5638
	ld a,0ffh		;563a
	ld (0c643h),a		;563c
L_563F:
	call L_6666		;563f
	ld a,(0c007h)		;5642
	and a			;5645
	call z,L_6666		;5646
	ld a,(0c641h)		;5649
	rrca			;564c
	rrca			;564d
	and 007h		;564e
	ld b,a			;5650
	ld hl,01a68h		;5651
	jr z,L_565E		;5654
L_5656:
	ld a,05fh		;5656
	call 0004dh		;5658   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;565b
	djnz L_5656		;565c
L_565E:
	ld a,(0c641h)		;565e
	and 003h		;5661
	jr z,L_566B		;5663
	add a,05bh		;5665
	call 0004dh		;5667   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;566a
L_566B:
	ld a,l			;566b
	cp 062h		;566c
	ret c			;566e
	xor a			;566f
	call 0004dh		;5670   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;5673
	jr L_566B		;5674
L_5676:
	call L_5603		;5676
L_5679:
	call L_5682		;5679
	call L_6A4F		;567c
	ret nz			;567f
	jr L_5679		;5680
L_5682:
	ld a,(0c643h)		;5682
	and a			;5685
	ld a,(0c641h)		;5686
	ld hl,0c642h		;5689
	jr nz,L_5690		;568c
	add a,(hl)			;568e
	add a,(hl)			;568f
L_5690:
	sub (hl)			;5690
	and a			;5691
	jp p,L_569D		;5692
	push af			;5695
	xor a			;5696
	ld (0c643h),a		;5697
	pop af			;569a
	jr L_56A8		;569b
L_569D:
	cp 038h		;569d
	jr c,L_56A8		;569f
	push af			;56a1
	ld a,0ffh		;56a2
	ld (0c643h),a		;56a4
	pop af			;56a7
L_56A8:
	ld (0c641h),a		;56a8
	call L_6666		;56ab
	ld hl,01b1ch		;56ae
	ld a,0afh		;56b1
	call L_6893		;56b3
	ld a,(0c641h)		;56b6
	neg		;56b9
	add a,044h		;56bb
	call L_6893		;56bd
	ld a,018h		;56c0
	call L_6893		;56c2
	ld a,00bh		;56c5
	jp 0004dh		;56c7   ; BIOS WRTVRM - Writes data in VRAM
L_56CA:
	xor a			;56ca
	ld (0c672h),a		;56cb
	call L_5749		;56ce
	ld a,080h		;56d1
	ld (0c616h),a		;56d3
	ld (0c618h),a		;56d6
L_56D9:
	call L_5769		;56d9
	call L_59AA		;56dc
	call L_5EE4		;56df
	ld hl,0c664h		;56e2
	cp (hl)			;56e5
	jr nc,L_56F7		;56e6
	ld (hl),a			;56e8
	ld a,(0c60eh)		;56e9
	ld l,a			;56ec
	ld a,(0c611h)		;56ed
	ld h,a			;56f0
	call L_47B0		;56f1
	ld (0c660h),a		;56f4
L_56F7:
	ld a,(0c634h)		;56f7
	and a			;56fa
	jr z,L_5735		;56fb
	ld a,(0c630h)		;56fd
	and a			;5700
	jr nz,L_5735		;5701
	ld a,(0c007h)		;5703
	add a,a			;5706
	add a,a			;5707
	add a,a			;5708
	ld hl,0c61eh		;5709
	add a,(hl)			;570c
	cp 03ch		;570d
	ret c			;570f
	ld a,001h		;5710
	ld (0c672h),a		;5712
	call L_4CD0		;5715
	ld b,a			;5718
	and 01fh		;5719
	add a,007h		;571b
	bit 7,b		;571d
	jr z,L_5723		;571f
	neg		;5721
L_5723:
	ld hl,0c61fh		;5723
	add a,(hl)			;5726
	ld (hl),a			;5727
	ld hl,0c61eh		;5728
	srl (hl)		;572b
	call L_5749		;572d
	ld a,001h		;5730
	ld (0c630h),a		;5732
L_5735:
	xor a			;5735
	ld (0c634h),a		;5736
	ld a,(0c633h)		;5739
	and a			;573c
	ret nz			;573d
	call L_5761		;573e
	ld a,(0c61eh)		;5741
	cp 005h		;5744
	jr nc,L_56D9		;5746
	ret			;5748
L_5749:
	ld a,(0c61eh)		;5749
	ld (0c620h),a		;574c
	ld a,(0c61fh)		;574f
	push af			;5752
	call L_57E5		;5753
	ld (0c617h),a		;5756
	pop af			;5759
	call L_57E0		;575a
	ld (0c619h),a		;575d
	ret			;5760
L_5761:
	ld a,(0c118h)		;5761
	and a			;5764
	ret nz			;5765
	jp L_6666		;5766
L_5769:
	ld b,002h		;5769
L_576B:
	ld a,(0c617h)		;576b
	call L_57F5		;576e
	ld hl,(0c60dh)		;5771
	add hl,de			;5774
	ld (0c60dh),hl		;5775
	ld a,(0c619h)		;5778
	call L_57F5		;577b
	ld hl,(0c610h)		;577e
	add hl,de			;5781
	ld (0c610h),hl		;5782
	djnz L_576B		;5785
	ld hl,0c631h		;5787
	inc (hl)			;578a
	ld a,(hl)			;578b
	rrca			;578c
	ret nc			;578d
	ld a,010h		;578e
	ld (0c620h),a		;5790
	ld a,(0c61fh)		;5793
	add a,080h		;5796
	call L_57BF		;5798
	ld a,(0c614h)		;579b
	ld (0c620h),a		;579e
	ld a,(0c615h)		;57a1
	call L_57BF		;57a4
	ld hl,(0c617h)		;57a7
	ld de,(0c619h)		;57aa
	push hl			;57ae
	push de			;57af
	call L_6510		;57b0
	ld (0c61eh),a		;57b3
	pop de			;57b6
	pop hl			;57b7
	call L_64C5		;57b8
	ld (0c61fh),a		;57bb
	ret			;57be
L_57BF:
	push af			;57bf
	call L_57E5		;57c0
	add hl,hl			;57c3
	add hl,hl			;57c4
	add hl,hl			;57c5
	add hl,hl			;57c6
	ex de,hl			;57c7
	ld hl,(0c616h)		;57c8
	add hl,de			;57cb
	ld (0c616h),hl		;57cc
	pop af			;57cf
	call L_57E0		;57d0
	add hl,hl			;57d3
	add hl,hl			;57d4
	add hl,hl			;57d5
	add hl,hl			;57d6
	ex de,hl			;57d7
	ld hl,(0c618h)		;57d8
	add hl,de			;57db
	ld (0c618h),hl		;57dc
	ret			;57df
L_57E0:
	call L_6558		;57e0
	jr L_57E8		;57e3
L_57E5:
	call L_655A		;57e5
L_57E8:
	ld a,(0c620h)		;57e8
	call L_6552		;57eb
	ld l,a			;57ee
	ld h,000h		;57ef
	and a			;57f1
	ret p			;57f2
	dec h			;57f3
	ret			;57f4
L_57F5:
	and a			;57f5
	ld e,a			;57f6
	ld d,000h		;57f7
	ret p			;57f9
	dec d			;57fa
	ret			;57fb
L_57FC:
	ld hl,00000h		;57fc
	ld (0c612h),hl		;57ff
	ld (0c64ah),hl		;5802
	ld a,080h		;5805
	ld (0c60ch),a		;5807
	ld (0c60fh),a		;580a
	ld (0c60dh),a		;580d
	ld (0c610h),a		;5810
	ld a,001h		;5813
	ld (0c624h),a		;5815
	ld a,(0c011h)		;5818
	and a			;581b
	call z,L_629C		;581c
	ld a,(0c638h)		;581f
	ld (0c628h),a		;5822
	ld (0c627h),a		;5825
	xor a			;5828
	ld (0c62bh),a		;5829
	ld (0c62eh),a		;582c
	ld (0c630h),a		;582f
	ld (0c66ah),a		;5832
	ld (0c66bh),a		;5835
	ld a,(0c639h)		;5838
	and a			;583b
	jr z,L_586E		;583c
	ld a,(0c011h)		;583e
	and a			;5841
	jr nz,L_586E		;5842
	ld a,(0c11ah)		;5844
	and a			;5847
	jr nz,L_5863		;5848
	ld b,026h		;584a
	ld a,(0c007h)		;584c
	cp 002h		;584f
	jr nz,L_5855		;5851
	ld b,040h		;5853
L_5855:
	push bc			;5855
	call L_4CD0		;5856
	pop bc			;5859
	call L_4CEE		;585a
	add a,00ch		;585d
	cpl			;585f
	ld e,a			;5860
	jr L_5865		;5861
L_5863:
	ld e,0e6h		;5863
L_5865:
	ld a,(0c61dh)		;5865
	call L_651F		;5868
	ld (0c61dh),a		;586b
L_586E:
	ld a,(0c621h)		;586e
	ld c,a			;5871
	ld b,000h		;5872
	ld ix,06437h		;5874
	add ix,bc		;5878
	ld a,(ix+000h)		;587a
	ld (0c61ch),a		;587d
	ld a,(ix+01ah)		;5880
	call L_5B28		;5883
	ld (0c61ah),a		;5886
	xor a			;5889
	ld (0c61bh),a		;588a
	ld a,(0c621h)		;588d
	cp 00dh		;5890
	ld a,(ix+027h)		;5892
	call nc,L_5B28		;5895
	ld (0c626h),a		;5898
	ld (0c61eh),a		;589b
	ld a,078h		;589e
	ld (0c620h),a		;58a0
	ld a,(0c621h)		;58a3
	cp 00eh		;58a6
	jp z,L_56CA		;58a8
	cp 00dh		;58ab
	jp z,L_5970		;58ad
	ld a,(ix+00dh)		;58b0
	call L_5B28		;58b3
	ld b,a			;58b6
L_58B7:
	push bc			;58b7
	call L_5968		;58b8
	call L_5AC9		;58bb
	call L_5AF4		;58be
	call L_59AA		;58c1
	pop bc			;58c4
	ld a,(0c633h)		;58c5
	and a			;58c8
	ret nz			;58c9
	call L_61BA		;58ca
	ret c			;58cd
	call L_5761		;58ce
	djnz L_58B7		;58d1
L_58D3:
	call L_5968		;58d3
	call L_5AC9		;58d6
	call L_5AF4		;58d9
	ld a,h			;58dc
	and a			;58dd
	jp m,L_5970		;58de
	ld a,(0c61ch)		;58e1
	ld e,a			;58e4
	ld d,000h		;58e5
	ld hl,(0c61ah)		;58e7
	and a			;58ea
	sbc hl,de		;58eb
	ld (0c61ah),hl		;58ed
	ld hl,0c624h		;58f0
	ld de,0c61fh		;58f3
	ld a,(0c622h)		;58f6
	and a			;58f9
	jr z,L_5904		;58fa
	dec (hl)			;58fc
	jr nz,L_5910		;58fd
	ld (hl),a			;58ff
	ex de,hl			;5900
	dec (hl)			;5901
	jr L_5910		;5902
L_5904:
	ld a,(0c623h)		;5904
	and a			;5907
	jr z,L_5910		;5908
	dec (hl)			;590a
	jr nz,L_5910		;590b
	ld (hl),a			;590d
	ex de,hl			;590e
	inc (hl)			;590f
L_5910:
	ld a,(0c625h)		;5910
	and 078h		;5913
	jr z,L_5956		;5915
	rrca			;5917
	rrca			;5918
	rrca			;5919
	ld b,a			;591a
	add a,a			;591b
	add a,b			;591c
	ld b,a			;591d
	ld a,(0c625h)		;591e
	add a,a			;5921
	add a,a			;5922
	add a,a			;5923
	add a,a			;5924
	add a,a			;5925
L_5926:
	push bc			;5926
	push af			;5927
	call L_655A		;5928
	call L_6295		;592b
	ld hl,(0c60ch)		;592e
	add hl,de			;5931
	ld (0c60ch),hl		;5932
	ld a,(0c60eh)		;5935
	adc a,d			;5938
	ld (0c60eh),a		;5939
	pop af			;593c
	push af			;593d
	call L_6558		;593e
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
	call L_59AA		;5956
	ld a,(0c633h)		;5959
	and a			;595c
	ret nz			;595d
	call L_61BA		;595e
	ret c			;5961
	call L_5761		;5962
	jp L_58D3		;5965
L_5968:
	ld hl,(0c64ah)		;5968
	inc hl			;596b
	ld (0c64ah),hl		;596c
	ret			;596f
L_5970:
	ld hl,00000h		;5970
	ld (0c612h),hl		;5973
	ld a,(0c626h)		;5976
	ld b,a			;5979
L_597A:
	push bc			;597a
	call L_5968		;597b
	call L_5AC9		;597e
	call L_59AA		;5981
	pop bc			;5984
	ld a,(0c633h)		;5985
	ld hl,0c635h		;5988
	or (hl)			;598b
	ret nz			;598c
	call L_61BA		;598d
	ret c			;5990
	ld a,(0c63ah)		;5991
	and a			;5994
	jr z,L_599C		;5995
	dec b			;5997
	jr nz,L_599B		;5998
	inc b			;599a
L_599B:
	inc b			;599b
L_599C:
	call L_5761		;599c
	djnz L_597A		;599f
	ld a,(0c638h)		;59a1
	xor 001h		;59a4
	call z,L_6B2D		;59a6
	ret			;59a9
L_59AA:
	ld de,0c600h		;59aa
	ld bc,0c608h		;59ad
	ld a,(0c009h)		;59b0
	and a			;59b3
	push af			;59b4
	jr z,L_59BA		;59b5
	ld de,0c604h		;59b7
L_59BA:
	ld a,(0c611h)		;59ba
	sub 002h		;59bd
	ld (bc),a			;59bf
	ld hl,0c613h		;59c0
	sub (hl)			;59c3
	ld (de),a			;59c4
	ld a,(hl)			;59c5
	and a			;59c6
	jr nz,L_59CC		;59c7
	ld a,0d1h		;59c9
	ld (bc),a			;59cb
L_59CC:
	ld a,(0c611h)		;59cc
	cp 0c0h		;59cf
	call nc,L_5AA2		;59d1
	ld a,(0c60eh)		;59d4
	dec a			;59d7
	inc de			;59d8
	ld (de),a			;59d9
	inc bc			;59da
	ld (bc),a			;59db
	cp 058h		;59dc
	call c,L_5AA2		;59de
	cp 0f8h		;59e1
	call nc,L_5AA2		;59e3
	ld a,(0c613h)		;59e6
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
	pop af			;59f9
	ld a,00fh		;59fa
	jr z,L_5A00		;59fc
	ld a,009h		;59fe
L_5A00:
	inc de			;5a00
	ld (de),a			;5a01
	ld a,001h		;5a02
	inc bc			;5a04
	ld (bc),a			;5a05
	ld a,(0c011h)		;5a06
	and a			;5a09
	jr nz,L_5A62		;5a0a
	call L_629C		;5a0c
	ld a,(0c63ah)		;5a0f
	and a			;5a12
	jr z,L_5A26		;5a13
	dec a			;5a15
	jr z,L_5A21		;5a16
	ld hl,0c608h		;5a18
	ld a,(hl)			;5a1b
	sub 005h		;5a1c
	ld (hl),a			;5a1e
	jr L_5A26		;5a1f
L_5A21:
	ld a,0d1h		;5a21
	ld (0c608h),a		;5a23
L_5A26:
	ld a,(0c613h)		;5a26
	cp 00ch		;5a29
	jr nc,L_5A62		;5a2b
	ld a,(0c611h)		;5a2d
	push af			;5a30
	ld hl,0c613h		;5a31
	sub (hl)			;5a34
	ld (0c611h),a		;5a35
	call L_629C		;5a38
	pop af			;5a3b
	ld (0c611h),a		;5a3c
	ld a,(0c63ah)		;5a3f
	dec a			;5a42
	push af			;5a43
	call L_629C		;5a44
	pop af			;5a47
	jr nz,L_5A62		;5a48
	ld a,(0c63ah)		;5a4a
	and a			;5a4d
	jr z,L_5A62		;5a4e
	ld hl,0c600h		;5a50
	ld a,(0c009h)		;5a53
	and a			;5a56
	jr z,L_5A5C		;5a57
	ld hl,0c604h		;5a59
L_5A5C:
	ld a,0d1h		;5a5c
	ld (hl),a			;5a5e
	ld (0c608h),a		;5a5f
L_5A62:
	ld hl,0c600h		;5a62
	ld de,01b00h		;5a65
	ld bc,0000ch		;5a68
	ld a,(0c118h)		;5a6b
	and a			;5a6e
	call z,0005ch		;5a6f   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,(0c011h)		;5a72
	and a			;5a75
	ret z			;5a76
	call L_6400		;5a77
	ld de,001e0h		;5a7a
	add hl,de			;5a7d
	ld a,(hl)			;5a7e
	cp 079h		;5a7f
	call z,L_5AA2		;5a81
	ld hl,(0c63dh)		;5a84
	ld a,(0c60eh)		;5a87
	sub l			;5a8a
	ld l,a			;5a8b
	ld a,(0c611h)		;5a8c
	sub h			;5a8f
	ld e,a			;5a90
	call L_6485		;5a91
	ld a,l			;5a94
	cp 002h		;5a95
	ret nc			;5a97
	ld a,e			;5a98
	cp 002h		;5a99
	ret nc			;5a9b
	ld a,001h		;5a9c
	ld (0c634h),a		;5a9e
	ret			;5aa1
L_5AA2:
	ld a,001h		;5aa2
	ld (0c633h),a		;5aa4
	jp 00090h		;5aa7   ; BIOS GICINI - Initialises PSG and sets initial value for the PLAY statement
L_5AAA:
	ld hl,0c600h		;5aaa
	ld a,(0c009h)		;5aad
	and a			;5ab0
	jr z,L_5AB6		;5ab1
	ld hl,0c604h		;5ab3
L_5AB6:
	ld (hl),0d1h		;5ab6
	jr L_5A62		;5ab8
L_5ABA:
	ld hl,0c600h		;5aba
	ld de,0c601h		;5abd
	ld bc,0000bh		;5ac0
	ld (hl),0d1h		;5ac3
	ldir		;5ac5
	jr L_5A62		;5ac7
L_5AC9:
	ld a,(0c61fh)		;5ac9
	push af			;5acc
	call L_57E5		;5acd
	call L_5AE9		;5ad0
	ld hl,(0c60dh)		;5ad3
	add hl,de			;5ad6
	ld (0c60dh),hl		;5ad7
	pop af			;5ada
	call L_57E0		;5adb
	call L_5AE9		;5ade
	ld hl,(0c610h)		;5ae1
	add hl,de			;5ae4
	ld (0c610h),hl		;5ae5
	ret			;5ae8
L_5AE9:
	ex de,hl			;5ae9
	ld a,(0c627h)		;5aea
	and a			;5aed
	ret z			;5aee
	sra d		;5aef
	rr e		;5af1
	ret			;5af3
L_5AF4:
	ld hl,(0c612h)		;5af4
	ld de,(0c61ah)		;5af7
	add hl,de			;5afb
	ld (0c612h),hl		;5afc
	ld a,(0c118h)		;5aff
	and a			;5b02
	ret nz			;5b03
	push hl			;5b04
	ld a,h			;5b05
	and a			;5b06
	jp p,L_5B0F		;5b07
	ld hl,00000h		;5b0a
	jr L_5B1C		;5b0d
L_5B0F:
	add hl,hl			;5b0f
	ld l,h			;5b10
	ld h,000h		;5b11
	add hl,hl			;5b13
	add hl,hl			;5b14
	ld de,00200h		;5b15
	ex de,hl			;5b18
	and a			;5b19
	sbc hl,de		;5b1a
L_5B1C:
	ld e,l			;5b1c
	xor a			;5b1d
	call 00093h		;5b1e   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,h			;5b21
	ld a,001h		;5b22
	pop hl			;5b24
	jp 00093h		;5b25   ; BIOS WRTPSG - Writes data to PSG-register
L_5B28:
	ld e,a			;5b28
	ld a,(0c61dh)		;5b29
	and a			;5b2c
	jr z,L_5B37		;5b2d
	call L_651F		;5b2f
	and a			;5b32
	ret nz			;5b33
	ld a,001h		;5b34
	ret			;5b36
L_5B37:
	ld a,e			;5b37
	ret			;5b38
L_5B39:
	ld hl,(0c63fh)		;5b39
	ld (0c648h),hl		;5b3c
	xor a			;5b3f
	ld (0c668h),a		;5b40
	ld (0c66dh),a		;5b43
	ld (0c669h),a		;5b46
	ld (0c66eh),a		;5b49
	ld (0c66fh),a		;5b4c
	ld (0c670h),a		;5b4f
	call L_4CD0		;5b52
	and 003h		;5b55
	add a,018h		;5b57
	ld (0c665h),a		;5b59
	call L_4CD0		;5b5c
	and 007h		;5b5f
	add a,019h		;5b61
	ld (0c666h),a		;5b63
	ld hl,(0c648h)		;5b66
	push hl			;5b69
	call L_47B0		;5b6a
	ld (0c65fh),a		;5b6d
	pop hl			;5b70
	ld a,(0c012h)		;5b71
	ld e,a			;5b74
	ld a,(0c013h)		;5b75
	ld d,a			;5b78
	call L_5EEF		;5b79
	ld (0c662h),a		;5b7c
	cp 080h		;5b7f
	jp nc,L_5F58		;5b81
L_5B84:
	ld a,(0c662h)		;5b84
	sub 06ch		;5b87
	jr c,L_5B8C		;5b89
	xor a			;5b8b
L_5B8C:
	neg		;5b8c
	rra			;5b8e
	rra			;5b8f
	rra			;5b90
	and 01fh		;5b91
	cp 00eh		;5b93
	jr c,L_5B99		;5b95
	ld a,00dh		;5b97
L_5B99:
	ld (0c667h),a		;5b99
	call L_629C		;5b9c
	ld a,(0c638h)		;5b9f
	and a			;5ba2
	ld a,0feh		;5ba3
	call nz,L_6048		;5ba5
	ld hl,(0c60dh)		;5ba8
	ld (0c656h),hl		;5bab
	ld hl,(0c610h)		;5bae
	ld (0c658h),hl		;5bb1
L_5BB4:
	call L_6666		;5bb4
	ld a,(0c65fh)		;5bb7
	ld b,a			;5bba
	ld a,(0c660h)		;5bbb
	sub b			;5bbe
	sub 070h		;5bbf
	cp 020h		;5bc1
	jp nc,L_5BCC		;5bc3
	ld a,b			;5bc6
	sub 080h		;5bc7
	ld (0c65fh),a		;5bc9
L_5BCC:
	ld hl,(0c656h)		;5bcc
	ld (0c60dh),hl		;5bcf
	ld hl,(0c658h)		;5bd2
	ld (0c610h),hl		;5bd5
	ld a,(0c65fh)		;5bd8
	ld (0c61fh),a		;5bdb
	ld a,001h		;5bde
	ld (0c118h),a		;5be0
	ld a,(0c666h)		;5be3
	ld (0c641h),a		;5be6
	ld a,(0c665h)		;5be9
	add a,a			;5bec
	add a,a			;5bed
	add a,a			;5bee
	add a,01fh		;5bef
	ld (0c61dh),a		;5bf1
	ld a,(0c667h)		;5bf4
	ld (0c621h),a		;5bf7
	ld hl,00000h		;5bfa
	ld (0c652h),hl		;5bfd
	ld (0c64ch),hl		;5c00
	ld (0c64eh),hl		;5c03
	ld (0c650h),hl		;5c06
	xor a			;5c09
	ld (0c622h),a		;5c0a
	ld (0c623h),a		;5c0d
	ld (0c66ah),a		;5c10
	ld (0c66ch),a		;5c13
	call L_53A7		;5c16
	ld hl,0c66dh		;5c19
	inc (hl)			;5c1c
	call L_629C		;5c1d
	ld hl,(0c648h)		;5c20
	ld a,(0c60eh)		;5c23
	ld e,a			;5c26
	ld a,(0c611h)		;5c27
	ld d,a			;5c2a
	call L_5EEF		;5c2b
	ld (0c662h),a		;5c2e
	ld hl,(0c656h)		;5c31
	ld (0c60dh),hl		;5c34
	ld hl,(0c658h)		;5c37
	ld (0c610h),hl		;5c3a
	ld a,(0c633h)		;5c3d
	and a			;5c40
	jp nz,L_5D95		;5c41
	ld a,(0c637h)		;5c44
	and a			;5c47
	ret nz			;5c48
	ld hl,(0c652h)		;5c49
	ld a,h			;5c4c
	or l			;5c4d
	jp nz,L_5CA4		;5c4e
	ld a,(0c66bh)		;5c51
	and a			;5c54
	jp nz,L_5D74		;5c55
	ld a,(0c66ah)		;5c58
	and a			;5c5b
	jp nz,L_5DFA		;5c5c
L_5C5F:
	ld a,(0c635h)		;5c5f
	and a			;5c62
	jp nz,L_5DB4		;5c63
	ld a,(0c636h)		;5c66
	and a			;5c69
	jp nz,L_5DB4		;5c6a
	ld a,(0c66ch)		;5c6d
	and a			;5c70
	jp nz,L_5ECB		;5c71
L_5C74:
	ld a,(0c638h)		;5c74
	and a			;5c77
	jp nz,L_5CB4		;5c78
	ld a,(0c66dh)		;5c7b
	cp 007h		;5c7e
	ret nc			;5c80
	call L_4CD0		;5c81
	and 003h		;5c84
	add a,00ah		;5c86
	ld b,a			;5c88
	ld a,(0c662h)		;5c89
	cp b			;5c8c
	jp c,L_5D41		;5c8d
	ld a,(0c639h)		;5c90
	and a			;5c93
	ret z			;5c94
	ld hl,(0c64ch)		;5c95
	call L_602A		;5c98
	cp 0f0h		;5c9b
	ret c			;5c9d
	call L_6082		;5c9e
	jp L_5BB4		;5ca1
L_5CA4:
	call L_6046		;5ca4
	ld hl,0c665h		;5ca7
	ld a,(hl)			;5caa
	cp 006h		;5cab
	jp nc,L_5E76		;5cad
	dec (hl)			;5cb0
	jp L_5BB4		;5cb1
L_5CB4:
	ld a,(0c667h)		;5cb4
	cp 00dh		;5cb7
	jp z,L_5D2B		;5cb9
	ld a,(0c66fh)		;5cbc
	cp 00ah		;5cbf
	ret nc			;5cc1
	ld a,(0c66dh)		;5cc2
	cp 00ch		;5cc5
	ret nc			;5cc7
L_5CC8:
	call L_4CD0		;5cc8
	cp 090h		;5ccb
	jp c,L_5DD6		;5ccd
	call L_4CD0		;5cd0
	cp 036h		;5cd3
	jr c,L_5CFB		;5cd5
	cp 046h		;5cd7
	jr c,L_5D0A		;5cd9
	cp 070h		;5cdb
	jr c,L_5D0F		;5cdd
	cp 090h		;5cdf
	jr c,L_5D17		;5ce1
	cp 0beh		;5ce3
	jr c,L_5D1F		;5ce5
	call L_4CD0		;5ce7
	and 007h		;5cea
	add a,004h		;5cec
	call L_6058		;5cee
	call L_4CD0		;5cf1
	and 003h		;5cf4
	call L_6072		;5cf6
	jr L_5D14		;5cf9
L_5CFB:
	ld a,0fbh		;5cfb
	call L_6058		;5cfd
	call L_4CD0		;5d00
	or 0fch		;5d03
	call L_6072		;5d05
	jr L_5D14		;5d08
L_5D0A:
	call L_6046		;5d0a
	jr L_5D12		;5d0d
L_5D0F:
	call L_6042		;5d0f
L_5D12:
	jr c,L_5CC8		;5d12
L_5D14:
	jp L_5BB4		;5d14
L_5D17:
	call L_4CD0		;5d17
	and 001h		;5d1a
	inc a			;5d1c
	jr L_5D26		;5d1d
L_5D1F:
	call L_4CD0		;5d1f
	and 003h		;5d22
	add a,003h		;5d24
L_5D26:
	call L_6061		;5d26
	jr L_5D12		;5d29
L_5D2B:
	ld a,00ch		;5d2b
	ld (0c667h),a		;5d2d
	ld a,(0c665h)		;5d30
	cp 008h		;5d33
	jp c,L_5BB4		;5d35
	srl a		;5d38
	inc a			;5d3a
	ld (0c665h),a		;5d3b
	jp L_5BB4		;5d3e
L_5D41:
	call L_6042		;5d41
	ld a,(0c667h)		;5d44
	cp 00ch		;5d47
	jr z,L_5D53		;5d49
	ld a,001h		;5d4b
	call L_6061		;5d4d
	jp L_5BB4		;5d50
L_5D53:
	ld a,(0c665h)		;5d53
	cp 007h		;5d56
	jp c,L_5BB4		;5d58
	cp 014h		;5d5b
	jr c,L_5D67		;5d5d
	ld a,0feh		;5d5f
	call L_6061		;5d61
	jp L_5BB4		;5d64
L_5D67:
	ld a,00dh		;5d67
	ld (0c667h),a		;5d69
	ld a,002h		;5d6c
	call L_6061		;5d6e
	jp L_5BB4		;5d71
L_5D74:
	ld a,(0c64ah)		;5d74
	cp 00ch		;5d77
	jp nc,L_5CB4		;5d79
	ld hl,00000h		;5d7c
	ld (0c652h),hl		;5d7f
	ld (0c64ch),hl		;5d82
	ld (0c64eh),hl		;5d85
	ld a,00ch		;5d88
	ld (0c667h),a		;5d8a
	ld a,01ah		;5d8d
	ld (0c665h),a		;5d8f
	jp L_5C5F		;5d92
L_5D95:
	ld a,001h		;5d95
	ld (0c668h),a		;5d97
	xor a			;5d9a
	ld (0c633h),a		;5d9b
	ld a,0ffh		;5d9e
	call L_6061		;5da0
	ld hl,(0c652h)		;5da3
	ld a,h			;5da6
	or l			;5da7
	jr z,L_5DBE		;5da8
	ld a,0ffh		;5daa
	call L_6061		;5dac
	ld a,001h		;5daf
	call L_6048		;5db1
L_5DB4:
	ld a,(0c667h)		;5db4
	cp 00dh		;5db7
	jr c,L_5DBE		;5db9
	call L_6042		;5dbb
L_5DBE:
	call L_4CD0		;5dbe
	cp 010h		;5dc1
	jp c,L_5DD6		;5dc3
	ld hl,(0c64ch)		;5dc6
	ld a,h			;5dc9
	or l			;5dca
	jp nz,L_5E95		;5dcb
L_5DCE:
	ld hl,(0c64eh)		;5dce
	ld a,h			;5dd1
	or l			;5dd2
	jp nz,L_5EB2		;5dd3
L_5DD6:
	ld a,(0c668h)		;5dd6
	and a			;5dd9
	jp nz,L_5F04		;5dda
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
	jp L_5BB4		;5df7
L_5DFA:
	ld hl,(0c654h)		;5dfa
	call L_602A		;5dfd
	cp 0f0h		;5e00
	jr nc,L_5E22		;5e02
	cp 0e8h		;5e04
	jp nc,L_5C5F		;5e06
	ld a,(0c66eh)		;5e09
	cp 014h		;5e0c
	jr c,L_5E22		;5e0e
	call L_6046		;5e10
	ld a,0ffh		;5e13
	call L_6061		;5e15
	ld a,(0c667h)		;5e18
	cp 00dh		;5e1b
	ld a,0ffh		;5e1d
	call z,L_6048		;5e1f
L_5E22:
	call L_4CD0		;5e22
	cp 070h		;5e25
	jr c,L_5E36		;5e27
	cp 090h		;5e29
	jr c,L_5E40		;5e2b
	cp 0b0h		;5e2d
	jr c,L_5E5E		;5e2f
	cp 0d0h		;5e31
	jp c,L_5DD6		;5e33
L_5E36:
	ld hl,0c66eh		;5e36
	inc (hl)			;5e39
	call L_5F28		;5e3a
	jp L_5BB4		;5e3d
L_5E40:
	ld a,(0c665h)		;5e40
	cp 00ch		;5e43
	jp c,L_5E53		;5e45
	call L_6046		;5e48
	ld a,001h		;5e4b
	call L_6061		;5e4d
	jp L_5BB4		;5e50
L_5E53:
	call L_6042		;5e53
	ld a,0ffh		;5e56
	call L_6061		;5e58
	jp L_5BB4		;5e5b
L_5E5E:
	ld a,(0c66fh)		;5e5e
	and 001h		;5e61
	jp z,L_5E6E		;5e63
	ld a,0feh		;5e66
	call L_6058		;5e68
	jp L_5BB4		;5e6b
L_5E6E:
	ld a,002h		;5e6e
	call L_6058		;5e70
	jp L_5BB4		;5e73
L_5E76:
	ld hl,(0c652h)		;5e76
	call L_602A		;5e79
	call L_6082		;5e7c
	jr nc,L_5E92		;5e7f
L_5E81:
	call L_6046		;5e81
	jr nc,L_5E92		;5e84
	ld a,0ffh		;5e86
	call L_6061		;5e88
	jr nc,L_5E92		;5e8b
	ld a,0f6h		;5e8d
	call L_6058		;5e8f
L_5E92:
	jp L_5BB4		;5e92
L_5E95:
	call L_602A		;5e95
	cp 085h		;5e98
	jp c,L_5DCE		;5e9a
L_5E9D:
	call L_6082		;5e9d
	jp nc,L_5BB4		;5ea0
	call L_4CD0		;5ea3
	cp 020h		;5ea6
	jr c,L_5E81		;5ea8
	ld a,028h		;5eaa
	call L_6058		;5eac
	jp L_5BB4		;5eaf
L_5EB2:
	call L_602A		;5eb2
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
	ld a,(0c66dh)		;5ecb
	cp 00bh		;5ece
	ret nc			;5ed0
	ld a,(0c66fh)		;5ed1
	cp 007h		;5ed4
	jp nc,L_5C74		;5ed6
	call L_4CD0		;5ed9
	cp 060h		;5edc
	jp nc,L_5DD6		;5ede
	jp L_5C74		;5ee1
L_5EE4:
	ld hl,(0c63dh)		;5ee4
	ld a,(0c60eh)		;5ee7
	ld e,a			;5eea
	ld a,(0c611h)		;5eeb
	ld d,a			;5eee
L_5EEF:
	ld a,e			;5eef
	sub l			;5ef0
	jr nc,L_5EF5		;5ef1
	neg		;5ef3
L_5EF5:
	ld l,a			;5ef5
	ld a,d			;5ef6
	sub h			;5ef7
	jr nc,L_5EFC		;5ef8
	neg		;5efa
L_5EFC:
	ld e,a			;5efc
	call L_6494		;5efd
	add hl,de			;5f00
	jp L_64A2		;5f01
L_5F04:
	ld hl,0c66fh		;5f04
	inc (hl)			;5f07
	ld a,(hl)			;5f08
	rrca			;5f09
	push af			;5f0a
	rlca			;5f0b
	ld c,a			;5f0c
	add a,a			;5f0d
	add a,a			;5f0e
	ld b,a			;5f0f
	pop af			;5f10
	ld a,b			;5f11
	jr nc,L_5F1C		;5f12
	neg		;5f14
	ld d,a			;5f16
	ld a,c			;5f17
	neg		;5f18
	ld c,a			;5f1a
	ld a,d			;5f1b
L_5F1C:
	push bc			;5f1c
	call L_6058		;5f1d
	pop bc			;5f20
	ld a,c			;5f21
	call L_6072		;5f22
	jp L_5BB4		;5f25
L_5F28:
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
	call L_6058		;5f3a
	pop af			;5f3d
	call L_6072		;5f3e
	ld a,(0c65fh)		;5f41
	ld b,a			;5f44
	ld a,(0c660h)		;5f45
	sub b			;5f48
	add a,040h		;5f49
	ret p			;5f4b
	ld a,002h		;5f4c
	call L_6048		;5f4e
	ret nc			;5f51
	ld a,00ch		;5f52
	ld (0c667h),a		;5f54
	ret			;5f57
L_5F58:
	ld a,(0cec4h)		;5f58
	ld b,a			;5f5b
	ld a,(0c611h)		;5f5c
	cp b			;5f5f
	jp nz,L_5B84		;5f60
	ld a,(0c670h)		;5f63
	and a			;5f66
	jp nz,L_5B84		;5f67
	inc a			;5f6a
	ld (0c670h),a		;5f6b
	ld a,003h		;5f6e
	ld (0c671h),a		;5f70
L_5F73:
	call L_4CD0		;5f73
	and 00fh		;5f76
	add a,053h		;5f78
	ld (0c65eh),a		;5f7a
	ld a,(0c65fh)		;5f7d
	ld c,a			;5f80
	ld b,000h		;5f81
L_5F83:
	call L_5FC9		;5f83
	jp c,L_5F97		;5f86
	ld a,b			;5f89
	add a,c			;5f8a
	ld (0c61fh),a		;5f8b
	ld (0c65fh),a		;5f8e
	ld (0c660h),a		;5f91
	jp L_5B84		;5f94
L_5F97:
	dec b			;5f97
	ld a,b			;5f98
	cp 0a0h		;5f99
	jr nc,L_5F83		;5f9b
	ld a,(0c65fh)		;5f9d
	ld c,a			;5fa0
	ld b,000h		;5fa1
L_5FA3:
	call L_5FC9		;5fa3
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
	cp 060h		;5fb8
	jr c,L_5FA3		;5fba
	ld a,(0c671h)		;5fbc
	dec a			;5fbf
	ld (0c671h),a		;5fc0
	jp nz,L_5F73		;5fc3
	jp L_5B84		;5fc6
L_5FC9:
	ld a,(0c65eh)		;5fc9
	ld (0c620h),a		;5fcc
	push bc			;5fcf
	ld a,c			;5fd0
	add a,b			;5fd1
	push af			;5fd2
	call L_57E5		;5fd3
	ld a,h			;5fd6
	and a			;5fd7
	ld a,(0c60eh)		;5fd8
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
	jp c,L_6026		;5fe7
	ld e,a			;5fea
	ld a,(0c65eh)		;5feb
	ld (0c620h),a		;5fee
	pop af			;5ff1
	push de			;5ff2
	call L_57E0		;5ff3
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
	call L_63F1		;600e
	ld a,(hl)			;6011
	pop hl			;6012
	pop bc			;6013
	ret c			;6014
	cp 078h		;6015
	ret z			;6017
	cp 07ah		;6018
	ret c			;601a
	cp 094h		;601b
	jr c,L_6024		;601d
	cp 0d9h		;601f
	ret c			;6021
	cp 0e9h		;6022
L_6024:
	ccf			;6024
	ret			;6025
L_6026:
	pop af			;6026
L_6027:
	pop bc			;6027
	scf			;6028
	ret			;6029
L_602A:
	ld a,h			;602a
	or l			;602b
	ret z			;602c
	ex de,hl			;602d
	ld hl,(0c64ah)		;602e
	ex de,hl			;6031
	ld a,h			;6032
	ld h,l			;6033
	ld l,000h		;6034
	ld c,0ffh		;6036
L_6038:
	inc c			;6038
	and a			;6039
	sbc hl,de		;603a
	sbc a,000h		;603c
	jr nc,L_6038		;603e
	ld a,c			;6040
	ret			;6041
L_6042:
	ld a,0ffh		;6042
	jr L_6048		;6044
L_6046:
	ld a,001h		;6046
L_6048:
	ld b,a			;6048
	ld a,(0c667h)		;6049
	add a,b			;604c
	ld b,a			;604d
	ld a,00dh		;604e
	cp b			;6050
	ret c			;6051
	ld a,b			;6052
	ld (0c667h),a		;6053
	and a			;6056
	ret			;6057
L_6058:
	ld b,a			;6058
	ld a,(0c65fh)		;6059
	add a,b			;605c
	ld (0c65fh),a		;605d
	ret			;6060
L_6061:
	ld b,a			;6061
	ld a,(0c665h)		;6062
	add a,b			;6065
	dec a			;6066
	ld b,a			;6067
	ld a,01bh		;6068
	cp b			;606a
	ret c			;606b
	ld a,b			;606c
	ld (0c665h),a		;606d
	and a			;6070
	ret			;6071
L_6072:
	ld b,a			;6072
	ld a,(0c666h)		;6073
	add a,b			;6076
	ld b,a			;6077
	ld a,037h		;6078
	cp b			;607a
	ret c			;607b
	ld a,b			;607c
	ld (0c666h),a		;607d
	and a			;6080
	ret			;6081
L_6082:
	ld e,a			;6082
	ld a,(0c665h)		;6083
	cp 006h		;6086
	ret c			;6088
	call L_651F		;6089
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
	call L_5EE4		;60a3
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
	call L_5EE4		;60d0
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
	call L_5EE4		;6108
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
	call L_59AA		;61e7
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
; DATOS sin identificar  0x63e9..0x63f1  (8 bytes)
DATA_63E9:
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
; DATOS sin identificar  0x6437..0x646d  (54 bytes)
DATA_6437:
	defb 002h,002h,002h,003h,003h,004h,006h,008h,00ah,00ch,00eh,013h,01eh,068h,060h,058h	; 6437  .............h`X
	defb 05ch,04ch,04ch,04ch,048h,03ch,032h,02dh,023h,01ch,031h,032h,033h,042h,044h,04bh	; 6447  \LLLH<2-#.123BDK
	defb 05ah,06ch,090h,0b4h,0c8h,0e2h,0ffh,014h,011h,00eh,00bh,008h,007h,006h,005h,004h	; 6457  Zl..............
	defb 003h,002h,001h,001h,01eh,07fh	; 6467

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
; DATOS sin identificar  0x65a2..0x6603  (97 bytes)
DATA_65A2:
	defb 004h,006h,006h,007h,006h,006h,007h,006h,007h,006h,007h,007h,007h,007h,007h,007h	; 65a2  ................
	defb 007h,008h,007h,008h,008h,009h,008h,009h,009h,00ah,009h,00ah,00bh,00bh,00bh,00ch	; 65b2  ................
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
	jp nz,L_713F		;6847
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
; DATOS sin identificar  0x6898..0x6a4f  (439 bytes)
DATA_6898:
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
	defb 0ffh,0ffh,0ffh,0aah,000h,0a2h,0ffh,0aah,003h,0ffh,0ffh,027h,017h,028h,029h,021h	; 69a8  ...........'.()!
	defb 02ah,054h,04fh,050h,004h,02bh,021h,02ah,031h,055h,050h,004h,02bh,021h,02ah,032h	; 69b8  *TOP.+!*1UP.+!*2
	defb 055h,050h,004h,02bh,021h,02ch,017h,02dh,02eh,022h,02ah,020h,053h,048h,04fh,054h	; 69c8  UP.+!,.-."* SHOT
	defb 053h,020h,02bh,021h,02ah,020h,031h,055h,050h,003h,02bh,021h,02ah,020h,032h,055h	; 69d8  S +!* 1UP.+!* 2U
	defb 050h,003h,02bh,021h,02ch,017h,02dh,02eh,021h,02ah,048h,04fh,04ch,045h,003h,02bh	; 69e8  P.+!,.-.!*HOLE.+
	defb 021h,02ah,005h,03fh,020h,02bh,021h,02ah,020h,050h,041h,052h,003h,02bh,023h,02ah	; 69f8  !*.? +!* PAR.+#*
	defb 020h,05fh,05fh,004h,02bh,021h,02ah,020h,05fh,05fh,004h,02bh,021h,02ah,020h,0d8h	; 6a08   __.+!* __.+!* .
	defb 0d8h,004h,02bh,021h,02ah,020h,0d8h,0d8h,004h,02bh,021h,024h,017h,025h,026h,021h	; 6a18  ..+!* ...+!$.%&!
	defb 009h,022h,002h,050h,04fh,057h,045h,052h,002h,021h,020h,017h,000h,020h,021h,002h	; 6a28  .".POWER.! .. !.
	defb 043h,055h,052h,056h,045h,002h,021h,020h,0d2h,015h,094h,0d3h,020h,021h,009h,021h	; 6a38  CURVE.! .... !.!
	defb 020h,043h,04ch,055h,042h,004h,021h	; 6a48

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
; DATOS sin identificar  0x6b55..0x6b6d  (24 bytes)
DATA_6B55:
	defb 048h,06dh,050h,06dh,066h,06ch,0e8h,06ch,0d8h,06ch,01ah,06dh,03ch,06dh,05ah,06dh	; 6b55  HmPmfl.l.l.m<mZm
	defb 07bh,06dh,097h,06dh,0bch,06dh,0dfh,06dh	; 6b65  {m.m.m.m

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
; DATOS sin identificar  0x6c0d..0x6f49  (828 bytes)
DATA_6C0D:
	defb 07eh,000h,08eh,000h,0a0h,000h,0a9h,000h,0beh,000h,001h,005h,0b9h,004h,075h,004h	; 6c0d  ~.............u.
	defb 0d5h,000h,0f1h,003h,0c0h,003h,08ah,003h,057h,003h,027h,003h,0f9h,002h,0cfh,002h	; 6c1d  ........W.'.....
	defb 0a6h,002h,080h,002h,05ch,002h,03ah,002h,01ah,002h,0f8h,001h,0e0h,001h,0c5h,001h	; 6c2d  ....\.:.........
	defb 0abh,001h,093h,001h,07ch,001h,067h,001h,053h,001h,040h,001h,02eh,001h,01dh,001h	; 6c3d  ....|.g.S.@.....
	defb 00dh,001h,0fch,000h,0f0h,000h,0e2h,000h,000h,000h,0c9h,000h,086h,000h,054h,000h	; 6c4d  ..............T.
	defb 050h,000h,04bh,000h,0b3h,000h,035h,004h,03dh,027h,0b8h,028h,010h,029h,010h,02ah	; 6c5d  P.K...5.='.(.).*
	defb 010h,02ch,010h,02dh,000h,061h,09dh,0c5h,00ah,062h,09fh,0d1h,00ah,048h,0a1h,0c5h	; 6c6d  .,.-.a...b...H..
	defb 00ah,042h,088h,0d1h,014h,048h,0a1h,0d1h,00ah,044h,0a2h,0c9h,00ah,043h,088h,0d5h	; 6c7d  .B...H...D...C..
	defb 00ah,042h,084h,0cah,00ah,041h,083h,0d6h,00ah,040h,084h,0cah,00ah,041h,0a5h,0d5h	; 6c8d  .B...A...@...A..
	defb 014h,043h,0a5h,0d5h,00ah,065h,09fh,0d0h,00ah,05fh,099h,0d5h,00ah,061h,09dh,0ceh	; 6c9d  .C...e..._...a..
	defb 00ah,062h,0dah,00ah,048h,0cdh,00ah,044h,0d9h,00ah,048h,0a1h,0cch,00ah,044h,09dh	; 6cad  .b..H..D..H...D.
	defb 0d5h,00ah,043h,0a1h,0d8h,00ah,042h,0ddh,00ah,041h,0a2h,0d3h,00ah,044h,09dh,0c7h	; 6cbd  ..C...B..A...D..
	defb 00ah,043h,0a2h,0cch,00ah,042h,0a1h,0d1h,014h,03dh,03dh,027h,0beh,028h,010h,02ch	; 6ccd  .C...B...=='.(.,
	defb 00ah,02dh,000h,041h,010h,008h,006h,004h,004h,004h,03dh,027h,0b8h,028h,010h,029h	; 6cdd  .-.A......='.(.)
	defb 010h,02ah,010h,02ch,010h,02dh,000h,055h,091h,0c5h,008h,059h,095h,008h,05ch,099h	; 6ced  .*.,.-.U...Y..\.
	defb 008h,061h,09dh,0d1h,008h,065h,0a1h,008h,043h,0a5h,008h,067h,0a5h,0e1h,008h,068h	; 6cfd  .a...e..C..g...h
	defb 084h,0e2h,008h,02ch,030h,069h,0aah,0e3h,014h,02dh,0ffh,014h,03dh,027h,0aeh,028h	; 6d0d  ...,0i...-..='.(
	defb 00fh,029h,010h,02ch,012h,02dh,000h,064h,026h,007h,000h,027h,0aeh,029h,010h,028h	; 6d1d  .).,.-.d&..'.).(
	defb 00dh,064h,026h,010h,02ch,00ah,02dh,00dh,000h,02ch,032h,064h,02dh,000h,000h,027h	; 6d2d  .d&.,.-..,2d-..'
	defb 0b7h,028h,010h,026h,002h,02ch,019h,064h,02dh,000h,000h,064h,02ch,004h,026h,01bh	; 6d3d  .(.&.,.d-..d,.&.
	defb 02dh,000h,000h,027h,0bdh,02ch,00ah,029h,010h,02dh,000h,089h,000h,027h,0b8h,028h	; 6d4d  -..'.,.).-...'.(
	defb 010h,029h,00dh,02ah,00ah,02ch,020h,02dh,000h,04dh,0a4h,0c6h,008h,052h,0cdh,008h	; 6d5d  .).*., -.M...R..
	defb 056h,0c6h,008h,05ah,097h,0d3h,010h,02ch,030h,059h,096h,0d2h,01fh,03dh,027h,0b8h	; 6d6d  V..Z...,0Y...='.
	defb 028h,010h,029h,010h,02ah,00ch,02ch,018h,02dh,000h,05eh,099h,0d6h,006h,062h,0d2h	; 6d7d  (.).*.,.-.^...b.
	defb 006h,065h,09eh,0d6h,006h,066h,0a5h,0ddh,01fh,03dh,027h,0b8h,028h,00fh,029h,00dh	; 6d8d  .e...f...='.(.).
	defb 02ah,00dh,05dh,095h,0d1h,006h,048h,09dh,0d5h,006h,061h,098h,0ddh,006h,044h,091h	; 6d9d  *.]...H...a...D.
	defb 0d6h,006h,064h,0a4h,0dah,006h,062h,09fh,0dch,006h,048h,0a1h,0ddh,01fh,03dh,027h	; 6dad  ..d...b...H...='
	defb 0b8h,028h,00fh,029h,00dh,02ah,00ch,042h,0a1h,0d1h,006h,048h,0ddh,006h,040h,088h	; 6dbd  .(.).*.B...H..@.
	defb 0d8h,006h,042h,0a1h,0ddh,006h,048h,0d8h,006h,040h,088h,0cch,006h,042h,0a1h,0d1h	; 6dcd  ..B...H..@...B..
	defb 010h,03dh,027h,0b8h,028h,00fh,029h,00ch,02ah,00dh,048h,0a1h,0d1h,00ch,03eh,00ch	; 6ddd  .='.(.).*.H...>.
	defb 042h,0a1h,0d1h,00ch,03eh,00ch,043h,088h,0d2h,00ch,0e4h,00ch,0ceh,00ch,044h,09eh	; 6ded  B...>.C.......D.
	defb 0e4h,006h,048h,006h,062h,09fh,0d3h,006h,064h,0a4h,006h,044h,0a2h,006h,064h,0a4h	; 6dfd  ..H.b...d..D..d.
	defb 006h,042h,0a2h,0d3h,006h,03eh,006h,044h,0a2h,0ceh,006h,064h,0a4h,0cdh,006h,043h	; 6e0d  .B...>.D...d...C
	defb 0a2h,0cch,00ch,03eh,006h,048h,0a2h,0d8h,004h,03eh,002h,048h,0a2h,0d8h,00ch,03eh	; 6e1d  ...>.H...>.H...>
	defb 00ch,040h,088h,0d1h,00ch,03eh,00ch,041h,0aah,0c9h,00ch,03eh,00ch,042h,084h,0cah	; 6e2d  .@...>.A...>.B..
	defb 00ch,03eh,00ch,043h,0a0h,0cbh,006h,03eh,006h,044h,0a0h,0d7h,006h,03eh,006h,048h	; 6e3d  .>.C...>.D...>.H
	defb 0a1h,0d8h,003h,03eh,003h,048h,0a1h,0d8h,003h,03eh,003h,063h,0a1h,0d8h,003h,03eh	; 6e4d  ...>.H...>.c...>
	defb 003h,048h,0a1h,0d8h,003h,03eh,003h,065h,0a2h,0cch,003h,03eh,003h,044h,0a2h,0cch	; 6e5d  .H...>.e...>.D..
	defb 003h,03eh,003h,06ah,0a2h,0cch,003h,03eh,003h,043h,0a2h,0cch,003h,03eh,003h,042h	; 6e6d  .>.j...>.C...>.B
	defb 0a1h,0d1h,00ch,03eh,006h,05dh,095h,0c5h,004h,03eh,002h,05dh,095h,0c5h,00ch,03eh	; 6e7d  ...>.]...>.]...>
	defb 00ch,05fh,096h,0cch,00ch,03eh,00ch,05eh,09bh,0c5h,00ch,03eh,00ch,05dh,09ah,0cah	; 6e8d  ._...>.^...>.]..
	defb 004h,064h,0a4h,002h,0e4h,006h,044h,09dh,004h,064h,0a4h,008h,061h,09dh,0cbh,004h	; 6e9d  .d....D..d..a...
	defb 064h,0a4h,002h,0e4h,006h,060h,09dh,004h,064h,0a4h,008h,05fh,09bh,0cch,004h,03eh	; 6ead  d....`..d.._...>
	defb 008h,062h,09bh,0c6h,004h,03eh,008h,061h,09bh,0c5h,004h,03eh,008h,05dh,095h,0cfh	; 6ebd  .b...>.a...>.]..
	defb 006h,05eh,0a4h,0e4h,006h,05fh,096h,0ceh,004h,0e4h,008h,0cah,004h,0e4h,008h,05dh	; 6ecd  .^..._.........]
	defb 09ah,0c9h,004h,03eh,008h,0ebh,004h,0e4h,008h,061h,098h,0c7h,00ch,03eh,00ch,060h	; 6edd  ...>.....a...>.`
	defb 09dh,0cbh,00ch,03eh,00ch,05fh,09ch,0cch,004h,03eh,008h,043h,09fh,004h,064h,0a4h	; 6eed  ...>._...>.C..d.
	defb 008h,043h,09fh,0cdh,004h,03eh,008h,042h,09fh,0cdh,004h,03eh,008h,043h,09dh,0ceh	; 6efd  .C...>.B...>.C..
	defb 004h,03eh,008h,061h,09dh,0ceh,004h,03eh,008h,063h,09dh,0c7h,004h,03eh,008h,043h	; 6f0d  .>.a...>.c...>.C
	defb 09dh,0d3h,004h,03eh,008h,044h,09ch,0d8h,004h,0e4h,002h,0d7h,004h,0e4h,002h,0d6h	; 6f1d  ...>.D..........
	defb 004h,0e4h,002h,0d3h,004h,0e4h,002h,0cch,004h,0e4h,002h,0cdh,004h,03eh,002h,065h	; 6f2d  .............>.e
	defb 0a2h,0ceh,004h,03eh,002h,0d0h,004h,0e4h,002h,033h,0dfh,06dh	; 6f3d  ...>.....3.m

; ======================================================================
; CODIGO 0x6f49..0x70f2  (425 bytes)
; ======================================================================


L_6F49:
	ld a,(0c011h)		;6f49
	and a			;6f4c
	jr z,L_6F54		;6f4d
	ld hl,09d6ch		;6f4f
	jr L_6F63		;6f52
L_6F54:
	ld a,(0cec3h)		;6f54
	ld hl,(0c000h)		;6f57
	add a,a			;6f5a
	ld e,a			;6f5b
	ld d,000h		;6f5c
	add hl,de			;6f5e
	ld e,(hl)			;6f5f
	inc hl			;6f60
	ld d,(hl)			;6f61
	ex de,hl			;6f62
L_6F63:
	ld de,0cec0h		;6f63
	call L_70A2		;6f66
	ld de,0cb00h		;6f69
	ld a,(0c011h)		;6f6c
	and a			;6f6f
	jr z,L_6F75		;6f70
	ld de,0cce0h		;6f72
L_6F75:
	call L_7099		;6f75
	cp 021h		;6f78
	jr z,L_6FCE		;6f7a
	cp 030h		;6f7c
	jr c,L_6FA4		;6f7e
	cp 060h		;6f80
	jr nc,L_6FA4		;6f82
	and 00fh		;6f84
	ld b,a			;6f86
	inc b			;6f87
	call L_7099		;6f88
	push hl			;6f8b
	push de			;6f8c
	and 0f0h		;6f8d
	rrca			;6f8f
	rrca			;6f90
	rrca			;6f91
	rrca			;6f92
	ld hl,0cebdh		;6f93
	ld e,a			;6f96
	ld d,000h		;6f97
	add hl,de			;6f99
	pop de			;6f9a
	ld a,(hl)			;6f9b
L_6F9C:
	ld (de),a			;6f9c
	inc de			;6f9d
	djnz L_6F9C		;6f9e
	pop hl			;6fa0
	inc hl			;6fa1
	jr L_6F75		;6fa2
L_6FA4:
	ld (de),a			;6fa4
	cp 0e9h		;6fa5
	jr nz,L_6FAD		;6fa7
	ld (0cec6h),de		;6fa9
L_6FAD:
	cp 0d9h		;6fad
	jr nz,L_6FB5		;6faf
	ld a,003h		;6fb1
	jr L_6FC3		;6fb3
L_6FB5:
	cp 0ddh		;6fb5
	jr nz,L_6FBD		;6fb7
	ld a,004h		;6fb9
	jr L_6FC3		;6fbb
L_6FBD:
	cp 0e3h		;6fbd
	jr nz,L_6FCA		;6fbf
	ld a,005h		;6fc1
L_6FC3:
	ld (0c06ch),a		;6fc3
	ld (0cec8h),de		;6fc6
L_6FCA:
	inc hl			;6fca
	inc de			;6fcb
	jr L_6F75		;6fcc
L_6FCE:
	ld a,(0c011h)		;6fce
	and a			;6fd1
	jp nz,L_713A		;6fd2
	inc hl			;6fd5
	ld de,0cecfh		;6fd6
	call L_70A2		;6fd9
	ld a,(0c006h)		;6fdc
	and a			;6fdf
	ret nz			;6fe0
L_6FE1:
	ld hl,(0cec6h)		;6fe1
	call L_70D3		;6fe4
	add a,007h		;6fe7
	ld (0cec5h),a		;6fe9
	ld a,c			;6fec
	add a,002h		;6fed
	ld (0cec4h),a		;6fef
	ld hl,(0cec8h)		;6ff2
	call L_70D3		;6ff5
	ld l,a			;6ff8
	ld h,c			;6ff9
	ld (0cecah),hl		;6ffa
	ld a,(0c006h)		;6ffd
	and a			;7000
	ld a,004h		;7001
	jr nz,L_700D		;7003
	call L_4CD0		;7005
	ld b,009h		;7008
	call L_4CEE		;700a
L_700D:
	ld (0cecch),a		;700d
	ld e,a			;7010
	ld d,000h		;7011
	ld a,(0c06ch)		;7013
	sub 003h		;7016
	ld c,a			;7018
	add a,a			;7019
	add a,a			;701a
	add a,a			;701b
	add a,c			;701c
	add a,a			;701d
	add a,e			;701e
	ld e,a			;701f
	ld hl,070f2h		;7020
	add hl,de			;7023
	ld a,(0cecah)		;7024
	add a,(hl)			;7027
	ld (0c63fh),a		;7028
	ld a,(0cecbh)		;702b
	ld e,009h		;702e
	add hl,de			;7030
	add a,(hl)			;7031
	ld (0c640h),a		;7032
	ld de,07128h		;7035
	ld a,(0cecch)		;7038
	ld l,a			;703b
	ld h,000h		;703c
	add hl,de			;703e
	ld e,(hl)			;703f
	push hl			;7040
	pop ix		;7041
	ld a,(ix+009h)		;7043
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
	ld (0cecdh),hl		;7052
	ld a,e			;7055
	add a,a			;7056
	add a,a			;7057
	add a,a			;7058
	add a,003h		;7059
	ld (0c63dh),a		;705b
	ld a,b			;705e
	add a,a			;705f
	add a,a			;7060
	add a,a			;7061
	add a,003h		;7062
	ld (0c63eh),a		;7064
	ld a,(0c006h)		;7067
	and a			;706a
	ret nz			;706b
	call L_4CD0		;706c
	ld hl,0c625h		;706f
	ld (hl),a			;7072
	ld a,(0c007h)		;7073
	and a			;7076
	jr nz,L_707B		;7077
	res 6,(hl)		;7079
L_707B:
	call L_4CD0		;707b
	and 0e0h		;707e
	ld (0c615h),a		;7080
	ld a,(0c007h)		;7083
	inc a			;7086
	ld b,a			;7087
	add a,a			;7088
	add a,b			;7089
	ld b,a			;708a
	push bc			;708b
	call L_4CD0		;708c
	pop bc			;708f
	call L_4CEE		;7090
	add a,004h		;7093
	ld (0c614h),a		;7095
	ret			;7098
L_7099:
	ld a,(0c006h)		;7099
	and a			;709c
	ld a,(hl)			;709d
	ret z			;709e
	jp 0004ah		;709f   ; BIOS RDVRM - Reads the content of VRAM
L_70A2:
	ld b,003h		;70a2
L_70A4:
	call L_7099		;70a4
	ld (de),a			;70a7
	inc hl			;70a8
	inc de			;70a9
	djnz L_70A4		;70aa
	ret			;70ac
L_70AD:
	ld hl,0cb00h		;70ad
	ld bc,001e0h		;70b0
L_70B3:
	ld a,(hl)			;70b3
	cp 0e9h		;70b4
	jr nz,L_70BB		;70b6
L_70B8:
	ld (0cec6h),hl		;70b8
L_70BB:
	cp 0d9h		;70bb
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
L_70D3:
	ld de,0cb00h		;70d3
	and a			;70d6
	sbc hl,de		;70d7
	ld de,00014h		;70d9
	ld c,0ffh		;70dc
L_70DE:
	and a			;70de
	sbc hl,de		;70df
	inc c			;70e1
	jr nc,L_70DE		;70e2
	ld a,c			;70e4
	add a,a			;70e5
	add a,a			;70e6
	add a,a			;70e7
	ld c,a			;70e8
	ld a,l			;70e9
	add a,014h		;70ea
	add a,a			;70ec
	add a,a			;70ed
	add a,a			;70ee
	add a,058h		;70ef
	ret			;70f1

; ----------------------------------------------------------------------
; DATOS sin identificar  0x70f2..0x713a  (72 bytes)
DATA_70F2:
	defb 005h,00bh,011h,005h,00bh,011h,005h,00bh,011h,003h,003h,003h,007h,007h,007h,00bh	; 70f2  ................
	defb 00bh,00bh,006h,00bh,010h,006h,00bh,010h,006h,00bh,010h,004h,004h,004h,007h,007h	; 7102  ................
	defb 007h,00ah,00ah,00ah,006h,00bh,010h,006h,00bh,010h,006h,00bh,010h,004h,004h,004h	; 7112  ................
	defb 007h,007h,007h,00ah,00ah,00ah,010h,014h,018h,010h,014h,018h,010h,014h,018h,007h	; 7122  ................
	defb 007h,007h,00bh,00bh,00bh,00fh,00fh,00fh	; 7132  ........

; ======================================================================
; CODIGO 0x713a..0x716b  (49 bytes)
; ======================================================================


L_713A:
	ld de,0cce0h		;713a
	jr L_7142		;713d
L_713F:
	ld de,0cb00h		;713f
L_7142:
	ld hl,0180bh		;7142
	ld c,018h		;7145
L_7147:
	ld b,014h		;7147
L_7149:
	ld a,(de)			;7149
	call 0004dh		;714a   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;714d
	inc hl			;714e
	djnz L_7149		;714f
	push de			;7151
	ld de,0000ch		;7152
	add hl,de			;7155
	pop de			;7156
	dec c			;7157
	jr nz,L_7147		;7158
	ld a,(0c011h)		;715a
	and a			;715d
	ret z			;715e
	ld hl,(0cecdh)		;715f
	ld de,01800h		;7162
	add hl,de			;7165
	ld a,0d6h		;7166
	jp 0004dh		;7168   ; BIOS WRTVRM - Writes data in VRAM

; ----------------------------------------------------------------------
; DATOS sin identificar  0x716b..0x9ddd  (11378 bytes)
DATA_716B:
	defb 0b3h,071h,0ceh,072h,0d2h,073h,0f9h,074h,00eh,076h,069h,077h,0c2h,078h,0dah,079h	; 716b  .q.r.s.t.viw.x.y
	defb 0dbh,07ah,042h,07ch,080h,07dh,0bah,07eh,0cah,07fh,017h,081h,053h,082h,04fh,083h	; 717b  .zB|.}.~....S.O.
	defb 07ah,084h,0cdh,085h,011h,087h,06eh,088h,08dh,089h,00fh,08bh,074h,08ch,0a6h,08dh	; 718b  z.....n.....t...
	defb 081h,08eh,0e2h,08fh,01ch,091h,07eh,092h,0ech,093h,005h,095h,035h,096h,073h,097h	; 719b  ......~.....5.s.
	defb 0a5h,098h,0c2h,099h,0fdh,09ah,01fh,09ch,094h,079h,078h,039h,0a1h,045h,0c0h,0d1h	; 71ab  .........yx9.E..
	defb 040h,039h,0b3h,040h,066h,040h,066h,0ddh,0deh,0dfh,0cbh,098h,039h,09bh,068h,067h	; 71bb  @9.@f@f.....9.hg
	defb 068h,067h,0e0h,0e1h,0e2h,098h,030h,034h,095h,031h,0abh,0a7h,066h,069h,066h,069h	; 71cb  hg....04.1..fifi
	defb 0a8h,0a9h,0ach,0a8h,031h,031h,095h,033h,09bh,066h,040h,067h,040h,067h,040h,0aah	; 71db  ....11.3.f@g@g@.
	defb 034h,035h,09bh,066h,067h,066h,068h,06ah,07eh,050h,07bh,0a2h,030h,00eh,031h,033h	; 71eb  45.fgfhj~P{.0.13
	defb 095h,0a3h,040h,067h,068h,067h,069h,06bh,082h,050h,093h,0aeh,030h,00fh,095h,030h	; 71fb  ..@ghgik.P..0..0
	defb 034h,09fh,066h,06ah,069h,0b7h,0b8h,066h,051h,085h,0a0h,033h,031h,095h,030h,09bh	; 720b  4.fji..fQ..31.0.
	defb 06ah,067h,069h,0b7h,0b5h,0bch,061h,051h,081h,0b2h,095h,032h,032h,09bh,068h,06bh	; 721b  jgi...aQ...22.hk
	defb 068h,0b7h,0b5h,0beh,0bah,060h,050h,07dh,098h,034h,095h,030h,09bh,040h,069h,068h	; 722b  h....`P}.4.0.@ih
	defb 069h,0b9h,0bah,086h,08ah,061h,085h,098h,035h,030h,09bh,041h,066h,069h,066h,040h	; 723b  i....a..50.Afif@
	defb 07ah,051h,07dh,09ch,030h,095h,032h,0b1h,0abh,09bh,042h,067h,066h,067h,07ah,051h	; 724b  zQ}.0.2...BgfgzQ
	defb 07dh,098h,034h,09bh,06ch,06eh,042h,06ah,040h,067h,07ah,051h,085h,09ch,031h,00eh	; 725b  }.4.lnBj@gzQ..1.
	defb 031h,0b3h,040h,06dh,06fh,042h,06bh,040h,07eh,051h,085h,068h,0a0h,031h,00fh,032h	; 726b  1.@moBk@~Q.h.1.2
	defb 0a9h,0a5h,040h,044h,082h,051h,081h,069h,0b2h,037h,0b0h,044h,092h,050h,085h,040h	; 727b  ..@D.Q.i.7.D.P.@
	defb 068h,09ah,038h,044h,07ch,050h,081h,040h,069h,066h,0a6h,0aah,032h,00eh,00eh,031h	; 728b  h.8D|P.@if..2..1
	defb 049h,067h,041h,0a6h,0aah,030h,00fh,00fh,031h,04ch,06ch,06eh,041h,06ch,06eh,040h	; 729b  IgA..0..1LlnAln@
	defb 041h,0eeh,0e9h,0eah,0f6h,046h,06dh,06fh,0f8h,0f9h,06dh,06fh,040h,041h,0efh,0ebh	; 72ab  A....Fmo..mo@A..
	defb 0ebh,0f7h,040h,00dh,047h,0f8h,0f9h,041h,047h,00dh,044h,00dh,044h,04fh,043h,021h	; 72bb  ..@.G..AG.D.DOC!
	defb 033h,035h,032h,094h,0b5h,079h,099h,050h,0b9h,0beh,043h,0beh,0beh,0bah,068h,0b9h	; 72cb  352..y.P..C...h.
	defb 0beh,0beh,0beh,043h,0b3h,0e3h,0e4h,0e5h,0b9h,041h,0bah,086h,08eh,08eh,063h,087h	; 72db  ...C.....A....c.
	defb 052h,0b9h,042h,0b3h,0e6h,0e7h,0e8h,066h,0bbh,0bch,050h,092h,078h,078h,078h,07dh	; 72eb  R.B....f..P.xxx}
	defb 0b7h,0bdh,0b8h,068h,0b9h,041h,030h,0a9h,0ach,0a5h,067h,0bbh,040h,0b8h,088h,08fh	; 72fb  ...h.A0...g.@...
	defb 08fh,089h,0b7h,041h,0bch,069h,068h,0b9h,040h,033h,099h,0b9h,0beh,0beh,0bdh,0bdh	; 730b  ...A.ih.@3......
	defb 0bfh,0bfh,076h,074h,040h,0bah,066h,069h,066h,0b9h,034h,0a9h,0ach,0a5h,0ceh,042h	; 731b  ..vt@.fif.4....B
	defb 077h,075h,0bch,07eh,061h,050h,067h,050h,037h,09dh,0bbh,043h,0bch,07ch,078h,07bh	; 732b  wu.~aPgP7..C.|x{
	defb 050h,066h,031h,00eh,034h,0a1h,0b9h,040h,073h,042h,0d1h,092h,078h,07fh,067h,031h	; 733b  Pf1.4..@sB..x.g1
	defb 00fh,034h,095h,09dh,0bbh,042h,070h,0bch,092h,060h,091h,068h,038h,0a1h,0ceh,042h	; 734b  .4...Bp..`.h8..B
	defb 071h,0bch,084h,061h,091h,069h,036h,00eh,031h,09dh,0b9h,042h,0bch,082h,078h,091h	; 735b  q..a.i6.1..B..x.
	defb 050h,035h,095h,00fh,031h,0a1h,050h,0ceh,041h,0bch,084h,078h,091h,06ah,039h,095h	; 736b  P5..1.P.A..x.j9.
	defb 099h,050h,0b9h,0beh,0bah,07ch,078h,081h,06bh,03bh,0a9h,0a5h,051h,06ch,06eh,051h	; 737b  .P...|x.k;..QlnQ
	defb 034h,095h,037h,0a9h,0a5h,06dh,06fh,050h,098h,03fh,0a9h,0ach,0a8h,030h,03dh,095h	; 738b  4.7..moP.?...0=.
	defb 034h,037h,00eh,038h,095h,030h,030h,00eh,035h,00fh,03ah,030h,00fh,03ah,0b1h,0b1h	; 739b  47.8.00.5.:0.:..
	defb 0b1h,095h,032h,03ah,0abh,0a7h,052h,0a6h,0aah,031h,036h,095h,031h,0a3h,06ch,0eeh	; 73ab  ..2:..R..16.1.l.
	defb 0e9h,0eah,0f2h,066h,050h,0a6h,0aah,039h,09fh,06dh,0efh,0ebh,0ebh,0f3h,067h,052h	; 73bb  ...fP..9.m....gR
	defb 039h,09dh,058h,021h,034h,037h,032h,0b5h,079h,094h,052h,09bh,068h,066h,040h,068h	; 73cb  9.X!472.y.R.hf@h
	defb 066h,043h,0a2h,055h,051h,09bh,040h,069h,067h,040h,069h,067h,068h,066h,068h,06ah	; 73db  fC.UQ.@ig@ighfhj
	defb 09eh,055h,050h,0a3h,0ddh,0deh,0dfh,0a4h,0a8h,0a9h,040h,069h,067h,069h,067h,066h	; 73eb  .UP.......@igigf
	defb 0a2h,095h,053h,050h,0a1h,0e0h,0e1h,0e2h,0a0h,050h,0b3h,040h,08ah,078h,08bh,087h	; 73fb  ..SP.....P.@.x..
	defb 067h,09eh,051h,095h,051h,050h,095h,0a9h,0ach,0a8h,051h,09bh,040h,08ch,060h,078h	; 740b  g.Q.QP....Q.@.`x
	defb 078h,07bh,066h,09ah,053h,055h,09bh,042h,069h,07ch,078h,078h,067h,066h,09ah,052h	; 741b  x{f.SU.Bi|xxgf.R
	defb 053h,0abh,0a7h,041h,0b7h,0bdh,0bdh,0b8h,092h,078h,083h,067h,066h,0a6h,0aah,050h	; 742b  S..A.....x.gf..P
	defb 051h,0abh,0a7h,042h,0b7h,032h,0bch,060h,078h,093h,068h,067h,041h,09ah,050h,09bh	; 743b  Q..B.2.`x.hgA.P.
	defb 043h,0b7h,030h,074h,031h,0bah,061h,078h,093h,069h,068h,042h,09bh,043h,0b7h,031h	; 744b  C.0t1.ax.ihB.C.1
	defb 075h,030h,0bah,07ah,078h,062h,093h,066h,069h,06ah,041h,044h,0bbh,032h,0bah,066h	; 745b  u0.zxb.fijAD.2.f
	defb 092h,078h,063h,085h,067h,066h,06bh,041h,043h,0b7h,032h,0bch,040h,067h,092h,078h	; 746b  .xc.gfkAC.2.@g.x
	defb 078h,081h,068h,067h,042h,042h,0b7h,033h,0bch,041h,07ch,078h,07dh,066h,069h,068h	; 747b  x.hgBB.3.A|x}fih
	defb 042h,041h,0b7h,035h,0bfh,0d1h,042h,067h,040h,069h,042h,041h,0bbh,031h,076h,074h	; 748b  BA.5..Bg@iBA.1vt
	defb 033h,0bfh,0bdh,0b8h,045h,040h,0b7h,032h,077h,075h,036h,0b8h,044h,040h,0bbh,037h	; 749b  3...E@.2wu6.D@.7
	defb 073h,032h,0b4h,0bdh,0d1h,042h,040h,0b9h,03eh,0b8h,041h,041h,0bbh,036h,0beh,0beh	; 74ab  s2...B@.>.AA.6..
	defb 0beh,034h,0bfh,0d1h,040h,0b7h,0b4h,034h,0b4h,0bah,042h,0b9h,035h,040h,0bbh,031h	; 74bb  .4..@..4..B.5@.1
	defb 070h,032h,0bah,0eeh,0e9h,0eah,0f2h,040h,0bbh,031h,072h,031h,040h,0bbh,031h,071h	; 74cb  p2.....@.1r1@.1q
	defb 031h,0bch,040h,0efh,0ebh,0ebh,0f3h,040h,0bbh,034h,040h,0b9h,0b4h,034h,0b8h,043h	; 74db  1.@....@.4@..4.C
	defb 0b7h,035h,041h,0bbh,035h,0bdh,0b8h,040h,0b7h,036h,021h,033h,037h,036h,094h,079h	; 74eb  .5A.5..@.6!376.y
	defb 06bh,03dh,0a1h,044h,032h,097h,031h,0abh,0adh,036h,0a9h,0a5h,042h,033h,096h,030h	; 74fb  k=.D2.1..6..B3.0
	defb 09dh,06ah,0a2h,034h,00eh,031h,099h,041h,035h,0a1h,050h,09eh,034h,00fh,032h,0a9h	; 750b  .j.4.1.A5.P.4.2.
	defb 0a5h,035h,0b3h,06ah,06ah,09ah,039h,035h,0b3h,051h,06ah,09ah,034h,0a3h,0a2h,031h	; 751b  .5.jj.95.Qj.4..1
	defb 030h,00eh,032h,095h,0a3h,06ah,040h,050h,040h,0a6h,0aah,032h,09fh,09ch,031h,030h	; 752b  0.2..j@P@..2..10
	defb 00fh,095h,032h,0afh,050h,0b7h,0bdh,0b8h,040h,06ah,0a6h,0aah,0abh,040h,0a0h,0abh	; 753b  ..2.P...@j...@..
	defb 0adh,035h,09fh,0d0h,0b5h,072h,0b4h,0b8h,050h,06ah,06ah,040h,0a0h,0abh,0a4h,0a8h	; 754b  .5...r..Pjj@....
	defb 034h,09bh,06ah,0ceh,0beh,0beh,0b4h,0b5h,0b8h,051h,06ah,09ah,0a9h,031h,033h,0b3h	; 755b  4.j......Qj..13.
	defb 06ah,050h,066h,0d9h,0d8h,0dah,0b9h,0bch,06ah,06ah,050h,040h,0aah,030h,097h,031h	; 756b  jPf.....jjP@.0.1
	defb 0abh,0aah,0abh,050h,040h,067h,0dbh,0d7h,0dch,0b7h,0bah,051h,040h,0a8h,0b0h,031h	; 757b  ...P@g.....Q@..1
	defb 031h,099h,040h,06ah,040h,06ah,06ah,0c2h,0bdh,0bfh,0bah,040h,0a4h,0ach,0a8h,033h	; 758b  1.@j@jj....@...3
	defb 030h,095h,09bh,040h,050h,06ah,051h,068h,066h,041h,098h,036h,030h,0a3h,06ah,098h	; 759b  0..@PjQhfA.60.j.
	defb 09dh,050h,0a8h,0a5h,069h,067h,06ah,09ch,033h,095h,032h,030h,0afh,050h,0a2h,0a1h	; 75ab  .P..igj.3.20.P..
	defb 098h,031h,0a9h,0a5h,050h,0aeh,095h,036h,030h,0afh,06ah,09ah,035h,099h,0a0h,032h	; 75bb  .1..P..60.j.5..2
	defb 00eh,033h,030h,0afh,050h,040h,09ah,038h,095h,00fh,033h,030h,09fh,098h,099h,098h	; 75cb  .30.P@.8..30....
	defb 033h,0b1h,039h,030h,0ach,034h,0abh,0a7h,040h,0a6h,0aah,037h,035h,09bh,044h,0a2h	; 75db  3.90.4..@..75.D.
	defb 030h,00eh,034h,034h,09bh,040h,06ah,0ech,0e9h,0eah,0f2h,09eh,030h,00fh,034h,033h	; 75eb  0.44.@j.....0.43
	defb 0a3h,041h,050h,0edh,0ebh,0ebh,0f3h,040h,0b2h,035h,033h,09fh,047h,0b2h,035h,021h	; 75fb  .AP....@.53.G.5!
	defb 031h,036h,037h,094h,079h,078h,042h,0a0h,033h,0a9h,0a5h,042h,066h,041h,068h,042h	; 760b  167.yxB.3..BfAhB
	defb 041h,098h,036h,0a9h,0a5h,040h,067h,0d0h,0c1h,06bh,0cch,0d1h,066h,040h,098h,039h	; 761b  A.6..@g..k..f@.9
	defb 0a9h,0a5h,0cah,0ddh,0deh,0dfh,0cbh,067h,09ch,095h,032h,0abh,0adh,0aah,035h,099h	; 762b  .......g..2...5.
	defb 0e0h,0e1h,0e2h,066h,06ah,0a0h,032h,0a3h,042h,0a6h,0aah,0b1h,031h,095h,030h,0a9h	; 763b  ...fj.2.B...1.0.
	defb 0a5h,040h,067h,06bh,0a2h,032h,09fh,041h,066h,068h,066h,040h,09ah,034h,099h,040h	; 764b  .@gk.2.Afhf@.4.@
	defb 068h,09eh,031h,0a3h,041h,068h,067h,069h,067h,040h,066h,09ah,034h,09dh,069h,040h	; 765b  h.1.Ahgig@f.4.i@
	defb 0b2h,030h,0afh,041h,069h,040h,0b7h,0bdh,0b8h,067h,040h,09ah,033h,0a1h,040h,040h	; 766b  .0.Ai@...g@.3.@@
	defb 0b2h,030h,0a1h,040h,07ah,050h,07fh,0bbh,0b5h,0bch,082h,083h,066h,09ah,095h,032h	; 767b  .0.@zP......f..2
	defb 09dh,040h,0a2h,030h,0a3h,040h,092h,050h,083h,0b9h,0b5h,0bch,092h,093h,067h,068h	; 768b  .@.0.@.P......gh
	defb 0a2h,032h,0afh,040h,0a0h,095h,0a1h,040h,092h,050h,060h,07bh,0b9h,0bah,092h,093h	; 769b  .2.@...@.P`{....
	defb 066h,069h,0aeh,032h,0afh,09ch,031h,0b3h,040h,084h,050h,061h,050h,08bh,08ah,060h	; 76ab  fi.2..1.@.PaP..`
	defb 093h,069h,066h,09eh,032h,0afh,0aeh,032h,09dh,080h,054h,061h,093h,0c7h,067h,066h	; 76bb  .if.2..2..Ta..gf
	defb 0b2h,031h,0afh,09eh,095h,031h,0a1h,040h,07ch,054h,07dh,0cbh,066h,067h,0b2h,031h	; 76cb  .1...1.@|T}.fg.1
	defb 0afh,040h,0a2h,032h,09dh,040h,088h,08ch,060h,08dh,089h,066h,040h,067h,040h,0b2h	; 76db  .@.2.@..`..f@g@.
	defb 031h,09fh,066h,09eh,095h,031h,0a1h,041h,068h,067h,066h,068h,067h,068h,040h,09ch	; 76eb  1.f..1.Ahgfhgh@.
	defb 095h,030h,0b3h,040h,067h,066h,0b2h,032h,09dh,040h,069h,068h,067h,069h,066h,069h	; 76fb  .0.@gf.2.@ihgifi
	defb 040h,0a0h,031h,0a3h,040h,068h,067h,0a2h,032h,0a1h,041h,069h,06ah,068h,067h,040h	; 770b  @.1.@hg.2.Aijhg@
	defb 098h,031h,095h,09fh,066h,069h,068h,09eh,095h,032h,0a9h,0a5h,040h,06bh,069h,0a4h	; 771b  .1..fih..2..@ki.
	defb 0a8h,032h,09bh,040h,067h,040h,069h,068h,0a2h,034h,0a9h,0ach,0a8h,032h,0abh,0a7h	; 772b  .2.@g@ih.4...2..
	defb 042h,066h,06ah,069h,0a0h,039h,09bh,0f0h,0e9h,0eah,0f4h,040h,067h,06bh,098h,031h	; 773b  Bfji.9.....@gk.1
	defb 00eh,036h,0a3h,040h,0f1h,0ebh,0ebh,0f5h,040h,0a4h,0a8h,031h,095h,00fh,032h,00eh	; 774b  .6.@....@..1..2.
	defb 032h,0afh,066h,044h,038h,00fh,032h,0a1h,067h,044h,021h,033h,031h,035h,079h,094h	; 775b  2.fD8.2.gD!315y.
	defb 078h,035h,0a4h,0ach,0ach,0ach,0ach,0ach,0ach,0ach,0a5h,034h,033h,0a4h,0a8h,048h	; 776b  x5.........43..H
	defb 099h,033h,030h,068h,030h,09ch,041h,0abh,0adh,0adh,0aah,095h,0abh,0adh,0adh,0aah	; 777b  .30h0.A.........
	defb 040h,099h,032h,030h,069h,06ah,0aeh,040h,09bh,038h,09ah,040h,09dh,031h,0b8h,030h	; 778b  @.20ij.@.8.@.1.0
	defb 06bh,0aeh,040h,0afh,030h,0ddh,0deh,0dfh,031h,07ah,050h,07bh,0aeh,040h,0afh,031h	; 779b  k.@.0...1zP{.@.1
	defb 0bch,031h,0aeh,040h,0afh,030h,0e0h,0e1h,0e2h,031h,07ch,050h,07dh,0aeh,040h,0afh	; 77ab  .1.@.0...1|P}.@.
	defb 031h,0bah,031h,09eh,0aah,09fh,032h,0d0h,0bfh,0d1h,032h,09eh,0b1h,0afh,031h,09ch	; 77bb  1.1...2...2...1.
	defb 0ach,0ach,09dh,031h,0d0h,0bfh,0bfh,0b4h,0b4h,0b4h,0bfh,0bfh,0d1h,031h,0a4h,0ach	; 77cb  ...1.........1..
	defb 09dh,0aeh,042h,0a9h,0a5h,0ceh,0beh,0b4h,0b4h,0b4h,0b4h,0b4h,0beh,0bah,0a4h,0a8h	; 77db  ..B.............
	defb 041h,0afh,003h,09ah,043h,099h,030h,0ceh,0beh,0beh,0beh,0bah,030h,098h,043h,09bh	; 77eb  A...C.0.....0.C.
	defb 000h,003h,09ah,042h,0b3h,030h,066h,08eh,066h,08eh,066h,030h,0b2h,042h,09bh,004h	; 77fb  ...B.0f.f.f0.B..
	defb 000h,000h,003h,0a2h,041h,0b3h,07eh,061h,060h,063h,060h,061h,07fh,0b2h,041h,0a3h	; 780b  ....A.~a`c`a..A.
	defb 004h,000h,002h,000h,005h,09eh,041h,0a3h,082h,050h,061h,050h,061h,050h,083h,0a2h	; 781b  ......A..PaPaP..
	defb 041h,09fh,006h,000h,030h,006h,005h,09ch,041h,09fh,056h,09eh,041h,09dh,006h,000h	; 782b  A...0...A.V.A...
	defb 09dh,002h,008h,0a0h,040h,0a3h,07ah,053h,060h,051h,07bh,0a2h,040h,0a3h,006h,000h	; 783b  ....@.zS`Q{.@...
	defb 0a1h,031h,0a0h,040h,09fh,051h,062h,051h,061h,051h,062h,09eh,040h,0a3h,006h,000h	; 784b  .1.@.QbQaQb.@...
	defb 095h,09dh,030h,0a0h,0a3h,07ah,051h,063h,054h,063h,07bh,0a2h,0a3h,006h,000h,040h	; 785b  ..0..zQcTc{....@
	defb 0afh,030h,09eh,09fh,084h,055h,060h,051h,093h,09eh,09fh,00ch,00ah,095h,0a1h,032h	; 786b  .0...U`Q.......2
	defb 07ch,055h,061h,051h,07dh,033h,040h,095h,099h,032h,0c8h,0c8h,0c8h,032h,0c8h,0c8h	; 787b  |UaQ}3@..2...2..
	defb 0c8h,034h,09ah,041h,099h,030h,06ah,0b6h,0b6h,0b6h,032h,0b6h,0b6h,0b6h,034h,030h	; 788b  .4.A.0j...2...40
	defb 09ah,095h,040h,0a9h,069h,033h,00dh,030h,0ech,0e9h,0eah,0f2h,033h,030h,068h,09ah	; 789b  ..@.i3.0....30h.
	defb 041h,0a9h,0a5h,031h,00dh,031h,0edh,0ebh,0ebh,0f3h,033h,030h,069h,030h,0a2h,041h	; 78ab  A..1.1....30i0.A
	defb 095h,099h,03bh,021h,032h,037h,038h,079h,000h,078h,049h,005h,030h,0d0h,0c1h,030h	; 78bb  ..;!278y.xI.0..0
	defb 0cch,0d1h,032h,049h,001h,030h,0cah,0e3h,0e4h,0e5h,0cbh,032h,047h,009h,00bh,066h	; 78cb  ..2I.0.....2G..f
	defb 068h,066h,0e6h,0e7h,0e8h,066h,066h,031h,043h,008h,008h,009h,00bh,0d0h,0c1h,067h	; 78db  hf...ff1C......g
	defb 069h,067h,0c0h,0c1h,066h,067h,067h,004h,007h,042h,001h,066h,068h,068h,0cch,0cdh	; 78eb  ig..fgg..B.fhh..
	defb 08ah,051h,08bh,066h,068h,067h,030h,004h,041h,041h,001h,068h,067h,069h,069h,086h	; 78fb  .Q.fhg0.AA.hgii.
	defb 08ah,060h,060h,062h,060h,067h,069h,004h,007h,042h,040h,005h,066h,069h,086h,08ah	; 790b  .``b`gi..B@.fi..
	defb 051h,08dh,067h,069h,069h,069h,030h,004h,044h,040h,001h,067h,082h,052h,07dh,004h	; 791b  Q.giii0.D@.g.R}.
	defb 007h,007h,007h,007h,007h,045h,005h,068h,082h,052h,07dh,004h,044h,008h,045h,005h	; 792b  .....E.h.R}.D.E.
	defb 069h,092h,051h,07dh,004h,043h,008h,001h,066h,002h,044h,001h,066h,092h,050h,093h	; 793b  i.Q}.C..f.D.f.P.
	defb 066h,006h,042h,005h,030h,066h,067h,030h,006h,043h,066h,067h,051h,093h,067h,002h	; 794b  f.B.0fg0.CfgQ.g.
	defb 043h,003h,067h,004h,007h,044h,067h,030h,092h,050h,093h,066h,068h,002h,043h,007h	; 795b  C.g..Dg0.P.fh.C.
	defb 043h,008h,008h,001h,030h,0c6h,084h,051h,063h,067h,066h,006h,046h,001h,066h,031h	; 796b  C...0..Qcgf.F.f1
	defb 030h,0ceh,0d1h,052h,07bh,067h,002h,045h,001h,068h,067h,031h,030h,066h,0ceh,0cch	; 797b  0..R{g.E.hg10f..
	defb 0cfh,051h,07bh,030h,002h,008h,008h,008h,008h,001h,030h,069h,032h,030h,067h,068h	; 798b  .Q{0......0i20gh
	defb 066h,07ch,052h,07fh,030h,066h,033h,0f8h,0f9h,032h,031h,069h,067h,066h,088h,08ch	; 799b  f|R.0f3..21igf..
	defb 08dh,081h,030h,067h,068h,030h,0f8h,0f9h,034h,032h,06ah,067h,068h,034h,069h,031h	; 79ab  ..0gh0..42jgh4i1
	defb 00dh,034h,032h,06bh,068h,069h,066h,03ch,033h,069h,030h,069h,03ch,03ch,0f0h,0e9h	; 79bb  .42khif<3i0i<<..
	defb 0eah,0f4h,032h,03ch,0f1h,0ebh,0ebh,0f5h,032h,03fh,033h,021h,034h,036h,039h,079h	; 79cb  ..2<....2?3!469y
	defb 000h,094h,0b9h,0beh,0beh,0b5h,0b5h,0b5h,0b5h,0b5h,0bah,03ah,032h,0b9h,0beh,0beh	; 79db  ...........:2...
	defb 0beh,0bah,030h,004h,007h,007h,007h,007h,007h,003h,033h,0b0h,0a9h,0a5h,034h,004h	; 79eb  ..0.......3...4.
	defb 046h,007h,007h,007h,003h,051h,095h,0a9h,0a5h,032h,002h,008h,008h,008h,047h,054h	; 79fb  F....Q...2....GT
	defb 0a9h,0a5h,031h,068h,06ah,068h,002h,008h,045h,056h,09dh,066h,069h,06bh,069h,0c0h	; 7a0b  ..1hjh..EV.fiki.
	defb 0d1h,002h,044h,056h,0a1h,067h,0c6h,0d9h,0d8h,0dah,0b6h,066h,006h,043h,055h,095h	; 7a1b  ..DV.g.....f.CU.
	defb 0b3h,068h,0cah,0dbh,0d7h,0dch,066h,067h,006h,043h,052h,00eh,052h,0a3h,069h,066h	; 7a2b  .h....fg.CR.R.if
	defb 030h,0c0h,0c1h,069h,004h,044h,051h,095h,00fh,052h,09fh,066h,067h,030h,004h,007h	; 7a3b  0..i.DQ..R.fg0..
	defb 007h,045h,054h,095h,09bh,06ah,067h,068h,066h,006h,047h,054h,09bh,066h,06bh,068h	; 7a4b  .ET..jghf.GT.fkh
	defb 069h,069h,002h,047h,052h,0abh,0a7h,068h,067h,066h,069h,066h,031h,00ch,00ah,008h	; 7a5b  ii.GR..hgfif1...
	defb 008h,043h,051h,09bh,030h,068h,069h,030h,067h,068h,067h,098h,0b0h,0a9h,0a5h,031h	; 7a6b  .CQ.0hi0ghg....1
	defb 00ch,00ah,008h,008h,0abh,0a7h,031h,069h,066h,030h,06ah,069h,098h,095h,052h,0b0h	; 7a7b  ......1if0ji..R.
	defb 0b0h,0a9h,0a5h,031h,034h,067h,030h,06bh,030h,0b2h,057h,099h,030h,033h,068h,030h	; 7a8b  ...14g0k0.W.03h0
	defb 066h,031h,0a6h,0aah,056h,0b3h,030h,033h,069h,030h,067h,033h,09ah,054h,0abh,0a7h	; 7a9b  f1..V.03i0g3.T..
	defb 030h,032h,0eeh,0e9h,0eah,0f6h,00dh,032h,068h,0a6h,0aah,0b1h,0b1h,09bh,032h,032h	; 7aab  02.....2h.....22
	defb 0efh,0ebh,0ebh,0f7h,031h,00dh,030h,069h,037h,003h,03fh,032h,040h,007h,007h,007h	; 7abb  ....1.0i7.?2@...
	defb 003h,03eh,044h,007h,007h,007h,007h,003h,039h,049h,003h,038h,021h,032h,030h,038h	; 7acb  .>D.....9I.8!208
	defb 079h,094h,0b5h,043h,0abh,0adh,0adh,0aah,04bh,042h,09bh,068h,066h,031h,0a6h,0aah	; 7adb  y..C....KB.hf1..
	defb 042h,00eh,045h,040h,095h,09bh,030h,069h,067h,031h,0f8h,0f9h,09ah,095h,040h,00fh	; 7aeb  B.E@..0ig1....@.
	defb 045h,040h,0a3h,030h,0c2h,0c3h,031h,068h,030h,0f8h,0f9h,09ah,045h,00eh,040h,040h	; 7afb  E@.0..1h0...E.@@
	defb 0afh,0c6h,0ddh,0deh,0dfh,0c7h,069h,066h,06ah,031h,09ah,095h,042h,095h,00fh,040h	; 7b0b  ......ifj1..B..@
	defb 040h,0a1h,0cah,0e0h,0e1h,0e2h,0cbh,066h,067h,06bh,032h,0a6h,0aah,0b1h,043h,041h	; 7b1b  @......fgk2...CA
	defb 099h,0c2h,0bdh,0c3h,06ah,067h,068h,032h,086h,087h,030h,068h,0a6h,0aah,0b1h,0b1h	; 7b2b  ....jgh2..0h....
	defb 042h,0a9h,0a5h,030h,06bh,030h,069h,031h,07ah,078h,078h,07bh,069h,030h,068h,031h	; 7b3b  B..0k0i1zxx{i0h1
	defb 0adh,0aah,0b1h,0b1h,040h,0b0h,0b0h,0a9h,0a5h,031h,07ch,078h,078h,07dh,06ah,068h	; 7b4b  ....@....1|xx}jh
	defb 069h,066h,030h,030h,06ah,068h,030h,0a6h,0aah,0b1h,0b1h,041h,0a9h,0a5h,088h,089h	; 7b5b  if00jh0....A....
	defb 066h,06bh,069h,06ah,067h,030h,066h,06bh,069h,086h,08eh,087h,066h,066h,0a6h,0aah	; 7b6b  fkijg0fki...ff..
	defb 0b1h,040h,0a9h,0a5h,067h,030h,066h,06bh,068h,030h,067h,066h,030h,092h,062h,078h	; 7b7b  .@..g0fkh0gf0.bx
	defb 067h,067h,068h,030h,06ah,0a6h,0aah,040h,0b0h,0a5h,067h,030h,069h,030h,06ah,067h	; 7b8b  ggh0j..@..g0i0jg
	defb 066h,084h,063h,060h,07fh,0c8h,069h,066h,06bh,068h,066h,0a6h,0aah,040h,0a5h,032h	; 7b9b  f.c`..ifkhf..@.2
	defb 06bh,068h,067h,0c6h,084h,061h,083h,0ceh,0d1h,067h,066h,069h,067h,06ah,066h,0a6h	; 7bab  khg..a...gfigjf.
	defb 040h,0a9h,031h,068h,069h,068h,0ceh,0d1h,078h,078h,07bh,0cah,066h,067h,06ah,068h	; 7bbb  @.1hih..xx{.fgjh
	defb 06bh,067h,068h,0a6h,040h,0a9h,0a5h,069h,066h,069h,066h,0ceh,0cfh,078h,078h,08bh	; 7bcb  kgh.@..ifif..xx.
	defb 067h,06ah,06bh,069h,066h,06ah,069h,030h,0a6h,0aah,040h,030h,067h,030h,067h,066h	; 7bdb  gjkifji0..@0g0gf
	defb 030h,07ch,078h,078h,093h,06bh,066h,06ah,067h,06bh,066h,032h,0a6h,0bfh,0bdh,0b8h	; 7beb  0|xx.kfjgkf2....
	defb 030h,067h,068h,066h,07ch,08ch,07dh,030h,067h,06bh,031h,067h,033h,051h,0b4h,0bdh	; 7bfb  0ghf|.}0gk1g3Q..
	defb 0d1h,069h,067h,06ah,068h,03ah,050h,076h,074h,051h,0bfh,0d1h,06bh,069h,066h,036h	; 7c0b  .igjh:PvtQ..kif6
	defb 0f8h,0f9h,030h,050h,077h,075h,053h,0bfh,0b8h,067h,036h,00dh,031h,058h,0b8h,033h	; 7c1b  ..0PwuS..g6.1X.3
	defb 0f0h,0e9h,0eah,0f4h,00dh,030h,055h,072h,051h,0bch,033h,0f1h,0ebh,0ebh,0f5h,031h	; 7c2b  .....0UrQ.3....1
	defb 058h,0bah,039h,021h,033h,034h,032h,094h,079h,0b0h,03fh,033h,031h,0abh,0adh,0aah	; 7c3b  X.9!342.y.?31...
	defb 030h,0abh,0adh,0aah,030h,0abh,0aah,037h,030h,0a3h,0ddh,0deh,0dfh,0a2h,09dh,0c8h	; 7c4b  0...0..70.......
	defb 09ch,0a3h,0c9h,09ch,030h,0adh,035h,030h,0a1h,0e0h,0e1h,0e2h,0a0h,0afh,0cbh,0a0h	; 7c5b  ....0.50........
	defb 0afh,0cah,0a0h,0a3h,0c7h,0a2h,030h,0b1h,032h,031h,099h,040h,066h,09ah,09fh,040h	; 7c6b  ......0.21.@f..@
	defb 09ah,09fh,068h,09ah,09fh,0cbh,0a0h,0a3h,0c8h,0a2h,031h,032h,09dh,067h,07ah,078h	; 7c7b  ..h.......12.gzx
	defb 060h,08bh,087h,069h,042h,09ah,09fh,0cah,0aeh,031h,030h,095h,030h,0afh,068h,08ch	; 7c8b  `..iB....10.0.h.
	defb 060h,061h,060h,078h,087h,0cch,0bdh,0bfh,0d1h,041h,0a0h,031h,032h,0a1h,069h,066h	; 7c9b  `a`x.....A.12.if
	defb 067h,068h,067h,060h,078h,07bh,0b9h,0b5h,0b5h,0d1h,06eh,0b2h,031h,033h,099h,067h	; 7cab  ghg`x{....n.13.g
	defb 066h,069h,066h,067h,078h,060h,07bh,0b9h,0b5h,0bch,06fh,0b2h,031h,034h,09dh,067h	; 7cbb  fifgx`{...o.14.g
	defb 068h,067h,068h,07ch,061h,078h,07fh,0bbh,0bch,09ch,032h,032h,095h,030h,0a1h,068h	; 7ccb  hgh|ax....22.0.h
	defb 069h,066h,069h,066h,084h,078h,083h,0b9h,0bah,0a0h,030h,095h,030h,034h,0b3h,069h	; 7cdb  ifif.x....0.04.i
	defb 066h,067h,068h,067h,090h,078h,062h,040h,09ch,030h,095h,031h,034h,0a3h,066h,067h	; 7ceb  fghg.xb@.0.14.fg
	defb 068h,069h,068h,090h,078h,063h,06eh,0a0h,033h,030h,00eh,032h,0afh,067h,06ah,069h	; 7cfb  hih.xcn.30.2.gji
	defb 066h,069h,082h,078h,085h,06fh,0b2h,033h,095h,00fh,032h,09fh,068h,06bh,068h,067h	; 7d0b  fi.x.o.3..2.hkhg
	defb 07eh,078h,085h,06eh,09ch,034h,033h,0b3h,066h,069h,068h,069h,040h,082h,078h,081h	; 7d1b  ~x.n.43.fihi@.x.
	defb 06fh,0a0h,095h,033h,032h,095h,0a3h,067h,066h,069h,040h,07ah,078h,085h,06eh,09ch	; 7d2b  o..32..gfi@zx.n.
	defb 035h,033h,09fh,040h,067h,040h,080h,078h,08dh,081h,06fh,0a0h,035h,032h,0a3h,045h	; 7d3b  53.@g@.x..o.52.E
	defb 06ch,06eh,09ch,032h,00eh,032h,032h,0afh,040h,0eeh,0e9h,0eah,0f6h,040h,06dh,06fh	; 7d4b  ln.2.22.@....@mo
	defb 0a0h,032h,00fh,095h,031h,032h,0a1h,040h,0efh,0ebh,0ebh,0f7h,041h,098h,097h,036h	; 7d5b  .2..12.@....A..6
	defb 032h,095h,0a9h,0a5h,042h,0a4h,0a8h,038h,030h,097h,033h,052h,034h,095h,034h,03fh	; 7d6b  2...B..80.3R4.4?
	defb 033h,021h,033h,033h,035h,094h,079h,000h,068h,041h,0cch,0d1h,068h,040h,066h,044h	; 7d7b  3!335.y.hA..h@fD
	defb 006h,055h,069h,0e3h,0e4h,0e5h,0cbh,069h,07ah,061h,078h,078h,08bh,087h,040h,00ch	; 7d8b  .Ui....izaxx..@.
	defb 00ah,054h,099h,0e6h,0e7h,0e8h,040h,066h,07ch,078h,078h,060h,062h,078h,08bh,087h	; 7d9b  .T....@f|xx`bx..
	defb 040h,002h,053h,030h,0b0h,0a9h,0ach,0a5h,067h,041h,06eh,067h,063h,060h,078h,078h	; 7dab  @.S0....gAngc`xx
	defb 08bh,087h,002h,052h,031h,095h,031h,0b0h,0a9h,0a5h,06fh,040h,06eh,069h,08ch,060h	; 7dbb  ...R1.1...o@ni.`
	defb 078h,078h,07fh,002h,051h,030h,00eh,035h,0a9h,0a5h,06fh,040h,06eh,069h,060h,078h	; 7dcb  xx..Q0.5..o@ni`x
	defb 083h,066h,006h,050h,030h,00fh,037h,0a9h,0a5h,06fh,06eh,067h,078h,093h,067h,002h	; 7ddb  .f.P0.7..ongx.g.
	defb 050h,037h,095h,032h,099h,06fh,040h,084h,078h,07fh,040h,002h,03ch,099h,040h,07ch	; 7deb  P7.2.o@.x.@.<.@|
	defb 078h,091h,066h,040h,039h,095h,031h,097h,09dh,0c6h,078h,081h,067h,068h,03dh,0a1h	; 7dfb  x.f@9.1...x.gh=.
	defb 0cah,093h,066h,040h,069h,03ch,095h,0b3h,07eh,093h,067h,066h,040h,03dh,0a3h,082h	; 7e0b  ..f@i<..~.gf@=..
	defb 093h,0c7h,067h,06ah,033h,00eh,037h,096h,09fh,092h,093h,0cbh,068h,06bh,033h,00fh	; 7e1b  ..gj3.7.....hk3.
	defb 031h,095h,033h,0abh,0a7h,07ah,060h,093h,066h,069h,040h,037h,0b1h,0abh,0adh,0a7h	; 7e2b  1.3..z`.fi@7....
	defb 086h,08ah,078h,061h,062h,067h,041h,030h,095h,032h,0abh,0adh,0a7h,086h,08eh,08ah	; 7e3b  ..xabgA0.2......
	defb 078h,078h,078h,060h,060h,069h,041h,0a4h,032h,0abh,0a7h,040h,086h,08ah,078h,078h	; 7e4b  xxx``iA.2..@..xx
	defb 078h,078h,078h,062h,061h,067h,041h,098h,030h,031h,09bh,041h,080h,078h,078h,078h	; 7e5b  xxxbagA.01.A.xxx
	defb 060h,078h,062h,060h,069h,041h,0a4h,0a8h,00eh,030h,030h,0a3h,043h,092h,078h,078h	; 7e6b  `xb`iA...00.C.xx
	defb 061h,060h,069h,067h,041h,098h,095h,030h,00fh,030h,030h,09fh,0eeh,0e9h,0eah,0f6h	; 7e7b  a`igA..0.00.....
	defb 08ch,08dh,08fh,089h,067h,041h,0a4h,0a8h,095h,030h,00eh,031h,0b3h,040h,0efh,0ebh	; 7e8b  ....gA...0.1.@..
	defb 0ebh,0f7h,043h,00dh,0a4h,0a8h,033h,00fh,031h,030h,0a9h,0a5h,045h,0a4h,0a8h,038h	; 7e9b  ..C...3.10..E..8
	defb 031h,095h,0a9h,0ach,0ach,0ach,0ach,0a8h,032h,095h,036h,021h,035h,035h,030h,079h	; 7eab  1.......2.6!550y
	defb 094h,000h,03fh,031h,098h,040h,039h,068h,068h,033h,0a4h,0a8h,040h,09bh,037h,06ah	; 7ebb  ..?1.@9hh3..@.7j
	defb 066h,067h,069h,0a4h,0ach,0a8h,0b0h,0b1h,0abh,0a7h,030h,036h,066h,06bh,067h,0a4h	; 7ecb  fgi.......06fkg.
	defb 0a8h,040h,0b1h,0abh,0a7h,066h,032h,034h,068h,066h,067h,030h,098h,040h,0abh,0a7h	; 7edb  .@...f24hfg0.@..
	defb 032h,067h,068h,031h,033h,066h,069h,067h,030h,098h,040h,09bh,0c2h,0cch,0bdh,0bfh	; 7eeb  2gh13fig0.@.....
	defb 0b8h,030h,069h,031h,032h,06ah,067h,068h,068h,09ch,095h,0a3h,0d9h,0d8h,0dah,0b9h	; 7efb  .0i12jghh.......
	defb 0b5h,0bch,066h,032h,032h,06bh,06ah,069h,06bh,0a0h,040h,0a1h,0dbh,0d7h,0dch,0b7h	; 7f0b  ..f22kjik.@.....
	defb 0b5h,0bah,067h,032h,032h,066h,06bh,066h,030h,0b2h,041h,0a9h,0a5h,0cch,0b5h,0bah	; 7f1b  ..g22fkf0.A.....
	defb 030h,0a4h,0a8h,0b0h,0b0h,031h,068h,067h,06ah,067h,09ch,040h,0abh,0aah,040h,095h	; 7f2b  0....1hgjg.@..@.
	defb 0a9h,0ach,0ach,0a8h,043h,031h,069h,068h,06bh,030h,0a0h,0a3h,030h,068h,09ah,048h	; 7f3b  ....C1ihk0..0h.H
	defb 032h,069h,030h,098h,040h,09fh,066h,069h,066h,09ah,040h,095h,045h,032h,0a4h,0a8h	; 7f4b  2i0.@.fif.@.E2..
	defb 040h,09bh,066h,067h,066h,067h,068h,09ah,046h,031h,098h,040h,0abh,0a7h,068h,067h	; 7f5b  @.fgfgh.F1.@..hg
	defb 06ah,067h,068h,069h,030h,0a6h,0aah,040h,095h,042h,0a4h,0a8h,0abh,0a7h,031h,069h	; 7f6b  jghi0..@.B....1i
	defb 030h,06bh,068h,069h,030h,066h,030h,066h,09ah,043h,095h,09bh,034h,068h,030h,069h	; 7f7b  0khi0f0f.C..4h0i
	defb 068h,066h,067h,030h,067h,068h,0a6h,0aah,0b1h,0b1h,09bh,035h,069h,031h,069h,067h	; 7f8b  hfg0gh.....5i1ig
	defb 032h,069h,033h,038h,068h,031h,0f0h,0e9h,0eah,0f4h,033h,038h,069h,031h,0f1h,0ebh	; 7f9b  2i38h1....38i1..
	defb 0ebh,0f5h,033h,03ah,00dh,037h,038h,06ah,031h,00dh,034h,004h,007h,038h,06bh,033h	; 7fab  ..3:.78j1.4..8k3
	defb 004h,007h,007h,007h,051h,03ch,004h,055h,03ch,006h,055h,021h,031h,037h,030h,079h	; 7fbb  ....Q<.U<.U!170y
	defb 069h,094h,054h,09bh,03dh,051h,00eh,050h,0b3h,030h,066h,066h,066h,066h,066h,066h	; 7fcb  i.T.=Q.P.0ffffff
	defb 066h,066h,035h,051h,00fh,095h,050h,09dh,047h,066h,034h,054h,0a1h,030h,068h,068h	; 7fdb  ff5Q..P.Gf4T.0hh
	defb 068h,068h,032h,067h,066h,033h,051h,0b1h,0b1h,0b1h,050h,099h,043h,0cch,0d1h,030h	; 7feb  hh2gf3Q...P.C..0
	defb 066h,067h,033h,0abh,0a7h,031h,0a6h,0aah,050h,0b0h,09dh,0ddh,0deh,0dfh,0cbh,030h	; 7ffb  fg3..1..P......0
	defb 067h,068h,033h,034h,066h,09ah,050h,0a1h,0e0h,0e1h,0e2h,031h,066h,040h,033h,033h	; 800b  gh34f.P....1f@33
	defb 06ah,067h,030h,09ah,050h,0b0h,0b0h,0b0h,0a9h,0a5h,067h,030h,068h,032h,032h,068h	; 801b  jg0.P.....g0h22h
	defb 06bh,086h,08eh,087h,0a6h,0adh,0adh,0adh,0aah,050h,0a9h,0a5h,040h,032h,031h,06ah	; 802b  k........P..@21j
	defb 040h,082h,078h,078h,08dh,030h,066h,031h,066h,09ah,051h,09dh,032h,030h,06ah,06bh	; 803b  @.xx.0f1f.Q.20jk
	defb 07ah,078h,08dh,089h,030h,066h,067h,030h,066h,067h,098h,050h,095h,09fh,032h,030h	; 804b  zx..0fg0fg.P..20
	defb 06bh,07eh,078h,085h,0b7h,0b8h,066h,067h,030h,066h,067h,098h,050h,0abh,0a7h,033h	; 805b  k~x...fg0fg.P..3
	defb 030h,06ah,082h,078h,091h,0bbh,0bch,067h,030h,066h,067h,09ch,095h,050h,0a9h,0ach	; 806b  0j.x...g0fg..P..
	defb 0a5h,032h,030h,06bh,078h,078h,083h,0cbh,0bah,030h,068h,067h,030h,0a6h,0aah,0b1h	; 807b  .20kxx...0hg0...
	defb 0b1h,0b1h,050h,099h,031h,068h,07eh,078h,078h,060h,08bh,087h,066h,040h,068h,068h	; 808b  ..P.1h~xx`..f@hh
	defb 068h,068h,068h,066h,066h,09ah,095h,09dh,030h,040h,090h,078h,078h,061h,078h,078h	; 809b  hhhff...0@.xxaxx
	defb 063h,07bh,046h,068h,0b2h,0a1h,030h,030h,07ch,078h,078h,078h,078h,078h,078h,085h	; 80ab  c{Fh..00|xxxxxx.
	defb 0d0h,0cch,0cfh,033h,040h,0a2h,050h,099h,031h,088h,060h,060h,078h,078h,08dh,0b7h	; 80bb  ...3@.P.1.``xx..
	defb 0bch,066h,030h,066h,066h,066h,066h,066h,09eh,050h,095h,032h,067h,067h,032h,0b9h	; 80cb  .f0fffff.P.2gg2.
	defb 0bah,067h,030h,067h,067h,067h,067h,067h,030h,09ah,050h,030h,06ch,06eh,030h,06eh	; 80db  .g0ggggg0.P0ln0n
	defb 03dh,09ah,030h,06dh,06fh,030h,06fh,031h,06ch,06eh,03ah,031h,0f8h,0f9h,030h,00dh	; 80eb  =.0mo0o1ln:1..0.
	defb 030h,06dh,06fh,033h,0f0h,0e9h,0eah,0f4h,032h,030h,0f8h,0f9h,032h,00dh,034h,00dh	; 80fb  0mo3....20..2.4.
	defb 0f1h,0ebh,0ebh,0f5h,032h,03fh,032h,098h,021h,033h,037h,038h,079h,094h,078h,034h	; 810b  ....2?2.!378y.x4
	defb 068h,066h,030h,068h,06ah,039h,031h,0d0h,0c1h,030h,069h,067h,066h,069h,06bh,068h	; 811b  hf0hj91..0igfikh
	defb 038h,030h,068h,0b6h,0ddh,0deh,0dfh,030h,067h,066h,068h,069h,068h,068h,036h,030h	; 812b  80h....0gfhihh60
	defb 069h,066h,0e0h,0e1h,0e2h,0c9h,030h,067h,069h,066h,069h,069h,066h,035h,030h,06ah	; 813b  if....0gifiif50j
	defb 067h,068h,066h,0cch,0cdh,07ah,062h,07bh,067h,066h,06ah,067h,068h,034h,030h,06bh	; 814b  ghf..zb{gfjgh40k
	defb 066h,069h,067h,068h,030h,092h,063h,050h,07bh,067h,06bh,068h,069h,034h,0a9h,0a5h	; 815b  figh0.cP{gkhi4..
	defb 067h,030h,068h,069h,068h,07ch,052h,07bh,066h,069h,066h,06ah,033h,041h,0a9h,030h	; 816b  g0hih|R{fifj3A.0
	defb 069h,066h,069h,066h,07ch,051h,093h,067h,066h,067h,06bh,068h,032h,042h,0a1h,030h	; 817b  ifif|Q.gfgkh2B.0
	defb 067h,068h,067h,066h,07ch,050h,093h,068h,067h,030h,068h,069h,032h,042h,0a3h,066h	; 818b  ghgf|P.hg0hi2B.f
	defb 030h,069h,068h,067h,068h,084h,085h,069h,0cch,0d1h,069h,066h,032h,042h,09fh,067h	; 819b  0ihgh..i..if2B.g
	defb 030h,066h,069h,068h,069h,066h,098h,0b0h,099h,0cbh,066h,067h,06ah,031h,041h,0a3h	; 81ab  0fihif....fgj1A.
	defb 06ch,031h,067h,066h,069h,066h,067h,0b2h,041h,099h,067h,066h,06bh,031h,041h,0afh	; 81bb  l1gfifg.A.gfk1A.
	defb 06dh,08ah,060h,08bh,067h,066h,067h,068h,0b2h,041h,0b3h,068h,067h,066h,031h,040h	; 81cb  m.`.gfgh.A.hgf1@
	defb 095h,099h,030h,08ch,061h,050h,07bh,069h,066h,069h,0b2h,041h,0b3h,069h,068h,067h	; 81db  ..0.aP{ifi.A.ihg
	defb 031h,042h,0a9h,0a5h,08ch,051h,08bh,067h,06ah,0a2h,041h,0b3h,066h,069h,032h,044h	; 81eb  1B...Q.gj.A.fi2D
	defb 099h,07ch,051h,08bh,06bh,09eh,095h,040h,0b3h,067h,066h,032h,045h,09dh,084h,051h	; 81fb  .|Q.k..@.gf2E..Q
	defb 08bh,030h,09ah,0b1h,09bh,030h,067h,032h,043h,00eh,040h,0a1h,030h,08ch,050h,08dh	; 820b  .0...0g2C.@.0.P.
	defb 038h,042h,095h,00fh,041h,099h,038h,066h,031h,047h,09dh,037h,067h,031h,046h,095h	; 821b  8B..A.8f1G.7g1F.
	defb 0a1h,030h,068h,038h,041h,00eh,044h,0b3h,030h,069h,066h,030h,0f0h,0e9h,0eah,0f4h	; 822b  .0h8A.D.0if0....
	defb 032h,040h,095h,00fh,044h,09bh,031h,067h,030h,0f1h,0ebh,0ebh,0f5h,030h,00dh,030h	; 823b  2@..D.1g0....0.0
	defb 045h,0abh,0a7h,03bh,021h,033h,035h,030h,079h,000h,007h,035h,06ah,03ch,035h,06bh	; 824b  E..;!350y..5j<5k
	defb 06ah,066h,06ah,034h,004h,053h,050h,003h,033h,068h,06bh,067h,06bh,030h,004h,052h	; 825b  jfj4.SP.3hkgk0.R
	defb 044h,041h,050h,003h,030h,066h,069h,0ddh,0deh,0dfh,004h,048h,042h,005h,030h,067h	; 826b  DAP.0fi....HB.0g
	defb 06ah,0e0h,0e1h,0e2h,006h,048h,042h,001h,030h,068h,06bh,068h,0c0h,0c1h,00ch,00ah	; 827b  j....HB.0hkh....
	defb 047h,041h,005h,030h,068h,069h,066h,069h,068h,092h,078h,07bh,006h,046h,041h,005h	; 828b  GA.0hifih.x{.FA.
	defb 030h,069h,066h,067h,066h,069h,084h,078h,078h,002h,046h,042h,003h,030h,067h,06ah	; 829b  0ifgfi.xx.FB.0gj
	defb 067h,066h,0c6h,078h,078h,07fh,006h,045h,042h,005h,030h,066h,069h,066h,067h,0ceh	; 82ab  gf.xx..EB.0fifg.
	defb 0c1h,078h,091h,006h,045h,042h,005h,068h,067h,06ah,067h,032h,08ch,081h,006h,045h	; 82bb  .x..EB.hgjg2...E
	defb 042h,001h,069h,066h,06bh,06ah,032h,066h,030h,006h,045h,041h,005h,031h,067h,068h	; 82cb  B.ifkj2f0.EA.1gh
	defb 06bh,068h,030h,068h,067h,068h,002h,045h,041h,005h,031h,06ah,069h,066h,069h,068h	; 82db  kh0hgh.EA.1jifih
	defb 069h,06ah,069h,030h,002h,008h,008h,008h,008h,001h,042h,003h,030h,06bh,030h,067h	; 82eb  iji0......B.0k0g
	defb 06ah,069h,066h,06bh,068h,036h,043h,003h,030h,066h,06ah,06bh,066h,069h,066h,069h	; 82fb  jifkh6C.0fjkfifi
	defb 068h,035h,041h,008h,008h,001h,068h,067h,06bh,068h,067h,066h,067h,066h,069h,035h	; 830b  h5A...hgkhgfgfi5
	defb 009h,00bh,032h,069h,030h,068h,069h,066h,067h,066h,067h,036h,034h,068h,030h,069h	; 831b  ..2i0hifgfg64h0i
	defb 030h,067h,030h,067h,037h,032h,066h,030h,069h,03dh,032h,067h,032h,0ech,0e9h,0eah	; 832b  0g0g72f0i=2g2...
	defb 0f2h,031h,0f8h,0f9h,034h,036h,0edh,0ebh,0ebh,0f3h,00dh,037h,03fh,033h,03fh,033h	; 833b  .1..46.....7?3?3
	defb 021h,032h,037h,039h,079h,094h,0b0h,033h,068h,039h,068h,033h,032h,068h,06bh,0a4h	; 834b  !279y..3h9h32hk.
	defb 0a8h,055h,0a5h,030h,069h,066h,032h,032h,069h,098h,095h,047h,0a9h,0a5h,069h,068h	; 835b  .U.0if22i..G..ih
	defb 031h,032h,09ch,042h,0abh,0adh,0aah,045h,099h,069h,031h,031h,066h,0a0h,041h,0a3h	; 836b  12.B...E.i11f.A.
	defb 0d9h,0d8h,0dah,0a6h,0adh,0aah,043h,09dh,031h,031h,067h,0a2h,041h,0a1h,0dbh,0d7h	; 837b  ......C.11g.A...
	defb 0dch,0c7h,066h,030h,0a2h,040h,00eh,040h,0afh,068h,030h,032h,09eh,041h,0a3h,0c0h	; 838b  ..f0.@.@.h02.A..
	defb 0cch,0c1h,0b6h,067h,068h,0aeh,040h,00fh,040h,0afh,069h,030h,032h,066h,0a6h,0adh	; 839b  ...gh.@.@.i02f..
	defb 0a7h,066h,08ah,08bh,087h,030h,069h,0aeh,042h,0afh,066h,030h,032h,069h,066h,086h	; 83ab  .f...0i.B.f02if.
	defb 08ah,061h,078h,060h,060h,068h,030h,0a0h,042h,09fh,067h,030h,032h,06ah,067h,088h	; 83bb  .ax``h0.B.g02jg.
	defb 08ch,078h,07dh,067h,069h,06bh,098h,095h,041h,09bh,032h,031h,066h,06bh,031h,0a4h	; 83cb  .x}gik..A.21fk1.
	defb 0a8h,053h,042h,09bh,066h,032h,031h,067h,068h,031h,0a0h,046h,0a3h,068h,067h,032h	; 83db  .SB.f21gh1.F.hg2
	defb 032h,069h,031h,09ah,0abh,0adh,0aah,0b1h,095h,041h,0a1h,069h,033h,030h,0f8h,0f9h	; 83eb  2i1......A.i30..
	defb 033h,066h,031h,066h,0a6h,0aah,041h,099h,033h,031h,0f8h,0f9h,031h,068h,067h,031h	; 83fb  3f1f..A.31..1hg1
	defb 067h,068h,030h,0a2h,040h,095h,099h,032h,035h,069h,033h,06bh,068h,09eh,042h,09dh	; 840b  gh0.@..25i3kh.B.
	defb 031h,030h,09ch,052h,099h,031h,0ech,0e9h,0eah,0f4h,069h,030h,0b2h,041h,0a1h,031h	; 841b  10.R.1....i0.A.1
	defb 030h,0a0h,040h,00eh,041h,09dh,030h,0edh,0ebh,0ebh,0f5h,030h,09ch,095h,041h,095h	; 842b  0.@.A.0....0..A.
	defb 068h,030h,030h,0b2h,040h,00fh,00eh,040h,0a1h,035h,0a0h,042h,0a3h,069h,030h,030h	; 843b  h00.@..@.5.B.i00
	defb 09ah,041h,00fh,041h,099h,033h,098h,095h,042h,09fh,066h,030h,031h,09ah,044h,053h	; 844b  .A.A.3..B.f01.DS
	defb 043h,09bh,066h,067h,030h,032h,09ah,04ah,09bh,030h,067h,031h,033h,0a6h,0aah,0b1h	; 845b  C.fg02.J.0g13...
	defb 0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0abh,0a7h,034h,03fh,033h,021h,031h,038h,035h,000h	; 846b  ........4?3!185.
	defb 079h,0b5h,035h,003h,043h,068h,040h,066h,041h,0c2h,0c3h,040h,098h,036h,003h,041h	; 847b  y.5.Ch@fA..@.6.A
	defb 068h,069h,066h,067h,0c6h,0e3h,0e4h,0e5h,09ch,094h,036h,005h,040h,068h,069h,066h	; 848b  hifg......6.@hif
	defb 067h,040h,0cah,0e6h,0e7h,0e8h,0a0h,094h,037h,003h,069h,06ah,067h,040h,0a4h,0ach	; 849b  g@......7.ijg@..
	defb 0a8h,0b0h,0b0h,094h,094h,037h,005h,06ah,06bh,040h,098h,094h,094h,094h,094h,094h	; 84ab  .....7.jk@......
	defb 094h,094h,037h,005h,06bh,040h,098h,094h,094h,094h,094h,094h,094h,094h,094h,037h	; 84bb  ..7.k@.........7
	defb 005h,066h,09ch,094h,094h,094h,094h,094h,094h,094h,094h,094h,037h,001h,067h,0aeh	; 84cb  .f..........7.g.
	defb 094h,094h,094h,0abh,0aah,094h,094h,094h,09bh,036h,001h,086h,087h,09eh,094h,094h	; 84db  .........6......
	defb 09bh,0b7h,0b8h,0a6h,0adh,0a7h,0b7h,035h,001h,07ah,078h,093h,040h,0a6h,0a7h,0b7h	; 84eb  .......5.zx.@...
	defb 076h,072h,0bdh,0bdh,0bfh,050h,034h,001h,07ah,078h,078h,07dh,0b7h,0bfh,0bdh,050h	; 84fb  vr...P4.zxx}...P
	defb 077h,050h,074h,072h,070h,050h,033h,001h,07ah,060h,078h,07dh,0b7h,073h,076h,072h	; 850b  wPtrpP3.z`x}.svr
	defb 076h,073h,074h,075h,050h,071h,050h,032h,005h,07eh,078h,061h,07dh,0b7h,073h,072h	; 851b  vstuPqP2.~xa}.sr
	defb 077h,070h,077h,074h,075h,050h,074h,051h,032h,005h,082h,078h,07dh,0b7h,073h,074h	; 852b  wpwtuPtQ2..x}.st
	defb 050h,070h,071h,050h,075h,050h,070h,075h,051h,032h,001h,092h,085h,0b7h,074h,076h	; 853b  PpqPuPpuQ2....tv
	defb 075h,074h,071h,074h,052h,071h,052h,030h,009h,00bh,07ah,060h,091h,0bbh,075h,077h	; 854b  utqtRqR0..z`..uw
	defb 050h,075h,076h,075h,056h,001h,040h,07ah,078h,061h,083h,0b9h,0beh,052h,077h,057h	; 855b  PuvuV.@zxa...RwW
	defb 066h,07eh,078h,078h,078h,078h,08bh,066h,0b9h,0beh,051h,074h,073h,055h,067h,080h	; 856b  f~xxxx.f..QtsUg.
	defb 078h,078h,078h,078h,078h,063h,07fh,040h,0b9h,0beh,075h,056h,040h,068h,088h,08fh	; 857b  xxxxxc.@..uV@h..
	defb 08ch,078h,078h,078h,081h,066h,068h,040h,0b9h,0beh,0beh,0beh,0beh,0beh,0beh,0beh	; 858b  .xxx.fh@........
	defb 040h,069h,066h,040h,068h,088h,08fh,089h,06ah,067h,069h,06ah,047h,041h,067h,068h	; 859b  @if@h...jgijGAgh
	defb 069h,066h,068h,066h,06bh,041h,06bh,066h,041h,0f0h,0e9h,0eah,0f4h,040h,042h,069h	; 85ab  ifhfkAkfA....@Bi
	defb 040h,067h,069h,067h,043h,067h,041h,0f1h,0ebh,0ebh,0f5h,040h,04fh,043h,021h,035h	; 85bb  @gigCgA....@OC!5
	defb 032h,032h,094h,079h,078h,040h,068h,041h,068h,066h,066h,040h,06ah,044h,06ah,044h	; 85cb  22.yx@hAhff@jDjD
	defb 068h,069h,0f8h,0f9h,069h,067h,067h,040h,06bh,041h,068h,040h,068h,06bh,068h,043h	; 85db  hi..igg@kAh@hkhC
	defb 069h,066h,040h,00dh,00dh,040h,0a4h,0a8h,0b0h,099h,066h,069h,066h,069h,068h,069h	; 85eb  if@..@....fifihi
	defb 066h,040h,068h,040h,040h,067h,00dh,0c2h,0c3h,09ch,032h,09bh,067h,066h,067h,040h	; 85fb  f@h@@g....2.gfg@
	defb 069h,040h,067h,068h,069h,040h,003h,040h,0ddh,0deh,0dfh,0aeh,095h,030h,0a3h,08ah	; 860b  i@ghi@.@.....0..
	defb 050h,061h,052h,08bh,087h,069h,066h,040h,000h,003h,0e0h,0e1h,0e2h,0a0h,031h,0a1h	; 861b  PaR..if@......1.
	defb 08ch,056h,07bh,067h,068h,000h,000h,003h,040h,098h,00eh,032h,099h,0c2h,0bdh,0d1h	; 862b  .V{gh...@..2....
	defb 084h,051h,060h,050h,07fh,069h,000h,000h,005h,09ch,030h,00fh,033h,099h,0b9h,0b5h	; 863b  .Q`P.i....0.3...
	defb 0d1h,084h,050h,061h,050h,091h,040h,000h,000h,005h,0aeh,095h,034h,095h,099h,0b9h	; 864b  ..PaP.@.....4...
	defb 0bch,080h,052h,091h,066h,000h,000h,005h,0aeh,037h,099h,0ceh,0cfh,092h,051h,081h	; 865b  ..R.f....7....Q.
	defb 067h,000h,000h,005h,0aeh,038h,099h,040h,084h,050h,085h,068h,040h,000h,000h,001h	; 866b  g....8.@.P.h@...
	defb 0a0h,039h,0a9h,0a5h,041h,069h,040h,000h,001h,098h,038h,00eh,032h,0a9h,0a5h,041h	; 867b  .9..Ai@...8.2..A
	defb 001h,098h,031h,00eh,036h,00fh,034h,0b0h,0a9h,09ch,032h,00fh,031h,0abh,0adh,0aah	; 868b  ..1.6.4...2.1...
	defb 039h,0aeh,033h,0abh,0a7h,066h,068h,040h,09ah,038h,0aeh,032h,09bh,0f8h,0f9h,067h	; 869b  9.3..fh@.8.2...g
	defb 069h,0a4h,0a8h,038h,09eh,095h,031h,0a9h,0ach,0ach,0a8h,0b0h,034h,0b1h,0b1h,0b1h	; 86ab  i..8..1.....4...
	defb 032h,040h,0a2h,039h,0abh,0a7h,066h,041h,0a6h,0aah,030h,040h,09eh,0b1h,037h,09bh	; 86bb  2@.9..fA..0@..7.
	defb 066h,068h,067h,041h,068h,040h,09ah,041h,068h,0a6h,0aah,0b1h,0b1h,0b1h,0abh,0adh	; 86cb  fhgAh@.Ah.......
	defb 0a7h,068h,067h,069h,042h,069h,041h,003h,040h,069h,06ah,066h,040h,068h,041h,06ah	; 86db  .hgiBiA.@ijf@hAj
	defb 068h,069h,041h,0ech,0e9h,0eah,0f2h,041h,000h,003h,040h,06bh,067h,040h,069h,066h	; 86eb  hiA....A..@kg@if
	defb 040h,06bh,069h,041h,00dh,0edh,0ebh,0ebh,0f3h,041h,000h,000h,007h,007h,003h,041h	; 86fb  @kiA.....A.....A
	defb 067h,04bh,021h,034h,031h,038h,079h,000h,094h,03ah,066h,033h,068h,031h,004h,007h	; 870b  gK!418y..:f3h1..
	defb 003h,034h,068h,030h,066h,030h,067h,030h,0ddh,0deh,0dfh,069h,068h,004h,040h,041h	; 871b  .4h0f0g0...ih.@A
	defb 007h,003h,032h,069h,066h,067h,066h,030h,0c8h,0e0h,0e1h,0e2h,0c7h,069h,006h,040h	; 872b  ..2ifgf0.....i.@
	defb 043h,003h,031h,068h,067h,068h,067h,066h,0ceh,0cfh,030h,0c0h,0cdh,066h,006h,040h	; 873b  C.1hghgf..0..f.@
	defb 044h,003h,030h,069h,066h,069h,066h,067h,07ah,078h,07bh,030h,066h,067h,006h,040h	; 874b  D.0ififgzx{0fg.@
	defb 044h,005h,031h,067h,068h,067h,07ah,078h,078h,085h,066h,067h,068h,002h,040h,044h	; 875b  D.1ghgzxx.fgh.@D
	defb 005h,031h,066h,069h,07ah,078h,078h,078h,081h,067h,066h,069h,030h,006h,044h,001h	; 876b  .1fizxxx.gfi0.D.
	defb 030h,068h,067h,07ah,078h,078h,078h,07dh,068h,030h,067h,066h,030h,006h,043h,001h	; 877b  0hgzxxx}h0gf0.C.
	defb 030h,066h,069h,07eh,078h,060h,078h,07dh,066h,069h,066h,066h,067h,030h,006h,042h	; 878b  0fi~x`x}fiffg0.B
	defb 005h,030h,066h,067h,066h,082h,078h,061h,085h,066h,067h,066h,067h,067h,030h,004h	; 879b  .0fgf.xa.fgfgg0.
	defb 040h,042h,001h,030h,067h,068h,067h,078h,078h,078h,0c7h,067h,068h,067h,066h,030h	; 87ab  @B.0ghgxxx.ghgf0
	defb 004h,041h,041h,001h,031h,066h,069h,066h,078h,078h,078h,0bbh,068h,069h,066h,067h	; 87bb  .AA.1fifxxx.hifg
	defb 066h,006h,041h,040h,005h,032h,067h,066h,067h,062h,078h,078h,0cbh,069h,06ah,067h	; 87cb  f.A@.2gfgbxx.ijg
	defb 066h,067h,002h,041h,009h,00bh,033h,067h,068h,063h,078h,078h,07bh,066h,06bh,066h	; 87db  fg.A..3ghcxx{fkf
	defb 067h,066h,030h,002h,040h,032h,06ch,06eh,030h,068h,069h,060h,078h,078h,093h,067h	; 87eb  gf0.@2ln0hi`xx.g
	defb 066h,067h,066h,067h,066h,031h,032h,06dh,06fh,030h,069h,066h,061h,078h,078h,093h	; 87fb  fgfgf12mo0ifaxx.
	defb 068h,067h,066h,067h,066h,067h,068h,030h,0a4h,0a8h,0b0h,0b0h,0b0h,099h,030h,067h	; 880b  hgfgfgh0......0g
	defb 07ch,078h,078h,093h,069h,068h,067h,066h,067h,066h,069h,030h,055h,0a9h,0a5h,030h	; 881b  |xx.ihgfgfi0U..0
	defb 07ch,078h,078h,07bh,069h,030h,067h,066h,067h,031h,051h,00eh,054h,099h,030h,088h	; 882b  |xx{i0gfg1Q.T.0.
	defb 08ch,07dh,032h,067h,066h,031h,051h,00fh,054h,0b3h,037h,067h,031h,055h,0b1h,0abh	; 883b  .}2gf1Q.T.7g1U..
	defb 0a7h,03ah,051h,0b1h,0b1h,0abh,0a7h,030h,0f8h,0f9h,031h,00dh,030h,0f0h,0e9h,0eah	; 884b  .:Q....0..1.0...
	defb 0f4h,032h,0abh,0a7h,032h,0f8h,0f9h,035h,0f1h,0ebh,0ebh,0f5h,032h,03fh,033h,021h	; 885b  .2..2..5....2?3!
	defb 033h,036h,030h,094h,079h,0b1h,04fh,040h,09ah,031h,043h,066h,042h,068h,044h,0f8h	; 886b  360.y.O@.1CfBhD.
	defb 0f9h,041h,0a2h,030h,043h,067h,041h,068h,069h,040h,068h,040h,066h,044h,09eh,030h	; 887b  .A.0CgAhi@h@fD.0
	defb 046h,069h,040h,066h,069h,068h,067h,066h,041h,06ch,06eh,040h,0b2h,0a5h,042h,068h	; 888b  Fi@fihgfAln@..Bh
	defb 042h,068h,067h,066h,069h,066h,067h,040h,066h,06dh,06fh,09ch,030h,030h,0a9h,0a5h	; 889b  Bhgfifg@fmo.00..
	defb 040h,069h,066h,041h,069h,040h,067h,066h,067h,040h,066h,067h,040h,06eh,0a0h,030h	; 88ab  @ifAi@gfg@fg@n.0
	defb 032h,099h,040h,067h,066h,040h,0c2h,0c3h,040h,067h,040h,06ah,067h,068h,040h,06fh	; 88bb  2.@gf@..@g@jgh@o
	defb 0b2h,030h,033h,0a9h,0a5h,067h,066h,0d9h,0d8h,0dah,040h,068h,06bh,066h,069h,06eh	; 88cb  .03..gf...@hkfin
	defb 040h,0b2h,095h,035h,099h,067h,0dbh,0d7h,0dch,0c9h,069h,040h,067h,040h,06fh,098h	; 88db  @..5.g....i@g@o.
	defb 031h,095h,034h,095h,099h,041h,0c0h,0cdh,040h,098h,0b0h,0b0h,0b0h,030h,095h,030h	; 88eb  1.4..A..@....0.0
	defb 032h,00eh,033h,0b0h,0b0h,0b0h,0b0h,09dh,0a2h,035h,032h,00fh,036h,095h,0a1h,09eh	; 88fb  2.3......52.6...
	defb 095h,031h,00eh,031h,036h,00eh,034h,09dh,0a2h,031h,00fh,031h,036h,00fh,095h,033h	; 890b  .1.16.4..1.16..3
	defb 0a1h,09eh,034h,03dh,09dh,0a2h,033h,030h,095h,03bh,0a1h,09eh,033h,034h,058h,09bh	; 891b  ..4=..30.;..34X.
	defb 040h,09ah,051h,030h,031h,0abh,0adh,0a7h,040h,066h,040h,066h,068h,040h,066h,043h	; 892b  @.Q01...@f@fh@fC
	defb 066h,040h,066h,09ah,0abh,0a7h,06ch,041h,068h,067h,066h,067h,069h,068h,067h,043h	; 893b  f@f...lAhgfgihgC
	defb 067h,068h,067h,040h,040h,06ch,06dh,041h,069h,066h,067h,068h,066h,069h,040h,0f0h	; 894b  ghg@@lmAifghfi@.
	defb 0e9h,0eah,0f4h,040h,069h,068h,040h,040h,06dh,042h,066h,067h,066h,069h,067h,06ah	; 895b  ...@ih@@mBfgfigj
	defb 068h,0f1h,0ebh,0ebh,0f5h,040h,06ah,069h,040h,044h,067h,068h,067h,068h,066h,06bh	; 896b  h....@ji@Dghghfk
	defb 069h,044h,06bh,041h,045h,069h,040h,069h,067h,045h,00dh,042h,04fh,043h,021h,031h	; 897b  iDkAEi@igE.BOC!1
	defb 039h,036h,079h,000h,094h,036h,098h,09bh,039h,004h,032h,0d0h,0c5h,0c2h,0c3h,09ah	; 898b  96y..6..9.2.....
	defb 099h,068h,033h,004h,007h,007h,007h,007h,040h,031h,066h,0b6h,0ddh,0deh,0dfh,030h	; 899b  .h3.....@1f....0
	defb 050h,069h,066h,068h,031h,002h,008h,043h,030h,066h,067h,0c6h,0e0h,0e1h,0e2h,098h	; 89ab  Pifh1..C0fg.....
	defb 09bh,066h,067h,069h,066h,032h,002h,042h,030h,067h,066h,0ceh,0cfh,098h,0b0h,09bh	; 89bb  .fgif2.B0gf.....
	defb 030h,067h,066h,066h,067h,068h,032h,006h,041h,030h,068h,067h,066h,098h,050h,09bh	; 89cb  0gffgh2.A0hgf.P.
	defb 07ah,08bh,087h,067h,067h,066h,069h,068h,031h,006h,041h,06ah,069h,066h,067h,0b2h	; 89db  z..ggfih1.Ajifg.
	defb 0b3h,030h,092h,078h,078h,07bh,066h,067h,066h,069h,06ah,030h,006h,041h,06bh,068h	; 89eb  .0.xx{fgfij0.Akh
	defb 067h,066h,0b2h,0b3h,030h,060h,078h,078h,093h,069h,066h,067h,068h,06bh,030h,006h	; 89fb  gf..0`xx.ifghk0.
	defb 041h,030h,069h,066h,067h,09ah,050h,099h,067h,060h,078h,078h,07bh,067h,066h,069h	; 8a0b  A0ifg.P.g`xx{gfi
	defb 030h,004h,042h,030h,066h,067h,066h,030h,0b2h,0b3h,068h,067h,07ch,078h,078h,0c7h	; 8a1b  0.B0fgf0..hg|xx.
	defb 067h,068h,030h,006h,042h,066h,067h,066h,067h,066h,0a2h,0b3h,069h,066h,0c6h,092h	; 8a2b  gh0.Bfgfgf..if..
	defb 078h,0cbh,066h,069h,030h,006h,042h,067h,066h,067h,066h,067h,0aeh,0b3h,066h,067h	; 8a3b  x.fi0.Bgfgfg..fg
	defb 0cah,092h,078h,07bh,067h,068h,030h,002h,042h,066h,067h,066h,067h,068h,0aeh,0b3h	; 8a4b  ..x{gh0.Bfgfgh..
	defb 067h,066h,066h,092h,078h,093h,066h,069h,06ah,030h,006h,041h,067h,066h,067h,066h	; 8a5b  gff.x.fij0.Agfgf
	defb 069h,0aeh,0b3h,030h,067h,067h,092h,078h,060h,067h,068h,06bh,030h,006h,041h,030h	; 8a6b  i..0gg.x`ghk0.A0
	defb 067h,068h,067h,066h,09eh,050h,09dh,066h,07ah,078h,078h,061h,066h,069h,06ah,030h	; 8a7b  ghgf.P.fzxxafij0
	defb 002h,041h,099h,030h,069h,066h,067h,066h,09ah,0a1h,067h,090h,078h,078h,060h,067h	; 8a8b  .A.0ifgf..g.xx`g
	defb 068h,06bh,031h,006h,040h,050h,0a9h,0a5h,067h,030h,067h,066h,09ah,099h,07ch,078h	; 8a9b  hk1.@P..g0gf..|x
	defb 060h,061h,066h,069h,032h,002h,040h,09ah,051h,0b0h,0b0h,099h,067h,06ah,09ah,099h	; 8aab  `afi2.@.Q...gj..
	defb 088h,061h,060h,067h,034h,002h,030h,09ah,053h,099h,06bh,030h,09ah,050h,099h,067h	; 8abb  .a`g4.0.S.k0.P.g
	defb 030h,066h,034h,030h,066h,09ah,0b1h,0b1h,0b1h,050h,0b0h,0b0h,099h,09ah,050h,099h	; 8acb  0f40f....P....P.
	defb 030h,067h,034h,030h,067h,066h,032h,0a6h,0aah,051h,0b0h,051h,0b0h,0a9h,0a5h,033h	; 8adb  0g40gf2..Q.Q...3
	defb 031h,067h,0eeh,0e9h,0eah,0f6h,030h,0a6h,0aah,0b1h,0b1h,0b1h,052h,0a9h,0a5h,031h	; 8aeb  1g....0.....R..1
	defb 032h,0efh,0ebh,0ebh,0f7h,035h,09ah,0b1h,0b1h,051h,099h,030h,03fh,09ah,051h,099h	; 8afb  2....5...Q.0?.Q.
	defb 021h,033h,034h,039h,079h,000h,078h,0d0h,0c1h,032h,066h,030h,006h,043h,008h,046h	; 8b0b  !349y.x..2f0.C.F
	defb 0b6h,0e3h,0e4h,0e5h,0c7h,067h,06ah,006h,041h,009h,00bh,068h,00ch,00ah,044h,099h	; 8b1b  .....gj.A..h..D.
	defb 0e6h,0e7h,0e8h,0cbh,068h,06bh,002h,008h,001h,030h,066h,069h,066h,030h,002h,043h	; 8b2b  ....hk...0fif0.C
	defb 09ah,0a9h,0ach,0ach,0a5h,069h,066h,086h,08eh,08eh,087h,067h,066h,067h,066h,030h	; 8b3b  .....if....gfgf0
	defb 006h,042h,030h,0a6h,0adh,0adh,0aah,099h,067h,08ch,052h,07bh,067h,030h,067h,030h	; 8b4b  .B0.....g.R{g0g0
	defb 006h,042h,066h,068h,066h,068h,066h,09ah,0a9h,0a5h,088h,08fh,08fh,089h,030h,07ah	; 8b5b  .Bfhfhf.......0z
	defb 050h,07bh,002h,042h,067h,069h,067h,069h,067h,068h,09ah,094h,0b0h,0b0h,0b0h,0a9h	; 8b6b  P{.Bgigigh......
	defb 0a5h,07ch,060h,050h,07bh,002h,041h,007h,007h,007h,007h,003h,069h,066h,0a6h,0adh	; 8b7b  .|`P{.A.....if..
	defb 0adh,0adh,0aah,094h,099h,067h,092h,050h,07bh,002h,040h,044h,003h,067h,0b7h,0bdh	; 8b8b  .....g.P{.@D.g..
	defb 0bdh,0c1h,030h,0b2h,0b3h,030h,092h,050h,093h,030h,006h,044h,005h,066h,0b9h,0beh	; 8b9b  ..0..0.P.0.D.f..
	defb 0bah,0a4h,0a8h,094h,09bh,030h,092h,060h,093h,068h,002h,044h,005h,067h,0a4h,0ach	; 8bab  .....0.`.h.D.g..
	defb 0a8h,0b1h,0abh,0a7h,066h,030h,092h,061h,093h,069h,030h,044h,001h,098h,094h,0abh	; 8bbb  ....f0.a.i0D....
	defb 0adh,0a7h,066h,066h,067h,07ah,051h,085h,066h,030h,043h,005h,068h,0b2h,0b3h,030h	; 8bcb  ..ffgzQ.f0C.h..0
	defb 0c6h,066h,067h,067h,07ah,052h,081h,067h,030h,043h,001h,069h,0a2h,094h,099h,0cah	; 8bdb  .fggzR.g0C.i....
	defb 067h,031h,092h,051h,07dh,0c9h,066h,030h,042h,001h,068h,066h,09eh,094h,094h,0a9h	; 8beb  g1.Q}.f0B.hf....
	defb 0ach,0ach,0a5h,088h,08fh,089h,0cch,0cdh,067h,030h,040h,009h,00bh,030h,069h,067h	; 8bfb  ........g0@..0ig
	defb 068h,0a6h,0aah,0b1h,0b1h,0b1h,094h,0b0h,0a9h,0a5h,030h,068h,031h,00bh,033h,066h	; 8c0b  h.........0h1.3f
	defb 069h,066h,030h,086h,08eh,087h,0a6h,0aah,094h,094h,099h,069h,031h,034h,067h,068h	; 8c1b  if0........i14gh
	defb 067h,07ah,051h,093h,030h,066h,09ah,094h,0b3h,066h,031h,035h,069h,030h,092h,051h	; 8c2b  gzQ.0f...f15i0.Q
	defb 07dh,068h,067h,030h,0b2h,0b3h,067h,031h,037h,07ch,050h,07dh,066h,069h,030h,098h	; 8c3b  }hg0..g17|P}fi0.
	defb 094h,09bh,032h,03ah,067h,0a4h,0a8h,094h,09bh,033h,032h,0eeh,0e9h,0eah,0f6h,033h	; 8c4b  ..2:g....32....3
	defb 098h,094h,0abh,0a7h,034h,032h,0efh,0ebh,0ebh,0f7h,031h,0a4h,0a8h,0abh,0a7h,036h	; 8c5b  ....42....1....6
	defb 037h,098h,0abh,0a7h,038h,021h,034h,038h,038h,094h,079h,000h,03fh,033h,034h,0abh	; 8c6b  7...8!488.y.?34.
	defb 0adh,0aah,030h,095h,034h,095h,033h,032h,095h,0a3h,0ddh,0deh,0dfh,09ah,03ah,033h	; 8c7b  ..0.4.32......:3
	defb 0a1h,0e0h,0e1h,0e2h,066h,0a2h,031h,00eh,035h,095h,030h,095h,032h,0b0h,0b0h,0a9h	; 8c8b  ....f.1.5.0.2...
	defb 067h,09eh,031h,00fh,095h,035h,033h,00eh,031h,0a3h,07ah,07bh,0a6h,0aah,034h,00eh	; 8c9b  g.1..53.1.z{..4.
	defb 031h,031h,00eh,030h,00fh,095h,030h,0a1h,07ch,078h,08bh,066h,0a6h,0aah,032h,00fh	; 8cab  11.0..0.|x.f..2.
	defb 031h,031h,00fh,095h,033h,09dh,084h,078h,061h,068h,066h,0a6h,0aah,033h,037h,0a1h	; 8cbb  11..3..xahf..37.
	defb 080h,078h,078h,063h,067h,041h,0a6h,0aah,0b1h,0abh,032h,0b1h,0b1h,0b1h,032h,099h	; 8ccb  .xxcgA....2...2.
	defb 07ch,078h,078h,08bh,066h,066h,043h,0b1h,0abh,0a7h,066h,041h,0a6h,0aah,030h,095h	; 8cdb  |xx.ffC...fA..0.
	defb 099h,088h,08ch,078h,061h,061h,066h,042h,041h,066h,067h,068h,040h,066h,040h,09ah	; 8ceb  ...xaafBAfgh@f@.
	defb 031h,0a9h,0a5h,084h,078h,060h,067h,068h,041h,041h,067h,06ah,069h,066h,067h,066h	; 8cfb  1...x`ghAAgjifgf
	defb 066h,09ah,0b1h,0abh,0a7h,082h,078h,061h,066h,069h,041h,041h,066h,06bh,068h,067h	; 8d0b  f.....xafiAAfkhg
	defb 066h,067h,067h,086h,08eh,08eh,08ah,078h,078h,060h,067h,068h,041h,041h,067h,066h	; 8d1b  fgg....xx`ghAAgf
	defb 069h,068h,067h,07ah,078h,060h,078h,060h,078h,078h,060h,061h,066h,069h,041h,042h	; 8d2b  ihgzx`x`xx`afiAB
	defb 067h,066h,069h,07ah,078h,060h,067h,066h,067h,078h,078h,061h,060h,067h,068h,041h	; 8d3b  gfizx`gfgxxa`ghA
	defb 043h,067h,040h,07ch,060h,067h,066h,067h,07ah,078h,078h,078h,061h,066h,069h,041h	; 8d4b  Cg@|`gfgzxxxafiA
	defb 042h,066h,068h,041h,067h,066h,067h,040h,07ch,078h,078h,060h,07dh,067h,042h,041h	; 8d5b  BfhAgfg@|xx`}gBA
	defb 066h,067h,069h,041h,066h,067h,042h,066h,066h,067h,043h,004h,040h,066h,067h,043h	; 8d6b  fgiAfgBffgC.@fgC
	defb 067h,043h,067h,067h,042h,004h,007h,050h,040h,067h,04bh,004h,007h,007h,052h,041h	; 8d7b  gCggB..P@gK...RA
	defb 0eeh,0e9h,0eah,0f2h,00dh,042h,004h,007h,007h,007h,055h,041h,0efh,0ebh,0ebh,0f3h	; 8d8b  .....B....UA....
	defb 041h,004h,007h,059h,046h,004h,05bh,021h,033h,035h,033h,094h,0b5h,079h,03fh,033h	; 8d9b  A..YF.[!353..y?3
	defb 03bh,095h,036h,038h,095h,039h,031h,095h,036h,0b1h,0b1h,034h,095h,031h,033h,00eh	; 8dab  ;.68.91.6..4.13.
	defb 032h,0abh,0a7h,0c0h,0d1h,0a6h,0aah,035h,033h,00fh,095h,030h,0a3h,0d9h,0d8h,0dah	; 8dbb  2......53..0....
	defb 0cbh,0f8h,0f9h,0a2h,034h,036h,0a1h,0dbh,0d7h,0dch,06ch,06eh,050h,0a0h,095h,033h	; 8dcb  ....46....lnP..3
	defb 035h,096h,095h,09dh,06ch,06eh,06dh,06fh,098h,035h,035h,097h,030h,0a1h,06dh,06fh	; 8ddb  5...lnmo.55.0.mo
	defb 050h,098h,095h,035h,032h,097h,031h,095h,096h,095h,09dh,050h,0b7h,00eh,036h,034h	; 8deb  P..52.1....P..64
	defb 096h,030h,095h,030h,09fh,0b7h,040h,00fh,00eh,035h,034h,097h,030h,097h,09bh,0b7h	; 8dfb  .0.0..@..54.0...
	defb 041h,030h,00fh,095h,034h,030h,00eh,033h,097h,0a3h,050h,0bbh,041h,034h,00eh,031h	; 8e0b  A0..40.3..P.A4.1
	defb 030h,00fh,032h,096h,030h,0afh,0b7h,042h,034h,00fh,095h,030h,035h,097h,0afh,0bbh	; 8e1b  0.2.0..B4..05...
	defb 042h,00eh,036h,033h,096h,097h,095h,0a1h,0b9h,0beh,041h,00fh,031h,00eh,033h,035h	; 8e2b  B.63......A.1.35
	defb 096h,030h,099h,06ch,0b9h,0beh,032h,00fh,033h,034h,097h,030h,097h,0b3h,06dh,051h	; 8e3b  .0.l..2.34.0..mQ
	defb 09ah,036h,034h,096h,097h,095h,0a3h,0ech,0e9h,0eah,0f2h,09ah,035h,032h,00eh,032h	; 8e4b  .64.........52.2
	defb 096h,0afh,0edh,0ebh,0ebh,0f3h,050h,0b2h,034h,031h,095h,00fh,031h,096h,030h,0a1h	; 8e5b  ......P.41..1.0.
	defb 053h,098h,032h,095h,031h,036h,096h,030h,0a9h,0ach,0ach,0a8h,036h,03dh,095h,034h	; 8e6b  S.2.16.0....6=.4
	defb 03fh,033h,021h,031h,039h,039h,094h,079h,000h,041h,066h,042h,066h,04ah,004h,007h	; 8e7b  ?3!199.y.AfBfJ..
	defb 040h,066h,067h,041h,066h,067h,066h,045h,004h,007h,007h,007h,051h,040h,067h,0ddh	; 8e8b  @fgAfgfE....Q@g.
	defb 0deh,0dfh,067h,066h,067h,066h,040h,068h,041h,004h,055h,066h,0c6h,0e0h,0e1h,0e2h	; 8e9b  ..gfgf@hA.Uf....
	defb 066h,067h,066h,067h,068h,069h,041h,006h,055h,067h,0bbh,0bdh,0bdh,0c1h,067h,066h	; 8eab  fgfghiA.Ug....gf
	defb 067h,066h,069h,066h,040h,066h,006h,055h,066h,0b9h,0beh,0bah,086h,08ah,061h,06ah	; 8ebb  gfif@f.Uf.....aj
	defb 067h,068h,067h,066h,067h,006h,055h,067h,068h,040h,066h,092h,078h,078h,065h,07bh	; 8ecb  ghgfg.Ugh@f.xxe{
	defb 069h,040h,067h,040h,002h,055h,040h,069h,066h,067h,092h,078h,078h,078h,078h,078h	; 8edb  i@g@.U@ifg.xxxxx
	defb 08bh,087h,0cch,0d1h,00ch,00ah,053h,041h,067h,066h,07ch,060h,078h,078h,078h,078h	; 8eeb  ......SAgf|`xxxx
	defb 078h,060h,08bh,0cbh,066h,068h,002h,052h,099h,040h,068h,067h,066h,067h,060h,060h	; 8efb  x`..fh.R.@hgfg``
	defb 060h,078h,078h,061h,078h,08bh,067h,069h,040h,006h,051h,030h,099h,069h,040h,067h	; 8f0b  `xxax.gi@.Q0.i@g
	defb 066h,067h,067h,067h,0b7h,0bdh,0d1h,092h,078h,083h,066h,040h,006h,051h,031h,0b0h	; 8f1b  fggg....x.f@.Q1.
	defb 0b0h,099h,067h,06ah,066h,0cch,0b5h,0b5h,0bch,092h,078h,093h,067h,040h,006h,051h	; 8f2b  ..gjf.....x.g@.Q
	defb 034h,099h,06bh,067h,066h,0b9h,0b5h,0bch,092h,078h,093h,066h,040h,002h,051h,032h	; 8f3b  4.kgf....x.f@.Q2
	defb 00eh,031h,099h,040h,067h,066h,0b9h,0bah,092h,078h,062h,067h,066h,040h,00ch,00ah	; 8f4b  .1.@gf...xbgf@..
	defb 032h,00fh,031h,095h,099h,040h,067h,066h,07eh,078h,078h,063h,066h,067h,066h,041h	; 8f5b  2.1..@gf~xxcfgfA
	defb 037h,099h,040h,067h,090h,078h,078h,064h,067h,066h,067h,041h,095h,036h,0b3h,040h	; 8f6b  7.@g.xxdgfgA.6.@
	defb 066h,090h,078h,078h,061h,066h,067h,042h,037h,0b3h,040h,067h,080h,078h,078h,078h	; 8f7b  f.xxafgB7.@g.xxx
	defb 067h,066h,042h,035h,00eh,031h,09dh,066h,040h,07ch,078h,07dh,040h,067h,066h,041h	; 8f8b  gfB5.1.f@|x}@gfA
	defb 0a6h,0adh,0adh,0aah,031h,00fh,095h,030h,0a1h,067h,066h,044h,067h,041h,042h,066h	; 8f9b  ....1..0.gfDgABf
	defb 09ah,034h,099h,067h,043h,00dh,042h,040h,068h,066h,067h,06ah,0a2h,033h,095h,099h	; 8fab  .4.gC.B@hfgj.3..
	defb 040h,0ech,0e9h,0eah,0f4h,041h,098h,040h,069h,067h,040h,067h,0a0h,034h,095h,099h	; 8fbb  @....A.@ig@g.4..
	defb 0edh,0ebh,0ebh,0f5h,040h,098h,030h,0a4h,0ach,0ach,0ach,0a8h,037h,0a9h,0ach,0ach	; 8fcb  ....@.0.....7...
	defb 0ach,0a8h,031h,021h,033h,037h,034h,079h,000h,078h,034h,066h,066h,030h,066h,030h	; 8fdb  ..1!374y.x4ff0f0
	defb 066h,032h,004h,044h,003h,030h,0d0h,0cfh,030h,067h,067h,066h,067h,066h,067h,068h	; 8feb  f2.D.0..0ggfgfgh
	defb 031h,006h,044h,005h,068h,0b6h,0ddh,0deh,0dfh,0c7h,067h,068h,067h,066h,069h,031h	; 8ffb  1.D.h.....ghgfi1
	defb 006h,044h,005h,069h,0c8h,0e0h,0e1h,0e2h,0cbh,066h,069h,066h,067h,068h,031h,006h	; 900b  .D.i.....fifgh1.
	defb 044h,040h,003h,0ceh,0cch,0c3h,066h,030h,067h,068h,067h,066h,069h,030h,004h,045h	; 901b  D@....f0ghgfi0.E
	defb 041h,003h,030h,068h,067h,07ah,050h,063h,07bh,067h,031h,006h,045h,042h,003h,069h	; 902b  A.0hgzPc{g1.EB.i
	defb 068h,053h,07bh,066h,031h,002h,044h,042h,005h,06ah,069h,07ch,060h,052h,061h,066h	; 903b  hS{f1.DB.ji|`Raf
	defb 031h,002h,043h,042h,005h,06bh,068h,066h,067h,088h,08ch,051h,061h,066h,031h,002h	; 904b  1.CB.khfg..Qaf1.
	defb 042h,042h,005h,066h,069h,067h,066h,0cch,0d1h,07ch,050h,060h,061h,066h,031h,002h	; 905b  BB.figf..|P`af1.
	defb 041h,042h,005h,067h,066h,068h,067h,066h,0ceh,0cfh,050h,061h,050h,061h,066h,031h	; 906b  AB.gfhgf..PaPaf1
	defb 002h,040h,042h,001h,066h,067h,069h,066h,067h,066h,07ah,053h,061h,066h,031h,006h	; 907b  .@B.fgifgfzSaf1.
	defb 041h,001h,068h,067h,06ah,066h,067h,066h,067h,060h,053h,060h,067h,066h,030h,006h	; 908b  A.hgjfgfg`S`gf0.
	defb 040h,005h,030h,069h,068h,06bh,067h,066h,067h,066h,067h,060h,052h,061h,066h,067h	; 909b  @.0ihkgfgfg`Rafg
	defb 030h,002h,040h,005h,030h,068h,069h,066h,068h,067h,066h,067h,066h,061h,053h,067h	; 90ab  0.@.0hifhgfgfaSg
	defb 066h,031h,040h,005h,030h,069h,066h,067h,069h,066h,067h,07ah,061h,053h,07dh,066h	; 90bb  f1@.0ifgifgzaS}f
	defb 067h,066h,030h,040h,005h,031h,067h,066h,06ah,067h,08ah,054h,07dh,066h,067h,066h	; 90cb  gf0@.1gfjg.T}fgf
	defb 067h,030h,040h,001h,032h,067h,06bh,07ch,053h,08dh,089h,066h,067h,030h,067h,031h	; 90db  g0@.2gk|S..fg0g1
	defb 005h,03ah,066h,066h,067h,066h,068h,032h,005h,039h,066h,067h,067h,066h,067h,069h	; 90eb  .:ffgfh2.9fggfgi
	defb 032h,001h,036h,00dh,031h,067h,068h,068h,067h,034h,032h,0eeh,0e9h,0eah,0f2h,031h	; 90fb  2.6.1ghhg42....1
	defb 00dh,031h,069h,069h,035h,032h,0efh,0ebh,0ebh,0f3h,03ch,03fh,033h,021h,033h,036h	; 910b  .1ii52....<?3!36
	defb 039h,079h,094h,000h,042h,0b1h,0b1h,0b1h,0b1h,043h,099h,030h,066h,030h,0c2h,0c3h	; 911b  9y..B....C.0f0..
	defb 030h,066h,030h,0b1h,0abh,0a7h,06ch,06eh,031h,0a6h,0aah,042h,099h,067h,0e3h,0e4h	; 912b  0f0...ln1..B.g..
	defb 0e5h,066h,067h,030h,030h,0f8h,0f9h,06dh,06fh,033h,0a6h,0aah,041h,099h,0e6h,0e7h	; 913b  .fg00..mo3..A...
	defb 0e8h,067h,031h,0f8h,0f9h,031h,086h,08ah,078h,060h,07bh,031h,09ah,041h,0b0h,0b0h	; 914b  .g1..1..x`{1.A..
	defb 0b0h,0b0h,0b0h,099h,030h,00dh,031h,092h,078h,078h,061h,078h,07fh,031h,0a6h,0aah	; 915b  ....0.1.xxax.1..
	defb 045h,031h,00dh,030h,092h,078h,078h,078h,078h,081h,066h,030h,066h,030h,0a6h,0aah	; 916b  E1.0.xxxx.f0f0..
	defb 043h,033h,060h,078h,078h,078h,093h,066h,067h,066h,067h,068h,066h,06ah,0a6h,0aah	; 917b  C3`xxx.fgfghfj..
	defb 0b1h,040h,004h,007h,003h,030h,067h,060h,078h,078h,078h,061h,066h,067h,066h,069h	; 918b  .@...0g`xxxafgfi
	defb 067h,06bh,066h,031h,0a6h,052h,003h,030h,067h,060h,062h,078h,078h,061h,068h,067h	; 919b  gkf1.R.0g`bxxahg
	defb 066h,068h,066h,067h,066h,031h,053h,003h,066h,067h,069h,060h,078h,078h,063h,066h	; 91ab  fhfgf1S.fgi`xxcf
	defb 067h,069h,067h,068h,067h,066h,030h,053h,005h,067h,068h,030h,067h,0b7h,0b8h,07ch	; 91bb  gighgf0S.gh0g..|
	defb 061h,066h,066h,068h,069h,068h,067h,030h,053h,005h,066h,069h,066h,066h,0b9h,0beh	; 91cb  affhihg0S.fiff..
	defb 0b8h,092h,061h,067h,069h,030h,069h,031h,053h,005h,067h,066h,067h,067h,066h,068h	; 91db  ..agi0i1S.gfggfh
	defb 0b6h,092h,060h,0b7h,0bdh,0b8h,032h,051h,008h,008h,001h,030h,067h,068h,066h,067h	; 91eb  ..`...2Q...0ghfg
	defb 069h,066h,092h,061h,0b9h,0b5h,0bch,032h,050h,001h,034h,069h,067h,066h,066h,067h	; 91fb  if.a...2P.4igffg
	defb 060h,078h,07bh,0b9h,0bah,032h,001h,031h,098h,0b0h,0b0h,0b0h,099h,030h,067h,067h	; 920b  `x{..2.1.....0gg
	defb 066h,061h,078h,078h,066h,033h,032h,0b2h,043h,0b0h,0a9h,0a5h,067h,07ch,078h,07dh	; 921b  faxxf32.C...g|x}
	defb 067h,068h,066h,031h,031h,068h,0a6h,0aah,045h,0a9h,0a5h,032h,069h,067h,0a4h,0a8h	; 922b  ghf11h..E..2ig..
	defb 031h,069h,066h,068h,0a6h,0aah,0b1h,0b1h,0b1h,042h,0b0h,0b0h,0b0h,0ach,0a8h,041h	; 923b  1ifh.....B.....A
	defb 031h,066h,067h,069h,032h,066h,0a6h,0aah,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0abh	; 924b  1fgi2f..........
	defb 0a7h,031h,067h,033h,066h,067h,03ah,031h,0eeh,0e9h,0eah,0f6h,066h,067h,038h,004h	; 925b  .1g3fg:1....fg8.
	defb 007h,007h,031h,0efh,0ebh,0ebh,0f7h,067h,037h,004h,007h,052h,03eh,006h,053h,021h	; 926b  ..1....g7..R>.S!
	defb 035h,030h,032h,094h,079h,000h,044h,068h,06ah,066h,042h,066h,040h,068h,002h,054h	; 927b  502.y.DhjfBf@h.T
	defb 041h,066h,041h,069h,06bh,067h,041h,066h,067h,06ah,069h,068h,002h,053h,040h,068h	; 928b  AfAikgAfgjih.S@h
	defb 067h,066h,0c6h,0ddh,0deh,0dfh,0c7h,066h,067h,06ah,06bh,066h,069h,06ah,002h,052h	; 929b  gf.....fgjkfij.R
	defb 066h,069h,066h,067h,0cah,0e0h,0e1h,0e2h,0cbh,067h,040h,06bh,066h,067h,066h,06bh	; 92ab  fifg.....g@kfgfk
	defb 068h,002h,051h,067h,066h,067h,040h,066h,08ah,091h,0a4h,0a8h,0b0h,0a9h,0a5h,067h	; 92bb  h.Qgfg@f.......g
	defb 040h,067h,040h,069h,040h,006h,050h,040h,067h,040h,07ah,061h,078h,081h,0b2h,033h	; 92cb  @g@i@.P@g@zax..3
	defb 0b0h,0b0h,0a9h,0a5h,040h,066h,002h,050h,099h,041h,092h,078h,07dh,066h,0a6h,0aah	; 92db  ....@f.P.A.x}f..
	defb 036h,099h,067h,06ah,002h,030h,09dh,040h,092h,093h,066h,067h,066h,040h,09ah,035h	; 92eb  6.gj.0.@..fgf@.5
	defb 0b3h,066h,06bh,040h,095h,0a1h,040h,092h,093h,067h,068h,067h,066h,066h,09ah,034h	; 92fb  .fk@..@..ghgff.4
	defb 09bh,067h,066h,040h,030h,0b3h,040h,092h,093h,066h,069h,068h,067h,067h,068h,0a2h	; 930b  .gf@0.@..fihggh.
	defb 031h,095h,0a3h,07ah,07bh,067h,068h,031h,09dh,092h,093h,067h,068h,069h,066h,066h	; 931b  1..z{gh1...ghiff
	defb 067h,0aeh,032h,0a1h,092h,093h,066h,069h,030h,095h,0afh,092h,093h,066h,069h,066h	; 932b  g.2...fi0....fif
	defb 067h,067h,066h,0aeh,032h,0b3h,092h,062h,067h,068h,031h,0afh,084h,093h,067h,066h	; 933b  ggf.2..bgh1...gf
	defb 067h,06ah,066h,067h,0aeh,031h,095h,0a3h,092h,063h,066h,069h,031h,0a1h,090h,078h	; 934b  gjfg.1...cfi1..x
	defb 07fh,067h,066h,06bh,067h,040h,09eh,032h,09fh,092h,060h,067h,06ah,031h,0b3h,090h	; 935b  .gfkg@.2..`gj1..
	defb 078h,083h,040h,067h,066h,042h,09ah,0b1h,09bh,07ah,078h,061h,066h,06bh,031h,0b3h	; 936b  x.@gfB...zxafk1.
	defb 080h,078h,078h,08bh,087h,067h,044h,07ah,078h,078h,060h,067h,06ah,030h,00eh,030h	; 937b  .xx..gDzxx`gj0.0
	defb 09dh,07ch,078h,078h,078h,08bh,087h,043h,092h,078h,060h,061h,068h,06bh,030h,00fh	; 938b  .|xxx..C.x`ahk0.
	defb 095h,0a1h,040h,07ch,078h,078h,078h,078h,07bh,042h,092h,078h,061h,068h,069h,040h	; 939b  ..@|xxxx{B.xahi@
	defb 033h,099h,040h,088h,08ch,078h,078h,07dh,042h,07ch,078h,060h,069h,066h,040h,034h	; 93ab  3.@..xx}B|x`if@4
	defb 0a9h,0a5h,042h,066h,044h,067h,066h,067h,040h,036h,0a9h,0a5h,040h,067h,066h,044h	; 93bb  ..BfDgfg@6..@gfD
	defb 067h,041h,033h,00eh,033h,099h,040h,067h,040h,00dh,0f0h,0e9h,0eah,0f4h,041h,033h	; 93cb  gA3.3.@g@.....A3
	defb 00fh,033h,095h,09dh,042h,0f1h,0ebh,0ebh,0f5h,041h,039h,0a1h,048h,021h,033h,039h	; 93db  .3..B....A9.H!39
	defb 030h,079h,000h,094h,034h,066h,031h,0a4h,0a8h,052h,09fh,031h,066h,068h,031h,033h	; 93eb  0y..4f1..R.1fh13
	defb 066h,067h,030h,098h,052h,095h,09bh,032h,067h,069h,030h,066h,032h,068h,067h,030h	; 93fb  fg0.R..2gi0f2hg0
	defb 098h,095h,052h,09bh,034h,0f8h,0f9h,067h,032h,069h,030h,098h,053h,09bh,031h,06ch	; 940b  ..R.4..g2i0.S.1l
	defb 06eh,030h,066h,031h,068h,032h,066h,09ch,095h,052h,09bh,032h,06dh,06fh,030h,067h	; 941b  n0f1h2f..R.2mo0g
	defb 030h,00dh,069h,032h,067h,0a0h,052h,0a3h,030h,0c2h,0cch,0d1h,098h,0b0h,099h,031h	; 942b  0.i2g.R.0......1
	defb 068h,030h,031h,066h,09ch,053h,09fh,0d9h,0d8h,0dah,0cbh,0b2h,050h,0b3h,031h,069h	; 943b  h01f.S......P.1i
	defb 030h,031h,067h,0a0h,052h,0b3h,030h,0dbh,0d7h,0dch,098h,051h,09bh,033h,030h,066h	; 944b  01g.R.0....Q.30f
	defb 030h,0b2h,053h,0a9h,0ach,0ach,0a8h,051h,09bh,032h,004h,007h,030h,067h,066h,0b2h	; 945b  0.S....Q.2..0gf.
	defb 054h,0b1h,0b1h,0b1h,0abh,0a7h,032h,004h,041h,031h,067h,09ah,053h,09bh,086h,08eh	; 946b  T.....2.A1g.S...
	defb 066h,068h,030h,004h,007h,007h,042h,032h,068h,0a6h,0adh,0adh,0a7h,08ah,078h,062h	; 947b  fh0...B2h.....xb
	defb 067h,069h,004h,045h,031h,068h,069h,066h,030h,086h,08ah,078h,060h,069h,030h,004h	; 948b  gi.E1hif0..x`i0.
	defb 046h,031h,069h,06ah,067h,07ah,078h,078h,060h,067h,066h,004h,047h,031h,066h,06bh	; 949b  F1ijgzxx`gf.G1fk
	defb 030h,092h,078h,060h,067h,068h,067h,006h,047h,030h,066h,067h,066h,030h,07ch,07dh	; 94ab  0.x`ghg.G0fgf0|}
	defb 067h,066h,069h,066h,006h,047h,030h,067h,066h,067h,033h,067h,068h,067h,006h,047h	; 94bb  gfif.G0gfg3ghg.G
	defb 030h,066h,067h,066h,034h,069h,06ah,006h,047h,030h,067h,068h,067h,030h,0eeh,0e9h	; 94cb  0fgf4ij.G0ghg0..
	defb 0eah,0f2h,066h,06bh,002h,047h,031h,069h,066h,030h,0efh,0ebh,0ebh,0f3h,067h,068h	; 94db  ..fk.G1if0....gh
	defb 030h,002h,046h,032h,067h,034h,066h,069h,031h,006h,045h,038h,067h,032h,006h,045h	; 94eb  0.F2g4fi1.E8g2.E
	defb 03ch,002h,045h,03dh,006h,044h,021h,031h,038h,036h,079h,094h,000h,057h,001h,03ah	; 94fb  <.E=.D!186y..W.:
	defb 055h,008h,001h,033h,068h,036h,00ah,008h,008h,008h,008h,001h,031h,068h,030h,068h	; 950b  U..3h6......1h0h
	defb 066h,069h,030h,066h,034h,034h,068h,0c2h,0c3h,069h,066h,069h,067h,068h,066h,067h	; 951b  fi0f44h..ifighfg
	defb 030h,068h,032h,033h,066h,069h,0ddh,0deh,0dfh,067h,066h,06ah,069h,067h,031h,069h	; 952b  0h23fi...gfjig1i
	defb 0a4h,0a8h,0b0h,0b0h,0a9h,0a5h,030h,067h,066h,0e0h,0e1h,0e2h,066h,067h,06bh,0a4h	; 953b  ......0gf...fgk.
	defb 0ach,0a8h,0b0h,0b0h,042h,0b1h,0b1h,040h,0a9h,0a5h,067h,0c0h,0bdh,0c1h,067h,0a4h	; 954b  ....B..@..g...g.
	defb 0a8h,044h,096h,041h,031h,09ah,041h,0b0h,0a9h,0ach,0ach,0a8h,049h,032h,09ah,0b1h	; 955b  .D.A1.A.....I2..
	defb 044h,095h,048h,007h,007h,003h,031h,09ah,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,046h	; 956b  D.H...1........F
	defb 052h,003h,032h,068h,032h,068h,030h,0a6h,0aah,044h,053h,007h,003h,030h,069h,066h	; 957b  R.2h2h0..DS..0if
	defb 0c4h,0d1h,069h,066h,030h,066h,0a2h,043h,055h,007h,003h,067h,0cch,0cdh,066h,067h	; 958b  ..if0f.CU..g..fg
	defb 068h,067h,0aeh,040h,095h,041h,056h,005h,07eh,083h,066h,067h,066h,069h,06ah,0aeh	; 959b  hg.@.AV.~.fgfij.
	defb 043h,056h,005h,090h,093h,067h,066h,067h,066h,06bh,0aeh,043h,056h,001h,082h,093h	; 95ab  CV...gfgfk.CV...
	defb 0c7h,067h,066h,067h,068h,0aeh,095h,042h,055h,001h,07ah,078h,093h,0cbh,066h,067h	; 95bb  .gfgh..BU.zx..fg
	defb 066h,069h,0a0h,043h,054h,001h,07ah,078h,078h,093h,030h,067h,068h,067h,030h,0b2h	; 95cb  fi.CT.zxx.0ghg0.
	defb 043h,052h,009h,00bh,030h,092h,078h,078h,085h,030h,066h,069h,068h,09ch,043h,09bh	; 95db  CR..0.xx.0fih.C.
	defb 008h,009h,00bh,032h,060h,078h,078h,081h,066h,067h,06ah,069h,0a0h,042h,09bh,030h	; 95eb  ...2`xx.fgji.B.0
	defb 032h,066h,031h,067h,060h,07dh,066h,067h,068h,06bh,09ch,040h,0abh,0adh,0a7h,031h	; 95fb  2f1g`}fghk.@...1
	defb 032h,067h,031h,066h,067h,066h,067h,068h,069h,030h,0a0h,0a3h,0f0h,0e9h,0eah,0f4h	; 960b  2g1fgfghi0......
	defb 030h,035h,067h,030h,067h,030h,069h,030h,098h,040h,09fh,0f1h,0ebh,0ebh,0f5h,030h	; 961b  05g0g0i0.@.....0
	defb 039h,0a4h,0a8h,040h,0a3h,035h,021h,033h,031h,033h,000h,079h,0adh,043h,068h,06ah	; 962b  9..@.5!313.y.Chj
	defb 066h,040h,0a4h,0ach,0ach,0ach,0ach,0a5h,044h,098h,040h,0d0h,0c1h,040h,069h,06bh	; 963b  f@......D.@..@ik
	defb 067h,098h,0abh,053h,0aah,0a9h,0a5h,041h,098h,094h,066h,0cah,0ddh,0deh,0dfh,066h	; 964b  g..S...A..f....f
	defb 09ch,0a3h,040h,066h,040h,068h,040h,066h,0a6h,0aah,0b0h,0b0h,094h,09bh,067h,068h	; 965b  ..@f@h@f......gh
	defb 0e0h,0e1h,0e2h,067h,0a0h,09fh,066h,067h,068h,069h,068h,067h,066h,040h,0a6h,050h	; 966b  ...g..fghihgf@.P
	defb 0a7h,040h,068h,069h,0cch,0c3h,0a4h,0a8h,09bh,040h,067h,040h,069h,066h,067h,040h	; 967b  .@hi.....@g@ifg@
	defb 067h,040h,066h,041h,004h,069h,066h,040h,098h,0abh,0a7h,044h,067h,066h,086h,08eh	; 968b  g@fA.if@...Dgf..
	defb 087h,067h,066h,004h,030h,068h,067h,09ch,0a3h,066h,040h,004h,007h,007h,007h,003h	; 969b  .gf.0hg..f@.....
	defb 040h,067h,092h,078h,078h,07fh,067h,006h,030h,069h,040h,0a0h,09fh,067h,040h,006h	; 96ab  @g.xx.g.0i@..g@.
	defb 033h,003h,040h,092h,078h,078h,083h,004h,031h,0a4h,0a8h,09bh,06ah,040h,004h,035h	; 96bb  3.@.xx..1...j@.5
	defb 003h,07ch,078h,078h,093h,006h,031h,094h,09bh,066h,06bh,040h,006h,035h,005h,040h	; 96cb  .|xx..1..fk@.5.@
	defb 07ch,078h,093h,006h,031h,09bh,040h,067h,041h,006h,035h,005h,040h,0c6h,092h,093h	; 96db  |x..1.@gA.5.@...
	defb 006h,031h,044h,006h,034h,008h,001h,066h,0cah,092h,093h,002h,031h,043h,004h,034h	; 96eb  .1D.4..f....1C.4
	defb 005h,040h,066h,067h,066h,092h,093h,066h,00ch,00ah,042h,004h,035h,001h,066h,067h	; 96fb  .@fgf..f..B.5.fg
	defb 066h,067h,060h,093h,067h,068h,040h,041h,004h,035h,005h,06ah,067h,068h,067h,066h	; 970b  fg`.gh@A.5.jghgf
	defb 061h,078h,07bh,069h,066h,004h,007h,036h,005h,06bh,066h,069h,068h,067h,092h,078h	; 971b  ax{if..6.kfihg.x
	defb 093h,066h,067h,038h,005h,040h,067h,066h,069h,066h,092h,078h,060h,067h,066h,038h	; 972b  .fg8.@gfif.x`gf8
	defb 005h,041h,067h,066h,067h,092h,060h,061h,068h,067h,039h,003h,041h,067h,040h,08ch	; 973b  .Agfg.`ahg9.Ag@.
	defb 061h,066h,069h,040h,039h,005h,044h,066h,067h,041h,039h,005h,040h,00dh,042h,067h	; 974b  afi@9.DfgA9.@.Bg
	defb 042h,039h,001h,041h,0eeh,0e9h,0eah,0f2h,042h,038h,005h,042h,0efh,0ebh,0ebh,0f3h	; 975b  B9.A....B8.B....
	defb 042h,038h,001h,049h,021h,034h,030h,035h,079h,094h,000h,047h,0b1h,0b1h,045h,09bh	; 976b  B8.I!405y..G..E.
	defb 030h,0c0h,0d1h,045h,0abh,0a7h,031h,0a6h,0adh,0aah,0b1h,0abh,0a7h,0e3h,0e4h,0e5h	; 977b  0..E..1.........
	defb 0cbh,040h,095h,042h,0a3h,07ah,078h,08bh,087h,066h,0c0h,0d1h,030h,066h,068h,0e6h	; 978b  .@.B.zx..f..0fh.
	defb 0e7h,0e8h,030h,044h,0a1h,07ch,078h,078h,078h,061h,07bh,0cbh,066h,067h,069h,030h	; 979b  ..0D.|xxxa{.fgi0
	defb 0c0h,0c1h,004h,045h,099h,07ch,078h,078h,078h,060h,030h,067h,004h,007h,007h,007h	; 97ab  ...E.|xxx`0g....
	defb 007h,050h,046h,099h,07ch,078h,060h,067h,066h,068h,006h,054h,041h,00eh,043h,09bh	; 97bb  .PF.|x`gfh.TA.C.
	defb 030h,068h,067h,068h,067h,069h,006h,054h,041h,00fh,095h,041h,0b3h,030h,066h,069h	; 97cb  0hghgi.TA..A.0fi
	defb 066h,069h,066h,004h,055h,045h,0b3h,030h,067h,068h,067h,066h,067h,006h,055h,042h	; 97db  fif.UE.0ghgfg.UB
	defb 0b1h,042h,099h,066h,069h,066h,067h,004h,056h,040h,0abh,0a7h,066h,09ah,041h,0b3h	; 97eb  .B.fifg.V@..f.A.
	defb 067h,066h,067h,004h,057h,0a3h,08ah,078h,061h,08bh,09ah,0b1h,09bh,030h,067h,068h	; 97fb  gfg.W..xa....0gh
	defb 006h,056h,001h,0a1h,08ch,078h,078h,078h,08bh,066h,031h,066h,069h,006h,055h,005h	; 980b  .V...xxx.f1fi.U.
	defb 030h,040h,099h,088h,08fh,08ch,078h,061h,08bh,030h,067h,068h,002h,055h,001h,030h	; 981b  0@....xa.0gh.U.0
	defb 041h,0b0h,0a9h,0a5h,088h,08ch,08dh,031h,069h,066h,00ch,00ah,008h,008h,009h,00bh	; 982b  A......1if......
	defb 031h,040h,095h,042h,0a9h,0a5h,032h,068h,067h,066h,066h,035h,044h,0abh,0aah,099h	; 983b  1@.B..2hgff5D...
	defb 031h,069h,066h,067h,067h,035h,041h,0b1h,0abh,0a7h,066h,030h,09ah,099h,031h,067h	; 984b  1ifgg5A...f0..1g
	defb 031h,0a4h,0a8h,0b0h,0a9h,0a5h,030h,0adh,0a7h,031h,068h,067h,031h,09ah,0a9h,0ach	; 985b  1.....0..1hg1...
	defb 0ach,0ach,0a8h,040h,0b1h,0b1h,041h,099h,030h,0f8h,0f9h,030h,069h,068h,031h,066h	; 986b  ...@..A.0..0ih1f
	defb 0a6h,0adh,0adh,0adh,0adh,0a7h,031h,0a6h,0aah,040h,030h,00dh,031h,066h,069h,031h	; 987b  ......1..@0.1fi1
	defb 067h,066h,038h,09ah,031h,00dh,030h,067h,0ech,0e9h,0eah,0f2h,067h,039h,034h,0edh	; 988b  gf8.1.0g....g94.
	defb 0ebh,0ebh,0f3h,03ah,03fh,033h,021h,034h,034h,035h,000h,094h,079h,034h,001h,050h	; 989b  ...:?3!445..y4.P
	defb 066h,068h,056h,004h,007h,007h,030h,033h,005h,050h,066h,067h,069h,068h,066h,050h	; 98ab  fhV...03.PfgihfP
	defb 004h,007h,007h,007h,033h,033h,001h,050h,067h,051h,069h,067h,050h,006h,036h,032h	; 98bb  ....33.PgQigP.62
	defb 001h,09ch,0b0h,09dh,0d9h,0d8h,0dah,0c7h,068h,006h,036h,031h,001h,050h,0a0h,040h	; 98cb  ........h.61.P.@
	defb 0a1h,0dbh,0d7h,0dch,0cbh,069h,006h,036h,009h,00bh,066h,09ch,040h,095h,040h,09dh	; 98db  .....i.6..f.@.@.
	defb 066h,08eh,08eh,087h,00ch,00ah,035h,050h,066h,067h,0a0h,042h,0a1h,067h,092h,078h	; 98eb  f.....5Pfg.B.g.x
	defb 060h,051h,006h,034h,068h,067h,068h,0b2h,042h,095h,099h,084h,078h,061h,066h,050h	; 98fb  `Q.4hgh.B...xafP
	defb 006h,034h,069h,06ah,069h,0b2h,044h,099h,078h,093h,067h,066h,002h,034h,068h,06bh	; 990b  .4iji.D.x.gf.4hk
	defb 068h,0b2h,043h,095h,0b3h,060h,093h,066h,067h,050h,006h,033h,069h,066h,069h,0b2h	; 991b  h.C..`.fgP.3ifi.
	defb 044h,0b3h,069h,060h,067h,051h,006h,033h,066h,067h,066h,0a2h,045h,09dh,067h,068h	; 992b  D.i`gQ.3fgf.E.gh
	defb 050h,004h,034h,067h,066h,067h,09eh,045h,0a1h,050h,069h,050h,006h,034h,066h,067h	; 993b  P.4gfg.E.PiP.4fg
	defb 068h,066h,09ah,045h,099h,051h,006h,034h,067h,050h,069h,067h,066h,09ah,045h,099h	; 994b  hf.E.Q.4gPigf.E.
	defb 050h,002h,034h,050h,066h,050h,066h,067h,066h,0a6h,0adh,0adh,0adh,0aah,041h,09dh	; 995b  P.4PfPfgf.....A.
	defb 050h,002h,033h,050h,067h,066h,067h,068h,067h,06ah,053h,09ah,040h,0a1h,066h,050h	; 996b  P.3PgfghgjS.@.fP
	defb 00ch,00ah,031h,051h,067h,050h,069h,066h,06bh,0ech,0e9h,0eah,0f2h,050h,0a2h,0b3h	; 997b  ..1QgPifk....P..
	defb 067h,052h,00ch,00ah,054h,067h,050h,0edh,0ebh,0ebh,0f3h,050h,0a0h,0b3h,050h,066h	; 998b  gR..TgP....P..Pf
	defb 053h,058h,0a4h,0ach,0a8h,041h,09dh,067h,053h,051h,098h,0b0h,0b0h,0b0h,0b0h,0b0h	; 999b  SX...A.gSQ......
	defb 0b0h,043h,095h,0a1h,054h,0a4h,0a8h,04ch,099h,053h,045h,095h,047h,095h,099h,052h	; 99ab  .C..T..L.SE.G..R
	defb 04fh,0b3h,052h,021h,032h,031h,035h,079h,000h,094h,034h,098h,050h,09bh,066h,068h	; 99bb  O.R!215y..4.P.fh
	defb 031h,0a6h,0aah,055h,032h,066h,09ch,050h,09bh,068h,067h,069h,06ah,068h,031h,0a6h	; 99cb  1..U2f.P.hgijh1.
	defb 0aah,053h,032h,067h,0a0h,0a3h,030h,069h,0d0h,0c1h,06bh,069h,066h,032h,0a6h,0adh	; 99db  .S2g..0i..kif2..
	defb 0adh,0a7h,031h,068h,09ch,050h,0a1h,030h,066h,0bch,0ddh,0deh,0dfh,067h,066h,030h	; 99eb  ..1h.P.0f....gf0
	defb 06ch,06eh,0f8h,0f9h,030h,003h,030h,069h,0a0h,095h,050h,099h,067h,0b6h,0e0h,0e1h	; 99fb  ln..0.0i..P.g...
	defb 0e2h,066h,067h,030h,06dh,06fh,032h,040h,003h,030h,0a2h,052h,0a9h,0a5h,030h,0cch	; 9a0b  .fg0mo2@.0.R..0.
	defb 0c1h,067h,036h,040h,005h,030h,09eh,095h,053h,099h,032h,004h,007h,007h,003h,032h	; 9a1b  .g6@.0..S.2....2
	defb 040h,005h,030h,068h,09ah,053h,09bh,030h,004h,007h,043h,007h,007h,003h,041h,003h	; 9a2b  @.0h.S.0..C...A.
	defb 069h,066h,0a6h,0aah,0b1h,09bh,030h,004h,048h,041h,005h,030h,061h,078h,08bh,066h	; 9a3b  if....0.HA.0ax.f
	defb 068h,004h,049h,041h,005h,07eh,078h,078h,093h,067h,069h,006h,049h,041h,005h,090h	; 9a4b  h.IA.~xx.gi.IA..
	defb 078h,078h,093h,066h,004h,04ah,041h,005h,090h,078h,078h,060h,067h,006h,04ah,041h	; 9a5b  xx.f.JA..xx`g.JA
	defb 005h,066h,08ch,078h,061h,004h,044h,008h,008h,008h,008h,042h,041h,001h,067h,0c6h	; 9a6b  .f.xa.D....BA.g.
	defb 078h,078h,006h,042h,008h,001h,066h,030h,066h,068h,002h,041h,009h,00bh,030h,066h	; 9a7b  xx.B..f0fh.A..0f
	defb 0cah,078h,078h,002h,008h,008h,001h,066h,068h,067h,066h,067h,069h,066h,00ch,00ah	; 9a8b  .xx....fhgfgif..
	defb 031h,068h,067h,066h,092h,078h,08bh,087h,030h,068h,067h,069h,066h,067h,068h,066h	; 9a9b  1hgf.x..0hgifghf
	defb 067h,031h,031h,069h,066h,067h,060h,078h,078h,078h,07bh,069h,031h,067h,030h,069h	; 9aab  g11ifg`xxx{i1g0i
	defb 067h,032h,031h,068h,067h,068h,067h,062h,078h,078h,093h,036h,066h,031h,031h,069h	; 9abb  g21hghgbxx.6f11i
	defb 06ah,069h,066h,067h,062h,078h,07dh,036h,067h,031h,007h,003h,030h,06bh,030h,067h	; 9acb  jifgbx}6g1..0k0g
	defb 068h,069h,035h,0f0h,0e9h,0eah,0f4h,031h,041h,007h,007h,003h,030h,069h,035h,00dh	; 9adb  hi5....1A...0i5.
	defb 0f1h,0ebh,0ebh,0f5h,031h,044h,003h,035h,00dh,036h,044h,005h,03ch,004h,021h,033h	; 9aeb  ....1D.5.6D.<.!3
	defb 037h,032h,094h,079h,000h,038h,09bh,049h,036h,095h,0b3h,040h,0d0h,0d1h,043h,004h	; 9afb  72.y.8.I6..@..C.
	defb 007h,007h,007h,030h,00eh,030h,095h,033h,09bh,040h,0cah,0ddh,0deh,0dfh,040h,004h	; 9b0b  ...0.0.3.@....@.
	defb 053h,030h,00fh,032h,0b1h,0b1h,09bh,041h,0c8h,0e0h,0e1h,0e2h,0c9h,006h,053h,033h	; 9b1b  S0.2...A......S3
	defb 09bh,066h,040h,086h,08ah,078h,0ceh,0cfh,066h,0cch,0cdh,006h,053h,031h,095h,09bh	; 9b2b  .f@..x..f...S1..
	defb 040h,067h,07ah,078h,078h,07dh,066h,068h,067h,040h,004h,054h,031h,0b3h,041h,07ah	; 9b3b  @gzxx}fhg@.T1.Az
	defb 078h,078h,07dh,040h,067h,069h,004h,007h,055h,031h,09bh,040h,066h,092h,078h,091h	; 9b4b  xx}@gi..U1.@f.x.
	defb 004h,007h,007h,007h,057h,030h,09bh,040h,066h,067h,092h,078h,081h,006h,05ah,09bh	; 9b5b  ....W0.@fg.x..Z.
	defb 040h,068h,067h,066h,060h,093h,066h,002h,058h,008h,008h,040h,066h,069h,066h,067h	; 9b6b  @hgf`.f.X..@fifg
	defb 061h,093h,067h,066h,002h,052h,008h,008h,008h,009h,00bh,041h,040h,067h,068h,067h	; 9b7b  a.gf.R.....A@ghg
	defb 066h,060h,093h,066h,067h,066h,002h,008h,001h,046h,041h,069h,068h,067h,061h,093h	; 9b8b  f`.fgf...FAihga.
	defb 067h,066h,067h,066h,040h,066h,046h,041h,066h,069h,066h,092h,093h,066h,067h,066h	; 9b9b  gfgf@fFAfif..fgf
	defb 067h,066h,067h,043h,0a4h,0a8h,0b0h,040h,068h,067h,068h,067h,092h,093h,067h,068h	; 9bab  gfgC...@hghg..gh
	defb 067h,040h,067h,040h,0a4h,0a8h,0b0h,0b0h,032h,040h,069h,06ah,069h,066h,092h,060h	; 9bbb  g@g@....2@ijif.`
	defb 066h,069h,040h,0a4h,0a8h,0b0h,034h,095h,030h,041h,06bh,068h,067h,092h,061h,067h	; 9bcb  fi@...4.0Akhg.ag
	defb 040h,098h,095h,031h,095h,035h,041h,066h,069h,060h,078h,085h,066h,09ch,03ah,041h	; 9bdb  @..1.5Afi`x.f.:A
	defb 067h,040h,061h,07dh,040h,067h,0aeh,095h,039h,045h,066h,040h,0aeh,03ah,045h,067h	; 9beb  g@a}@g..9Ef@.:Eg
	defb 040h,0a0h,034h,00eh,034h,041h,0eeh,0e9h,0eah,0f2h,040h,098h,095h,034h,00fh,095h	; 9bfb  @.4.4A....@..4..
	defb 033h,041h,0efh,0ebh,0ebh,0f3h,09ch,03ch,045h,0a0h,030h,0abh,0adh,0adh,0aah,037h	; 9c0b  3A.....<E.0....7
	defb 021h,033h,034h,030h,094h,079h,000h,041h,0c2h,0c3h,041h,0a2h,0a1h,042h,002h,057h	; 9c1b  !340.y.A..A..B.W
	defb 0c6h,0e3h,0e4h,0e5h,066h,040h,0a0h,0a3h,041h,068h,040h,002h,008h,055h,0cah,0e6h	; 9c2b  ....f@..Ah@..U..
	defb 0e7h,0e8h,067h,098h,030h,09fh,040h,066h,069h,066h,040h,068h,002h,054h,040h,0c0h	; 9c3b  ..g.0.@fif@h.T@.
	defb 0c3h,066h,09ch,030h,09bh,066h,040h,067h,066h,067h,066h,069h,066h,006h,053h,042h	; 9c4b  .f.0.f@gfgfif.SB
	defb 067h,0a0h,09bh,08ah,061h,08bh,087h,067h,068h,067h,068h,067h,002h,053h,041h,0a4h	; 9c5b  g...a..ghghg.SA.
	defb 0a8h,09bh,066h,07ch,060h,078h,078h,07bh,069h,066h,069h,068h,040h,002h,052h,040h	; 9c6b  ..f|`xx{ifih@.R@
	defb 098h,030h,09bh,040h,067h,066h,069h,060h,078h,078h,07bh,067h,066h,069h,068h,040h	; 9c7b  .0.@gfi`xx{gfih@
	defb 00ch,00ah,008h,09ch,030h,09bh,041h,068h,067h,066h,067h,07ch,078h,078h,07bh,067h	; 9c8b  ....0.Ahgfg|xx{g
	defb 040h,069h,043h,0aeh,0b3h,042h,069h,068h,067h,066h,066h,07ch,062h,0cch,0bdh,0bdh	; 9c9b  @iC..Bihgff|b...
	defb 0bfh,0b8h,042h,09eh,030h,099h,042h,069h,068h,067h,067h,066h,061h,066h,0b9h,0beh	; 9cab  ..B.0.Bihggfaf..
	defb 0beh,0bah,082h,083h,040h,040h,09ah,030h,0a9h,0a5h,041h,069h,041h,067h,066h,069h	; 9cbb  ....@@.0..AiAgfi
	defb 066h,08ah,078h,060h,078h,093h,040h,041h,0a6h,0aah,030h,0a9h,0ach,0ach,0ach,0ach	; 9ccb  f.x`x.@A..0.....
	defb 0a5h,067h,066h,067h,062h,078h,061h,078h,085h,040h,043h,0a6h,0adh,0adh,0adh,0adh	; 9cdb  .gfgbxax.@C.....
	defb 0aah,030h,09dh,067h,066h,063h,060h,078h,078h,081h,0a4h,042h,0f8h,0f9h,040h,066h	; 9ceb  .0.gfc`xx..B..@f
	defb 041h,068h,0a2h,0a1h,040h,067h,062h,061h,078h,07dh,098h,030h,040h,0f8h,0f9h,042h	; 9cfb  Ah..@gbax}.0@..B
	defb 067h,068h,066h,069h,0a0h,0b3h,040h,066h,063h,078h,07dh,098h,095h,030h,041h,0f8h	; 9d0b  ghfi..@fcx}..0A.
	defb 0f9h,042h,069h,067h,098h,095h,030h,09dh,067h,041h,098h,032h,0a9h,0a5h,044h,0a4h	; 9d1b  .Big..0.gA.2..D.
	defb 0a8h,032h,0afh,041h,09ch,033h,030h,00eh,0b0h,0b0h,0b0h,0b0h,0b0h,034h,0a1h,041h	; 9d2b  .2.A.30......4.A
	defb 09eh,033h,030h,00fh,039h,0b3h,042h,0a6h,0aah,0b1h,0b1h,03bh,0b3h,046h,095h,03ah	; 9d3b  .30.9.B....;.F.:
	defb 0a3h,046h,033h,00eh,032h,095h,032h,09fh,040h,00dh,0f0h,0e9h,0eah,0f4h,040h,032h	; 9d4b  .F3.2.2.@.....@2
	defb 095h,00fh,035h,09bh,042h,0f1h,0ebh,0ebh,0f5h,040h,039h,09bh,048h,021h,034h,033h	; 9d5b  ..5.B....@9.H!43
	defb 034h,0d8h,079h,0ffh,04fh,043h,04fh,043h,043h,010h,011h,036h,012h,013h,044h,042h	; 9d6b  4.y.OCOCC..6..DB
	defb 0fah,03ah,0fbh,043h,041h,0fah,03ch,0fbh,042h,040h,018h,03eh,019h,041h,040h,01ch	; 9d7b  .:.CA.<.B@.>.A@.
	defb 03eh,01dh,041h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h	; 9d8b  >.A.?0P@.?0P@.?0
	defb 050h,040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h	; 9d9b  P@.?0P@.?0P@.?0P
	defb 040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h,0feh,03fh,030h,050h,040h	; 9dab  @.?0P@.?0P@.?0P@
	defb 040h,01eh,03eh,01fh,041h,040h,01ah,03eh,01bh,041h,041h,0fch,03ch,0fdh,042h,042h	; 9dbb  @.>.A@.>.AA.<.BB
	defb 0fch,03ah,0fdh,043h,043h,014h,015h,036h,016h,017h,044h,04fh,043h,04fh,043h,04fh	; 9dcb  .:.CC..6..DOCOCO
	defb 043h,021h	; 9ddb

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
; DATOS sin identificar  0x9ec0..0x9ef4  (52 bytes)
DATA_9EC0:
	defb 002h,008h,001h,00ch,000h,011h,001h,005h,002h,002h,003h,002h,004h,003h,005h,005h	; 9ec0  ................
	defb 006h,001h,0ffh,002h,008h,001h,00ch,000h,011h,001h,006h,002h,003h,003h,003h,004h	; 9ed0  ................
	defb 005h,005h,001h,0ffh,002h,008h,001h,00fh,002h,004h,003h,005h,004h,001h,0ffh,002h	; 9ee0  ................
	defb 018h,003h,001h,0ffh	; 9ef0

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
; DATOS sin identificar  0x9f21..0xaea3  (3970 bytes)
DATA_9F21:
	defb 007h,013h,01fh,028h,032h,040h,04eh,009h,02dh,02eh,00ch,02fh,030h,00ch,031h,032h	; 9f21  ...(2@N.-../0.12
	defb 00dh,033h,00dh,034h,00eh,035h,00ch,036h,030h,00ch,037h,038h,00dh,039h,009h,03ah	; 9f31  .3.4.5.60.78.9.:
	defb 049h,00fh,00dh,03bh,00dh,05ah,00dh,05bh,00ch,05ch,03ah,00fh,00dh,03bh,00dh,03ch	; 9f41  I..;.Z.[.\:..;.<
	defb 009h,03dh,03eh,009h,03ah,03fh,007h,040h,001h,03bh,042h,043h,009h,044h,045h,009h	; 9f51  .=>.:?.@.;BC.DE.
	defb 046h,047h,009h,048h,049h,008h,04ah,04bh,04ch,009h,04dh,04eh,00dh,04fh,009h,057h	; 9f61  FG.HI.JKL.MN.O.W
	defb 058h,009h,059h,049h,00fh,008h,050h,051h,052h,008h,053h,054h,055h,008h,056h,057h	; 9f71  X.YI..PQR.STU.VW
	defb 058h,009h,059h,049h,0a6h,000h,001h,003h,00fh,0a1h,01fh,03fh,0ffh,080h,0c0h,0f0h	; 9f81  X.YI.......?....
	defb 0a1h,0f8h,0fch,0ffh,07fh,0a0h,03fh,01fh,007h,003h,001h,000h,0feh,0a0h,0fch,0f8h	; 9f91  ......?.........
	defb 0f0h,0c0h,080h,0a0h,000h,0a0h,001h,0a1h,003h,0a0h,001h,0a0h,000h,080h,0a2h,0c0h	; 9fa1  ................
	defb 080h,07eh,030h,0abh,000h,03ch,0a2h,000h,007h,01fh,03fh,07fh,0a2h,000h,0e0h,0f8h	; 9fb1  .~0..<....?.....
	defb 0fch,0feh,003h,01fh,03fh,0a3h,0ffh,0c0h,0f8h,0fch,0a3h,0ffh,000h,01eh,012h,032h	; 9fc1  ....?..........2
	defb 07eh,0ffh,099h,066h,0a0h,004h,0a0h,00ch,0a0h,01ch,03ch,03eh,004h,0ffh,07fh,080h	; 9fd1  ~..f......<>....
	defb 008h,022h,0a4h,000h,007h,01fh,03fh,0ffh,003h,01fh,07fh,0a3h,0ffh,080h,0f8h,0fch	; 9fe1  ."....?.........
	defb 0a3h,0ffh,0a2h,000h,0e0h,0f8h,0fch,0a0h,0ffh,07fh,01fh,003h,0a2h,000h,0a3h,0ffh	; 9ff1  ................
	defb 07fh,00fh,003h,0a3h,0ffh,0feh,0f0h,080h,0ffh,0fch,0f8h,0c0h,0a2h,000h,0a0h,001h	; a001  ................
	defb 0a0h,003h,007h,0a1h,00fh,0a0h,080h,0c0h,0a1h,0e0h,0a0h,0f0h,0a1h,00fh,007h,0a0h	; a011  ................
	defb 003h,0a0h,001h,0a1h,0f0h,0a0h,0e0h,0c0h,0a0h,080h,00fh,0a0h,01fh,03fh,0a1h,07fh	; a021  .............?..
	defb 0ffh,0a1h,0f8h,0a0h,0fch,0a0h,0feh,0a0h,0ffh,0a2h,07fh,03fh,0a0h,01fh,0ffh,0a1h	; a031  ...........?....
	defb 0feh,0a1h,0fch,0f8h,0a6h,000h,0afh,07eh,0a5h,07eh,073h,078h,07fh,03fh,01fh,0a1h	; a041  .......~.~sx.?..
	defb 000h,0ffh,000h,0a1h,0ffh,0a1h,000h,0ceh,01eh,0feh,0fch,0f8h,0a2h,000h,01fh,03fh	; a051  ...............?
	defb 07fh,078h,073h,0a0h,074h,000h,0a1h,0ffh,000h,0ffh,0a1h,000h,0f8h,0fch,0feh,01eh	; a061  .xs.t...........
	defb 0ceh,06eh,02eh,0a6h,074h,0a6h,02eh,073h,078h,0a0h,07fh,078h,073h,0a0h,074h,0ffh	; a071  .n..t..sx..xs.t.
	defb 000h,0a0h,0ffh,000h,0ffh,0a0h,000h,0ceh,01eh,0a0h,0feh,01eh,0ceh,0a0h,02eh,03ch	; a081  ...............<
	defb 07eh,0e7h,0a0h,0c3h,0e7h,07eh,03ch,03eh,0a3h,073h,03eh,000h,01ch,0a0h,03ch,0a1h	; a091  ~....~<>.s>...<.
	defb 01ch,03eh,000h,03eh,067h,007h,01eh,030h,060h,07fh,000h,03eh,067h,007h,01eh,007h	; a0a1  .>.>g..0`..>g...
	defb 067h,03eh,000h,00eh,01eh,03eh,0a0h,06eh,07fh,00eh,000h,03fh,0a0h,038h,03eh,003h	; a0b1  g>...>.n...?.8>.
	defb 063h,03eh,000h,03eh,073h,070h,07eh,0a0h,073h,03eh,000h,07fh,063h,006h,00ch,0a1h	; a0c1  c>.>sp~.s>..c...
	defb 01ch,000h,03eh,0a0h,073h,03eh,0a0h,073h,03eh,000h,03eh,0a0h,073h,03fh,003h,063h	; a0d1  ..>.s>.s>.>.s?.c
	defb 03eh,0a0h,000h,0a0h,018h,0a0h,000h,0a0h,018h,0a0h,000h,0a0h,008h,03eh,0a0h,008h	; a0e1  >............>..
	defb 0a0h,000h,0a0h,008h,03eh,0a0h,008h,000h,03eh,0a2h,000h,03eh,0a7h,000h,0a0h,018h	; a0f1  ....>...>..>....
	defb 0a1h,000h,07eh,0a2h,06bh,000h,03ch,042h,09dh,0a0h,0b1h,09dh,042h,03ch,01ch,03eh	; a101  ..~.k.<B....B<.>
	defb 0a0h,073h,07fh,0a0h,073h,000h,07eh,0a0h,073h,07eh,0a0h,073h,07eh,000h,03eh,0a0h	; a111  .s..s.~.s~.s~.>.
	defb 073h,070h,0a0h,073h,03eh,000h,07ch,076h,0a1h,073h,076h,07ch,000h,07fh,071h,070h	; a121  sp.s>.|v.sv|..qp
	defb 07ch,070h,071h,07fh,000h,07fh,071h,070h,07ch,0a1h,070h,000h,03eh,073h,070h,077h	; a131  |pq...qp|.p.>spw
	defb 0a0h,073h,03eh,000h,0a1h,073h,07fh,0a1h,073h,000h,03eh,0a3h,01ch,03eh,000h,01fh	; a141  .s>..s..s.>..>..
	defb 0a1h,007h,0a0h,067h,03eh,000h,073h,076h,07ch,078h,07ch,076h,073h,000h,0a3h,070h	; a151  ...g>.sv|x|vs..p
	defb 071h,07fh,000h,063h,077h,07fh,06bh,0a1h,063h,000h,073h,07bh,07fh,077h,0a1h,073h	; a161  q..cw.k.c.s{.w.s
	defb 000h,03eh,0a3h,073h,03eh,000h,07eh,0a1h,073h,07eh,0a0h,070h,000h,03eh,0a1h,073h	; a171  .>.s>.~.s~.p.>.s
	defb 07fh,072h,03dh,000h,07eh,0a1h,073h,07eh,076h,073h,000h,03eh,073h,070h,03eh,007h	; a181  .r=.~.s~vs.>sp>.
	defb 067h,03eh,000h,07fh,0a4h,01ch,000h,0a4h,073h,03eh,000h,0a3h,073h,03eh,01ch,000h	; a191  g>......s>..s>..
	defb 0a0h,063h,0a1h,06bh,07fh,036h,000h,0a0h,073h,032h,01ch,032h,0a0h,073h,000h,0a0h	; a1a1  .c.k.6..s2.2.s..
	defb 073h,032h,0a2h,01ch,000h,07fh,047h,00eh,01ch,038h,071h,07fh,000h,018h,0a0h,03ch	; a1b1  s2....G..8q....<
	defb 018h,000h,0a0h,018h,000h,0a6h,003h,0a6h,00fh,0a6h,03fh,0a6h,0ffh,000h,0a0h,018h	; a1c1  ..........?.....
	defb 034h,07eh,05ah,0efh,0f7h,0bdh,0cfh,07eh,0a0h,018h,0e7h,07eh,0a2h,000h,018h,03ch	; a1d1  4~Z....~...~...<
	defb 06ah,0dfh,0f7h,0efh,0bbh,07eh,018h,0e7h,07eh,0a5h,000h,03ch,06ah,0fbh,0efh,0b3h	; a1e1  j....~..~..<j...
	defb 07eh,0e7h,07eh,0a2h,000h,0a0h,018h,034h,076h,05ah,0efh,0b7h,0bdh,0d7h,07eh,0a0h	; a1f1  ~.~....4vZ....~.
	defb 018h,0e7h,07eh,0a2h,000h,018h,03ch,06ah,0dfh,0f7h,0efh,0bbh,07eh,018h,0e7h,07eh	; a201  ..~...<j....~..~
	defb 0a5h,000h,03ch,06ah,0fbh,0efh,0b3h,07eh,0e7h,07eh,0a2h,000h,024h,05eh,0fbh,0ddh	; a211  ..<j...~.~..$^..
	defb 0c9h,090h,0a1h,018h,0a1h,00ch,006h,0f8h,01fh,0a0h,000h,024h,07ah,0dfh,0dbh,093h	; a221  ...........$z...
	defb 009h,018h,0a1h,030h,060h,01fh,0f8h,0a1h,000h,008h,03ch,076h,07ah,0dfh,0edh,0b7h	; a231  ...0`.....<vz...
	defb 0ddh,072h,0ffh,07eh,0a1h,000h,03ch,056h,0fah,0f5h,0b5h,0bbh,04eh,07eh,034h,07eh	; a241  .r.~..<V....N~4~
	defb 0bdh,0d6h,051h,038h,0c7h,07ch,0a0h,000h,060h,0f0h,0a0h,0b0h,0f2h,0b7h,0bdh,0bbh	; a251  ..Q8.|..`.......
	defb 0feh,0a0h,0f0h,09fh,0f0h,0a1h,000h,00ch,01eh,0a0h,016h,05eh,0a0h,0f6h,07eh,0a0h	; a261  ...........^..~.
	defb 01eh,0f3h,01eh,0a8h,000h,0a7h,0ffh,0a0h,0fch,0a1h,0f0h,0c0h,080h,0ffh,07fh,0a0h	; a271  ................
	defb 03fh,00fh,0a1h,007h,0c0h,0a1h,0f0h,0f8h,0a0h,0feh,0ffh,0a0h,001h,007h,0a0h,00fh	; a281  ?...............
	defb 01fh,07fh,0a1h,0ffh,0a0h,0feh,0a0h,0fch,0a0h,0f8h,0a0h,0ffh,07fh,0a0h,03fh,07fh	; a291  ..............?.
	defb 03fh,01fh,0f8h,0a0h,0fch,0a0h,0feh,0fch,0a0h,0ffh,01fh,0a1h,03fh,07fh,0a1h,0ffh	; a2a1  ?...........?...
	defb 0a0h,0f8h,0e0h,0f0h,0e0h,0a0h,0c0h,080h,00fh,01fh,0a1h,007h,0a1h,001h,080h,0a0h	; a2b1  ................
	defb 0c0h,0a2h,0f0h,0f8h,0a0h,001h,003h,0a1h,007h,00fh,01fh,0a3h,0ffh,0feh,0f0h,0c0h	; a2c1  ................
	defb 0a3h,0ffh,03fh,00fh,007h,0c0h,0f0h,0fch,0a3h,0ffh,003h,00fh,03fh,0a4h,0ffh,0fch	; a2d1  ..?.........?...
	defb 0f0h,0c0h,0a2h,000h,0ffh,03fh,00fh,003h,0a6h,000h,0c0h,0f0h,0fch,0ffh,0a2h,000h	; a2e1  .....?..........
	defb 003h,00fh,03fh,0a3h,0ffh,0a6h,000h,0a2h,0ffh,0f0h,0e0h,0a1h,0f0h,0e0h,0a0h,0f0h	; a2f1  ..?.............
	defb 00fh,007h,0a1h,00fh,007h,0a0h,00fh,000h,080h,000h,0a0h,0c0h,080h,0a1h,000h,001h	; a301  ................
	defb 0a0h,003h,000h,001h,0aah,000h,010h,048h,001h,020h,0a0h,000h,01ch,03eh,07fh,0ffh	; a311  .......H. ...>..
	defb 0feh,0ffh,07ch,02ah,000h,01ch,03ch,0a0h,07eh,06eh,008h,022h,0feh,0fch,0f8h,0a0h	; a321  ..|*..<.~n."....
	defb 0f0h,0e0h,080h,000h,03fh,01fh,0a0h,00fh,0a0h,007h,003h,0a0h,000h,080h,09ch,0d8h	; a331  ....?...........
	defb 0c0h,0fch,0feh,0ffh,001h,037h,027h,0a0h,003h,0a0h,01fh,0a1h,0ffh,0f8h,0feh,0fch	; a341  .....7'.........
	defb 0f4h,0e0h,0f8h,0a0h,0ffh,07fh,01fh,00fh,01fh,0a0h,00fh,0f0h,0a0h,0f8h,0f0h,0fch	; a351  ................
	defb 0feh,0a0h,0ffh,01fh,00fh,01fh,0a0h,03fh,01fh,07fh,0ffh,0f0h,0a0h,0c0h,0e0h,0a0h	; a361  .......?........
	defb 0c0h,0a0h,080h,0a0h,00fh,003h,007h,0a1h,003h,001h,080h,0a0h,0c0h,080h,0e0h,0a0h	; a371  ................
	defb 0f0h,0e0h,001h,0a0h,003h,001h,007h,00fh,007h,00fh,0a2h,0ffh,0f8h,0fch,0f8h,0c0h	; a381  ................
	defb 0a1h,0ffh,0cfh,00fh,01fh,001h,003h,080h,0f4h,0e0h,0fch,0a2h,0ffh,003h,01fh,00fh	; a391  ................
	defb 09fh,0a2h,0ffh,0feh,0f0h,0f8h,080h,010h,002h,040h,000h,0ffh,00fh,03fh,033h,080h	; a3a1  .........@...?3.
	defb 008h,021h,0a0h,000h,008h,040h,002h,0e0h,0ech,0fch,0ffh,010h,000h,084h,030h,063h	; a3b1  .!...@........0c
	defb 00fh,03fh,0a2h,0ffh,073h,000h,040h,002h,0a0h,010h,000h,042h,000h,073h,0a1h,0ffh	; a3c1  .?..s.@....B.s..
	defb 0f0h,0a0h,0e0h,0f0h,0f8h,0f0h,0e0h,0f0h,0a0h,007h,00fh,0a0h,01fh,007h,0a0h,00fh	; a3d1  ................
	defb 07eh,00ch,041h,008h,020h,0a4h,000h,010h,000h,084h,000h,076h,000h,0a0h,080h,000h	; a3e1  ~.A. ......v....
	defb 080h,0c0h,080h,0a0h,000h,0a0h,001h,000h,001h,003h,001h,0a8h,000h,020h,002h,008h	; a3f1  ............. ..
	defb 000h,040h,002h,010h,0a0h,081h,0c3h,0a3h,0ffh,0a1h,0f8h,0fch,0f8h,0e0h,0a0h,080h	; a401  .@..............
	defb 0a0h,007h,003h,0a0h,01fh,00fh,0a0h,001h,080h,0c0h,0e0h,0a1h,0f0h,0fch,0ffh,0a0h	; a411  ................
	defb 001h,007h,003h,00fh,03fh,07fh,0ffh,080h,0a0h,0c0h,080h,0a0h,000h,0a0h,080h,001h	; a421  ....?...........
	defb 0a0h,003h,001h,0a0h,000h,0a0h,001h,0ffh,0a0h,03ch,0a9h,000h,020h,076h,0a6h,000h	; a431  .........<.. v..
	defb 0ffh,0a0h,087h,0a0h,000h,080h,0f0h,0feh,0a0h,0e1h,0a1h,000h,001h,003h,00fh,0ffh	; a441  ................
	defb 0a0h,0e0h,000h,080h,0c0h,0a1h,0ffh,0a0h,01fh,000h,001h,003h,007h,0a0h,0ffh,0f8h	; a451  ................
	defb 0f0h,0a0h,0e0h,0f0h,0a1h,0ffh,00fh,0a1h,007h,00fh,01fh,0ffh,0e1h,0c1h,080h,081h	; a461  ................
	defb 0a1h,003h,000h,0c7h,087h,003h,0c1h,0c0h,0a0h,000h,080h,0a1h,0ffh,0c3h,081h,000h	; a471  ................
	defb 0a0h,001h,0a2h,0ffh,0a0h,0e1h,0c0h,080h,0a2h,001h,0a0h,000h,081h,0c3h,0a1h,080h	; a481  ................
	defb 0a0h,000h,081h,0c3h,0a0h,0ffh,0a0h,0f0h,0a1h,000h,080h,0e0h,080h,000h,0a0h,001h	; a491  ................
	defb 003h,007h,00fh,03fh,0a0h,080h,0a0h,0c0h,0e0h,0f8h,0a0h,0ffh,087h,007h,0a0h,000h	; a4a1  ...?............
	defb 001h,003h,00fh,0a0h,0ffh,0a0h,0fch,0f0h,0e0h,0c0h,0a0h,080h,0ffh,0a0h,03fh,007h	; a4b1  ..............?.
	defb 0a0h,003h,0a0h,001h,000h,006h,01eh,0a0h,07eh,01eh,006h,0a0h,000h,060h,078h,0a0h	; a4c1  ........~....`x.
	defb 07eh,078h,060h,0a0h,000h,03ch,07eh,066h,066h,07eh,03ch,0a0h,000h,018h,018h,03ch	; a4d1  ~x`..<~ff~<....<
	defb 03ch,07eh,07eh,0a1h,000h,018h,0a0h,03ch,018h,0a7h,000h,0ffh,0a6h,000h,0fch,0f0h	; a4e1  <~~....<........
	defb 0c0h,0a0h,080h,0a1h,000h,07fh,01fh,007h,0a0h,003h,0a1h,001h,0a0h,000h,0a0h,080h	; a4f1  ................
	defb 0c0h,0f0h,0fch,0ffh,0a0h,001h,0a0h,003h,007h,01fh,07fh,0a0h,0ffh,0feh,0f8h,0e0h	; a501  ................
	defb 0c0h,0a1h,080h,0ffh,001h,0a4h,000h,0a0h,0ffh,03fh,00fh,007h,0a1h,003h,0a0h,080h	; a511  .........?......
	defb 0c0h,0e0h,0f8h,0feh,0a0h,0ffh,0a3h,000h,001h,0a0h,0ffh,0a0h,003h,007h,00fh,03fh	; a521  ...............?
	defb 0a3h,0ffh,0fch,0f0h,0a0h,0e0h,0a0h,0c0h,0a0h,0ffh,0a4h,000h,0a0h,0ffh,07fh,01fh	; a531  ................
	defb 0a0h,00fh,0a0h,007h,0c0h,0a0h,0e0h,0f0h,0fch,0a1h,0ffh,0a3h,000h,0a1h,0ffh,007h	; a541  ................
	defb 0a0h,00fh,01fh,07fh,0a1h,0ffh,000h,040h,0e0h,040h,0e0h,0a2h,000h,002h,007h,002h	; a551  .......@.@......
	defb 007h,0a9h,000h,0fch,0a3h,0f8h,0a3h,0f0h,0a3h,0e0h,0ffh,0feh,0a0h,0fch,0a0h,0f8h	; a561  ................
	defb 0a0h,0f0h,0a0h,0e0h,0a0h,0c0h,0a0h,080h,0a0h,000h,0a1h,0e0h,0a1h,0f0h,0a1h,0f8h	; a571  ................
	defb 0a1h,0fch,0a1h,0feh,0ffh,03fh,0a3h,01fh,0a3h,00fh,0a3h,007h,0ffh,07fh,0a0h,03fh	; a581  .....?.........?
	defb 0a0h,01fh,0a0h,00fh,0a0h,007h,0a0h,003h,0a0h,001h,0a0h,000h,0a1h,007h,0a1h,00fh	; a591  ................
	defb 0a1h,01fh,0a1h,03fh,0a1h,07fh,0ffh,003h,00fh,03fh,0a0h,0ffh,049h,0a0h,07fh,0c0h	; a5a1  ...?.....?..I...
	defb 0f0h,0fch,0a0h,0ffh,092h,0a0h,0feh,0a0h,001h,007h,0a0h,00fh,03fh,0a0h,07fh,080h	; a5b1  ............?...
	defb 0a0h,0c0h,0f0h,0f8h,0a0h,0fch,0feh,0a0h,07fh,0a0h,03fh,00fh,0a0h,007h,001h,0feh	; a5c1  ..........?.....
	defb 0a0h,0fch,0a0h,0f0h,0c0h,080h,0a1h,000h,001h,000h,001h,003h,001h,0a1h,000h,080h	; a5d1  ................
	defb 000h,080h,0c0h,080h,000h,000h,004h,0f1h,0f1h,000h,030h,031h,021h,0b3h,0f2h,0f3h	; a5e1  ..........01!...
	defb 0f2h,0e3h,092h,051h,012h,000h,004h,084h,084h,0f4h,0f4h,0b4h,000h,002h,0f4h,0f4h	; a5f1  ...Q............
	defb 0f4h,000h,040h,0c3h,0c2h,000h,004h,0fch,0f1h,000h,006h,0d1h,0d1h,0b1h,091h,091h	; a601  ..@.............
	defb 0b1h,0b1h,091h,091h,0b1h,000h,002h,0d1h,0d1h,000h,02ch,0a1h,0a1h,08ch,081h,000h	; a611  ..........,.....
	defb 002h,089h,089h,08ch,081h,000h,0b0h,0fch,0f1h,000h,010h,081h,081h,000h,003h,0c3h	; a621  ................
	defb 0c3h,000h,002h,0c1h,0c1h,0c3h,063h,063h,016h,013h,000h,003h,0c3h,0c3h,0c3h,000h	; a631  ......cc........
	defb 002h,0c1h,0c1h,0c3h,063h,016h,013h,000h,004h,0c3h,0c3h,0c3h,0c1h,0c1h,0c1h,0c3h	; a641  ....c...........
	defb 016h,013h,000h,002h,0c3h,0c3h,000h,002h,0c2h,0c3h,0c2h,000h,002h,0c1h,0c1h,0c3h	; a651  ................
	defb 062h,063h,016h,013h,000h,003h,0c2h,0c3h,0c2h,000h,002h,0c1h,0c1h,0c3h,062h,016h	; a661  bc............b.
	defb 012h,000h,004h,0c3h,0c2h,0c3h,0c1h,0c1h,0c1h,0c3h,016h,013h,000h,003h,0c2h,0c3h	; a671  ................
	defb 0c1h,0c1h,0c2h,000h,004h,063h,062h,016h,012h,000h,002h,0c3h,0c2h,0c1h,0c1h,0c3h	; a681  .....cb.........
	defb 000h,003h,062h,063h,016h,013h,0c2h,000h,004h,0cbh,0cbh,0c1h,0c1h,0c1h,01bh,01bh	; a691  ..bc............
	defb 000h,003h,0cbh,0cbh,0cbh,0c1h,0c1h,0c1h,01bh,0cbh,0cbh,0c1h,0c1h,0c1h,0cbh,016h	; a6a1  ................
	defb 01bh,000h,004h,0cbh,0cbh,0c3h,0c3h,0cbh,0cbh,0cbh,01ch,01bh,000h,006h,0cbh,0cbh	; a6b1  ................
	defb 0cbh,01ch,01bh,0cbh,0cbh,000h,004h,033h,033h,000h,06ch,033h,023h,000h,004h,074h	; a6c1  .......33.l3#..t
	defb 074h,000h,004h,0f4h,0f4h,000h,003h,034h,024h,03fh,0f4h,000h,002h,034h,024h,034h	; a6d1  t......4$?...4$4
	defb 02fh,0f4h,0f4h,000h,042h,034h,024h,000h,002h,0f4h,0f4h,000h,002h,034h,024h,000h	; a6e1  /...B4$......4$.
	defb 004h,0f4h,0f4h,000h,002h,034h,024h,0f4h,0f4h,0f4h,000h,004h,024h,034h,024h,000h	; a6f1  .....4$.....$4$.
	defb 004h,0f4h,0f4h,000h,00bh,034h,024h,000h,006h,0f4h,0f4h,0f4h,000h,008h,024h,034h	; a701  .....4$.......$4
	defb 024h,000h,004h,03bh,03bh,000h,004h,0abh,0abh,000h,004h,03bh,02bh,031h,000h,003h	; a711  $..;;......;+1..
	defb 02bh,03bh,02bh,031h,000h,014h,02bh,03bh,021h,01bh,000h,006h,02bh,03bh,02bh,031h	; a721  +;+1..+;!...+;+1
	defb 000h,004h,02bh,03bh,021h,01bh,000h,002h,02bh,03bh,02bh,031h,01bh,000h,003h,03bh	; a731  ..+;!...+;+1...;
	defb 02bh,03bh,021h,01bh,000h,003h,02bh,03bh,021h,01bh,000h,003h,02bh,03bh,021h,000h	; a741  +;!...+;!...+;!.
	defb 003h,03bh,02bh,03bh,021h,000h,003h,03bh,02bh,031h,000h,002h,02bh,03bh,02bh,01bh	; a751  .;+;!..;+1..+;+.
	defb 02bh,031h,02bh,03bh,02bh,01bh,000h,003h,02bh,03bh,021h,01bh,000h,003h,02bh,03bh	; a761  +1+;+...+;!...+;
	defb 02bh,031h,000h,003h,02bh,03bh,01bh,000h,003h,03bh,02bh,01bh,000h,003h,02bh,03bh	; a771  +1..+;...;+...+;
	defb 021h,01bh,000h,002h,02bh,03bh,02bh,01bh,000h,007h,02bh,03bh,02bh,031h,01bh,000h	; a781  !...+;+...+;+1..
	defb 003h,03bh,02bh,03bh,021h,000h,003h,03bh,02bh,03bh,021h,000h,003h,03bh,02bh,000h	; a791  .;+;!..;+;!..;+.
	defb 010h,094h,094h,000h,004h,01ch,01ch,000h,048h,03ch,02ch,03ch,0ach,0ach,0ach,01ch	; a7a1  ........H<,<....
	defb 000h,002h,02ch,03ch,0ach,0ach,0ach,01ch,000h,035h,02ch,03ch,02ch,000h,002h,083h	; a7b1  ..,<.....5,<,...
	defb 082h,071h,0b1h,0b1h,0b1h,000h,002h,083h,082h,071h,0b1h,0b1h,0b1h,000h,018h,0c3h	; a7c1  .q.......q......
	defb 0c2h,0a0h,000h,001h,002h,00ch,010h,060h,080h,000h,0c0h,0e0h,060h,0a2h,000h,003h	; a7d1  .......`....`...
	defb 01ch,018h,01ch,00ch,0a0h,006h,003h,03ch,07eh,0feh,0ffh,0c7h,0c3h,0e7h,018h,003h	; a7e1  .......<~.......
	defb 001h,0a4h,000h,0a0h,0fch,01ch,06ch,0a2h,03ch,03eh,0a0h,07fh,0a0h,02ch,0a2h,06ch	; a7f1  ......l.<>...,.l
	defb 0cch,0a0h,0c6h,0a0h,0c3h,0a0h,0c7h,0a3h,000h,060h,0e0h,0c0h,0a0h,080h,0a2h,040h	; a801  .........`.....@
	defb 0a2h,020h,0a0h,010h,019h,0a0h,01fh,000h,03ch,07eh,0feh,0bah,0f6h,0eeh,0deh,0a0h	; a811  . ......<~......
	defb 03eh,0a0h,07fh,0a1h,036h,0a0h,066h,0a0h,063h,0a4h,0c3h,03ch,0a0h,07eh,0a0h,0ffh	; a821  >...6.f.c..<.~..
	defb 0c3h,0e7h,018h,03eh,07dh,07fh,05eh,03dh,02dh,01fh,017h,03fh,07bh,07fh,0a2h,01bh	; a831  ...>}.^=-..?{...
	defb 033h,000h,0a3h,080h,0a2h,040h,0a1h,020h,038h,098h,080h,0a0h,000h,0a0h,006h,002h	; a841  3....@. 8.......
	defb 004h,0a0h,008h,03ch,07eh,07fh,0ffh,0fbh,0e3h,0e7h,018h,0a4h,000h,001h,003h,010h	; a851  ...<~...........
	defb 0a0h,020h,040h,0a0h,080h,0a0h,000h,03eh,03fh,027h,038h,0a2h,01fh,0f7h,09fh,0f8h	; a861  . @....>?'8.....
	defb 0e0h,0a1h,000h,080h,03fh,0a0h,07fh,0a3h,00dh,0a0h,0c0h,0a4h,080h,00dh,0a0h,01bh	; a871  ....?...........
	defb 033h,073h,0e3h,0a0h,0c3h,0a4h,000h,0a0h,080h,000h,01ch,01bh,0a5h,000h,080h,070h	; a881  3s.............p
	defb 00eh,001h,0a5h,000h,0f0h,0a0h,078h,03ch,07eh,07fh,0ffh,0fdh,0f1h,0f3h,00dh,078h	; a891  ......x<~......x
	defb 0a1h,068h,0e8h,0d0h,0e0h,080h,0a0h,01fh,01eh,0a0h,01fh,0a0h,00fh,01fh,003h,0a1h	; a8a1  .h..............
	defb 007h,002h,0a0h,005h,008h,01eh,03fh,07fh,0ffh,0f9h,0e1h,0f3h,0edh,0a3h,000h,0a1h	; a8b1  ......?.........
	defb 080h,0a0h,008h,0a2h,010h,0a0h,020h,07fh,03fh,01fh,00fh,0a0h,007h,00fh,01fh,080h	; a8c1  ...... .?.......
	defb 0a4h,000h,0e0h,020h,030h,038h,018h,0a2h,000h,03fh,0fch,0f8h,0a2h,00dh,01bh,0c0h	; a8d1  ... 08...?......
	defb 080h,0a4h,000h,01bh,033h,0a0h,063h,0a2h,0c3h,07eh,0a1h,0ffh,0dfh,0dbh,06ah,036h	; a8e1  ....3.c..~....j6
	defb 03ah,077h,07fh,0a0h,076h,0a1h,0b6h,0a1h,001h,0a0h,002h,0a0h,006h,000h,060h,0ech	; a8f1  :w..v.........`.
	defb 08eh,0a0h,0b2h,0a1h,054h,0a0h,0feh,0a9h,0beh,0a1h,0feh,000h,008h,0f4h,0f4h,0f4h	; a901  ....T...........
	defb 000h,003h,0b4h,0b4h,0b4h,000h,002h,0d4h,0d4h,0dbh,0dbh,0dbh,000h,004h,0b4h,0b4h	; a911  ................
	defb 0b4h,000h,003h,084h,084h,084h,000h,002h,074h,074h,000h,002h,0a4h,0a4h,0a4h,000h	; a921  ........tt......
	defb 003h,0b4h,0b4h,064h,064h,000h,00ah,0f4h,0f4h,000h,002h,0b4h,0b4h,000h,003h,084h	; a931  ...dd...........
	defb 084h,084h,000h,002h,074h,074h,000h,005h,0b4h,0b4h,0b4h,064h,064h,000h,002h,0d4h	; a941  ....tt.....dd...
	defb 0d4h,0d4h,0dbh,0dbh,0b4h,000h,003h,084h,084h,084h,000h,002h,074h,074h,000h,004h	; a951  ............tt..
	defb 0b4h,0b4h,000h,005h,0f4h,0f4h,0f4h,064h,064h,000h,004h,0f4h,0f4h,000h,002h,0d4h	; a961  .......dd.......
	defb 0d4h,0dbh,0dbh,0dbh,000h,004h,0b4h,0b4h,0b4h,000h,004h,0f4h,0f4h,000h,003h,084h	; a971  ................
	defb 084h,084h,074h,000h,003h,0b4h,0b4h,0b4h,000h,002h,074h,074h,000h,002h,0b4h,0b4h	; a981  ..t.......tt....
	defb 0b4h,074h,074h,074h,000h,005h,0b4h,0b4h,0b4h,064h,064h,000h,003h,0b4h,0b4h,084h	; a991  .ttt.....dd.....
	defb 084h,000h,008h,0f4h,0f4h,000h,004h,0b4h,0b4h,000h,002h,0d4h,0d4h,0dbh,0dbh,0dbh	; a9a1  ................
	defb 000h,004h,0b4h,0b4h,0b4h,000h,003h,084h,084h,084h,074h,000h,003h,0b4h,0b4h,0b4h	; a9b1  ..........t.....
	defb 0f4h,0d4h,0d4h,0d4h,000h,002h,0dbh,0dbh,0b4h,000h,004h,084h,084h,000h,004h,0f4h	; a9c1  ................
	defb 0f4h,000h,003h,084h,084h,084h,074h,000h,003h,084h,084h,084h,074h,000h,004h,0f4h	; a9d1  ......t.....t...
	defb 0f4h,074h,07fh,07fh,000h,002h,0b4h,0b4h,0b4h,074h,054h,0a4h,000h,005h,0b4h,0b4h	; a9e1  .t.......tT.....
	defb 0b4h,064h,064h,000h,004h,084h,084h,074h,074h,074h,000h,002h,0b4h,0b4h,0b4h,000h	; a9f1  .dd....ttt......
	defb 008h,0f4h,0f4h,094h,094h,000h,005h,0b4h,0b4h,0b4h,064h,064h,064h,007h,01fh,03fh	; aa01  ..........ddd..?
	defb 0a0h,07fh,0a0h,0ffh,0feh,0c0h,0f0h,0f8h,0a0h,0fch,0a1h,0feh,0a0h,0ffh,0a0h,07fh	; aa11  ................
	defb 03fh,01fh,0a0h,007h,0a0h,0feh,0a0h,0fch,0f8h,0f0h,0a0h,0c0h,0a5h,0ffh,0feh,0a5h	; aa21  ?...............
	defb 0ffh,000h,0adh,0feh,000h,03fh,07fh,0a4h,0ffh,000h,0c0h,0e0h,0f0h,0f8h,0fch,0feh	; aa31  .....?..........
	defb 0a0h,0ffh,07fh,03fh,01fh,00fh,007h,003h,001h,007h,01fh,03ch,070h,060h,0e1h,0c3h	; aa41  ...?.......<p`..
	defb 0c7h,0c0h,0f0h,078h,01ch,00ch,00eh,086h,0c6h,0c3h,0e1h,060h,070h,03ch,01fh,0a0h	; aa51  ...x.......`p<..
	defb 007h,086h,00eh,00ch,01ch,078h,0f0h,0a0h,0c0h,0a0h,0ffh,0a1h,0c0h,0a0h,0c7h,0c6h	; aa61  .....x..........
	defb 0a0h,0ffh,0a1h,000h,0a0h,0ffh,000h,0a6h,0c6h,0a0h,0feh,0a1h,006h,0a0h,0feh,000h	; aa71  ................
	defb 0a3h,0c6h,0a0h,0feh,000h,0a0h,0c7h,0a1h,0c0h,0a0h,0c7h,0c6h,0a0h,0ffh,0a1h,0c0h	; aa81  ................
	defb 0a0h,0ffh,000h,0a0h,0feh,0a4h,0c6h,0a0h,0ffh,0a1h,000h,0a0h,0ffh,001h,0a5h,0c6h	; aa91  ................
	defb 0c7h,0a5h,000h,0a0h,001h,003h,006h,00ch,038h,0a0h,0ffh,0afh,000h,000h,003h,00fh	; aaa1  ........8.......
	defb 01fh,0a0h,03fh,0a0h,07fh,0feh,0a5h,0ffh,000h,080h,0e0h,0f0h,0a0h,0f8h,0a0h,0fch	; aab1  ..?.............
	defb 0a0h,0f9h,0a0h,09fh,0ffh,0a0h,0f3h,07fh,0a0h,0e7h,0ffh,0a0h,03ch,0ffh,0a0h,0e7h	; aac1  ............<...
	defb 0a5h,0feh,0fch,06fh,037h,03fh,01ch,00fh,003h,000h,0c0h,000h,0c3h,09fh,0feh,0ffh	; aad1  ...o7?..........
	defb 0c7h,0feh,07ch,0ech,0d8h,0f8h,070h,0e0h,080h,001h,007h,0feh,0a2h,0c6h,0feh,07ch	; aae1  ..|...p........|
	defb 0feh,0a5h,000h,07ch,003h,0a5h,000h,0c0h,0afh,000h,0ach,000h,000h,003h,0f9h,0e9h	; aaf1  ...|............
	defb 0f9h,0e1h,000h,002h,0f9h,0e9h,0f9h,0e1h,0f1h,0e1h,000h,003h,0f6h,0e6h,0f6h,016h	; ab01  ................
	defb 000h,002h,0f1h,0e1h,0f6h,0e6h,0f6h,016h,000h,010h,0f1h,0e1h,000h,008h,0f9h,0e9h	; ab11  ................
	defb 000h,004h,0f8h,0e8h,000h,00bh,0fch,0fch,0fch,01ch,000h,003h,0fch,0fch,0fch,01ch	; ab21  ................
	defb 000h,007h,0fch,0fch,0fch,0f1h,000h,007h,0fch,0fch,0fch,0f1h,000h,003h,0fch,0fch	; ab31  ................
	defb 0fch,0f1h,000h,007h,0fch,0fch,0fch,0f1h,000h,007h,0fch,0fch,0fch,0f1h,000h,00bh	; ab41  ................
	defb 0fch,0fch,0fch,0f1h,000h,004h,01ch,01ch,0f1h,000h,00fh,0fch,0fch,0fch,000h,003h	; ab51  ................
	defb 0feh,0feh,0feh,0fch,000h,004h,0feh,0feh,000h,004h,0fch,0fch,000h,002h,0ech,0ech	; ab61  ................
	defb 0e1h,0e1h,0e1h,0c1h,0efh,0efh,000h,002h,0ech,0ech,0e1h,011h,000h,002h,0ech,0ech	; ab71  ................
	defb 0e1h,0e1h,0e1h,0c1h,000h,003h,0fch,0fch,0fch,01ch,0f1h,000h,003h,0fch,0fch,0fch	; ab81  ................
	defb 000h,008h,01ch,01ch,000h,004h,019h,019h,000h,004h,018h,018h,000h,004h,016h,016h	; ab91  ................
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
	defb 0a5h,000h,024h,0afh,025h,0a4h,025h,026h,0a1h,000h,000h,027h,0afh,028h,0a9h,028h	; acf1  ..$.%.%&...'.(.(
	defb 029h,0a0h,000h,02ah,0a4h,020h,048h,041h,04ch,020h,043h,04fh,055h,04eh,054h,052h	; ad01  )..*. HAL COUNTR
	defb 059h,020h,043h,04ch,055h,042h,0a4h,020h,02bh,0a0h,000h,024h,0afh,025h,0a9h,025h	; ad11  Y CLUB. +..$.%.%
	defb 026h,0a0h,000h,027h,0abh,028h,029h,027h,0abh,028h,029h,0a0h,000h,02ah,0a2h,020h	; ad21  &..'.()'.()..*. 
	defb 04fh,020h,055h,020h,054h,0a2h,020h,02bh,02ah,0a2h,020h,049h,0a0h,020h,04eh,0a3h	; ad31  O U T. +*. I. N.
	defb 020h,02bh,0a0h,000h,02ch,0abh,02dh,02eh,02ch,0abh,02dh,02eh,0a0h,000h,02ah,048h	; ad41   +..,.-.,.-...*H
	defb 04ch,020h,050h,041h,052h,020h,031h,050h,0a0h,020h,032h,050h,02bh,02ah,048h,04ch	; ad51  L PAR 1P. 2P+*HL
	defb 020h,050h,041h,052h,020h,031h,050h,0a0h,020h,032h,050h,02bh,0a0h,000h,02ch,0abh	; ad61   PAR 1P. 2P+..,.
	defb 02dh,02eh,02ch,0abh,02dh,02eh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh	; ad71  -.,.-...*. +*. +
	defb 0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh	; ad81  ..*. +*. +..*. +
	defb 02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h	; ad91  *. +..*. +*. +..
	defb 02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh	; ada1  *. +*. +..*. +*.
	defb 020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh	; adb1   +..*. +*. +..*.
	defb 020h,02bh,02ah,0abh,020h,02bh,0a0h,000h,02ah,0abh,020h,02bh,02ah,0abh,020h,02bh	; adc1   +*. +..*. +*. +
	defb 0a0h,000h,02ch,0abh,02dh,02eh,02ch,0abh,02dh,02eh,0a0h,000h,02ah,053h,043h,04fh	; add1  ..,.-.,.-...*SCO
	defb 052h,045h,03ah,0a1h,020h,03ah,0a1h,020h,02bh,02ah,053h,043h,04fh,052h,045h,03ah	; ade1  RE:. :. +*SCORE:
	defb 0a1h,020h,03ah,0a1h,020h,02bh,0a0h,000h,024h,0abh,025h,026h,024h,0abh,025h,026h	; adf1  . :. +..$.%&$.%&
	defb 0a0h,000h,027h,0afh,028h,0a9h,028h,029h,0a0h,000h,02ah,020h,054h,04fh,054h,041h	; ae01  ..'.(.()..* TOTA
	defb 04ch,0a0h,020h,03ah,020h,050h,04ch,041h,059h,045h,052h,031h,020h,03ah,020h,050h	; ae11  L. : PLAYER1 : P
	defb 04ch,041h,059h,045h,052h,032h,020h,02bh,0a0h,000h,02ah,0a0h,020h,053h,043h,04fh	; ae21  LAYER2 +..*. SCO
	defb 052h,045h,020h,03ah,0a7h,020h,03ah,0a7h,020h,02bh,0a0h,000h,024h,0afh,025h,0a9h	; ae31  RE :. :. +..$.%.
	defb 025h,026h,000h,000h,027h,0afh,028h,0a9h,028h,029h,0a0h,000h,02ah,0a4h,020h,048h	; ae41  %&..'.(.()..*. H
	defb 041h,04ch,020h,043h,04fh,055h,04eh,054h,052h,059h,020h,043h,04ch,055h,042h,0a4h	; ae51  AL COUNTRY CLUB.
	defb 020h,02bh,0a0h,000h,02ch,0afh,02dh,0a9h,02dh,02eh,0a0h,000h,02ah,052h,041h,04eh	; ae61   +..,.-.-...*RAN
	defb 04bh,0a2h,020h,050h,04ch,041h,059h,045h,052h,0a2h,020h,053h,043h,04fh,052h,045h	; ae71  K. PLAYER. SCORE
	defb 020h,048h,04fh,04ch,045h,02bh,0a0h,000h,02ch,0afh,02dh,0a9h,02dh,02eh,000h,000h	; ae81   HOLE+..,.-.-...
	defb 02ah,0a2h,020h,021h,0afh,020h,0a4h,020h,02bh,000h,000h,024h,0ach,025h,0ach,025h	; ae91  *. !. . +..$.%.%
	defb 026h,000h	; aea1

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
; DATOS sin identificar  0xafad..0xafc5  (24 bytes)
DATA_AFAD:
	defb 0cfh,0afh,0adh,0b0h,017h,0b1h,01ah,0b2h,0d7h,0b2h,004h,0b3h,05ch,0b3h,07ch,0b3h	; afad  ............\.|.
	defb 07ch,0b3h,07ch,0b3h,00ch,00bh,00ah,000h	; afbd  |.|.....

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
; DATOS sin identificar  0xb09e..0xb0a7  (9 bytes)
DATA_B09E:
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
	call L_70AD		;b142
	ld hl,(0cec4h)		;b145
	ld (0cf11h),hl		;b148
	ld a,h			;b14b
	ld (0c60eh),a		;b14c
	ld a,l			;b14f
	ld (0c611h),a		;b150
	call L_59AA		;b153
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
	call L_5359		;b223
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
	call L_70AD		;b24e
	ld a,(0cec5h)		;b251
	ld (0c60eh),a		;b254
	ld a,(0cec4h)		;b257
L_B25A:
	ld (0c611h),a		;b25a
	call L_59AA		;b25d
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
	call L_70AD		;b278
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
; DATOS sin identificar  0xb2a4..0xb2ac  (8 bytes)
DATA_B2A4:
	defb 0cbh,0b2h,0cfh,0b2h,0b5h,0b2h,0b9h,0b2h	; b2a4  ........

; ======================================================================
; CODIGO 0xb2ac..0xb2b5  (9 bytes)
; ======================================================================


L_B2AC:
	dec c			;b2ac
	jp z,L_BC0D		;b2ad
	dec c			;b2b0
	jp z,L_BC13		;b2b1
	ret			;b2b4

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb2b5..0xb2d7  (34 bytes)
DATA_B2B5:
	defb 006h,001h,018h,002h,006h,0ffh,03ah,025h,0c6h,04fh,080h,0e6h,007h,047h,079h,0e6h	; b2b5  ......:%.O...Gy.
	defb 0f8h,080h,032h,025h,0c6h,0c9h,006h,008h,018h,002h,006h,0f8h,03ah,025h,0c6h,080h	; b2c5  ..2%........:%..
	defb 018h,0f0h	; b2d5

; ======================================================================
; CODIGO 0xb2d7..0xb46c  (405 bytes)
; ======================================================================


L_B2D7:
	call L_B229		;b2d7
L_B2DA:
	xor a			;b2da
	ld (0c613h),a		;b2db
	call L_59AA		;b2de
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
	call L_70AD		;b2f4
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
	call L_6F49		;b3fc
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
; DATOS sin identificar  0xb46c..0xb46f  (3 bytes)
DATA_B46C:
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
; DATOS sin identificar  0xb501..0xb528  (39 bytes)
DATA_B501:
	defb 00dh,00ch,00bh,00ah,009h,008h,007h,006h,005h,004h,003h,002h,001h,000h,00dh,00ch	; b501  ................
	defb 00bh,00ah,009h,007h,006h,004h,003h,002h,001h,000h,00ch,00bh,00ah,009h,008h,007h	; b511  ................
	defb 006h,005h,004h,003h,002h,001h,000h	; b521

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
; DATOS sin identificar  0xb603..0xb60b  (8 bytes)
DATA_B603:
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
; DATOS sin identificar  0xb7a3..0xb7af  (12 bytes)
DATA_B7A3:
	defb 050h,0d1h,000h,000h,054h,000h,008h,058h,054h,000h,010h,058h	; b7a3  P...T..XT..X

; ======================================================================
; CODIGO 0xb7af..0xb885  (214 bytes)
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
	jp L_59AA		;b7e4
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

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb885..0xb898  (19 bytes)
DATA_B885:
	defb 0e5h,02ah,0f9h,0ceh,07ch,087h,067h,087h,087h,084h,085h,0a7h,028h,002h,0feh,013h	; b885  .*..|.g.....(...
	defb 03fh,0e1h,0c9h	; b895

; ======================================================================
; CODIGO 0xb898..0xba81  (489 bytes)
; ======================================================================


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
; DATOS sin identificar  0xba81..0xba91  (16 bytes)
DATA_BA81:
	defb 0f8h,0e9h,002h,003h,0e9h,0d7h,002h,004h,0e9h,0d7h,002h,003h,0f8h,0e9h,002h,004h	; ba81  ................

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
; DATOS sin identificar  0xbc3d..0xbdf1  (436 bytes)
DATA_BC3D:
	defb 002h,018h,048h,04fh,04ch,045h,03ah,040h,043h,018h,053h,045h,054h,043h,048h,052h	; bc3d  ..HOLE:@C.SETCHR
	defb 040h,063h,018h,050h,041h,052h,040h,083h,018h,044h,049h,053h,054h,03eh,040h,0c3h	; bc4d  @c.PAR@..DIST>@.
	defb 018h,053h,048h,04fh,054h,040h,0e3h,018h,04dh,04fh,056h,045h,040h,063h,019h,057h	; bc5d  .SHOT@..MOVE@c.W
	defb 049h,04eh,044h,040h,001h,018h,027h,028h,028h,028h,028h,028h,028h,028h,029h,040h	; bc6d  IND@..'((((((()@
	defb 021h,018h,02ah,048h,04fh,04ch,045h,020h,020h,020h,02bh,040h,041h,018h,02ah,020h	; bc7d  !.*HOLE   +@A.* 
	defb 020h,020h,020h,020h,03fh,020h,02bh,040h,061h,018h,02ah,020h,050h,041h,052h,020h	; bc8d      ? +@a.* PAR 
	defb 020h,020h,02bh,040h,081h,018h,024h,025h,025h,025h,025h,025h,025h,025h,026h,040h	; bc9d    +@..$%%%%%%%&@
	defb 0c3h,018h,053h,041h,056h,045h,040h,0e3h,018h,04ch,04fh,041h,044h,040h,003h,019h	; bcad  ..SAVE@..LOAD@..
	defb 043h,04fh,050h,059h,040h,023h,019h,053h,057h,041h,050h,040h,043h,019h,043h,04ch	; bcbd  COPY@#.SWAP@C.CL
	defb 045h,041h,052h,040h,07ah,07bh,086h,08ah,08bh,087h,07eh,07fh,07ch,07dh,088h,08ch	; bccd  EAR@z{....~.|}..
	defb 08dh,089h,082h,083h,092h,093h,090h,091h,08eh,08fh,084h,085h,009h,00bh,00ch,00ah	; bcdd  ................
	defb 078h,079h,080h,081h,001h,002h,003h,004h,005h,006h,007h,008h,000h,094h,0b2h,0b3h	; bced  xy..............
	defb 0aeh,0afh,09ch,09dh,097h,096h,0b0h,0b1h,0ach,0adh,0a0h,0a1h,098h,099h,0a4h,0a8h	; bcfd  ................
	defb 0a9h,0a5h,0a2h,0a3h,09ah,09bh,0a6h,0aah,0abh,0a7h,09eh,09fh,0b7h,0bdh,0bfh,0b8h	; bd0d  ................
	defb 0d0h,0d1h,0c6h,0c7h,0bbh,0b5h,0b4h,0bch,0c8h,0b6h,0cah,0cbh,0b9h,0beh,0bah,0c9h	; bd1d  ................
	defb 0ceh,0cfh,0c2h,0c3h,0c4h,0c5h,0cch,0cdh,0c0h,0c1h,079h,079h,060h,062h,064h,066h	; bd2d  ..........yy`bdf
	defb 068h,06ah,06ch,06eh,061h,063h,065h,067h,069h,06bh,06dh,06fh,076h,074h,070h,073h	; bd3d  hjlnacegikmovtps
	defb 00eh,00dh,0f8h,0f9h,077h,075h,071h,072h,00fh,095h,079h,079h,0d9h,0d8h,0dah,0dbh	; bd4d  ....wuqr..yy....
	defb 0d7h,0dch,0ddh,0deh,0dfh,0e0h,0e1h,0e2h,0e3h,0e4h,0e5h,0e6h,0e7h,0e8h,0ech,0e9h	; bd5d  ................
	defb 0eah,0f2h,0edh,0ebh,0ebh,0f3h,0ech,0e9h,0eah,0f4h,0edh,0ebh,0ebh,0f5h,0f0h,0e9h	; bd6d  ................
	defb 0eah,0f4h,0f1h,0ebh,0ebh,0f5h,0eeh,0e9h,0eah,0f2h,0efh,0ebh,0ebh,0f3h,0eeh,0e9h	; bd7d  ................
	defb 0eah,0f6h,0efh,0ebh,0ebh,0f7h,059h,0bdh,05fh,0bdh,065h,0bdh,06bh,0bdh,073h,0bdh	; bd8d  ......Y._.e.k.s.
	defb 07bh,0bdh,083h,0bdh,08bh,0bdh,023h,019h,050h,041h,052h,03ah,040h,0e7h,019h,03fh	; bd9d  {.....#.PAR:@..?
	defb 040h,065h,019h,031h,053h,054h,040h,085h,019h,032h,04eh,044h,040h,0a5h,019h,033h	; bdad  @e.1ST@..2ND@..3
	defb 052h,044h,040h,042h,01ah,04eh,041h,04dh,045h,03ah,040h,062h,01ah,047h,052h,045h	; bdbd  RD@B.NAME:@b.GRE
	defb 045h,04eh,040h,083h,01ah,04fh,052h,020h,054h,045h,045h,040h,0a2h,01ah,04eh,04fh	; bdcd  EN@..OR TEE@..NO
	defb 054h,040h,0c3h,01ah,046h,04fh,055h,04eh,044h,03eh,040h,062h,01ah,053h,055h,052h	; bddd  T@..FOUND>@b.SUR
	defb 045h,03eh,03eh,040h	; bded

; ======================================================================
; CODIGO 0xbdf1..0xbe0e  (29 bytes)
; ======================================================================


L_BDF1:
	ld (0cf25h),sp		;bdf1
	ld (0cf21h),hl		;bdf5
	ld (0f87dh),de		;bdf8
	ld (0fcbfh),hl		;bdfc
	call L_BE16		;bdff
	ld hl,0be0eh		;be02
	push hl			;be05
	ld hl,(0cf21h)		;be06
	push hl			;be09
	push hl			;be0a
	jp L_6FD7		;be0b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe0e..0xbe16  (8 bytes)
DATA_BE0E:
	defb 0cdh,0e7h,000h,0cdh,01bh,0beh,0a7h,0c9h	; be0e  ........

; ======================================================================
; CODIGO 0xbe16..0xbe63  (77 bytes)
; ======================================================================


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

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe63..0xbe85  (34 bytes)
DATA_BE63:
	defb 07eh,0a7h,0c8h,0cdh,0a2h,000h,023h,018h,0f7h,050h,075h,073h,068h,020h,061h,06eh	; be63  ~.....#..Push an
	defb 079h,020h,04bh,065h,079h,020h,021h,021h,000h,0edh,07bh,025h,0cfh,0cdh,01bh,0beh	; be73  y Key !!..{%....
	defb 037h,0c9h	; be83

; ======================================================================
; CODIGO 0xbe85..0xbef0  (107 bytes)
; ======================================================================


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
; DATOS sin identificar  0xbef0..0xbf14  (36 bytes)
DATA_BEF0:
	defb 04bh,0d0h,02bh,0d2h,00bh,0d4h,0ebh,0d5h,0cbh,0d7h,0abh,0d9h,08bh,0dbh,06bh,0ddh	; bef0  K.+...........k.
	defb 04bh,0dfh,02bh,0e1h,00bh,0e3h,0ebh,0e4h,0cbh,0e6h,0abh,0e8h,08bh,0eah,06bh,0ech	; bf00  K.+...........k.
	defb 04bh,0eeh,02bh,0f0h	; bf10

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
; DATOS sin identificar  0xbf78..0xbf8e  (22 bytes)
DATA_BF78:
	defb 0f5h,0e5h,021h,066h,0c0h,022h,000h,0e0h,021h,08ah,0c0h,022h,002h,0e0h,03eh,001h	; bf78  ..!f."..!.."..>.
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
; DATOS sin identificar  0xbff2..0xc000  (14 bytes)
DATA_BFF2:
	defb 079h,094h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff2  y.............
