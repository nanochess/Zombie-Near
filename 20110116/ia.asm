        ;
        ; Inteligencia artificial de los enemigos de Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 16-ene-2011. Separado del programa principal. Se agrega
        ;                        rutina para zombies que caminan de arriba
        ;                        hacia abajo. Se agrega c¢digo para manejar
        ;                        el surgimiento del zombie tipo 4. Se escribe
        ;                        el c¢digo para carrerita de jefe zombie y
        ;                        opciones (solo salto, solo carrera o ambos).
        ;

        ;
        ; Movimiento del monstruo 1
        ; Va a izquierda o derecha, da media vuelta si se topa con algo
        ;
mueve_monstruo_1:
        ld a,(ix+d_dx)
        or a                    ; ¨Es vertical?
        jp z,mueve_monstruo_1b  ; S¡, salta a rutina correcta.
        cp 1                    ; ¨Va a la derecha?
        jp z,.1
        call mov_izquierda
        ret c
        ld a,(ix+d_dx)
        neg
        ld (ix+d_dx),a
        ret

.1:     call mov_derecha
        ret c
        ld a,(ix+d_dx)
        neg
        ld (ix+d_dx),a
        ret

        ;
        ; Movimiento del monstruo 1
        ; Va hacia arriba o abajo, da media vuelta si se topa con algo
        ;
mueve_monstruo_1b:
        ld a,(ix+d_dy)
        cp 1    ; ¨Va hacia abajo?
        jp z,.1
        call mov_arriba
        ret c
        ld a,(ix+d_dy)
        neg
        ld (ix+d_dy),a
        ret

.1:     call mov_abajo
        ret c
        ld a,(ix+d_dy)
        neg
        ld (ix+d_dy),a
        ret

        ;
        ; Movimiento del monstruo 2
        ; Gira a la derecha si se topa con algo
        ;
mueve_monstruo_2:
        ld a,(ix+d_dx)
        cp 1    ; ¨Va a la derecha?
        jp nz,.1
        call mov_derecha
        ret c
        ld (ix+d_dx),0     ; Ahora abajo
        ld (ix+d_dy),1
        call mov_abajo
        ret c
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.1:     cp -1   ; ¨Va a la izquierda?
        jp nz,.2
        call mov_izquierda
        ret c
        ld (ix+d_dx),0     ; Ahora arriba
        ld (ix+d_dy),-1
        call mov_arriba
        ret c
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

.2:     ld a,(ix+d_dy)
        cp 1    ; ¨Va hacia abajo?
        jp nz,.3
        call mov_abajo
        ret c
        ld (ix+d_dx),-1    ; Ahora a la izquierda
        ld (ix+d_dy),0
        call mov_izquierda
        ret c
        ld (ix+d_dx),1
        ld (ix+d_dy),0
        ret

.3:     call mov_arriba
        ret c
        ld (ix+d_dx),1     ; Ahora a la derecha
        ld (ix+d_dy),0
        call mov_derecha
        ret c
        ld (ix+d_dx),-1
        ld (ix+d_dy),0
        ret

        ;
        ; Un zombie tipo 4 en espera
        ;
monstruo_en_espera:
        ld (ix+d_velocidad),8
        ld a,(ix+d_dx)
        inc a
        ld (ix+d_dx),a
        cp 10
        ret c
        ld e,(ix+d_sprite)
        inc e
        inc e
        inc e
        inc e
        ld (ix+d_sprite),e
        cp 15
        ret c
        ld (ix+d_dx),1
        ld (ix+d_dy),0
        ld (ix+d_sprite),$40
        ld (ix+d_velocidad),2
        ret
        
        ;
        ; Movimiento del monstruo 3
        ; En cada intersecci¢n trata de ir hacia el jugador
        ;
mueve_monstruo_3:
        ld a,(ix+d_sprite)
        cp $94
        jp nc,monstruo_en_espera
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_dx)
        or a
        jp z,.1
        ;
        ; Estaba en horizontal, trata de ir en vertical
        ;
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nz,.6
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp z,.5
        jp c,.7
        call mov_izquierda
        jp nc,.5
        ld (ix+d_dx),-1
        ld (ix+d_dy),0
        ret

.7:     call mov_derecha
        jp nc,.5
        ld (ix+d_dx),1
        ld (ix+d_dy),0
        ret

.6:     jp c,.2
        call mov_arriba
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.2:     call mov_abajo
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

        ;
        ; Estaba en vertical, trata de ir en horizontal
        ;
.1:     ld a,(ix+d_x)
        sub (iy+d_x)
        jp nz,.8
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp z,.4
        jp c,.9
        call mov_arriba
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.9:     call mov_abajo
        jp nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

.8:     jp c,.3
        call mov_izquierda
        jp nc,.5
        ld (ix+d_dx),-1
        ld (ix+d_dy),0
        ret

.3:     call mov_derecha
        ret c
        ld (ix+d_dx),1
        ld (ix+d_dy),0
        ret

        ;
        ; Trata de ir en cualquier ruta
        ;
.5:     call mov_izquierda
        ret c
        call mov_derecha
        ret c
.4:     call mov_arriba
        ret c
        call mov_abajo
        ret c
        jp .5

        ;
        ; Mueve al zombie jefe
        ;
mueve_jefe:
        ld a,(ix+d_dy)
        cp 1
        jp nz,.1
        ;
        ; Cayendo
        ;
        ld a,(ix+d_x)
        add a,(ix+d_dx)
        ld (ix+d_x),a
        ld a,(ix+d_y)
        add a,2
        ld (ix+d_y),a
        sub (ix+d_refy)
        cp $20
        ret nz
        xor a
        ld (ix+d_dy),a
        ret

        ;
        ; Verifica brinco
        ;
