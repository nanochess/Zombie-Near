        ;
        ; Zombie Wars
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011
        ;
        ; Creaci¢n: 06-ene-2011.
        ; Revisi¢n: 07-ene-2011. Ya no ocurren movimientos desalineados. Los
        ;                        niveles se navegan ahora como laberintos.
        ;                        Los cuadros sin fondo toman info. de
        ;                        alrededor.
        ; Revisi¢n: 08-ene-2011. Los sprites de los jugadores se definen
        ;                        sobre la marcha para hacer espacio a m s
        ;                        sprites. Permite agregar "adornos" y objetos
        ;                        a los niveles. Permite recoger la llave y
        ;                        rescatar a los cient¡ficos. Permite usar la
        ;                        llave para traspasar puerta. Se implementa
        ;                        el zombie tipo 3 que persigue al jugador.
        ;                        Se implementa el disparo. Ya visualiza el
        ;                        sprite del gran jefe.
        ; Revisi¢n: 09-ene-2011. Se incorpora el gran jefe zombie. La bala
        ;                        empuja a los monstruos al impactarlos. Se
        ;                        agregan rutinas de relleno para efectos de
        ;                        sonido y m£sica. La mancha se vuelve verde
        ;                        obscuro. Se corrige movimiento de zombies 3
        ;                        y se hacen negros. Se agregan vidas, dan
        ;                        energ¡a. Los cient¡ficos, llaves y vidas
        ;                        solo aparecen una vez y desaparecen al ser
        ;                        tomados. Correcciones varias. Se agrega
        ;                        pausa con F1. Limpia pantalla antes de
        ;                        empezar juego (antes se ve¡an por instantes
        ;                        los caracteres). Las llaves y las vidas
        ;                        parpadean. Se empiezan a armar rutinas
        ;                        preliminares para presentaci¢n.
        ; Revisi¢n: 10-ene-2011. Se incorpora c¢digo para probar los
        ;                        retratitos. Se integran los retratitos. Se
        ;                        integra la pantalla de t¡tulo usando el
        ;                        descompactador de mi juego sin terminar
        ;                        Galaktis. Se integra pantalla de alerta.
        ;

        ORG $4000

        FNAME "ZOMBIWAR.ROM"

        ;
        ; Por hacer:
        ; o Los efectos de sonido.
        ; o La m£sica de fondo.
        ; o La megapresentaci¢n espectacular
        ; o El megafinal espectacular.
        ;
        ; Peque¤os detalles:
        ; o Adornar las paredes (cuadros, avisos, etc)
        ; o Agregar estatuas (p.ej, una venus, al C, yo mero, los personajes)
        ; o Poner los adornos al £ltimo en la lista de monigotes para que
        ;   nunca aparezcan encima de los monigotes.
        ;
        ; Ya hecho:
        ; o Integrar el gran jefe (09-ene-2011)
        ; o Urge el disparo (08-ene-2011)
        ; o Desarrollar el zombie tipo 3 (08-ene-2011)
        ; o Implementar las llaves (08-ene-2011)
        ; o Dispersar zombies por los niveles (08-ene-2011)
        ; o Dispersar cient¡ficos por los niveles. (08-ene-2011)
        ; o Decorar los niveles (08-ene-2011)
        ; o Sprites decorativos para esqueletitos y sangrita. (08-ene-2011)
        ; o Definir los sprites de los jugadores en tiempo real,
        ;   para hacer m s espacio para figuras. (08-ene-2011)
        ; o El laberinto y m s gr ficas. (07-ene-2011)
        ; o Tener un engine b sico y gr ficas preliminares. (06-ene-2011)
        ; o Un mont¢n de cosas.
        ;

        ;
        ; En el Z80 la instrucci¢n JR es m s lenta que JP cuando se toma
        ; el salto, as¡ que he preferido usar solo JP, ­cada ciclo cuenta!
        ;

        ;
        ; Al principio iba a ser un avance por pisos, sin retroceso, pero
        ; como quedaron tan peque¤os lo hice por habitaciones, pero se
        ; qued¢ el nombre de pisos :)
        ;
        ; El convertidor de imagenes BMP a formato MSX y el compactador
        ; de titulos, cortes¡a de mi juego no acabado Galaktis.
        ;

        ;
        ; Tecnicas de portabilidad
        ; * El uso de byte $0006 para obtener puerta VDP (98)
        ; * El uso de byte $002B (bit 7 = 0 = 60 hz, 1= 50 hz)
        ;

        DB "AB"         ; Para que el MSX reconozca el cartucho
        DW INICIO

        DB "Zombie Wars, a freeware MSX game, "
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
SNSMAT: EQU $0141       ; Lee l¡nea A del teclado en A

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
d_energia:      equ 7   ; Energ¡a
d_dx:           equ 4   ; Monigotes, direcci¢n X
d_dy:           equ 5   ; Monigotes, direcci¢n Y
d_paso:         equ 8   ; Paso
d_tipo:         equ 9   ; Monigotes, tipo
d_ultimo:       equ 10  ; Ultimo movimiento.
d_offset:       equ 12  ; Offset de pantalla (p gina oculta)
d_refx:         equ 14  ; Referencia X (base nivel)
d_refy:         equ 15  ; Referencia Y (base nivel)
d_real:         equ 16  ; Offset de nivel (datos reales)
d_moni:         equ 18  ; Offset de lista de monigotes
d_vidas:        equ 20  ; Vidas
d_espera:       equ 21  ; Espera antes de m s da¤o.
d_basex:        equ 22  ; Base X de donde apareci¢.
d_basey:        equ 23  ; Base Y de donde apareci¢.
d_puntos:       equ 24  ; Puntos acumulados
d_objeto:       equ 27  ; Indica si lleva objetos (actualmente solo llave)
d_trans:        equ 28  ; Ubicaci¢n del transportador (p gina oculta)
d_tiempo:       equ 30  ; Tiempo para que aparezca gran jefe
d_mapa:         equ 32  ; Apuntador a mapa modificado.

BASE_MOSAICOS:  equ $40 ; Caracter base de mosaicos gr ficos.

