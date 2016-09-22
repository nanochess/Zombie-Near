        ;
        ; Zombie Near para Commodore 64
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 29-jul-2011. De verdad debo estar loco :P
        ; Revisi¢n: 03-ago-2011. Comienza a funcionar reproductor b sico de
        ;                        m£sica.
        ;

        ; P g. 173 = Referencia 6502.
        ; P g. 232 = Referencia SID.

        *=$0801
        !cpu 6502
        !to "zombnear.prg",cbm

BASIC   ;SYS 2064
        !byte $0c,$08,$06,$00,$9e,$20,$32,$30
        !byte $36,$34,$00,$00,$00,$00,$00

        sei     ; Desactiva las interrupciones.
        lda #<vector_irq        ; < Indica byte bajo
        ldx #>vector_irq        ; > Indica byte alto
        sta $314                ; Gancho Kernal C64 para atrapar IRQ
        stx $315
        lda #$1b        ; !!!
        ldx #$00        ; !!! 
        ldy #$7f        ; !!!
        sta $d011
        stx $d012
        sty $dc0d
        lda #$01
        sta $d01a
        sta $d019       ; Reconoce IRQ raster pendiente
        ;
        ; Limpia las variables de p gina cero que se van a usar
        ;
        lda #$00
        ldx #$10
        tay
.0:     sta $02,y
        iny
        dex
        bne .0
        cli
        jsr inicia_sonido
        lda #<melodia_principal
        ldx #>melodia_principal
        jsr pone_melodia
lazo:   inc $0401          ; Para ver que ocurre algo en la pantalla
.1:     lda #$10           
        bit $dc00          ; Espera a que se suelte el bot¢n
        beq .1
.2:     lda #$10           
        bit $dc00          ; Espera a que se oprima el bot¢n.
        bne .2
        lda #<melodia_2
        ldx #>melodia_2
        jsr pone_melodia
.3:     lda #$10           
        bit $dc00          
        beq .3
.4:     lda #$10           
        bit $dc00          
        bne .4
        lda #<melodia_amor
        ldx #>melodia_amor
        jsr pone_melodia
.5:     lda #$10           
        bit $dc00          
        beq .5
.6:     lda #$10           
        bit $dc00          
        bne .6
        lda #<melodia_principal
        ldx #>melodia_principal
        jsr pone_melodia
        jmp lazo

        !zone vector_irq
vector_irq:
        lda #$01
        sta $d019       ; Reconoce IRQ raster
        inc $0400
        jsr genera_sonido
        ;
        ; Copia variables en pantalla para ver que ocurre algo
        ;
        lda #$00
        ldx #$10
        tay
.0:     lda $02,y
        sta $0402,y
        iny
        dex
        bne .0
        jmp $ea31

        ef_inicio = $02         ; Dos bytes, inicio melod¡a.
        ef_ap     = $04         ; Dos bytes, ap. melod¡a.
        ef_t      = $06         ; Un byte, tiempo melod¡a.
        ef_ta     = $07         ; Un byte, tiempo actual en nota.
        ef_cn     = $08         ; Un byte, indica si debe cargar otra nota.
        ef_ac1    = $09
        ef_ac2    = $0a
        ef_ac3    = $0b
        ef_ritmo  = $0c
        ef_env    = $0d         ; Indica iniciar envolvente
        ef_ruido  = $0e
        ef_tamb   = $0f
        ef_n      = $10
        ef_b      = $11

        ;
        ; Inicia el chip de sonido
        ;
inicia_sonido:
        lda #$00
        sta $d402
        sta $d409
        sta $d410
        lda #$02
        sta $d403
        lda #$04
        sta $d40a
        lda #$08
        sta $d411
        lda #$00
        sta $d415
        sta $d416
        sta $d417
        lda #$24        ; Attack - Decay
        sta $d405       
        lda #$a6        ; Sustain - Release
        sta $d406
        lda #$11
        sta $d40c
        lda #$f8
        sta $d40d
        lda #$11
        sta $d413
        lda #$f8
        sta $d414
        lda #$0c
        sta $d418
        rts

        ;
        ; Pone una nueva melod¡a.
        ; A = Byte bajo ap. a melod¡a.
        ; X = Byte alto ap. a melod¡a.
        ;
