        ;
        ; Historia para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 17-ene-2011.
        ; Revisi¢n: 18-ene-2011. Se agrega rutina visualiza_historia y todo
        ;                        lo necesario para cambios de estado,
        ;                        adelantar mapa y finalizar juego. Se pone
        ;                        aqu¡ todo el c¢digo de presentaci¢n e
        ;                        historia. Si se ha ganado el juego entonces
        ;                        muestra presentaci¢n alterna e icono de
        ;                        h‚roe en lugar de pistola.
        ;

        ;
        ; La presentaci¢n
        ;
        ; Puede ponerse voz usando el truco PCM del PSG
        ;
presentacion:
.0:
        call musica_silencio
        call inicia_sonido
        call limpia_sprites
        ld hl,modo
        res 2,(hl)
        set 0,(hl)
        xor a
        ld (estado),a
        halt
        ; Prueba de retratos para ajustar pixel por pixel.
        ; ­Ugh! eso fue dif¡cil 10-ene-2011
    if 0
.888:       
        ld hl,retrato_investigadora            
        ld de,$0000
        ld a,3
        call carga_retrato
        ld hl,retrato_jefe            
        ld de,$0040
        ld a,3
        call carga_retrato
        ld hl,retrato_investigadora3
        ld de,$0080
        ld a,4
        call carga_retrato
        ld hl,retrato_jefe3a
        ld de,$00c0      
        ld a,4
        call carga_retrato
        ld hl,retrato_jefe3b
        ld de,$08c0      
        ld a,4
        call carga_retrato
        ld hl,retrato_telefonista            
        ld de,$0800
        ld a,3
        call carga_retrato
        ld hl,retrato_delta_1            
        ld de,$1000
        ld a,3
        call carga_retrato
        ld hl,retrato_delta_2
        ld de,$1040
        ld a,3
        call carga_retrato
        ld hl,retrato_zombies_1
        ld de,$1080
        ld a,3
        call carga_retrato
        ld hl,retrato_zombies_2
        ld de,$10c0
        ld a,3
        call carga_retrato
        jr .888
    endif

        CALL PANTALLA_NEGRA
        ; Carga pantalla de t¡tulo
        ;
        ; Presentaci¢n compactada (son 12288 bytes si no se compacta)
        ;
        ld a,(ganado)
        or a
        LD HL,GRAFICA_TITULO AND $FFFF
        LD DE,GRAFICA_TITULO>>16
        jp z,.555
        LD HL,GRAFICA_TITULO2 AND $FFFF
        LD DE,GRAFICA_TITULO2>>16
.555:   LD B,2
        CALL CARGAR_TOMA
        ;
        ; Vuelve a definir sprite pistola en sprites h‚roes
        ; y restaura dos sprites que pueden ser borrados por historia
        ;
        ld hl,modo
        res 0,(hl)
        ld a,(ganado)
        or a
        LD HL,figuras_sprites
        jp z,.556
        LD HL,sprites_heroes
.556:   LD DE,$1800
        LD BC,$0040
        CALL LDIRVM
        LD HL,figuras_sprites+64
        LD DE,$1840
        LD BC,$0040
        CALL LDIRVM

        ;
        ; Antirebote
        ;
    IF 0
.7:     ld b,5
.2:     halt
        call boton_oprimido
        cp $ff
        jp z,.7
        djnz .2
    ENDIF
        ld hl,modo
        set 0,(hl)      ; Controla sprites y pantalla
        ld hl,sprites
        ld (hl),$68
        inc hl
        ld (hl),$88
        inc hl
        ld (hl),$04     ; La pistola (color brillante)
        inc hl
        ld (hl),$0f
        inc hl
        ld (hl),$68
        inc hl
        ld (hl),$88
        inc hl
        ld (hl),$00     ; La pistola (color obscuro)
        inc hl
        ld (hl),$0e
        inc hl
.906:
        ld de,(ticks)
.1:     halt
        ld hl,(ticks)
        bit 3,l
        ld bc,$0e0f
        jp z,.3
        ld bc,$0101
.3:     ld a,b
        ld (sprites+7),a
        ld a,c
        ld (sprites+3),a
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        ret z
        ld a,0          ; Cursor
        push de
        call GTSTCK
        pop de
        cp 1            ; ¨Arriba?
        jp z,.900
        cp 5            ; ¨Abajo?
        jp z,.901
        ld a,1          ; Joystick 1
        push de
        call GTSTCK
        pop de
        cp 1            ; ¨Arriba?
        jp z,.900
        cp 5            ; ¨Abajo?
        jp z,.901
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,500       ; ¨Transcurridos 10 segundos?
        or a
        sbc hl,bc
        jp c,.1
        jp .902

        ; Pistola arriba
.900:   ld a,(sprites)
        cp $68
        jp z,.903
        sub $10
        ld (sprites),a
        ld (sprites+4),a
        jp .903

        ; Pistola abajo
.901:   ld a,(sprites)
        cp $88
        jp z,.903
        add a,$10
        ld (sprites),a
        ld (sprites+4),a
.903:
        ld de,(ticks)
.904:   halt
        ld hl,(ticks)
        bit 3,l
        ld bc,$0e0f
        jp z,.905
        ld bc,$0101
.905:   ld a,b
        ld (sprites+7),a
        ld a,c
        ld (sprites+3),a
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        ret z
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,18
        or a
        sbc hl,bc
        jp c,.904
        jp .906

        ;
        ; Comienza la historia, empezando por una pantalla de alerta
        ; estilo cine con chicharra inclu¡da.
        ;
.902:
        call limpia_sprites
        halt
        LD HL,GRAFICA_ALERTA AND $FFFF
        LD DE,GRAFICA_ALERTA>>16
        LD B,4
        CALL CARGAR_TOMA
        ;
        ; Programa sonido
        ;
        ld hl,modo
        set 3,(hl)
        ld hl,tabla_psg
        ld d,0
.950:   ld e,(hl)
        ld a,d
        call WRTPSG
        inc d
        inc hl
        ld a,d
        cp 14
        jp nz,.950
        ;
        ; El truco es que el fondo es transparente
        ;
        ld a,6
        ld (estado),a
        ld de,(ticks)
