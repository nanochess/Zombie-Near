        ;            
        ; Mapa 3 para Zombie Near
        ;
        ; por Oscar Toledo Gutierrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Gutierrez
        ;
        ; Creaci�n: 16-ene-2011.
        ; Revisi�n: 17-ene-2011. Se termina el laberinto.
        ; Revisi�n: 18-ene-2011. Se agrega jefe esperando.
        ;

        ; 00 Piso de mosaicos (alterno 09)
        ; 10 Piso de mosaico diagonal (alterno 11)
        ; 01/12 Pared norte
        ; 02/13 Pared oeste
        ; 03/14 Pared sur
        ; 04/15 Pared este
        ; 05/16 Uni�n pared norte con oeste
        ; 06/17 Uni�n pared norte con este
        ; 07/18 Uni�n pared sur con oeste
        ; 08/19 Uni�n pared sur con este
        ; 20 Puerta oeste
        ; 21 Puerta norte
        ; 22 Escritorio vacio
        ; 23 Escritorio con papeles
        ; 24 Escritorio con PC
        ; 25 Escritorio con matraces
        ; 26 M�quina de caf�
        ; 27 Librero
        ; 28 Armario
        ; 29 Armario semiabierto
        ; 30 Sanitario
        ; 31 Consola 1
        ; 32 Mesa de disecci�n.
        ; 33 Mesa de disecci�n con huesitos.
        ; 34 Mesa con herramientas de cirug�a.
        ; 35 Consola 2
        ; 40 Puerta sur
        ; 41 Escritorio con perro de peluche
        ; 42 Maceta con planta
        ; 43 Caja de cart�n
        ; 44 M�quina con zombie (sup. izq)
        ; 45 M�quina con zombie (sup. der)
        ; 46 M�quina con zombie (inf. izq)
        ; 47 M�quina con zombie (inf. der)
        ; 48 Puerta este
        ; 72 Jefe esperando
        ; 73 Chica esperando
        ; 74 Puerta de habitaci�n de jefe (arriba)
        ; 75 Amistoso zombie 4 listo para surgir
        ; 76 Amistoso zombie 1 mirando hacia abajo
        ; 77 Amistoso zombie 1 mirando hacia arriba
        ; 78 Vida
        ; 79 Puerta de la habitaci�n del jefe 1 (abajo)
        ; 80 Amistoso zombie 3 mirando a la izq.
        ; 81 Amistoso zombie 3 mirando a la der.
        ; 82 Amistoso zombie 3 mirando arriba
        ; 83 Amistoso zombie 3 mirando abajo
        ; 84 Llave
        ; 85 Cient�fico
        ; 86 Cient�fica
        ; 87 Mancha de sangre
        ; 88 Medio esqueleto
        ; 89 Mano suelta
        ; 90 Amistoso zombie 1 mirando a la izq.
        ; 91 Amistoso zombie 1 mirando a la der.
        ; 92 Amistoso zombie 2 mirando a la izq.
        ; 93 Amistoso zombie 2 mirando a la der.
        ; 94 Amistoso zombie 2 mirando arriba
        ; 95 Amistoso zombie 2 mirando abajo
        ; 96 Puerta de la habitaci�n del jefe 2 (izq)
        ; 97 Puerta que se abre con llave
        ; 98 Puerta
        ; 99 Punto de inicio
        ; 
mapa3:
        ; Piso 1.
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 20,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 2
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 3
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 4
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,84,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 5
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 6
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 07,04,04,04,04,04,98,04,04,04,04,08
        ; Piso 7
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 8
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 9
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 10
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,98,08
        ; Piso 11.
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 12
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 13
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 14
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 15
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 16
        db 05,01,01,01,01,01,98,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 17
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 18
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 19
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 20
        db 05,01,01,01,01,01,01,01,01,01,98,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 21
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 22
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 23
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 24
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 25
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 26
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,98,15,15,15,15,19
        ; Piso 27
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 28
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 29
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 30
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 31
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 32
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 33
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 34
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 35
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 36
        db 16,12,12,12,12,12,98,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 37
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 38
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 39
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 40
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 41
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 42
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 43
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 44
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 45
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,97
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,98,15,15,15,15,19
        ; Piso 46
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 20,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,98
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 47
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,97
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 96,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 48
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 20,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,97
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,98,15,15,15,19
        ; Piso 49
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 20,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 50
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 51
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 52
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 53
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,97,15,15,15,15,15,19
        ; Piso 54
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 55
        db 16,12,12,12,12,12,98,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 56
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,98,15,15,15,15,19
        ; Piso 57
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 58
        db 16,12,12,12,12,12,12,98,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,98,15,15,15,15,15,15,15,19
        ; Piso 59
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 60
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 61
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 62
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 63
        db 16,12,12,12,12,21,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 64
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 65
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 66
        db 16,12,12,12,12,12,98,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 67
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,98,15,15,15,15,19
        ; Piso 68
        db 16,12,12,98,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,98,15,15,19
        ; Piso 69
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 70
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 71
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 72
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 73
        db 16,12,12,12,12,74,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,97
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 74
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 20,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 75
        db 16,12,12,12,12,98,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 76
        db 16,12,12,12,12,12,12,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,98,15,15,15,15,15,19
        ; Piso 77
        db 16,12,12,12,12,12,98,12,12,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,98
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 78
        db 16,12,12,12,12,12,12,12,98,12,12,17
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 98,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 13,10,10,10,10,10,10,10,10,10,10,14
        db 18,15,15,15,15,15,15,15,15,15,15,19
        ; Piso 79
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 80
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 81
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 82
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 83
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 84
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 85
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,84,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 86
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 87
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 88
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 89
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,98,04,04,04,04,04,08
        ; Piso 90
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 91
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 92
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 93
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 94
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,84,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 95
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 96
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 97
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 98
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 99
        db 05,01,01,01,01,98,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 98,00,00,00,00,00,00,00,00,00,00,98
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 100
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 96,00,00,00,00,00,00,00,00,00,00,97
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
        ; Piso 101
        db 05,01,01,01,01,01,01,01,01,01,01,06
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 20,00,00,00,00,00,00,72,00,00,00,97
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 02,00,00,00,00,00,00,00,00,00,00,03
        db 07,04,04,04,04,04,04,04,04,04,04,08
