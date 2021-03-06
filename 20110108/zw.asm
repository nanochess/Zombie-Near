        ;
        ; Zombie wars
        ;
        ; por Oscar Toledo Guti�rrez
        ;
        ; (c) Copyright Oscar Toledo Guti�rrez 2011
        ;
        ; Creaci�n: 06-ene-2011.
        ; Revisi�n: 07-ene-2011. Ya no ocurren movimientos desalineados. Los
        ;                        niveles se navegan ahora como laberintos.
        ;                        Los cuadros sin fondo toman info. de
        ;                        alrededor.
        ; Revisi�n: 08-ene-2011. Los sprites de los jugadores se definen
        ;                        sobre la marcha para hacer espacio a m�s
        ;                        sprites. Permite agregar "adornos" y objetos
        ;                        a los niveles. Permite recoger la llave y
        ;                        rescatar a los cient�ficos. Permite usar la
        ;                        llave para traspasar puerta. Se implementa
        ;                        el zombie tipo 3 que persigue al jugador.
        ;                        Se implementa el disparo. Ya visualiza el
        ;                        sprite del gran jefe.
        ;

        ORG $4000

        FNAME "ZOMBIWAR.ROM"

        ;
        ; Por hacer:
        ; o Integrar el gran jefe
        ; o La megapresentaci�n espectacular
        ; o El megafinal espectacular.
        ; o La m�sica de fondo.
        ; o Los efectos de sonido.
        ;
        ; Ya hecho:
        ; o Urge el disparo (08-ene-2011)
        ; o Desarrollar el zombie tipo 3 (08-ene-2011)
        ; o Implementar las llaves (08-ene-2011)
        ; o Dispersar zombies por los niveles (08-ene-2011)
        ; o Dispersar cient�ficos por los niveles. (08-ene-2011)
        ; o Decorar los niveles (08-ene-2011)
        ; o Sprites decorativos para esqueletitos y sangrita. (08-ene-2011)
        ; o Definir los sprites de los jugadores en tiempo real,
        ;   para hacer m�s espacio para figuras. (08-ene-2011)
        ; o El laberinto y m�s gr�ficas. (07-ene-2011)
        ; o Tener un engine b�sico y gr�ficas preliminares. (06-ene-2011)
        ; o Un mont�n de cosas.
        ;

        ;
        ; En el Z80 la instrucci�n JR es m�s lenta que JP cuando se toma
        ; el salto, as� que he preferido usar solo JP, �cada ciclo cuenta!
        ;

        ;
        ; Al principio iba a ser un avance por pisos, sin retroceso, pero
        ; como quedaron tan peque�os lo hice por habitaciones, pero se
        ; qued� el nombre de pisos :)
        ;

        DB "AB"         ; Para que el MSX reconozca el cartucho
        DW INICIO

        DB "Zombie wars, MSX game, "
        DB "(c) Copyright 2011 by Oscar Toledo Gutierrez, "
        DB "http://nanochess.110mb.com/",0

DISSCR: EQU $0041       ; Desactiva la pantalla
ENASCR: EQU $0044       ; Activa la pantalla
WRTVDP: EQU $0047       ; Escribe un registro VDP B=Dato, C=Reg
RDVRM:  EQU $004A       ; Lee VRAM HL=Dir, A=Dato
WRTVRM: EQU $004D       ; Escribe VRAM HL=Dir, A=Dato
SETRD:  EQU $0050       ; Pone dir. VDP para leer (HL)
SETWRT: EQU $0053       ; Pone dir. VDP para escribir (HL)
FILVRM: EQU $0056       ; Rellena VRAM, HL=Dir. BC=Total A=Dato
LDIRMV: EQU $0059       ; Copia de VRAM, HL=VRAM DE=Mem BC=Tam
LDIRVM: EQU $005C       ; Copia a VRAM, HL=Mem DE=VRAM BC=Tam
WRTPSG: EQU $0093       ; Escribe PSG, A=Reg. E=Dato
GTSTCK: EQU $00D5       ; Lee joystick, A=Joystick. A=Dir.
GTTRIG: EQU $00D8       ; Lee botones, A=Cual, A=$FF oprimido
RSLREG: EQU $0138       ; Lee estatus slot en A
WSLREG: EQU $013B       ; Escribe slot con A
RDVDP:  EQU $013E       ; Lee el registro de estatus del VDP en A

        ;
        ; Cuantos monigotes y adornos
        ;
MAX_MONIGOTES:  equ 12

        ;
        ; Offsets de variables de jugador
        ;
d_x:            equ 0   ; Coordenada X
d_y:            equ 1   ; Coordenada Y  
d_sprite:       equ 2   ; Sprite
d_color:        equ 3   ; Color
d_recarga:      equ 4   ; Tiempo para recarga de disparo
d_nivel:        equ 5   ; Nivel de juego
d_velocidad:    equ 6   ; Velocidad.
d_energia:      equ 7   ; Energ�a
d_dx:           equ 4   ; Monigotes, direcci�n X
d_dy:           equ 5   ; Monigotes, direcci�n Y
d_paso:         equ 8   ; Paso
d_tipo:         equ 9   ; Monigotes, tipo
d_ultimo:       equ 10  ; Ultimo movimiento.
d_offset:       equ 12  ; Offset de pantalla (p�gina oculta)
d_refx:         equ 14  ; Referencia X (base nivel)
d_refy:         equ 15  ; Referencia Y (base nivel)
d_real:         equ 16  ; Offset de nivel (datos reales)
d_moni:         equ 18  ; Offset de lista de monigotes
d_vidas:        equ 20  ; Vidas
d_espera:       equ 21  ; Espera antes de m�s da�o.
d_basex:        equ 22  ; Base X de donde apareci�.
d_basey:        equ 23  ; Base Y de donde apareci�.
d_puntos:       equ 24  ; Puntos acumulados
d_objeto:       equ 27  ; Indica si lleva objetos (actualmente solo llave)
d_trans:        equ 28  ; Ubicaci�n del transportador (p�gina oculta)

BASE_MOSAICOS:  equ $40 ; Caracter base de mosaicos gr�ficos.

tabla_modo_2:
        DB $02          ; Registro 0
        DB $E2          ; Registro 1
        DB $0F          ; Registro 2 - Base pantalla $3C00
        DB $FF          ; Registro 3 - Tabla color $2000
        DB $03          ; Registro 4 - Tabla caracteres $0000
        DB $7F          ; Registro 5 - Tabla sprites $3F80
        DB $03          ; Registro 6 - Figuras sprites $1800
        DB $01          ; Registro 7 - Borde negro

