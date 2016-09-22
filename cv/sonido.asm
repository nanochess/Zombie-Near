        ;
        ; Sonido y m£sica de Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011-2013 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 12-ene-2011.
        ; Revisi¢n: 23-abr-2011. Redise¤ado para Coleco y su chip SN76489.
        ; Revisi¢n: 09-may-2011. genera_sonido se optimiza un poco m s. Se
        ;                        elimina c¢digo que tocaba melod¡a de
        ;                        historia.
        ; Revisi¢n: 11-may-2011. M s optimizaci¢n en genera_sonido.
        ; Revisi¢n: 13-may-2011. Se pone c¢digo de melod¡a de historia.
        ; Revisi¢n: 14-may-2011. Mejoras en la reproducci¢n de temas
        ;                        principales.
        ; Revisi¢n: 15-may-2011. Mejora en percusi¢n. Se optimiza el c¢digo
        ;                        de sonido.
        ; Revisi¢n: 17-may-2011. Se quita DI/EI en pone_melodia. Se reduce el
        ;                        c¢digo de instrumentos y se optimizan
        ;                        algunos efectos de sonido. La m£sica se
        ;                        conserva ahora en el VRAM. Evita volver a
        ;                        iniciar registro de ruido si es el mismo
        ;                        valor que antes, esto evita una distorsi¢n
        ;                        que ocurre por que se reinicia el LFSR del
        ;                        SN76489.
        ; Revisi¢n: 28-jun-2011. Se vuelve a poner la m£sica en ROM.
        ; Revisi¢n: 26-jun-2013. Se actualiza el reproductor de m£sica para
        ;                        utilizar el formato de Bemol.
        ; Revisi¢n: 27-jun-2013. Se agrega musica_batalla2.
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

    ifdef SLOT_1
        ;
        ; Convierte volumen AY-3-8910 a SN76489
        ;
tabla_vol:
        db $0f,$0f,$0f,$0e,$0e,$0e,$0d,$0b,$0a,$08,$07,$05,$04,$03,$01,$00
    endif

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
        ld a,1          ; M£sica 1
        jr z,.0
        ld a,2          ; M£sica 2
.0:     jr pone_melodia

        ; M£sica historia
musica_historia:
        push hl
        ld a,9
        jr pone_melodia

        ; M£sica amor
musica_amor:
        push hl
        ld a,3
        jr pone_melodia

        ; M£sica de avance
musica_avance:
        push hl
        ld a,4
        jr pone_melodia

        ; M£sica de esperando al monstruo :P
musica_esperando:
        push hl
        ld a,6
        jr pone_melodia

        ; M£sica de batalla (cuando se pelea con monstruo)
musica_batalla:
        push hl
        ld a,5
        jr pone_melodia

        ; M£sica de batalla (cuando se pelea con monstruo grande)
musica_batalla2:
        push hl
        ld a,11
        jr pone_melodia

        ; M£sica de triunfo (al matar monstruo o abrir puerta)
musica_triunfo:
        push hl
        ld a,10
        jr pone_melodia

        ; M£sica de fracaso (game over)
musica_fracaso:
        push hl
        ld a,8
        jr pone_melodia

        ; M£sica final (cuando se gana el juego)
musica_final:
        push hl
        ld a,7
        jr pone_melodia

        ;
        ; Inicia chip SN76489, necesario si no se empieza con logo Coleco
        ;
psg_silencio:
        ld a,$9f
        out (PSG),a
        ld a,$bf
        out (PSG),a
        ld a,$df
        out (PSG),a
        ld a,$ff
        out (PSG),a
        ld (ef_envm),a
        ld a,$ec
        out (PSG),a
        ld (ef_cont),a
        ret

        ;
        ; Inicia el sonido
        ;
inicia_sonido:
        call psg_silencio
        ld a,$b8
        ld (ef_mezc),a
    ifdef SGM                   ; Eco en efectos de sonido
        ld (ef2_mezc),a
    endif
        ; M£sica silencio
musica_silencio:
        push hl
        xor a
        ;
        ; Pone una nueva melod¡a.
        ; Entrada: A = N£mero de melod¡a
        ;
        ; No debe perder ning£n registro.
        ;
        ; La subrutina de explosi¢n y cambio en mueve_monstruos en ZW.ASM
        ; asume que BC no se pierde.
        ;