pone_melodia:
        sei
        sta ef_inicio
        stx ef_inicio+1
        ldy #0
        lda (ef_inicio),y
        ror
        and #$7f
        sta ef_t
        iny
        lda (ef_inicio),y
        sta ef_ac1
        iny
        lda (ef_inicio),y
        sta ef_ac2
        iny
        lda (ef_inicio),y
        sta ef_ac3
        lda #4
        clc
        adc ef_inicio
        sta ef_inicio
        sta ef_ap
        lda #0
        adc ef_inicio+1
        sta ef_inicio+1
        sta ef_ap+1
        ldx #0
        stx ef_ritmo
        dex             ; x = -1
        stx ef_cn
        cli
        rts

        !zone genera_musica

        ;
        ; M£sica doble voz
        ;
genera_musica:
        ldx ef_cn
        inx
        bne .1
        ldy #0
        lda (ef_ap),y
        cmp #$fe        ; ¨Fin de melod¡a?
        bne .3
        rts             ; Se queda detenido

.3:     cmp #$fd        ; ¨Repetici¢n?
        bne .6
        lda #1
        eor ef_ac1      ; Posible intercambio de instrumento
        sta ef_ac1
        lda ef_inicio
        sta ef_ap
        lda ef_inicio+1
        sta ef_ap+1
        lda (ef_ap),y
.6:     inc ef_ap
        bne .7
        inc ef_ap+1
.7:     cmp #$3f        ; ¨Sostenido?
        beq .4
        sta ef_n
        lda #2          ; Indica que inicia instrumento
        ora ef_env
        sta ef_env
.4:     lda #$40        ; ¨Tambor 2?
        and (ef_ap),y
        beq .12         ; No, salta.
        lda #$08
        sta ef_ruido
        lda #$01
        sta ef_tamb
.12:    lda #$80        ; ¨Tambor 1?
        and (ef_ap),y
        beq .13
        lda #$05        ; Frecuencia
        sta ef_ruido
        lda #$03        ; Duraci¢n.
        sta ef_tamb
.13:    lda (ef_ap),y   ; Lee segunda voz
        inc ef_ap
        bne .8
        inc ef_ap+1
.8:     and #$3f
        cmp #$3f        ; ¨Sostenido?
        beq .5
        sec
        sbc #12
        sta ef_b
        lda #1          ; Indica que inicia instrumento
        ora ef_env
        sta ef_env
.5:     lda #0
        sta ef_cn
        sta ef_ta
.1:     
        inc ef_ta
        lda ef_t
        clc
        rol
        cmp ef_ta
        bne .9
        lda ef_b
        beq .9
        sec
        sbc #12
        sta ef_b
.9:     lda ef_t
        clc
        rol
        rol
        cmp ef_ta       ; ¨Acab¢ la nota?
        bne .2          ; No, retorna
        ldx #0
        stx ef_ta
        dex             ; Prepara para traer otra nota
        stx ef_cn
        lda ef_b
        beq .2
        clc
        adc #12
        sta ef_b
.2:     rts

        ;
        ; Nota a frecuencia
        ;
nota_a_frec:
        tay
        lda tabla_notas_1,y
        ldx tabla_notas_2,y
        rts

        !zone genera_sonido

        ;
        ; Genera el sonido
        ;
genera_sonido:
        lda ef_n
        beq .2
        jsr nota_a_frec
        stx $d401
        sta $d400
        lda ef_env
        and #$02
        beq .1
        lda #$21
        bne .2

.1:     lda #$20
.2:     sta $d404
        lda ef_b
        beq .4
        jsr nota_a_frec
        stx $d408
        sta $d407
        lda ef_env
        and #$01
        beq .3
        lda #$41
        bne .4

.3:     lda #$40
.4:     sta $d40b
        lda #0
        sta ef_env
        lda ef_tamb
        beq .5
        dec ef_tamb
        lda ef_ruido
        sta $d40f
        lda #$00
        sta $d40e
        lda #$81
.5:     sta $d412
        jsr genera_musica
        rts

        ; Tabla de notas
tabla_notas_1:
        !byte 0 , 87 , 154 , 224 , 42 , 120 , 204 , 36 
        !byte 129 , 229 , 78 , 189 , 50 , 175 , 52 , 192 
        !byte 84 , 241 , 152 , 72 , 3 , 202 , 156 , 122 
        !byte 101 , 95 , 104 , 128 , 169 , 227 , 48 , 145 
        !byte 7 , 148 , 56 , 244 , 203 , 191 , 208 , 0 
        !byte 82 , 199 , 97 , 35 , 15 , 43 , 112 , 233 
        !byte 151 , 126 , 160 , 1 , 164 , 142 , 195 , 71 
        !byte 31 , 80 , 224 , 210 , 47 
