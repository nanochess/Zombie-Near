        ;
        ; Experimento de tiempo de VBLANK
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011
        ;
        ; Creaci¢n: 27-mar-2011. Basado en c¢digo de mi Zombie Near.
        ; 

        ORG $4000

        FNAME "VBLANK.ROM"

        ;
        ; Este archivo es para experimentar posibilidades de animaci¢n con
        ; el VBLANK.
        ;

        ;
        ; Tecnicas de portabilidad
        ; * El uso de byte $0006 para obtener puerta VDP (98)
        ; * El uso de byte $002B (bit 7 = 0 = 60 hz, 1= 50 hz)
        ;

        DB "AB"         ; Para que el MSX reconozca el cartucho
        DW INICIO

ENASLT: EQU $0024       ; Activa slot
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
        ; Esta es la forma correcta de hacerlo, ya que
        ; cada slot puede tener subslots
        ;
        call RSLREG     ; Lee slot primario
        rrca
        rrca
        and $03         ; Indica mapeado primario de $4000
        ld c,a
        ld b,0
        ld hl,$FCC1     ; EXPTBL
        add hl,bc
        ld a,(hl)
        and $80         ; Obtiene bandera de expandido
        or c
        ld c,a
        inc hl
        inc hl
        inc hl
        inc hl
        ld a,(hl)       ; SLTTBL
        and $0c         ; Obtiene mapeado secundario de $4000
        or c            ; C contiene bit 7 = Indica expandido
                        ;            bit 6 - 4 = No importa
                        ;            bit 3 - 2 = Mapeado secundario
                        ;            bit 1 - 0 = Mapeado primario
        ld h,$80        ; La direcci¢n $8000
        call ENASLT
        ; 
        ; Es incre¡ble pero algunos emuladores (p.ej. MSKISS) no hacen esto,
        ; tambi‚n requerido para MSX2+ y MSX Turbo-R en BlueMSX
        ;
        ld a,$01
        ld ($6000),a
        ld a,$02
        ld ($8000),a
        ld a,$03
        ld ($a000),a
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
        call vdp_modo_2
        ;
        ; Carga una mejor paleta para MSX2
        ;
        ld a,($002d)
        or a
        jp z,.0
        xor a
        out ($99),a
        ld a,$90
        out ($99),a
        ld hl,paleta
        ld bc,$209a
        otir
.0:
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
        ld hl,pantalla
.1:     ld (hl),$28
        inc hl
        ld a,h
        cp (pantalla+768)>>8
        jp nz,.1
        ld hl,mensaje1
        ld de,pantalla
        ld bc,13
        ldir
        ld hl,mensaje2
        ld de,pantalla+736
        ld bc,12
        ldir
        ld hl,mensaje3
        ld de,pantalla+72
        ld bc,16
        ldir
        ld hl,pantalla
        ld de,$3c00
        ld bc,768
        call LDIRVM
        ld hl,256
        ld (timing1),hl
        ld (timing2),hl
        ld hl,modo
        set 0,(hl)
    if 0
        ;
        ; Apertura
        ;
        ld a,($002b)
        and $80
        ld bc,$0228
        ld hl,$0228+$0614/2
        jp z,.7
        ld bc,$03c8
        ld hl,$03c8+$0614/2
.7:     ld de,8
.8:     ld (timing1),hl
        ld (timing2),de
        halt
        or a
        sbc hl,bc
        add hl,bc
        jp c,$
        push bc
        ld bc,-8
        add hl,bc
        ld bc,16
        ex de,hl
        add hl,bc
        ex de,hl
        pop bc
        jp .8

    endif

    if 1
        ;
        ; Exploraci¢n m s retroceso
        ;
        ld a,($002b)
        and $80
        ld hl,$0228     ; 60 hz
        jp z,.9
        ld hl,$03c8     ; 50 hz
.9:     ld de,$0100
        ld a,20
.10:    ld (timing1),hl
        ld (timing2),de
        halt
        ld bc,32
        add hl,bc
        dec a
        jr nz,.10
        ld bc,-32
        add hl,bc
        ld a,20
.11:    ld (timing1),hl
        ld (timing2),de
        ld bc,-16
        add hl,bc
        ex de.hl
        ld bc,16
;        add hl,bc
        ex de,hl
        halt
        dec a
        jr nz,.11
        halt
        jp $
    endif

    if 0

.2:     halt
        ld a,0
        call SNSMAT
        bit 1,a
        jp z,.3
        bit 2,a
        jp z,.4
        bit 3,a
        jp z,.5
        bit 4,a
        jp z,.6
        jp .2

.3:     ld hl,(timing1)
        dec hl
        ld (timing1),hl
        jp .2

.4:     ld hl,(timing1)
        inc hl
        ld (timing1),hl
        jp .2

.5:     ld hl,(timing2)
        dec hl
        ld (timing2),hl
        jp .2

.6:     ld hl,(timing2)
        inc hl
        ld (timing2),hl
        jp .2
    endif