pone_melodia:
        push bc
        push de
        ld e,a
        ld d,0
        ld hl,tabla_melodias
        add hl,de
        add hl,de
    ifdef SLOT_1
        call zona_dura
    else
        di
    endif
        ld a,1
        ld (ef_cn),a
        call lee_4_bytes
    ifdef SLOT_1
    else
        di
    endif
        ld l,b
        ld h,c
        inc hl
        ld (ef_inicio),hl
        ld (ef_ap),hl
        dec hl
        call lee_4_bytes
        ld a,b          ; Obtiene tiempo (bits 5-0) y formato (bit 7)
        ld (ef_t),a
        xor a
        ld (ef_cn),a
        ld hl,modo
        res 3,(hl)      ; Nuevamente permite acceso interrupci¢n al sonido
    ifdef SLOT_1
        call zona_facil
    else
        ei
    endif
        pop de
        pop bc
        pop hl
        ret

        ;
        ; Lee 4 bytes
        ;
lee_4_bytes:
    ifdef SLOT_1
        ld a,(SLOT_3)   ; Colecovision
        nop
    endif
        ld b,(hl)
        inc hl
        ld c,(hl)
        inc hl
        ld d,(hl)
        inc hl
        ld e,(hl)
    ifdef SLOT_1
        ld a,(SLOT_0)   ; Colecovision
    endif
        ret

        ;
        ; Genera la m£sica
        ;
genera_musica:
    ifdef SLOT_1
    else
        ld a,(fm_act)
        or a
        jp nz,genera_musica_fm
    endif
        ld a,(ef_cn)
        or a
        jp nz,.6
        ld hl,(ef_ap)
.15:    push hl
        call lee_4_bytes
        pop hl
        ld a,(ef_t)
        rlca
        jr nc,.16
        ld e,d
        ld d,0
        jr .17

.16:    rlca
        jr nc,.17
        ld e,0
.17:    ld a,b          ; Lee primera voz
        cp -2           ; ¨Fin de melod¡a?
        ret z           ; Se queda detenido
        cp -4           ; ¨Vuelve a melod¡a general?
        jr nz,.12
        call musica_general
        ld hl,(ef_inicio)
        jr .15

.12:    cp -3           ; ¨Repetici¢n?
        jp nz,.0
        ld hl,(ef_inicio)
        jr .15

.0:     ld a,(ef_t)
        and $3f         ; Reinicio tiempo de nota
        ld (ef_cn),a
        ld a,b
        cp $3f          ; ¨Sostenido?
        jr z,.1
        rlca
        rlca
        and 3
        ld (ef_i1),a    ; Instrumento
        ld a,b
        and $3f
        ld (ef_n1),a    ; Nota
        xor a         
        ld (ef_f1),a    ; Forma
.1:     ld a,c          ; Lee segunda voz
        cp $3f          ; ¨Sostenido?
        jr z,.2
        rlca
        rlca
        and 3
        ld (ef_i2),a    ; Instrumento
        ld a,c
        and $3f
        ld (ef_n2),a    ; Nota
        xor a         
        ld (ef_f2),a    ; Forma
.2:     ld a,d          ; Lee tercera voz
        cp $3f          ; ¨Sostenido?
        jr z,.3
        rlca
        rlca
        and 3
        ld (ef_i3),a    ; Instrumento
        ld a,d
        and $3f
        ld (ef_n3),a    ; Nota
        xor a         
        ld (ef_f3),a    ; Forma
.3:     ld a,e          ; Lee efecto
        ld (ef_n4),a
        xor a
        ld (ef_f4),a
        inc hl
        inc hl
        inc hl
        ld a,(ef_t)
        and $c0
        jr nz,.14
        inc hl
.14:    ld (ef_ap),hl
        ;
        ; Arma voz principal
        ;
.6:     ld a,(ef_n1)    ; Lee nota
        or a            ; ¨Hay nota?
        jr z,.7         ; No, salta.
        ld bc,(ef_i1)
        call nota_a_frec
        ld (ef_voz1),hl ; Nota principal en voz 1
        ld (ef_vol1),a
    ifdef SGM
        ld bc,(ef_i1)
        call efecto_sgm
        ld (ef2_voz1),hl
        ld (ef2_vol1),a
    endif
