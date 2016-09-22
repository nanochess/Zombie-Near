        ;
        ; Sonido y m£sica de Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 12-ene-2011.
        ; Revisi¢n: 23-abr-2011. Redise¤ado para Coleco y su chip SN76489.
        ;

        ; M£sica general
musica_general:
        push hl
        ld a,(jug1+d_seccion)
        and $30
        ld l,a
        ld a,(jug2+d_seccion)
        and $30
        cp l
        jr nc,.1
        ld a,l
.1:     and $10
        ld a,$45        ; M£sica 1
        ld hl,melodia_principal
        jr z,.0
        ld a,$49        ; M£sica 2
        ld hl,melodia_2
.0:     jr pone_melodia

        ; M£sica de avance
musica_avance:
        push hl
        ld hl,melodia_avance
        jr pone_melodia_simple

        ; M£sica de esperando al monstruo :P
musica_esperando:
        push hl
        ld hl,melodia_esperando
        jr pone_melodia_simple

        ; M£sica de batalla
musica_batalla:
        push hl
;        ld a,8                  ; Forma de onda : \\\\
;        ld (ef_envm),a
;        Cambiar debajo 'ld a,$80' -> 'ld a,$90' para probar, suena feo
        ld hl,melodia_batalla
        ld a,$80
        jr pone_melodia

        ; M£sica de triunfo
musica_triunfo:
        push hl
        ld hl,melodia_triunfo
        jr pone_melodia_simple

        ; M£sica de fracaso
musica_fracaso:
        push hl
        ld hl,melodia_fracaso
        jr pone_melodia_simple

        ; M£sica final
musica_final:
        push hl
        ld hl,melodia_final
        jr pone_melodia_simple

        ;
        ; Inicia el sonido
        ;
inicia_sonido:
        ld a,$b8
        ld (ef_mezc),a
        ; M£sica silencio
musica_silencio:
        push hl
        ld hl,melodia_silencio
;        jr pone_melodia_simple

        ;
        ; Pone una nueva melod¡a.
        ; Entrada: A = bits 5-0 = Nuevo valor para ef_env
        ;              bits 7-6 = Bits correspondientes a ritmo en ef_band
        ;          HL = Apuntador a melod¡a
        ;
        ; No debe perder ning£n registro.
        ;
        ; La subrutina de explosi¢n y cambio en mueve_monstruos en ZW.ASM
        ; asume que BC no se pierde.
        ;
pone_melodia_simple:
        xor a
pone_melodia:
        di
        push bc
        ld c,a
        and $c0
        ld b,a
        ld a,(ef_band)
        and $3f
        or b
        ld (ef_band),a
        ld a,c
        and $3f
        ld (ef_env),a
        ld a,(hl)
        inc hl
        inc a
        srl a
        ld (ef_t),a
        xor a
        ld (ef_ritmo),a
        dec a           ; ld a,-1
        ld (ef_cn),a
        push de
        ld de,ef_ac1
        ld bc,3
        ldir
        pop de
        ld (ef_inicio),hl
        ld (ef_ap),hl
        ld hl,modo
        res 3,(hl)      ; Nuevamente permite acceso interrupci¢n al sonido
        ei
        pop bc
        pop hl          ; hl fue salvado antes de entrar a pone_melodia
        ret

        ;
        ; Genera la m£sica
        ;
genera_musica:
        ld a,(ef_env)
        rrca
        jp c,genera_musica_historia
        ld a,(ef_cn)
        inc a   ; cp -1
        jr nz,.1
        ;
        ; M£sica con acorde autom tico
        ;
        ld hl,(ef_ap)
        ld a,(hl)
        cp $fe          ; ¨Fin de m£sica?
        ret z           ; S¡, corta todo
        cp $fc          ; ¨Retorna a m£sica principal?
        jr nz,.6
        call musica_general
        jr genera_musica        ; Necesario, es otro estilo de m£sica

.6:     cp $fd          ; ¨Repetir?
        jr nz,.0
        ld hl,(ef_inicio)
        ld a,(hl)
