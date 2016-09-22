        ;
        ; M£sica para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ; y Ad n Toledo Guti‚rrez (tema principal)
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;                    Ad n Toledo Guti‚rrez
        ;
        ; Creaci¢n: 13-ene-2011. Generado autom ticamente
        ; Revisi¢n: 22-ene-2011. Redondea las frecuencias.
        ;

        ; Tabla de notas
tabla_notas:
        dw 0 , 1721 , 1621 , 1532 , 1434 , 1364 , 1286 , 1216 
        dw 1141 , 1076 , 1017 , 956 , 909 , 854 , 805 , 761 
        dw 717 , 678 , 639 , 605 , 571 , 538 , 508 , 480 
        dw 453 , 427 , 404 , 380 , 360 , 339 , 321 , 302 
        dw 285 , 270 , 254 , 240 , 226 , 214 , 202 , 191 
        dw 180 , 170 , 160 , 151 , 143 , 135 , 127 , 120 
        dw 113 , 107 , 101 , 95 , 90 , 85 , 80 , 76 
        dw 71 , 67 , 64 , 60 , 57 

        ; Esperando al monstruo
melodia_esperando:
        db  16 , 2 , 1 , 3 
        db  25 , 25 , 25 , 32 
        db  32 , 32 , 30 , 30 
        db  29 , 27 , 25 ,-2 

        ; Triunfo
melodia_triunfo:
        db  10 , 5 , 4 ,-4 
        db  25 , 29 , 32 , 37 
        db  41 , 44 , 0 , 0 
        db  0 ,-3 

        ; Fracaso
melodia_fracaso:
        db  20 , 2 , 2 , 2 
        db  32 , 29 , 25 , 0 
        db  0 , 0 ,-3 

        ; Avance
melodia_avance:
        db  10 , 4 , 3 ,-3 
        db  25 , 30 , 27 , 32 
        db  29 , 0 , 0 , 0 
        db -3 

        ; Batalla
melodia_batalla:
        db  6 , 12 ,-12 , 12 
        db  25 , 35 , 28 , 29 
        db  31 , 30 , 29 , 28 
        db  27 , 37 , 30 , 31 
        db  33 , 32 , 31 , 30 
        db  25 , 34 , 27 , 32 
        db  30 , 27 , 32 , 25 
        db  29 , 26 , 31 , 36 
        db  32 , 29 , 34 , 27 
        db  25 , 30 , 29 , 34 
        db -2 

        ; Final
melodia_final:
        db  20 , 4 , 3 ,-3 
        db  25 , 30 , 32 , 34 
        db  41 , 37 , 34 ,-1 

        ; Historia
melodia_historia:
        db  6 , 12 ,-12 , 12 
        db  32 , 37 , 41 , 37 
        db  32 , 37 , 41 , 37 
        db  32 , 37 , 41 , 37 
        db  32 , 37 , 41 , 37 
        db  32 , 37 , 40 , 37 
        db  32 , 37 , 40 , 37 
        db  32 , 37 , 40 , 37 
        db  32 , 37 , 40 , 37 
        db  32 , 36 , 39 , 36 
        db  32 , 36 , 39 , 36 
        db  32 , 36 , 39 , 36 
        db  32 , 36 , 39 , 36 
        db  32 , 35 , 39 , 35 
        db  32 , 35 , 39 , 35 
        db  32 , 35 , 39 , 35 
        db  32 , 35 , 39 , 35 
        db  32 , 36 , 39 , 36 
        db  32 , 36 , 39 , 36 
        db  32 , 36 , 39 , 36 
        db  32 , 36 , 39 , 36 
        db  32 , 35 , 39 , 35 
        db  32 , 35 , 39 , 35 
        db  32 , 35 , 39 , 35 
        db  32 , 35 , 39 , 35 
        db  31 , 34 , 40 , 34 
        db  31 , 34 , 40 , 34 
        db  31 , 34 , 40 , 34 
        db  34 , 38 , 41 , 38 
        db  34 , 38 , 41 , 38 
        db  34 , 38 , 41 , 38 
        db  34 , 38 , 41 , 38 
        db  34 , 37 , 42 , 37 
        db  34 , 37 , 42 , 37 
        db  34 , 37 , 42 , 37 
        db  33 , 37 , 42 , 37 
        db  33 , 37 , 42 , 37 
        db  33 , 37 , 42 , 37 
        db  27 , 32 , 39 , 32 
        db -1 

        ; Tema principal
melodia_principal:
        db  6 , 0 , 0 , 0 
        db  37 , 44 , 0 , 0 
        db  0 , 0 , 0 , 0 
        db  35 , 44 , 0 , 0 
        db  0 , 0 , 0 , 0 
        db  37 , 44 , 49 , 0 
        db  0 , 0 , 0 , 0 
        db  35 , 44 , 49 , 0 
        db  0 , 0 , 0 , 0 
        db  37 , 44 , 43 , 44 
        db  44 , 0 , 0 , 0 
        db  36 , 44 , 43 , 44 
        db  44 , 0 , 0 , 0 
        db  35 , 44 , 43 , 44 
        db  44 , 0 , 0 , 0 
        db  37 , 44 , 43 , 44 
        db  44 , 0 , 0 , 0 
        db  36 , 44 , 43 , 44 
        db  44 , 0 , 0 , 0 
        db  35 , 44 , 43 , 44 
        db  44 , 0 , 0 , 0 
        db  37 , 44 , 43 , 44 
        db  47 , 46 , 45 , 44 
        db  43 , 44 , 44 , 0 
        db  34 , 44 , 43 , 44 
        db  47 , 46 , 45 , 44 
        db  43 , 44 , 44 , 0 
        db  37 , 37 , 37 , 37 
        db  44 , 44 , 44 , 44 
        db  43 , 43 , 43 , 43 
        db  0 , 0 , 0 , 0 
        db  37 , 37 , 37 , 37 
        db  44 , 44 , 44 , 44 
        db  45 , 45 , 45 , 45 
        db  0 , 0 , 0 , 0 
        db  37 , 43 , 44 , 45 
        db  0 , 0 , 0 , 0 
        db  49 , 45 , 44 , 43 
        db  0 , 0 , 0 , 0 
        db  37 , 43 , 44 , 0 
        db  0 , 0 , 0 , 0 
        db  49 , 44 , 43 , 0 
        db  0 , 0 , 0 , 0 
        db -2 
