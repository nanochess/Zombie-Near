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
        db $30,$30,$00,$30,$30,$60,$c6,$7c      ; $35 ¨
        db $FE,$00,$C6,$e6,$de,$Ce,$C6,$00      ; $36 ¥
        db $18,$18,$00,$18,$3c,$3c,$3c,$18      ; $37 ­

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
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $35
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $36
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $37

        ;
        ; Bitmaps para armar los niveles
        ; Pueden existir hasta 50 mosaicos diferentes para mostrar
        ; al artista interno (mejor dicho, :) la artisteada)
        ;
graf_bitmap:
        ; 52 - Escritorio con taza y dona
        ; 00 - Piso con mosaico 1
        db $98,$80,$80,$80,$ef,$08,$08,$89
        db $00,$ff,$ff,$e7,$db,$c0,$c2,$c2      ; Reusado (52,0) 
        db $89,$08,$08,$08,$fe,$80,$80,$98
        db $00,$ff,$ff,$ff,$ff,$ff,$c7,$93      ; Reusado (52,1)
        ; 01 - Pared norte
        db $ff,$80,$80,$80,$ff,$08,$08,$08
        db $c0,$e7,$ff,$ff,$00,$30,$30,$18      ; Reusado (52,2)
        db $ff,$80,$ff,$08,$ff,$80,$ff,$08      
        db $c7,$c7,$ff,$ff,$00,$0c,$0c,$18      ; Reusado (52,3)
        ; 02 - Pared oeste
        db $f8,$88,$88,$88,$8f,$88,$88,$88
        db $ea,$aa,$ae,$aa,$aa,$ba,$aa,$ab
        db $00,$03,$0D,$1B,$33,$32,$78,$61      ; Reusado (53,0)
        db $00,$C0,$B0,$D8,$CC,$4C,$1E,$86      ; Reusado (53,1)
        ; 03 - Pared este
        db $57,$55,$75,$55,$55,$5d,$55,$d5
        db $1f,$11,$11,$11,$f1,$11,$11,$11
        db $59,$7C,$3E,$2C,$11,$0F,$03,$00      ; Reusado (53,2)
        db $9A,$3E,$7C,$34,$88,$F0,$C0,$00      ; Reusado (53,3)
        ; 04 - Pared sur
        db $08,$ff,$80,$ff,$08,$ff,$80,$ff
        db $00,$00,$01,$01,$00,$83,$ff,$01      ; Reusado (54,1)
        db $08,$08,$08,$ff,$80,$80,$80,$ff
        db $ff,$80,$ff,$08,$ff,$80,$d5,$d5      ; Reusado (56,2)
        ; 05 - Uni¢n pared norte y oeste
        db $ff,$80,$80,$80,$ff,$88,$88,$88
        db $ff,$80,$ff,$81,$81,$81,$7e,$08      ; Reusado (57,2)
        db $f0,$fe,$fe,$fe,$fe,$fe,$fe,$fe      ; Reusado (58,0)
        db $FF,$80,$BF,$A8,$AF,$B8,$AB,$AB
        ; 06 - Uni¢n pared norte y este
        db $fe,$fe,$ff,$fc,$f8,$7c,$7c,$7f      ; Reusado (58,2)
        db $ff,$81,$81,$81,$f1,$11,$11,$11
        db $ff,$81,$fd,$0d,$f7,$9d,$f5,$d5
        db $3e,$02,$fe,$fe,$7e,$fc,$fc,$fc      ; Reusado (58,3)
        ; 07 - Uni¢n pared sur y oeste
        db $88,$88,$88,$8f,$88,$88,$88,$f8      ; Reusado (59/60)
        db $ea,$ab,$a8,$af,$a8,$bf,$80,$ff
        db $88,$88,$88,$ff,$80,$80,$80,$ff
        db $88,$88,$88,$88,$88,$88,$88,$88      ; Reusado (59/60)
        ; 08 - Uni¢n pared sur y este
        db $57,$d5,$95,$f5,$0d,$fd,$81,$ff
        db $1F,$11,$11,$11,$F1,$11,$11,$ff
        db $CC,$33,$1C,$17,$15,$15,$15,$15      ; Reusado (66)
        db $09,$09,$09,$ff,$81,$81,$81,$ff
        ; 09 - Piso con mosaico 2
        db $98,$80,$80,$80,$ee,$08,$08,$00
        db $98,$80,$80,$80,$ef,$88,$88,$09
        db $8e,$08,$08,$00,$fe,$80,$80,$98
        db $e9,$88,$88,$08,$fe,$80,$80,$98
        ; 10 - Piso de rombo 1
        db $01,$02,$04,$08,$11,$21,$41,$81
        db $81,$41,$21,$11,$08,$04,$02,$01
        db $80,$40,$20,$10,$88,$44,$22,$11
        db $11,$22,$44,$88,$10,$20,$40,$80
        ; 11 - Piso de rombo 2
        db $01,$02,$04,$08,$11,$22,$44,$88
        db $88,$44,$22,$11,$08,$04,$02,$01
        db $80,$40,$20,$10,$88,$84,$82,$81
        db $81,$82,$84,$88,$10,$20,$40,$80
        ; 12 - Pared norte
        db $ff,$02,$04,$08,$10,$20,$40,$80
        db $00,$00,$00,$00,$00,$00,$00,$03      ; Reusado (61,0)
        db $ff,$0c,$30,$c0,$03,$0c,$30,$c0
        db $00,$01,$06,$0f,$37,$37,$5b,$5b      ; Reusado (61,1)
        ; 13 - Pared oeste
        db $81,$82,$84,$88,$90,$a0,$c0,$80      
        db $88,$88,$c4,$c4,$a2,$a2,$91,$91
        db $e0,$03,$1f,$f0,$f0,$f0,$00,$00      ; Reusado (61,2)
        db $2d,$ad,$d6,$16,$03,$00,$00,$00      ; Reusado (61,3)
        ; 14 - Pared este
        db $11,$11,$23,$23,$45,$45,$89,$89
        db $01,$03,$05,$09,$11,$21,$41,$81
        db $c8,$ed,$ed,$76,$76,$bb,$bb,$dd      ; Reusado (62,0)
        db $00,$9c,$b6,$c3,$db,$6d,$6d,$ab      ; Reusado (62,1)
        ; 15 - Pared sur
        db $03,$0c,$30,$c0,$03,$0c,$30,$ff
        db $dd,$ee,$ee,$f7,$72,$35,$05,$06      ; Reusado (62,2)
        db $01,$02,$04,$08,$10,$20,$40,$ff
        db $aa,$cc,$dc,$3e,$da,$ea,$ee,$d6      ; Reusado (62,3)
        ; 16 - Uni¢n pared norte y oeste
        db $ff,$82,$84,$88,$90,$a0,$c0,$80
        db $00,$1f,$30,$37,$60,$7f,$c0,$ff      ; Reusado (63,0)
        db $00,$ff,$01,$ff,$41,$7d,$e3,$ff      ; Reusado (63,1)
        db $ff,$cc,$f0,$d0,$ab,$a4,$92,$91
        ; 17 - Uni¢n pared norte y este
        db $c9,$c9,$ff,$ff,$80,$ff,$7f,$7f      ; Reusado (63,2)
        db $ff,$03,$05,$09,$11,$21,$41,$81
        db $ff,$0f,$37,$cb,$15,$25,$49,$89
        db $3c,$3c,$ff,$ff,$00,$ff,$ff,$ff      ; Reusado (63,3)
        ; 18 - Uni¢n pared sur y oeste
        db $ef,$ef,$ec,$db,$db,$bc,$ff,$ff      ; Reusado (64,0)
        db $89,$8a,$c4,$c8,$b3,$ac,$f0,$ff
        db $81,$82,$84,$88,$90,$a0,$c0,$ff
        db $3a,$ce,$b6,$37,$4f,$ff,$ff,$ff      ; Reusado (64,1)
        ; 19 - Uni¢n pared sur y este
        db $91,$51,$23,$d3,$0d,$05,$33,$ff
        db $24,$24,$ff,$ff,$00,$ff,$ff,$ff      ; Reusado (64,2)
        db $93,$93,$ff,$ff,$01,$ff,$fe,$fe      ; Reusado (64,3)
        db $01,$03,$05,$09,$11,$21,$41,$ff
        ; 20 - Puerta oeste
        db $00,$7e,$56,$56,$56,$56,$56,$56
        db $00,$f0,$fe,$fa,$fa,$fa,$fa,$fa
        db $56,$56,$56,$56,$56,$56,$7e,$00
        db $fa,$fa,$fa,$fa,$fa,$fe,$f0,$00
        ; 21 - Puerta norte
        db $00,$7f,$40,$7f,$40,$7f,$7f,$00
        db $00,$fe,$02,$fe,$02,$fe,$fe,$00
        db $7f,$7f,$7f,$7f,$3f,$20,$3f,$3f
        db $fe,$fe,$fe,$fe,$fc,$04,$fc,$fc
        ; 22 - Escritorio vac¡o
        db $00,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        db $00,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        db $ff,$ff,$ff,$ff,$00,$30,$30,$18
        db $ff,$ff,$ff,$ff,$00,$0c,$0c,$18
        ; 23 - Escritorio con papeles
        db $00,$ff,$ff,$ff,$ff,$e7,$83,$c1
        db $00,$ff,$ff,$ff,$ff,$f3,$f3,$e7
        db $e0,$f3,$ff,$ff,$00,$30,$30,$18
        db $e7,$ff,$ff,$ff,$00,$0c,$0c,$18
        ; 24 - Escritorio con PC
        db $c6,$86,$a6,$a6,$a6,$87,$a7,$8c
        db $00,$00,$fe,$fe,$00,$83,$ff,$01
        db $f9,$fa,$f8,$ff,$00,$30,$30,$18
        db $54,$aa,$00,$ff,$00,$0c,$0c,$18
        ; 25 - Escritorio con matraces
        db $00,$ff,$e7,$db,$e7,$db,$bd,$81
        db $00,$ff,$ff,$ff,$e7,$db,$e7,$db
        db $81,$c3,$ff,$ff,$00,$30,$30,$18
        db $81,$81,$c3,$ff,$00,$0c,$0c,$18
        ; 26 - Maquina de caf‚
        db $ff,$ff,$ff,$ff,$ff,$ff,$88,$8a
        db $fe,$fe,$fe,$fe,$fe,$fe,$03,$ab
        db $8f,$f8,$7a,$7f,$7f,$7f,$7f,$7f
        db $fe,$02,$aa,$fe,$fc,$84,$8c,$fc
        ; 27 - Librero
        db $ff,$ff,$ff,$ff,$ff,$80,$aa,$ff
        db $fe,$fe,$fe,$fe,$fe,$02,$52,$fe
        db $80,$aa,$7f,$40,$55,$7f,$40,$7f
        db $02,$aa,$fc,$04,$54,$fc,$04,$fc
        ; 28 - Armario
        db $00,$7f,$7f,$7f,$7f,$7f,$7f,$00
        db $00,$fe,$fe,$fe,$fe,$fe,$fe,$00
        db $7e,$4e,$7e,$7e,$3e,$3e,$3e,$00
        db $fe,$fe,$fe,$fe,$fc,$fc,$fc,$00
        ; 29 - Armario semiabierto
        db $00,$7f,$7f,$7f,$7f,$7f,$7f,$00
        db $00,$fe,$fe,$fe,$fe,$fe,$fe,$00
        db $7e,$4e,$7e,$7e,$3e,$3e,$3e,$00
        db $0e,$3e,$7e,$7e,$7c,$7c,$7c,$70
        ; 30 - Sanitario
        db $7f,$7f,$00,$7f,$4f,$7f,$3f,$00
        db $fe,$fe,$00,$fe,$fe,$fe,$fc,$00
        db $1f,$38,$38,$1c,$0f,$07,$07,$07
        db $f8,$1c,$1c,$38,$f0,$e0,$e0,$e0
        ; 31 - Consola 1
        db $ff,$00,$ff,$d5,$ff,$d5,$ff,$00
        db $ff,$00,$ff,$ab,$ff,$ab,$ff,$00
        db $7f,$f0,$f0,$f0,$ff,$00,$7f,$7f
        db $fe,$0f,$0f,$0f,$ff,$00,$fe,$fe
        ; 32 - Mesa de disecci¢n.
        db $bf,$bf,$bf,$bf,$bf,$bf,$bf,$bf
        db $fd,$fd,$fd,$fd,$fd,$fd,$fd,$fd
        db $bf,$bf,$bf,$bf,$bf,$ff,$60,$30
        db $fd,$fd,$fd,$fd,$fd,$ff,$06,$0c
        ; 33 - Mesa de disecci¢n con huesitos
        db $bf,$b8,$b6,$b8,$b0,$bd,$bc,$be
        db $fd,$1d,$6d,$1d,$0d,$bd,$3d,$7d
        db $b0,$be,$bc,$bd,$b9,$ff,$60,$30
        db $0d,$7d,$3d,$bd,$9d,$ff,$06,$0c
        ; 34 - Mesa con herramientas de cirug¡a
        db $00,$ff,$ff,$ff,$fd,$f5,$d5,$d5
        db $00,$ff,$ff,$ff,$9d,$bb,$bb,$bb
        db $d5,$d5,$ff,$00,$60,$60,$30,$30
        db $ff,$c3,$ff,$00,$06,$06,$0c,$0c
        ; 35 - Consola 2
        db $ff,$00,$7f,$d5,$ff,$d5,$ff,$00
        db $ff,$00,$ff,$ab,$ff,$ab,$ff,$00
        db $7f,$f0,$f0,$f0,$ff,$00,$7f,$7f
        db $fe,$0f,$0f,$0f,$ff,$00,$fe,$fe
        ; 36 - Transportador (1)
        db $ee,$88,$00,$00,$ee,$88,$00,$00
        db $00,$00,$01,$02,$53,$29,$58,$38      ; Reusado (55,0)
        db $ee,$88,$00,$00,$ee,$88,$00,$00
        db $00,$80,$45,$aa,$6d,$c7,$8c,$98      ; Reusado (55,1)
        ; 37 - Transportador (2)
        db $00,$88,$88,$cc,$00,$88,$88,$cc
        db $0d,$05,$30,$3f,$3f,$3f,$1f,$0f      ; Reusado (55,2)
        db $00,$88,$88,$cc,$00,$88,$88,$cc
        db $b0,$20,$0c,$fc,$fc,$fc,$f8,$f0      ; Reusado (55,3)
        ; 38 - Transportador (3)
        db $00,$00,$11,$77,$00,$00,$11,$77
        db $00,$00,$00,$00,$07,$19,$27,$4E      ; Reusado (65,0)
        db $00,$00,$11,$77,$00,$00,$11,$77
        db $00,$00,$00,$00,$C0,$E0,$F8,$1C      ; Reusado (65,1)
        ; 39 - Transportador (4)
        db $33,$11,$11,$00,$33,$11,$11,$00
        db $5C,$5C,$5C,$5C,$3D,$1E,$0F,$31      ; Reusado (65,2)
        db $33,$11,$11,$00,$33,$11,$11,$00
        db $0E,$00,$00,$3C,$CE,$1C,$F8,$E4      ; Reusado (65,3)
        ; 40 - Puerta sur
        db $3f,$3f,$20,$3f,$7f,$7f,$7f,$7f
        db $fc,$fc,$04,$fc,$fe,$fe,$fe,$fe
        db $00,$7f,$40,$7f,$40,$7f,$7f,$00
        db $00,$fe,$02,$fe,$02,$fe,$fe,$00
        ; 41 - Escritorio con perro de peluche
        db $00,$f9,$f2,$f4,$fa,$f0,$f2,$f8
        db $00,$ff,$ff,$1f,$6f,$af,$3f,$5f
        db $f0,$f0,$ff,$ff,$00,$30,$30,$18
        db $1f,$3f,$1f,$9f,$00,$0c,$0c,$18
        ; 42 - Maceta con planta
        db $00,$30,$38,$1c,$0e,$77,$fb,$3d
        db $0c,$1e,$3e,$78,$f0,$e6,$cf,$be
        db $1f,$07,$30,$3f,$3f,$3f,$1f,$0f
        db $f8,$e0,$0c,$fc,$fc,$fc,$f8,$f0
        ; 43 - Caja de cart¢n (1)
        db $1e,$fe,$fe,$fe,$fe,$fe,$fe,$fe
        db $00,$fe,$fe,$fe,$fe,$fe,$fe,$fe
        db $f8,$80,$ff,$fc,$f8,$7c,$7c,$7f
        db $fe,$fe,$fe,$fe,$7e,$fc,$fc,$fc
        ; 44 - M quina con zombie (sup. izq)
        db $00,$00,$00,$ff,$83,$fa,$be,$82
        db $0f,$10,$20,$47,$4b,$89,$8f,$86
        db $be,$b2,$b6,$f6,$86,$fe,$9e,$82
        db $82,$83,$81,$8f,$9b,$9b,$9b,$87
        ; 45 - M quina con zombie (sup. der)        
        db $f0,$08,$04,$e2,$d2,$91,$f1,$61
        db $00,$00,$00,$ff,$ff,$51,$5d,$45
        db $41,$c1,$81,$f1,$d9,$d9,$d9,$e9
        db $5d,$41,$7f,$41,$75,$5f,$41,$7f
        ; 46 - M quina con zombie (inf. izq)
        db $ff,$a4,$ae,$a8,$ab,$a9,$a1,$ff
        db $86,$86,$80,$86,$86,$70,$0f,$ff
        db $c9,$c9,$ff,$ff,$80,$ff,$7f,$7f
        db $3c,$3c,$ff,$ff,$00,$ff,$ff,$ff
        ; 47 - M quina con zombie (inf. der)
        db $61,$61,$01,$61,$61,$0e,$f0,$ff
        db $ff,$21,$af,$bd,$21,$ef,$81,$ff
        db $24,$24,$ff,$ff,$00,$ff,$ff,$ff
        db $93,$93,$ff,$ff,$01,$ff,$fe,$fe
        ; 48 - Puerta este
        db $00,$0f,$7f,$5f,$5f,$5f,$5f,$5f
        db $00,$7e,$6a,$6a,$6a,$6a,$6a,$6a
        db $5f,$5f,$5f,$5f,$5f,$7f,$0f,$00
        db $6a,$6a,$6a,$6a,$6a,$6a,$7e,$00
        ; 49 - Vac¡o (para simplificar visualizaci¢n historia)
        db $33,$CC,$38,$E8,$A8,$A8,$A8,$A8      ; Reusado (66,1)
        db $15,$15,$15,$3D,$5F,$23,$1C,$03      ; Reusado (66,2)
        db $A8,$A8,$A8,$BC,$FA,$C4,$38,$C0      ; Reusado (66,3)
        db $00,$00,$00,$00,$00,$00,$00,$00