inicio:
        ;
        ; Inicia la pila e intercepta vector de interrupci�n
        ;
        di
        ld sp,pila
        ld a,$c3
        ld ($fd9a),a
        ld hl,vector_int
        ld ($fd9b),hl
        ;
        ; Borra todas las variables habidas y por haber
        ;
        ld hl,$e000
        ld d,h
        ld e,l
        inc de
        ld bc,4095
        ld (hl),0
        ldir
        ei
        ;
        ; Mapea el resto del ROM en $8000-$BFFF
        ;
        call RSLREG
        and $CF
        ld b,a
        and $0C
        rlca
        rlca
        or b
        call WSLREG
        ;
        ; Introducci�n del juego
        ;
        call vdp_modo_2
        call presentacion
      
        ;
        ; Entrada al juego
        ;
        xor a
        ld (modo),a
        ld hl,letras
        ld de,$0000
        ld bc,512
        call ldirvm
        ld hl,letras
        ld de,$0800
        ld bc,512
        call ldirvm
        ld hl,letras
        ld de,$1000
        ld bc,512
        call ldirvm
        ld hl,color_letras
        ld de,$2000
        ld bc,512
        call ldirvm
        ld hl,color_letras
        ld de,$2800
        ld bc,512
        call ldirvm
        ld hl,color_letras
        ld de,$3000
        ld bc,512
        call ldirvm
        ld hl,graf_bitmap
        ld de,$0200
        ld bc,1536
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$0a00
        ld bc,1536
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$1200
        ld bc,1536
        call LDIRVM
        ld hl,graf_color
        ld de,$2200
        ld bc,1536
        call LDIRVM
        ld hl,graf_color
        ld de,$2a00
        ld bc,1536
        call LDIRVM
        ld hl,graf_color
        ld de,$3200
        ld bc,1536
        call LDIRVM
        ld hl,pantalla
        ld b,0 ; o sea 256
.2:     ld (hl),0
        inc hl
        djnz .2
.3:     ld (hl),0
        inc hl
        djnz .3
.4:     ld (hl),0
        inc hl
        djnz .4
        halt
        ld a,1
        ld (modo),a
        ld hl,jug1_inicial
        ld de,jug1
        ld bc,30
        ldir
        ld hl,jug2_inicial
        ld de,jug2
        ld bc,30
        ldir   
        ld ix,jug1
        call carga_nivel
        ld ix,jug2
        call carga_nivel
        ld ix,jug1
        call actualiza_indicadores
        ld ix,jug2
        call actualiza_indicadores
.1:     halt
        call actualiza_sprites
        call maneja_entrada
        JR .1

        ;
        ; Vector de interrupci�n, llamado 50 o 60 veces por segundo
        ; Todos los registros son salvados por el BIOS MSX
        ;
vector_int:
        ;
        ; Limpia la interrupci�n
        ;
        call RDVDP
        ld a,(modo)
        cp 1
        jp nz,.2
        ld bc,sprites_heroes
        ld a,(sprites+2)
        push af
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ex de,hl
        ld a,(sprites+6)
        push af
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ld b,h
        ld c,l
        xor a
        ld (sprites+2),a
        ld a,4
        ld (sprites+6),a
        ;
        ; Define sprites heroes
        ;
        ld hl,$1800
        call SETWRT
        ld h,b
        ld l,c
        ex de,hl
        ld c,$98
        ld b,32
        outi
        jp nz,$-2
        ex de,hl
        ld b,32
        outi
        jp nz,$-2
        ;
        ; Actualiza los sprites
        ;
        ld hl,$3f80
        call SETWRT
        ld hl,sprites
        ld c,$98
        ld b,128
        outi
        jp nz,$-2
        ld hl,$3c00
        call SETWRT
        ld hl,pantalla
        ld c,$98
        ld b,128
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        pop af
        ld (sprites+6),a
        pop af
        ld (sprites+2),a
.2:     ld a,($002B)
        and $80         ; �60 hz?
        jp nz,.1        ; No, salta.
        ld hl,ciclo
        inc (hl)
        ld a,(hl)
        cp 6
        jp nz,.1
        ld (hl),0       ; Se come 1 de cada 6 ciclos
        ret

        ;
        ; Aqu� cree que son 50 ciclos por segundo
        ;
.1:     ld a,(modo)
        cp 1
        ret nz
        ;
        ; Incrementa ticks transcurridos
        ;
        ld hl,ticks
        inc (hl)
        ret

limpia_sprites:
        ld hl,sprites
        ld d,h
        ld e,l
        inc de
        ld bc,127
        ld (hl),$d1
        ldir
        LD HL,$3F80
        LD A,$D1
        LD BC,$0080
        JP FILVRM

        ;
        ; Pone el modo de alta resoluci�n
        ;
vdp_modo_2:
        LD HL,tabla_modo_2
        LD BC,$0800
.1:     PUSH BC
        LD B,(HL)
        CALL WRTVDP
        POP BC
        INC C
        INC HL
        DJNZ .1
        CALL limpia_sprites
        LD HL,$0000
        LD BC,$1800
        XOR A
        CALL FILVRM
        LD HL,$2000
        LD BC,$1800
        XOR A
        CALL FILVRM
        LD HL,figuras_sprites
        LD DE,$1800
        LD BC,$0800
        CALL LDIRVM
        LD HL,$3C00
.2:     LD A,L
        CALL WRTVRM
        INC HL
        LD A,H
        CP $3F
        JP NZ,.2
        RET

        ;
        ; Carga un nivel
        ;
carga_nivel:
        xor a
        ld (ix+d_trans),a
        ld (ix+d_trans+1),a
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,MAX_MONIGOTES*16
        xor a
.3:     ld (hl),a
        inc hl
        djnz .3
        ld a,(ix+d_nivel)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        ld d,h
        ld e,l
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,de
        ld de,niveles
        add hl,de
        ld (ix+d_real),l
        ld (ix+d_real+1),h
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld c,6
.1:     push de
        ld b,12
.2:     push bc
        ld a,(hl)
        cp 99
        call z,inicio_jugador
        cp 98
        call z,final_jugador
        cp 97
        call z,anota_transportador
        cp 80
        call nc,agrega_monigote
        add a,a
        add a,a
        add a,BASE_MOSAICOS
        ld (de),a
        inc de
        inc a
        ld (de),a
        ex de,hl
        ld bc,31
        add hl,bc
        inc a
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
        ld bc,-31
        add hl,bc
        ex de,hl
        pop bc
        inc hl
        djnz .2
        pop de
        push bc
        ld bc,64
        ex de,hl
        add hl,bc
        ex de,hl
        pop bc
        dec c
        jp nz,.1
        ret

        ;
        ; Anota un transportador
        ;
anota_transportador:
        ld (ix+d_trans),e
        ld (ix+d_trans+1),d
        jp estima_cuadro

        ;
        ; Anota el inicio de un jugador
        ;
