tambor_1:
        ld b,a
        ld a,(ef_env)
        and 12          ; Detecta tipo de melod¡a
        ld a,4
        jr nz,.0
        xor a
.0:     add a,b
        or $f0
        ld (ef_mezc),a
        xor a
        ld (ef_ruido),a
        ret

tambor_22:
        ld (hl),0
tambor_2:
        xor a
        ld (ef_ruido),a
        ld a,(ef_env)
        and 12          ; Detecta tipo de melod¡a
        ld a,$f4
        jr nz,.0
        ld a,$f0
.0:     ld (ef_mezc),a
        ret

