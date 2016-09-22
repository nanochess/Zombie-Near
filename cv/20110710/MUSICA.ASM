        ;
        ; M£sica para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ; y Ad n Toledo Guti‚rrez (dos temas principales)
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;                    Ad n Toledo Guti‚rrez
        ;
        ; Creaci¢n: 13-ene-2011. Generado autom ticamente
        ; Revisi¢n: 23-abr-2011. Se elimina melod¡a de historia y de amor.
        ; Revisi¢n: 13-may-2011. Se vuelve a poner melod¡a de historia, pero
        ;                        reducida.
        ; Revisi¢n: 28-jun-2011. Se pone la melod¡a de historia completa y
        ;                        tambi‚n la melod¡a de amor.
        ; Revisi¢n: 29-jun-2011. Se restaura la tabla de notas, resulta que
        ;                        la melod¡a de amor usa los tonos bajos pero
        ;                        posteriormente duplica la frecuencia.
        ; 

        ; Tabla de notas
tabla_notas:
        ; Silencio - 0
        dw 0
        ; Octava 2 - 1
        dw 1721,1621,1532,1434,1364,1286,1216,1141,1076,1017,956,909
        ; Octava 3 - 13
        dw 854,805,761,717,678,639,605,571,538,508,480,453
        ; Octava 4 - 25
        dw 427,404,380,360,339,321,302,285,270,254,240,226
        ; Octava 5 - 37
        dw 214,202,191,180,170,160,151,143,135,127,120,113
        ; Octava 6 - 49
        dw 107,101,95,90,85,80,76,71,67,64,60,57
        ; Octava 7 - 61
        ; Solo caben dos notas m s.

ZZ:     equ 0           ; Silencio
SO:     equ $3f         ; Sostenido

FIN1:   equ $fe         ; Termina y queda en silencio
FIN2:   equ $fd         ; Repite melod¡a
FIN3:   equ $fc         ; Salta a melod¡a principal

C2:     equ 1
C2S:    equ 2
D2:     equ 3
D2S:    equ 4
E2:     equ 5
F2:     equ 6
F2S:    equ 7
G2:     equ 8
G2S:    equ 9
A2:     equ 10
A2S:    equ 11
B2:     equ 12

C3:     equ 13
C3S:    equ 14
D3:     equ 15
D3S:    equ 16
E3:     equ 17
F3:     equ 18
F3S:    equ 19
G3:     equ 20
G3S:    equ 21
A3:     equ 22
A3S:    equ 23
B3:     equ 24

C4:     equ 25
C4S:    equ 26
D4:     equ 27
D4S:    equ 28
E4:     equ 29
F4:     equ 30
F4S:    equ 31
G4:     equ 32
G4S:    equ 33
A4:     equ 34
A4S:    equ 35
B4:     equ 36

C5:     equ 37
C5S:    equ 38
D5:     equ 39
D5S:    equ 40
E5:     equ 41
F5:     equ 42
F5S:    equ 43
G5:     equ 44
G5S:    equ 45
A5:     equ 46
A5S:    equ 47
B5:     equ 48

C6:     equ 49

TA1:    equ $40         ; Tambor 1
TA2:    equ $80         ; Tambor 2

        ; Silencio
melodia_silencio:
        db 100,0,0,0
        db ZZ, ZZ, ZZ, ZZ, FIN1

        ; Esperando al monstruo
melodia_esperando:
        db  16 , 2 , 1 , 3 
        db  C4 , C4 , C4 , G4 
        db  G4 , G4 , F4 , F4 
        db  E4 , D4 , C4 , FIN2

        ; Triunfo
melodia_triunfo:
        db  10 , 5 , 4 ,-4 
        db  C4 , E4 , G4 , C5 
        db  E5 , G5 , ZZ , ZZ 
        db  ZZ , ZZ , ZZ , ZZ
        db FIN3

        ; Fracaso
melodia_fracaso:
        db  20 , 2 , 2 , 2 
        db  G4 , E4 , C4 , ZZ 
        db  ZZ , ZZ , ZZ , ZZ
        db  ZZ , FIN3

        ; Avance
melodia_avance:
        db  10 , 4 , 3 ,-3 
        db  C4 , F4 , D4 , G4 
        db  E4 , ZZ , ZZ , ZZ 
        db  ZZ , ZZ , ZZ , FIN3

        ; Batalla