tabla_notas_2:
        !byte 0 , 4 , 4 , 4 , 5 , 5 , 5 , 6 
        !byte 6 , 6 , 7 , 7 , 8 , 8 , 9 , 9 
        !byte 10 , 10 , 11 , 12 , 13 , 13 , 14 , 15 
        !byte 16 , 17 , 18 , 19 , 20 , 21 , 23 , 24 
        !byte 26 , 27 , 29 , 30 , 32 , 34 , 36 , 39 
        !byte 41 , 43 , 46 , 49 , 52 , 55 , 58 , 61 
        !byte 65 , 69 , 73 , 78 , 82 , 87 , 92 , 98 
        !byte 104 , 110 , 116 , 123 , 131 

ZZ     = 0           ; Silencio
SO     = $3f         ; Sostenido

FIN1   = $fe         ; Termina y queda en silencio
FIN2   = $fd         ; Repite melod¡a
FIN3   = $fc         ; Salta a melod¡a principal

C2     = 1
C2S    = 2
D2     = 3
D2S    = 4
E2     = 5
F2     = 6
F2S    = 7
G2     = 8
G2S    = 9
A2     = 10
A2S    = 11
B2     = 12

C3     = 13
C3S    = 14
D3     = 15
D3S    = 16
E3     = 17
F3     = 18
F3S    = 19
G3     = 20
G3S    = 21
A3     = 22
A3S    = 23
B3     = 24

C4     = 25
C4S    = 26
D4     = 27
D4S    = 28
E4     = 29
F4     = 30
F4S    = 31
G4     = 32
G4S    = 33
A4     = 34
A4S    = 35
B4     = 36

C5     = 37
C5S    = 38
D5     = 39
D5S    = 40
E5     = 41
F5     = 42
F5S    = 43
G5     = 44
G5S    = 45
A5     = 46
A5S    = 47
B5     = 48

C6     = 49

TA1    = $40         ; Tambor 1
TA2    = $80         ; Tambor 2

        ; Tema principal
