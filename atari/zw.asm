        ;
        ; Zombie Near para Atari 2600
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 27-ago-2011.
        ;

        processor 6502

VSYNC   = $00 ; 0000 00x0   Vertical Sync Set-Clear
VBLANK  = $01 ; xx00 00x0   Vertical Blank Set-Clear
WSYNC   = $02 ; ---- ----   Wait for Horizontal Blank
RSYNC   = $03 ; ---- ----   Reset Horizontal Sync Counter
NUSIZ0  = $04 ; 00xx 0xxx   Number-Size player/missile 0
NUSIZ1  = $05 ; 00xx 0xxx   Number-Size player/missile 1
COLUP0  = $06 ; xxxx xxx0   Color-Luminance Player 0
COLUP1  = $07 ; xxxx xxx0   Color-Luminance Player 1
COLUPF  = $08 ; xxxx xxx0   Color-Luminance Playfield
COLUBK  = $09 ; xxxx xxx0   Color-Luminance Background
CTRLPF  = $0a ; 00xx 0xxx   Control Playfield, Ball, Collisions
REFP0   = $0b ; 0000 x000   Reflection Player 0
REFP1   = $0c ; 0000 x000   Reflection Player 1
PF0     = $0d ; xxxx 0000   Playfield Register Byte 0
PF1     = $0e ; xxxx xxxx   Playfield Register Byte 1
PF2     = $0f ; xxxx xxxx   Playfield Register Byte 2
RESP0   = $10 ; ---- ----   Reset Player 0
RESP1   = $11 ; ---- ----   Reset Player 1
RESM0   = $12 ; ---- ----   Reset Missle 0
RESM1   = $13 ; ---- ----   Reset Missle 1
RESBL   = $14 ; ---- ----   Reset Ball
AUDC0   = $15 ; 0000 xxxx   Audio Control 0
AUDC1   = $16 ; 0000 xxxx   Audio Control 1
AUDF0   = $17 ; 000x xxxx   Audio Frequency 0
AUDF1   = $18 ; 000x xxxx   Audio Frequency 1
AUDV0   = $19 ; 0000 xxxx   Audio Volume 0
AUDV1   = $1a ; 0000 xxxx   Audio Volume 1
GRP0    = $1b ; xxxx xxxx   Graphics Register Player 0
GRP1    = $1c ; xxxx xxxx   Graphics Register Player 1
ENAM0   = $1d ; 0000 00x0   Graphics Enable Missile 0
ENAM1   = $1e ; 0000 00x0   Graphics Enable Missile 1
ENABL   = $1f ; 0000 00x0   Graphics Enable Ball
HMP0    = $20 ; xxxx 0000   Horizontal Motion Player 0
HMP1    = $21 ; xxxx 0000   Horizontal Motion Player 1
HMM0    = $22 ; xxxx 0000   Horizontal Motion Missile 0
HMM1    = $23 ; xxxx 0000   Horizontal Motion Missile 1
HMBL    = $24 ; xxxx 0000   Horizontal Motion Ball
VDELP0  = $25 ; 0000 000x   Vertical Delay Player 0
VDELP1  = $26 ; 0000 000x   Vertical Delay Player 1
VDELBL  = $27 ; 0000 000x   Vertical Delay Ball
RESMP0  = $28 ; 0000 00x0   Reset Missile 0 to Player 0
RESMP1  = $29 ; 0000 00x0   Reset Missile 1 to Player 1
HMOVE   = $2a ; ---- ----   Apply Horizontal Motion
HMCLR   = $2b ; ---- ----   Clear Horizontal Move Registers
CXCLR   = $2c ; ---- ----   Clear Collision Latches

CXM0P   = $00 ; xx00 0000       Read Collision  M0-P1   M0-P0
CXM1P   = $01 ; xx00 0000                       M1-P0   M1-P1
CXP0FB  = $02 ; xx00 0000                       P0-PF   P0-BL
CXP1FB  = $03 ; xx00 0000                       P1-PF   P1-BL
CXM0FB  = $04 ; xx00 0000                       M0-PF   M0-BL
CXM1FB  = $05 ; xx00 0000                       M1-PF   M1-BL
CXBLPF  = $06 ; x000 0000                       BL-PF   -----
CXPPMM  = $07 ; xx00 0000                       P0-P1   M0-M1
INPT0   = $08 ; x000 0000       Read Pot Port 0
INPT1   = $09 ; x000 0000       Read Pot Port 1
INPT2   = $0a ; x000 0000       Read Pot Port 2
INPT3   = $0b ; x000 0000       Read Pot Port 3
INPT4   = $0c ; x000 0000       Read Input (Trigger) 0
INPT5   = $0d ; x000 0000       Read Input (Trigger) 1

	; RIOT MEMORY MAP

SWCHA   = $280  ; Port A data register for joysticks:
                ; Bits 4-7 for player 1.  Bits 0-3 for player 2.