.7:     ld a,(ef_n2)    ; Lee nota
        or a            ; ¨Hay nota?
        jr z,.8         ; No, salta.
        ld bc,(ef_i2)
        call nota_a_frec
    ifdef SLOT_1
        push af
        ld a,(ef_i2)
        cp 3            ; ¨Bajo?
        jr z,.13        ; S¡, salta a tratamiento especial
        pop af
    endif
        ld (ef_voz2),hl ; Nota principal en voz 2
        ld (ef_vol2),a
    ifdef SLOT_1
        jr .18

.13:    pop af
        ld (ef_envo),hl
        ld (ef_jeje),a
.18:
    ifdef SGM
        ld bc,(ef_i2)
        call efecto_sgm
        ld (ef2_voz2),hl
        ld (ef2_vol2),a
    endif
    endif
.8:     ld a,(ef_n3)    ; Lee nota
        or a            ; ¨Hay nota?
        jr z,.9         ; No, salta.
        ld bc,(ef_i3)
        call nota_a_frec
        ld (ef_voz3),hl ; Nota principal en voz 3
        ld (ef_vol3),a
    ifdef SGM
        ld bc,(ef_i3)
        call efecto_sgm
        ld (ef2_voz3),hl
        ld (ef2_vol3),a
    endif
.9:     ld a,(ef_n4)    ; Lee efecto
        or a            ; ¨Hay efecto?
        jr z,.4         ; No, salta.
        dec a           ; 1 - Tambor largo.
        jr nz,.5
        ld a,(ef_f4)
        cp 3
        jp nc,.4
.10:    ld a,5
        ld (ef_ruido),a
    ifdef SGM
        ld (ef2_ruido),a
    endif
        call activa_tambor
        jr .4

.5:     dec a           ; 2 - Tambor corto
        jr nz,.11
        ld a,(ef_f4)
        or a
        jp nz,.4
        ld a,8
        ld (ef_ruido),a
    ifdef SGM
        ld (ef2_ruido),a
    endif
        call activa_tambor
        jr .4

.11:    ;dec a           ; 3 - Redoble
        ;jp nz,.4
        ld a,(ef_t)
        and $3e
        rrca
        ld b,a
        ld a,(ef_f4)
        cp 2
        jp c,.10
        cp b
        jp c,.4
        dec a
        dec a
        cp b
        jp c,.10
.4:
        ; Incrementa tiempo para forma de instrumento
        ld a,(ef_f1)
        inc a
        cp $18
        jp nz,$+5
        sub $08
        ld (ef_f1),a
        ; Incrementa tiempo para forma de instrumento
        ld a,(ef_f2)
        inc a
        cp $18
        jp nz,$+5
        sub $08
        ld (ef_f2),a
        ; Incrementa tiempo para forma de instrumento
        ld a,(ef_f3)
        inc a
        cp $18
        jp nz,$+5
        sub $08
        ld (ef_f3),a
        ; Incrementa tiempo para forma de efecto
        ld hl,ef_f4
        inc (hl)
        ld hl,ef_cn
        dec (hl)
        ret

    ifdef SGM
        ;
        ; Efecto para Super Game Module
        ; C = Instrumento
        ;
efecto_sgm:
        dec c
        jp z,.2
        dec c
        jp z,.2
        dec c
        ret z
        add hl,hl
        dec hl
        ret

.2:     inc hl
        ret
    endif

        ;
        ; Convierte n£mero de nota a frecuencia
        ; A = Nota
        ; B = Forma de instrumento
        ; C = Instrumento
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
        ld a,c
        or a
        jp z,instrumento_piano
        dec a
        jp z,instrumento_clarinete
        dec a
        jp z,instrumento_flauta_pan
        ;
        ; Genera un bajo
        ;
instrumento_bajo:
        add hl,hl               ; Baja 2 octavas
        add hl,hl
        ld a,(ef_t)
        and $3e
        rrca
        ld d,a
        ld a,(ef_cn)
        cp d
        jr nc,.1
        add hl,hl               ; Baja una octava en tiempo intermedio
.1:     ld c,b                  ; Efecto wum del bajo
        ld b,0
        ld de,volumen_bajo
        ex de,hl
        add hl,bc
        ex de,hl
        ld a,(de)
        ret