.0:     inc hl
        ld (ef_ap),hl
        ld (ef_n),a     ; Nota principal
        ld (ef_b),a     ; Bajo
        xor a
        ld (ef_cn),a    ; Nota actual
        ld (ef_ta),a    ; Tiempo de nota
;        ld hl,ef_env
;        bit 4,(hl)
;        jr z,.1
;        set 1,(hl)      ; Reinicia envolvente
        ;
        ; Pone la nota en la voz actual, corta dos ticks antes del final
        ;
.1:     ld a,(ef_t)
        sub 2
        ld c,a
        ld a,(ef_ta)
        cp c
        jr nc,.5
        ld a,(ef_n)
        or a
        jr z,.5
        call nota_a_frec
        ld (ef_voz1),hl
        ld a,14
        ld (ef_vol1),a
        ;
        ; Pone el bajo en la segunda voz
        ;
.5:     ld a,(ef_b)
        or a
        jr z,.8
        call nota_a_frec
        ld (ef_voz2),hl
;        ld a,(ef_env)
;        and $10         ; ¨Bajo distorsionado?
;        jr nz,.9        ; S¡, salta (A ya contiene 16)
        ld a,13
.9:     ld (ef_vol2),a
;        add hl,hl       ; Divisi¢n entre 32
;        add hl,hl
;        add hl,hl
;        ld a,h
;        srl a           ; Para que la frecuencia se corra.
;        add a,h
;        ld l,a
;        ld h,0
;        ld (ef_envo),hl
        ;
        ; Cuenta el tiempo de nota
        ;
.8:     ld hl,ef_ta
        inc (hl)
        ld a,(ef_t)
        cp (hl)         ; ¨Termin¢?
        ret nz          ; No, retorna
        ld (hl),0       ; Reinicia contador
        ld hl,ef_cn
        inc (hl)        ; Cuenta nota
        ld a,(hl)
        dec a           ; ¨Segunda nota?
        jr nz,.2        ; No, salta
        ld a,(ef_n)
        or a
        ret z
        ld b,a
        ld a,(ef_ac1)
        add a,b         ; Desplaza por acorde 1
        ld (ef_n),a
        ret

.2:     dec a           ; ¨Tercera nota?
        jr nz,.3        ; No, salta
        ld a,(ef_n)
        or a
        ret z
        ld b,a
        ld a,(ef_ac2)
        add a,b         ; Desplaza por acorde 2
        ld (ef_n),a     
        ld a,(ef_b)
        sub 12          ; Desplaza bajo una octava abajo
        ld (ef_b),a
        ret

.3:     dec a           ; ¨Cuarta nota?
        jr nz,.4        ; No, salta
        ld a,(ef_n)
        or a
        ret z
        ld b,a
        ld a,(ef_ac3)
        add a,b         ; Desplaza por acorde 3
        ld (ef_n),a
        ret

.4:     dec a           ; ¨Todas las notas?
        ret nz          ; No, retorna.
        ld (hl),-1      ; Tiempo de cargar otra nota
        ret

        ;
        ; M£sica para historia
        ;
genera_musica_historia:
        ld a,(ef_cn)
        inc a   ; cp -1
        jr nz,.1
        ld hl,(ef_ap)
        ld a,(hl)       ; Lee primera voz
        cp $fe          ; ¨Fin de melod¡a?
        ret z           ; Se queda detenido
        cp $fd          ; ¨Repetici¢n?
        jr nz,.0
        ld a,(ef_ac1)
        xor 1           ; Posible intercambio de instrumento
        ld (ef_ac1),a
        ld hl,(ef_inicio)
        ld a,(hl)
.0:     inc hl
        cp $3f          ; ¨Sostenido?
        jr z,.4
        ld (ef_n),a
        push hl
        ld hl,ef_env
        set 1,(hl)      ; Indica que debe reiniciar envolvente
        pop hl
        xor a           ; Inicia contador para forma de instrumento
        ld (ef_ac2),a