.4:     halt
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,.0
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,200       ; ¨Transcurridos 4 segundos?
        or a
        sbc hl,bc
        jp c,.4
        xor a
        ld (estado),a
        ld bc,$0107
        call WRTVDP
        call presentacion_limpia
        call musica_historia
        call inicia_sonido
        ;
        ; Todos los cuadros de personaje son de 64x64 pixeles, 1024 bytes,
        ; se desplazan utilizando truco directo tabla de caracteres.
        ;
        ld hl,retrato_investigadora     ; Retrato de chica investigadora
        ld de,$08c0
        ld a,3
        call carga_retrato
        call entrada_derecha
        ; "Security failure"
        ld hl,$11a8
        ld de,mensaje_1
        call visual_mensaje
        call retardo_cuadro
        ld hl,retrato_jefe              ; Retrato de jefe de investigaci¢n
        ld de,$0800
        ld a,3
        call carga_retrato
        call entrada_izquierda
        ld hl,$1108
        ld de,mensaje_2
        call visual_mensaje
        call retardo_cuadro
        ;
        ; Edificio compactado, solo verde m s sprites
        ;
        CALL PANTALLA_NEGRA_RAPIDA
        ld hl,modo
        res 0,(hl)
        LD HL,sprites_heroes+$400
        LD DE,$1840
        LD BC,$0040
        CALL LDIRVM
        ld hl,modo
        set 0,(hl)
        LD HL,GRAFICA_EDIFICIO AND $FFFF
        LD DE,GRAFICA_EDIFICIO>>16
        LD B,4
        CALL CARGAR_TOMA
        ld hl,$1420
        ld de,mensaje_11
        call visual_mensaje
        ld hl,$14A0
        ld de,mensaje_11
        call visual_mensaje
        ld a,$20
        ld (bits1),a
        ld a,$20
        ld (bits1+1),a
        ld a,$31
        ld (bits1+2),a
        ld a,$ff
        ld (bits1+3),a
        LD HL,tabla_puntos
        ld de,sprites
        ld bc,64
        ldir
        ld a,3
        ld ($a000),a
        ld ix,tabla_aleatoria
        push ix
.800:
        halt
        ld a,(ticks)
        bit 0,a
        jp z,.805
        ;
        ; Mueve seudoaleatoriamente
        ;
        pop de
        ld hl,sprites
        ld b,16
.803:   ld a,(de)
        inc de
        bit 2,d
        jp nz,$+6
        ld de,tabla_aleatoria
        add a,(hl)
        ld (hl),a
        inc hl
        ld a,(de)
        inc de
        bit 2,d
        jp nz,$+6
        ld de,tabla_aleatoria
        add a,(hl)
        cp $10
        jp nc,$+5
        ld a,$10
        cp $48
        jp c,$+5
        ld a,$48
        ld (hl),a
        inc hl
        inc hl
        ld a,(bits1)
        sub $20
        add a,a
        cp b
        jp c,.804
        ld (hl),$09
.804:   inc hl
        djnz .803
        push de
        ;
        ; Duplica sprites para el otro edificio
        ;
.805:   ld hl,sprites
        ld de,sprites+64
        ld b,16
.802:   ld a,(hl)
        ld (de),a
        inc hl
        inc de
        ld a,(hl)
        cpl
        sub 15
        ld (de),a
        inc hl
        inc de
        ld a,(hl)
        ld (de),a
        inc hl
        inc de
        ld a,(hl)
        ld (de),a
        inc hl
        inc de
        djnz .802
        ld hl,$1638
        ld de,bits1
        call visual_mensaje
        ld hl,$16b8
        ld de,bits1
        call visual_mensaje
        ld a,(bits1+1)
        add a,1
        cp $2a
        jp nz,.801
        ld a,(bits1)
        add a,1
        ld (bits1),a
        ld a,$20
.801:   ld (bits1+1),a
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        ld a,(bits1)
        cp $29
        jp nz,.800
        ld a,(bits1+1)
        cp $29
        jp nz,.800
        pop ix
        CALL retardo_cuadro
        CALL limpia_sprites
        halt
        call presentacion_limpia
        ld hl,retrato_investigadora   ; Retrato de chica investigadora
        ld de,$08c0
        ld a,3
        call carga_retrato
        call entrada_derecha
        ; "Them're through the building!"
        ld hl,$1180
        ld de,mensaje_3
        call visual_mensaje
        call retardo_cuadro
        ld hl,$a400             ; Retrato de jefe
        ld de,$0800
        ld a,3
        call carga_retrato
        call entrada_izquierda
        ; "Call the special team... What's that?"
        ld hl,$1108
        ld de,mensaje_4
        call visual_mensaje
        call retardo_cuadro
        call presentacion_limpia
        ; "Oh my god!... gritos y luego est tica"
        ld hl,$1150
        ld de,mensaje_5
        call visual_mensaje
        call retardo_cuadro
        ld hl,retrato_zombies_1         ; Retrato zombies (izq)
        ld de,$0800
        ld a,3
        call carga_retrato
        ld hl,retrato_zombies_2         ; Retrato zombies (der)
        ld de,$08c0
        ld a,3
        call carga_retrato
        call entrada_doble
        ld hl,$1358
        ld de,mensaje_6
        call visual_mensaje
        call retardo_cuadro
        call presentacion_limpia
        ld hl,retrato_telefonista       ; Retrato de telefonista
        ld de,$0060
        ld a,3
        call carga_retrato
        call entrada_arriba
        ; "Emergency! Calling special team"
        ld hl,$0208
        ld de,mensaje_7
        call visual_mensaje
        call retardo_cuadro
        ld hl,retrato_delta_1           ; Retrato de Steve Thunder
        ld de,$08c0
        ld a,3
        call carga_retrato
        call entrada_derecha
        ; "Delta 1 ready, I'll enter building A"
        ld hl,$1188
        ld de,mensaje_8
        call visual_mensaje
        call retardo_cuadro
        ld hl,retrato_delta_2           ; Retrato de Eve Lightning
        ld de,$0800
        ld a,3
        call carga_retrato
        call entrada_izquierda
        ; "Delta 2 ready, I'll enter building B"
        ld hl,$1108
        ld de,mensaje_9
        call visual_mensaje
        call retardo_cuadro
        call retardo_cuadro
        jp .0

        ;
        ; Limpia la pantalla en preparaci¢n para entrada de retratos
        ;
