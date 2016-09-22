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
        ; Revisi¢n: 31-mar-2011. Se pone aqu¡ la melod¡a de silencio.
        ; 

        ; Tabla de notas
tabla_notas:
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

ZZ:     equ 0           ; Silencio
SO:     equ -1          ; Sostenido

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
        db G4 ,G4
        db C5 ,SO
        db E5 ,SO
        db C5 ,SO
        db G4 ,E5
        db C5 ,SO
        db E5 ,SO
        db C5 ,SO
        db G4 ,ZZ
        db C5 ,ZZ
        db E5 ,ZZ
        db C5 ,ZZ
        db G4 ,ZZ
        db C5 ,ZZ
        db E5 ,ZZ
        db C5 ,ZZ

        db G4 ,G4
        db C5 ,SO
        db D5S,SO
        db C5 ,SO
        db G4 ,D5S
        db C5 ,SO
        db D5S,SO
        db C5 ,SO
        db G4 ,ZZ
        db C5 ,ZZ
        db D5S,ZZ
        db C5 ,ZZ
        db G4 ,ZZ
        db C5 ,ZZ
        db D5S,ZZ
        db C5 ,ZZ

        db G4 ,G4
        db B4 ,SO
        db D5 ,SO
        db B4 ,SO
        db G4 ,D5
        db B4 ,SO
        db D5 ,SO
        db B4 ,SO
        db G4 ,ZZ
        db B4 ,ZZ
        db D5 ,ZZ
        db B4 ,ZZ
        db G4 ,ZZ
        db B4 ,ZZ
        db D5 ,ZZ
        db B4 ,ZZ

        db G4 ,ZZ
        db A4S,ZZ
        db D5 ,ZZ
        db A4S,ZZ
        db G4 ,G4
        db A4S,SO
        db D5 ,SO
        db A4S,SO
        db G4 ,D5
        db A4S,SO
        db D5 ,SO
        db A4S,SO
        db G4 ,ZZ
        db A4S,ZZ
        db D5 ,ZZ
        db A4S,ZZ

        db G4 ,ZZ
        db B4 ,ZZ
        db D5 ,ZZ
        db B4 ,ZZ
        db G4 ,G4
        db B4 ,SO
        db D5 ,SO
        db B4 ,SO
        db G4 ,D5
        db B4 ,SO
        db D5 ,SO
        db B4 ,SO
        db G4 ,ZZ
        db B4 ,ZZ
        db D5 ,ZZ
        db B4 ,ZZ

        db G4 ,ZZ
        db A4S,ZZ
        db D5 ,ZZ
        db A4S,ZZ
        db G4 ,G4
        db A4S,SO
        db D5 ,SO
        db A4S,SO
        db G4 ,D5
        db A4S,SO
        db D5 ,SO
        db A4S,SO
        db G4 ,ZZ
        db A4S,ZZ
        db D5 ,ZZ
        db A4S,ZZ

        db F4S,F4S
        db A4 ,SO
        db D5S,SO
        db A4 ,SO
        db F4S,D5S
        db A4 ,SO
        db D5S,SO
        db A4 ,SO
        db F4S,ZZ
        db A4 ,ZZ
        db D5S,ZZ
        db A4 ,ZZ

        db A4 ,A4
        db C5S,SO
        db E5 ,SO
        db C5S,SO
        db A4 ,E5
        db C5S,SO
        db E5 ,SO
        db C5S,SO
        db A4 ,ZZ
        db C5S,ZZ
        db E5 ,ZZ
        db C5S,ZZ
        db A4 ,ZZ
        db C5S,ZZ
        db E5 ,ZZ
        db C5S,ZZ

        db A4 ,A4
        db C5 ,SO
        db F5 ,SO
        db C5 ,SO
        db A4 ,F5
        db C5 ,SO
        db F5 ,SO
        db C5 ,SO
        db A4 ,ZZ
        db C5 ,ZZ
        db F5 ,ZZ
        db C5 ,ZZ

        db G4S,G4S
        db C5 ,SO
        db F5 ,SO
        db C5 ,SO
        db G4S,F5
        db C5 ,SO
        db F5 ,SO
        db C5 ,SO
        db G4S,ZZ
        db C5 ,ZZ
        db F5 ,ZZ
        db C5 ,ZZ

        db D4 ,D4
        db G4 ,SO
        db D5 ,SO
        db G4 ,SO

        db ZZ ,ZZ
        db ZZ ,ZZ
        db ZZ ,ZZ
        db ZZ ,ZZ

        db FIN1,ZZ

        ; Tema principal
