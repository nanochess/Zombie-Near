        ;
        ; Sonido y m£sica de Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 12-ene-2011. 
        ; Revisi¢n: 27-mar-2011. Ahora el mezclador permanece todo el tiempo
        ;                        encendido y solo se cambian los volumenes,
        ;                        esto evita el "pop" en la presentaci¢n.
        ; Revisi¢n: 30-mar-2011. Los acordes de historia y tema principal se
        ;                        pasan a MUSICA.ASM.
        ; Revisi¢n: 31-mar-2011. El silencio se pasa a MUSICA.ASM. Se unifica
        ;                        el reproductor de melod¡a de historia y tema
        ;                        principal. Ya selecciona melod¡a seg£n mapa.
        ;

        ; M£sica general
musica_general:
        xor a
        ld (ef_ritmo),a
        ld hl,ef_band
        set 6,(hl)
        res 7,(hl)
        ld a,(jug1+d_seccion)
        and $30
        ld l,a
        ld a,(jug2+d_seccion)
        and $30
        cp l
        jr nc,.1
        ld a,l
.1:     and $10
        ld a,5          ; M£sica 1
        ld hl,melodia_principal
        jr z,.0
        ld a,9          ; M£sica 2
        ld hl,melodia_2
.0:     ld (ef_env),a
        call pone_melodia
        ld a,(hl)
        ret

        ; M£sica historia
musica_historia:
        push hl
        xor a
        ld (ef_ritmo),a
        ld a,1
        ld (ef_env),a
        ld hl,ef_band
        set 6,(hl)
        res 7,(hl)
        ld hl,melodia_historia
        call pone_melodia
        pop hl
        ret

        ; M£sica de avance
musica_avance:
        push hl
        xor a
        ld (ef_env),a
        ld hl,ef_band
        res 6,(hl)
        res 7,(hl)
        ld hl,melodia_avance
        call pone_melodia
        pop hl
        ret

        ; M£sica de esperando al monstruo :P
musica_esperando:
        push hl
        xor a
        ld (ef_env),a
        ld hl,ef_band
        res 6,(hl)
        res 7,(hl)
        ld hl,melodia_esperando
        call pone_melodia
        pop hl
        ret

        ; M£sica de batalla
musica_batalla:
        push hl
        xor a
        ld (ef_ritmo),a
        ld (ef_env),a
        ld hl,ef_band
        res 6,(hl)
        set 7,(hl)
        ld hl,melodia_batalla
        call pone_melodia
        pop hl
        ret

        ; M£sica de triunfo
musica_triunfo:
        push hl
        xor a
        ld (ef_env),a
        ld hl,ef_band
        res 6,(hl)
        res 7,(hl)
        ld hl,melodia_triunfo
        call pone_melodia
        pop hl
        ret

        ; M£sica de fracaso
musica_fracaso:
        push hl
        xor a
        ld (ef_env),a
        ld hl,ef_band
        res 6,(hl)
        res 7,(hl)
        ld hl,melodia_fracaso
        call pone_melodia
        pop hl
        ret

        ; M£sica final
musica_final:
        push hl
        xor a
        ld (ef_env),a
        ld hl,ef_band
        res 6,(hl)
        res 7,(hl)
        ld hl,melodia_final
        call pone_melodia
        pop hl
        ret

        ;
        ; Inicia el sonido
        ;
inicia_sonido:
        ld a,$b8
        ld (ef_mezc),a
        ; M£sica silencio
musica_silencio:
        push hl
        xor a
        ld (ef_env),a
        ld hl,ef_band
        res 6,(hl)
        res 7,(hl)
        ld hl,melodia_silencio
        call pone_melodia
        pop hl
        ret

        ;
        ; Pone una nueva melod¡a.
        ;
