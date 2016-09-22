        ;
        ; Zombie marabunta
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011
        ;
        ; Creaci¢n: 04-ene-2011.
        ; Revisi¢n: 05-ene-2011. Algoritmo de ray-casting casi operativo,
        ;                        pero las distancias las calcula mal.
        ;

        ORG $4000

        FNAME "ZM.ROM"

        DB "AB"         ; Para que el MSX reconozca el cartucho
        DW INICIO

        DB "Zombie Marabunta, MSX game, "
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

tabla_modo_2:
        DB $02          ; Registro 0
        DB $E2          ; Registro 1
        DB $0F          ; Registro 2 - Base pantalla $3C00
        DB $FF          ; Registro 3 - Tabla color $2000
        DB $03          ; Registro 4 - Tabla caracteres $0000
        DB $7F          ; Registro 5 - Tabla sprites $3F80
        DB $03          ; Registro 6 - Figuras sprites $1800
        DB $01          ; Registro 7 - Borde negro

tabla_modo_3:
        DB $00          ; Registro 0
        DB $EA          ; Registro 1
        DB $0F          ; Registro 2 - Base pantalla $3C00
        DB $FF          ; Registro 3 - Tabla color $2000
        DB $00          ; Registro 4 - Tabla caracteres $0000
        DB $7F          ; Registro 5 - Tabla sprites $3F80
        DB $03          ; Registro 6 - Figuras sprites $1800
        DB $01          ; Registro 7 - Borde negro
        
inicio:
        ;
        ; Inicia la pila e intercepta vector de interrupci¢n
        ;
        di
        ld sp,pila
        ld a,$c3
        ld ($fd9a),a
        ld hl,vector_int
        ld ($fd9b),hl
        xor a
        ld (ticks),a
        ld (ciclo),a
        ld (modo),a
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
        ; Introducci¢n del juego
        ;
        call vdp_modo_2
        call presentacion
      
        ;
        ; Entrada al juego
        ;
        ld hl,pantalla
        ld de,pantalla+1
        ld bc,1535
        ld (hl),0
        ldir
        call vdp_modo_3
        ld a,1
        ld (modo),a
        ld hl,$00a0
        ld (jug1_x),hl
        ld hl,$00a0
        ld (jug1_y),hl
        ld hl,$0020
        ld (jug1_a),hl
        ld hl,pantalla
        ld (jug1_p),hl
.1:     halt
        ld ix,jug1
        call dibuja_vision
    if 0
        ld hl,pantalla
        ld c,6
.3:     ld b,8
.2:     inc (hl)
        inc hl
        djnz .2
        ld de,248
        add hl,de
        dec c
        jr nz,.3
    endif
        ld a,0
        call GTSTCK
        cp 7    ; Izquierda
        jp nz,.4
        dec (ix+4)
.4:     cp 3    ; Derecha
        jp nz,.5
        inc (ix+4)
.5:     JR .1

        ;
        ; Vector de interrupci¢n, llamado 50 o 60 veces por segundo
        ; Todos los registros son salvados por el BIOS MSX
        ;
vector_int:
        ;
        ; Limpia la interrupci¢n
        ;
        call RDVDP
        ;
        ; Incrementa ticks transcurridos
        ;
        ld hl,ticks
        inc (hl)
        ld a,(modo)
        cp 1
        jp nz,.2
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
        ;
        ; Este es un supertruco, actualiza media pantalla en cada tick
        ; y la otra media pantalla en el otro tick, de esta forma
        ; consigue 30 o 25 cuadros por segundo en AMBOS cuadros
        ;
        ld a,(ticks)
        and 1
        ld hl,$0000
        ld de,pantalla
        jp z,.3
        ld hl,$0300
        ld de,pantalla+768
