        ;
        ; Gr ficas para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ; El dibujo de la maceta es cortes¡a de Ad n Toledo Guti‚rrez
        ;
        ; Creaci¢n: 06-ene-2011.
        ; Revisi¢n: 11-ene-2011. Se agregan s¡mbolos !, ?, ' y %, adem s se
        ;                        termina el alfabeto. Se corrigen los colores
        ;                        del transportador y se redise¤a la gr fica.
        ; Revisi¢n: 14-ene-2011. Se agregan letras A, B y gui¢n.
        ; Revisi¢n: 15-ene-2011. Se agregan el mosaico 41 (perro de peluche),
        ;                        42 (maceta con planta), 43 (caja de cart¢n),
        ;                        44-47 (m quina con zombie). Mejoras en
        ;                        colores. Se redise¤a el librero, la m quina
        ;                        de caf‚ y el escritorio con PC.
        ; Revisi¢n: 17-ene-2011. Se agrega el mosaico 48 (puerta este). Se
        ;                        agrega s¡mbolo :
        ; Revisi¢n: 18-ene-2011. Se agrega el mosaico 49 de relleno y letras
        ;                        $36 y $37.
        ; Revisi¢n: 20-ene-2011. Se agrega letra ¥ como $36, ­ como $37 y ¨
        ;                        como $35 (se elimina :)
        ; Revisi¢n: 24-ene-2011. Se mejora el piso de mosaico 0 y 9.
        ; Revisi¢n: 25-ene-2011. Se mejora color de paredes 12-19.
        ;                        Se estilizan un poco m s las letras. Las
        ;                        letras se van a ZW.ASM, y estas gr ficas
        ;                        ahora estar n en slot alto.
        ; Revisi¢n: 26-mar-2011. Las letras vuelven a este m¢dulo.
        ; Revisi¢n: 03-abr-2011. Se reutilizan caracteres repetidos de
        ;                        algunos mosaicos, as¡ se tiene los nuevos
        ;                        mosaico 52 : escritorio con taza y dona,
        ;                        mosaico 53 : piso con s¡mbolo biopeligro.
        ; Revisi¢n: 04-abr-2011. Se modifica el PC para poder colorear la
        ;                        pantalla en el mosaico 54.
        ; Revisi¢n: 05-abr-2011. Se dibuja un nuevo mosaico 53.
        ; Revisi¢n: 06-abr-2011. Nuevo mosaico 55 : maceta con flores.
        ; Revisi¢n: 08-abr-2011. Nuevo mosaico 56 : pared 1 con rejilla. 
        ;                        Nuevo mosaico 57 : pared 1 con pizarr¢n.
        ;                        Nuevo mosaico 58 : caja de cart¢n versi¢n 2.
        ;                        Nuevos mosaicos 59-60 : piso para jefes.
        ;                        Nuevos mosaicos 61-64 : M quina l ser.
        ;                        En los mosaicos 65-66 queda el monumento al
        ;                        C.
        ; Revisi¢n: 17-may-2011, Se elimina letra ¥, ¨ y ­, no se usan en
        ;                        esta versi¢n.
        ;

        ;
        ; Las fantabulosas letras
        ; Incluye algunos gr ficos fantastirigillos
        ;