volumen_bajo:
        db 11,10,9,8,7,6,6,7,8,9,10,11
        db 11,10,9,8,7,6,6,7,8,9,10,11

        ;
        ; Genera un piano
        ; HL = Frecuencia.
        ; B = Tick instrumento.
        ;
        ; Salida:
        ; HL = Frecuencia.
        ; A = Volumen.
        ;
instrumento_piano:
        ld a,b
        add a,piano_volumen and 255
        ld c,a
        adc a,piano_volumen>>8
        sub c
        ld b,a
        ld a,(bc)
        ret

piano_volumen:
        db 14,13,13,12,12,11,11,10
        db 10,9,9,8,8,7,7,6
        db 6,6,7,7,6,6,5,5

        ;
        ; Genera un clarinete
        ; HL = Frecuencia.
        ; B = Tick instrumento.
        ;
        ; Salida:
        ; HL = Frecuencia.
        ; A = Volumen.
        ;
instrumento_clarinete:
        ld a,b
        add a,clarinete_vibrato and 255
        ld c,a
        adc a,clarinete_vibrato>>8
        sub c
        ld b,a
        ld a,(bc)
        ld e,a
        rlca
        sbc a,a
        ld d,a
        add hl,de
        srl h           ; Duplica la frecuencia
        rr l
        jp nc,.1
        inc hl
.1:     ld a,c
        add a,24
        ld c,a
        adc a,b
        sub c
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
        db 13,14,14,13,13,12,12,12
        db 11,11,11,11,12,12,12,12
        db 11,11,11,11,12,12,12,12

        ;
        ; Genera una flauta de pan
        ; HL = Frecuencia.
        ; B = Tick instrumento.
        ;
        ; Salida:
        ; HL = Frecuencia.
        ; A = Volumen.
        ;
instrumento_flauta_pan:
        ld a,b
        add a,flauta_vibrato and 255
        ld c,a
        adc a,flauta_vibrato>>8
        sub c
        ld b,a
        ld a,(bc)
        ld e,a
        rlca
        sbc a,a
        ld d,a
        add hl,de
        ld a,c
        sub flauta_vibrato and 255
        rrca
        jr nc,.1
        add hl,hl
.1:     rlca
        ld a,c
        add a,24
        ld c,a
        adc a,b
        sub c
        ld b,a
        ld a,(bc)
        ret

flauta_vibrato:
        db 0,0,0,0
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
        db 0,1,2,1
                 
flauta_volumen:
        db 13,13,12,12,12,12,12,12
        db 11,11,11,11,11,11,11,11
        db 11,11,11,11,11,11,11,11

        ;
        ; Emite el sonido
        ;
        ; El tiempo en el que hace esto es relativamente el mismo 
        ; cada vez, as¡ no se notan peque¤os desplazamientos
        ;
emite_sonido:
    ifdef SLOT_1
    ifdef SGM
        ld bc,$0b00
        ld hl,ef2_voz1
.002:   ld a,c
        out (PSG2+$00),a
        inc c
        ld a,(hl)
        out (PSG2+$01),a
        inc hl
        djnz .002
    endif
        ;
        ; Si la voz 2 no se utiliza (algo com£n al jugar por el bajo),
        ; entonces pasa la voz 3 a la 2, para que el bajo suene todo el
        ; tiempo posible.
        ;
        ld a,(ef_vol2)
        or a
        jp nz,.7
        ld a,(ef_vol3)
        or a
        jp z,.7
        ld (ef_vol2),a
        xor a
        ld (ef_vol3),a
        ld hl,(ef_voz3)
        ld (ef_voz2),hl
.7:
        ;
        ; Arma voz 1 en formato SN76489
        ;
        ld hl,(ef_voz1)
        ld a,h
        cp 4
        ld a,$9f
        jp nc,.1
        ld a,l
        and $0f
        or $80
        out (PSG),a
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        ld a,h
        out (PSG),a
        ld a,(ef_vol1)
        add a,tabla_vol and 255
        ld l,a
        adc a,tabla_vol>>8
        sub l
        ld h,a
        ld a,(hl)
        or $90
