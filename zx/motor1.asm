        ;
        ; Motor de sprites para ZX Spectrum
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 30-jul-2011
        ;

        ;
        ; Informe: El ZX Spectrum es taaaan lento que no se puede conservar
        ; el fondo de un sprite y luego restaurarlo, solo vea como se "ahoga"
        ; con solo 4 sprites.
        ;

        org $8000,$ffff

inicio:
        di
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
        call limpia_sprites
        call motor_inicia
_2:     ld hl,sprites
        ld b,4
        ld c,$80
_3:     ld (hl),c
        inc hl
        ld a,(ticks)
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
        ld b,128*2
_1:     ld (hl),$d1
        inc hl
        djnz _1
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
        ex af,af'
        exx
        push bc
        push de
        push hl
        push af
        ex af,af'
        exx
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
        ld bc,28*4
        ldir
        ld a,$07        ; Gris
        out ($fe),a
        ld hl,(ticks)
        inc hl
        ld (ticks),hl
        ex af,af'
        exx
        pop af
        pop hl
        pop de
        pop bc
        ex af,af'
        exx
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
        ld de,fondo_sprites
        ld b,28
_1:     push bc
        push hl
        push de
        call motor_restaura_zona
        pop hl
        ld bc,48
        add hl,bc
        ex de,hl
        pop hl
        inc hl
        inc hl
        inc hl
        inc hl
        pop bc
        djnz _1
        ret

        ;
        ; Pone los sprites
        ;
motor_pone_sprites:
        ld hl,sprites+27*4
        ld de,fondo_sprites+27*48
        ld b,28
_1:     push bc
        push de
        push hl
        call motor_coor_sprite
        jp c,_2
        push hl
        push af
        push bc
        call motor_salva_zona
        pop bc
        pop af
        pop hl
        call motor_pone_sprite
_2:     pop hl
        pop de
        ex de,hl
        ld bc,-48
        add hl,bc
        ex de,hl
        dec hl
        dec hl
        dec hl
        dec hl
        pop bc
        djnz _1
        ret

        ;
        ; Pone un sprite
        ;
motor_pone_sprite:
        push bc
        ld c,0
        rra
        rr c
        rra
        rr c
        rra
        rr c
        ld b,a
        ex de,hl
        ld hl,sprites_heroes
        add hl,bc
        ex de,hl
        pop bc
        push hl
        call _0
        pop hl
        inc l
_0:     ld b,16
_1:     push bc
        ld a,c
        or a
        ld a,(de)
        ld b,0
        jp z,_2
_3:     rra
        rr b
        dec c
        jp nz,_3
_2:     or (hl)
        ld (hl),a
        inc l
        ld a,b
        or (hl)
        ld (hl),a
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
_4:     inc de
        pop bc
        djnz _1
        ret

        ;
        ; Salva la zona debajo de un sprite
        ; HL = Ap. a sprite
        ; DE = Ap. a espacio de 48 bytes
        ;
motor_salva_zona:
        ld bc,$0030
_0:     ldi
        ldi
        ldi
        ret po
        dec hl
        dec hl
        dec hl
        inc h
        ld a,h
        and 7
        jp nz,_0
        ld a,l
        add a,$20
        ld l,a
        jp c,_0
        ld a,h
        sub 8
        ld h,a
        jp _0

        ;
        ; Restaura la zona debajo de un sprite
        ; HL = Ap. a sprite
        ; DE = Ap. a espacio de 48 bytes
        ;
motor_restaura_zona:
        call motor_coor_sprite
        ret c
        ex de,hl
        ld bc,$0030
_0:     ldi
        ldi
        ldi
        ret po
        dec de
        dec de
        dec de
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
        ld a,(hl)
        inc a
        cp $c0
        ccf
        ret c
        ld c,a
        and $07
        ld b,a
        ld a,c
        and $c0
        rrca
        rrca
        rrca
        or $40
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
        push bc
        ld a,(hl)
        and $07
        ld c,a
        inc hl
        ld a,(hl)       ; Figura sprite
        pop hl
        ret

        include "sprites.asm"

sprites:
        ds 32*4
sprites_anterior:
        ds 32*4
fondo_sprites:
        ds 32*48
ticks:  ds 2

        end inicio