.4:     ld a,(hl)       ; Lee segunda voz
        inc hl
        ld (ef_ap),hl
        bit 6,a         ; ¨Tambor 2?
        jr z,.12        ; No, salta
        ex af,af'
        ld a,$08        ; Frecuencia
        ld (ef_ruido),a
        ld a,1          ; Duraci¢n
        ld (ef_tamb),a
        ex af,af'
.12:    bit 7,a         ; ¨Tambor 1?
        jr z,.13        ; No, salta
        ex af,af'
        ld a,$05        ; Frecuencia
        ld (ef_ruido),a
        ld a,3          ; Duraci¢n
        ld (ef_tamb),a
        ex af,af'
.13:    and $3f
        cp $3f          ; ¨Sostenido?
        jr z,.5
        ld (ef_b),a
        xor a
        ld (ef_ac3),a
.5:     xor a
        ld (ef_cn),a
        ld (ef_ta),a
        ;
        ; Arma voz principal
        ;
.1:     ld a,(ef_n)     ; Lee nota
        or a            ; ¨Hay nota?
        jr z,.6         ; No, salta.
        call nota_a_frec
        ld a,(ef_env)
        and 12          ; Detecta tipo de melod¡a
        jr nz,.7
        ; Historia: piano y flauta
        ld (ef_voz2),hl ; Nota principal en voz 2
        ld a,16
        ld (ef_vol2),a
        srl h           ; Doble frecuencia en voz primaria para...
        rr l            ; ...generar piano
        jr .9

.7:     cp 4
        ld a,(ef_ac1)
        jr nz,.8
        ; Tema principal 1: flauta de pan y bajo
        or a
        ld a,(ef_ac2)   ; Tiempo para forma de instrumento
        jr nz,.15
        call instrumento_flauta_pan
        jr .9

.15:    call instrumento_piano
        jr .9

        ; Tema principal 2: flauta y bajo
.8:     or a
        ld a,(ef_ac2)
        jr nz,.15
        call instrumento_clarinete
.9:     ld (ef_voz1),hl
        ld (ef_vol1),a

        ;
        ; Arma voz secundaria
        ;
.6:     ld a,(ef_b)     ; Lee bajo
        or a            ; ¨Hay nota?
        jr z,.2         ; No, salta
        call nota_a_frec
        ld a,(ef_env)
        and 12          ; Detecta tipo de melod¡a
        jr nz,.10
        ; Historia: segunda voz.
        ld a,(ef_ac3)
        call instrumento_clarinete
        srl h                   ; A doble frecuencia
        rr l
        jr nc,$+3               ; Redondeo
        inc hl
        ld (ef_voz3),hl         ; Usa la voz de efectos
        ld (ef_vol3),a
        jr .2

        ; Temas principales: bajos
.10:    add hl,hl               ; Baja 2 octavas
        add hl,hl
        ; Demasiado para Coleco
;        ld a,(ef_t)
;        add a,a
;        ld d,a
;        ld a,(ef_ta)
;        cp d
;        jr c,.11
;        add hl,hl               ; Baja una octava en tiempo intermedio
.11:    ld (ef_voz2),hl
        ld a,(ef_ritmo)         ; Efecto wum del bajo
.14:    sub 12
        jr nc,.14
        add a,12
        ld e,a
        ld d,0
        ld hl,volumen_bajo
        add hl,de
        ld a,(hl)
        ld (ef_vol2),a
        ; Incrementa tiempo para forma de instrumento
.2:     ld a,(ef_ac2)
        inc a
        cp $18
        jr nz,$+4
        sub $08
        ld (ef_ac2),a
        ; Incrementa tiempo para forma de instrumento
        ld a,(ef_ac3)
        inc a
        cp $18
        jr nz,$+4
        sub $08
        ld (ef_ac3),a
        ld hl,ef_ta
        inc (hl)
        ld a,(ef_t)
        add a,a
        add a,a
        sub (hl)        ; ¨Acab¢ la nota?
        ret nz          ; No retorna
        ld (hl),a
        dec a           ; Prepara para traer otra nota
        ld (ef_cn),a
        ret