pone_melodia:
        push af
        di
        ld a,(hl)
        inc hl
        add a,1
        srl a
        ld (ef_t),a
        ld a,-1
        ld (ef_cn),a
        ld a,(hl)
        inc hl
        ld (ef_ac1),a
        ld a,(hl)
        inc hl
        ld (ef_ac2),a
        ld a,(hl)
        inc hl
        ld (ef_ac3),a
        ld (ef_inicio),hl
        ld (ef_ap),hl
        push hl
        ld hl,modo
        res 3,(hl)      ; Nuevamente permite acceso interrupci¢n al sonido
        pop hl
        ei
        pop af
        ret

        ;
        ; Genera la m£sica
        ;
genera_musica:
        ld a,(ef_env)
        rrca
        jp c,genera_musica_historia
        ld a,(ef_cn)
        cp -1
        jp nz,.1
        ;
        ; M£sica con acorde autom tico
        ;
        ld hl,(ef_ap)
        ld a,(hl)
        cp $fe          ; ¨Fin de m£sica?
        ret z           ; S¡, corta todo
        cp $fc          ; ¨Retorna a m£sica principal?
        jp nz,.6
        call musica_general
        jp genera_musica

.6:     cp $fd          ; ¨Repetir?
        jp nz,.0
        ld hl,(ef_inicio)
        ld a,(hl)
.0:     inc hl
        ld (ef_ap),hl
        ld (ef_n),a     ; Nota principal
        ld (ef_b),a     ; Bajo
        xor a
        ld (ef_cn),a    ; Nota actual
        ld (ef_ta),a    ; Tiempo de nota
        ;
        ; Pone la nota en la voz actual, corta dos ticks antes del final
        ;
.1:     ld a,(ef_t)
        sub 2
        ld c,a
        ld a,(ef_ta)
        cp c
        jp nc,.5
        ld a,(ef_n)
        or a
        jp z,.5
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld (ef_voz1),hl
        ld a,14
        ld (ef_vol1),a
        ;
        ; Pone el bajo en la segunda voz
        ;
.5:     ld a,(ef_b)
        or a
        jp z,.8
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld (ef_voz2),hl
        ld a,13
        ld (ef_vol2),a
        ;
        ; Cuenta el tiempo de nota
        ;
.8:     ld hl,ef_ta
        inc (hl)
        ld a,(ef_t)
        cp (hl)
        ret nz
        ld (hl),0
        ld hl,ef_cn
        inc (hl)
        ld a,(hl)
        cp 1
        jp nz,.2
        ld a,(ef_n)
        or a
        ret z
        ld b,a
        ld a,(ef_ac1)
        add a,b         ; Desplaza por acorde 1
        ld (ef_n),a
        ret

.2:     cp 2
        jp nz,.3
        ld a,(ef_n)
        or a
        ret z
        ld b,a
        ld a,(ef_ac2)
        add a,b         ; Desplaza por acorde 2
        ld (ef_n),a     
        ld a,(ef_b)
        sub 12
        ld (ef_b),a
        ret

.3:     cp 3
        jp nz,.4
        ld a,(ef_n)
        or a
        ret z
        ld b,a
        ld a,(ef_ac3)
        add a,b         ; Desplaza por acorde 3
        ld (ef_n),a
        ret

.4:     cp 4
        ret nz
        ld (hl),-1      ; Tiempo de cargar otra nota
        ret

        ;
        ; M£sica para historia
        ;
genera_musica_historia:
        ld a,(ef_cn)
        cp -1
        jp nz,.1
        ld hl,(ef_ap)
        ld a,(hl)       ; Lee primera voz
        cp $fe          ; ¨Fin de melod¡a?
        jp z,.3         ; Se queda detenido
        cp $fd          ; ¨Repetici¢n?
        jp nz,.0
        ld hl,(ef_inicio)
        ld a,(hl)
.0:     inc hl
        cp $ff          ; ¨Sostenido?
        jp z,.4
        ld (ef_n),a
        push hl
        ld hl,ef_env
        set 1,(hl)      ; Indica que debe reiniciar envolvente
        pop hl
        xor a
        ld (ef_ac2),a
.4:     ld a,(hl)       ; Lee segunda voz
        inc hl
        ld (ef_ap),hl
        cp $ff          ; ¨Sostenido?
        jp z,.5
        ld (ef_b),a
        xor a
        ld (ef_ac3),a