presentacion_limpia:
        ld hl,modo
        res 0,(hl)
        ld hl,$2050     ; Caracter $0a
        ld bc,$0008
        xor a
        call filvrm
        ld hl,$2850
        ld bc,$0008
        xor a
        call filvrm
        ld hl,$3050
        ld bc,$0008
        xor a
        call filvrm
        ld hl,modo
        set 0,(hl)
        ld hl,pantalla
        ld bc,768
.1:     ld (hl),10
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,.1
        halt
        ld hl,0
        ld (offset),hl
        halt
        ld hl,384
        ld (offset),hl
        halt
        ret

        ;
        ; Sonido de chicharra
        ;
tabla_psg:
        db $00,$01
        db $80,$02
        db $c0,$04
        db $04
        db $b8
        db $10
        db $10
        db $10
        db $78
        db $0d
        db $08

        ;
        ; Tabla para puntos loquitos en edificio 3-D
        ;
tabla_puntos:
        db 28,44,8,7 
        db 42,29,8,7
        db 56,37,12,7
        db 70,33,8,7
        db 84,26,12,7
        db 108,21,8,7
        db 122,30,8,7
        db 136,28,12,7
        db 36,60,8,7
        db 50,54,12,7
        db 64,61,8,7
        db 78,64,12,7
        db 92,57,8,7
        db 116,50,12,7
        db 127,79,12,7
        db 135,63,8,7

        ;
        ; Detecta boton oprimido
        ; Devuelve A=$FF si bot¢n oprimido, de lo contrario $00
        ;
boton_oprimido:
        push bc
        push de
        push hl
        ld b,0
.1:     push bc
        ld a,b
        call GTTRIG
        pop bc
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,.2
        inc b
        ld a,b
        sub 5
        jp nz,.1
.2:     pop hl
        pop de
        pop bc
        ret

        ;
        ; Retardo por cuadro de presentaci¢n.
        ;
retardo_cuadro:
        ld de,(ticks)
.1:     halt
        pop bc
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push bc
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,150       ; ¨Transcurridos 3 segundos?
        or a
        sbc hl,bc
        jp c,.1
        ret

        ;
        ; Carga un retrato
        ;
carga_retrato:
        ld ($a000),a    ; Banco del ROM con los retratos
        ld a,h
        and $1f
        or $a0
        ld h,a
        push hl
        ld hl,modo
        res 0,(hl)
        pop hl
        ; Carga bitmap
        push de
        ld b,8
.1:     push bc
        push de
        push hl
        ld bc,64
        call LDIRVM
        pop hl
        ld bc,64
        add hl,bc
        pop de
        inc d
        pop bc
        djnz .1
        pop de
        set 5,d
        ld b,8
.2:     push bc
        push de
        push hl
        ld bc,64
        call LDIRVM
        pop hl
        ld bc,64
        add hl,bc
        pop de
        inc d
        pop bc
        djnz .2
        ld hl,modo
        set 0,(hl)
        ret

        ;
        ; Entrada de retrato desde arriba
        ;
entrada_arriba:
        halt
        ld hl,$0000
        ld (offset),hl
        ld bc,$01ec
.1:     halt
        push bc
        ld hl,pantalla+12
        ld de,25
.2:     ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        inc c
        inc hl
        ld (hl),c
        ld a,c
        add a,25
        ld c,a
        add hl,de
        djnz .2
        pop bc
        pop de
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push de
        ld a,c
        sub 32
        ld c,a
        inc b
        ld a,b
        cp 9
        jp nz,.1
        ret

        ;
        ; Entrada de retrato desde izquierda
        ;
entrada_izquierda:
        exx
        ld bc,$0b01
        exx
        jp entrada_retrato

        ;
        ; Entrada de retrato desde derecha
        ;
entrada_derecha:
        exx
        ld bc,$0b02
        exx
        jp entrada_retrato

        ;
        ; Entrada de retratos dobles
        ;
entrada_doble:
        exx
        ld bc,$1103
        exx
entrada_retrato:
        halt
        ld hl,$0100
        ld (offset),hl
        ld bc,$0107
.1:     halt
        ld hl,pantalla+$0100
        ld de,32
        exx
        bit 0,c
        exx
        jp z,.8
        push bc
.2:     push hl
        ld a,c
        or a
        jp p,.4
        ld a,10
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        jp .5

.4:     ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
        ld (hl),a
        add a,32
        add hl,de
.5:     ld (hl),a
        pop hl
        inc c
        inc hl
        djnz .2
        pop bc
.8:     exx
        bit 1,c
        exx
        jp z,.9
        push bc
        ld hl,pantalla+$0120
        ld a,l
        sub b
        ld l,a
        ld de,32
        ld c,$18
.3:     push hl
        ld a,c
        cp $20
        jp c,.6
        ld a,10
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        ld (hl),a
        add hl,de
        jp .7

.6:     ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
        ld (hl),a
        add a,$20
        add hl,de
.7:     ld (hl),a
        pop hl
        inc c
        inc hl
        djnz .3
        pop bc
.9:     pop de
        call boton_oprimido
        cp $ff          ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push de
        inc b
        dec c
        ld a,b
        exx
        cp b
        exx
        jp nz,.1
        ret

        ;
        ; Muestra lema de jugador
        ;
muestra_lema:
        ld a,(ix+d_objeto)
        and $30
        ld b,1          ; Finaliza mapa1
        jp z,.1
        ld b,11         ; Finaliza mapa2
        cp $10
        jp z,.1
        ld b,23         ; Finaliza mapa3
.1:     ld a,b
        jp inicia_historia

        ;
        ; Final
        ;