melodia_batalla:
        db  6 , 12 ,-12 , 12 
        db  C4 , A4S, D4S, E4 
        db  F4S, F4 , E4 , D4S 
        db  D4 , C5 , F4 , F4S 
        db  G4S, G4 , F4S, F4 
        db  C4 , A4 , D4 , G4 
        db  F4 , D4 , G4 , C4 
        db  E4 , C4S, F4S, B4 
        db  G4 , E4 , A4 , D4 
        db  C4 , F4 , E4 , A4 
        db FIN2

        ; Final
melodia_final:
        db  20 , 4 , 3 ,-3 
        db  C4 , F4 , G4 , A4 
        db  E5 , C5 , A4 , FIN1

        ; Historia
melodia_historia:
        db  6 , 12 ,-12 , 12
        ; Investigadora
        db G4 ,G4 OR TA2
        db C5 ,SO OR TA1
        db E5 ,SO OR TA1
        db C5 ,SO OR TA1
        db G4 ,E5 OR TA2
        db C5 ,SO OR TA1
        db E5 ,SO OR TA1
        db C5 ,SO OR TA1
        db G4 ,ZZ OR TA2
        db C5 ,ZZ OR TA1
        db E5 ,ZZ OR TA1
        db C5 ,ZZ OR TA1
        db G4 ,ZZ OR TA2
        db C5 ,ZZ OR TA1
        db E5 ,ZZ OR TA1
        db C5 ,ZZ OR TA1

        ; Jefe
        db G4 ,G4 OR TA2
        db C5 ,SO OR TA1
        db D5S,SO OR TA1
        db C5 ,SO OR TA1
        db G4 ,D5S OR TA2
        db C5 ,SO OR TA1
        db D5S,SO OR TA1
        db C5 ,SO OR TA1
        db G4 ,ZZ OR TA2
        db C5 ,ZZ OR TA1
        db D5S,ZZ OR TA1
        db C5 ,ZZ OR TA1
        db G4 ,ZZ OR TA2
        db C5 ,ZZ OR TA1
        db D5S,ZZ OR TA1
        db C5 ,ZZ OR TA1

        ; Edificio
        db G4 ,G4 OR TA2
        db B4 ,SO OR TA1
        db D5 ,SO OR TA1
        db B4 ,SO OR TA1
        db G4 ,D5 OR TA2
        db B4 ,SO OR TA1
        db D5 ,SO OR TA1
        db B4 ,SO OR TA1
        db G4 ,ZZ OR TA2
        db B4 ,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db B4 ,ZZ OR TA1
        db G4 ,ZZ OR TA2
        db B4 ,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db B4 ,ZZ OR TA1

        ; Investigadora
        db G4 ,ZZ OR TA2
        db A4S,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db A4S,ZZ OR TA1
        db G4 ,G4 OR TA2
        db A4S,SO OR TA1
        db D5 ,SO OR TA1
        db A4S,SO OR TA1
        db G4 ,D5 OR TA2
        db A4S,SO OR TA1
        db D5 ,SO OR TA1
        db A4S,SO OR TA1
        db G4 ,ZZ OR TA2
        db A4S,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db A4S,ZZ OR TA1

        ; Jefe
        db G4 ,ZZ OR TA2
        db B4 ,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db B4 ,ZZ OR TA1
        db G4 ,G4 OR TA2
        db B4 ,SO OR TA1
        db D5 ,SO OR TA1
        db B4 ,SO OR TA1
        db G4 ,D5 OR TA2
        db B4 ,SO OR TA1
        db D5 ,SO OR TA1
        db B4 ,SO OR TA1
        db G4 ,ZZ OR TA2
        db B4 ,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db B4 ,ZZ OR TA1

        ; Pregunta
        db G4 ,ZZ OR TA2
        db A4S,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db A4S,ZZ OR TA1
        db G4 ,G4 OR TA2
        db A4S,SO OR TA1
        db D5 ,SO OR TA1
        db A4S,SO OR TA1
        db G4 ,D5 OR TA2
        db A4S,SO OR TA1
        db D5 ,SO OR TA1
        db A4S,SO OR TA1
        db G4 ,ZZ OR TA2
        db A4S,ZZ OR TA1
        db D5 ,ZZ OR TA1
        db A4S,ZZ OR TA1

        ; Zombies
        db F4S,F4S OR TA2
        db A4 ,SO  OR TA1
        db D5S,SO  OR TA1
        db A4 ,SO  OR TA1
        db F4S,D5S OR TA2
        db A4 ,SO  OR TA1
        db D5S,SO  OR TA1
        db A4 ,SO  OR TA1
        db F4S,ZZ  OR TA2
        db A4 ,ZZ  OR TA1
        db D5S,ZZ  OR TA2
        db A4 ,ZZ  OR TA2

        ; Telefonista
        db A4 ,A4  OR TA2
        db C5S,SO  OR TA1
        db E5 ,SO  OR TA1
        db C5S,SO  OR TA1
        db A4 ,E5  OR TA2
        db C5S,SO  OR TA1
        db E5 ,SO  OR TA1
        db C5S,SO  OR TA1
        db A4 ,ZZ  OR TA2
        db C5S,ZZ  OR TA1
        db E5 ,ZZ  OR TA1
        db C5S,ZZ  OR TA1
        db A4 ,ZZ  OR TA2
        db C5S,ZZ  OR TA1
        db E5 ,ZZ  OR TA2
        db C5S,ZZ  OR TA2

        ; Delta-1
        db A4 ,A4  OR TA2
        db C5 ,SO  OR TA1
        db F5 ,SO  OR TA1
        db C5 ,SO  OR TA1
        db A4 ,F5  OR TA2
        db C5 ,SO  OR TA1
        db F5 ,SO  OR TA1
        db C5 ,SO  OR TA1
        db A4 ,ZZ  OR TA2
        db C5 ,ZZ  OR TA1
        db F5 ,ZZ  OR TA2
        db C5 ,ZZ  OR TA2

        ; Delta-2
        db G4S,G4S OR TA2
        db C5 ,SO  OR TA1
        db F5 ,SO  OR TA1
        db C5 ,SO  OR TA1
        db G4S,F5  OR TA2
        db C5 ,SO  OR TA1
        db F5 ,SO  OR TA1
        db C5 ,SO  OR TA1
        db G4S,ZZ  OR TA2
        db C5 ,ZZ  OR TA1
        db F5 ,ZZ  OR TA1
        db C5 ,ZZ  OR TA1

        db D4 ,D4  OR TA2
        db G4 ,SO  OR TA2
        db D5 ,SO  OR TA2
        db G4 ,SO  OR TA2

        db ZZ ,ZZ
        db ZZ ,ZZ
        db ZZ ,ZZ
        db ZZ ,ZZ

        db FIN1,ZZ

        ; Tema principal
