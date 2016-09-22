        ;
        ; Gr ficas para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ; El dibujo de la maceta es cortes¡a de Ad n Toledo Guti‚rrez
        ;
        ; Creaci¢n: 06-ene-2011.
        ; Revisi¢n: 26-mar-2011. Las letras vuelven a este m¢dulo.
        ; Revisi¢n: 27-mar-2011. Se comprime el color.
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
indice_color_letras:
        db 0,0,0,0
        db 0,0,0,0
        db 0,0,0,0
        db 0,0,0,0
        db 0,0,0,0
        db 0,0,0,0
        db 0,0,0,1
        db 2,1,2,3
        db 4,4,4,4
        db 4,4,4,4
        db 4,4,5,0
        db 0,6,0,0
        db 7,4,4,4
        db 4,0,0,0

color_letras:
        db $31,$31,$31,$31,$31,$21,$21,$21
        db $F8,$F8,$F9,$F9,$F8,$F8,$F6,$F8
        db $F4,$F4,$F5,$F5,$F4,$F4,$F1,$F4
        db $F1,$F1,$F1,$F1,$F1,$F1,$F1,$F1
        db $F1,$F1,$F1,$F1,$F1,$E1,$E1,$E1
        db $11,$91,$81,$81,$81,$81,$61,$11
        db $B1,$B1,$B1,$B1,$A1,$A1,$A1,$A1
        db $31,$31,$21,$31,$31,$21,$21,$21

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
        db $08,$08,$08,$ff,$80,$80,$80,$ff      ; Disponible para reusar
        ; 05 - Uni¢n pared norte y oeste
        db $ff,$80,$80,$80,$ff,$88,$88,$88
        db $ff,$80,$80,$80,$ff,$08,$08,$08      ; Disponible si se usa 1,0
        db $f8,$88,$88,$88,$8f,$88,$88,$88      ; Disponible si se usa 2,0
        db $FF,$80,$BF,$A8,$AF,$B8,$AB,$AB
        ; 06 - Uni¢n pared norte y este
        db $ff,$80,$80,$80,$ff,$08,$08,$08      ; Disponible si se usa 1,0
        db $ff,$81,$81,$81,$f1,$11,$11,$11
        db $ff,$81,$fd,$0d,$f7,$9d,$f5,$d5
        db $1f,$11,$11,$11,$f1,$11,$11,$11      ; Disponible si se usa 3,1
        ; 07 - Uni¢n pared sur y oeste
        db $f8,$88,$88,$88,$8f,$88,$88,$88      ; Disponible si se usa 2,0
        db $ea,$ab,$a8,$af,$a8,$bf,$80,$ff
        db $88,$88,$88,$ff,$80,$80,$80,$ff
        db $08,$08,$08,$ff,$80,$80,$80,$ff      ; Disponible si se usa 4,2
        ; 08 - Uni¢n pared sur y este
        db $57,$d5,$95,$f5,$0d,$fd,$81,$ff
        db $1F,$11,$11,$11,$F1,$11,$11,$ff
        db $08,$08,$08,$ff,$80,$80,$80,$ff      ; Disponible si se usa 4,2
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
        db $ff,$02,$04,$08,$10,$20,$40,$80      ; Repetido
        db $ff,$0c,$30,$c0,$03,$0c,$30,$c0
        db $ff,$0c,$30,$c0,$03,$0c,$30,$c0      ; Repetido
        ; 13 - Pared oeste
        db $81,$82,$84,$88,$90,$a0,$c0,$80      
        db $88,$88,$c4,$c4,$a2,$a2,$91,$91
        db $81,$82,$84,$88,$90,$a0,$c0,$80      ; Repetido
        db $88,$88,$c4,$c4,$a2,$a2,$91,$91      ; Repetido
        ; 14 - Pared este
        db $11,$11,$23,$23,$45,$45,$89,$89
        db $01,$03,$05,$09,$11,$21,$41,$81
        db $11,$11,$23,$23,$45,$45,$89,$89      ; Repetido
        db $01,$03,$05,$09,$11,$21,$41,$81      ; Repetido
        ; 15 - Pared sur
        db $03,$0c,$30,$c0,$03,$0c,$30,$ff
        db $03,$0c,$30,$c0,$03,$0c,$30,$ff      ; Repetido
        db $01,$02,$04,$08,$10,$20,$40,$ff
        db $01,$02,$04,$08,$10,$20,$40,$ff      ; Repetido
        ; 16 - Uni¢n pared norte y oeste
        db $ff,$82,$84,$88,$90,$a0,$c0,$80
        db $ff,$02,$04,$08,$10,$20,$40,$80      ; Repetido
        db $81,$82,$84,$88,$90,$a0,$c0,$80
        db $ff,$cc,$f0,$d0,$ab,$a4,$92,$91
        ; 17 - Uni¢n pared norte y este
        db $ff,$02,$04,$08,$10,$20,$40,$80      ; Repetido
        db $ff,$03,$05,$09,$11,$21,$41,$81
        db $ff,$0f,$37,$cb,$15,$25,$49,$89
        db $01,$03,$05,$09,$11,$21,$41,$81      ; Repetido
        ; 18 - Uni¢n pared sur y oeste
        db $81,$82,$84,$88,$90,$a0,$c0,$80
        db $89,$8a,$c4,$c8,$b3,$ac,$f0,$ff
        db $81,$82,$84,$88,$90,$a0,$c0,$ff
        db $01,$02,$04,$08,$10,$20,$40,$ff      ; Repetido
        ; 19 - Uni¢n pared sur y este
        db $91,$51,$23,$d3,$0d,$05,$33,$ff
        db $01,$03,$05,$09,$11,$21,$41,$81      ; Repetido
        db $01,$02,$04,$08,$10,$20,$40,$ff      ; Repetido
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
        db $00,$00,$11,$77,$00,$00,$11,$77      ; Disponible para reusar
        db $00,$00,$11,$77,$00,$00,$11,$77
        db $00,$00,$11,$77,$00,$00,$11,$77      ; Disponible para reusar
        ; 39 - Transportador (4)
        db $33,$11,$11,$00,$33,$11,$11,$00
        db $33,$11,$11,$00,$33,$11,$11,$00      ; Disponible para reusar
        db $33,$11,$11,$00,$33,$11,$11,$00
        db $33,$11,$11,$00,$33,$11,$11,$00      ; Disponible para reusar
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
        ; 43 - Caja de cart¢n.
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
        db $00,$00,$00,$00,$00,$00,$00,$00      ; Repetido
        db $00,$00,$00,$00,$00,$00,$00,$00      ; Repetido
        db $00,$00,$00,$00,$00,$00,$00,$00      ; Repetido
        db $00,$00,$00,$00,$00,$00,$00,$00