toma_final:
        call limpia_sprites
        halt
        call musica_silencio
        halt
        call PANTALLA_NEGRA
        call musica_final
        ;
        ; Carga pantalla de helic¢ptero
        ;
        LD HL,GRAFICA_HELICOPTERO AND $FFFF
        LD DE,GRAFICA_HELICOPTERO>>16
        LD B,2
        CALL CARGAR_TOMA
        LD HL,modo
        set 0,(hl)
        ld b,25
        halt
        call aspas_helicoptero
        djnz $-4

        ;
        ; El cuadro de final se compone seg£n si uno o dos de los jugadores
        ; lo lograron.
        ;
        ld hl,modo
        set 0,(hl)      ; Controla sprites y pantalla
        set 2,(hl)      ; Define sprites jugadores
        ld a,$30
        ld (sprites_especiales),a
        ld a,$70
        ld (sprites_especiales+2),a
        ld hl,sprites
        ld (hl),$c0
        inc hl
        ld (hl),$78
        inc hl
        ld (hl),$00     ; El chico
        inc hl
        ld a,(jug1+d_vidas)
        cp -1
        ld (hl),$00
        jp z,$+5
        ld (hl),$07
        inc hl
        ld (hl),$c4
        inc hl
        ld (hl),$98
        inc hl
        ld (hl),$04     ; La chica
        inc hl
        ld a,(jug2+d_vidas)
        cp -1
        ld (hl),$00
        jp z,$+5
        ld (hl),$09
        inc hl  
        ;
        ; Animaci¢n de carrerita hasta el helic¢ptero
        ;
.1:     halt
        call aspas_helicoptero
        ld a,(ticks)
        bit 0,a
        jp z,.1
        and $0c
        or $30
        ld (sprites_especiales),a
        or $70
        ld (sprites_especiales+2),a
        ld hl,sprites+4
        dec (hl)
        ld hl,sprites
        dec (hl)
        ld a,(hl)
        cp $78
        jp nz,.1
        ;
        ; Nuestros h‚roes entran al helic¢ptero.
        ;
        ld a,$d1
        ld (sprites),a
        ld (sprites+4),a
        ld b,10
        halt
        call aspas_helicoptero
        djnz $-4
        ;
        ; Salen unos amistosos zombies
        ;
        ld hl,tabla_zombies
        ld de,sprites+8
        ld bc,24
        ldir
.2:     halt
        call aspas_helicoptero
        ld a,(ticks)
        bit 0,a
        jp z,.2
        ld ix,sprites+8
        inc (ix+1)
        dec (ix+5)
        inc (ix+9)
        dec (ix+13)
        dec (ix+16)
        dec (ix+20)
        ld hl,sprites+10
        ld b,6
.3:     ld a,(ticks)
        and $0c
        ld c,a
        ld a,(hl)
        and $f0
        or c
        ld (hl),a
        inc hl
        inc hl
        inc hl
        inc hl
        djnz .3
        ld a,(sprites+24)
        cp $7C
        jp nz,.2
        CALL limpia_sprites
        ld hl,pantalla+$0140
        ld b,32
        ld (hl),l
        inc hl
        djnz $-2
        ld hl,modo
        res 2,(hl)
        HALT
        ;
        ; Carga pantalla de final
        ;
        LD HL,GRAFICA_FIN AND $FFFF
        LD DE,GRAFICA_FIN>>16
        LD B,4
        CALL CARGAR_TOMA
        ld bc,500
.4:     halt
        dec bc
        ld a,b
        or c
        jp nz,.4
        ld a,1
        ld (ganado),a
        JP REINICIO

tabla_zombies:
        db $80,$00,$40,$03
        db $80,$e0,$50,$03
        db $90,$00,$40,$01
        db $90,$e0,$50,$01
        db $c0,$88,$70,$0b
        db $c0,$a0,$70,$0b

tabla_aspas:
        db $47,$48,$49,$4a,$4b,$4c,$4d,$4e ; 1
        db $51,$52,$53,$54,$55,$56,$57,$58
        db $46,$46,$49,$4a,$4b,$4c,$4d,$4e ; 2
        db $51,$52,$53,$54,$55,$56,$46,$46
        db $46,$46,$46,$46,$4b,$4c,$4d,$4e ; 3
        db $51,$52,$53,$54,$46,$46,$46,$46
        db $46,$46,$46,$46,$46,$46,$4d,$4e ; 4
        db $51,$52,$46,$46,$46,$46,$46,$46
        db $46,$46,$46,$46,$46,$46,$46,$46 ; 5
        db $46,$46,$46,$46,$46,$46,$46,$46
        db $46,$46,$46,$46,$46,$46,$4d,$4e ; 6
        db $51,$52,$46,$46,$46,$46,$46,$46
        db $46,$46,$46,$46,$4b,$4c,$4d,$4e ; 7
        db $51,$52,$53,$54,$46,$46,$46,$46
        db $46,$46,$49,$4a,$4b,$4c,$4d,$4e ; 8
        db $51,$52,$53,$54,$55,$56,$46,$46

        ;
        ; Animaci¢n de las aspas del helic¢ptero
        ; 
aspas_helicoptero:
        push bc
        ld a,(ticks)
        and 7
        rlca
        rlca
        rlca
        rlca
        ld e,a
        ld d,0
        ld hl,tabla_aspas
        add hl,de
        ld de,pantalla+$0147
        ld bc,8
        ldir
        inc de
        inc de
        ld bc,8
        ldir
        pop bc
        ret

    if 0
        ;
        ; Experimento historia
        ;
experimento_historia:
        ld ix,jug2
        ld a,(ix+d_estado)
        or a
        ret nz
        ld (ix+d_rescatados),0
;        ld a,1 ; Al finalizar mapa1
;        ld a,7 ; Al llegar con chica en mapa2
;        ld a,11        ; Al finalizar mapa2
;        ld a,17 ; Al llegar con jefe en mapa3
;        ld a,23 ; Al finalizar mapa3
        call inicia_historia
        ret
    endif

        ;
        ; Limpia la zona de historia
        ;
zona_historia:
        ld hl,modo
        res 0,(hl)
        ld a,(ix+d_refx)
        or a
        jp nz,.1
        ld hl,$3c00
        ld bc,$0100
        ld a,$ff
        call filvrm
        ld hl,letras
        ld de,$0000
        ld bc,512
        call LDIRVM
        ld hl,color_letras
        ld de,$2000
        ld bc,512
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$01c0
        ld bc,1600
        call LDIRVM
        ld hl,graf_color
        ld de,$21c0
        ld bc,1600
        call LDIRVM
        ld hl,pantalla
        ld b,0
        ld (hl),$ff
        inc hl
        djnz $-3
        ld hl,modo
        set 0,(hl)
        ret