tabla_modo_2:
        DB $02          ; Registro 0
        DB $A2          ; Registro 1
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
        di
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
        ; Introducci¢n del juego
        ;
        call musica_silencio
        call vdp_modo_2
        call presentacion
        ;
        ; Entrada al juego
        ;
        ld hl,modo
        res 0,(hl)
        ;
        ; Procede a inicializar la pantalla oculta
        ;
        call limpia_sprites
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
        ld hl,$3c00
        ld bc,$0300
        ld a,$00
        call FILVRM
        ;
        ; Carga las letras (64 caracteres, replicados 3 veces para
        ; los bitmaps y 3 veces para el color)
        ;
        ld hl,letras
        ld de,$0000
        ld bc,512
        call LDIRVM
        ld hl,letras
        ld de,$0800
        ld bc,512
        call LDIRVM
        ld hl,letras
        ld de,$1000
        ld bc,512
        call LDIRVM
        ld hl,color_letras
        ld de,$2000
        ld bc,512
        call LDIRVM
        ld hl,color_letras
        ld de,$2800
        ld bc,512
        call LDIRVM
        ld hl,color_letras
        ld de,$3000
        ld bc,512
        call LDIRVM
        ;
        ; Carga los mosaicos para los niveles (hasta 48 diferentes)
        ;
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
        ;
        ; Espera una actualizaci¢n
        ;
        halt
        ;
        ; Estado inicial de los jugadores
        ;
        ld hl,jug1_inicial
        ld de,jug1
        ld bc,34
        ldir
        ld hl,mapa1
        ld b,101
        ld (hl),0
        inc hl
        djnz $-3
        ld hl,jug2_inicial
        ld de,jug2
        ld bc,34
        ldir
        ld hl,mapa2
        ld b,101
        ld (hl),0
        inc hl
        djnz $-3
        ;
        ; A partir de ahora solo la rutina de interrupci¢n toca el VDP
        ;
        ld hl,modo
        set 2,(hl)      ; Redefine sprites
        set 0,(hl)      ; Controla sprites y pantalla
        ;
        ; Carga los niveles para cada uno y actualiza sus indicadores
        ;
        ld ix,jug1
        call carga_nivel
        call actualiza_indicadores
        ld ix,jug2
        call carga_nivel
        call actualiza_indicadores
        ;
        ; Comienza la m£sica
        ;
        call musica_general
        ;
        ; Bucle principal
        ;
.1:     halt                    ; Actualizaci¢n, tambi‚n ahorra energ¡a.
        call actualiza_sprites  ; Coloca los sprites
        call maneja_entrada     ; Los jugadores y monstruos se mueven.
        call checa_pausa
        jr .1                   ; Repite incansablemente

        ;
        ; Vector de interrupci¢n, llamado 50 o 60 veces por segundo
        ; Todos los registros son salvados por el BIOS MSX
        ;
vector_int:
        ;
        ; Limpia la interrupci¢n
        ;
        call RDVDP
        ld hl,modo
        bit 7,(hl)
        ret nz
        set 7,(hl)
        ld a,(estado)
        add a,a
        ld e,a
        ld d,0
        ld hl,vector_dir
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        jp (hl)

vector_dir:
        dw .0
        dw .5
        dw .6

.5:     call LINEAS_ABRE
        LD HL,modo
        RES 7,(HL)
        RET

.6:     call LINEAS
        LD HL,modo
        RES 7,(HL)
        RET

        ;
        ; Solo en el modo de juego se mete con el VDP
        ;
.0:     ld hl,modo
        bit 0,(hl)
        jp z,.2
        bit 2,(hl)
        jp z,.3
        ;
        ; Obtiene los sprites que est n usando los h‚roes...
        ;
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
        ; ...para definirlos en el momento.
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
        pop af
        ld (sprites+6),a
        pop af
        ld (sprites+2),a
        jp .4

        ;
        ; Actualiza los sprites
        ;
.3:     ld hl,$3f80
        call SETWRT
        ld hl,sprites
        ld c,$98
        ld b,128
        outi
        jp nz,$-2
        ;
        ; Actualiza la pantalla
        ;
.4:     ld hl,$3c00
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
.2:     ld hl,modo
        res 7,(hl)
        ld a,($002B)
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
.1:     ;
        ; Incrementa ticks transcurridos
        ;
        ld hl,(ticks)
        inc hl
        ld (ticks),hl
        ret

        ;
        ; Pantalla negra
        ; Realiza una secuencia de cortina de izquierda a derecha
        ;
PANTALLA_NEGRA:
        LD HL,modo
        RES 0,(HL)
        LD HL,$2000
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$2800
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$3000
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$0000
        LD BC,8
        XOR A
        CALL FILVRM
        LD HL,$0800
        LD BC,8
        XOR A
        CALL FILVRM
        LD HL,$1000
        LD BC,8
        XOR A
        CALL FILVRM
        LD DE,32
        LD C,32
PANTALLA_NEGRA3:
        LD H,$3C
        LD A,32
        SUB C
        LD L,A
        LD B,24
        XOR A
PANTALLA_NEGRA2:
        CALL WRTVRM
        ADD HL,DE
        DJNZ PANTALLA_NEGRA2
        LD A,(ticks)
        LD B,A
PANTALLA_NEGRA4:
        LD A,(ticks)
        CP B
        JR Z,PANTALLA_NEGRA4
        DEC C
        JR NZ,PANTALLA_NEGRA3
        LD HL,$0000
        LD BC,6144
        XOR A
        CALL FILVRM
        LD HL,$2000
        LD BC,6144
        XOR A
        CALL FILVRM
        LD HL,pantalla
PANTALLA_NEGRA1:
        LD (HL),L
        INC HL
        LD A,H
        CP (pantalla+768)>>8
        JR NZ,PANTALLA_NEGRA1
PANTALLA_NEGRA0:
        LD HL,pantalla
        LD DE,$3C00
        LD BC,768
        CALL LDIRVM
        RET

        ;
        ; Carga una toma de la historia
        ; (gr fica compactada)
        ;
CARGAR_TOMA:
        LD A,H
        AND $E0
        OR E
        RLCA
        RLCA
        RLCA
        DI
        LD (L_PAGINA),A
        LD A,H
        AND $1F
        OR $A0
        LD H,A
        LD (L_OFFSET),HL
        LD A,B
        LD (ESTADO),A
        LD HL,0
        LD (L_LINEA),HL
        EI
.1:     HALT
        LD A,(L_LINEA)
        CP 64
        JP C,.1
        XOR A
        LD (ESTADO),A
        RET

        ;
        ; Visualiza una imagen por apertura
        ;
LINEAS_ABRE:
        LD HL,(L_LINEA)
        LD A,L
        CP 64
        RET NC
        LD B,A
        LD DE,(L_OFFSET)
        LD A,(L_PAGINA)
        LD ($A000),A
        LD A,63
        SUB B
        PUSH AF
        AND 7
        LD L,A
        POP AF
        RRCA
        RRCA
        RRCA
        AND $1F
        LD H,A
        LD C,$08
        PUSH HL
        CALL LINEAS10
        POP HL
        PUSH HL
        SET 5,H
        CALL LINEAS10
        POP HL
        LD A,(L_LINEA)
        ADD A,64
        PUSH AF
        AND 7
        LD L,A
        POP AF
        RRCA
        RRCA
        RRCA
        AND $1F
        LD H,A
        PUSH HL
        CALL LINEAS10
        POP HL
        PUSH HL
        SET 5,H
        CALL LINEAS10
        POP HL
        LD A,(L_LINEA)
        CP 63
        JR NZ,LINEAS0
        LD HL,$1000
        LD BC,$0808
LINEAS9:
        PUSH BC
        PUSH HL
        CALL LINEAS10
        POP HL
        PUSH HL
        SET 5,H
        CALL LINEAS10
        POP HL
        POP BC
        INC L
        LD A,L
        CP 8
        JR NZ,LINEAS9
        LD L,0
        INC H
        DJNZ LINEAS9