.5:     xor a
        ld (ef_cn),a
        ld (ef_ta),a
        ;
        ; Arma voz principal
        ;
.1:     ld a,(ef_n)
        or a
        jp z,.6
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld a,(ef_env)
        and 12
        jp nz,.7
        ; Historia: piano y flauta
        ld (ef_voz2),hl ; Nota principal en voz 1
        srl h           ; Doble frecuencia en voz secundaria para piano
        rr l
        ld a,16
        ld (ef_vol2),a
        jr .9
.7:     cp 4
        ld a,(ef_ac2)
        jp nz,.8
        ; Tema principal 1: flauta de pan y bajo
        call instrumento_flauta_pan
        jr .9

        ; Tema principal 2: flauta y bajo
.8:     call instrumento_clarinete
.9:     ld (ef_voz1),hl
        ld (ef_vol1),a

        ;
        ; Arma voz secundaria
        ;
.6:     ld a,(ef_b)
        or a
        jp z,.2
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld a,(ef_env)
        and 12
        jp nz,.10
        ; Historia: segunda voz.
        ld a,(ef_ac3)
        call instrumento_clarinete
        srl h                   ; A doble frecuencia
        rr l
        jp nc,$+4
        inc hl
        ld (ef_voz3),hl         ; Usa la voz de efectos
        ld (ef_vol3),a
        jp .2

        ; Temas principales: bajos
.10:
        ld a,h
        or l
        jp z,.3
        add hl,hl
        add hl,hl
        ld a,(ef_t)
        srl a
        ld d,a
        ld a,(ef_ta)
        cp d
        jp c,.11
        add hl,hl
.11:    ld (ef_voz2),hl
        ld a,(ef_ritmo)
        ld e,a
        ld d,0
        ld hl,volumen_bajo
        add hl,de
        ld a,(hl)
        ld (ef_vol2),a
.2:     ld a,(ef_ac2)
        inc a
        cp $20
        jp nz,$+5
        sub $10
        ld (ef_ac2),a
        ld a,(ef_ac3)
        inc a
        cp $20
        jp nz,$+5
        sub $10
        ld (ef_ac3),a
        ld hl,ef_ta
        inc (hl)
        ld a,(ef_t)
        add a,a
        add a,a
        cp (hl)
        ret nz
        ld (hl),0
        ld a,-1
        ld (ef_cn),a
        ret

.3:     ld hl,ef_band
        res 6,(hl)      ; Quita el ritmo
        ret

volumen_bajo:
        db 12,12,11,10,9,8,8,9,10,11,12,12
        db 12,12,11,10,9,8,8,9,10,11,12,12
        db 12,12,11,10,9,8,8,9,10,11,12,12
        db 12,12,11,10,9,8,8,9,10,11,12,12

        ;
        ; Genera un clarinete
        ; HL = Frecuencia.
        ; A = Tick instrumento.
        ;
        ; Salida:
        ; HL = Frecuencia.
        ; A = Volumen.
        ;
instrumento_clarinete:
        add a,clarinete_vibrato and 255
        ld c,a
        ld a,clarinete_vibrato>>8
        adc a,0
        ld b,a
        ld a,(bc)
        ld e,a
        rlca
        sbc a,a
        ld d,a
        add hl,de
        ld a,c
        sub a,clarinete_vibrato and 255
        add a,clarinete_volumen and 255
        ld c,a
        ld a,clarinete_volumen>>8
        adc a,0
        ld b,a
        ld a,(bc)
        ret

clarinete_vibrato:
        db 0,0,0,0
        db -2,-4,-2,0
        db 2,4,2,0
        db -2,-4,-2,0
        db 2,4,2,0
        db -2,-4,-2,0
        db 2,4,2,0
        db -2,-4,-2,0