indice_graf_color:
        db 0,1,0,2
        db 3,4,5,6
        db 7,5,0,0
        db 5,7,0,0
        db 5,8,9,9
        db 10,11,7,5
        db 10,10,5,7
        db 7,5,12,12
        db 5,7,12,12
        db 0,0,0,0
        db 0,0,0,0
        db 0,0,0,0
        db 13,13,14,14
        db 15,14,15,14
        db 14,15,14,15
        db 14,14,13,13
        db 13,13,15,14
        db 13,13,14,15
        db 15,14,13,13
        db 14,15,13,13
        db 16,17,16,17
        db 16,16,18,18
        db 17,17,19,19
        db 20,21,4,22
        db 23,23,4,4
        db 24,25,26,27
        db 28,28,29,30
        db 31,31,32,32
        db 33,33,34,34
        db 33,33,34,34
        db 35,35,36,36
        db 37,38,39,40
        db 41,41,42,42
        db 41,41,42,42
        db 43,44,45,45
        db 46,47,48,49
        db 50,51,52,53
        db 50,54,52,55
        db 50,50,52,52
        db 50,50,52,52
        db 56,56,16,16
        db 57,58,59,60
        db 61,62,54,55
        db 63,63,64,64
        db 65,66,67,16
        db 66,65,16,67
        db 67,68,69,69
        db 68,67,70,70
        db 17,16,17,16
        db 71,71,71,71