LINEAS0:
        LD HL,L_LINEA
        INC (HL)
        LD (L_OFFSET),DE
        RET

        ;
        ; Visualiza una imagen por l¡neas
        ;
LINEAS:
        LD HL,(L_LINEA)
        LD A,L
        CP 64
        RET Z
        AND 7
        LD B,A
        ADD A,A
        ADD A,B
        LD H,A
        SRL L
        SRL L
        SRL L
        LD DE,(L_OFFSET)
        LD A,(L_PAGINA)
        LD ($A000),A
        CALL LINEAS1
        LD HL,L_LINEA
        INC (HL)
        LD (L_OFFSET),DE
        RET

LINEAS1:
        LD BC,$0308
LINEAS6:
        PUSH BC
        PUSH HL
        CALL LINEAS5
        POP HL
        PUSH HL
        SET 5,H
        CALL LINEAS5
        POP HL
        POP BC
        INC H
        DJNZ LINEAS6
        RET

LINEAS10:
        LD A,(DE)
        CP $80
        JR NZ,LINEAS5
        INC DE
        BIT 6,D
        CALL NZ,LINEAS7
        RET
LINEAS5:
        LD A,(DE)
        INC DE
        BIT 6,D
        CALL NZ,LINEAS7
        OR A
        JP P,LINEAS2
        CPL
        ADD A,2
        LD B,A
LINEAS3:
        LD A,(DE)
        CALL MIPOKE
        LD A,C
        ADD A,L
        LD L,A
        DJNZ LINEAS3
        INC DE
        BIT 6,D
        CALL NZ,LINEAS7
        RET C
        JP LINEAS5
LINEAS2:
        INC A
        LD B,A
LINEAS4:
        LD A,(DE)
        INC DE
        BIT 6,D
        CALL NZ,LINEAS7
        CALL MIPOKE
        LD A,C
        ADD A,L
        LD L,A
        DJNZ LINEAS4
        RET C
        JP LINEAS5

LINEAS7:
        PUSH AF
        LD A,(L_PAGINA)
        INC A
        LD (L_PAGINA),A
        LD DE,$A000
        LD (DE),A
        POP AF
        RET

MIPOKE:
        EX AF,AF'
        CALL SETWRT
        EX AF,AF'
        OUT ($98),A
        RET

        ;
        ; Limpia los sprites.
        ; Los sprites se conservan buffereados en el modo 1
        ;
limpia_sprites:
        ld hl,sprites
        ld d,h
        ld e,l
        inc de
        ld bc,127
        ld (hl),$d1
        ldir
        ret

        ;
        ; Pone el modo de alta resoluci¢n
        ;
vdp_modo_2:
        LD hl,modo
        res 0,(hl)      ; No controla VDP
        res 2,(hl)      ; No define sprites
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
        ;
        ; Limpia todo
        ; 
        LD HL,$0000
        LD BC,$1800
        XOR A
        CALL FILVRM
        LD HL,$2000
        LD BC,$1800
        XOR A
        CALL FILVRM
        LD HL,$3F80
        LD A,$D1
        LD BC,$0080
        CALL FILVRM
        ;
        ; Carga los sprites fijos
        ;
        LD HL,figuras_sprites
        LD DE,$1800
        LD BC,$0800
        CALL LDIRVM
        ;
        ; Prepara para uso de pantalla de alta resoluci¢n
        ;
        LD HL,$3C00
        LD DE,pantalla
.2:     LD A,L
        LD (DE),A
        CALL WRTVRM
        INC DE
        INC HL
        LD A,H
        CP $3F
        JP NZ,.2
        LD BC,$E201     ; Activa el video
        CALL WRTVDP
        RET

        ;
        ; Checa si se oprimi¢ F1 para hacer pausa
        ;
checa_pausa:
        ld a,6
        call SNSMAT
        and $20         ; Bit 5 = F1
        ret nz          ; ¨Oprimido?, no, retorna
        ld hl,modo
        set 1,(hl)      ; Desactiva sonido
        ;
        ; Salva contenido de pantalla oculta
        ;
        ld hl,pantalla+$016c
        ld b,7
.4:     ld a,(hl)
        push af
        inc hl
        djnz .4
        ;
        ; Antirebote
        ;
        call pausa_1
.2:     ld b,10
.1:     halt
        ld a,6
        call SNSMAT
        and $20
        jp z,.2
        djnz .1
        ;
        ; Lazo principal de pausa
        ;
.3:     ld a,(ticks)
        and $10
        jp z,.6
        call pausa_1
        jp .7

.6:     call pausa_2
.7:     halt
        ld a,6
        call SNSMAT
        and $20         ; ¨F1 oprimido?
        jp nz,.3        ; No, sigue esperando
        ;
        ; Restaura pantalla
        ;
        ld hl,pantalla+$0172
        ld b,7
.5:     pop af
        ld (hl),a
        dec hl
        djnz .5
        ;
        ; Antirebote
        ;
.8:     ld b,10
.9:     halt
        ld a,6
        call SNSMAT
        and $20
        jp z,.8
        djnz .9
        ld hl,modo
        res 1,(hl)      ; Reactiva sonido
        ret

pausa_1:
        ld hl,pantalla+$016c
        ld (hl),0
        inc hl
        ld (hl),$10     ; P
        inc hl
        ld (hl),$01     ; A
        inc hl
        ld (hl),$15     ; U
        inc hl
        ld (hl),$13     ; S
        inc hl
        ld (hl),$05     ; E
        inc hl
        ld (hl),0
        ret

pausa_2:
        ld hl,pantalla+$016c
        xor a
        ld b,7
.1:     ld (hl),a
        inc hl
        djnz .1
        ret

        ;
        ; Carga un nivel
        ;
carga_nivel:
        xor a           ; No hay transportador
        ld (ix+d_trans),a
        ld (ix+d_trans+1),a
        ;
        ; Limpia la tabla de monigotes correspondiente
        ;
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,MAX_MONIGOTES*16
        xor a
.3:     ld (hl),a
        inc hl
        djnz .3
        ;
        ; Busca el nivel
        ;
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
        ld (ix+d_real),l        ; Anota
        ld (ix+d_real+1),h
        ;
        ; Dibuja en pantalla oculta
        ;
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld c,6
.1:     push de
        ld b,12