volumen_bajo:
;        db 10,10,9,8,7,6,6,7,8,9,10,10
        db 11,11,10,9,8,7,7,8,9,10,11,11

        ;
        ; Nota a frecuencia
        ;
nota_a_frec:
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_notas
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ret

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

clarinete_volumen:
        db 14,14,13,13,12,12,12,12
        db 11,11,11,11,12,12,12,12
        db 11,11,11,11,12,12,12,12

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
        jr nc,.1
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
                 
flauta_pan_volumen:
        db 13,13,12,12,12,12,12,12
        db 11,11,11,11,11,11,11,11
        db 11,11,11,11,11,11,11,11

        ;
        ; Genera un piano
        ; HL = Frecuencia.
        ; A = Tick instrumento.
        ;
        ; Salida:
        ; HL = Frecuencia.
        ; A = Volumen.
        ;
instrumento_piano:
        add a,piano_volumen and 255
        ld c,a
        ld a,piano_volumen>>8
        adc a,0
        ld b,a
        ld a,(bc)
        ret

piano_volumen:
        db 14,13,13,12,12,11,11,10
        db 10,9,9,8,8,7,7,6
        db 6,6,7,7,6,6,5,5

        ;
        ; Genera el sonido
        ;
genera_sonido:
        ld hl,modo
        bit 3,(hl)              ; ¨Sonido protegido?
        ret nz                  ; S¡, retorna
        ;
        ; Env¡a los datos del £ltimo ciclo al chip de sonido
        ;
        ; El tiempo en el que hace esto es relativamente el mismo 
        ; cada vez, as¡ no se notan peque¤os desplazamientos
        ;
        ld bc,$0380
        ld de,ef_voz1
.1:     ld a,(de)
        ld l,a
        and $0f
        or c
        out (PSG),a
        inc de
        ld a,(de)
        ld h,a
        inc de
        ld a,l
        srl h
        rra
        srl h
        rra
        srl h
        rra
        srl h
        rra
        and $3f
        out (PSG),a
        ld a,c
        add a,$20
        ld c,a
        djnz .1
        ld de,ef_vol1
        ld bc,$0390
.2:     ld a,(de)
        inc de
        cpl
        and $0f
        or c
        out (PSG),a
        ld a,c
        add a,$20
        ld c,a
        djnz .2
        ld a,(ef_ruido)
        sub 4
        and $0c
        rrca
        rrca
        or $ec
        out (PSG),a
        ld a,(ef_mezc)
        and $10
        ld a,$ff
        jr nz,.0
        ld a,(ef_vol2)
        cpl
        and $0f
        or $f0
.0:     out (PSG),a
        ld a,(ef_mezc)
        and $c0                 
        or $38
        ld (ef_mezc),a
        xor a
        ld (ef_vol1),a
        ld (ef_vol2),a
        ld (ef_vol3),a
        ld hl,modo
        bit 1,(hl)              ; ¨En pausa?
        ret nz                  ; S¡, desactiva sonido
        bit 4,(hl)              ; ¨Sin sonido?
        ret nz                  ; S¡, desactiva sonido
        call genera_musica
        call genera_llave
        call genera_rescate
        call genera_rasca
        call genera_tocado
        call genera_laser
        call genera_disparo
        call genera_explota
        call genera_monstruo
        call genera_megamonstruo
        call genera_berrido
        call genera_vida
        call genera_pierde
        ld hl,ef_band
        bit 6,(hl)
        jr nz,ritmo_variable
        bit 7,(hl)
        ret z
        ;
        ; Ritmo carrerita
        ;
ritmo_carrera:
        ld hl,ef_ritmo
        ld a,(hl)
        ex af,af'
        inc (hl)
        ld a,(hl)
        sub 24
        jr nz,$+3
        ld (hl),a
        ex af,af'
        cp 3
        jr c,tambor_1
        cp 6
        jr z,tambor_2
        cp 12
        jr z,tambor_2
        ret

        ;
        ; Ritmo variable
        ;