graf_color:
        ; 00 - Piso de mosaico 1
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $e1,$e1,$e1,$ef,$ef,$ef,$ef,$ef
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $e1,$e1,$e1,$e1,$e1,$e1,$e9,$e9
        ; 01 - Pared norte
        db $e8,$e9,$e8,$e6,$e8,$e9,$e8,$e6
        db $ef,$ef,$ef,$f1,$e1,$e1,$e1,$e4
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        db $e9,$e6,$e6,$f1,$e1,$e1,$e1,$e4
        ; 02 - Pared oeste
        db $e8,$e8,$e8,$e8,$e8,$e8,$e8,$e8
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        ; 03 - Pared este
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        db $e8,$e8,$e8,$e8,$e8,$e8,$e8,$e8
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        ; 04 - Pared sur
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        db $1f,$1f,$fc,$fc,$ef,$ef,$ef,$ef
        db $e9,$e8,$e6,$e8,$e9,$e8,$e6,$e8
        db $e6,$e6,$e6,$e6,$e6,$e6,$61,$61
        ; 05 - Uni¢n pared norte y oeste
        db $e8,$e9,$e8,$e8,$e8,$e9,$e8,$e8
        db $e6,$e6,$1f,$1c,$1c,$12,$16,$e6
        db $b4,$b1,$b1,$b1,$b1,$b1,$b1,$b1
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        ; 06 - Uni¢n pared norte y este
        db $b1,$b1,$a1,$a1,$a1,$a1,$a1,$e4
        db $e8,$e9,$e8,$e8,$e8,$e9,$e8,$e8
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        db $b1,$b1,$a1,$a1,$a1,$a1,$a1,$e4
        ; 07 - Uni¢n pared sur y oeste
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        db $e9,$e8,$e8,$e8,$e9,$e8,$e8,$e8
        db $54,$54,$54,$54,$54,$54,$54,$54
        ; 08 - Uni¢n pared sur y este
        db $e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        db $e8,$e8,$e8,$e8,$e8,$e8,$e8,$e8
        db $f1,$f1,$f1,$e1,$e1,$e1,$e1,$e1
        db $e9,$e8,$e8,$e8,$e9,$e8,$e8,$e8
        ; 09 - Piso con mosaico botado
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        ; 10 - Piso de mosaico 1
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        ; 11 - Piso de mosaico 2
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $54,$54,$54,$54,$54,$54,$54,$54
        ; 12 - Pared norte
        db $c3,$c3,$c3,$c3,$c2,$c2,$c2,$c2
        db $14,$14,$14,$14,$14,$14,$14,$14
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        db $d4,$d1,$d1,$f1,$d1,$d1,$d1,$d1
        ; 13 - Pared oeste
        db $c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        db $41,$91,$91,$96,$61,$14,$44,$44
        db $d1,$d1,$d1,$d1,$d1,$d1,$d4,$d4
        ; 14 - Pared este
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        db $c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2
        db $d1,$d1,$f1,$d1,$d1,$d1,$d1,$d1
        db $71,$71,$51,$71,$51,$51,$51,$41
        ; 15 - Pared sur
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        db $d1,$d1,$d1,$d1,$d1,$d1,$71,$51
        db $c3,$c3,$c3,$c3,$c2,$c2,$c2,$c2
        db $41,$71,$51,$71,$51,$71,$51,$71
        ; 16 - Uni¢n pared norte y oeste
        db $c3,$c3,$c3,$c3,$c2,$c2,$c2,$c2
        db $51,$51,$71,$71,$71,$71,$f1,$f1
        db $51,$51,$71,$71,$74,$74,$f4,$f4
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        ; 17 - Uni¢n pared norte y este
        db $75,$74,$71,$f1,$8e,$a4,$a1,$61
        db $c3,$c3,$c3,$c3,$c2,$c2,$c2,$c2
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        db $75,$74,$71,$f1,$8e,$a4,$a1,$61
        ; 18 - Uni¢n pared sur y oeste
        db $74,$74,$74,$74,$74,$74,$f4,$f4
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        db $c3,$c3,$c3,$c3,$c2,$c2,$c2,$c2
        db $71,$71,$71,$71,$f1,$f1,$f1,$f1
        ; 19 - Uni¢n pared sur y este
        db $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c
        db $78,$76,$71,$f1,$8e,$a4,$a1,$61
        db $78,$76,$71,$f1,$8e,$a4,$a1,$61
        db $c3,$c3,$c3,$c3,$c2,$c2,$c2,$c2
        ; 20 - Puerta oeste
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        ; 21 - Puerta norte
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$54
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$54
        ; 22 - Escritorio vacio
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $e1,$e1,$e1,$f1,$e1,$e1,$e1,$e4
        db $e1,$e1,$e1,$f1,$e1,$e1,$e1,$e4
        ; 23 - Escritorio con papeles
        db $e1,$ef,$ef,$ef,$ef,$ef,$ef,$ef
        db $e1,$ef,$ef,$ef,$e6,$e6,$e6,$e6
        db $ef,$ef,$ef,$f1,$e1,$e1,$e1,$e4
        db $e6,$e6,$e6,$f1,$e1,$e1,$e1,$e4
        ; 24 - Escritorio con PC
        db $1f,$1f,$1f,$1f,$ef,$ef,$ef,$ef
        db $1f,$1f,$1f,$1f,$ef,$ef,$ef,$ef
        db $ef,$ef,$ef,$f1,$e1,$e1,$e1,$e4
        db $ef,$ef,$ef,$f1,$e1,$e1,$e1,$e4
        ; 25 - Escritorio con matraces
        db $e1,$e1,$ed,$ed,$ed,$ed,$ed,$e5
        db $e1,$e1,$e1,$e1,$e8,$e8,$e8,$e8
        db $ed,$ed,$e1,$f1,$e1,$e1,$e1,$e4
        db $e9,$e8,$e8,$f1,$e1,$e1,$e1,$e4
        ; 26 - M quina de caf‚
        db $f1,$91,$91,$91,$91,$81,$8f,$8f
        db $f1,$91,$91,$91,$91,$81,$8f,$8f
        db $8f,$81,$81,$81,$81,$81,$81,$64
        db $81,$81,$81,$81,$81,$81,$81,$64
        ; 27 - Librero
        db $f1,$b1,$b1,$b1,$a1,$a1,$a1,$a1
        db $f1,$b1,$b1,$b1,$a1,$a1,$a1,$a1
        db $a1,$a1,$a1,$a1,$a1,$a1,$a1,$a4
        db $a1,$a1,$a1,$a1,$a1,$a1,$a1,$a4
        ; 28 - Armario
        db $f1,$f1,$71,$71,$71,$71,$71,$71
        db $f1,$f1,$71,$71,$71,$71,$71,$71
        db $51,$51,$51,$51,$51,$51,$41,$41
        db $51,$51,$51,$51,$51,$51,$41,$41
        ; 29 - Armario semiabierto
        db $f1,$f1,$71,$71,$71,$71,$71,$71
        db $f1,$f1,$71,$71,$71,$71,$71,$71
        db $51,$51,$51,$51,$51,$51,$41,$41
        db $51,$51,$51,$51,$51,$51,$41,$41
        ; 30 - Sanitario
        db $f1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $f1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $f1,$f1,$f1,$f1,$f4,$14,$e4,$e4
        db $f1,$f1,$f1,$f1,$f4,$14,$e4,$e4
        ; 31 - Consola 1
        db $f1,$e1,$e1,$e3,$e1,$ed,$e1,$00
        db $f1,$e1,$e1,$e6,$e1,$ea,$e1,$00
        db $f1,$f8,$f2,$f4,$f1,$e1,$e1,$e4
        db $f1,$f4,$f8,$f2,$f1,$e1,$e1,$e4
        ; 32 - Mesa de disecci¢n
        db $ef,$ef,$ef,$ef,$ef,$ef,$ef,$ef
        db $ef,$ef,$ef,$ef,$ef,$ef,$ef,$ef
        db $ef,$ef,$ef,$ef,$ef,$f1,$e1,$e4
        db $ef,$ef,$ef,$ef,$ef,$f1,$e1,$e4
        ; 33 - Mesa de disecci¢n con huesitos
        db $ef,$ef,$ef,$ef,$ef,$ef,$ef,$ef
        db $ef,$ef,$ef,$ef,$ef,$ef,$ef,$ef
        db $ef,$ef,$ef,$ef,$ef,$f1,$e1,$e4
        db $ef,$ef,$ef,$ef,$ef,$f1,$e1,$e4
        ; 34 - Mesa con herramientas de cirug¡a
        db $11,$2f,$cf,$cf,$c6,$cf,$cf,$cf
        db $11,$2f,$cf,$cf,$cf,$cf,$cf,$cf
        db $cf,$ce,$cf,$e1,$e1,$e1,$e1,$e4
        db $cf,$ce,$cf,$e1,$e1,$e1,$e1,$e4
        ; 35 - Consola 2
        db $f1,$e1,$e1,$e4,$e1,$e2,$e1,$00
        db $f1,$e1,$e1,$e7,$e1,$e9,$e1,$00
        db $f1,$f9,$f3,$f5,$f1,$e1,$e1,$e4
        db $f1,$f5,$f9,$f3,$f1,$e1,$e1,$e4
        ; 36 - Transportador (1)
        db $d1,$d1,$31,$31,$91,$91,$51,$51
        db $84,$84,$84,$81,$81,$81,$81,$61
        db $a1,$a1,$81,$81,$41,$41,$21,$21
        db $84,$84,$81,$81,$81,$61,$c1,$c1
        ; 37 - Transportador (2)
        db $d1,$d1,$31,$31,$91,$91,$51,$51
        db $31,$31,$81,$84,$84,$84,$84,$64
        db $a1,$a1,$81,$81,$41,$41,$21,$21
        db $c1,$c1,$61,$64,$64,$64,$64,$64
        ; 38 - Transportador (3)
        db $d1,$d1,$31,$31,$91,$91,$51,$51
        db $44,$44,$44,$44,$f4,$f1,$f1,$f1
        db $a1,$a1,$81,$81,$41,$41,$21,$21
        db $44,$44,$44,$44,$f4,$f4,$f1,$f1
        ; 39 - Transportador (4)
        db $d1,$d1,$31,$31,$91,$91,$51,$51
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $a1,$a1,$81,$81,$41,$41,$21,$21
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        ; 40 - Puerta sur
        db $54,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $54,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        ; 41 - Escritorio con perro de peluche
        db $e1,$e9,$18,$18,$18,$18,$18,$18
        db $e1,$e1,$11,$18,$16,$16,$16,$16
        db $e8,$e6,$e1,$f1,$e1,$e1,$e1,$e4
        db $e6,$e6,$e6,$f6,$e1,$e1,$e1,$e4
        ; 42 - Maceta con planta
        db $34,$34,$34,$34,$31,$31,$31,$31
        db $24,$24,$24,$24,$21,$21,$21,$21
        db $31,$31,$81,$84,$84,$84,$84,$64
        db $c1,$c1,$61,$64,$64,$64,$64,$64
        ; 43 - Caja de cart¢n.
        db $b4,$b1,$b1,$b1,$b1,$b1,$b1,$b1
        db $b4,$b1,$b1,$b1,$b1,$b1,$b1,$b1
        db $b1,$b1,$a1,$a1,$a1,$a1,$a1,$e4
        db $b1,$b1,$a1,$a1,$a1,$a1,$a1,$e4
        ; 44 - M quina con zombie (sup. izq)
        db $f4,$f4,$f4,$f5,$75,$75,$75,$75
        db $f4,$f1,$f1,$f1,$f1,$fd,$fd,$fd
        db $75,$75,$75,$75,$75,$75,$75,$75
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        ; 45 - M quina con zombie (sup. der)
        db $f4,$f1,$f1,$f1,$f1,$fd,$fd,$fd
        db $f4,$f4,$f4,$f5,$75,$75,$75,$75
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $75,$75,$75,$75,$75,$75,$75,$75
        ; 46 - M quina con zombie (inf. izq)
        db $75,$75,$75,$75,$75,$75,$75,$75
        db $fd,$fd,$fd,$fd,$f1,$f1,$f1,$75
        db $73,$72,$71,$f1,$8e,$64,$61,$61
        db $73,$72,$71,$f1,$8e,$64,$61,$61
        ; 47 - M quina con zombie (inf. der)
        db $fd,$fd,$fd,$fd,$f1,$f1,$f1,$75
        db $75,$75,$75,$75,$75,$75,$75,$75
        db $79,$78,$71,$f1,$8e,$64,$61,$61
        db $79,$78,$71,$f1,$8e,$64,$61,$61
        ; 48 - Puerta este
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        db $e1,$e1,$e1,$e1,$e1,$e1,$e1,$e1
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1
        ; 49 - Vac¡o (para simplificar visualizaci¢n historia)
        db $f1,$f1,$f1,$e1,$e1,$e1,$e1,$e1
        db $e1,$e1,$e1,$e1,$f1,$f1,$f1,$f4
        db $e1,$e1,$e1,$e1,$f1,$f1,$f1,$f4
        db $11,$11,$11,$11,$11,$11,$11,$11
        