.2:     push bc
        ld a,(hl)               ; Casilla del mapa
        cp 99
        call z,inicio_jugador
        cp 98
        call z,final_jugador
        cp 97
        call z,anota_transportador
        cp 78
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

        ;
        ; Deriva coordenadas X,Y
        ;
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
        sub 78
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
        dw vida         ; 78 Vida
        dw entrada2     ; 79 Entrada jefe 2
        dw zombie3_izq  ; 80 Zombie 3 izq.
        dw zombie3_der  ; 81 Zombie 3 der.
        dw zombie3_arr  ; 82 Zombie 3 arriba
        dw zombie3_aba  ; 83 Zombie 3 abajo
        dw llave        ; 84 Llave del laboratorio
        dw cientifico   ; 85 Cient¡fico
        dw cientifica   ; 86 Cient¡fica (mismo sprite p/caber, color dif.)
        dw mancha       ; 87 Una manchita de sangre
        dw esqueleto    ; 88 Medio esqueletito
        dw mano_suelta  ; 89 Una manita suelta
        dw zombie1_izq  ; 90 Zombie 1 izq.
        dw zombie1_der  ; 91 Zombie 1 der.
        dw zombie2_izq  ; 92 Zombie 2 izq.
        dw zombie2_der  ; 93 Zombie 2 der.
        dw zombie2_arr  ; 94 Zombie 2 arriba
        dw zombie2_aba  ; 95 Zombie 2 abajo
        dw entrada1     ; 96 Entrada jefe 1
        dw nada         ; 97 Puerta con llave
        dw nada         ; 98 Conexi¢n con otro piso
        dw nada         ; 99 Sin uso

entrada1:
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        ld hl,100
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        call musica_esperando
        pop hl
        pop de
        pop bc
        ld a,20 ; Puerta oeste
        ret

entrada2:
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        ld hl,100
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        call musica_esperando
        pop hl
        pop de
        pop bc
        ld a,40 ; Puerta sur
        ret
               
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

vida:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 1,(hl)      ; ¨Ya tomada?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
        ld a,$3c
        ld de,$0000
        ld bc,$010b
        ex af,af'
        ld a,9
        ex af,af'
        jp anota_monigote

llave:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 2,(hl)      ; ¨Ya usada?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
        ld a,$10
        ld de,$0000
        ld bc,$0107
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

cientifico:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 0,(hl)      ; ¨Ya rescatado?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
        ld a,$30
        ld de,$0000
        ld bc,$0306
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

cientifica:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 0,(hl)      ; ¨Ya rescatada?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
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
        ld a,12
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
        ld a,1
        ex af,af'
        jp anota_monigote

zombie3_der:
        ld a,$40
        ld de,$0001
        ld bc,$0103
        ex af,af'
        ld a,1
        ex af,af'
        jp anota_monigote

zombie3_arr:
        ld a,$70
        ld de,$ff00
        ld bc,$0103
        ex af,af'
        ld a,1
        ex af,af'
        jp anota_monigote

zombie3_aba:
        ld a,$60
        ld de,$0100
        ld bc,$0103
        ex af,af'
        ld a,1
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
        ld (hl),a       ; Energ¡a (2, 3 y 4 por tipo de monstruo)
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
        ; un objeto, adorno o monigote, as¡ que lo deriva de los
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
        ; Actualiza la animaci¢n del transportador
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
        cp 4    ; ¨Zombie jefe?
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
        ld a,1          ; Joystick 1, bot¢n A
        call GTTRIG
        or a
        call nz,disparo
        ld a,3          ; Joystick 1, bot¢n B
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
        ld a,(ix+d_vidas)
        cp $ff
        ret z
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
        and $30         ; ¨Mira a la derecha?
        ld de,$fd06
        ld bc,$0004
        jp z,.1
        cp $10          ; ¨Mira a la izquierda?
        ld de,$fdfa
        ld bc,$00fc
        jp z,.1
        cp $30          ; ¨Mira arriba?
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
        ; Mueve un jugador en una direcci¢n
        ;
maneja_dir:
        push af
        ld a,(ix+d_vidas)
        cp $ff          ; ¨Muerto?
        jp nz,.12
        pop af          ; No acepta m s entradas
        jp .2
.12:
        ;
        ; Cuenta el tiempo para que aparezca gran jefe
        ;
        ld l,(ix+d_tiempo)
        ld h,(ix+d_tiempo+1)
        ld a,h
        or l
        jp z,.9
        dec hl
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        ld a,h
        or l
        jp nz,.9
        call musica_batalla
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16
        add hl,de
        ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $60
        jp c,.10
        ;
        ; El jugador se halla a la derecha, nuestro
        ; amistoso monstruo le dar  una sorpresa a la izquierda.
        ;
        ld a,(ix+d_refx)
        ld (hl),a       ; Posici¢n X.
        inc hl
        ld a,(ix+d_refy)
        sub $20
        ld (hl),a       ; Posici¢n Y.
        inc hl
        ld (hl),$c0     ; Sprite, andando a la izquierda
        inc hl
        ld de,$0101
        jp .11

        ;
        ; El jugador se halla a la izquierda, nuestro
        ; amistoso monstruo caer  a la derecha
        ;
.10:    ld a,(ix+d_refx)
        add a,$a0
        ld (hl),a        ; Posici¢n X.
        inc hl
        ld a,(ix+d_refy)
        sub $20
        ld (hl),a       ; Posici¢n Y.
        inc hl
        ld (hl),$80     ; Sprite, andando a la izquierda
        inc hl
        ld de,$01ff

.11:    ld (hl),$0f     ; Color
        inc hl
        ld (hl),e       ; Dir. X
        inc hl
        ld (hl),d       ; Dir. Y
        inc hl
        ld (hl),1       ; Velocidad
        inc hl
        ld (hl),25      ; 25 impactos para detener al jefe zombie.
        inc hl
        ld (hl),1       ; Paso actual (copia de velocidad)
        inc hl
        ld (hl),4       ; Tipo de monigote
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
.9:
        ;
        ; Cuenta el tiempo para la recarga del disparo
        ;
        ld a,(ix+d_recarga)
        or a
        jp z,.7
        dec (ix+d_recarga)
.7:
        ;
        ; Tiempo de espera para no recibir da¤o.
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
        ld a,(ix+d_x)
        and $f0
        ld e,a
        ld a,(ix+d_y)
        add a,$0f
        and $f0
        ld d,a
        call accede_casilla2
        cp 79
        jp z,.8
        cp 96
        jp z,.5
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

.8:     pop af
        call mov_arriba
        jp .2

.6:     pop af
        ;
        ; Ahora chi, ¨que movimiento queria?
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
        cp 97           ; ¨Transportador?
        jp nz,.2
        res 0,(ix+d_objeto)     ; Le quita la llave al jugador
        call musica_avance
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
        cp 101
;        jp z,  ; !!! Termin¢ el juego, musica_final
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
        dec (ix+d_paso) ; ¨Ya puede moverse?
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

.15:    dw .4           ; 1- Zombie tipo 1
        dw .8           ; 2- Zombie tipo 2
        dw .12          ; 3- Zombie tipo 3
        dw .17          ; 4- Zombie jefe
        dw .2           ; 5- Adorno, ignora
        dw .9           ; 6- Cient¡fico/a
        dw .22          ; 7- Llave
        dw .13          ; 8- Bala
        dw .16          ; 9- Bala en explosi¢n.
        dw .14          ; 10- Explosi¢n monstruo.
        dw .20          ; 11- Vida

        ;
        ; Llave
        ;
