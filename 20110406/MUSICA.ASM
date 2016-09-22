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
        ; Revisi¢n: 22-ene-2011. Redondea las frecuencias.
        ; Revisi¢n: 30-mar-2011. Se pone aqu¡ la segunda voz de la historia y
        ;                        el bajo del tema principal. A partir de 
        ;                        ahora este archivo se edita manualmente. Se
        ;                        integra otro tema musical de Ad n para
        ;                        alternar entre mapas.
        ; Revisi¢n: 31-mar-2011. Se pone aqu¡ la melod¡a de silencio. En la
        ;                        segunda voz se agrega informaci¢n de ritmo.
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
        db ZZ, ZZ, ZZ, ZZ,-1

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
        db G4S, G4S OR TA2
        db G4S, SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db G4S, SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 6
        db G4S, G4S OR TA2
        db G4S, SO  OR TA1
        db D5S, SO  OR TA1
        db SO , SO  OR TA1
        db G4S, SO  OR TA2
        db G5 , SO  OR TA1
        db SO , SO  OR TA1
        db ZZ , SO  OR TA1
        ; 7
        db G4 , G4  OR TA2
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
