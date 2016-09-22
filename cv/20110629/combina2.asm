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
        
