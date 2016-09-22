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
        ; Revisi¢n: 21-ene-2011. Se agrega efecto de temblor cuando el jefe
        ;                        cae inicialmente y al final del brinco,
        ;                        tambi‚n cuando choca con pared izq/der.
        ; Revisi¢n: 24-ene-2011. Se agrega efecto de temblor cuando el jefe
        ;                        corre y choca con pared izq/der.
        ; Revisi¢n: 26-ene-2011. Correcci¢n en movimiento jefe, resulta que
        ;                        si su coordenada X era muy cercana a la del
        ;                        jugador siempre brincaba o corr¡a, esto lo
        ;                        hac¡a f cil de derrotar si el jugador se
        ;                        pon¡a arriba o abajo hacia la izquierda, as¡
        ;                        que ahora eso simplemente incrementa sus
        ;                        ganas de correr o brincar pero no se queda
        ;                        quieto en Y.
        ; Revisi¢n: 01-abr-2011. Se agrega c¢digo para lluvia de monstruos.
        ; Revisi¢n: 03-abr-2011. Se agrega c¢digo para monstruo tipo 5.
        ; Revisi¢n: 09-abr-2011. El zombie que se arrastra llama al efecto
        ;                        de sonido para rascado.
        ; Revisi¢n: 11-abr-2011. Se agrega c¢digo para que desaparezca el
        ;                        zombie que se arrastra, usado cuando
        ;                        reemplaza al jugador.
        ;

        ;
        ; Movimiento del monstruo 1
        ; Va a izquierda o derecha, da media vuelta si se topa con algo
        ;
        ; Caso especial para monstruo que se arrastra.
        ;
mueve_monstruo_1:
        ld a,(ix+d_sprite)
        cp $6c
        jr z,mueve_monstruo_5
        cp $7c
        jr z,mueve_monstruo_5
        cp $b4
        jr z,mueve_monstruo_5
        cp $b8
        jr z,mueve_monstruo_5
        ;
        ; Monstruo que camina
        ;
        ld a,(ix+d_dx)
        or a                    ; ¨Es vertical?
        jr z,mueve_monstruo_1b  ; S¡, salta a rutina correcta.
        dec a                   ; ¨Va a la derecha?
        jr z,.1
        call mov_izquierda
        ret c
        jr .2

.1:     call mov_derecha
        ret c
.2:     ld a,(ix+d_dx)
        neg
        ld (ix+d_dx),a
        ret

        ;
        ; Movimiento del monstruo 1
        ; Va hacia arriba o abajo, da media vuelta si se topa con algo
        ;
mueve_monstruo_1b:
        ld a,(ix+d_dy)
        dec a   ; ¨Va hacia abajo?
        jr z,.1
        call mov_arriba
        ret c
        jr .2

.1:     call mov_abajo
        ret c
.2:     ld a,(ix+d_dy)
        neg
        ld (ix+d_dy),a
        ret

        ;
        ; Movimiento del monstruo 5
        ;
mueve_monstruo_5:
        ld a,(ix+d_ultimo)
        or a                    ; ¨Es el jugador :) ?
        jr z,.5                 ; No, salta.
        ld a,(ix+d_ultimo+1)
        inc a                   ; Tiempo para que desaparezca
        ld (ix+d_ultimo+1),a
        cp 50                   ; 150 / paso = 50
        jr nz,.5
        ld (ix+d_tipo),0        ; Lo desaparece
        ret

.5:     inc (ix+d_dy)           ; Estado
        ld a,(ix+d_dy)
        cp 24                   ; Quietud
        ret c
        jr nz,.0                ; Preparaci¢n
        ld a,(ix+d_x)
        sub (iy+d_x)            ; Busca al jugador
        ld a,-1
        jr nc,.7
        ld a,1
.7:     ld (ix+d_dx),a
        dec a
        ld a,$7c
        jr nz,.1
        ld a,$b8
.1:     ld (ix+d_sprite),a      ; Levanta la manita
        ret

.0:     cp 28
        ret c
        jr nz,.2
        ld a,(ix+d_dx)
        dec a
        ld a,$6c
        jr nz,.3
        ld a,$b4
.3:     ld (ix+d_sprite),a      ; Baja la manita
        call efecto_rasca
        call .4                 ; Avance r pido
        call .4
        call .4
        jr .4

.2:     cp 32
        jr c,.4
        ld a,r                  ; Para que no todos se muevan al mismo tiempo
        and 3
        add a,13
        ld (ix+d_dy),a          ; Repite el ciclo
        ret

.4:     ld a,(ix+d_dx)
        dec a                   ; ¨Va a la derecha?
        jp nz,.8
        ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $b0
        ret nc
        ld de,$0001
        call mov_libre
        ret nc
        inc (ix+d_x)
        ret

.8:     ld a,(ix+d_x)
        sub (ix+d_refx)
        ret z
        ld de,$00ff
        call mov_libre
        ret nc
        dec (ix+d_x)
        ret

        ;
        ; Movimiento del monstruo 2
        ; Gira a la derecha si se topa con algo
        ;
