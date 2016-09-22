        ;
        ; Motor de sprites para ZX Spectrum
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 01-ago-2011. Revisi¢n 2
        ;

        ;
        ; El ZX Spectrum es taaan lento...
        ;
        ; Con este c¢digo se pueden visualizar hasta 8 sprites en pantalla,
        ; a partir de la l¡nea 32 se pueden poner 2 en la misma l¡nea.
        ; a partir de la l¡nea 64 se pueden poner 4 en la misma l¡nea.
        ;
        ; Para mejores resultados es necesario ordenar los sprites por
        ; coordenada Y, primero los que tengan la coordenada Y m s baja.
        ;

        org $8000,$ffff

inicio:
        di
        ld sp,$ff00
        ld hl,$4000
        ld bc,$1800
_0:     ld (hl),0
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,_0
        ld bc,$0300
_1:     ld (hl),$07
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,_1
        ld hl,$6000
        ld bc,$0800
_4:     push bc
        ld b,$00
_5:     push bc
        ld a,c
        or a
        ld a,b
        ld b,0
        jr z,_6
_7:     rra
        rr b
        dec c
        jr nz,_7
_6:     ld (hl),a
        inc h
        ld (hl),b
        dec h
        inc hl
        pop bc
        inc b
        jr nz,_5
        inc h
        pop bc
        inc c
        djnz _4
        call limpia_sprites
        call motor_inicia
_2:     ld hl,sprites
        ld b,11
        ld c,$00
_3:     ld a,c
        srl a
        ld d,a
        srl a
        add a,d
        add a,$30
        ld (hl),a
        inc hl
        ld a,(ticks)
        add a,c
        srl a
        ld (hl),a
        inc hl
        ld a,(ticks)
        and $0c
        rrca
        rrca
        ld (hl),a
        inc hl
        ld (hl),$0f
        inc hl
        ld a,c
        add a,$10
        ld c,a
        djnz _3
        halt
        jp _2
        
        ;
        ; Limpia los sprites.
        ; Los sprites se conservan buffereados
        ; Esta rutina limpia sprites y sprites_anterior
        ;
limpia_sprites:
        ld hl,sprites
        ld b,128
_1:     ld (hl),$d1
        inc hl
        djnz _1
        ld hl,sprites_anterior
        ld b,96
_2:     ld (hl),$00
        inc hl
        djnz _2
        ret

        ;
        ; Inicia motor de sprites
        ; Toma el control completo del ZX Spectrum y as¡ libera IY.
        ;
motor_inicia:
        di
        ld a,motor_tabla_vectores>>8
        ld i,a
        im 2
        ei
        ret

        ds $0100-($ and 255),0

motor_tabla_vectores:
        ds 257,$88

        ds $8888-$
motor_vector_int:
        push bc
        push de
        push hl
        push af
        in a,($fe)
        ld a,$01        ; Azul
        out ($fe),a
        call motor_quita_sprites
        ld a,$02        ; Rojo
        out ($fe),a
        call motor_pone_sprites
        ld a,$03        ; Morado
        out ($fe),a
        ld hl,sprites
        ld de,sprites_anterior
_1:     push hl
        ld a,(hl)
        inc a
        cp $c0
        jr c,_2
        ld bc,0
        jr _3

_2:     call motor_coor_sprite
_3:     ld a,c
        ld (de),a
        inc de
        ld a,b
        ld (de),a
        inc de
        pop hl
        inc hl
        inc hl
        inc hl
        inc hl
        ld a,l
        cp 255 and (sprites+11*4)
        jr nz,_1
        ld a,$07        ; Gris
        out ($fe),a
        ld hl,(ticks)
        inc hl
        ld (ticks),hl
        pop af
        pop hl
        pop de
        pop bc
        ei
        reti

        ;
        ; Quita los sprites
        ;
motor_quita_sprites:
        ld hl,sprites_anterior
_1:     ld e,(hl)
        inc hl
        ld d,(hl)
        inc hl
        ld a,d
        or e
        call nz,motor_restaura_zona
        ld a,l
        cp 255 and (sprites_anterior+11*2) 
        jp nz,_1
        ret

    MACRO PIXEL_BYTE
        ld a,(de)
        ld c,a
        ld a,(bc)
        or (hl)
        ld (hl),a
        inc de
        inc b
        inc l
        ld a,(bc)
        or (hl)
        ld (hl),a
        dec b
        dec l
        inc h
        ld a,h
        and 7
        jp nz,_4
        ld a,l
        add a,$20
        ld l,a
        jp c,_4
        ld a,h
        sub 8
        ld h,a
_4:     
    ENDM

        ;
        ; Pone los sprites
        ;
motor_pone_sprites:
        ld hl,sprites
_1:     push hl
        ld a,(hl)
        inc a
        cp $c0
        jp nc,_2
        call motor_coor_sprite
        ;
        ; Pone un sprite
        ;
        push bc
        ld a,(hl)
        and $07
        add a,a
        or $60
        ld b,a
        inc hl
        ld a,(hl)       ; Figura sprite
        ld l,0
        rra
        rr l
        rra
        rr l
        rra
        rr l
        ld h,a
        ld de,sprites_heroes
        add hl,de
        ex de,hl
        pop hl
        ;
        ; Pone lado izquierdo
        ;
        push hl
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

        pop hl
        ;
        ; Pone lado derecho
        ;
        inc l
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE
        PIXEL_BYTE

_2:     pop hl
        inc hl
        inc hl
        inc hl
        inc hl
        ld a,l
        cp 255 and (sprites+11*4) 
        jp nz,_1
        ret

        ;
        ; Restaura la zona debajo de un sprite
        ; HL = Ap. a memoria de video
        ;
motor_restaura_zona:
        ld b,16
_0:     xor a
        ld (de),a
        inc e
        ld (de),a
        inc e
        ld (de),a
        dec b
        ret z
        dec e
        dec e
        inc d
        ld a,d
        and 7
        jp nz,_0
        ld a,e
        add a,$20
        ld e,a
        jp c,_0
        ld a,d
        sub 8
        ld d,a
        jp _0

        ;
        ; Obtiene las coordenadas en pantalla de un sprite
        ;
motor_coor_sprite:
        ld c,a
        and $07
        ld b,a
        ld a,c
        and $c0
        rrca
        scf
        rra
        rrca
        or b
        ld b,a
        ld a,c
        rlca
        rlca
        and $e0
        ld c,a
        inc hl
        ld a,(hl)
        rrca
        rrca
        rrca
        and $1f
        or c
        ld c,a
        ret

        include "sprites.asm"

sprites:
        ds 32*4
sprites_anterior:
        ds 32*2
ticks:  ds 2

        end inicio

