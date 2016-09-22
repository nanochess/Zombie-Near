        ;
        ; Zombie wars
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011
        ;
        ; Creaci¢n: 06-ene-2011.
        ;

        ORG $4000

        FNAME "ZOMBIWAR.ROM"

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
        ; Offsets de variables de jugador
        ;
d_x:            equ 0   ; Coordenada X
d_y:            equ 1   ; Coordenada Y  
d_sprite:       equ 2   ; Sprite
d_color:        equ 3   ; Color
d_recarga:      equ 4   ; Tiempo para recarga de disparo
d_nivel:        equ 5   ; Nivel de juego
d_velocidad:    equ 6   ; Velocidad.
d_energia:      equ 7   ; Energ¡a
d_dx:           equ 4   ; Monigotes, direcci¢n X
d_dy:           equ 5   ; Monigotes, direcci¢n Y
d_paso:         equ 8   ; Paso
d_puntos:       equ 9   ; Puntos acumulados
d_offset:       equ 12  ; Offset de pantalla (p gina oculta)
d_refx:         equ 14  ; Referencia X (base nivel)
d_refy:         equ 15  ; Referencia Y (base nivel)
d_real:         equ 16  ; Offset de nivel (datos reales)
d_moni:         equ 18  ; Offset de lista de monigotes
d_vidas:        equ 20  ; Vidas
d_espera:       equ 21  ; Espera antes de m s da¤o.
d_basex:        equ 22  ; Base X de donde apareci¢.
d_basey:        equ 23  ; Base Y de donde apareci¢.

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
        ; Inicia la pila e intercepta vector de interrupci¢n
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
        ; Introducci¢n del juego
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
        ld de,$0400
        ld bc,1024
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$0C00
        ld bc,1024
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$1400
        ld bc,1024
        call LDIRVM
        ld hl,graf_color
        ld de,$2400
        ld bc,1024
        call LDIRVM
        ld hl,graf_color
        ld de,$2C00
        ld bc,1024
        call LDIRVM
        ld hl,graf_color
        ld de,$3400
        ld bc,1024
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
        ld bc,22
        ldir
        ld hl,jug2_inicial
        ld de,jug2
        ld bc,22
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
        ; Vector de interrupci¢n, llamado 50 o 60 veces por segundo
        ; Todos los registros son salvados por el BIOS MSX
        ;
vector_int:
        ;
        ; Limpia la interrupci¢n
        ;
        call RDVDP
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
        ; Pone el modo de alta resoluci¢n
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
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,8*16
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
        cp 90
        call nc,agrega_monigote
        add a,a
        add a,a
        add a,$80
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
        xor a
        ret

        ;
        ; Agrega un monigote
        ; !!! Actualmente solo maneja un tipo de monstruo
        ;
agrega_monigote:
        push de
        push hl
        push af
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
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
        cp 90
        ld a,144
        ld de,$00ff
        jp z,.3
        ld a,128
        ld de,$0001
.3:     ld (hl),a       ; Sprite
        inc hl
        ld (hl),$03     ; Color
        inc hl
        ld (hl),e       ; Dir. X
        inc hl
        ld (hl),d       ; Dir. Y
        inc hl
        ld (hl),3       ; Velocidad
        inc hl  
        ld (hl),2       ; Energ¡a
        inc hl
        ld (hl),3       ; Paso actual (copia de velocidad)
        inc hl
        inc hl
        inc hl
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
        xor a
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
        srl a
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
        ld de,66
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
        ld ix,jug1
        call actualiza_jugador
        ld ix,jug2
        call actualiza_jugador
        ret

        ;
        ; Actualiza el sprite de un jugador
        ;
actualiza_jugador:
        ld a,(ix+d_vidas)
        cp $ff
        jp nz,.1
        ld a,$d1
        ld (de),a
        inc de
        inc de
        inc de
        inc de
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
        and 4
        ld a,(ix+d_color)
        jp z,.6
        ld a,$0f
.6:     ld (de),a
        inc de
        ;
        ; Actualiza sprites monigotes
        ;
.2:     ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,8
.3:     ld a,(hl)
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

.4:     inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
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
        push bc
        ld bc,13
        add hl,bc
        pop bc
.5:     djnz .3
        ret

        ;
        ; Maneja la entrada del usuario
        ;
maneja_entrada:
        ld ix,jug1
        ld a,0
        call GTSTCK
        call maneja_dir
        ; !!! Falta el disparo del jugador 1
        ld ix,jug2
        ld a,1
        call GTSTCK
        call maneja_dir
        ; !!! Falta el disparo del jugador 2
        ret

        ;
        ; Mueve un jugador en una direcci¢n
        ;
maneja_dir:
        push af
        ld a,(ix+d_espera)
        or a
        jp z,.1
        dec (ix+d_espera)