.1:     ld hl,$3e00
        ld bc,$0100
        ld a,$00
        call filvrm
        ld hl,letras
        ld de,$1000
        ld bc,$01c0
        call LDIRVM
        ld hl,color_letras
        ld de,$3000
        ld bc,$01c0
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$11c0
        ld bc,1600
        call LDIRVM
        ld hl,graf_color
        ld de,$31c0
        ld bc,1600
        call LDIRVM
        ld hl,pantalla+512
        ld b,0
        ld (hl),$00
        inc hl
        djnz $-3
        ld hl,modo
        set 0,(hl)
        ret

        ;
        ; Avanza la historia
        ;
avanza_historia:
        ld a,(ix+d_estado)
        or a
        ret z
        ld a,(ix+d_tiempo)
        sub 7
        or (ix+d_tiempo+1)
        call z,zona_historia_2
        ld a,(ix+d_tiempo)
        dec a
        or (ix+d_tiempo+1)
        ret nz
        ld a,(ix+d_estado)
        cp $fd
        jp z,.1
        cp $ff
        jp z,.2
        cp $fe
        jp nz,visualiza_historia
        ;
        ; El monigote b sico se transforma en grande y feo monstruo
        ;
        call zona_historia
        call carga_nivel
        call actualiza_indicadores
        res 3,(ix+d_objeto)     ; Elimina bandera o repetir¡a eternamente
        xor a
        ld (ix+d_estado),a
        ld (ix+d_tiempo),a
        ld (ix+d_tiempo+1),a
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16
        add hl,de
        push iy
        push hl
        pop iy
        ld (iy+d_tipo),12
        ld (iy+d_paso),4
        ld (iy+d_velocidad),4
        ld (iy+d_dx),12
        pop iy
        ret

        ;
        ; Ha pasado de nivel
        ;
.1:     call zona_historia
        xor a
        ld (ix+d_estado),a
        ld (ix+d_tiempo),a
        ld (ix+d_tiempo+1),a
        ld (ix+d_nivel),a
        ld (ix+d_rescatados),a
        ld a,(ix+d_mapa)
        add a,$10
        ld (ix+d_mapa),a
        ld (ix+d_energia),6
        inc (ix+d_vidas)
        ld a,(ix+d_refx)
        inc a
        ld (ix+d_basex),a
        add a,15
        ld (ix+d_x),a
        ld a,(ix+d_refy)
        add a,$10
        ld (ix+d_y),a
        ld (ix+d_basey),a
        call carga_nivel
        call actualiza_indicadores
        jp efecto_vida

        ;
        ; Ha ganado el juego
        ;
.2:     xor a
        ld (ix+d_estado),a
        ld (ix+d_tiempo),a
        ld (ix+d_tiempo+1),a
        set 7,(ix+d_objeto)     ; Victoria
        ret

        ;
        ; Inicia historia
        ; ix = apunta a jugador
        ; a = estado
        ;
inicia_historia:
        ld (ix+d_estado),a
        ld (ix+d_tiempo),8
        ld (ix+d_tiempo+1),0
zona_historia_2:
        ld a,(ix+d_refx)
        or a
        jp nz,.1
        ld hl,pantalla
        ld b,0
        ld (hl),$ff
        inc hl
        djnz $-3
        ld b,128
        ld (hl),$ff
        inc hl
        djnz $-3
        jp .2

.1:     ld hl,pantalla+384
        ld b,0
        ld (hl),$00
        inc hl
        djnz $-3
        ld b,128
        ld (hl),$00
        inc hl
        djnz $-3
.2:     ret

        ;
        ; Visualiza cuadro de historia
        ; ix = apunta a jugador
        ;
visualiza_historia:
        ld hl,tabla_historia
        ld a,(ix+d_estado)
        add a,a
        add a,a
        ld e,a
        ld d,0
        add hl,de
        ld a,(ix+d_refx)
        or a            ; ¨Jugador 1?
        jp z,.1         ; S¡, salta
        inc hl          ; No, selecciona descriptor correcto
        inc hl
        scf
.1:     ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ;
        ; hl ahora apunta a descriptor historia
        ;
        ld a,(hl)       ; Salva c¢digo siguiente estado
        inc hl
        push af
        ld a,(hl)       ; Obtiene n£mero de retrato
        inc hl
        adc a,a         ; Cambia seg£n jugador
        push hl
        add a,a
        add a,a
        add a,a
        ld e,a
        ld d,0
        ld hl,tabla_retratos
        add hl,de
        ld e,(hl)       ; Obtiene offset retrato
        inc hl
        ld d,(hl)
        inc hl
        ld b,(hl)       ; Obtiene slot retrato
        inc hl
        ld a,(hl)       ; Obtiene alineaci¢n
        ex af,af'
        inc hl
        ld c,(hl)       ; Obtiene posici¢n en pantalla
        inc hl
        ld a,(hl)
        inc hl
        push hl
        ex de,hl
        ld e,c
        ld d,a
        ld a,b
        push de
        call carga_retrato
        pop de
        srl d
        rr e
        srl d
        rr e
        srl d
        rr e
        ld hl,pantalla
        add hl,de
        ld c,8
.6:     ld b,8
        ld (hl),l
        inc l
        djnz $-2
        ld a,l
        add a,24
        ld l,a
        dec c
        jp nz,.6
        pop hl
        ld e,(hl)       ; Obtiene zona de texto
        inc hl
        ld d,(hl)
        pop hl
        ld b,(hl)       ; Obtiene ancho de texto
        inc hl
        ex af,af'
        or a            ; ¨Alineaci¢n izquierda?
        jp z,.5         ; S¡, ya no hay que hacer nada
        ld a,15         ; Alinea a un caracter del retrato
        sub b
        add a,a
        add a,a
        add a,a
        add a,e
        ld e,a
.5:     ex de,hl
        call visual_mensaje
        ld (ix+d_tiempo),300 and 255
        ld (ix+d_tiempo+1),300 >> 8
        pop af
        or a            ; 0 - Ir a siguiente cuadro
        jp nz,.2
        inc (ix+d_estado)
        ret

.2:     dec a           ; 1 - Ir a sig. si rescat¢, de lo contrario brinca
        jp nz,.3
        inc (ix+d_estado)
        ld a,(ix+d_rescatados)
        or a
        ret nz
        inc (ix+d_estado)
        ret

.3:     dec a           ; 2 - Brincar sig. estado
        jp nz,.4
        inc (ix+d_estado)
        inc (ix+d_estado)
        ret

