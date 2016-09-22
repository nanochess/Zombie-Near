        ;
        ; Experimento de tiempo de retrazo vertical
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011
        ;
        ; Creaci¢n: 16-ene-2011. Basado en c¢digo de mi Zombie Near.
        ; 

        ORG $4000

        FNAME "RETRAZO.ROM"

        ;
        ; Este archivo es para experimentar las posibilidades de definir
        ; hasta 10 sprites al mismo tiempo (320 bytes), con el fin de poner
        ; los d¢s h‚roes (16x16 cada uno) y dos jefes (32x32 cada uno) al
        ; mismo tiempo, y como el jefe es definido en tiempo real es posible
        ; mostrar m s de un jefe al mismo tiempo, cosa que no se pod¡a hacer
        ; con el c¢digo anterior.
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
.1:     ld (hl),$00
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
        ld hl,sprites
        ld (hl),$60
        inc hl
        ld (hl),$20
        inc hl
        ld (hl),$00
        inc hl
        ld (hl),$07
        inc hl
        ld (hl),$60
        inc hl
        ld (hl),$40
        inc hl
        ld (hl),$04
        inc hl
        ld (hl),$09
        inc hl
        ld (hl),$50
        inc hl
        ld (hl),$70
        inc hl
        ld (hl),$08
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$50
        inc hl
        ld (hl),$80
        inc hl
        ld (hl),$0c
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$60
        inc hl
        ld (hl),$70
        inc hl
        ld (hl),$10
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$60
        inc hl
        ld (hl),$80
        inc hl
        ld (hl),$14
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$40
        inc hl
        ld (hl),$a0
        inc hl
        ld (hl),$18
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$40
        inc hl
        ld (hl),$b0
        inc hl
        ld (hl),$1c
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$50
        inc hl
        ld (hl),$a0
        inc hl
        ld (hl),$20
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$50
        inc hl
        ld (hl),$b0
        inc hl
        ld (hl),$24
        inc hl
        ld (hl),$0f
        inc hl
        ld hl,modo
        set 0,(hl)
.2:     halt
        ld a,(ticks)
        and $0c
        ld b,a
        ld a,b
        or $00
        ld (sprites+128),a
        ld a,b
        or $10
        ld (sprites+129),a
        ld a,b
        rlca
        rlca
        add a,$20
        ld (sprites+130),a
        ld a,b
        rlca
        rlca
        add a,$60
        ld (sprites+131),a
        jp .2

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
        ld hl,modo
        bit 7,(hl)
        ret nz
        set 7,(hl)
        ;
        ; Solo en el modo de juego se mete con el VDP
        ;
.0:     ld hl,modo
        bit 0,(hl)
        jp z,.2
        ;
        ; Trucazo, actualiza la pantalla en un ciclo y los
        ; sprites en otro ciclo.
        ;
        ld a,(ticks)
        and 1
        jp z,.3
;        ld bc,$0907
;        call WRTVDP
        ;
        ; Obtiene los sprites que est n usando los h‚roes...
        ;
        ld bc,sprites_heroes
        ld a,(sprites+128)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ex de,hl
        ld a,(sprites+129)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ld b,h
        ld c,l
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
;        ld bc,$0a07
;        call WRTVDP
        ;
        ; Obtiene los sprites que est n usando los monstruos...
        ;
        ld bc,sprites_heroes
        ld a,(sprites+130)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ex de,hl
        ld a,(sprites+131)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ld b,h
        ld c,l
        ;
        ; ...para definirlos en el momento.
        ;
        ld hl,$1840
        call SETWRT
        ld h,b
        ld l,c
        ex de,hl
        ld c,$98
        ld b,128
        outi
        jp nz,$-2
        ex de,hl
        ld b,128
        outi
        jp nz,$-2
;        ld bc,$0207
;        call WRTVDP
        ;
        ; Actualiza los sprites
        ;
        ld hl,$3f80
        call SETWRT
        ld hl,sprites
        ld c,$98
        ld b,112
        outi
        jp nz,$-2
        ld bc,$0407
        call WRTVDP
        jp .2

        ;
        ; Actualiza la pantalla
        ;
.3:
        ld bc,$0207
        call WRTVDP
        ;
        ; Actualiza los sprites
        ;
        ld hl,$3f80
        call SETWRT
        ld hl,sprites
        ld c,$98
        ld b,112
        outi
        jp nz,$-2
        ld bc,$0d07
        call WRTVDP
        ;
        ; !!! Modificar animaci¢n retratos para actualizar solo la
        ;     porci¢n necesaria (256 bytes) a 60 cuadros por segundo.
        ;
        ld a,(ticks)
        and 2
        ld hl,$3c00
        ld de,pantalla
        jp z,.4
        ld hl,$3d80
        ld de,pantalla+384