graf_color:
        db $54,$54,$54,$54,$54,$54,$54,$54
        db $E1,$E1,$E1,$EF,$EF,$EF,$EF,$EF
        db $E1,$E1,$E1,$E1,$E1,$E1,$E9,$E9
        db $E8,$E9,$E8,$E6,$E8,$E9,$E8,$E6
        db $EF,$EF,$EF,$F1,$E1,$E1,$E1,$E4
        db $E6,$E6,$E6,$E6,$E6,$E6,$E6,$E6
        db $E9,$E6,$E6,$F1,$E1,$E1,$E1,$E4
        db $E8,$E8,$E8,$E8,$E8,$E8,$E8,$E8
        db $1F,$1F,$FC,$FC,$EF,$EF,$EF,$EF
        db $E9,$E8,$E6,$E8,$E9,$E8,$E6,$E8
        db $E8,$E9,$E8,$E8,$E8,$E9,$E8,$E8
        db $E8,$E9,$E8,$E8,$E8,$E8,$E8,$E8
        db $E9,$E8,$E8,$E8,$E9,$E8,$E8,$E8
        db $C3,$C3,$C3,$C3,$C2,$C2,$C2,$C2
        db $1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C
        db $C2,$C2,$C2,$C2,$C2,$C2,$C2,$C2
        db $F1,$F1,$F1,$F1,$F1,$F1,$F1,$F1
        db $E1,$E1,$E1,$E1,$E1,$E1,$E1,$E1
        db $E1,$E1,$E1,$E1,$E1,$E1,$E1,$54
        db $E1,$E1,$E1,$F1,$E1,$E1,$E1,$E4
        db $E1,$EF,$EF,$EF,$EF,$EF,$EF,$EF
        db $E1,$EF,$EF,$EF,$E6,$E6,$E6,$E6
        db $E6,$E6,$E6,$F1,$E1,$E1,$E1,$E4
        db $1F,$1F,$1F,$1F,$EF,$EF,$EF,$EF
        db $E1,$E1,$ED,$ED,$ED,$ED,$ED,$E5
        db $E1,$E1,$E1,$E1,$E8,$E8,$E8,$E8
        db $ED,$ED,$E1,$F1,$E1,$E1,$E1,$E4
        db $E9,$E8,$E8,$F1,$E1,$E1,$E1,$E4
        db $F1,$91,$91,$91,$91,$81,$8F,$8F
        db $8F,$81,$81,$81,$81,$81,$81,$64
        db $81,$81,$81,$81,$81,$81,$81,$64
        db $F1,$B1,$B1,$B1,$A1,$A1,$A1,$A1
        db $A1,$A1,$A1,$A1,$A1,$A1,$A1,$A4
        db $F1,$F1,$71,$71,$71,$71,$71,$71
        db $51,$51,$51,$51,$51,$51,$41,$41
        db $F1,$E1,$E1,$E1,$E1,$E1,$E1,$E1
        db $F1,$F1,$F1,$F1,$F4,$14,$E4,$E4
        db $F1,$E1,$E1,$E3,$E1,$ED,$E1,$00
        db $F1,$E1,$E1,$E6,$E1,$EA,$E1,$00
        db $F1,$F8,$F2,$F4,$F1,$E1,$E1,$E4
        db $F1,$F4,$F8,$F2,$F1,$E1,$E1,$E4
        db $EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF
        db $EF,$EF,$EF,$EF,$EF,$F1,$E1,$E4
        db $11,$2F,$CF,$CF,$C6,$CF,$CF,$CF
        db $11,$2F,$CF,$CF,$CF,$CF,$CF,$CF
        db $CF,$CE,$CF,$E1,$E1,$E1,$E1,$E4
        db $F1,$E1,$E1,$E4,$E1,$E2,$E1,$00
        db $F1,$E1,$E1,$E7,$E1,$E9,$E1,$00
        db $F1,$F9,$F3,$F5,$F1,$E1,$E1,$E4
        db $F1,$F5,$F9,$F3,$F1,$E1,$E1,$E4
        db $D1,$D1,$31,$31,$91,$91,$51,$51
        db $84,$84,$84,$81,$81,$81,$81,$61
        db $A1,$A1,$81,$81,$41,$41,$21,$21
        db $84,$84,$81,$81,$81,$61,$C1,$C1
        db $31,$31,$81,$84,$84,$84,$84,$64
        db $C1,$C1,$61,$64,$64,$64,$64,$64
        db $54,$E1,$E1,$E1,$E1,$E1,$E1,$E1
        db $E1,$E9,$18,$18,$18,$18,$18,$18
        db $E1,$E1,$11,$18,$16,$16,$16,$16
        db $E8,$E6,$E1,$F1,$E1,$E1,$E1,$E4
        db $E6,$E6,$E6,$F6,$E1,$E1,$E1,$E4
        db $34,$34,$34,$34,$31,$31,$31,$31
        db $24,$24,$24,$24,$21,$21,$21,$21
        db $B4,$B1,$B1,$B1,$B1,$B1,$B1,$B1
        db $B1,$B1,$A1,$A1,$A1,$A1,$A1,$E4
        db $F4,$F4,$F4,$F5,$75,$75,$75,$75
        db $F4,$F1,$F1,$F1,$F1,$FD,$FD,$FD
        db $75,$75,$75,$75,$75,$75,$75,$75
        db $FD,$FD,$FD,$FD,$F1,$F1,$F1,$75
        db $73,$72,$71,$F1,$8E,$64,$61,$61
        db $79,$78,$71,$F1,$8E,$64,$61,$61
        db $11,$11,$11,$11,$11,$11,$11,$11