.4:     dec a           ; 3 - Volver a juego
        add a,$fd       ; 4 - Volver a juego con efecto
        ld (ix+d_estado),a  ; 5 - Ir a gran final
        ret

        ;
        ; Tabla de retratos:
        ; 0 - Offset retrato
        ; 1 - Slot retrato y alineaci¢n (0=izq, 1=der)
        ; 2 - Posici¢n en video
        ; 3 - Posici¢n para zona de caracteres
        ;
tabla_retratos:
        dw 0,0,0,0
        dw 0,0,0,0
        dw retrato_delta_1,$0103,$0080,$0200
        dw retrato_delta_2,$0003,$1040,$1288
        dw retrato_telefonista,$0003,$0000,$0248
        dw retrato_telefonista,$0103,$10c0,$1240
        dw retrato_investigadora2,$0004,$0000,$0248
        dw retrato_investigadora3,$0104,$10c0,$1240
        dw retrato_jefe2a,$0004,$0000,$0248
        dw retrato_jefe3a,$0104,$10c0,$1240
        dw retrato_jefe2b,$0004,$0000,$0248
        dw retrato_jefe3b,$0104,$10c0,$1240

tabla_historia:
        dw 0,0
        ;
        ; Al finalizar mapa 1
        ;
        dw historia_1a,historia_1b      ; Estado 1
        dw historia_2,historia_2        ; Estado 2
        dw historia_3a,historia_3b      ; Estado 3
        dw historia_4a,historia_4b      ; Estado 4
        dw historia_5,historia_5        ; Estado 5
        dw historia_6,historia_6        ; Estado 6
        ;
        ; Al hallar a la chica
        ;
        dw historia_7a,historia_7b      ; Estado 7
        dw historia_8,historia_8        ; Estado 8
        dw historia_9a,historia_9b      ; Estado 9
        dw historia_10,historia_10      ; Estado 10
        ;
        ; Al finalizar mapa 2
        ;
        dw historia_11a,historia_11b    ; Estado 11
        dw historia_12,historia_12      ; Estado 12
        dw historia_13a,historia_13b    ; Estado 13
        dw historia_14a,historia_14b    ; Estado 14
        dw historia_15,historia_15      ; Estado 15
        dw historia_16,historia_16      ; Estado 16
        ;
        ; Al hallar al jefe
        ;
        dw historia_17a,historia_17b    ; Estado 17
        dw historia_18,historia_18      ; Estado 18
        dw historia_19a,historia_19b    ; Estado 19
        dw historia_20,historia_20      ; Estado 20
        dw historia_21a,historia_21b    ; Estado 21
        dw historia_22,historia_22      ; Estado 22
        ;
        ; Al finalizar mapa 3
        ;
        dw historia_23a,historia_23b    ; Estado 23
        dw historia_24,historia_24      ; Estado 24
        dw historia_25a,historia_25b    ; Estado 25
        dw historia_26a,historia_26b    ; Estado 26
        dw historia_27,historia_27      ; Estado 27
        dw historia_28a,historia_28b    ; Estado 28

        ;
        ; Banderas (byte 0):
        ; 00 - Continuar con siguiente
        ; 01 - Seleccionar siguiente si rescat¢, posterior si no rescat¢
        ; 02 - Brincar el siguiente e ir al posterior
        ; 03 - Volver al juego
        ; 04 - Volver al juego con efecto
        ; 05 - Ir al gran final
        ;
        ; Retrato (byte 1):
        ; 1 - Delta
        ; 2 - Telefonista
        ; 3 - Cient¡fica 
        ; 4 - Jefe 1 
        ; 5 - Jefe 2 
        ;
        ; Longitud (byte 2):
        ; Contiene la longitud m xima de una l¡nea, no debe exceder de 14
        ; caracteres.
        ;
        ; Letras:
        ; 01-1A - Alfabeto
        ; 2E - !
        ; 2F - ?
        ; 30 - '
        ; 35 - :
        ;
historia_1a:
        db 0,1,11
        ; THAT WAS SO / EASY!
        db $14,$08,$01,$14,$00,$17,$01,$13,$00,$13,$0f,$fe
        db $05,$01,$13,$19,$2E,$ff

historia_1b:
        db 0,1,13
        ; NO ZOMBIE CAN / DEFEAT ME!
        db $0e,$0f,$00,$1a,$0f,$0d,$02,$09,$05,$00,$03,$01,$0e,$fe
        db $04,$05,$06,$05,$01,$14,$00,$0d,$05,$2e,$ff

historia_2:
        db 1,2,11
        ; WELL DONE! / SCIENTISTS / RESCUED: 00
        db $17,$05,$0c,$0c,$00,$04,$0f,$0e,$05,$2e,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$fe
        db $12,$05,$13,$03,$15,$05,$04,$35,$00,$40,$41,$ff

historia_3a:
        db 2,1,12
        ; I'M THE MAN!
        db $09,$30,$0d,$00,$14,$08,$05,$00,$0d,$01,$0e,$2e,$ff

historia_3b:
        db 2,1,11
        ; I LIKE TO / SAVE PEOPLE
        db $09,$00,$0c,$09,$0b,$05,$00,$14,$0f,$fe
        db $13,$01,$16,$05,$00,$10,$05,$0f,$10,$0c,$05,$ff

historia_4a:
        db 0,1,12
        ; I DIDN'T SAW / PEOPLE
        db $09,$00,$04,$09,$04,$0e,$30,$14,$00,$13,$01,$17,$fe
        db $10,$05,$0f,$10,$0c,$05,$ff

historia_4b:
        db 0,1,12
        ; IT IS SO SAD
        db $09,$14,$00,$09,$13,$00,$13,$0f,$00,$13,$01,$04,$ff

historia_5:
        db 0,2,9
        ; WAIT! I'M / RECEIVING / SOMETHING
        db $17,$01,$09,$14,$2e,$00,$09,$30,$0d,$fe
        db $12,$05,$03,$05,$09,$16,$09,$0e,$07,$fe
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$07,$ff

historia_6:
        db 3,3,11
        ; PLEASE HELP / ME! I'M / SURROUNDED
        db $10,$0c,$05,$01,$13,$05,$00,$08,$05,$0c,$10,$fe
        db $0d,$05,$2e,$00,$09,$30,$0d,$fe
        db $13,$15,$12,$12,$0f,$15,$0e,$04,$05,$04,$ff