.4:     call SETWRT
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
        ld bc,$0407
        call WRTVDP
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
.1:     
        ;
        ; Incrementa ticks transcurridos
        ;
        ld hl,(ticks)
        inc hl
        ld (ticks),hl
        ret

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

sprites_heroes:
        ; 00 - Jugador 1 der. (1)
        db $00,$01,$03,$03,$05,$06,$0F,$0F,$0F,$0F,$00,$0F,$0E,$1C,$38,$1C
        db $00,$E0,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$80,$C0,$C0,$C0,$E0,$70,$7C
        ; 04 - Jugador 1 der. (2)
        db $01,$03,$03,$05,$06,$0F,$0F,$0F,$0F,$03,$0C,$0F,$0F,$0E,$0F,$01
        db $E0,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$C0,$80,$C0,$C0,$80,$80,$40,$F0
        ; 08 - Jugador 1 der. (3)
        db $01,$03,$03,$05,$06,$0F,$0F,$0F,$0F,$03,$0C,$0F,$07,$07,$08,$0F
        db $E0,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$C0,$80,$C0,$80,$00,$C0,$00,$80
        ; 0C - Jugador 1 der. (4)
        db $01,$03,$03,$05,$06,$0F,$0F,$0F,$0F,$03,$0C,$0F,$0F,$0D,$19,$1E
        db $E0,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$C0,$80,$C0,$C0,$80,$80,$F0,$00

        ; 40 - Jugador 2 der. (1)
        db $00,$07,$0A,$0A,$0D,$06,$0F,$0F,$07,$07,$00,$0F,$0E,$1C,$38,$1C
        db $00,$60,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$80,$C0,$C0,$C0,$E0,$70,$7C
        ; 44 - Jugador 2 der. (2)
        db $07,$0A,$0A,$0D,$06,$0F,$0F,$07,$07,$03,$0C,$0F,$07,$0E,$0F,$01
        db $60,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$C0,$80,$C0,$C0,$80,$80,$40,$F0
        ; 48 - Jugador 2 der. (3)
        db $07,$0A,$0A,$0D,$06,$0F,$0F,$07,$07,$03,$0C,$0F,$07,$07,$08,$0F
        db $60,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$C0,$80,$C0,$80,$00,$C0,$00,$80
        ; 4C - Jugador 2 der. (4)
        db $07,$0A,$0A,$0D,$06,$0F,$0F,$07,$07,$03,$0C,$0F,$07,$0D,$19,$1E
        db $60,$A0,$F0,$E0,$0F,$F7,$CC,$F0,$C0,$80,$C0,$C0,$80,$80,$F0,$00

        ; 80 - Zombie jefe izq. cuadro 1 (1)
        db $00,$00,$0F,$3F,$61,$5E,$53,$5B,$59,$6E,$13,$3C,$38,$1F,$15,$15
        db $00,$00,$FF,$FF,$FF,$7F,$41,$3D,$65,$6C,$4D,$BB,$47,$FE,$59,$5B
        ; 84 - Zombie jefe izq. cuadro 1 (2)
        db $00,$B0,$B6,$DE,$DB,$DB,$9B,$B6,$76,$C2,$BC,$7E,$7D,$3B,$3A,$75
        db $00,$00,$00,$80,$40,$40,$50,$D8,$C8,$8C,$86,$86,$0E,$0E,$FE,$FE
        ; 88 - Zombie jefe izq. cuadro 1 (3)
        db $00,$01,$15,$0F,$03,$00,$00,$00,$04,$06,$19,$1B,$07,$01,$00,$00
        db $18,$51,$E3,$EF,$C7,$30,$6D,$CD,$9B,$13,$07,$CF,$B7,$7B,$3C,$0C
        ; 8C - Zombie jefe izq. cuadro 1 (4)
        db $BB,$D7,$CF,$DF,$BF,$7E,$FE,$1D,$0B,$07,$01,$02,$0F,$33,$0F,$3C
        db $BE,$BE,$BC,$BC,$78,$E0,$00,$E0,$F0,$80,$78,$F4,$6C,$BC,$C0,$00
        ; 90 - Zombie jefe izq. cuadro 2 (1)
        db $0F,$3F,$61,$40,$5E,$53,$5B,$59,$6E,$13,$3C,$38,$1F,$15,$15,$00
        db $FE,$FF,$FF,$FF,$47,$03,$3D,$65,$6D,$4D,$BB,$47,$FE,$59,$5B,$18
        ; 94 - Zombie jefe izq. cuadro 2 (2)
        db $00,$B0,$B6,$DE,$DB,$DB,$9B,$B6,$76,$C2,$BC,$7E,$7D,$3B,$3A,$3A
        db $00,$00,$00,$80,$40,$40,$50,$D8,$C8,$8C,$86,$86,$0E,$0E,$FE,$FE
        ; 98 - Zombie jefe izq. cuadro 2 (3)
        db $00,$01,$15,$0F,$03,$00,$00,$00,$00,$00,$00,$00,$03,$03,$00,$03
        db $18,$50,$E0,$E0,$C1,$00,$03,$03,$02,$02,$00,$00,$83,$DB,$5D,$DE
        ; 9C - Zombie jefe izq. cuadro 2 (4)
        db $76,$0D,$F3,$EF,$EF,$1E,$6F,$6C,$41,$46,$81,$7A,$9D,$FD,$00,$00
        db $BE,$BE,$BC,$BC,$78,$E0,$00,$C0,$E0,$00,$70,$D0,$B0,$E0,$00,$00
        ; A0 - Zombie jefe izq. cuadro 3 (1)
        db $0F,$3F,$61,$5E,$53,$5B,$59,$4E,$60,$13,$3C,$38,$1F,$15,$15,$00
        db $FE,$FF,$FF,$FF,$47,$3B,$65,$6D,$4D,$39,$83,$47,$FE,$59,$5B,$18
        ; A4 - Zombie jefe izq. cuadro 3 (2)
        db $00,$B0,$B6,$DE,$DB,$DB,$9B,$B6,$76,$C2,$BC,$7E,$3D,$1E,$1E,$1E
        db $00,$00,$00,$80,$40,$40,$50,$D8,$C8,$8C,$86,$86,$0E,$8E,$BE,$BE
        ; A8 - Zombie jefe izq. cuadro 3 (3)
        db $00,$15,$1F,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $18,$51,$E2,$EE,$05,$30,$6C,$CC,$98,$10,$18,$1E,$02,$1E,$00,$07
        ; AC - Zombie jefe izq. cuadro 3 (4)
        db $1E,$0F,$C0,$EF,$EF,$E0,$0D,$0D,$09,$09,$16,$DA,$DA,$EE,$01,$BB
        db $BE,$BE,$3C,$3C,$78,$60,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00
        ; B0 - Zombie jefe izq. cuadro 4 (1)
        db $0F,$3F,$61,$40,$5E,$53,$5B,$59,$6E,$13,$3C,$38,$1F,$15,$15,$00
        db $FE,$FF,$FF,$FF,$47,$03,$3D,$65,$6D,$4D,$BB,$47,$FE,$59,$5B,$18
        ; B4 - Zombie jefe izq. cuadro 4 (2)
        db $00,$B0,$B6,$DE,$DB,$DB,$9B,$B6,$76,$C2,$BC,$7E,$7D,$3B,$3A,$3A
        db $00,$00,$00,$80,$40,$40,$50,$D8,$C8,$8C,$86,$86,$0E,$0E,$FE,$FE
        ; B8 - Zombie jefe izq. cuadro 4 (3)
        db $00,$01,$15,$0F,$03,$00,$00,$00,$00,$00,$03,$03,$00,$03,$00,$00
        db $18,$50,$E0,$E0,$C1,$00,$03,$03,$02,$02,$81,$DB,$5D,$DE,$00,$00
        ; BC - Zombie jefe izq. cuadro 4 (4)
        db $76,$0D,$F3,$EF,$EF,$1E,$6F,$6F,$43,$40,$81,$00,$81,$7A,$9D,$FD
        db $BE,$BE,$BC,$BC,$78,$E0,$C0,$C0,$20,$C0,$E0,$00,$70,$D0,$B0,$E0

        ; C0 - Zombie jefe der. cuadro 1 (1)
        db $00,$00,$00,$01,$02,$02,$0A,$1B,$13,$31,$61,$61,$70,$70,$7F,$7F
        db $00,$0D,$6D,$7B,$DB,$DB,$D9,$6D,$6E,$43,$3D,$7E,$BE,$DC,$5C,$AE
        ; C4 - Zombie jefe der. cuadro 1 (2)
        db $00,$00,$FF,$FF,$FF,$FE,$82,$BC,$A6,$36,$B2,$DD,$E2,$7F,$9A,$DA
        db $00,$00,$F0,$FC,$86,$7A,$CA,$DA,$9A,$76,$C8,$3C,$1C,$F8,$A8,$A8
        ; C8 - Zombie jefe der. cuadro 1 (3)
        db $7D,$7D,$3D,$3D,$1E,$07,$00,$07,$0F,$01,$1E,$2F,$36,$3D,$03,$00
        db $DD,$EB,$F3,$FB,$FD,$7E,$7F,$B8,$D0,$E0,$80,$40,$F0,$CC,$F0,$3C
        ; CC - Zombie jefe der. cuadro 1 (4)
        db $18,$8A,$C7,$F7,$E3,$0C,$B6,$B3,$D9,$C8,$E0,$F3,$ED,$DE,$3C,$30
        db $00,$80,$A8,$F0,$C0,$00,$00,$00,$20,$60,$98,$D8,$E0,$80,$00,$00
        ; D0 - Zombie jefe der. cuadro 2 (1)
        db $00,$00,$00,$01,$02,$02,$0A,$1B,$13,$31,$61,$61,$70,$70,$7F,$7F
        db $00,$0D,$6D,$7B,$DB,$DB,$D9,$6D,$6E,$43,$3D,$7E,$BE,$DC,$5C,$5C
        ; D4 - Zombie jefe der. cuadro 2 (2)
        db $7F,$FF,$FF,$FF,$E2,$C0,$BC,$A6,$B6,$B2,$DD,$E2,$7F,$9A,$DA,$18
        db $F0,$FC,$86,$02,$7A,$CA,$DA,$9A,$76,$C8,$3C,$1C,$F8,$A8,$A8,$00
        ; D8 - Zombie jefe der. cuadro 2 (3)
        db $7D,$7D,$3D,$3D,$1E,$07,$00,$03,$07,$00,$0E,$0B,$0D,$07,$00,$00
        db $6E,$B0,$CF,$F7,$F7,$78,$F6,$36,$82,$62,$81,$5E,$B9,$BF,$00,$00
        ; DC - Zombie jefe der. cuadro 2 (4)
        db $18,$0A,$07,$07,$83,$00,$C0,$C0,$40,$40,$00,$00,$C1,$DB,$BA,$7B
        db $00,$80,$A8,$F0,$C0,$00,$00,$00,$00,$00,$00,$00,$C0,$C0,$00,$C0
        ; E0 - Zombie jefe der. cuadro 3 (1)
        db $00,$00,$00,$01,$02,$02,$0A,$1B,$13,$31,$61,$61,$70,$71,$7D,$7D
        db $00,$0D,$6D,$7B,$DB,$DB,$D9,$6D,$6E,$43,$3D,$7E,$BC,$78,$78,$78
        ; E4 - Zombie jefe der. cuadro 3 (2)
        db $7F,$FF,$FF,$FF,$E2,$DC,$A6,$B6,$B2,$9C,$C1,$E2,$7F,$9A,$DA,$18
        db $F0,$FC,$86,$7A,$CA,$DA,$9A,$72,$06,$C8,$3C,$1C,$F8,$A8,$A8,$00
        ; E8 - Zombie jefe der. cuadro 3 (3)
        db $7D,$7D,$3C,$3C,$1E,$06,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00
        db $78,$F0,$03,$F7,$F7,$07,$B0,$B0,$90,$90,$68,$5B,$5B,$77,$80,$DD
        ; EC - Zombie jefe der. cuadro 3 (4)
        db $18,$8A,$47,$77,$A0,$0C,$36,$33,$19,$08,$18,$78,$40,$78,$00,$E0
        db $00,$A8,$F8,$C0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        ; F0 - Zombie jefe der. cuadro 4 (1)
        db $00,$00,$00,$01,$02,$02,$0A,$1B,$13,$31,$61,$61,$70,$70,$7F,$7F
        db $00,$0D,$6D,$7B,$DB,$DB,$D9,$6D,$6E,$43,$3D,$7E,$BE,$DC,$5C,$5C
        ; F4 - Zombie jefe der. cuadro 4 (2)
        db $7F,$FF,$FF,$FF,$E2,$C0,$BC,$A6,$B6,$B2,$DD,$E2,$7F,$9A,$DA,$18
        db $F0,$FC,$86,$02,$7A,$CA,$DA,$9A,$76,$C8,$3C,$1C,$F8,$A8,$A8,$00
        ; F8 - Zombie jefe der. cuadro 4 (3)
        db $7D,$7D,$3D,$3D,$1E,$07,$03,$03,$04,$03,$07,$00,$0E,$0B,$0D,$07
        db $6E,$B0,$CF,$F7,$F7,$78,$F6,$F6,$C2,$02,$81,$00,$81,$5E,$B9,$BF
        ; FC - Zombie jefe der. cuadro 4 (4)
        db $18,$0A,$07,$07,$83,$00,$C0,$C0,$40,$40,$81,$DB,$BA,$7B,$00,$00
        db $00,$80,$A8,$F0,$C0,$00,$00,$00,$00,$00,$C0,$C0,$00,$C0,$00,$00

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


        ORG $F0F0
PILA:   

