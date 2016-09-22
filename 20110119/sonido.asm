        ;
        ; Sonido y m£sica de Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 12-ene-2011. Se implementan los efectos de sonido. Se
        ;                        agrega ritmo preliminar.
        ; Revisi¢n: 13-ene-2011. Se integran las rutinas para melod¡as.
        ; Revisi¢n: 14-ene-2011. La melod¡a de historia ahora suena a piano y
        ;                        tiene ritmo. Se mejora el coro de la melod¡a
        ;                        principal.
        ; Revisi¢n: 15-ene-2011. Ajuste de envolvente.
        ; Revisi¢n: 19-ene-2011. Admite modo bit 4 para desactivar sonido.
        ;

        ; M£sica general
musica_general:
        xor a
        ld (ef_ritmo),a
        ld a,5
        ld (ef_env),a
        ld hl,ef_band
        set 6,(hl)
        res 7,(hl)
        ld hl,melodia_principal
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

melodia_silencio:       db 100,0,0,0,0,0,0,0,-1

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
        xor a
        ld (ef_b),a
        ei
        pop af
        ret

        ;
        ; Inicia el sonido
        ;
inicia_sonido:
        ld hl,modo
        set 3,(hl)
        ld a,$bf        ; Bits 7 y 6 deben ser 1 y 0 respectivamente
        ld (ef_mezc),a
        ld e,a
        ld a,$07        ; Mezclador
        call WRTPSG
        ld a,$08        ; Volumen canal A
        ld e,$0f
        call WRTPSG
        ld a,$09        ; Volumen canal B
        ld e,$0f
        call WRTPSG
        ld a,$0a        ; Volumen canal C
        ld e,$0f
        call WRTPSG
        ld hl,modo
        res 3,(hl)
        ret

        ;
        ; Genera la m£sica
        ;
genera_musica:
        ld a,(ef_env)
        bit 0,a
        jp nz,genera_musica_simple
        ld a,(ef_cn)
        cp -1
        jp nz,.1
        ld hl,(ef_ap)
        ld a,(hl)
        cp -1
        jp z,.7
        cp -3
        call z,musica_general
        cp -2
        jp nz,.0
        ld hl,(ef_inicio)
        ld a,(hl)
.0:     inc hl
        ld (ef_ap),hl
        ld (ef_n),a
        ld (ef_b),a
        xor a
        ld (ef_cn),a
        ld (ef_ta),a
.1:     ld a,(ef_n)
        ld b,a
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(ef_t)
        sub 2
        ld c,a
        ld a,(ef_ta)
        cp c
        jp nc,.5
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ld (ef_voz1),hl
.5:     ld a,(ef_b)
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
        ld hl,ef_ta
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
        ld a,(ef_ac1)
        add a,b
        ld (ef_n),a
        ret

.2:     cp 2
        jp nz,.3
        ld a,(ef_ac2)
        add a,b
        ld (ef_n),a
        ld a,(ef_b)
        or a
        ret z
        sub 12
        ld (ef_b),a
        ret

.3:     cp 3
        jp nz,.4
        ld a,(ef_ac3)
        add a,b
        ld (ef_n),a
        ret

.4:     cp 4
        ret nz
        ld (hl),-1
        ld a,(ef_b)
        or a
        ret z
        add a,12
        ld (ef_b),a
        ret

.7:     xor a
        ld (ef_b),a
        ret

genera_musica_simple:
        bit 2,a
        jp nz,genera_musica_general
        ld a,(ef_cn)
        cp -1
        jp nz,.1
        ld hl,(ef_ap)
        ld a,(hl)
        cp -1
        ret z
        inc hl
        ld (ef_ap),hl
        ld (ef_n),a
        xor a
        ld (ef_cn),a
        ld (ef_ta),a
        ld hl,ef_env
        set 1,(hl)
.1:     ld a,(ef_n)
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
        srl h
        rr l
        ld (ef_voz2),hl
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

genera_musica_general:
        ld a,(ef_cn)
        cp -1
        jp nz,.1
        ld hl,(ef_ap)
        ld a,(hl)
        cp -2
        jp nz,.0
        ld hl,(ef_inicio)
        ld a,(hl)
.0:     inc hl
        ld (ef_ap),hl
        ld (ef_n),a
        ld a,(ef_inicio)
        inc a
        ld h,a
        ld a,l
        sub h
        srl a
        srl a
        ld l,a
        ld h,0
        ld de,acordes
        add hl,de
        ld a,(hl)
        ld (ef_b),a
        xor a
        ld (ef_cn),a
        ld (ef_ta),a
        ld hl,ef_env
        set 1,(hl)
.1:     ld a,(ef_n)
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        or h
        jp z,.4
        ld a,(ef_ta)
        add a,a
        add a,vibrato and 255
        ld e,a
        ld a,d
        adc a,vibrato>>8
        ld d,a
        ld a,(de)
        add a,l
        ld l,a
        inc de
        ld a,(de)
        adc a,h
        ld h,a
.4:     ld a,(ef_ta)
        and 1
        jp z,.2
        add hl,hl