.1:     out (PSG),a
        ;
        ; Arma voz 2 en formato SN76489
        ;
        ld hl,(ef_voz2)
        ld a,h
        cp 4
        ld a,$bf
        jp nc,.2
        ld a,l
        and $0f
        or $a0
        out (PSG),a
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        ld a,h
        out (PSG),a
        ld a,(ef_vol2)
        add a,tabla_vol and 255
        ld l,a
        adc a,tabla_vol>>8
        sub l
        ld h,a
        ld a,(hl)
        or $b0
.2:     out (PSG),a
        ;
        ; Arma voz 3 en formato SN76489
        ;
        ld hl,(ef_voz3)
        ld a,h
        cp 4
        ld a,$df
        jp nc,.3
        ld a,l
        and $0f
        or $c0
        out (PSG),a
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        ld a,h
        out (PSG),a
        ld a,(ef_vol3)
        add a,tabla_vol and 255
        ld l,a
        adc a,tabla_vol>>8
        sub l
        ld h,a
        ld a,(hl)
        or $d0
.3:     out (PSG),a
        ld a,(ef_envm)
        cp $ff          ; ¨Est  poniendo tambor?
        jr nz,.6        ; S¡, salta.
        ld a,(ef_vol3)
        or a            ; ¨Volumen 3 activo?
        jr nz,.6        ; S¡, salta.
        ld a,(ef_jeje)
        or a            ; ¨Volumen 3 superbajo activo?
        jr z,.6         ; No, salta.
        add a,tabla_vol and 255
        ld l,a
        adc a,tabla_vol>>8
        sub l
        ld h,a
        ld a,(hl)
        or $f0
        ld (ef_envm),a
        ld hl,(ef_envo)
        ld d,h
        ld e,l
        add hl,hl       ; Multiplica por 17
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,de
        rr h            ; Bit de sobrepasamiento
        ld l,h          ; Termina dividiendo entre 512
        ld h,0
        jr nc,$+3
        inc hl
        ld a,l
        and $0f
        or $c0
        out (PSG),a
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        ld a,h
        and $3f
        out (PSG),a
        ld b,$eb        ; Ruido como canal modulado de audio por frec. 3
        jp .5

.6:     ld a,(ef_envm)
        inc a           ; ¨Tambor activo?
        jr z,.4         ; No, salta.
        ld a,(ef_ruido)
        cp 16
        ld b,$ec        ; Equivale a AY-3-8910 (sound 6,16)
        jp c,.5
        ld b,$ed        ; Equivale a AY-3-8910 (sound 6,32) (imposible)
;       ld b,$ee        ; Equivale a AY-3-8910 (sound 6,64) (imposible)
.5:     ld a,(ef_cont)
        cp b
        jr z,.4
        ld a,b
        ld (ef_cont),a
        out (PSG),a
.4:     ld a,(ef_envm)
        out (PSG),a
        ld a,$ff
        ld (ef_envm),a
        ret
    else
        ld a,(ef_envm)
        inc a        
        ld d,$0b
        jr z,.001
        ld d,$0e
.001:   ld hl,ef_voz1
        xor a
.000:   ld e,(hl)
        call WRTPSG
        inc hl
        inc a
        cp d
        jr nz,.000
        ld a,$ff
        ld (ef_envm),a
    endif
        ret

        ;
        ; Genera el sonido
        ;
genera_sonido:
        ld hl,modo
        bit 3,(hl)              ; ¨Sonido protegido?
        ret nz                  ; S¡, retorna
        call emite_sonido
        ;
        ; El AY-3-8910 es una cosa rara, al desactivar un canal en el
        ; mezclador lo que se hace efectivamente es poner a 1 la salida
        ; que implica meter todo el volumen, as¡ que es m s f cil poner
        ; volumen a 0 y dejar todo activado.
        ;
        ld a,(ef_mezc)
        and $c0                 
        or $38
        ld (ef_mezc),a
    ifdef SGM                   ; Eco en efectos de sonido
        ld (ef2_mezc),a
        ld hl,(ef_voz3)
        ld a,(ef_vol3)
        ld (ef2_voz3),hl
        ld (ef2_vol3),a
    endif
        xor a                   ; Apaga los tres canales de sonido
        ld l,a
        ld h,a
        ld (ef_vol1),hl         ; ef_vol1/ef_vol2
        ld (ef_vol3),a
    ifdef SLOT_1
        ld (ef_jeje),a
    endif
    ifdef SGM
        ld (ef2_vol1),hl        ; ef2_vol1/ef2_vol2
    endif
        ld a,(modo)
        and $18                 ; ¨En pausa o sin sonido?
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
        jp genera_pierde

        ;
        ; Efectos de sonido
        ;

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
        or a
        jr z,.1
        ld a,$80