inicio_jugador:
        ld a,12
        sub b
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refx)
        ld (ix+d_x),a
        ld (ix+d_basex),a
        ld a,6
        sub c
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refy)
        ld (ix+d_y),a
        ld (ix+d_basey),a
final_jugador:
        jp estima_cuadro

        ;
        ; Agrega un monigote
        ;
agrega_monigote:
        push bc
        push de
        push hl
        push af
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16        ; Primera entrada reservada para bala
        add hl,de
        ; Busca una entrada libre
.1:     ld a,(hl)
        or a
        jp z,.2
        ld de,16
        add hl,de
        jp .1

.2:     ld a,12
        sub b
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,6
        sub c
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refy)
        ld (hl),a
        inc hl
        pop af
        push hl
        sub 80
        ld hl,tabla_monigotes
        ld e,a
        ld d,0
        add hl,de
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ex (sp),hl
        ret

tabla_monigotes:
        dw zombie3_izq  ; 80 Zombie 3 izq.
        dw zombie3_der  ; 81 Zombie 3 der.
        dw zombie3_arr  ; 82 Zombie 3 arriba
        dw zombie3_aba  ; 83 Zombie 3 abajo
        dw llave        ; 84 Llave del laboratorio
        dw cientifico   ; 85 Cient�fico
        dw cientifica   ; 86 Cient�fica (pero faltan sprites)
        dw mancha       ; 87 Una manchita de sangre
        dw esqueleto    ; 88 Medio esqueletito
        dw mano_suelta  ; 89 Una manita suelta
        dw zombie1_izq  ; 90 Zombie 1 izq.
        dw zombie1_der  ; 91 Zombie 1 der.
        dw zombie2_izq  ; 92 Zombie 2 izq.
        dw zombie2_der  ; 93 Zombie 2 der.
        dw zombie2_arr  ; 94 Zombie 2 arriba
        dw zombie2_aba  ; 95 Zombie 2 abajo
        dw temporal     ; 96 Puerta de entrada a cuarto zombie jefe.
        dw nada         ; 97 Puerta con llave
        dw nada         ; 98 Conexi�n con otro piso
        dw nada         ; 99 Sin uso

        ;
        ; C�digo temporal para poder ver el enorme monstruo que dibuj� :)
        ;
temporal:
        dec hl
        ld a,$28
        add a,(ix+d_refy)
        ld (hl),a
        dec hl
        ld a,$40
        add a,(ix+d_refx)
        ld (hl),a
        inc hl
        inc hl
        ld a,$80
        ld de,$00ff
        ld bc,$0104
        ex af,af'
        ld a,15
        ex af,af'
        jp anota_monigote

nada:
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        pop hl
        pop de
        pop bc
        jp estima_cuadro

llave:
        ld a,$10
        ld de,$0000
        ld bc,$0107
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

cientifico:
        ld a,$30
        ld de,$0000
        ld bc,$0306
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

cientifica:
        ld a,$30
        ld de,$0000
        ld bc,$0306
        ex af,af'
        ld a,9
        ex af,af'
        jp anota_monigote

mancha:
        ld a,$14
        ld de,$0000
        ld bc,$0105
        ex af,af'
        ld a,3
        ex af,af'
        jp anota_monigote

esqueleto:
        ld a,$18
        ld de,$0000
        ld bc,$0105
        ex af,af'
        ld a,15
        ex af,af'
        jp anota_monigote

mano_suelta:
        ld a,$1c
        ld de,$0000
        ld bc,$0105
        ex af,af'
        ld a,15
        ex af,af'
        jp anota_monigote

zombie1_izq:
        ld a,$50
        ld de,$00ff
        ld bc,$0301
        ex af,af'
        ld a,3
        ex af,af'
        jp anota_monigote

zombie1_der:
        ld a,$40
        ld de,$0001
        ld bc,$0301
        ex af,af'
        ld a,3
        ex af,af'
        jp anota_monigote

zombie2_izq:
        ld a,$50
        ld de,$00ff
        ld bc,$0202
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie2_der:
        ld a,$40
        ld de,$0001
        ld bc,$0202
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie2_arr:
        ld a,$70
        ld de,$ff00
        ld bc,$0202
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie2_aba:
        ld a,$60
        ld de,$0100
        ld bc,$0202
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie3_izq:
        ld a,$50
        ld de,$00ff
        ld bc,$0103
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie3_der:
        ld a,$40
        ld de,$0001
        ld bc,$0103
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie3_arr:
        ld a,$70
        ld de,$ff00
        ld bc,$0103
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie3_aba:
        ld a,$60
        ld de,$0100
        ld bc,$0103
        ex af,af'
        ld a,11
        ex af,af'
;       jp anota_monigote

anota_monigote:
        ld (hl),a       ; Sprite
        inc hl
        ex af,af'
        ld (hl),a       ; Color
        ex af,af'
        inc hl
        ld (hl),e       ; Dir. X
        inc hl
        ld (hl),d       ; Dir. Y
        inc hl
        ld (hl),b       ; Velocidad
        inc hl
        ld a,c
        cp 4
        jp nz,.1
        ld a,24         ; 25 impactos para jefe zombie
.1:     add a,1
        ld (hl),a       ; Energ�a (2, 3 y 4 por tipo de monstruo)
        inc hl
        ld (hl),b       ; Paso actual (copia de velocidad)
        inc hl
        ld (hl),c       ; Tipo de monigote
        inc hl
        xor a
        ld (hl),a       ; Ultimo movimiento
        inc hl
        ld (hl),a
        inc hl
        inc hl
        inc hl
        ld a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,(ix+d_refy)
        ld (hl),a
        inc hl
        pop hl
        pop de
        pop bc
        ;
        ; No es posible poner fondo en el mismo cuadro cuando se escoge
        ; un objeto, adorno o monigote, as� que lo deriva de los
        ; alrededores
        ;
estima_cuadro:
        ld a,c
        cp 6
        jp z,.1
        push de
        push hl
        ld de,-12
        add hl,de
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.1:     ld a,b
        cp 12
        jp z,.2
        push de
        push hl
        dec hl
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.2:     ld a,b
        cp 1
        jp z,.3
        push de
        push hl
        inc hl
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.3:     ld a,c
        cp 1
        jp z,.4
        push de
        push hl
        ld de,12
        add hl,de
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.4:     xor a
        ret

        ;
        ; Actualiza los indicadores
        ;
actualiza_indicadores:
        ld l,(ix+d_offset)
        ld h,(ix+d_offset+1)
        ld a,(ix+d_refx)
        or a
        ld de,32-8
        jp nz,.1
        ld de,25+32