clarinete_volumen:
        db 14,14,13,13,12,12,12,12,11,11,11,11,12,12,12,12
        db 12,12,12,12,11,11,11,11,12,12,12,12,11,11,11,11

        ;
        ; Genera una flauta de pan
        ; HL = Frecuencia.
        ; A = Tick instrumento.
        ;
        ; Salida:
        ; HL = Frecuencia.
        ; A = Volumen.
        ;
instrumento_flauta_pan:
        add a,flauta_pan_vibrato and 255
        ld c,a
        ld a,flauta_pan_vibrato>>8
        adc a,0
        ld b,a
        ld a,(bc)
        ld e,a
        rlca
        sbc a,a
        ld d,a
        add hl,de
        ld a,c
        sub a,flauta_pan_vibrato and 255
        rrca
        jp nc,.1
        add hl,hl
.1:     rlca
        add a,flauta_pan_volumen and 255
        ld c,a
        ld a,flauta_pan_volumen>>8
        adc a,0
        ld b,a
        ld a,(bc)
        ret

flauta_pan_vibrato:
        db 0,0,0,0
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
                 
flauta_pan_volumen:
        db 13,13,12,12,12,12,12,12,12,12,12,12,12,12,12,12
        db 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12

        ;
        ; Genera el sonido
        ;
genera_sonido:
        ld hl,modo
        bit 3,(hl)              ; ¨Sonido protegido?
        ret nz                  ; S¡, retorna
        ld a,(ef_mezc)
        or $38
        ld (ef_mezc),a
        xor a
        ld (ef_vol1),a
        ld (ef_vol2),a
        ld (ef_vol3),a
        bit 1,(hl)              ; ¨En pausa?
        jp nz,arma_sonido       ; S¡, desactiva sonido
        bit 4,(hl)              ; ¨Sin sonido?
        jp nz,arma_sonido       ; S¡, desactiva sonido
        call genera_musica
        call genera_llave
        call genera_rescate
        call genera_tocado
        call genera_disparo
        call genera_explota
        call genera_monstruo
        call genera_megamonstruo
        call genera_berrido
        call genera_vida
        call genera_pierde
        ld hl,ef_band
        bit 6,(hl)
        jp nz,ritmo_rock
        bit 7,(hl)
        jp z,arma_sonido
        ;
        ; Ritmo carrerita
        ;
ritmo_carrera:
        ld hl,ef_ritmo
        ld a,(hl)
        ex af,af'
        inc (hl)
        ld a,(hl)
        cp 24
        jp nz,$+5
        ld (hl),0
        ex af,af'
        cp 3
        jp c,tambor_1
        cp 6
        jp z,tambor_2
        cp 12
        jp z,tambor_2
        jp arma_sonido

        ;
        ; Ritmo rock
        ;
ritmo_rock:
        ld hl,ef_ritmo
        ld a,(hl)
        ex af,af'
        inc (hl)
        ld a,(hl)
        cp 48
        jp nz,$+5
        ld (hl),0
        ex af,af'
        cp 3
        jp c,tambor_1
        cp 12
        jp z,tambor_2
        cp 24
        jp z,tambor_2
        cp 36
        jp z,tambor_2
        jp arma_sonido

tambor_1:
        ld a,$05
        ld (ef_ruido),a
        ld hl,ef_mezc
        res 4,(hl)
        jp arma_sonido

tambor_2:
        ld a,$08
        ld (ef_ruido),a
        ld hl,ef_mezc
        res 4,(hl)
        jp arma_sonido

arma_sonido:
        ld hl,ef_voz1
        xor a
.0:     ld e,(hl)
        call WRTPSG
        inc hl
        inc a
        cp $0b
        jp nz,.0
        ld hl,ef_env
        bit 1,(hl)
        ret z
        res 1,(hl)
        ld a,$0b
        ld e,$78
        call WRTPSG
        ld a,$0c
        ld e,$10
        call WRTPSG
        ld a,$0d
        ld e,$00
        jp WRTPSG

        ; Se ha tomado la llave
efecto_llave:
        push af
        push hl
        ld a,-1
        ld (ef_cont1),a
        ld hl,ef_band
        set 0,(hl)
        pop hl
        pop af
        ret

        ; Se ha rescatado a alguien