melodia_principal:
        db  6 , 0 , 0 , 0
        ; 1
        db  C5 , C5 , G5 , C5 , ZZ , C5 , ZZ , C5
        db  ZZ , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        ; 2
        db  A4S, A4 , G5 , A4 , ZZ , A4 , ZZ , A4
        db  ZZ , A4 , ZZ , A4 , ZZ , A4 , ZZ , A4
        ; 3
        db  C5 , C5 , G5 , C5 , C6 , C5 , ZZ , C5
        db  ZZ , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        ; 4
        db  A4S, A4 , G5 , A4 , C6 , A4 , ZZ , A4
        db  ZZ , A4 , ZZ , A4 , ZZ , A4 , ZZ , A4
        ; 5
        db  C5 , C5 , G5 , C5 , F5S, C5 , G5 , C5
        db  SO , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        ; 6
        db  B4 , B4 , G5 , B4 , F5S, B4 , G5 , B4 
        db  SO , B4 , ZZ , B4 , ZZ , B4 , ZZ , B4
        ; 7
        db  A4S, A4S, G5 , A4S, F5S, A4S, G5 , A4S 
        db  SO , A4S, ZZ , A4S, ZZ , A4S, ZZ , A4S
        ; 8
        db  C5 , C5 , G5 , C5 , F5S, C5 , G5 , C5
        db  SO , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        ; 9
        db  B4 , B4 , G5 , B4 , F5S, B4 , G5 , B4
        db  SO , B4 , ZZ , B4 , ZZ , B4 , ZZ , B4
        ; 10
        db  A4S, A4S, G5 , A4S, F5S, A4S, G5 , A4S
        db  SO , A4S, ZZ , A4S, ZZ , A4S, ZZ , A4S
        ; 11
        db  C5 , C5 , G5 , C5 , F5S, C5 , G5 , C5
        db  A5S, C5 , A5 , C5 , G5S, C5 , G5 , C5
        ; 12
        db  F5S, C5 , G5 , C5 , SO , C5 , ZZ , C5
        db  A4 , A4 , G5 , A4 , F5S, A4 , G5 , A4
        ; 13
        db  A5S, A4 , A5 , A4 , G5S, A4 , G5 , A4
        db  F5S, A4 , G5 , A4 , SO , A4 , ZZ , A4
        ; 14
        db  C5 , C5 , SO , C5 , SO , C5 , SO , C5
        db  G5 , G5 , SO , G5 , SO , G5 , SO , G5
        ; 15
        db  F5S, F5S, SO , F5S, SO , F5S, SO , F5S
        db  ZZ , F5S, ZZ , F5S, ZZ , F5S, ZZ , F5S
        ; 16
        db  C5 , C5 , SO , C5 , SO , C5 , SO , C5
        db  G5 , G5 , SO , G5 , SO , G5 , SO , G5
        ; 17
        db  G5S, G5S, SO , G5S, SO , G5S, SO , G5S 
        db  ZZ , G5S, ZZ , G5S, ZZ , G5S, ZZ , G5S
        ; 18
        db  C5 , C5 , F5S, C5 , G5 , C5 , G5S, C5 
        db  ZZ , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        ; 19
        db  C6 , C5 , G5S, C5 , G5 , C5 , F5S, C5
        db  ZZ , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        ; 20
        db  C5 , C5 , F5S, C5 , G5 , C5 , ZZ , C5
        db  ZZ , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        ; 21
        db  C6 , C5 , G5 , C5 , F5S, C5 , ZZ , C5
        db  ZZ , C5 , ZZ , C5 , ZZ , C5 , ZZ , C5
        db  FIN2

        ; Tema 2