mensaje1:
        db $10,$12,$09,$0d,$05,$12,$01,$00,$0c,$09,$0e,$05,$01

mensaje2:
        db $15,$0c,$14,$09,$0d,$01,$00,$0c,$09,$0e,$05,$01

mensaje3:
        db $30,$31,$32,$33,$34,$35,$36,$37
        db $38,$39,$3a,$3b,$3c,$3d,$3e,$3f

paleta:
        db $00,$00      ; 0 - Transparente
        db $00,$00      ; 1 - Negro
        db $22,$05      ; 2 - Verde medio
        db $33,$06      ; 3 - Verde claro
        db $06,$00      ; 4 - Azul profundo
        db $27,$03      ; 5 - Azul claro
        db $51,$01      ; 6 - Cafe
        db $07,$07      ; 7 - Cielo
        db $63,$02      ; 8 - Rosado obscuro (para caras)
        db $74,$03      ; 9 - Rosado claro (para caras)
        db $60,$05      ; 10 - Amarillo
        db $64,$06      ; 11 - Amarillo claro
        db $11,$04      ; 12 - Verde obscuro
        db $55,$00      ; 13 - Morado
        db $55,$05      ; 14 - Gris
        db $77,$07      ; 15 - Blanco

        ;
        ; Vector de interrupci¢n, llamado 50 o 60 veces por segundo
        ; Todos los registros son salvados por el BIOS MSX
        ;
        ; A 60 ciclos por segundo solo hay tiempo para actualizar
        ; 128 + 384 bytes.
        ;
        ; Por eso:
        ; o Las posiciones de sprites se actualizan siempre y en cada cuadro.
        ;   128 bytes.
        ; o Para retratos que se desplazan se actualizan £nicamente
        ;   los 256 bytes necesarios.
        ; o Para el juego se sigue esta secuencia.
        ;   cuadro 0. Actualiza sprites (128). Define sprites (320)
        ;   cuadro 1. Actualiza sprites (128). Actualiza pantalla sup. (384)
        ;   cuadro 2. Actualiza sprites (128). Define sprites (320)
        ;   cuadro 3. Actualiza sprites (128). Actualiza pantalla inf. (384)
        ;
vector_int:
        ;
        ; Limpia la interrupci¢n
        ;
        call RDVDP
        ld a,(modo)
        and 1
        ret z
        di
        ld a,$a2
        out ($99),a
        ld a,$81
        out ($99),a
        ld bc,(timing1)
.0:     dec bc
        ld a,b
        or c
        jp nz,.0
        ld a,$e2
        out ($99),a
        ld a,$81
        out ($99),a
        ld bc,(timing2)
.2:     dec bc
        ld a,b
        or c
        jp nz,.2
        ld a,$a2
        out ($99),a
        ld a,$81
        out ($99),a
        ei
        ld a,($002B)
        and $80         ; ¨60 hz?
        jp nz,.1        ; No, salta.
        ret

        ;
        ; Aqu¡ cree que son 50 ciclos por segundo
        ;
.1:     
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
        LD HL,$3F80
        LD BC,$80
        LD A,$D1
        CALL FILVRM
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
        ; Las fantabulosas letras
        ; Incluye algunos gr ficos fantastirigillos
        ;