.3:     call SETWRT
        ex de,hl
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
.2:     ld a,($002B)
        and $80         ; ¨60 hz?
        jp nz,.1        ; No, salta.
        ld hl,ciclo
        inc (hl)
        ld a,(hl)
        cp 6
        jp nz,.1
        ld (hl),0       ; Se come 1 de cada 6 ciclos
        ret

        ;
        ; Aqu¡ cree que son 50 ciclos por segundo
        ;
.1:     ld a,(modo)
        cp 1
        ret nz
        ret

limpia_sprites:
        LD HL,$3F80
        LD A,$D1
        LD BC,$0080
        JP FILVRM

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
        LD HL,$3C00
.2:     LD A,L
        CALL WRTVRM
        INC HL
        LD A,H
        CP $3F
        JP NZ,.2
        RET

vdp_modo_3:
        LD HL,tabla_modo_3
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
        LD BC,$0600
        LD A,$11
        CALL FILVRM
        LD HL,$3C00
        LD C,$00
.2:     LD B,$80
.3:     LD A,C
        CALL WRTVRM
        INC HL
        LD A,C
        INC A
        AND $1F
        LD D,A
        LD A,C
        AND $E0
        OR D
        LD C,A
        DJNZ .3
        LD A,C
        ADD A,$20
        LD C,A
        LD A,H
        CP $3F
        JR NZ,.2
        RET

        ;
        ; La presentaci¢n
        ;
        ; Para la voz se usa el truco PCM con el PSG
        ;
presentacion:
        ;
        ; Presentaci¢n compactada (12288 bytes sin compactar)
        ; Entrada en diagonal
        ;
        ; !!! Mostrar presentaci¢n "Zombie marabunta"
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
        ; Edificio compactado, solo verde m s sprites
        ;
        ; !!! Edificio alambre 3-D, puntos rojos se desplazan y convierten
        ;     puntos blancos en puntos verdes, puertas se rompen.
        ; !!! Entra chica por derecha
        ; !!! Mensaje hablado "They're through the building!"
        ; !!! Entra jefe por izquierda
        ; !!! Mensaje hablado "Call the special team... What's that?"
        ; !!! Se apaga la pantalla
        ; !!! Mensaje hablado "Oh my god!... gritos y luego est tica"
        ; !!! Entra de arriba telefonista
        ; !!! Mensaje hablado "Emergency! Calling special team"
        ; !!! Entra Steve desde la izquierda
        ; !!! Mensaje hablado "Steve K1 ready, I'll enter by north"
        ; !!! Entra Eve por la derecha
        ; !!! Mensaje hablado "Eve K2 ready, I'll enter by south"
        ; !!! Vuelta a presentaci¢n
        ; !!! Modo de atracci¢n, nivel, algo de movimiento, disparos, sin
        ;     m£sica de fondo
        ret

        ;
        ; Final
        ;
final:
        ;
        ; El cuadro de final se compone seg£n si uno o dos de los jugadores
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

        ;
        ; Dibuja la visualizaci¢n de un jugador
        ; IX = Apunta a los datos del jugador
        ;
dibuja_vision:
        ;
        ; Paso 1, limpia la pantalla
        ;
        ld a,(ix+8)
        rlca
        rlca
        rlca
        ld e,a
        ld d,0
        ld l,e
        ld h,d
        add hl,hl
        add hl,de
        ld de,colores_niveles
        add hl,de
        ld e,(ix+6)
        ld d,(ix+7)
        push de
        ld a,30
.100:   push hl
        ld bc,8
        ldir
        pop hl
        dec a
        jp nz,.100
        pop de
        inc d
        ld bc,8
        add hl,bc
        push de
        ld a,30
.101:   push hl
        ld bc,8
        ldir
        pop hl
        dec a
        jp nz,.101
        pop de
        inc d
        ld bc,8
        add hl,bc
        ld a,30
.102:   push hl
        ld bc,8
        ldir
        pop hl
        dec a
        jp nz,.102
        ;
        ; Procede a generar los rayos de visi¢n para ver 120 grados
        ;
        ld a,(ix+4)
        sub 45
        ld c,a
        ld b,60