melodia_2:
        db 6, 0, 0, 0
        ; 1
        db C5 , C5
        db C5 , SO
        db D5S, SO
        db SO , SO
        db C5 , SO
        db G5 , SO
        db SO , SO
        db ZZ , SO
        ; 2
        db C5 , C5
        db C5 , SO
        db D5S, SO
        db SO , SO
        db C5 , SO
        db G5 , SO
        db SO , SO
        db ZZ , SO
        ; 3
        db A4S, A4S
        db A4S, SO
        db D5S, SO
        db SO , SO
        db A4S, SO
        db G5 , SO
        db SO , SO
        db ZZ , SO
        ; 4
        db A4S, A4S
        db A4S, SO
        db D5S, SO
        db SO , SO
        db A4S, SO
        db G5 , SO
        db SO , SO
        db ZZ , SO
        ; 5
        db G4S, G4S
        db G4S, SO
        db D5S, SO
        db SO , SO
        db G4S, SO
        db G5 , SO
        db SO , SO
        db ZZ , SO
        ; 6
        db G4S, G4S
        db G4S, SO
        db D5S, SO
        db SO , SO
        db G4S, SO
        db G5 , SO
        db SO , SO
        db ZZ , SO
        ; 7
        db G4 , G4
        db G4 , SO
        db D5S, SO
        db SO , SO
        db G4 , SO
        db G5 , SO
        db SO , SO
        db ZZ , SO
        ; 8
        db G5 , G5
        db G5S, SO
        db G5 , SO
        db F5 , SO
        db D5S, C5
        db D5 , SO
        db C5 , SO
        db SO , SO
        ; 8.5
        db ZZ , C5
        db ZZ , SO
        db ZZ , SO
        db ZZ , SO
        ; 9
        db C5 , C5
        db SO , SO
        db D5S, SO
        db SO , SO
        db C5 , SO
        db SO , SO
        db C5 , SO
        db C5 , SO
        ; 10
        db D5S, D5S
        db SO , SO
        db C5 , SO
        db SO , SO
        db D5 , SO
        db SO , SO
        db A4S, SO
        db A4S, SO
        ; 11
        db D5 , D5
        db SO , SO
        db A4S, SO
        db A4S, SO
        db D5 , SO
        db SO , SO
        db A4S, SO
        db SO , SO
        ; 12
        db F5 , F5
        db SO , SO
        db G4S, SO
        db SO , SO
        db F5 , SO
        db SO , SO
        db G4S, SO
        db G4S, SO
        ; 13
        db F5 , F5
        db SO , SO
        db G4S, SO
        db SO , SO
        db F4S, SO
        db C5 , SO
        db F4S, SO
        db D5 , SO
        ; 13.5
        db ZZ , C5
        db ZZ , SO
        db ZZ , SO
        db ZZ , SO
        ; 14
        db D5 , D5
        db D5S, SO
        db D5 , SO
        db C5 , SO
        db A4S, SO
        db D5 , SO
        db SO , SO
        db ZZ , SO
        ; 15      
        db A4S, C5
        db A4S, SO
        db C5 , SO
        db SO , SO
        db ZZ , SO
        db ZZ , SO
        db ZZ , SO
        db ZZ , SO
        ; 16
        db G5 , G5
        db G5 , SO
        db G5S, SO
        db G5 , SO
        db SO , SO
        db A5S, SO
        db SO , SO
        db G5S, SO
        ; 17
        db G5 , F5
        db F5 , SO
        db SO , SO
        db D5S, SO
        db SO , SO
        db F5 , SO
        db SO , SO
        db C5 , SO
        db SO , SO
        ; 18
        db C5 , C5
        db ZZ , SO
        db ZZ , SO
        db ZZ , SO
        db C5 , SO
        db D5S, SO
        db C5 , SO
        db D5 , SO
        ; 19
        db A4S, D5
        db SO , SO
        db D5 , SO
        db D5 , SO
        db D5S, SO
        db D5 , SO
        db C5 , SO
        db A4S, SO
        ; 20
        db D5 , D5
        db A4S, SO
        db C5 , SO
        db SO , SO
        db ZZ , C5
        db ZZ , SO
        db ZZ , SO
        db ZZ , SO
        db FIN2