.1:     add hl,de
        push hl
        inc hl
        inc hl
        ld a,(ix+d_refx)
        or a
        ld a,$2B        ; 1
        jp z,.2
        ld a,$2C        ; 2
.2:     ld (hl),a
        inc hl
        ld (hl),$15     ; U
        inc hl
        ld (hl),$10     ; P
        pop hl
        ld de,32
        add hl,de
        push hl
        ld a,(ix+d_puntos)
        call dos_digitos
        ld a,(ix+d_puntos+1)
        call dos_digitos
        ld a,(ix+d_puntos+2)
        call dos_digitos
        ld (hl),$20     ; Un cero de relleno
        pop hl
        ld de,64
        add hl,de
        push hl
        ld (hl),$05     ; E
        inc hl
        ld (hl),$0e     ; N
        inc hl
        ld (hl),$05     ; E
        inc hl
        ld (hl),$12     ; R
        inc hl
        ld (hl),$07     ; G
        inc hl
        ld (hl),$19     ; Y
        pop hl
        ld de,32
        add hl,de
        push hl
        ld a,(ix+d_energia)
        or a
        ld b,a
        ld a,$1c
        jp z,.3
        ld a,$1b
.3:     ld (hl),a
        inc hl
        ld c,1
.4:     inc c
        ld a,b
        cp c
        ld a,$1e
        jp c,.5
        ld a,$1d
.5:     ld (hl),a
        inc hl
        ld a,c
        cp 6
        jp nz,.4
        ld (hl),$1f
        pop hl
        ld de,64
        add hl,de
        push hl
        inc hl
        ld (hl),$06     ; F
        inc hl
        ld (hl),$0C     ; L
        inc hl
        ld (hl),$0F     ; O
        inc hl
        ld (hl),$0F     ; O
        inc hl
        ld (hl),$12     ; R
        pop hl
        ld de,32
        add hl,de
        push hl
        ld a,(ix+d_nivel)
        inc a
        inc hl
        inc hl
        ld b,100
        call digito_decimal
        ld b,10
        call digito_decimal
        ld b,1
        call digito_decimal
        pop hl
        ld de,65
        add hl,de
        ld a,(ix+d_vidas)
        add a,$20
        cp $1f
        jp nz,.6
        ld a,$20
.6:     ld (hl),a
        inc hl
        inc hl
        ld (hl),$2a     ; Corazoncito
        inc hl
        inc hl
        bit 0,(ix+d_objeto)
        ld (hl),$00
        ret z
        ld (hl),$2d     ; Llave
        ret

        ;
        ; Digito decimal
        ;
digito_decimal:
        ld c,$1f
.1:     inc c
        sub b
        jp nc,.1
        add a,b
        ld (hl),c
        inc hl
        ret

        ;
        ; Dibuja dos digitos
        ;
dos_digitos:
        push af
        rrca
        rrca
        rrca
        rrca
        call un_digito
        pop af
un_digito:
        and $0f
        add a,$20
        ld (hl),a
        inc hl
        ret

        ;
        ; Actualiza los sprites
        ;
actualiza_sprites:
        ld de,sprites
        ld bc,sprites+16
        ld ix,jug1
        call actualiza_jugador
        ld de,sprites+4
        ld bc,sprites+64
        ld ix,jug2
        call actualiza_jugador
        ret

        ;
        ; Actualiza el sprite de un jugador
        ;
actualiza_jugador:
        ;
        ; Actualiza la animaci�n del transportador
        ;
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        jp z,.7
        push de
        ld a,(ticks)
        and $0c
        add a,BASE_MOSAICOS+$90
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
        ld de,31
        add hl,de
        inc a
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
        pop de
        ;
        ; Actualiza el sprite correspondiente al jugador
        ;
.7:     ld a,(ix+d_vidas)
        cp $ff
        jp nz,.1
        ld a,$d1
        ld (de),a
        jp .2

.1:     ld a,(ix+d_y)
        dec a
        ld (de),a
        inc de
        ld a,(ix+d_x)
        ld (de),a
        inc de
        ld a,(ix+d_sprite)
        ld (de),a
        inc de
        ld a,(ix+d_espera)
        and 8
        ld a,(ix+d_color)
        jp z,.6
        ld a,$0f
.6:     ld (de),a
        ;
        ; Actualiza sprites de monigotes/adornos/objetos
        ;
.2:     ld d,b
        ld e,c
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,8
.3:     push hl
        ld a,l
        add a,9
        ld l,a
        ld a,h
        adc a,0
        ld h,a
        ld a,(hl)
        ld c,a
        pop hl
        or a
        jp nz,.4
        ld a,$d1
        ld (de),a
        inc de
        inc de
        inc de
        inc de
        push bc
        ld bc,16
        add hl,bc
        pop bc
        jp .5

.4:     ld a,(hl)
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        dec a
        ld (de),a
        inc de
        inc de
        inc hl
        ld a,(hl)
        ld (de),a
        inc de
        inc hl
        ld a,(hl)
        ld (de),a
        inc de
        ld a,c
        cp 4    ; �Zombie jefe?
        jp nz,.8
        ;
        ; Segundo cuadro en X+16,Y
        ;
        dec hl
        dec hl
        dec hl
        ld a,(hl)
        add a,16
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        dec a
        ld (de),a
        inc de
        inc de
        inc hl
        ld a,(hl)
        add a,4
        ld (de),a
        inc de
        inc hl
        ld a,(hl)
        ld (de),a
        inc de
        ;
        ; Tercer cuadro en X,Y+16
        ;
        dec hl
        dec hl
        dec hl
        ld a,(hl)
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        add a,15
        ld (de),a
        inc de
        inc de
        inc hl
        ld a,(hl)
        add a,8
        ld (de),a
        inc de
        inc hl
        ld a,(hl)
        ld (de),a
        inc de
        ;
        ; Cuarto cuadro en X+16,Y+16
        ;
        dec hl
        dec hl
        dec hl
        ld a,(hl)
        add a,16
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        add a,15
        ld (de),a
        inc de
        inc de
        inc hl
        ld a,(hl)
        add a,12
        ld (de),a
        inc de
        inc hl
        ld a,(hl)
        ld (de),a
        inc de
.8:     push bc
        ld bc,13
        add hl,bc
        pop bc
.5:     dec b
        jp nz,.3
        ret

        ;
        ; Maneja la entrada del usuario
        ;
maneja_entrada:
        ld ix,jug1
        ld a,0          ; Barra de espacio
        call GTTRIG
        or a
        call nz,disparo
        ld a,0          ; Teclas del cursor
        call GTSTCK
        call maneja_dir
        ld ix,jug2
        ld a,1          ; Joystick 1, bot�n A
        call GTTRIG
        or a
        call nz,disparo
        ld a,3          ; Joystick 1, bot�n B
        call GTTRIG
        or a
        call nz,disparo
        ld a,1          ; Joystick 1
        call GTSTCK
        call maneja_dir
        ret

        ;
        ; El jugador dispara
        ;