.1:     push bc
    if 1
        ld a,(ix+2)     ; Obtiene coordenada Y jugador
        ld h,(ix+3)
        and $c0
        ld l,a
        ld a,c
        or a
        jp z,.3
        jp m,.3         ; ¨Angulo menor de 180 grados?
        ld de,64
        add hl,de
        ld (y_mapa),hl
        ld e,(ix+2)
        ld d,(ix+3)
        or a
        sbc hl,de       ; y_mapa - y_jugador...
        ex de,hl        ; ...en DE
        ld hl,64
        jp .4

.3:     dec hl
        ld (y_mapa),hl
        ld e,(ix+2)
        ld d,(ix+3)
        or a
        sbc hl,de       ; y_mapa - y_jugador...
        ex de,hl        ; ...en DE
        ld hl,-64
.4:     ld (dist_y),hl
        ld b,0
        ld hl,tab_itan
        add hl,bc
        add hl,bc
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        call mul_frac
        ld e,(ix+0)     ; Obtiene X jugador
        ld d,(ix+1)
        add hl,de
        ld (x_mapa),hl
        ld a,c
        or a
        jp z,.5
        cp 128
        jp nz,.6
.5:     ld hl,$7fff
        ld (dist_h),hl
        jp .7

.6:     ld b,0
        ld hl,tab_paso_x
        add hl,bc
        add hl,bc
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld (dist_x),hl
.8:     ld hl,(y_mapa)
        ld a,h
        cp $08
        jp nc,.5
        srl h
        rr l
        ld a,l
        and $e0
        ld l,a
        ld de,(x_mapa)
        ld a,d
        cp 8
        jp nc,.5
        ld a,e
        and $c0
        or d
        rlca
        rlca
        or l
        ld l,a
        ld de,nivel1
        add hl,de
        ld a,(hl)
        or a
        jp z,.9
        ld (muro_h),a
        ld hl,(x_mapa)
        ld e,(ix+0)
        ld d,(ix+1)
        or a
        sbc hl,de
        ex de,hl
        ld b,0
        ld hl,tab_icos
        add hl,bc
        add hl,bc
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        call mul_frac
        bit 7,h
        jp z,.41
        ld a,h
        cpl
        ld h,a
        ld a,l
        cpl
        ld l,a
        inc hl
.41:    ld (dist_h),hl
        jp .7

.9:
        ;call depura
        ld hl,(x_mapa)
        ld de,(dist_x)
        add hl,de
        ld (x_mapa),hl
        ld hl,(y_mapa)
        ld de,(dist_y)
        add hl,de
        ld (y_mapa),hl
        jp .8

.7:
    endif
    if 1
        ld a,(ix+0)     ; Obtiene coordenada X jugador
        ld h,(ix+1)
        and $c0
        ld l,a
        ld a,c
        sub 64          ; ¨Angulo entre 90 y 270 grados?
        jp p,.10
        ld de,64
        add hl,de
        ld (x_mapa),hl
        ld e,(ix+0)
        ld d,(ix+1)
        or a
        sbc hl,de       ; x_mapa - x_jugador...
        ex de,hl        ; ...en DE
        ld hl,64
        jp .11

.10:    dec hl
        ld (x_mapa),hl
        ld e,(ix+0)
        ld d,(ix+1)
        or a
        sbc hl,de       ; x_mapa - x_jugador...
        ex de,hl        ; ...en DE
        ld hl,-64
.11:    ld (dist_x),hl
        ld b,0
        ld hl,tab_tan
        add hl,bc
        add hl,bc
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        call mul_frac
        ld e,(ix+2)     ; Obtiene Y jugador
        ld d,(ix+3)
        add hl,de
        ld (y_mapa),hl
        ld a,c
        cp 64
        jp z,.12
        cp 192
        jp nz,.13
.12:    ld hl,$7fff
        ld (dist_v),hl
        jp .16