efecto_rescate:
        push af
        push hl
        ld a,-1
        ld (ef_cont2),a
        ld hl,ef_band
        set 1,(hl)
        pop hl
        pop af
        ret

        ; Se ha tocado un monstruo
efecto_tocado:
        push af
        push hl
        ld a,4
        ld (ef_cont3),a
        ld hl,128
        ld (ef_frec3),hl
        pop hl
        pop af
        ret
        
        ; Se ha disparado
efecto_disparo:
        push af
        push hl
        ld a,8
        ld (ef_cont4),a
        pop hl
        pop af
        ret

        ; La bala ha tocado algo
efecto_explota:
        push af
        push hl
        ld a,10
        ld (ef_cont5),a
        ld hl,3000
        ld (ef_frec5),hl
        pop hl
        pop af
        ret

        ; Un monstruo menos en el universo
efecto_monstruo:
        push af
        push hl
        ld a,10
        ld (ef_cont6),a
        ld hl,1000
        ld (ef_frec6),hl
        ld hl,750
        ld (ef_frec7),hl
        ld hl,500
        ld (ef_frec8),hl
        ld hl,ef_band
        set 2,(hl)
        pop hl
        pop af
        ret

        ; Un megamonstruo menos en el universo
efecto_megamonstruo:
        push af
        push hl
        ld a,40
        ld (ef_cont6),a
        ld hl,800
        ld (ef_frec6),hl
        ld hl,500
        ld (ef_frec7),hl
        ld hl,300
        ld (ef_frec8),hl
        ld hl,ef_band
        set 3,(hl)
        pop hl
        pop af
        ret

        ; El megamonstruo avisa que va a saltar
efecto_berrido:
        push af
        push hl
        ld a,(ix+d_ultimo+1)
        and $f0
        cp $20
        ld a,$80
        jp z,.1
        xor a
.1:     ld (ef_cont7),a
        ld hl,ef_band
        set 4,(hl)
        pop hl
        pop af
        ret

        ; Obtiene energ¡a o vida
efecto_vida:
        push af
        push hl
        xor a
        ld (ef_cont8),a
        ld hl,ef_band
        set 5,(hl)
        pop hl
        pop af
        ret

        ; Pierde una vida
efecto_pierde:
        push af
        push hl
        ld a,48
        ld (ef_cont9),a
        pop hl
        pop af
        ret

        ;
        ; Genera el efecto de sonido para la llave
        ;
genera_llave:
        ld hl,ef_band
        bit 0,(hl)
        ret z
        ld a,(ef_cont1)
        inc a
        ld (ef_cont1),a
        cp 32
        jp nz,.1
        res 0,(hl)
        ret

.1:     ld e,a
        and 3
        cp 3
        ld a,e
        ret nz
        and $1c
        rrca
        ld e,a
        ld d,0
        ld hl,.2
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

.2:     dw 453
        dw 226
        dw 453
        dw 226
        dw 359
        dw 180
        dw 301
        dw 150

        ;
        ; Genera el efecto de sonido para rescate de cient¡fico/a
        ;
genera_rescate:
        ld hl,ef_band
        bit 1,(hl)
        ret z
        ld a,(ef_cont2)
        inc a
        ld (ef_cont2),a
        cp 48
        jp nz,.1
        res 1,(hl)
        ret

.1:     ld e,a
        and 3
        cp 3
        ld a,e
        ret nz
        and $3c
        rrca
        ld e,a
        ld d,0
        ld hl,.2
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

.2:     dw 453
        dw 301
        dw 453
        dw 301
        dw 453
        dw 359
        dw 453
        dw 359
        dw 453
        dw 226
        dw 453
        dw 226

        ;
        ; Genera el efecto de sonido para jugador tocado
        ;
genera_tocado:
        ld hl,ef_cont3
        ld a,(hl)
        or a
        ret z
        dec (hl)
        ld hl,(ef_frec3)
        add hl,hl
        ld (ef_frec3),hl
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera el efecto de sonido para disparo
        ;