melodia_principal:
        db  6 , 0 , 0 , 0
        ; 0
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA2
        ; 1
        db  C5 , C5  OR TA2,G5 , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 2
        db  A4S, A4  OR TA2,G5 , A4  OR TA1, ZZ , A4  OR TA1, ZZ , A4  OR TA1
        db  ZZ , A4  OR TA2,ZZ , A4  OR TA1, ZZ , A4  OR TA1, ZZ , A4  OR TA1
        ; 3
        db  C5 , C5  OR TA2,G5 , C5  OR TA1, C6 , C5  OR TA1, ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 4
        db  A4S, A4  OR TA2,G5 , A4  OR TA1, C6 , A4  OR TA1, ZZ , A4  OR TA1
        db  ZZ , A4  OR TA2,ZZ , A4  OR TA1, ZZ , A4  OR TA1, ZZ , A4  OR TA1
        ; 5
        db  C5 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, G5 , C5  OR TA1
        db  SO , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 6
        db  B4 , B4  OR TA2,G5 , B4  OR TA1, F5S, B4  OR TA1, G5 , B4  OR TA1
        db  SO , B4  OR TA2,ZZ , B4  OR TA1, ZZ , B4  OR TA1, ZZ , B4  OR TA1
        ; 7
        db  A4S, A4S OR TA2,G5 , A4S OR TA1, F5S, A4S OR TA1, G5 , A4S OR TA1 
        db  SO , A4S OR TA2,ZZ , A4S OR TA1, ZZ , A4S OR TA1, ZZ , A4S OR TA1
        ; 8
        db  C5 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, G5 , C5  OR TA1
        db  SO , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 9
        db  B4 , B4  OR TA2,G5 , B4  OR TA1, F5S, B4  OR TA1, G5 , B4  OR TA1
        db  SO , B4  OR TA2,ZZ , B4  OR TA1, ZZ , B4  OR TA1, ZZ , B4  OR TA1
        ; 10
        db  A4S, A4S OR TA2,G5 , A4S OR TA1, F5S, A4S OR TA1, G5 , A4S OR TA1
        db  SO , A4S OR TA2,ZZ , A4S OR TA1, ZZ , A4S OR TA1, ZZ , A4S OR TA1
        ; 11
        db  C5 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, G5 , C5  OR TA1
        db  A5S, C5  OR TA2,A5 , C5  OR TA1, G5S, C5  OR TA1, G5 , C5  OR TA1
        ; 12
        db  F5S, C5  OR TA2,G5 , C5  OR TA1, SO , C5  OR TA1, ZZ , C5  OR TA1
        db  A4 , A4  OR TA2,G5 , A4  OR TA1, F5S, A4  OR TA1, G5 , A4  OR TA1
        ; 13
        db  A5S, A4  OR TA2,A5 , A4  OR TA1, G5S, A4  OR TA1, G5 , A4  OR TA1
        db  F5S, A4  OR TA2,G5 , A4  OR TA1, SO , A4  OR TA1, ZZ , A4  OR TA1
        ; 14
        db  C5 , C5  OR TA2,SO , C5  OR TA1, SO , C5  OR TA1, SO , C5  OR TA1
        db  G5 , G5  OR TA2,SO , G5  OR TA1, SO , G5  OR TA1, SO , G5  OR TA1
        ; 15
        db  F5S, F5S OR TA2,SO , F5S OR TA1, SO , F5S OR TA1, SO , F5S OR TA1
        db  ZZ , F5S OR TA2,ZZ , F5S OR TA1, ZZ , F5S OR TA1, ZZ , F5S OR TA1
        ; 16
        db  C5 , C5  OR TA2,SO , C5  OR TA1, SO , C5  OR TA1, SO , C5  OR TA1
        db  G5 , G5  OR TA2,SO , G5  OR TA1, SO , G5  OR TA1, SO , G5  OR TA1
        ; 17
        db  G5S, G5S OR TA2,SO , G5S OR TA1, SO , G5S OR TA1, SO , G5S OR TA1 
        db  ZZ , G5S OR TA2,ZZ , G5S OR TA1, ZZ , G5S OR TA1, ZZ , G5S OR TA1
        ; 18
        db  C5 , C5  OR TA2,F5S, C5  OR TA1, G5 , C5  OR TA1, G5S, C5  OR TA1
        db  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 19
        db  C6 , C5  OR TA2,G5S, C5  OR TA1, G5 , C5  OR TA1, F5S, C5  OR TA1
        db  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 20
        db  C5 , C5  OR TA2,F5S, C5  OR TA1, G5 , C5  OR TA1, ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        ; 21
        db  C6 , C5  OR TA2,G5 , C5  OR TA1, F5S, C5  OR TA1, ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2,ZZ , C5  OR TA1, ZZ , C5  OR TA1, ZZ , C5  OR TA1
        db  FIN2

        ; Tema 2