.13:    ld b,0
        ld hl,tab_paso_y
        add hl,bc
        add hl,bc
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld (dist_y),hl
.14:    ld hl,(y_mapa)
        ld a,h
        cp $08
        jp nc,.12
        srl h
        rr l
        ld a,l
        and $e0
        ld l,a
        ld de,(x_mapa)
        ld a,d
        cp $08
        jp nc,.12
        ld a,e
        and $c0
        or d
        rlca
        rlca
        or l
        ld l,a
        ld de,nivel1
        add hl,de
        ld a,(hl)
        or a
        jp z,.15
        ld (muro_v),a
        ld hl,(y_mapa)
        ld e,(ix+2)
        ld d,(ix+3)
        or a
        sbc hl,de
        ex de,hl
        ld b,0
        ld hl,tab_isin
        add hl,bc
        add hl,bc
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        call mul_frac
        bit 7,h
        jp z,.40
        ld a,h
        cpl
        ld h,a
        ld a,l
        cpl
        ld l,a
        inc hl
.40:
        ld (dist_v),hl
        jp .16

.15:
        ;call depura
        ld hl,(x_mapa)
        ld de,(dist_x)
        add hl,de
        ld (x_mapa),hl
        ld hl,(y_mapa)
        ld de,(dist_y)
        add hl,de
        ld (y_mapa),hl
        jp .14

.16:
    endif
        ld a,c
        sub (ix+4)
        ld c,a
        ld b,0
        ld hl,tab_cos
        add hl,bc
        add hl,bc
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        push hl
        ld hl,(dist_h)
        ld a,(muro_h)
        ld b,a
        ld de,(dist_v)
        ld a,(muro_v)
        ld c,a
        or a
        sbc hl,de
        add hl,de
        jp c,.17
        ld b,c
        ex de,hl
.17:    pop de
        call mul_frac   ; Correcci¢n ojo de pescado
        ;
        ; !!! Anotar en z-buffer
        ;
    if 1
        ld e,h
        ld d,0
        ld hl,tab_esc
        add hl,de
        add hl,de
        ld l,(hl)
        ld a,23
        sub l
        srl a
        ld h,a          ; Coordenada Y inicial.
        ld a,b          ; Tipo de muro
        pop bc
        push bc
        ld c,a
        ld a,60
        sub b           ; Coordenada X
        srl a
        jp c,.19        ; Pixeles derechos
        ;
        ; Pixeles izquierdos
        ;
        ld e,(ix+6)
        ld d,(ix+7)
        add a,a
        add a,a
        add a,a
        add a,e
        ld e,a
        ld a,h
        srl a
        srl a
        srl a
        add a,d
        ld d,a
        ld a,h
        and 7
        add a,e
        ld e,a
        ld b,l
        ex de,hl
.21:    ld a,(hl)
        and $0f
        or $50
        ld (hl),a
        inc l
        ld a,l
        and 7
        jp z,.22
        djnz .21
        jp .20

.22:    ld a,l
        sub 8
        ld l,a
        inc h
        djnz .21
        jp .20

        ;
        ; Pixeles derechos
        ;
.19:    ld e,(ix+6)
        ld d,(ix+7)
        add a,a
        add a,a
        add a,a
        add a,e
        ld e,a
        ld a,h
        srl a
        srl a
        srl a
        add a,d
        ld d,a
        ld a,h
        and 7
        add a,e
        ld e,a
        ld b,l
        ex de,hl
.24:    ld a,(hl)
        and $f0
        or $05
        ld (hl),a
        inc l
        ld a,l
        and 7
        jp z,.25
        djnz .24
        jp .20

.25:    ld a,l
        sub 8
        ld l,a
        inc h
        djnz .24

.20:
    else
        halt
    endif
        pop bc
        inc c
        bit 0,b
        jp z,.2
        inc c