disparo:
        ld a,(ix+d_recarga)
        or a
        ret nz
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,9
        add hl,de
        ld a,(hl)
        or a
        sbc hl,de
        or a
        ret nz
        ld (ix+d_recarga),15
        ld a,(ix+d_sprite)
        and $30         ; �Mira a la derecha?
        ld de,$fd06
        ld bc,$0004
        jp z,.1
        cp $10          ; �Mira a la izquierda?
        ld de,$fdfa
        ld bc,$00fc
        jp z,.1
        cp $30          ; �Mira arriba?
        ld de,$fa00
        ld bc,$fc00
        jp z,.1         ; o tal vez abajo.
        ld de,$0300
        ld bc,$0400
.1:     push hl
        pop iy
        ld a,(ix+d_x)
        add a,e
        ld (iy+d_x),a
        ld a,(ix+d_y)
        add a,d
        ld (iy+d_y),a
        ld (iy+d_dx),c
        ld (iy+d_dy),b
        ld a,(ix+d_refx)
        ld (iy+d_refx),a
        ld a,(ix+d_refy)
        ld (iy+d_refy),a
        ld (iy+d_sprite),$08
        ld (iy+d_color),$0b
        ld (iy+d_velocidad),1
        ld (iy+d_paso),1
        ld (iy+d_tipo),8
        call efecto_disparo
        ret

        ;
        ; Mueve un jugador en una direcci�n
        ;
maneja_dir:
        push af
        ;
        ; Cuenta el tiempo para la recarga del disparo
        ;
        ld a,(ix+d_recarga)
        or a
        jp z,.7
        dec (ix+d_recarga)
.7:
        ;
        ; Tiempo de espera para no recibir da�o.
        ;
        ld a,(ix+d_espera)
        or a
        jp z,.1
        dec (ix+d_espera)
.1:     pop af

        ;
        ; Velocidad del jugador
        ;
        dec (ix+d_paso)
        jp nz,mueve_monstruos
        ld l,(ix+d_velocidad)
        ld (ix+d_paso),l
        ld l,(ix+d_real)
        ld h,(ix+d_real+1)
        ;
        ; Autodesplazamiento al cambiar de zona de juego
        ;
        push af
        ld de,0
        call accede_casilla
        cp 20
        jp z,.5
        cp 21
        jp nz,.6
        pop af
        call mov_abajo
        jp .2

.5:     pop af
        call mov_derecha
        jp .2

.6:     pop af
        ;
        ; Ahora chi, �que movimiento queria?
        ;
        cp 1
        push af
        call z,mov_arriba
        pop af
        cp 3
        push af
        call z,mov_derecha
        pop af
        cp 5
        push af
        call z,mov_abajo
        pop af
        cp 7
        push af
        call z,mov_izquierda
        pop af
    if 0
        cp 2
        push af
        call z,mov_arriba
        call z,mov_derecha
        pop af
        cp 4
        push af
        call z,mov_derecha
        call z,mov_abajo
        pop af
        cp 6
        push af
        call z,mov_abajo
        call z,mov_izquierda
        pop af
        cp 8
        push af
        call z,mov_izquierda
        call z,mov_arriba
        pop af
    endif
        ;
        ; Detecta si cambia de piso
        ;
        ld a,(ix+d_x)
        and $0f
        jp nz,.2
        ld a,(ix+d_y)
        and $0f
        jp nz,.2
        ld de,0
        call accede_casilla
        cp 98
        jp z,.4
        cp 97           ; �Transportador?
        jp nz,.2
        res 0,(ix+d_objeto)     ; Le quita la llave al jugador
.4:     ld a,(ix+d_y)
        sub (ix+d_refy)
        ld de,$4f00
        ld b,-10
        jp z,.3
        cp $50
        ld de,$b100
        ld b,10
        jp z,.3
        ld a,(ix+d_x)
        sub (ix+d_refx)
        ld b,-1
        ld de,$00af
        jp z,.3
        ld b,1
        ld de,$0051
.3:     ld a,(ix+d_nivel)
        add a,b
        ld (ix+d_nivel),a
        ld a,(ix+d_x)
        add a,e
        ld (ix+d_x),a
        ld (ix+d_basex),a
        ld a,(ix+d_y)
        add a,d
        ld (ix+d_y),a
        ld (ix+d_basey),a
        call carga_nivel
        call actualiza_indicadores
.2:
        ;
        ; Mueve los monigotes
        ;
mueve_monstruos:
        ld e,(ix+d_moni)
        ld d,(ix+d_moni+1)
        ld l,(ix+d_real)
        ld h,(ix+d_real+1)
        push ix
        pop iy
        push de
        pop ix
        ld b,8
.1:     ld a,(ix+d_tipo)
        or a
        jp z,.2
        dec (ix+d_paso) ; �Ya puede moverse?
        jp nz,.2        ; No, salta.
        ld a,(ix+d_velocidad)
        ld (ix+d_paso),a
.3:     ld a,(ix+d_tipo)
        dec a
        push hl
        ld hl,.15
        add a,a
        add a,l
        ld l,a
        ld a,h
        adc a,0
        ld h,a
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ex (sp),hl
        ret

.15:    dw .4           ; Zombie tipo 1
        dw .8           ; Zombie tipo 2
        dw .12          ; Zombie tipo 3
        dw .2           ; Zombie jefe
        dw .2           ; Adorno, ignora
        dw .9           ; Cient�fico/a
        dw .7           ; Llave
        dw .13          ; Bala
        dw .16          ; Bala en explosi�n.
        dw .14          ; Explosi�n monstruo.

.16:    xor a
        ld (ix+d_tipo),a ; Apaga explosi�n bala.
        jp .2

        ;
        ; Explosi�n
        ;
.14:    ld a,(ix+d_sprite)
        add a,4
        ld (ix+d_sprite),a
        cp $30
        jp nz,.2
        xor a
        ld (ix+d_tipo),a
        jp .2

        ;
        ; El/la cient�fico/cient�fica mueve su manita
.9:
        ld a,(ix+d_sprite)
        and $f0
        ld c,a
        ld a,(ticks)
        and $0c
        or c
        ld (ix+d_sprite),a
        jp .7

.13:    call mueve_bala
        jp .2

.12:    call mueve_monstruo_3
        jp .7

.8:     call mueve_monstruo_2
        jp .7

.4:     call mueve_monstruo_1
        ;
        ; Verifica si el jugador toca el monstruo/adorno/objeto
        ;
.7:     ld a,(ix+d_x)
        sub (iy+d_x)
        jp nc,.5
        neg 