.22:    ld a,(ticks)
        and $0c
        ld c,$0a
        jp z,.23
        cp $04
        ld c,$0b
        jp z,.23
        cp $08
        ld c,$0f
        jp z,.23
        ld c,$0b
.23:    ld (ix+d_color),c
        jp .7

        ;
        ; Vida
        ;
.20:    ld a,(ticks)
        and $0c
        ld c,$06
        jp z,.21
        cp $04
        ld c,$08
        jp z,.21
        cp $08
        ld c,$09
        jp z,.21
        ld c,$08
.21:    ld (ix+d_color),c
        jp .7

        ;
        ; Explosi¢n
        ;
.14:    ld a,(ix+d_sprite)
        add a,4
        ld (ix+d_sprite),a
        cp $30
        jp nz,.2
.16:    xor a
        ld (ix+d_tipo),a
        jp .2

        ;
        ; El/la cient¡fico/cient¡fica mueve su manita
.9:
        ld a,(ix+d_sprite)
        and $f0
        ld c,a
        ld a,(ticks)
        and $0c
        cp $0c
        jp nz,.18
        ld a,$04        ; El cuadro 3 es el cuadro 1 replicado
.18:    or c
        ld (ix+d_sprite),a
        jp .7

.13:    call mueve_bala
        jp .2

.17:    call mueve_jefe
        ;
        ; Verifica si el jugador toca al jefe
        ;
        ld a,(iy+d_vidas)
        cp $ff
        jp z,.2
        ld a,(iy+d_x)
        add a,8
        sub (ix+d_x)
        cp $20
        jp nc,.2
        ld a,(iy+d_y)
        add a,8
        sub (ix+d_y)
        cp $20
        jp nc,.2
        xor a
        jp .6

.12:    call mueve_monstruo_3
        jp .7

.8:     call mueve_monstruo_2
        jp .7

.4:     call mueve_monstruo_1
        ;
        ; Verifica si el jugador toca el monstruo/adorno/objeto
        ;
.7:     ld a,(iy+d_vidas)
        cp $ff
        jp z,.2
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp nc,.5
        neg 
.5:     cp 13
        jp nc,.2
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nc,.6
        neg
.6:     cp 13
        jp nc,.2
        ld a,(ix+d_tipo)
        cp 5
        jp c,.10
        cp 6
        jp nz,.11
        ;
        ; Toc¢ un cient¡fico
        ;
        ld (ix+d_tipo),0     ; Lo quita
        push bc
        push hl
        push ix
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        add hl,de
        set 0,(hl)          ; Ya no aparece m s
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
        ; Toc¢ la llave
        ;
.11:    cp 7
        jp nz,.19
        ld (ix+d_tipo),0     ; La quita
        set 0,(iy+d_objeto)     ; Indica que la lleva
        push bc
        push hl
        push ix
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        add hl,de
        set 2,(hl)          ; Ya no aparece m s
        push iy
        pop ix
        call actualiza_indicadores
        call efecto_llave
        pop ix
        pop hl
        pop bc
        jp .2

        ;
        ; Recuperaci¢n de energ¡a
        ;
.19:    ld (ix+d_tipo),0        ; La quita
        ld (iy+d_energia),6
        push bc
        push hl
        push ix
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        add hl,de
        set 1,(hl)          ; Ya no aparece m s
        push iy
        pop ix
        call actualiza_indicadores
        call efecto_vida
        pop ix
        pop hl
        pop bc
        jp .2
        
        ;
        ; Toc¢ un monstruo
        ;
.10:
        ld a,(iy+d_espera)
        or a            ; ¨El jugador puede recibir da¤o?      
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
        ; Notese que al reiniciar la posici¢n tambi‚n reinicia el
        ; sprite y direcci¢n de movimiento, porque queda a un pixel
        ; del inicio real con el fin de evitar un molesto flicker
        ; de cambio entre zonas y si no se hiciera as¡, al tratar de
        ; moverse se ir¡a en direcci¢n equivocada, ocasionando un
        ; bucle infinito.
        ;
jugador_atrapado:
        ld a,(ix+d_basex)
        add a,4         ; Necesario o puede trabarse
        and $f0
        sub (ix+d_refx)
        or a
        jp nz,.1
        ld c,$00
        inc a
        ld hl,mov_derecha
        jp .2

.1:     cp $b0
        jp nz,.2
        ld c,$10
        dec a
        ld hl,mov_izquierda
.2:     add a,(ix+d_refx)
        ld (ix+d_x),a
        ld a,(ix+d_basey)
        add a,4         ; Necesario o puede trabarse
        and $f0
        or a
        jp nz,.3
        ld c,$20
        inc a
        ld hl,mov_abajo
        jp .4

.3:     cp $50
        jp nz,.4
        ld c,$30
        dec a
        ld hl,mov_arriba
.4:     add a,(ix+d_refy)
        ld (ix+d_y),a
        ld (ix+d_ultimo),l
        ld (ix+d_ultimo+1),h
        ld a,(ix+d_sprite)
        and $c0
        or c
        ld (ix+d_sprite),a
        dec (ix+d_vidas)
        jp m,.5
        ld (ix+d_energia),6
        call actualiza_indicadores
        ret

.5:     call musica_fracaso
        call actualiza_indicadores
        ret

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
        ; Comprobaci¢n para monstruos grandotes
        ;
        ld a,(ix+d_x)
        add a,8
        sub (iy+d_x)
        cp $1c
        jp nc,.7
        ld a,(ix+d_y)
        add a,8
        sub (iy+d_y)
        cp $1c
        jp nc,.7
        ;
        ; La bala peg¢ en un monstruo
        ;
        dec (iy+d_energia)
        ld hl,puntos_bala
        ld (salva_puntos),hl
        jp nz,.14       ; El monstruo grande ni se inmuta.
        ;
        ; ­Wiii!, ­Monstruo matado!
        ;
        ld e,(iy+d_x)
        ld d,(iy+d_y)
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),8
        ld (iy+d_paso),8
        ld (iy+d_color),14
        ld bc,16
        add iy,bc
        ld a,e
        add a,$10
        ld (iy+d_x),a
        ld (iy+d_y),d
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),9
        ld (iy+d_paso),9
        ld (iy+d_color),14
        ld bc,16
        add iy,bc
        ld (iy+d_x),e
        ld a,d
        add a,$10
        ld (iy+d_y),a
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),10
        ld (iy+d_paso),10
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
        ld (iy+d_velocidad),7
        ld (iy+d_paso),7
        ld (iy+d_color),14
        ld bc,16
        add iy,bc
        ld a,e
        add a,$08
        ld (iy+d_x),a
        ld a,d
        add a,$08
        ld (iy+d_y),a
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),11
        ld (iy+d_paso),11
        ld (iy+d_color),14
        ld bc,16
        add iy,bc
        ld a,e
        add a,$08
        ld (iy+d_x),a
        ld a,d
        add a,$08
        ld (iy+d_y),a
        ld (iy+d_sprite),$10    ; Llave
        ld (iy+d_tipo),7
        ld (iy+d_velocidad),1
        ld (iy+d_paso),1
        ld (iy+d_color),11
        call efecto_megamonstruo
        call musica_triunfo
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
        push ix
        push iy
        pop ix
        ld hl,(salva_puntos)
        call agrega_puntos
        call actualiza_indicadores
        pop ix
        pop hl
        pop iy
        pop bc
        ret

        ;
        ; Comprobaci¢n para monstruos chiquitos
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
        ; La bala peg¢ en un monstruo
        ;
        dec (iy+d_energia)
        jp nz,.10
        ;
        ; ­Wiii!, ­Monstruo matado!
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
        ld (iy+d_velocidad),8
        ld (iy+d_paso),8
        ld (iy+d_color),14
        call efecto_monstruo
        jp .14

        ;
        ; El monstruo se atonta un instante
        ;