melodia_principal:
        !byte  6 , 0 , 0 , 0
        ; 0
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA2
        ; 1
        !byte  C5 , C5  OR TA2,G5 , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 2
        !byte  A4S, A4  OR TA2,G5 , A4  OR TA1, ZZ , A4  OR TA1, ZZ , A4  OR TA1
        !byte  ZZ , A4  OR TA2,ZZ , A4  OR TA1, ZZ , A4  OR TA1, ZZ , A4  OR TA1
        ; 3
        !byte  C5 , C5  OR TA2,G5 , C5  OR TA1, C6 , C5  OR TA1, ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 4
        !byte  A4S, A4  OR TA2,G5 , A4  OR TA1, C6 , A4  OR TA1, ZZ , A4  OR TA1
        !byte  ZZ , A4  OR TA2,ZZ , A4  OR TA1, ZZ , A4  OR TA1, ZZ , A4  OR TA1
        ; 5
        !byte  C5 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, G5 , C5  OR TA1
        !byte  SO , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 6
        !byte  B4 , B4  OR TA2,G5 , B4  OR TA1, F5S, B4  OR TA1, G5 , B4  OR TA1
        !byte  SO , B4  OR TA2,ZZ , B4  OR TA1, ZZ , B4  OR TA1, ZZ , B4  OR TA1
        ; 7
        !byte  A4S, A4S OR TA2,G5 , A4S OR TA1, F5S, A4S OR TA1, G5 , A4S OR TA1 
        !byte  SO , A4S OR TA2,ZZ , A4S OR TA1, ZZ , A4S OR TA1, ZZ , A4S OR TA1
        ; 8
        !byte  C5 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, G5 , C5  OR TA1
        !byte  SO , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 9
        !byte  B4 , B4  OR TA2,G5 , B4  OR TA1, F5S, B4  OR TA1, G5 , B4  OR TA1
        !byte  SO , B4  OR TA2,ZZ , B4  OR TA1, ZZ , B4  OR TA1, ZZ , B4  OR TA1
        ; 10
        !byte  A4S, A4S OR TA2,G5 , A4S OR TA1, F5S, A4S OR TA1, G5 , A4S OR TA1
        !byte  SO , A4S OR TA2,ZZ , A4S OR TA1, ZZ , A4S OR TA1, ZZ , A4S OR TA1
        ; 11
        !byte  C5 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, G5 , C5  OR TA1
        !byte  A5S, C5  OR TA2,A5 , C5  OR TA1, G5S, C5  OR TA1, G5 , C5  OR TA1
        ; 12
        !byte  F5S, C5  OR TA2,G5 , C5  OR TA1, SO , C5  OR TA1, ZZ , C5  OR TA1
        !byte  A4 , A4  OR TA2,G5 , A4  OR TA1, F5S, A4  OR TA1, G5 , A4  OR TA1
        ; 13
        !byte  A5S, A4  OR TA2,A5 , A4  OR TA1, G5S, A4  OR TA1, G5 , A4  OR TA1
        !byte  F5S, A4  OR TA2,G5 , A4  OR TA1, SO , A4  OR TA1, ZZ , A4  OR TA1
        ; 14
        !byte  C5 , C5  OR TA2,SO , C5  OR TA1, SO , C5  OR TA1, SO , C5  OR TA1
        !byte  G5 , G5  OR TA2,SO , G5  OR TA1, SO , G5  OR TA1, SO , G5  OR TA1
        ; 15
        !byte  F5S, F5S OR TA2,SO , F5S OR TA1, SO , F5S OR TA1, SO , F5S OR TA1
        !byte  ZZ , F5S OR TA2,ZZ , F5S OR TA1, ZZ , F5S OR TA1, ZZ , F5S OR TA1
        ; 16
        !byte  C5 , C5  OR TA2,SO , C5  OR TA1, SO , C5  OR TA1, SO , C5  OR TA1
        !byte  G5 , G5  OR TA2,SO , G5  OR TA1, SO , G5  OR TA1, SO , G5  OR TA1
        ; 17
        !byte  G5S, G5S OR TA2,SO , G5S OR TA1, SO , G5S OR TA1, SO , G5S OR TA1 
        !byte  ZZ , G5S OR TA2,ZZ , G5S OR TA1, ZZ , G5S OR TA1, ZZ , G5S OR TA1
        ; 18
        !byte  C5 , C5  OR TA2,F5S, C5  OR TA1, G5 , C5  OR TA1, G5S, C5  OR TA1
        !byte  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 19
        !byte  C6 , C5  OR TA2,G5S, C5  OR TA1, G5 , C5  OR TA1, F5S, C5  OR TA1
        !byte  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 20
        !byte  C5 , C5  OR TA2,F5S, C5  OR TA1, G5 , C5  OR TA1, ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 21
        !byte  C6 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        !byte  FIN2

        ; Tema 2