.2:     dec b
        jp nz,.1
        ret

    if 1
        ;
        ; Depuraci¢n
        ;
depura:
        ld hl,(y_mapa)
        srl h
        rr l
        ld a,l
        and $e0
        rlca
        rlca
        rlca
        ld l,a
        ld de,(x_mapa)
        ld a,e
        and $80
        or d
        rlca
        add a,a
        add a,a
        add a,a
        add a,l
        ld l,a
        ld a,e
        ld de,pantalla
        add hl,de
        and $40
        jp nz,.1
        ld a,(hl)
        and $0f
        or $f0
        ld (hl),a
        ret

.1:     ld a,(hl)
        and $f0
        or $0f
        ld (hl),a
        ret
    endif

        ;
        ; Multiplicaci¢n fraccionaria
        ; HL x DE = HL
        ;
mul_frac:
        PUSH BC
        LD A,H
        XOR D
        PUSH AF
        BIT 7,H
        JP Z,.1
        LD A,H
        CPL
        LD H,A
        LD A,L
        CPL
        LD L,A
        INC HL
.1:     BIT 7,D
        JP Z,.2
        LD A,D
        CPL
        LD D,A
        LD A,E
        CPL
        LD E,A
        INC DE
.2:     LD B,D
        LD C,E
        PUSH HL
        EXX
        POP HL
        EXX
        LD A,16
        LD HL,0
        LD DE,0
.4:     ADD HL,HL
        EX DE,HL
        ADC HL,HL
        EX DE,HL
        EXX
        ADD HL,HL
        EXX
        JP NC,.3
        ADD HL,BC
        JP NC,.3
        INC DE
.3:     DEC A
        JP NZ,.4
        LD L,H
        LD H,E
        LD A,D
        OR A
        JP NZ,.6
        LD A,H
        CP $80
        JP C,.5
.6:     LD HL,$7FFF
.5:     POP AF
        POP BC
        RET P
        LD A,H
        CPL
        LD H,A
        LD A,L
        CPL
        LD L,A
        INC HL
        RET

        ;
        ; Colores de los niveles
        ;
colores_niveles:
        db $77,$77,$77,$77,$77,$77,$77,$77
        db $77,$77,$77,$77,$ee,$ee,$ee,$ee
        db $ee,$ee,$ee,$ee,$ee,$ee,$ee,$11

        ;
        ; Un mont¢n de tablas matem ticas requeridas
        ;
        include "tablas.asm"

        ;
        ; Se supone que ser n diez niveles, compactados, y faltan los
        ; dise¤os de los muros y monstruos
        ;
nivel1:
        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

        DS $C000-$      ; Rellena a 32K

        ORG $C000

DEP:    RB 128

        ORG $E000

pantalla:
        RB 1536
nivel:
        RB 32*32
sprites:
        RB 128

jug1:   ; Datos del jugador 1
jug1_x: RB 2    ; Coordenada X fracci¢n 5.6
jug1_y: RB 2    ; Coordenada Y fracci¢n 5.6
jug1_a: RB 2    ; Angulo, un n£mero entre 0 y 255
jug1_p: RB 2    ; Offset pantalla
jug1_n: RB 1    ; Nivel que est  jugando

        ;
        ; Variables usadas por el algoritmo de rayos
        ;
x_mapa: rb 2    ; Coordenada rayo en mapa 5.6
y_mapa: rb 2    ; Coordenada rayo en mapa 5.6
dist_x: rb 2    ; Avance rayo 5.6
dist_y: rb 2    ; Avance rayo 5.6
dist_h: rb 2    ; Distancia horizontal
dist_v: rb 2    ; Distancia vertical
muro_h: rb 1    ; Muro que top¢ horizontalmente
muro_v: rb 1    ; Muro que top¢ verticalmente

        ;
        ; Variables usadas por el n£cleo
        ;
ticks:  RB 1
ciclo:  RB 1
modo:   RB 1

        ORG $F0F0
PILA:   