.10:    ld (iy+d_paso),5
        ;
        ; Empuje de la bala
        ;
        ld a,(ix+d_dx)
        or a
        jp z,.100
        jp p,.101
        ld a,(iy+d_x)
        and $0f
        cp 4
        jp c,.102
        ld a,(iy+d_x)
        sub 4
        ld (iy+d_x),a
        jp .102

.101:   ld a,(iy+d_x)
        and $0f
        jp z,.102
        cp 13
        jp nc,.102
        ld a,(iy+d_x)
        add a,4
        ld (iy+d_x),a
        jp .102

.100:   ld a,(iy+d_y)
        or a
        jp p,.103
        ld a,(iy+d_y)
        and $0f
        cp 4
        jp c,.102
        ld a,(iy+d_y)
        sub 4
        ld (iy+d_y),a
        jp .102

.103:   ld a,(iy+d_y)
        and $0f
        jp z,.102
        cp 13
        jp nc,.102
        ld a,(iy+d_y)
        add a,4
        ld (iy+d_y),a
.102:
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
        ; La bala peg¢ en algo
        ;
.5:     ld (ix+d_sprite),$0c
        ld (ix+d_color),9
        ld (ix+d_tipo),9
        call efecto_explota
        pop hl
        pop iy
        pop bc
        ret

        ; Puntos por rescatar un cient¡fico
puntos_cientifico:
        db $00,$01,$00

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
        cp 1    ; ¨Va a la derecha?
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
        cp 1    ; ¨Va a la derecha?
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

.1:     cp -1   ; ¨Va a la izquierda?
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
        cp 1    ; ¨Va hacia abajo?
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
        ; En cada intersecci¢n trata de ir hacia el jugador
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
        jp nc,.5
        ld (ix+d_dx),-1
        ld (ix+d_dy),0
        ret

.7:     call mov_derecha
        jp nc,.5
        ld (ix+d_dx),1
        ld (ix+d_dy),0
        ret

.6:     jp c,.2
        call mov_arriba
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.2:     call mov_abajo
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

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
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.9:     call mov_abajo
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

.8:     jp c,.3
        call mov_izquierda
        jp nc,.5
        ld (ix+d_dx),-1
        ld (ix+d_dy),0
        ret

.3:     call mov_derecha
        ret c
        ld (ix+d_dx),1
        ld (ix+d_dy),0
        ret

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
        jp .5

        ;
        ; Mueve al zombie jefe
        ;
mueve_jefe:
        ld a,(ix+d_dy)
        cp 1
        jp nz,.1
        ;
        ; Cayendo
        ;
        ld a,(ix+d_x)
        add a,(ix+d_dx)
        ld (ix+d_x),a
        ld a,(ix+d_y)
        add a,2
        ld (ix+d_y),a
        sub (ix+d_refy)
        cp $20
        ret nz
        xor a
        ld (ix+d_dy),a
        ret

        ;
        ; Verifica brinco
        ;
.1:     ld a,(ix+d_dy)
        cp -1
        jp nz,.2
        ;
        ; Piernas abiertas
        ;
        ld a,(ix+d_sprite)
        and $cf
        ld (ix+d_sprite),a
        ;
        ; Movimiento
        ;
        push hl
        ld a,(ix+d_ultimo)
        ld hl,salto_jefe
        ld e,a
        ld d,0
        add hl,de
        add hl,de
        ld a,(hl)
        bit 7,(ix+d_dx)
        jp z,.9
        neg
.9:     add a,(ix+d_x)
        sub (ix+d_refx)
        cp $0f
        jp nc,.10
        ld a,$10
.10:    cp $91
        jp c,.11
        ld a,$90
.11:    add a,(ix+d_refx)
        ld (ix+d_x),a
        inc hl
        ld a,(hl)
        pop hl
        add a,(ix+d_y)
        ld (ix+d_y),a
        ld a,(ix+d_ultimo)
        inc a
        cp 32
        ld (ix+d_ultimo),a
        ret nz
        xor a
        ld (ix+d_dy),a
        ld a,18
        ld (ix+d_velocidad),a
        ld (ix+d_paso),a
        ret

        ;
        ; Ciclo principal
        ; Avanzar amenazadoramente hacia el jugador
        ;
.2:     ld a,(iy+d_nivel)
        ld (ix+d_velocidad),3
        ;
        ; Mueve verticalmente
        ;
        ld a,(ix+d_y)
        add $10
        sub (iy+d_y)
        jp z,.7
        ld a,-1
        jp nc,.8
        ld a,1
.8:     add a,(ix+d_y)
        ld (ix+d_y),a
        ;
        ; Mueve horizontalmente
        ;
.7:     ld a,(ix+d_x)
        sub (iy+d_x)
        jp c,.3
        ld (ix+d_sprite),$80
        dec (ix+d_x)
        ld (ix+d_dx),-1
        jp .4

.3:     ld (ix+d_sprite),$c0
        inc (ix+d_x)
        ld (ix+d_dx),1
        ;
        ; ¨Le dan ganas de brincar?
        ;
.4:     ld a,(iy+d_x)
        add a,8
        sub (ix+d_x)
        cp $10
        jp c,.6
        ld a,r
        and $0f
        cp 5
        jp nz,.5
.6:     ld (ix+d_dy),-1
        ld (ix+d_velocidad),1
        ld (ix+d_ultimo),0
        call efecto_berrido
        ;
        ; Animaci¢n
        ;
.5:     ld a,(ticks)
        and $0c
        rlca
        rlca
        ld c,a
        ld a,(ix+d_sprite)
        and $cf
        or c
        ld (ix+d_sprite),a
        ret

        ;
        ; El gran salto del zombie jefe
        ;
salto_jefe:
        db  3 ,-4 
        db  3 ,-4 
        db  3 ,-3 
        db  2 ,-3 
        db  3 ,-2 
        db  2 ,-2 
        db  3 ,-1 
        db  1 ,-1 
        db  2 ,-1 
        db  1 ,-1 
        db  0 ,-1 
        db  1 ,-1 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  1 , 1 
        db  0 , 1 
        db  1 , 1 
        db  2 , 1 
        db  1 , 1 
        db  3 , 1 
        db  2 , 2 
        db  3 , 2 
        db  2 , 3 
        db  3 , 3 
        db  3 , 4 
        db  3 , 4 

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
        cp 97   ; ¨Transportador?
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