historia_7a:
        db 0,1,9
        ; I COME TO / SAVE YOU
        db $09,$00,$03,$01,$0d,$05,$00,$14,$0f,$fe
        db $13,$01,$16,$05,$00,$19,$0f,$15,$ff

historia_7b:
        db 0,1,11
        ; I'M HERE TO / RESCUE YOU
        db $09,$30,$0d,$00,$08,$05,$12,$05,$00,$14,$0f,$fe
        db $12,$05,$13,$03,$15,$05,$00,$19,$0f,$15,$ff

historia_8:
        db 0,3,12
        ; YOU'RE TOO / LATE / I'M INFECTED
        db $19,$0f,$15,$30,$12,$05,$00,$14,$0f,$0f,$fe
        db $0c,$01,$14,$05,$fe
        db $09,$30,$0d,$00,$09,$0e,$06,$05,$03,$14,$05,$04,$ff

historia_9a:
        db 0,1,9
        ; INFECTED? / HOW?
        db $09,$0e,$06,$05,$03,$14,$05,$04,$2f,$fe
        db $08,$0f,$17,$2f,$ff

historia_9b:
        db 0,1,12
        ; WHAT ARE YOU / SAYING?
        db $17,$08,$01,$14,$00,$01,$12,$05,$00,$19,$0f,$15,$fe
        db $13,$01,$19,$09,$0e,$07,$2f,$ff

historia_10:
        db 4,3,12
        ; AARGH! HELP! / GRR!
        db $01,$01,$12,$07,$08,$2e,$00,$08,$05,$0c,$10,$2e,$fe
        db $07,$12,$12,$2e,$ff

historia_11a:
        db 0,1,12
        ; POOR GIRL! / SHE WAS CUTE
        db $10,$0f,$0f,$12,$00,$07,$09,$12,$0c,$2e,$fe
        db $13,$08,$05,$00,$17,$01,$13,$00,$03,$15,$14,$05,$ff

historia_11b:
        db 0,1,10
        ; I COULDN'T / SAVE HER
        db $09,$00,$03,$0f,$15,$0c,$04,$0e,$30,$14,$fe
        db $13,$01,$16,$05,$00,$08,$05,$12,$ff

historia_12:
        db 1,2,11
        ; GOOD WORK! / SCIENTISTS / RESCUED: 00
        db $07,$0f,$0f,$04,$00,$17,$0f,$12,$0b,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$fe
        db $12,$05,$13,$03,$15,$05,$04,$35,$00,$40,$41,$ff

historia_13a:
        db 2,1,7
        ; I'M THE / BEST!
        db $09,$30,$0d,$00,$14,$08,$05,$fe
        db $02,$05,$13,$14,$2e,$ff

historia_13b:
        db 2,1,11
        ; I'M / UNBEATABLE!
        db $09,$30,$0d,$fe
        db $15,$0e,$02,$05,$01,$14,$01,$02,$0c,$05,$2e,$ff

historia_14a:
        db 0,1,11
        ; WHAT / SCIENTISTS?
        db $17,$08,$01,$14,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$2f,$ff

historia_14b:
        db 0,1,11
        ; THERE ARE / SCIENTISTS?
        db $14,$08,$05,$12,$05,$00,$01,$12,$05,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$2f,$ff

historia_15:
        db 0,2,14
        ; THERE IS / ANOTHER SIGNAL
        db $14,$08,$05,$12,$05,$00,$09,$13,$fe
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$13,$09,$07,$0e,$01,$0c,$ff

historia_16:
        db 3,4,12
        ; HELP ME! I'M / HIDDEN BUT / SOMEONE / FOLLOWS ME!
        db $08,$05,$0c,$10,$00,$0d,$05,$2e,$00,$09,$30,$0d,$fe
        db $08,$09,$04,$04,$05,$0e,$00,$02,$15,$14,$fe
        db $13,$0f,$0d,$05,$0f,$0e,$05,$fe
        db $06,$0f,$0c,$0c,$0f,$17,$13,$00,$0d,$05,$2e,$ff

historia_17a:
        db 0,1,11
        ; YOU'RE HERE / GREAT!
        db $19,$0F,$15,$30,$12,$05,$00,$08,$05,$12,$05,$FE
        db $07,$12,$05,$01,$14,$2E,$FF

historia_17b:
        db 0,1,12
        ; APPEARS THAT / I'M ON TIME / TO SAVE YOU
        db $01,$10,$10,$05,$01,$12,$13,$00,$14,$08,$01,$14,$fe
        db $09,$30,$0d,$00,$0f,$0e,$00,$14,$09,$0d,$05,$fe
        db $14,$0f,$00,$13,$01,$16,$05,$00,$19,$0f,$15,$ff

historia_18:
        db 0,4,13
        ; SO YOU FOUGHT / YOUR WAY
        db $13,$0f,$00,$19,$0f,$15,$00,$06,$0f,$15,$07,$08,$14,$fe
        db $19,$0f,$15,$12,$00,$17,$01,$19,$ff

historia_19a:
        db 0,1,10
        ; EXCUSE ME?
        db $05,$18,$03,$15,$13,$05,$00,$0d,$05,$2f,$ff

historia_19b:
        db 0,1,13
        ; IT IS MY WORK
        db $09,$14,$00,$09,$13,$00,$0d,$19,$00,$17,$0f,$12,$0b,$ff

historia_20:
        db 0,4,14
        ; I WASN'T GOING / TO SHOW MY / POWERS
        db $09,$00,$17,$01,$13,$0e,$30,$14,$00,$07,$0f,$09,$0e,$07,$fe
        db $14,$0f,$00,$13,$08,$0f,$17,$00,$0d,$19,$fe
        db $10,$0f,$17,$05,$12,$13,$ff

historia_21a:
        db 0,1,13
        ; WAIT! ARE YOU / THE BAD GUY?
        db $17,$01,$09,$14,$2e,$00,$01,$12,$05,$00,$19,$0f,$15,$fe
        db $14,$08,$05,$00,$02,$01,$04,$00,$07,$15,$19,$2f,$ff