letras:
        db $00,$00,$00,$00,$00,$00,$00,$00      ; $00
        db $38,$6c,$c6,$c6,$fe,$c6,$c6,$00      ; $01
        db $fc,$c6,$c6,$fc,$c6,$c6,$fc,$00      ; $02
        db $7c,$c6,$c0,$c0,$c0,$c6,$7c,$00      ; $03
        db $fc,$c6,$c6,$c6,$c6,$c6,$fc,$00      ; $04
        db $FE,$C0,$C0,$FC,$C0,$C0,$FE,$00      ; $05
        db $FE,$C0,$C0,$FC,$C0,$C0,$C0,$00      ; $06
        db $7C,$C6,$C0,$CE,$C6,$C6,$7C,$00      ; $07
        db $c6,$c6,$c6,$fe,$c6,$c6,$c6,$00      ; $08
        db $78,$30,$30,$30,$30,$30,$78,$00      ; $09
        db $06,$06,$06,$06,$c6,$c6,$7c,$00      ; $0A
        db $c6,$c6,$cc,$f8,$cc,$c6,$c6,$00      ; $0B
        db $C0,$C0,$C0,$C0,$C0,$C0,$FE,$00      ; $0C
        db $c6,$ee,$fe,$d6,$d6,$c6,$c6,$00      ; $0D
        db $C6,$C6,$E6,$DE,$CE,$C6,$C6,$00      ; $0E
        db $7C,$C6,$C6,$C6,$C6,$C6,$7C,$00      ; $0F
        db $FC,$C6,$C6,$FC,$C0,$C0,$C0,$00      ; $10
        db $7c,$c6,$c6,$c6,$c6,$ec,$76,$03      ; $11
        db $FC,$C6,$C6,$FC,$CC,$C6,$C6,$00      ; $12
        db $7c,$c6,$c0,$7c,$06,$c6,$7c,$00      ; $13
        db $fc,$30,$30,$30,$30,$30,$30,$00      ; $14
        db $C6,$C6,$C6,$C6,$C6,$C6,$7C,$00      ; $15
        db $c6,$c6,$c6,$c6,$6c,$6c,$38,$00      ; $16
        db $c6,$c6,$c6,$d6,$fe,$fe,$6c,$00      ; $17
        db $c6,$c6,$6c,$38,$6c,$c6,$c6,$00      ; $18
        db $C6,$C6,$6C,$38,$30,$30,$30,$00      ; $19
        db $fe,$0c,$18,$30,$60,$c0,$fe,$00      ; $1A
        db $ff,$c0,$c0,$c0,$c0,$c0,$c0,$ff      ; $1B
        db $ff,$c0,$c0,$c0,$c0,$c0,$c0,$ff      ; $1C
        db $ff,$00,$00,$00,$00,$00,$00,$ff      ; $1D
        db $ff,$00,$00,$00,$00,$00,$00,$ff      ; $1E
        db $c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0      ; $1F
        db $7C,$C6,$E6,$DE,$CE,$C6,$7C,$00      ; $20
        db $30,$70,$30,$30,$30,$30,$78,$00      ; $21
        db $7C,$C6,$06,$3E,$60,$C0,$FE,$00      ; $22
        db $7C,$C6,$06,$7C,$06,$C6,$7C,$00      ; $23
        db $1E,$36,$66,$FE,$06,$06,$06,$00      ; $24
        db $FE,$C0,$C0,$FC,$06,$06,$FC,$00      ; $25
        db $3E,$60,$C0,$FC,$C6,$C6,$7C,$00      ; $26
        db $FE,$06,$0C,$18,$30,$30,$30,$00      ; $27
        db $7C,$C6,$C6,$7C,$C6,$C6,$7C,$00      ; $28
        db $7C,$C6,$C6,$7E,$06,$06,$FC,$00      ; $29
        db $00,$6C,$fe,$fe,$7c,$38,$10,$00      ; $2A
        db $30,$70,$30,$30,$30,$30,$78,$00      ; $2B
        db $7C,$C6,$06,$3E,$60,$C0,$FE,$00      ; $2C
        db $3c,$30,$3c,$30,$78,$CC,$CC,$78      ; $2D Llave
        db $18,$3c,$3c,$3c,$18,$00,$18,$18      ; $2E !
        db $7C,$C6,$0C,$18,$18,$00,$18,$18      ; $2F ?
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff      

        ;
        ; El color de las fantabulosas letras
        ; Para cuando se juega, en la historia se usan otros colores.
        ;
color_letras:
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $00
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $01
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $02
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $03
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $04
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $05
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $06
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $07
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $08
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $09
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0A
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0B
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0C
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0D
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0E
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0F
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $10
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $11
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $12
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $13
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $14
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $15
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $16
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $17
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $18
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $19
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $1A
        db $f8,$f8,$f9,$f9,$f8,$f8,$f6,$f8      ; $1b
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1      ; $1c
        db $f8,$f8,$f9,$f9,$f8,$f8,$f6,$f8      ; $1d
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1      ; $1e
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1      ; $1f
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $20
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $21
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $22
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $23
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $24
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $25
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $26
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $27
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $28
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $29
        db $11,$91,$81,$81,$81,$81,$61,$11      ; $2A
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2B
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2C
        db $b1,$b1,$b1,$b1,$a1,$a1,$a1,$a1      ; $2D
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2E
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2F
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $11,$11,$11,$11,$11,$11,$11,$11
        db $22,$22,$22,$22,$22,$22,$22,$22
        db $33,$33,$33,$33,$33,$33,$33,$33
        db $44,$44,$44,$44,$44,$44,$44,$44
        db $55,$55,$55,$55,$55,$55,$55,$55
        db $66,$66,$66,$66,$66,$66,$66,$66
        db $77,$77,$77,$77,$77,$77,$77,$77
        db $88,$88,$88,$88,$88,$88,$88,$88
        db $99,$99,$99,$99,$99,$99,$99,$99
        db $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
        db $bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb
        db $cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc
        db $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
        db $ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee
        db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

        DS $C000-$,255      ; Rellena a 32K

        ORG $E000
pantalla:
        RB 768
sprites:
        RB 132

        ;
        ; Variables usadas por el n£cleo
        ;
ticks:  RB 2
ciclo:  RB 1

        ;
        ; Modo del vector de interrupci¢n.
        ; bit 0 = 1 = Controlar pantalla y sprites
        ;     2 = 1 = Redefinir sprites h‚roes (usado durante juego)
        ;     7 = 1 = Dentro de interrupci¢n.
        ;
modo:   RB 1

timing1:        RB 2
timing2:        RB 2


        ORG $F0F0
PILA:   