.3:     bit 0,(ix+d_objeto)     ; ¨Tiene la llave?
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
        ld e,a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        add a,d
        ld d,a
accede_casilla2:
        ld a,e
        rrca
        rrca
        rrca
        rrca
        and $0f
        ld e,a
        ld a,d
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

        ; El megamonstruo avisa que va a saltar
efecto_berrido:
        ; !!!
        ret

        ; Obtiene energ¡a o vida
efecto_vida:
        ; !!!
        ret

        ; M£sica general
musica_general:
        ; !!!
        ret

        ; M£sica de avance
musica_avance:
        ; !!!
        ret

        ; M£sica de esperando al monstruo :P
musica_esperando:
        ; !!!
        ret

        ; M£sica de batalla
musica_batalla:
        ; !!!
        ret

        ; M£sica de triunfo
musica_triunfo:
        ; !!!
        ret

        ; M£sica de fracaso
musica_fracaso:
        ; !!!
        ret

        ; M£sica final
musica_final:
        ; !!!
        ret

        ; M£sica silencio
musica_silencio:
        ; !!!
        ret

        ;
        ; La presentaci¢n
        ;
        ; Para la voz se usa el truco PCM con el PSG
        ;
presentacion:
.0:
        ; Prueba de retratos para ajustar pixel por pixel.
        ; ­Ugh! eso fue dif¡cil 10-ene-2011
        if 0
.888:       
        ld hl,$a000            
        ld de,$0000
        call carga_retrato
        ld hl,$a400            
        ld de,$0040
        call carga_retrato
        ld hl,$a800            
        ld de,$0800
        call carga_retrato
        ld hl,$ac00            
        ld de,$1000
        call carga_retrato
        ld hl,$b000            
        ld de,$1040
        call carga_retrato
        jr .888
        endif

        CALL PANTALLA_NEGRA
        ; Carga pantalla de t¡tulo
        ;
        ; Presentaci¢n compactada (son 12288 bytes si no se compacta)
        ;
        LD HL,GRAFICA_TITULO AND $FFFF
        LD DE,GRAFICA_TITULO>>16
        LD B,1
        CALL CARGAR_TOMA

        ;
        ; Antirebote
        ;
    IF 0
.7:     ld b,5
.2:     halt
        call boton_oprimido
        cp $ff
        jp z,.7
        djnz .2
    ENDIF
        ld hl,modo
        set 0,(hl)      ; Controla sprites y pantalla
        ld hl,sprites
        ld (hl),$80
        inc hl
        ld (hl),$c0
        inc hl
        ld (hl),$04     ; La pistola (color brillante)
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$80
        inc hl
        ld (hl),$c0
        inc hl
        ld (hl),$00     ; La pistola (color obscuro)
        inc hl
        ld (hl),$0e
        inc hl
        ld de,(ticks)
.1:     halt
        ld hl,(ticks)
        bit 3,l
        ld bc,$0e0f
        jp z,.3
        ld bc,$0101
.3:     ld a,b
        ld (sprites+7),a
        ld a,c
        ld (sprites+3),a
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        ret z
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,250       ; ¨Transcurridos 5 segundos?
        or a
        sbc hl,bc
        jp c,.1
        ; !!! Mover la pistola con flechas para seleccionar modo
        ; !!! Implementar modos
        call limpia_sprites
        LD HL,GRAFICA_ALERTA AND $FFFF
        LD DE,GRAFICA_ALERTA>>16
        LD B,2
        CALL CARGAR_TOMA
        ; !!! Mensaje parpadeante de alerta y sonido de chicharra de alerta
        ;     El truco es que el fondo es transparente
        ld de,(ticks)
.4:     halt
        ld a,(ticks)
        sub e
        and $0c
        ld bc,$0107
        jp z,.5
        cp $04
        ld bc,$0607
        jp z,.5
        cp $08
        ld bc,$0807
        jp z,.5
        ld bc,$0907
.5:     call WRTVDP
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,.0
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,150       ; ¨Transcurridos 3 segundos?
        or a
        sbc hl,bc
        jp c,.4
        ld bc,$0107
        call WRTVDP
        ld hl,pantalla
        ld bc,768
.6:     ld (hl),8
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,.6
        halt
        ;
        ; Todos los cuadros de personaje son de 64x64 pixeles, 1024 bytes,
        ; se desplazan utilizando truco directo tabla de caracteres.
        ;
        ld hl,$a000             ; Retrato de chica investigadora
        ld de,$08c0
        call carga_retrato
        call entrada_derecha
        ; !!! Mensaje hablado "Security failure"
        call retardo_cuadro
        ld hl,$a400             ; Retrato de jefe
        ld de,$0800
        call carga_retrato
        call entrada_izquierda
        ; !!! Mensaje hablado "Close down the doors"
        call retardo_cuadro
        ;
        ; Edificio compactado, solo verde m s sprites
        ;
        ; !!! Edificio alambre 3-D, puntos rojos se desplazan y convierten
        ;     puntos blancos en puntos verdes, puertas se rompen.
        ld hl,pantalla
        ld bc,768
.9:     ld (hl),8
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,.9
        halt
        ld hl,$a000             ; Retrato de chica investigadora
        ld de,$08c0
        call carga_retrato
        call entrada_derecha
        ; !!! Mensaje hablado "They're through the building!"
        call retardo_cuadro
        ld hl,$a400             ; Retrato de jefe
        ld de,$0800
        call carga_retrato
        call entrada_izquierda
        ; !!! Mensaje hablado "Call the special team... What's that?"
        call retardo_cuadro
        ld hl,pantalla
        ld bc,768
.12:    ld (hl),8
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,.12
        halt
        ; !!! Mensaje hablado "Oh my god!... gritos y luego est tica"
        call retardo_cuadro
        ld hl,pantalla
        ld bc,768
.13:    ld (hl),8
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,.13
        halt
        ld hl,$a800             ; Retrato de telefonista
        ld de,$0060
        call carga_retrato
        call entrada_arriba
        ; !!! Mensaje hablado "Emergency! Calling special team"
        call retardo_cuadro
        ld hl,$ac00             ; Retrato de Steve
        ld de,$08c0
        call carga_retrato
        call entrada_derecha
        ; !!! Mensaje hablado "Delta 1 ready, I'll enter building A"
        call retardo_cuadro
        ld hl,$b000             ; Retrato de Eve
        ld de,$0800
        call carga_retrato
        call entrada_izquierda
        ; !!! Mensaje hablado "Delta 2 ready, I'll enter building B"
        call retardo_cuadro
        ; !!! Vuelta a presentaci¢n
        ; !!! Modo de atracci¢n, nivel, algo de movimiento, disparos, sin
        ;     m£sica de fondo
        jp .0

        ;
        ; Detecta boton oprimido
        ; Devuelve A=$FF si bot¢n oprimido, de lo contrario $00
        ;