letras:
        db $00,$00,$00,$00,$00,$00,$00,$00      ; $00 Espacio
        db $38,$6c,$c6,$c6,$fe,$c6,$c6,$00      ; $01 A
        db $fc,$c6,$c6,$fc,$c6,$c6,$fc,$00      ; $02 B
        db $3c,$66,$c0,$c0,$c0,$66,$3c,$00      ; $03 C
        db $f8,$cc,$c6,$c6,$c6,$cc,$f8,$00      ; $04 D
        db $FE,$C0,$C0,$FC,$C0,$C0,$FE,$00      ; $05 E
        db $FE,$C0,$C0,$FC,$C0,$C0,$C0,$00      ; $06 F
        db $3C,$66,$C0,$CE,$C6,$66,$3C,$00      ; $07 G
        db $c6,$c6,$c6,$fe,$c6,$c6,$c6,$00      ; $08 H
        db $78,$30,$30,$30,$30,$30,$78,$00      ; $09 I
        db $06,$06,$06,$06,$c6,$c6,$7c,$00      ; $0A J
        db $c6,$c6,$cc,$f8,$cc,$c6,$c6,$00      ; $0B K
        db $C0,$C0,$C0,$C0,$C0,$C0,$FE,$00      ; $0C L
        db $c6,$ee,$fe,$d6,$d6,$c6,$c6,$00      ; $0D M
        db $C6,$e6,$f6,$DE,$CE,$C6,$C6,$00      ; $0E N
        db $38,$6c,$C6,$C6,$C6,$6c,$38,$00      ; $0F O
        db $Fc,$C6,$C6,$fc,$c0,$C0,$C0,$00      ; $10 P
        db $38,$6c,$c6,$c6,$c6,$6c,$36,$03      ; $11 Q
        db $Fc,$C6,$C6,$fC,$d8,$Cc,$C6,$00      ; $12 R
        db $7c,$c6,$c0,$7c,$06,$c6,$7c,$00      ; $13 S
        db $fc,$30,$30,$30,$30,$30,$30,$00      ; $14 T
        db $C6,$C6,$C6,$C6,$C6,$c6,$7c,$00      ; $15 U
        db $c6,$c6,$c6,$6c,$6c,$38,$10,$00      ; $16 V
        db $c6,$c6,$c6,$d6,$fe,$fe,$6c,$00      ; $17 W
        db $c6,$c6,$6c,$38,$6c,$c6,$c6,$00      ; $18 X
        db $C6,$C6,$6C,$38,$30,$30,$30,$00      ; $19 Y
        db $fe,$0c,$18,$30,$60,$c0,$fe,$00      ; $1A Z
        db $ff,$c0,$c0,$c0,$c0,$c0,$c0,$ff      ; $1B Energ¡a llena (izq)
        db $ff,$c0,$c0,$c0,$c0,$c0,$c0,$ff      ; $1C Energ¡a vacia (izq)
        db $ff,$00,$00,$00,$00,$00,$00,$ff      ; $1D Energ¡a llena (medio)
        db $ff,$00,$00,$00,$00,$00,$00,$ff      ; $1E Energ¡a vacia (medio)
        db $c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0      ; $1F Energ¡a (der)
        db $7c,$c6,$ce,$DE,$f6,$e6,$7c,$00      ; $20 0
        db $30,$70,$30,$30,$30,$30,$78,$00      ; $21 1
        db $7C,$C6,$06,$3c,$60,$C0,$FE,$00      ; $22 2
        db $7C,$C6,$0c,$38,$0c,$C6,$7C,$00      ; $23 3
        db $1E,$36,$66,$c6,$fe,$06,$06,$00      ; $24 4
        db $FE,$C0,$C0,$Fc,$06,$0c,$F8,$00      ; $25 5
        db $3E,$60,$c0,$fc,$C6,$c6,$7c,$00      ; $26 6
        db $FE,$06,$0C,$18,$30,$30,$30,$00      ; $27 7
        db $7C,$C6,$c6,$7c,$c6,$C6,$7C,$00      ; $28 8
        db $7c,$c6,$C6,$7e,$06,$0c,$78,$00      ; $29 9
        db $00,$6C,$fe,$fe,$7c,$38,$10,$00      ; $2A Coraz¢n
        db $30,$70,$30,$30,$30,$30,$78,$00      ; $2B 1 (para 1UP)
        db $7C,$C6,$06,$3c,$60,$C0,$FE,$00      ; $2C 2 (para 2UP)
        db $3c,$30,$3c,$30,$78,$CC,$CC,$78      ; $2D Llave
        db $18,$3c,$3c,$3c,$18,$00,$18,$18      ; $2E !
        db $7C,$C6,$0C,$18,$18,$00,$18,$18      ; $2F ?
        db $0C,$18,$30,$00,$00,$00,$00,$00      ; $30 '
        db $c0,$cc,$18,$30,$60,$cc,$0c,$00      ; $31 %
        db $38,$6c,$c6,$c6,$fe,$c6,$c6,$00      ; $32 A (para piso)
        db $fc,$c6,$c6,$fc,$c6,$c6,$fc,$00      ; $33 B (para piso)
        db $00,$00,$00,$fc,$00,$00,$00,$00      ; $34 -

        ;
        ; El color de las fantabulosas letras, usado exclusivamente para
        ; los indicadores.
        ;
        ; Para la historia se usan otros colores.
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
        db $f4,$f4,$f5,$f5,$f4,$f4,$f1,$f4      ; $1c
        db $f8,$f8,$f9,$f9,$f8,$f8,$f6,$f8      ; $1d
        db $f4,$f4,$f5,$f5,$f4,$f4,$f1,$f4      ; $1e
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
        db $31,$31,$21,$31,$31,$21,$21,$21      ; $30
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $31
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $32
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $33
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $34