.1:     ld a,(ix+d_dy)
        cp -1
        jp nz,.12
        ;
        ; Piernas abiertas
        ;
        ld a,(ix+d_sprite)
        and $f3
        ld (ix+d_sprite),a
        ;
        ; Movimiento
        ;
        push hl
        ld a,(ix+d_ultimo)
        ld hl,salto_jefe
        ld e,a
        ld d,0
        add hl,de
        add hl,de
        ld a,(hl)
        bit 7,(ix+d_dx)
        jp z,.9
        neg
.9:     add a,(ix+d_x)
        sub (ix+d_refx)
        cp $0f
        jp nc,.10
        ld a,$10
.10:    cp $91
        jp c,.11
        ld a,$90
.11:    add a,(ix+d_refx)
        ld (ix+d_x),a
        inc hl
        ld a,(hl)
        pop hl
        add a,(ix+d_y)
        ld (ix+d_y),a
        ld a,(ix+d_ultimo)
        inc a
        cp 32
        ld (ix+d_ultimo),a
        ret nz
        xor a
        ld (ix+d_dy),a
        ld (ix+d_velocidad),3
        ld a,18
        ld (ix+d_paso),a
        ret

        ;
        ; Verifica carrerita
        ;
.12:    ld a,(ix+d_dy)
        cp -2
        jp nz,.2
        ld (ix+d_velocidad),1
        ;
        ; Animaci¢n
        ;
        ld a,(ticks)
        and $06
        rlca
        ld c,a
        ld a,(ix+d_sprite)
        and $f3
        or c
        ld (ix+d_sprite),a
        ;
        ; Mueve horizontalmente
        ;
        ld a,(ix+d_dx)
        or a
        jp p,.13
        dec (ix+d_x)
        ld a,(ix+d_x)
        sub (iy+d_refx)
        cp 16
        jp nc,.14
        ld a,16
        add a,(iy+d_refx)
        ld (ix+d_x),a
        jp .14

.13:    inc (ix+d_x)
        ld a,(ix+d_x)
        sub (iy+d_refx)
        cp 144
        jp c,.14
        ld a,144
        add a,(iy+d_refx)
        ld (ix+d_x),a
.14:    dec (ix+d_ultimo)       ; ¨Fin de la carrera?
        ret nz                  ; No, retorna
        xor a
        ld (ix+d_dy),a
        ld (ix+d_velocidad),3
        ld a,18
        ld (ix+d_paso),a
        ret

        ;
        ; Ciclo principal
        ; Avanzar amenazadoramente hacia el jugador
        ;
.2:     ld a,(iy+d_nivel)
        ld (ix+d_velocidad),3
        ;
        ; Mueve verticalmente
        ;
        ld a,(ix+d_y)
        add $10
        sub (iy+d_y)
        jp z,.7
        ld a,-1
        jp nc,.8
        ld a,1
.8:     add a,(ix+d_y)
        ld (ix+d_y),a
        ;
        ; Mueve horizontalmente
        ;
.7:     ld a,(ix+d_x)
        sub (iy+d_x)
        jp c,.3
        ld a,(ix+d_ultimo+1)
        and $f0
        ld (ix+d_sprite),a
        dec (ix+d_x)
        ld (ix+d_dx),-1
        jp .4

.3:     ld a,(ix+d_ultimo+1)
        and $e0
        or $10
        ld (ix+d_sprite),a
        inc (ix+d_x)
        ld (ix+d_dx),1
        ;
        ; ¨Le dan ganas de brincar o correr?
        ;
.4:     ld a,(iy+d_x)
        add a,8
        sub (ix+d_x)
        cp $10
        jp c,.6
        ld a,r
        and $0f
        cp 5
        jp nz,.5
.6:
        ld a,(ix+d_ultimo+1)
        bit 0,a                 ; bit 0 = 0 = Jefe simple
        jp z,.15
        bit 1,a                 ; bit 1 = 0 = Maratonista
        jp z,.16
        xor 4                   ; Hace las dos cosas
        ld (ix+d_ultimo+1),a
        and 4                   ; Para despistar...
        jp nz,.15               ; ...la primera vez es brinco
        jp .16

        ; Inicia brinco
.15:    ld (ix+d_dy),-1
        ld (ix+d_velocidad),1
        ld (ix+d_ultimo),0
        call efecto_berrido
        jp .5

        ; Inicia carrera
.16:    ld (ix+d_dy),-2
        ld (ix+d_velocidad),20  ; Para que se entere el jugador
        ld (ix+d_paso),20       ; Para que se entere el jugador
        ld (ix+d_ultimo),80
        call efecto_berrido
        ;
        ; Animaci¢n
        ;
.5:     ld a,(ticks)
        and $0c
        ld c,a
        ld a,(ix+d_sprite)
        and $f3
        or c
        ld (ix+d_sprite),a
        ret

        ;
        ; El gran salto del zombie jefe
        ;
salto_jefe:
        db  3 ,-4 
        db  3 ,-4 
        db  3 ,-3 
        db  2 ,-3 
        db  3 ,-2 
        db  2 ,-2 
        db  3 ,-1 
        db  1 ,-1 
        db  2 ,-1 
        db  1 ,-1 
        db  0 ,-1 
        db  1 ,-1 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  2 , 0 
        db  1 , 1 
        db  0 , 1 
        db  1 , 1 
        db  2 , 1 
        db  1 , 1 
        db  3 , 1 
        db  2 , 2 
        db  3 , 2 
        db  2 , 3 
        db  3 , 3 
        db  3 , 4 
        db  3 , 4 