ritmo_variable:
        ld hl,ef_ritmo
        inc (hl)
        ld a,(hl)
        sub 48
        jr nz,$+3
        ld (hl),a
        ld hl,ef_tamb
        ld a,(hl)
        or a
        ret z
        dec (hl)
        jr activa_tambor

tambor_1:
        ld a,$05
        db $01  ; Viejo truco para saltar dos bytes

tambor_2:
        ld a,$08
        ld (ef_ruido),a
activa_tambor:
        ld hl,ef_mezc
        res 4,(hl)
        ret

        ; Se ha tomado la llave
efecto_llave:
        ld a,-1
        ld (ef_cont1),a
        ld hl,ef_band
        set 0,(hl)
        ret

        ; Se ha rescatado a alguien
efecto_rescate:
        ld a,-1
        ld (ef_cont2),a
        ld hl,ef_band
        set 1,(hl)
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
        ld hl,768
        ld (ef_frec5),hl
        pop hl
        pop af
        ret

        ; Un monstruo menos en el universo
efecto_monstruo:
        push af
        push hl
        ld a,(ef_band)
        bit 3,a         ; ¨Est  activo el efecto de magamonstruo?
        jr nz,.1        ; S¡, entonces no generar este sonido.
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
.1:     pop hl
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
        res 2,(hl)
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
        jr z,.1
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
        ld (ef_tipo9),a
        ld a,48
        ld (ef_cont9),a
        ret

        ; Disparo l ser
efecto_laser:
        ld a,25
        ld (ef_cont10),a
        ret

        ; Rasca
efecto_rasca:
        ld a,10
        ld (ef_cont11),a
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
        jr nz,.1
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
        jr nz,.1
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

.1:     dw $03c0
        dw $0380
        dw $0340
        dw $0300
        dw $02c0
        dw $0280
        dw $0240
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
        ld de,25
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
        jr nz,.1
        res 2,(hl)
.1:     sub 3
        jr nc,.1
        add a,3
        ld hl,(ef_frec6)
        ld de,2
        add hl,de
        ld (ef_frec6),hl
        or a
        jr nz,.2
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        xor a
.2:     ld hl,(ef_frec7)
        ld de,25
        add hl,de
        ld (ef_frec7),hl
        dec a
        jr nz,.3
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
        jr nz,.1
        res 3,(hl)
.1:     sub 3
        jr nc,.1
        add a,3
        ld hl,(ef_frec6)
        ld de,-20
        jr nz,.4
        ld de,40
.4:     add hl,de
        ld (ef_frec6),hl
        or a
        jr nz,.2
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        xor a
.2:     ld hl,(ef_frec7)
        ld de,5
        add hl,de
        ld (ef_frec7),hl
        dec a
        jr nz,.3
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
        ld de,500
        jr z,.2
        ld de,250
.2:     ld a,b
        inc a
        and $7f
        cp 25
        jr nz,.1
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
        jr nz,.1
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
        jr z,.1
        cp 31
        ld hl,348
        jr z,.1
        cp 15
        ld hl,428
        jr z,.1
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
        ld e,a
        add hl,de
.1:     ld (ef_frec9),hl
        ld a,(ef_tipo9)
        or a            ; 0 = Normal, otro valor = M s agudo
        jr z,.2
        srl h
        rr l
.2:     ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera el efecto de disparo l ser
        ;
genera_laser:
        ld a,(ef_cont10)
        or a
        ret z
        dec a
        ld (ef_cont10),a
        cp 24
        ld hl,150
        jr z,.1
        cp 16
        ld l,120
        jr z,.1
        cp 8
        ld l,90
        jr z,.1
        ld hl,(ef_frec10)
        ld a,l
        sub 10
        ld l,a
.1:     ld (ef_frec10),hl
        ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
        ret

        ;
        ; Genera un efecto de rascado
        ;
genera_rasca:
        ld hl,ef_cont11
        ld a,(hl)
        or a
        ret z
        dec (hl)
        add a,16
        ld (ef_ruido),a
        jp activa_tambor