melodia_2:
        !byte 6, 0, 0, 0
        ; 0
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA1
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA2
        !byte  ZZ , C5  OR TA2
        ; 1
        !byte C5 , C5  OR TA2
        !byte C5 , SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte C5 , SO  OR TA2
        !byte G5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 2
        !byte C5 , C5  OR TA2
        !byte C5 , SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte C5 , SO  OR TA2
        !byte G5 , SO  OR TA1 
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 3
        !byte A4S, A4S OR TA2
        !byte A4S, SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte A4S, SO  OR TA2
        !byte G5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 4
        !byte A4S, A4S OR TA2
        !byte A4S, SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte A4S, SO  OR TA2
        !byte G5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 5
        !byte G4S, G4S OR TA2
        !byte G4S, SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte G4S, SO  OR TA2
        !byte G5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 6
        !byte G4S, G4S OR TA2
        !byte G4S, SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte G4S, SO  OR TA2
        !byte G5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 7
        !byte G4 , G4  OR TA2
        !byte G4 , SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte G4 , SO  OR TA2
        !byte G5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 8
        !byte G5 , G5  OR TA2
        !byte G5S, SO  OR TA1
        !byte G5 , SO  OR TA1
        !byte F5 , SO  OR TA1
        !byte D5S, C5  OR TA2
        !byte D5 , SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte SO , SO  OR TA1
        ; 8.5
        !byte ZZ , C5  OR TA2
        !byte ZZ , SO  OR TA1
        !byte ZZ , SO  OR TA2
        !byte ZZ , SO  OR TA2
        ; 9
        !byte C5 , C5  OR TA2
        !byte SO , SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte C5 , SO  OR TA2
        !byte SO , SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte C5 , SO  OR TA1
        ; 10
        !byte D5S, D5S OR TA2
        !byte SO , SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte D5 , SO  OR TA2
        !byte SO , SO  OR TA1
        !byte A4S, SO  OR TA1
        !byte A4S, SO  OR TA1
        ; 11
        !byte D5 , D5  OR TA2
        !byte SO , SO  OR TA1
        !byte A4S, SO  OR TA1
        !byte A4S, SO  OR TA1
        !byte D5 , SO  OR TA2
        !byte SO , SO  OR TA1
        !byte A4S, SO  OR TA1
        !byte SO , SO  OR TA1
        ; 12
        !byte F5 , F5  OR TA2
        !byte SO , SO  OR TA1
        !byte G4S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte F5 , SO  OR TA2
        !byte SO , SO  OR TA1
        !byte G4S, SO  OR TA1
        !byte G4S, SO  OR TA1
        ; 13
        !byte F5 , F5  OR TA2
        !byte SO , SO  OR TA1
        !byte G4S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte F4S, SO  OR TA2
        !byte C5 , SO  OR TA1
        !byte F4S, SO  OR TA1
        !byte D5 , SO  OR TA1
        ; 13.5
        !byte SO , C5  OR TA2
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 14
        !byte D5 , D5  OR TA2
        !byte D5S, SO  OR TA1
        !byte D5 , SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte A4S, SO  OR TA2
        !byte D5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA1
        ; 15      
        !byte A4S, C5  OR TA2
        !byte A4S, SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , SO  OR TA2
        !byte ZZ , SO  OR TA1
        !byte ZZ , SO  OR TA2
        !byte ZZ , SO  OR TA2
        ; 16
        !byte G5 , G5  OR TA2
        !byte G5 , SO  OR TA1
        !byte G5S, SO  OR TA1
        !byte G5 , SO  OR TA1
        !byte SO , SO  OR TA2
        !byte A5S, SO  OR TA1
        !byte SO , SO  OR TA1
        !byte G5S, SO  OR TA1
        ; 17
        !byte G5 , F5  OR TA2
        !byte F5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte D5S, SO  OR TA1
        !byte SO , SO  OR TA2
        !byte F5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte C5 , SO  OR TA1
        ; 18
        !byte SO , SO  OR TA2
        !byte C5 , C5  OR TA1
        !byte ZZ , SO  OR TA1
        !byte ZZ , SO  OR TA1
        !byte C5 , SO  OR TA2
        !byte D5S, SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte D5 , SO  OR TA1
        ; 19
        !byte A4S, D5  OR TA2
        !byte SO , SO  OR TA1
        !byte D5 , SO  OR TA1
        !byte D5 , SO  OR TA1
        !byte D5S, SO  OR TA2
        !byte D5 , SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte A4S, SO  OR TA1
        ; 20
        !byte D5 , D5  OR TA2
        !byte A4S, SO  OR TA1
        !byte C5 , SO  OR TA1
        !byte SO , SO  OR TA1
        !byte ZZ , C5  OR TA2
        !byte ZZ , SO  OR TA1
        !byte ZZ , SO  OR TA1
        !byte ZZ , SO  OR TA1
        !byte FIN2

        ; Tema de amor
melodia_amor:
        !byte  8 , 12 ,-12 , 12
        ; 1
        !byte D4 , ZZ
        ; 2
        !byte B4 , G3
        !byte B3 , SO
        !byte D4 , SO
        ; 3
        !byte G4 , SO
        !byte D4 , SO
        !byte B3 , SO
        ; 4
        !byte B4 , F3S
        !byte B3 , SO
        !byte D4S, SO
        ; 5
        !byte A4 , SO
        !byte D4S, SO
        !byte B3 , SO
        ; 6
        !byte B4 , E3
        !byte B3 , SO
        !byte D4 , SO
        ; 7
        !byte G4S, E2
        !byte E4 , SO
        !byte D4 , SO
        ; 8
        !byte B4 , A2
        !byte SO , E3
        !byte SO , G3
        ; 9
        !byte E4 , B3
        !byte SO , G3
        !byte E4 , E3
        ; 10
        !byte E4 , D3
        !byte F4S, SO
        !byte G4 , SO
        ; 11
        !byte B4 , D2
        !byte F4S, SO
        !byte A4 , SO
        ; 12
        !byte G4 , G2
        !byte SO , SO
        !byte SO , D3
        ; 13
        !byte SO , G3
        !byte SO , SO
        !byte FIN1