.1:     pop af
        dec (ix+d_paso)
        jp nz,mueve_monstruos
        ld l,(ix+d_velocidad)
        ld (ix+d_paso),l
        ld l,(ix+d_real)
        ld h,(ix+d_real+1)
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
        ld a,(ix+d_x)
        and $0f
        jp nz,.2
        ld a,(ix+d_y)
        and $0f
        jp nz,.2
        ld de,0
        call accede_casilla
        cp 98
        jp nz,.2
        inc (ix+d_nivel)
        inc (ix+d_nivel)
        call carga_nivel
        call actualiza_indicadores
        ld a,(ix+d_nivel)
        cp 4
        ; !!! jp nc,finaliza_juego
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
.1:     ld a,(ix+0)
        or a
        jp z,.2
        dec (ix+d_paso) ; ¨Ya puede moverse?
        jp nz,.2        ; No, salta.
        ld a,(ix+d_velocidad)
        ld (ix+d_paso),a
.3:     ld a,(ix+d_sprite)
        and $e0
        cp $80
        jp nz,.2
        ; !!! Actualmente solo maneja un tipo de monstruo
        call mueve_monstruo_1
        ld a,(ix+0)
        sub (iy+0)
        jp nc,.5
        neg 
.5:     cp 14
        jp nc,.2
        ld a,(ix+1)
        sub (iy+1)
        jp nc,.6
        neg
.6:     cp 14
        jp nc,.2
        ld a,(iy+d_espera)
        or a            ; ¨El jugador puede recibir da¤o?      
        jp nz,.2        ; No, salta.
        push bc
        push ix
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

        ;
        ; Movimiento del monstruo 1
        ;
mueve_monstruo_1:
        ld a,(ix+4)
        cp 1    ; ¨Va a la derecha?
        jp z,.1
        call mov_izquierda
        ret c
        ld a,(ix+4)
        neg
        ld (ix+4),a
        ret

.1:     call mov_derecha
        ret c
        ld a,(ix+4)
        neg
        ld (ix+4),a
        ret

        ;
        ; Movimiento hacia arriba
        ;
mov_arriba:
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
        scf
        ret

        ;
        ; Movimiento hacia abajo
        ;
mov_abajo:
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
        scf
        ret

        ;
        ; Movimiento a la izquierda
        ;
mov_izquierda:
        ld a,(ix+d_x)
        sub (ix+d_refx)
        or a
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
        scf
        ret

        ;
        ; Movimiento a la derecha
        ;
mov_derecha:
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
        scf
        ret

        ;
        ; Verifica si puede moverse libremente
        ;
mov_libre:
        bit 7,e
        jp nz,.1
        ld a,e
        add a,15
        ld e,a
.1:     bit 7,d
        ld a,0
        jp nz,.2
        ld a,15
.2:     add a,d
        ld d,a
        call accede_casilla
        ld e,a
        ld d,0
        push hl
        ld hl,caminable
        add hl,de
        ld a,(hl)
        or a
        pop hl
        ret z
        scf
        ret

        ;
        ; Accede una casilla del nivel
        ;
accede_casilla:
        ld a,(ix+d_x)
        sub (ix+d_refx)
        add a,e
        srl a
        srl a
        srl a
        srl a
        ld e,a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        add a,d
        srl a
        srl a
        srl a
        srl a
        add a,a
        add a,a
        ld d,a
        add a,a
        add a,d
        add a,e
        ld e,a
        ld d,0
        push hl
        add hl,de
        ld a,(hl)
        pop hl
        ret

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
        ; !!! Mostrar presentaci¢n "Zombie wars"
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

jug1_inicial:
        db 0,0,0,7,0,0,2,6,2,0,0,0
        dw pantalla
        db 0,0
        dw 0
        dw monigotes
        db 2    ; Dos vidas
        db 0
        db 0,0
jug2_inicial:
        db 224,144,64,9,0,1,2,6,2,0,0,0
        dw pantalla+392
        db $40,$60
        dw 0
        dw monigotes+8*16
        db 2    ; Dos vidas
        db 0
        db 0,0

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
jug1_n: RB 1    ; Pantalla que est  jugando
jug1_l: RB 1    ; Velocidad
jug1_e: RB 1    ; Energia restante
jug1_a: RB 1    ; Paso
jug1_p: RB 3    ; Puntuaci¢n (BCD)
jug1_o: RB 2    ; Offset pantalla
jug1_f: RB 1    ; Referencia X
jug1_g: RB 1    ; Referencia Y
jug1_d: RB 2    ; Apunta al nivel que esta jugando
jug1_m: RB 2    ; Su tabla de amistosos monigotes
jug1_v: RB 1    ; Vidas restantes ($ff = muerto)
        RB 1
        RB 2    ; Base X y Y de donde empieza si pierde una vida.

jug2:   ; Datos del jugador 2
        RB 24

monigotes:      ; Tabla de monigotes
        RB 16*16

        ;
        ; Variables usadas por el n£cleo
        ;
ticks:  RB 1
ciclo:  RB 1
modo:   RB 1

        ORG $F0F0
PILA:   