melodia_2:
        db 6, 0, 0, 0
        ; 0
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA1
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA2
        db  ZZ , C5  OR TA2
        ; 1
        db C5 , C5  OR TA2
        db C5 , SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db C5 , SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 2
        db C5 , C5  OR TA2
        db C5 , SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db C5 , SO  OR TA2
        db G5 , SO  OR TA1 
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 3
        db A4S, A4S OR TA2
        db A4S, SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db A4S, SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 4
        db A4S, A4S OR TA2
        db A4S, SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db A4S, SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 5
        db G4S, C5  OR TA2
        db G4S, SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db G4S, SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 6
        db G4S, C5  OR TA2
        db G4S, SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db G4S, SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 7
        db G4 , A4S OR TA2
        db G4 , SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db G4 , SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 8
        db G5 , G5  OR TA2
        db G5S, SO  OR TA1
        db G5 , SO  OR TA1
        db F5 , SO  OR TA1
        db D5S, C5  OR TA2
        db D5 , SO  OR TA1
        db C5 , SO  OR TA1
        db SO , SO  OR TA1
        ; 8.5
        db ZZ , C5  OR TA2
        db ZZ , SO  OR TA1
        db ZZ , SO  OR TA2
        db ZZ , SO  OR TA2
        ; 9
        db C5 , C5  OR TA2
        db SO , SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db C5 , SO  OR TA2
        db SO , SO  OR TA1
        db C5 , SO  OR TA1
        db C5 , SO  OR TA1
        ; 10
        db D5S, D5S OR TA2
        db SO , SO  OR TA1
        db C5 , SO  OR TA1
        db SO , SO  OR TA1
        db D5 , SO  OR TA2
        db SO , SO  OR TA1
        db A4S, SO  OR TA1
        db A4S, SO  OR TA1
        ; 11
        db D5 , D5  OR TA2
        db SO , SO  OR TA1
        db A4S, SO  OR TA1
        db A4S, SO  OR TA1
        db D5 , SO  OR TA2
        db SO , SO  OR TA1
        db A4S, SO  OR TA1
        db SO , SO  OR TA1
        ; 12
        db F5 , F5  OR TA2
        db SO , SO  OR TA1
        db G4S, SO  OR TA1
        db SO , SO  OR TA1
        db F5 , SO  OR TA2
        db SO , SO  OR TA1
        db G4S, SO  OR TA1
        db G4S, SO  OR TA1
        ; 13
        db F5 , F5  OR TA2
        db SO , SO  OR TA1
        db G4S, SO  OR TA1
        db SO , SO  OR TA1
        db F4S, SO  OR TA2
        db C5 , SO  OR TA1
        db F4S, SO  OR TA1
        db D5 , SO  OR TA1
        ; 13.5
        db SO , C5  OR TA2
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 14
        db D5 , D5  OR TA2
        db D5S, SO  OR TA1
        db D5 , SO  OR TA1
        db C5 , SO  OR TA1
        db A4S, SO  OR TA2
        db D5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 15      
        db A4S, C5  OR TA2
        db A4S, SO  OR TA1
        db C5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA2
        db ZZ , SO  OR TA1
        db ZZ , SO  OR TA2
        db ZZ , SO  OR TA2
        ; 16
        db G5 , G5  OR TA2
        db G5 , SO  OR TA1
        db G5S, SO  OR TA1
        db G5 , SO  OR TA1
        db SO , SO  OR TA2
        db A5S, SO  OR TA1
        db SO , SO  OR TA1
        db G5S, SO  OR TA1
        ; 17
        db G5 , F5  OR TA2
        db F5 , SO  OR TA1
        db SO , SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA2
        db F5 , SO  OR TA1
        db SO , SO  OR TA1
        db C5 , SO  OR TA1
        ; 18
        db SO , SO  OR TA2
        db C5 , C5  OR TA1
        db ZZ , SO  OR TA1
        db ZZ , SO  OR TA1
        db C5 , SO  OR TA2
        db D5S, SO  OR TA1
        db C5 , SO  OR TA1
        db D5 , SO  OR TA1
        ; 19
        db A4S, D5  OR TA2
        db SO , SO  OR TA1
        db D5 , SO  OR TA1
        db D5 , SO  OR TA1
        db D5S, SO  OR TA2
        db D5 , SO  OR TA1
        db C5 , SO  OR TA1
        db A4S, SO  OR TA1
        ; 20
        db D5 , D5  OR TA2
        db A4S, SO  OR TA1
        db C5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , C5  OR TA2
        db ZZ , SO  OR TA1
        db ZZ , SO  OR TA1
        db ZZ , SO  OR TA1
        db FIN2

        ; Tema de amor
melodia_amor:
        db  8 , 12 ,-12 , 12
        ; 1
        db D4 , ZZ
        ; 2
        db B4 , G3
        db B3 , SO
        db D4 , SO
        ; 3
        db G4 , SO
        db D4 , SO
        db B3 , SO
        ; 4
        db B4 , F3S
        db B3 , SO
        db D4S, SO
        ; 5
        db A4 , SO
        db D4S, SO
        db B3 , SO
        ; 6
        db B4 , E3
        db B3 , SO
        db D4 , SO
        ; 7
        db G4S, E2
        db E4 , SO
        db D4 , SO
        ; 8
        db B4 , A2
        db SO , E3
        db SO , G3
        ; 9
        db E4 , B3
        db SO , G3
        db E4 , E3
        ; 10
        db E4 , D3
        db F4S, SO
        db G4 , SO
        ; 11
        db B4 , D2
        db F4S, SO
        db A4 , SO
        ; 12
        db G4 , G2
        db SO , SO
        db SO , D3
        ; 13
        db SO , G3
        db SO , SO
        db FIN1

