        ;
        ; Prueba de concepto. 14-ene-2010. O.T.G.
        ;

        ;
        ; Flautita
        ;
volumen:
        db 15
        db 14
        db 14
        db 13
        db 13
        db 12
        db 12
        db 11
        db 11
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10

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

arma_sonido:
        ld hl,(ef_voz1)
        ld a,h
        or l
        jp nz,.4
        ld hl,ef_mezc
        set 0,(hl)
        jp .5

.4:     ld a,(ef_ac1)
        or a
        ld e,9
        jp nz,.6
        ld a,(ef_ta)
        add a,a
        add a,vibrato and 255
        ld e,a
        ld a,vibrato >> 8
        adc a,0
        ld d,a
        ld a,(de)
        add a,l
        ld l,a
        inc de
        ld a,(de)
        adc a,h
        ld h,a
        ld a,(ef_ta)
        add a,volumen and 255
        ld e,a
        ld a,volumen >> 8
        adc a,0
        ld d,a
        ld a,(de)
        ld e,a
.6:     ld a,$08
        call WRTPSG
        ld a,$00
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
        ld a,$09
        ld e,0
        call WRTPSG
        ld hl,ef_mezc
        set 1,(hl)
        jp .3
.2:     ld a,(ef_ac1)
        or a
        ld e,10
        jp nz,.7
        ld a,(ef_env)
        or a
        jp z,.8
        xor a
        ld (ef_env),a
        ld a,l
        and $c0
        or h
        rrca
        rrca
        ld e,a
        ld a,$0b
        call WRTPSG
        ld a,$0c
        ld e,0
        call WRTPSG
        ld a,$0d
        ld e,$08
        call WRTPSG
.8:     ld e,16
.7:     ld a,$09
        call WRTPSG
        ld a,$02
        ld e,l
        call WRTPSG
        ld a,$03
        ld e,h
        call WRTPSG
        ld hl,ef_mezc
        res 1,(hl)