.1:     or 48
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

.1:     ld hl,.2
voz32:  ld e,a
        and 3
        cp 3
        ld a,e
        ret nz
        and $fc
        rrca
voz31:  ld e,a
        ld d,0
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
voz3:   ld (ef_voz3),hl
        ld a,15
        ld (ef_vol3),a
sin_ruido_blanco:
    ifdef SLOT_1
        ld a,$ff
        ld (ef_envm),a
    ifdef SGM
        ld hl,ef2_mezc
        set 5,(hl)
    endif
    else
        ld hl,ef_mezc
        set 5,(hl)
    endif
        ret

genera_llave.2:
        dw 453
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

.1:     ld hl,.2
        jp voz32

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
        dec a
        ret m
        ld (hl),a
        ld hl,.1
        ld e,a
        ld d,0
        add hl,de
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        jp voz3

.1:     dw 512,256,128,64   

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
        ld hl,.1
        jp voz31

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
        dec a
        ret m
        ld (hl),a
        ld hl,.1
        ld e,a
        ld d,0
        add hl,de
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        jp voz3

.1:     dw 1018
        dw 993
        dw 968
        dw 943
        dw 918
        dw 893
        dw 868
        dw 843
        dw 818
        dw 793

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
        call voz3
        xor a
.2:     ld hl,(ef_frec7)
        ld de,25
        add hl,de
        ld (ef_frec7),hl
        dec a
        jr nz,.3
        call voz3
        xor a
.3:     ld hl,(ef_frec8)
        ld de,12
        add hl,de
        ld (ef_frec8),hl
        dec a
        ret nz
        jp voz3

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
        call voz3
        xor a
.2:     ld hl,(ef_frec7)
        ld de,5
        add hl,de
        ld (ef_frec7),hl
        dec a
        jr nz,.3
        call voz3
        xor a
.3:     ld hl,(ef_frec8)
        inc hl
        inc hl
        ld (ef_frec8),hl
        dec a
        ret nz
        jp voz3

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
        jp voz3

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
        jp voz3

        ;
        ; Genera el efecto de perder una vida
        ;
genera_pierde:
        ld a,(ef_cont9)
        ld b,a
        and $7f
        ret z
        ld a,b
        dec a
        ld (ef_cont9),a
        and $7f
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
        ld e,l
        add hl,hl
        add hl,hl
        add hl,hl
        ld l,h
        ld h,0
        add hl,de
.1:     ld (ef_frec9),hl
        rlc b           ; 0 = Normal, otro valor = M s agudo
        jr nc,.2
        srl h
        rr l
.2:     jp voz3

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
        jp voz3

        ;
        ; Genera un efecto de rascado
        ;
genera_rasca:
        ld hl,ef_cont11
        ld a,(hl)
        or a
        ret z
        dec (hl)
        rrca
        rrca
        dec a
        and 3
        ld (ef_ruido),a
    ifdef SGM
        ld (ef2_ruido),a
    endif
    ifdef SLOT_1
        ld a,$f3
        ld (ef_envm),a
    ifdef SGM
        ld hl,ef2_mezc
        res 5,(hl)      ; Activa ruido blanco
    endif
    else
        ld hl,ef_mezc
        res 5,(hl)      ; Activa ruido blanco
    endif
        ret

        ;
        ; Activa el tambor
        ;
activa_tambor:
    ifdef SLOT_1
        ld a,$f5
        ld (ef_envm),a
    ifdef SGM
        ld hl,ef2_mezc
        ld a,(ef2_vol2)
        or a
        jr nz,.2
        ld a,10
        ld (ef2_vol2),a
        set 1,(hl)
.2:     res 4,(hl)
    endif
    else
        ld hl,ef_mezc
        ld a,(ef_vol2)
        or a
        jr nz,.1
        ld a,10
        ld (ef_vol2),a
        set 1,(hl)
.1:     res 4,(hl)
    endif
        ret