.5:     cp 14
        jp nc,.2
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nc,.6
        neg
.6:     cp 14
        jp nc,.2
        ld a,(ix+d_tipo)
        cp 5
        jp c,.10
        cp 6
        jp nz,.11
        ;
        ; Toc� un cient�fico
        ;
        ld (ix+d_tipo),0     ; Lo quita
        push bc
        push hl
        push ix
        push iy
        pop ix
        ld hl,puntos_cientifico
        call agrega_puntos
        call actualiza_indicadores
        call efecto_rescate
        pop ix
        pop hl
        pop bc
        jp .2

        ;
        ; Toc� la llave
        ;
.11:
        ld (ix+d_tipo),0     ; La quita
        set 0,(iy+d_objeto)     ; Indica que la lleva
        push bc
        push hl
        push ix
        push iy
        pop ix
        call actualiza_indicadores
        call efecto_llave
        pop ix
        pop hl
        pop bc
        jp .2

        ;
        ; Toc� un monstruo
        ;
.10:
        ld a,(iy+d_espera)
        or a            ; �El jugador puede recibir da�o?      
        jp nz,.2        ; No, salta.
        push bc
        push hl
        push ix
        call efecto_tocado
        ld a,(ix+d_paso)
        add a,20        ; El monstruo se hace lento
        ld (ix+d_paso),a
        ld a,(iy+d_paso)
        add a,5         ; El jugador se hace lento
        ld (iy+d_paso),a
        ld a,50
        ld (iy+d_espera),a
        dec (iy+d_energia)
        push iy
        pop ix
        call actualiza_indicadores
        ld a,(ix+d_energia)
        or a
        call z,jugador_atrapado
        pop ix
        pop hl
        pop bc
.2:     ld de,16
        add ix,de
        dec b
        jp nz,.1
        ret

        ;
        ; Jugador atrapado por un monstruo, pierde una vida
        ;
jugador_atrapado:
        ld a,(ix+d_basex)
        ld (ix+d_x),a
        ld a,(ix+d_basey)
        ld (ix+d_y),a
        dec (ix+d_vidas)
        jp m,.1
        ld (ix+d_energia),6
.1:     call actualiza_indicadores
        ret

        ; Puntos por rescatar un cient�fico
puntos_cientifico:
        db $00,$01,$00

        ;
        ; Agrega puntos
        ;
agrega_puntos:
        inc hl
        inc hl
        ld a,(ix+d_puntos+2)
        add a,(hl)
        daa
        ld (ix+d_puntos+2),a
        dec hl
        ld a,(ix+d_puntos+1)
        adc a,(hl)
        daa
        ld (ix+d_puntos+1),a
        dec hl
        ld a,(ix+d_puntos)
        adc a,(hl)
        daa
        ld (ix+d_puntos),a
        ret

        ;
        ; Mueve bala
        ;
mueve_bala:
        push bc
        push iy
        push hl
        ld l,(iy+d_moni)
        ld h,(iy+d_moni+1)
        ld de,16
        add hl,de
        push hl
        pop iy
        ld b,MAX_MONIGOTES-1
.6:     ld a,(iy+d_tipo)
        or a
        jp z,.7
        cp 5
        jp nc,.7
        cp 4
        jp nz,.11
        ;
        ; Comprobaci�n para monstruos grandotes
        ;
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp nc,.12
        neg
.12:    cp 12
        jp nc,.7
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nc,.13
        neg
.13:    cp 12
        jp nc,.7
        ;
        ; La bala peg� en un monstruo
        ;
        dec (iy+d_energia)
        ld hl,puntos_bala
        ld (salva_puntos),hl
        jp nz,.14       ; El monstruo grande ni se inmuta.
        ;
        ; �Wiii!, �Monstruo matado!
        ;
        ld e,(iy+d_x)
        ld d,(iy+d_y)
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),4
        ld (iy+d_paso),4
        ld (iy+d_color),14
        ld bc,16
        add iy,bc
        ld a,e
        add a,$10
        ld (iy+d_x),a
        ld (iy+d_y),d
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),4
        ld (iy+d_paso),4
        ld (iy+d_color),14
        ld bc,16
        add iy,bc
        ld (iy+d_x),e
        ld a,d
        add a,$10
        ld (iy+d_y),a
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),4
        ld (iy+d_paso),4
        ld (iy+d_color),14
        ld bc,16
        add iy,bc
        ld a,e
        add a,$10
        ld (iy+d_x),a
        ld a,d
        add a,$10
        ld (iy+d_y),a
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),4
        ld (iy+d_paso),4
        ld (iy+d_color),14
        call efecto_megamonstruo
        ; !!! Musica de ganar
        ; !!! Deja una llave
        ld hl,puntos_megamonstruo
        ld (salva_puntos),hl
        ;
        ; La bala termina
        ;
.14:    ld (ix+d_sprite),$0c
        ld (ix+d_color),9
        ld (ix+d_tipo),9
        call efecto_explota
        pop hl
        pop iy
        pop bc
        push bc
        push iy
        push hl
        push iy
        pop ix
        ld hl,(salva_puntos)
        call agrega_puntos
        call actualiza_indicadores
        pop hl
        pop iy
        pop bc
        ret

        ;
        ; Comprobaci�n para monstruos chiquitos
        ;
.11:
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp nc,.8
        neg
.8:     cp 12
        jp nc,.7
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nc,.9
        neg
.9:     cp 12
        jp nc,.7
        ;
        ; La bala peg� en un monstruo
        ;
        dec (iy+d_energia)
        jp nz,.10
        ;
        ; �Wiii!, �Monstruo matado!
        ;
        ld a,(iy+d_tipo)
        cp 1
        ld hl,puntos_monstruo_1
        jp z,.15
        cp 2
        ld hl,puntos_monstruo_2
        jp z,.15
        ld hl,puntos_monstruo_3
.15:    ld (salva_puntos),hl
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),4
        ld (iy+d_paso),4
        ld (iy+d_color),14
        call efecto_monstruo
        pop af
        jp .14

.10:    ld (iy+d_paso),5
        ld hl,puntos_bala
        ld (salva_puntos),hl
        ld a,(iy+d_velocidad)
        cp 1
        jp z,.14
        dec (iy+d_velocidad)
        jp .14

.7:     ld de,16
        add iy,de
        dec b
        jp nz,.6
        pop hl
        push hl
        ld a,(ix+d_x)
        add a,(ix+d_dx)
        ld (ix+d_x),a
        sub (ix+d_refx)
        cp 4
        jp c,.1
        cp $ad
        jp nc,.1
        ld a,(ix+d_y)
        add a,(ix+d_dy)
        ld (ix+d_y),a
        sub (ix+d_refy)
        cp 4
        jp c,.1
        cp $4d
        jp nc,.1
        ld a,(ix+d_dx)
        or a
        jp z,.2
        jp p,.4
        ; Bala a la izquierda
        ld de,$0300
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

        ; Bala a la derecha