.2:     ld (ef_voz1),hl
        ld a,(ef_b)
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        or h
        jp z,.3
        add hl,hl
        add hl,hl
        ld a,(ef_t)
        srl a
        ld d,a
        ld a,(ef_ta)
        cp d
        jp c,.3
        add hl,hl
.3:     ld (ef_voz2),hl
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

acordes:
        db $25,$25,$22,$22
        db $25,$25,$22,$22
        db $25,$25,$24,$24
        db $23,$23,$25,$25
        db $24,$24,$23,$23
        db $25,$25,$25,$22
        db $22,$22,$25,$2c
        db $2b,$2b,$25,$2c
        db $2d,$2d,$25,$25
        db $25,$25,$25,$25
        db $25,$25

vibrato:
        dw 0
        dw 0
        dw 0
        dw 0
        dw -1
        dw -2
        dw -1
        dw 0
        dw 1
        dw 2
        dw 1
        dw 0
        dw -1
        dw -2
        dw -1
        dw 0
        dw 1
        dw 2
        dw 1
        dw 0

        ;
        ; Genera el sonido
        ;
genera_sonido:
        ld hl,modo
        bit 3,(hl)              ; ¨Sonido protegido?
        ret nz                  ; S¡, retorna
        ld hl,0
        ld (ef_voz1),hl
        ld (ef_voz2),hl
        ld (ef_voz3),hl
        ld hl,modo
        bit 1,(hl)              ; ¨En pausa?
        jp nz,sin_tambor        ; S¡, desactiva sonido.
        bit 4,(hl)              ; ¨Sin sonido?
        jp nz,sin_tambor        ; S¡, desactiva sonido.
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
        ld hl,ef_band
        bit 6,(hl)
        jp nz,ritmo_rock
        bit 7,(hl)
        jp nz,ritmo_carrera
        jp sin_tambor

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
sin_tambor:
        ld hl,ef_mezc
        set 4,(hl)
        jp arma_sonido

tambor_1:
        ld a,$06
        ld e,$05
        call WRTPSG
        ld hl,ef_mezc
        res 4,(hl)
        jp arma_sonido

tambor_2:
        ld a,$06
        ld e,$08
        call WRTPSG
        ld hl,ef_mezc
        res 4,(hl)
        jp arma_sonido

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
        jp sin_tambor

arma_sonido:
        ld hl,(ef_voz1)
        ld a,h
        or l
        jp nz,.4
        ld hl,ef_mezc
        set 0,(hl)
        jp .5

.4:     ld a,$00
        ld e,l
        call WRTPSG
        ld a,$01
        ld e,h
        call WRTPSG
        ld hl,ef_mezc
        res 0,(hl)
.5:     ld hl,(ef_voz2)
        ld a,h
        or l
        jp nz,.2
        ld hl,ef_mezc
        set 1,(hl)
        jp .3

.2:     ld a,$02
        ld e,l
        call WRTPSG
        ld a,$03
        ld e,h
        call WRTPSG
        ld hl,ef_mezc
        res 1,(hl)
.3:     ld hl,(ef_voz3)
        ld a,h
        or l
        jp nz,.1
        ld hl,ef_mezc
        set 2,(hl)
        jp .7

.1:     ld a,$04
        ld e,l
        call WRTPSG
        ld a,$05
        ld e,h
        call WRTPSG
        ld hl,ef_mezc
        res 2,(hl)
.7:     ld e,(hl)
        ld a,$07
        call WRTPSG
        ld hl,ef_env
        ld e,12
        bit 0,(hl)
        jp z,.6
        bit 2,(hl)
        jp nz,.6
        ld e,16
        bit 1,(hl)
        jp z,.6
        res 1,(hl)
        ld a,$0b
        ld e,$78
        call WRTPSG
        ld a,$0c
        ld e,$08
        call WRTPSG
        ld a,$0d
        ld e,$00
        call WRTPSG
        ld e,16
.6:     ld a,$08
        call WRTPSG
        ld a,$09
        call WRTPSG
        ret

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
        xor a
        ld (ef_cont7),a
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
.2:     ld hl,(ef_frec7)
        ld de,25
        add hl,de
        ld (ef_frec7),hl
        dec a
        jp nz,.3
        ld (ef_voz3),hl
.3:     ld hl,(ef_frec8)
        ld de,12
        add hl,de
        ld (ef_frec8),hl
        dec a
        ret nz
        ld (ef_voz3),hl
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
.2:     ld hl,(ef_frec7)
        ld de,5
        add hl,de
        ld (ef_frec7),hl
        dec a
        jp nz,.3
        ld (ef_voz3),hl
.3:     ld hl,(ef_frec8)
        ld de,2
        add hl,de
        ld (ef_frec8),hl
        dec a
        ret nz
        ld (ef_voz3),hl
        ret

        ;
        ; Genera el efecto de berrido del megamonstruo
        ;
genera_berrido:
        ld hl,ef_band
        bit 4,(hl)
        ret z
        ld a,(ef_cont7)
        inc a
        ld (ef_cont7),a
        cp 25
        jp nz,.1
        res 4,(hl)
.1:     and 1
        ret nz
        ld a,(ef_cont7)
        and 6
        srl a
        ld d,a
        ld e,0
        srl d
        rr e
        ld hl,2000
        add hl,de
        ld (ef_voz3),hl
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
        ret