genera_disparo:
        ld hl,ef_cont4
        ld a,(hl)
        or a
        ret z
        dec a
        ld (hl),a
        add a,a
        ld e,a
        ld d,0
        ld hl,.1
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ; ef_frec4 no usado
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

.1:     dw $0f00
        dw $0e00
        dw $0c00
        dw $0a00
        dw $0800
        dw $0600
        dw $0400
        dw $0200

        ;
        ; Genera el efecto de sonido de bala explotando
        ;
genera_explota:
        ld hl,ef_cont5
        ld a,(hl)
        or a
        ret z
        dec (hl)
        ld hl,(ef_frec5)
        ld de,100
        add hl,de
        ld (ef_frec5),hl
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera el efecto de sonido de monstruo muerto
        ;
genera_monstruo:
        ld hl,ef_band
        bit 2,(hl)
        ret z
        ld a,(ef_cont6)
        dec a
        ld (ef_cont6),a
        jp nz,.1
        res 2,(hl)
.1:     sub 3
        jp nc,.1
        add a,3
        ld hl,(ef_frec6)
        ld de,50
        add hl,de
        ld (ef_frec6),hl
        or a
        jp nz,.2
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        xor a
.2:     ld hl,(ef_frec7)
        ld de,25
        add hl,de
        ld (ef_frec7),hl
        dec a
        jp nz,.3
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        xor a
.3:     ld hl,(ef_frec8)
        ld de,12
        add hl,de
        ld (ef_frec8),hl
        dec a
        ret nz
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera el efecto de sonido de megamonstruo muerto
        ;
genera_megamonstruo:
        ld hl,ef_band
        bit 3,(hl)
        ret z
        ld a,(ef_cont6)
        dec a
        ld (ef_cont6),a
        jp nz,.1
        res 3,(hl)
.1:     sub 3
        jp nc,.1
        add a,3
        ld hl,(ef_frec6)
        ld de,-20
        jp nz,.4
        ld de,40
.4:     add hl,de
        ld (ef_frec6),hl
        or a
        jp nz,.2
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        xor a
.2:     ld hl,(ef_frec7)
        ld de,5
        add hl,de
        ld (ef_frec7),hl
        dec a
        jp nz,.3
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        xor a
.3:     ld hl,(ef_frec8)
        ld de,2
        add hl,de
        ld (ef_frec8),hl
        dec a
        ret nz
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera el efecto de berrido del megamonstruo
        ;
genera_berrido:
        ld hl,ef_band
        bit 4,(hl)
        ret z
        ld a,(ef_cont7)
        ld b,a
        and $80
        ld c,a
        ld de,1000
        jp z,.2
        ld de,500
.2:     ld a,b
        inc a
        and $7f
        cp 25
        jp nz,.1
        res 4,(hl)
.1:     or c
        ld (ef_cont7),a
        and 6
        srl a
        ld h,a
        ld l,0
        srl h
        rr l
        add hl,de
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera el efecto de vida extra
        ;
genera_vida:
        ld hl,ef_band
        bit 5,(hl)
        ret z
        ld a,(ef_cont8)
        inc a
        ld (ef_cont8),a
        cp 49
        jp nz,.1
        res 5,(hl)
.1:     and 4
        ret nz
        ld a,(ef_cont8)
        ld l,a
        ld a,100
        sub l
        ld l,a
        ld h,0
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera el efecto de perder una vida
        ;
genera_pierde:
        ld a,(ef_cont9)
        or a
        ret z
        dec a
        ld (ef_cont9),a
        cp 47
        ld hl,318
        jp z,.1
        cp 31
        ld hl,348
        jp z,.1
        cp 15
        ld hl,428
        jp z,.1
        ld hl,(ef_frec9)
        ld d,h
        ld a,l
        srl d
        rra
        srl d
        rra
        srl d
        rra
        srl d
        rra
        srl d
        rra
        add hl,de
.1:     ld (ef_frec9),hl
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