boton_oprimido:
        push bc
        push de
        push hl
        ld b,0
.1:     push bc
        ld a,b
        call GTTRIG
        pop bc
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,.2
        inc b
        ld a,b
        sub 5
        jp nz,.1
.2:     pop hl
        pop de
        pop bc
        ret

        ;
        ; Retardo por cuadro de presentaci¢n.
        ;
retardo_cuadro:
        ld de,(ticks)
.1:     halt
        pop bc
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push bc
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,150       ; ¨Transcurridos 3 segundos?
        or a
        sbc hl,bc
        jp c,.1
        ret

        ;
        ; Carga un retrato
        ;
carga_retrato:
        push hl
        ld a,3
        ld ($a000),a    ; Banco del ROM con los retratos
        ld hl,modo
        res 0,(hl)
        pop hl
        ; Carga bitmap
        push de
        ld b,8
.1:     push bc
        push de
        push hl
        ld bc,64
        call LDIRVM
        pop hl
        ld bc,64
        add hl,bc
        pop de
        inc d
        pop bc
        djnz .1
        pop de
        set 5,d
        ld b,8
.2:     push bc
        push de
        push hl
        ld bc,64
        call LDIRVM
        pop hl
        ld bc,64
        add hl,bc
        pop de
        inc d
        pop bc
        djnz .2
        ld hl,modo
        set 0,(hl)
        ret

        ;
        ; Entrada de retrato desde arriba
        ;
entrada_arriba:
        ld bc,$01ec
.1:     halt
        halt
        push bc
        ld hl,pantalla+12
        ld de,25
.2:     ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        ld a,c
        add a,25
        ld c,a
        add hl,de
        djnz .2
        pop bc
        pop de
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push de
        ld a,c
        sub 32
        ld c,a
        inc b
        ld a,b
        cp 9
        jp nz,.1
        ret

        ;
        ; Entrada de retrato desde izquierda
        ;
entrada_izquierda:
        ld bc,$0107
.1:     halt
        halt
        push bc
        ld hl,pantalla+$0100
        ld de,32
.2:     push bc
        push hl
        ld a,c
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        pop hl
        pop bc
        inc c
        inc hl
        djnz .2
        pop bc
        pop de
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push de
        inc b
        dec c
        ld a,b
        cp 9
        jp nz,.1
        ret

        ;
        ; Entrada de retrato desde derecha
        ;
entrada_derecha:
        ld b,$01
.1:     halt
        halt
        push bc
        ld hl,pantalla+$0120
        ld a,l
        sub b
        ld l,a
        ld de,32
        ld c,$18
.2:     push bc
        push hl
        ld a,c
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        pop hl
        pop bc
        inc c
        inc hl
        djnz .2
        pop bc
        pop de
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push de
        inc b
        ld a,b
        cp 9
        jp nz,.1
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

jug1_inicial:           ; El chico
        db $10,$10      ; Coordenada X,Y actual, cambiada al leer nivel
        db 0,7          ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw pantalla     ; Ap. a pantalla oculta
        db 0,0          ; Base X,Y visual
        dw 0            ; Ap. a nivel cargado
        dw monigotes    ; Lista de monigotes
        db 2            ; Dos vidas
        db 0            ; Espera antes de recibir m s da¤o.
        db $10,$10      ; Coordenadas X,Y donde apareci¢
        db 0,0,0        ; Puntos en BCD (alto a bajo)
        db 0            ; Objetos (bit 0 = Llave)
        dw 0            ; Monitor para transportador
        dw 0            ; Tiempo para que aparezca gran jefe
        dw mapa1        ; Mapa modificado

jug2_inicial:           ; La chica
        db $50,$70      ; Coordenada X,Y actual, cambiada al leer nivel
        db 64,9         ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw pantalla+392 ; Ap. a pantalla oculta
        db $40,$60      ; Base X,Y visual
        dw 0            ; Ap. a nivel cargado
        dw monigotes+MAX_MONIGOTES*16       ; Lista de monigotes
        db 2            ; Dos vidas
        db 0            ; Espera antes de recibir m s da¤o.
        db $50,$70      ; Coordenadas X,Y donde apareci¢
        db 0,0,0        ; Puntos en BCD (alto a bajo)
        db 0            ; Objetos (bit 0 = Llave)
        dw 0            ; Monitor para transportador
        dw 0            ; Tiempo para que aparezca gran jefe
        dw mapa2        ; Mapa modificado

        ;
        ; Los sprites bellamente dibujados :)
        ;
        include "sprites.asm"

        include "niveles.asm"

        include "graficas.asm"

        DS $9F00-$,255      ; Rellena a 32K
        DB "What are you looking for? :)",0

        DS $A000-$,255      ; Rellena a 32K

        ; Comienza retrato investigadora
        incbin "retrato1.dat"

        ; Comienza retrato jefe
        incbin "retrato2.dat"

        ; Comienza retrato telefonista
        incbin "retrato3.dat"

        ; Comienza retrato Delta 1
        incbin "retrato4.dat"

        ; Comienza retrato Delta 2
        incbin "retrato5.dat"

        DS $C000-$,255      ; Rellena a 32K

        ORG $C000
        FORG $C000
GRAFICA_TITULO:
        INCBIN "TITULO.DAT"
GRAFICA_ALERTA:
        INCBIN "ALERTA.DAT"

        FORG $20000
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
        RB 1    ; Tiempo de espera antes de recibir m s da¤o.
        RB 2    ; Base X y Y de donde empieza si pierde una vida.
        RB 3    ; Puntos
        RB 1    ; Objetos
        RB 2    ; Monitor para transportador
        RB 2    ; Tiempo para que aparezca gran jefe
        RB 2    ; Su mapa modificado de nivel

jug2:   ; Datos del jugador 2
        RB 34

monigotes:      ; Tabla de monigotes
        RB (MAX_MONIGOTES*2)*16

        ;
        ; bit 0 = Cient¡fico rescatado
        ; bit 1 = Vida usada
        ; bit 2 = Llave tomada
        ;
mapa1:  RB 101  ; Cosas modificadas en el mapa (jugador 1)
mapa2:  RB 101  ; Cosas modificadas en el mapa (jugador 2)

salva_puntos:   RB 2

        ;
        ; Variables usadas por el n£cleo
        ;
ticks:  RB 2
ciclo:  RB 1
L_OFFSET2: RB 2
L_PAGINA2: RB 1
L_OFFSET: RB 2
L_LINEA:  RB 2
L_PAGINA: RB 1

        ;
        ; Modo del vector de interrupci¢n.
        ; bit 0 = 1 = Controlar pantalla y sprites
        ;     1 = 1 = En pausa, quitar sonido.
        ;     2 = 1 = Redefinir sprites h‚roes (usado durante juego)
        ;
modo:   RB 1
estado: RB 1

        ORG $F0F0
PILA:   

