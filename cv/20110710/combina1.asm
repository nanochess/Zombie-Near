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
        db $ff,$00,$7f,$d5,$ff,$d5,$ff,$00
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

