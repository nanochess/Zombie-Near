        ;
        ; C¢digo obsoleto para final sencillo en Zombie Near
        ; Eliminado 18-ene-2011. O.T.G.
        ; 

muestra_lema:
        ld hl,modo
        res 0,(hl)
        res 2,(hl)
        ld a,(ix+d_refy)
        or a
        jp nz,.1
        ;
        ; Jugador 1
        ;
        ld hl,$2040
        ld bc,8
        xor a
        call FILVRM
        ld hl,pantalla
        ld b,0
        ld a,8
        ld (hl),a
        inc hl
        djnz $-2
        ld hl,pantalla+256
        ld b,128
        xor a
        ld (hl),a
        inc hl
        djnz $-2
        ld hl,modo
        set 0,(hl)
        set 2,(hl)
        halt
        ld hl,modo
        res 0,(hl)
        res 2,(hl)
        ld hl,$2000
        ld bc,$0800
        ld a,$00
        call FILVRM
        ld hl,retrato_delta_1
        ld de,$0080
        ld a,3
        call carga_retrato
        ld hl,pantalla
        ld b,0
        ld (hl),l
        inc hl
        djnz $-2
        ld hl,$0300
        ld de,mensaje_11
        call visual_mensaje
        jp .2

        ;
        ; Jugador 2
        ;
.1:
        ld hl,$3040
        ld bc,8
        xor a
        call FILVRM
        ld hl,pantalla+384
        ld b,128
        xor a
        ld (hl),a
        inc hl
        djnz $-2
        ld b,0
        ld a,8
        ld (hl),a
        inc hl
        djnz $-2
        ld hl,modo
        set 0,(hl)
        set 2,(hl)
        halt
        ld hl,modo
        res 0,(hl)
        res 2,(hl)
        ld hl,$3000
        ld bc,$0800
        ld a,$00
        call FILVRM
        ld hl,pantalla+512
        ld b,0
        ld (hl),l
        inc hl
        djnz $-2
        ld hl,retrato_delta_2
        ld de,$1040
        ld a,3
        call carga_retrato
        ld hl,$1388
        ld de,mensaje_12
        call visual_mensaje
.2:     ld hl,200
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        xor a
        ld (ix+d_trans),a       ; Elimina el transportador
        ld (ix+d_trans+1),a
        set 7,(ix+d_objeto)     ; Bit de triunfo
        ld hl,modo
        set 0,(hl)
        set 2,(hl)
        ret

mensaje_11:     ; THAT WAS SO EASY!
        db $14,$08,$01,$14,$00,$17,$01,$13,$00,$13,$0f,$fe
        db $05,$01,$13,$19,$2e,$ff

mensaje_12:     ; NO ZOMBIE CAN DEFEAT ME!
        db $0E,$0F,$00,$1A,$0F,$0D,$02,$09,$05,$00,$03,$01,$0E,$FE
        db $04,$05,$06,$05,$01,$14,$00,$0d,$05,$2e,$ff