SWACNT  = $281  ; Port A data direction register (DDR)
SWCHB   = $282  ; Port B data (console switches)
SWBCNT  = $283  ; Port B DDR
INTIM   = $284  ; Timer output

TIMINT  = $285

TIM1T   = $294  ; set 1 clock interval
TIM8T   = $295  ; set 8 clock interval
TIM64T  = $296  ; set 64 clock interval
T1024T  = $297  ; set 1024 clock interval

        ;
        ; Inicia l¡nea de jugador
        ;
cuadro          = $80
offset          = $81
y_jugador       = $82
linea_jugador   = $83

        ;
        ; La RAM se halla entre $0080 y $00FF.
        ;

        org $f000       ; Locaci¢n de inicio del ROM

inicio: sei             ; Desactiva interrupciones
        cld             ; Desactiva modo decimal
        ldx #$ff        ; Carga X con FF...
        txs             ; ...copia a registro de pila.
        lda #0          ; Carga cero en A
limpia_mem:
        sta 0,X         ; Guarda en posici¢n 0 m s X
        dex             ; Decrementa X
        bne limpia_mem  ; Continua hasta que X es cero.
        sta SWACNT
        sta SWBCNT

        lda #$00
        sta COLUBK      ; Color de fondo
        lda #$33
        sta COLUP0      ; Color de Player/Missile 0
bucle:
        lda #2
        sta VSYNC       ; Inicia sincron¡a vertical
        sta WSYNC       ; 3 l¡neas de espera
        sta WSYNC
        sta WSYNC
        lda #43
        sta TIM64T
        lda #0
        sta VSYNC       ; Detiene sincron¡a vertical
espera_vblank:
        lda INTIM
        bne espera_vblank
        ldy #192
        sta WSYNC
        sta VBLANK
pantalla:
        sec
        cpy y_jugador
        bne no_activo
        lda #16
        sta linea_jugador
no_activo:
        lda linea_jugador
        beq sin_jugador
        tax
        dex
        lda colores,x
        sta COLUP0
        dec linea_jugador
        txa
        clc
        adc offset
        tax
        lda sprites,x
sin_jugador:
        sta GRP0        ; Pone en bitmap Player 0
        sta WSYNC
        dey
        bne pantalla
        lda #2
        sta WSYNC
        sta VBLANK
        ldx #37
overscan:
        sta WSYNC
        dex
        bne overscan
        inc cuadro
        lda cuadro
        and #$0c
        asl
        asl
        sta offset
        lda cuadro
        and #$01
        beq z1
        lda SWCHA
        and #$10
        bne z2
        dec y_jugador
z2:     lda SWCHA
        and #$20
        bne z3
        inc y_jugador
z3:
z1:     jmp bucle

        ;
        ; Colores de sprite por l¡nea
        ;
colores:
        .byte $9a 
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $9a
        .byte $3a
        .byte $3a
        .byte $3a
        .byte $3a

        ;
        ; Los sprites est n verticalmente al rev‚s, para ahorrar
        ; instrucciones al visualizar.
        ;
sprites:
        ; Jugador a la derecha (1 / 4)
        .byte %01100110
        .byte %01000100
        .byte %01101100
        .byte %00101000
        .byte %00111000
        .byte %00001000
        .byte %00110000
        .byte %00111100
        .byte %00111010
        .byte %00111111
        .byte %00110011
        .byte %00001100
        .byte %00011110
        .byte %00010100
        .byte %00011100
        .byte %00000000
        ; Jugador a la derecha (2 / 4)
        .byte %00001100
        .byte %00110000
        .byte %00101000
        .byte %00110000
        .byte %00111000
        .byte %00101000
        .byte %00011000
        .byte %00111000
        .byte %00111100
        .byte %00111010
        .byte %00111111
        .byte %00110011
        .byte %00001100
        .byte %00011110
        .byte %00010100
        .byte %00011100
        ; Jugador a la derecha (3 / 4)
        .byte %00111000
        .byte %00100000
        .byte %00011100
        .byte %00011000
        .byte %00111000
        .byte %00101000
        .byte %00011000
        .byte %00111000
        .byte %00111100
        .byte %00111010
        .byte %00111111
        .byte %00110011
        .byte %00001100
        .byte %00011110
        .byte %00010100
        .byte %00011100
        ; Jugador a la derecha (4 / 4)
        .byte %01100000
        .byte %01011100
        .byte %00111000
        .byte %00110000
        .byte %00111000
        .byte %00101000
        .byte %00011000
        .byte %00111000
        .byte %00111100
        .byte %00111010
        .byte %00111111
        .byte %00110011
        .byte %00001100
        .byte %00011110
        .byte %00010100
        .byte %00011100

        org $fffc
        .word inicio    ; Posici¢n de inicio al recibir RESET
        .word inicio    ; Posici¢n para servir BRK