.4:     ld de,$0308
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

.2:     ld a,(ix+d_dy)
        or a
        jp p,.3
        ; Bala para arriba
        ld de,$0000
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

        ; Bala para abajo
.3:     ld de,$0800
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

.1:     ld (ix+d_tipo),0
        pop hl
        pop iy
        pop bc
        ret

        ;
        ; La bala peg� en algo
        ;
.5:     ld (ix+d_sprite),$0c
        ld (ix+d_color),9
        ld (ix+d_tipo),9
        call efecto_explota
        pop hl
        pop iy
        pop bc
        ret

        ; Diez puntos por atinar una bala
puntos_bala:
        db $00,$00,$01

        ; Cien puntos por monstruo simple
puntos_monstruo_1:
        db $00,$00,$10

        ; Doscientos cincuenta puntos por monstruo tipo 2
puntos_monstruo_2:
        db $00,$00,$25

        ; Quinientos puntos por monstruo tipo 3
puntos_monstruo_3:
        db $00,$00,$50

        ; Diez mil puntos por acabar con el megamonstruo
puntos_megamonstruo:
        db $00,$10,$00

        ;
        ; Movimiento del monstruo 1
        ; Va a izquierda o derecha, da media vuelta si se topa con algo
        ;
mueve_monstruo_1:
        ld a,(ix+d_dx)
        cp 1    ; �Va a la derecha?
        jp z,.1
        call mov_izquierda
        ret c
        ld a,(ix+d_dx)
        neg
        ld (ix+d_dx),a
        ret

.1:     call mov_derecha
        ret c
        ld a,(ix+d_dx)
        neg
        ld (ix+d_dx),a
        ret

        ;
        ; Movimiento del monstruo 2
        ; Gira a la derecha si se topa con algo
        ;
mueve_monstruo_2:
        ld a,(ix+d_dx)
        cp 1    ; �Va a la derecha?
        jp nz,.1
        call mov_derecha
        ret c
        ld (ix+d_dx),0     ; Ahora abajo
        ld (ix+d_dy),1
        call mov_abajo
        ret c
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.1:     cp -1   ; �Va a la izquierda?
        jp nz,.2
        call mov_izquierda
        ret c
        ld (ix+d_dx),0     ; Ahora arriba
        ld (ix+d_dy),-1
        call mov_arriba
        ret c
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

.2:     ld a,(ix+d_dy)
        cp 1    ; �Va hacia abajo?
        jp nz,.3
        call mov_abajo
        ret c
        ld (ix+d_dx),-1    ; Ahora a la izquierda
        ld (ix+d_dy),0
        call mov_izquierda
        ret c
        ld (ix+d_dx),1
        ld (ix+d_dy),0
        ret

.3:     call mov_arriba
        ret c
        ld (ix+d_dx),1     ; Ahora a la derecha
        ld (ix+d_dy),0
        call mov_derecha
        ret c
        ld (ix+d_dx),-1
        ld (ix+d_dy),0
        ret

        ;
        ; Movimiento del monstruo 3
        ; En cada intersecci�n trata de ir hacia el jugador
        ;
mueve_monstruo_3:
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_dx)
        or a
        jp z,.1
        ;
        ; Estaba en horizontal, trata de ir en vertical
        ;
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nz,.6
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp z,.5
        jp c,.7
        call mov_izquierda
        ret c
        jp .5

.7:     call mov_derecha
        ret c
        jp .5

.6:     jp c,.2
        call mov_arriba
        ret c
        jp .4

.2:     call mov_abajo
        ret c
        jp .4

        ;
        ; Estaba en vertical, trata de ir en horizontal
        ;
.1:     ld a,(ix+d_x)
        sub (iy+d_x)
        jp nz,.8
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp z,.4
        jp c,.9
        call mov_arriba
        ret c
        jp .4

.9:     call mov_abajo
        ret c
        jp .4

.8:     jp c,.3
        call mov_izquierda
        ret c
        jp .5

.3:     call mov_derecha
        ret c
        jp .5

        ;
        ; Trata de ir en cualquier ruta
        ;
.5:     call mov_izquierda
        ret c
        call mov_derecha
        ret c
.4:     call mov_arriba
        ret c
        call mov_abajo
        ret c
        jp mueve_monstruo_2

        ;
        ; Realiza el movimiento previo
        ;
mov_previo:
        push hl
        ld l,(ix+d_ultimo)
        ld h,(ix+d_ultimo+1)
        ex (sp),hl
        ret

        ;
        ; Movimiento hacia arriba
        ;
mov_arriba:
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_y)
        sub (ix+d_refy)
        or a
        ret z
        ld de,$ff00
        call mov_libre
        ret nc
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or $30
        or c
        ld (ix+d_sprite),a
        dec (ix+d_y)
        ld de,mov_arriba
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Movimiento hacia abajo
        ;
mov_abajo:
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_y)
        sub (ix+d_refy)
        cp $50
        ret nc
        ld de,$0100
        call mov_libre
        ret nc
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or $20
        or c
        ld (ix+d_sprite),a
        inc (ix+d_y)
        ld de,mov_abajo
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Movimiento a la izquierda
        ;
mov_izquierda:
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_x)
        sub (ix+d_refx)
        ret z
        ld de,$00ff
        call mov_libre
        ret nc
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or $10
        or c
        ld (ix+d_sprite),a
        dec (ix+d_x)
        ld de,mov_izquierda
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Movimiento a la derecha
        ;
mov_derecha:
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $b0
        ret nc
        ld de,$0001
        call mov_libre
        ret nc
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or c
        ld (ix+d_sprite),a
        inc (ix+d_x)
        ld de,mov_derecha
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Verifica si puede moverse libremente
        ;
mov_libre:
        ld a,e
        or a
        jp z,.1
        bit 7,e
        jp nz,.1
        ld a,e
        add a,15
        ld e,a
.1:     ld a,d
        or a
        jp z,.2
        bit 7,d
        jp nz,.2
        ld a,d
        add a,15
        ld d,a
.2:
mov_libre0:
        call accede_casilla
        cp 97   ; �Transportador?
        jp z,.3
        push hl
        ld e,a
        ld d,0
        ld hl,caminable
        add hl,de
        bit 0,(hl)
        pop hl
        ret z
        scf
        ret

.3:     bit 0,(ix+d_objeto)     ; �Tiene la llave?
        scf
        ret nz                  ; Si, puede caminar el transportador
        ccf
        ret

        ;
        ; Accede una casilla del nivel
        ;