mueve_monstruo_2:
        ld a,(ix+d_dx)
        cp 1    ; ¨Va a la derecha?
        jr nz,.1
        call mov_derecha
        ret c
        ld (ix+d_dx),0     ; Ahora abajo
        ld (ix+d_dy),1
        call mov_abajo
        ret c
        ld (ix+d_dy),-1
        ret

.1:     cp -1   ; ¨Va a la izquierda?
        jr nz,.2
        call mov_izquierda
        ret c
        ld (ix+d_dx),0     ; Ahora arriba
        ld (ix+d_dy),-1
        call mov_arriba
        ret c
        ld (ix+d_dy),1
        ret

.2:     ld a,(ix+d_dy)
        cp 1    ; ¨Va hacia abajo?
        jr nz,.3
        call mov_abajo
        ret c
        ld (ix+d_dx),-1    ; Ahora a la izquierda
        ld (ix+d_dy),0
        call mov_izquierda
        ret c
        ld (ix+d_dx),1
        ret

.3:     call mov_arriba
        ret c
        ld (ix+d_dx),1     ; Ahora a la derecha
        ld (ix+d_dy),0
        call mov_derecha
        ret c
        ld (ix+d_dx),-1
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
        ; Movimiento del monstruo 3 y 4
        ; En cada intersecci¢n trata de ir hacia el jugador
        ;
mueve_monstruo_3:
        ld a,(ix+d_sprite)
        cp $94
        jr nc,monstruo_en_espera
        ld a,(ix+d_x)
        or (ix+d_y)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_dx)
        or a
        jr z,.1
        ;
        ; Estaba en horizontal, trata de ir en vertical
        ;
        ld a,(ix+d_y)
        sub (iy+d_y)
        jr nz,.6
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp z,.5
        jr c,.7
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

.6:     jr c,.2
        call mov_arriba
        jr nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.2:     call mov_abajo
        jr nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

        ;
        ; Estaba en vertical, trata de ir en horizontal
        ;
.1:     ld a,(ix+d_x)
        sub (iy+d_x)
        jr nz,.8
        ld a,(ix+d_y)
        sub (iy+d_y)
        jr z,.4
        jr c,.9
        call mov_arriba
        jr nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),-1
        ret

.9:     call mov_abajo
        jr nc,.4
        ld (ix+d_dx),0
        ld (ix+d_dy),1
        ret

.8:     jr c,.3
        call mov_izquierda
        jr nc,.5
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
        jr .5

        ;
        ; Mueve al zombie jefe
        ;
mueve_jefe:
        ld a,(ix+d_dy)
        cp 1
        jr nz,.1
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
.1:     cp -1
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
        jr z,.9
        neg
.9:     add a,(ix+d_x)
        sub (ix+d_refx)
        cp $0f
        jr nc,.10
        ld a,$10
.10:    cp $91
        jr c,.11
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
.12:    cp -2
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
        cp $10
        jr nc,.14
        ld a,$10
        add a,(iy+d_refx)
        ld (ix+d_x),a
        jr .14

.13:    inc (ix+d_x)
        ld a,(ix+d_x)
        sub (iy+d_refx)
        cp $90
        jr c,.14
        ld a,$90
        add a,(iy+d_refx)
        ld (ix+d_x),a
.14:    dec (ix+d_ultimo)       ; ¨Fin de la carrera?
        ret nz                  ; No, retorna
        xor a
        ld (ix+d_dy),a
        ld (ix+d_velocidad),3
        ld a,18                 ; Tiempo de quietud
        ld (ix+d_paso),a
        ret

        ;
        ; Ciclo principal
        ; Avanzar amenazadoramente hacia el jugador
        ;
.2:     ld (ix+d_velocidad),3
        ;
        ; Mueve verticalmente
        ;
        ld a,(ix+d_y)
        add a,$10               ; Offset con respecto al jugador
        sub (iy+d_y)
        jp z,.7                 ; Salta si est  alineado en Y
        ld a,-1                 ; Ir para arriba
        jr nc,.8
        ld a,1                  ; Ir para abajo
.8:     add a,(ix+d_y)
        ld (ix+d_y),a
        ;
        ; Mueve horizontalmente
        ;
.7:     ld a,(ix+d_x)
        sub (iy+d_x)
        jr c,.3
        ld a,(ix+d_ultimo+1)
        and $f0
        ld (ix+d_sprite),a
        dec (ix+d_x)
        ld (ix+d_dx),-1
        jr .4

.3:     ld a,(ix+d_ultimo+1)
        and $e0
        or $10
        ld (ix+d_sprite),a
        inc (ix+d_x)
        ld (ix+d_dx),1
        ;
        ; ¨Le dan ganas de brincar o correr?
        ;