historia_21b:
        db 0,1,14
        ; HARMED YOU ALL / THE PEOPLE?
        db $08,$01,$12,$0D,$05,$04,$00,$19,$0F,$15,$00,$01,$0C,$0C,$FE
        db $14,$08,$05,$00,$10,$05,$0f,$10,$0c,$05,$2f,$ff

historia_22:
        db 4,5,11
        ; DO YOU WANT / TO SEE / SOMETHING / SCARY?
        db $04,$0f,$00,$19,$0f,$15,$00,$17,$01,$0e,$14,$fe
        db $14,$0f,$00,$13,$05,$05,$fe
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$07,$fe
        db $13,$03,$01,$12,$19,$2f,$ff

historia_23a:
        db 0,1,10
        ; THAT WAS A / EVIL BOSS!
        db $14,$08,$01,$14,$00,$17,$01,$13,$00,$01,$fe
        db $05,$16,$09,$0c,$00,$02,$0f,$13,$13,$2e,$ff

historia_23b:
        db 0,1,14
        ; SO MANY HARMED / INNOCENTS!
        db $13,$0f,$00,$0d,$01,$0e,$19,$00,$08,$01,$12,$0d,$05,$04,$fe
        db $09,$0e,$0e,$0f,$03,$05,$0e,$14,$13,$2e,$ff

historia_24:
        db 1,2,11
        ; MISSION / COMPLETE! / SCIENTISTS / RESCUED: 00
        db $0d,$09,$13,$13,$09,$0f,$0e,$fe
        db $03,$0f,$0d,$10,$0c,$05,$14,$05,$2e,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$fe
        db $12,$05,$13,$03,$15,$05,$04,$35,$00,$40,$41,$ff

historia_25a:
        db 2,1,12
        ; I'M SO GOOD!
        db $09,$30,$0d,$00,$13,$0F,$00,$07,$0f,$0f,$04,$2e,$ff

historia_25b:
        db 2,1,12
        ; I'M PROUD OF / MYSELF!
        db $09,$30,$0d,$00,$10,$12,$0f,$15,$04,$00,$0f,$06,$fe
        db $0d,$19,$13,$05,$0c,$06,$2e,$ff

historia_26a:
        db 0,1,9
        ; MAYBE I'M / BLIND?
        db $0D,$01,$19,$02,$05,$00,$09,$30,$0D,$fe
        db $02,$0c,$09,$0e,$04,$2f,$ff

historia_26b:
        db 0,1,11
        ; PEOPLE? / WHERE?
        db $10,$05,$0F,$10,$0C,$05,$2F,$FE
        db $17,$08,$05,$12,$05,$2f,$ff

historia_27:
        db 0,2,14
        ; I'VE SENT / AN HELICOPTER
        db $09,$30,$16,$05,$00,$13,$05,$0e,$14,$fe
        db $01,$0e,$00,$08,$05,$0c,$09,$03,$0f,$10,$14,$05,$12,$ff

historia_28a:
        db 5,1,10
        ; I'LL BE ON / TIME TO / WATCH TV!
        db $09,$30,$0c,$0c,$00,$02,$05,$00,$0f,$0e,$fe
        db $14,$09,$0d,$05,$00,$14,$0f,$fe
        db $17,$01,$14,$03,$08,$00,$14,$16,$2e,$ff

historia_28b:
        db 5,1,12
        ; I'VE TO FEED / MY CATS
        db $09,$30,$16,$05,$00,$14,$0f,$00,$06,$05,$05,$04,$fe
        db $0d,$19,$00,$03,$01,$14,$13,$ff

        ;
        ; Los mensajes de la historia b sica.
        ;
mensaje_1:
        db $14,$08,$05,$12,$05,$00,$09,$13,$00,$01,$fe
        db $13,$05,$03,$15,$12,$09,$14,$19,$fe  ; SECURITY
        db $02,$12,$05,$01,$03,$08,$FF          ; BREACH

mensaje_2:
        db $03,$0C,$0F,$13,$05,$00              ; CLOSE
        db $04,$0f,$17,$0e,$FE                  ; DOWN
        db $14,$08,$05,$00                      ; THE
        db $07,$01,$14,$05,$13,$FF              ; GATES

mensaje_3:
        db $14,$08,$05,$0D,$30,$12,$05,$00      ; THEM'RE
        db $14,$08,$12,$0F,$15,$07,$08,$FE      ; THROUGH
        db $14,$08,$05,$00                      ; THE
        db $02,$15,$09,$0C,$04,$09,$0E,$07,$2E  ; BULDING!
        db $FF

mensaje_4:
        db $03,$01,$0c,$0c,$00                  ; CALL
        db $13,$10,$05,$03,$09,$01,$0c,$fe      ; SPECIAL
        db $14,$05,$01,$0d,$00                  ; TEAM
        db $0e,$0f,$17,$2E                      ; NOW!
        db $FF

mensaje_5:
        db $17,$08,$01,$14,$30,$13,$00          ; WHAT'S
        db $14,$08,$01,$14,$2F                  ; THAT?
        db $FF

mensaje_6:
        db $0F,$08,$00,$0D,$19,$00              ; OH MY
        db $07,$0F,$04,$2E,$FF                  ; GOD!

mensaje_7:
        db $05,$0d,$05,$12,$07,$05,$0e,$03,$19,$2e,$fe  ; EMERGENCY!
        db $03,$01,$0c,$0c,$09,$0e,$07,$fe      ; CALLING
        db $04,$05,$0c,$14,$01,$00              ; DELTA
        db $14,$05,$01,$0d,$ff                  ; TEAM

mensaje_8:
        db $04,$05,$0c,$14,$01,$00,$21,$00      ; DELTA 1
        db $12,$05,$01,$04,$19,$2e,$fe          ; READY!
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$12,$fe              ; ENTER
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING A
        db $01,$ff

mensaje_9:
        db $04,$05,$0c,$14,$01,$00,$22,$00      ; DELTA 2
        db $12,$05,$01,$04,$19,$2e,$fe          ; READY!
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$12,$FE              ; ENTER
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING B
        db $02,$ff

mensaje_10:     ; GAME OVER
        db $00,$07,$01,$0d,$05,$00,$0f,$16,$05,$12,$00,$ff

mensaje_11:     ; INFECTION
        db $09,$0e,$06,$05,$03,$14,$09,$0f,$0e,$ff