accede_casilla:
        ld a,(ix+d_x)
        sub (ix+d_refx)
        add a,e
        rrca
        rrca
        rrca
        rrca
        and $0f
        ld e,a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        add a,d
        and $f0
        rrca
        ld d,a
        rrca
        add a,d
        add a,e
        push hl
        ld e,a
        ld d,0
        add hl,de
        ld a,(hl)
        pop hl
        ret

        ;
        ; ================================
        ; EFECTOS DE SONIDO
        ; ================================
        ;

        ; Se ha tomado la llave
efecto_llave:
        ; !!!
        ret

        ; Se ha rescatado a alguien
efecto_rescate:
        ; !!!
        ret

        ; Se ha tocado un monstruo
efecto_tocado:
        ; !!!
        ret
        
        ; Se ha disparado
efecto_disparo:
        ; !!!
        ret

        ; La bala ha tocado algo
efecto_explota:
        ; !!!
        ret

        ; Un monstruo menos en el universo
efecto_monstruo:
        ; !!!
        ret

        ; Un megamonstruo menos en el universo
efecto_megamonstruo:
        ; !!!
        ret

        ;
        ; La presentaci�n
        ;
        ; Para la voz se usa el truco PCM con el PSG
        ;
presentacion:
        ;
        ; Presentaci�n compactada (12288 bytes sin compactar)
        ; Entrada en diagonal
        ;
        ; !!! Mostrar presentaci�n "Zombie wars"
        ; !!! Esperar un rato, hacer parpadear "Press any key"
        ; !!! Mensaje parpadeante de alerta y sonido de chicharra de alerta
        ;
        ; Todos los cuadros de personaje son de 64x64 pixeles, 1024 bytes,
        ; se desplazan utilizando truco directo tabla de caracteres.
        ;
        ; !!! Entra chica por derecha
        ; !!! Mensaje hablado "Security failure"
        ; !!! Entra jefe por izquierda
        ; !!! Mensaje hablado "Close down the doors"
        ;
        ; Edificio compactado, solo verde m�s sprites
        ;
        ; !!! Edificio alambre 3-D, puntos rojos se desplazan y convierten
        ;     puntos blancos en puntos verdes, puertas se rompen.
        ; !!! Entra chica por derecha
        ; !!! Mensaje hablado "They're through the building!"
        ; !!! Entra jefe por izquierda
        ; !!! Mensaje hablado "Call the special team... What's that?"
        ; !!! Se apaga la pantalla
        ; !!! Mensaje hablado "Oh my god!... gritos y luego est�tica"
        ; !!! Entra de arriba telefonista
        ; !!! Mensaje hablado "Emergency! Calling special team"
        ; !!! Entra Steve desde la izquierda
        ; !!! Mensaje hablado "Steve K1 ready, I'll enter by north"
        ; !!! Entra Eve por la derecha
        ; !!! Mensaje hablado "Eve K2 ready, I'll enter by south"
        ; !!! Vuelta a presentaci�n
        ; !!! Modo de atracci�n, nivel, algo de movimiento, disparos, sin
        ;     m�sica de fondo
        ret

        ;
        ; Final
        ;
final:
        ;
        ; El cuadro de final se compone seg�n si uno o dos de los jugadores
        ; lo lograron.
        ;
        ; !!!
        ; !!! Tonada especial de final.
        ;
        ; Toma extra, el piloto voltea y se ve que es un zombie
        ;
        ; !!! Retardo de unos segundos
        ;
        ; Cuadro con letras chuecas "The End"
        ;
        ; !!!
        ret

jug1_inicial:           ; El chico
        db $10,$10      ; Coordenada X,Y actual, cambiada al leer nivel
        db 0,7          ; Sprite y color
        db 0,54         ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ�a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw pantalla     ; Ap. a pantalla oculta
        db 0,0          ; Base X,Y visual
        dw 0            ; Ap. a nivel cargado
        dw monigotes    ; Lista de monigotes
        db 2            ; Dos vidas
        db 0            ; Espera antes de recibir m�s da�o.
        db 0,0          ; Coordenadas X,Y donde apareci�
        db 0,0,0        ; Puntos en BCD (alto a bajo)
        db 0            ; Objetos
        dw 0            ; Monitor para transportador

jug2_inicial:           ; La chica
        db $50,$70      ; Coordenada X,Y actual, cambiada al leer nivel
        db 64,9         ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ�a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw pantalla+392 ; Ap. a pantalla oculta
        db $40,$60      ; Base X,Y visual
        dw 0            ; Ap. a nivel cargado
        dw monigotes+MAX_MONIGOTES*16       ; Lista de monigotes
        db 2            ; Dos vidas
        db 0            ; Espera antes de recibir m�s da�o.
        db 0,0          ; Coordenadas X,Y donde apareci�
        db 0,0,0        ; Puntos en BCD (alto a bajo)
        db 0            ; Objetos
        dw 0            ; Monitor para transportador

        ;
        ; Los sprites bellamente dibujados :)
        ;
        include "sprites.asm"

        include "niveles.asm"

        include "graficas.asm"

        DS $C000-$      ; Rellena a 32K

        ORG $E000

pantalla:
        RB 768
sprites:
        RB 128

jug1:   ; Datos del jugador 1
jug1_x: RB 1    ; Coordenada X 
jug1_y: RB 1    ; Coordenada Y
jug1_s: RB 1    ; Sprite correspondiente
jug1_c: RB 1    ; Color
jug1_r: RB 1    ; Recarga de disparo
jug1_n: RB 1    ; Pantalla que est� jugando
jug1_l: RB 1    ; Velocidad
jug1_e: RB 1    ; Energia restante
jug1_a: RB 1    ; Paso
jug1_p: RB 3    ; Puntuaci�n (BCD)
jug1_o: RB 2    ; Offset pantalla
jug1_f: RB 1    ; Referencia X
jug1_g: RB 1    ; Referencia Y
jug1_d: RB 2    ; Apunta al nivel que esta jugando
jug1_m: RB 2    ; Su tabla de amistosos monigotes
jug1_v: RB 1    ; Vidas restantes ($ff = muerto)
        RB 1    ; Tiempo de espera antes de recibir m�s da�o.
        RB 2    ; Base X y Y de donde empieza si pierde una vida.
        RB 3    ; Puntos
        RB 1
        RB 2    ; Monitor para transportador

jug2:   ; Datos del jugador 2
        RB 30

monigotes:      ; Tabla de monigotes
        RB (MAX_MONIGOTES*2)*16

salva_puntos:   RB 2

        ;
        ; Variables usadas por el n�cleo
        ;
ticks:  RB 1
ciclo:  RB 1
modo:   RB 1

        ORG $F0F0
PILA:   