.4:     ld a,r                  ; Usa refresh como n£mero aleatorio
        and $0f
        ld c,a
        ld a,(iy+d_x)
        add a,8
        sub (ix+d_x)
        cp $10                  ; ¨Trepado en X?
        jr nc,.6                ; No, salta.
        res 3,c                 ; S¡, le dan m s ganas de brincar o correr
.6:     ld a,c
        cp 5
        jr nz,.5
        ld a,(ix+d_ultimo+1)
        bit 0,a                 ; bit 0 = 0 = Jefe simple
        jr z,.15
        bit 1,a                 ; bit 1 = 0 = Maratonista
        jr z,.16
        xor 4                   ; Hace las dos cosas
        ld (ix+d_ultimo+1),a
        and 4                   ; Para despistar...
        jr nz,.15               ; ...la primera vez es brinco
        jr .16

        ; Inicia brinco
.15:    ld (ix+d_dy),-1
        ld (ix+d_velocidad),1
        ld (ix+d_ultimo),0
        call efecto_berrido
        jr .5

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

        ;
        ; Llueve un monstruo
        ;
llueve_monstruo:
        ld a,(ix+d_y)
        sub (ix+d_refy)
        and $f0         ; ¨El jugador entrando por la puerta?
        jp z,.3         ; A£n no puede agregar monstruo
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16        ; Primera entrada reservada para bala
        add hl,de
        push hl
        ; Busca una entrada libre
        ld b,max_monigotes-1
.2:     ld de,d_tipo
        add hl,de
        ld a,(hl)
        sbc hl,de
        or a
        jr z,.4
        ld de,16
        add hl,de
        djnz .2
        pop hl
        jp .3           ; En este momento no puede agregar

        ; Verifica que no haya m s de dos monstruos por l¡nea
.4:     ex (sp),hl
        ld b,max_monigotes-1
        ld c,0
.5:     ld de,d_tipo
        add hl,de
        ld a,(hl)
        sbc hl,de
        or a
        jr z,.6
        inc hl
        ld a,(ix+d_y)
        and $f0
        cp (hl)
        dec hl
        jr nz,.6
        inc c
        ld a,c
        cp 2
        jr nz,.6
        pop hl
        jp .3           ; En este momento no puede agregar

.6:     ld de,16
        add hl,de
        djnz .5
        pop hl
        ;
        ; Listo para agregar
        ;
        ld a,(ix+d_seccion)
        rlca
        rlca
        and $3f
        cp 23
        jp nz,.10
        ; Tiempo de llave
        call musica_triunfo
        ld de,$0000
        ld bc,$010b
        ; A la izquierda
.11:    ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $38
        jr c,.12
        ld a,(ix+d_x)
        sub $28
        ld (hl),a
        ld a,$10
        jr .9

        ; A la derecha
.12:    ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $78
        jr nc,.11
        ld a,(ix+d_x)
        add a,$28
        ld (hl),a
        ld a,$10
        jr .9

.10:    ld a,(ix+d_seccion)
        cpl
        and $06         ; La velocidad se agranda cada 8 monos
        rrca
        ld b,a
        ld a,(ix+d_seccion)
        bit 6,a         ; Alterna lado
        jr z,.7
        ; A la izquierda
.8:     ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $38
        jr c,.7
        ld a,(ix+d_x)
        sub $28
        ld (hl),a
        ld a,$40
        ld de,$0001
        ld c,3
        jr .9

        ; A la derecha
.7:     ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $78
        jr nc,.8
        ld a,(ix+d_x)
        add a,$28
        ld (hl),a
        ld a,$50
        ld de,$00ff
        ld c,3
.9:     inc hl
        push af
        ld a,(ix+d_refy)
        add a,$f0
        ld (hl),a
        inc hl
        pop af
        ld (hl),a       ; Sprite
        inc hl
        ld (hl),c       ; Color
        inc hl
        ld (hl),e       ; Dir. X
        inc hl
        ld (hl),d       ; Dir. Y
        inc hl
        ld (hl),b       ; Velocidad
        inc hl
        ld (hl),2       ; Energ¡a
        inc hl
        ld (hl),b       ; Paso actual (copia de velocidad)
        inc hl
        ld (hl),14      ; Tipo de monigote
        inc hl
        xor a
        ld (hl),a       ; Ultimo movimiento
        inc hl
        ld (hl),a
        call finaliza_monigote
        ld a,(ix+d_seccion)
        rlca
        rlca
        inc a                   ; Cuenta monstruos
        rrca
        rrca
        ld (ix+d_seccion),a
        rlca
        rlca
        and $3f
        cp 24
        jp z,.1
.3:     ld (ix+d_tiempo),50     ; Tiempo para otro monstruo
        ld (ix+d_tiempo+1),0
        ret

.1:     res 4,(ix+d_objeto)     ; Termina la lluvia de monstruos
        ld a,(ix+d_seccion)
        and $30                 ; Limpia contador
        ld (ix+d_seccion),a
        ret
        
