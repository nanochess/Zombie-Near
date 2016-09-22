        ;
        ; Historia para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 17-ene-2011.
        ; Revisi¢n: 26-mar-2011. Se elimina opci¢n para mostrar fotos de
        ;                        desarrolladores. Adaptado para presentaci¢n
        ;                        armada por partes. La etiqueta del edificio
        ;                        se pone por separado. Los retratos ahora
        ;                        est n compactados. La tabla aleatoria se
        ;                        compacta.
        ; Revisi¢n: 27-mar-2011. Modificado para ROM linear de 64K.
        ; Revisi¢n: 28-mar-2011. Desactiva la pantalla mientras arma la
        ;                        presentaci¢n. Se cambia el tama¤o de la
        ;                        imagen de personaje en el t¡tulo a 128x128 y
        ;                        el texto "COMPLEJO" a 96x16, desaparecen
        ;                        adem s los zombies en portada, quedan solo
        ;                        en historia. Copyright redimensionado a
        ;                        128x16. Paneles redimensionados a 128x64.
        ;                        T¡tulo 2 redimensionado a 128x112. M s
        ;                        optimizaciones.
        ; Revisi¢n: 29-mar-2011. Se agregan sonidos al mover la pistola y
        ;                        seleccionar opci¢n. M s optimizaciones. Se
        ;                        intercambian colores de la pistola por
        ;                        redise¤o del sprite.
        ; Revisi¢n: 31-mar-2011. Cambia la m£sica al pasar de nivel. Utiliza
        ;                        el registro R para mover puntos
        ;                        aleatoriamente en vez de la enorme tabla.
        ; Revisi¢n: 01-abr-2011. Se modifica historia para el nuevo formato
        ;                        con byte de retrato y ancho combinados.
        ;                        Muestra la nueva historia para el mapa 4.
        ;

        ;
        ; La presentaci¢n
        ;
        ; Puede ponerse voz usando el truco PCM del PSG
        ;
presentacion:
.0:
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
        ld a,retrato_investigadora>>16
        call carga_retrato
        ld hl,retrato_jefe            
        ld de,$0040
        ld a,retrato_jefe>>16
        call carga_retrato
        ld hl,retrato_investigadora3
        ld de,$0080
        ld a,retrato_investigadora3>>16
        call carga_retrato
        ld hl,retrato_jefe3a
        ld de,$00c0      
        ld a,retrato_jefe3a>>16
        call carga_retrato
        ld hl,retrato_jefe3b
        ld de,$08c0      
        ld a,retrato_jefe3b>>16
        call carga_retrato
        ld hl,retrato_telefonista            
        ld de,$0800
        ld a,retrato_telefonista>>16
        call carga_retrato
        ld hl,retrato_delta_1            
        ld de,$1000
        ld a,retrato_delta_1>>16
        call carga_retrato
        ld hl,retrato_delta_2
        ld de,$1040
        ld a,retrato_delta_2>>16
        call carga_retrato
        ld hl,retrato_zombies_1
        ld de,$1080
        ld a,retrato_zombies_1>>16
        call carga_retrato
        ld hl,retrato_zombies_2
        ld de,$10c0
        ld a,retrato_zombies_2>>16
        call carga_retrato
        jr .888
    endif

        CALL PANTALLA_NEGRA
        ld hl,modo      ; Permite acceso directo al sonido
        set 3,(hl)
        LD BC,$A201     ; Desactiva el video
        CALL WRTVDP
        ; Carga pantalla de t¡tulo
        ;
        ; Presentaci¢n compactada (son 12288 bytes si no se compacta)
        ;

        ; Los zombies ahora se ven cuadrados, retirado 28-mar-2010
;        ld hl,retrato_zombies_1
;        ld de,$0000
;        ld a,retrato_zombies_1>>16
;        call carga_retrato
;        ld hl,retrato_zombies_2
;        ld de,$0040
;        ld a,retrato_zombies_2>>16
;        call carga_retrato
        ld a,(ganado)
        or a
        ld hl,$0400
        ld bc,$1080
        ld de,GRAFICA_TITULO_1 AND $FFFF
        jr z,.555
        ld hl,$0500
        ld bc,$0e80
        ld de,GRAFICA_TITULO_2 AND $FFFF
.555:   call descompacta_rle_imagen
        ld de,GRAFICA_LOGO AND $FFFF
        ld hl,$0080
        ld bc,$0c80
        call descompacta_rle_imagen
        ld de,GRAFICA_COPYRIGHT AND $FFFF
        ld hl,$1680
        ld bc,$0280
        call descompacta_rle_imagen
        ld a,(idioma)
        or a
        ld de,GRAFICA_PANEL_EN AND $FFFF
        jr z,.556
        ld de,GRAFICA_PANEL_ES AND $FFFF
.556:   ld hl,$0d80
        ld bc,$0880
        call descompacta_rle_imagen
        ;
        ; Vuelve a definir sprite pistola en sprites h‚roes
        ; y restaura dos sprites que pueden ser borrados por historia
        ;
        ld hl,modo
        res 0,(hl)
        ld a,(ganado)
        or a
        LD HL,figuras_sprites
        jr z,.557
        LD HL,sprites_heroes+$90*8
.557:   LD DE,$1800
        LD BC,$0040
        CALL LDIRVM
        LD HL,figuras_sprites+64
        LD DE,$1840
        LD BC,$0040
        CALL LDIRVM

        ;
        ; Record
        ;
        ld a,(quien)
        or a            ; ¨Record establecido?
        jr z,.558       ; No, salta
        ld hl,bits1
        ld (hl),$08     ; H
        inc hl
        ld (hl),$09     ; I
        inc hl
        ld (hl),$00
        inc hl
        ld a,(record)
        call dos_digitos
        ld a,(record+1)
        call dos_digitos
        ld a,(record+2)
        call dos_digitos
        ld (hl),$20
        inc hl
        ld (hl),$00
        inc hl
        ld a,(quien)
        add a,$20
        ld (hl),a
        inc hl
        ld (hl),$15     ; U
        inc hl
        ld (hl),$90     ; P
        ld hl,$0c88
        ld de,bits1
        ld c,$e1
        call visual_mensaje1
.558:
        ;
        ; Antirebote
        ;
    IF 0
.7:     ld b,5
.2:     halt
        call boton_oprimido
        jr z,.7
        djnz .2
    ENDIF
        LD BC,$E201     ; Activa el video
        CALL WRTVDP
        ld hl,modo
        set 0,(hl)      ; Controla sprites y pantalla
        ld hl,sprites
        ld (hl),$68
        inc hl
        ld (hl),$88
        inc hl
        ld (hl),$04     ; La pistola (color obscuro)
        inc hl
        ld (hl),$0E
        inc hl
        ld (hl),$68
        inc hl
        ld (hl),$88
        inc hl
        ld (hl),$00     ; La pistola (color brillante)
        inc hl
        ld (hl),$0F
.906:
        ld de,(ticks)
.1:     halt
        ld a,(tecla)
        cp $37          ; ¨F3?
        jr nz,.907
        ld a,$ff
        ld (tecla),a
        ld a,1          ; Activa depuraci¢n
        ld (depura),a
.907:   ld a,(tecla)
        cp $36          ; ¨F2?
        jr nz,.908
        ld a,$ff
        ld (tecla),a
        ld a,(depura)
        cp 1
        ld a,2
        jr z,.911
        xor a
.911:   ld (depura),a
.908:   ld a,(tecla)
        cp $35          ; ¨F1?
        jr nz,.909
        ld a,$ff
        ld (tecla),a
        ld a,(depura)
        cp 2            ; ¨Haciendo truco?
        ld a,3          ; S¡, pr¢ximo paso
        jr z,.910
        xor a           ; No, cambia idioma
        ld (depura),a
        ld a,(idioma)
        xor 1           ; Cambio de idioma
        ld (idioma),a
        pop af
        jp reinicio

.910:   ld (depura),a
.909:   ld a,(ticks)
        and 12
        ld bc,$0E0F
        jr nz,.3
        ld bc,$0101
.3:     ld a,b
        ld (sprites+3),a
        ld a,c
        ld (sprites+7),a
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,programa_sonido_sel ; Retorna al mismo tiempo que pone sonido
        xor a           ; Cursor
        push de
        call GTSTCK
        pop de
        cp 1            ; ¨Arriba?
        jr z,.900
        cp 5            ; ¨Abajo?
        jr z,.901
        ld a,1          ; Joystick 1
        push de
        call GTSTCK
        pop de
        cp 1            ; ¨Arriba?
        jr z,.900
        cp 5            ; ¨Abajo?
        jr z,.901
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,600       ; ¨Transcurridos 12 segundos?
        sbc hl,bc
        jp c,.1
        jp .902

        ; Pistola arriba
.900:
        ld a,(sprites)
        cp $68
        jr z,.903
        sub $10
        jr .903

        ; Pistola abajo
.901:   ld a,(sprites)
        cp $88
        jr z,.903
        add a,$10
.903:   ld (sprites),a
        ld (sprites+4),a
        ld hl,tabla_psg1
        call programa_sonido
        ld de,(ticks)
.904:   halt
        ld a,(ticks)
        and 12
        ld bc,$0e0f
        jr nz,.905
        ld bc,$0101
.905:   ld a,b
        ld (sprites+3),a
        ld a,c
        ld (sprites+7),a
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,programa_sonido_sel ; Retorna al mismo tiempo que pone sonido
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,18
        sbc hl,bc
        jr c,.904
        jp .906

        ;
        ; Comienza la historia, empezando por una pantalla de alerta
        ; estilo cine con chicharra inclu¡da.
        ;
.902:
        call limpia_sprites
        halt
        ld a,(idioma)
        or a
        LD HL,GRAFICA_ALERTA_EN AND $FFFF
        jr z,.913
        LD HL,GRAFICA_ALERTA_ES AND $FFFF
.913:   LD B,4
        CALL CARGAR_TOMA
        ;
        ; Programa sonido
        ;
        ld hl,tabla_psg
        call programa_sonido
        ;
        ; El truco es que el fondo es transparente
        ;
        ld a,6
        ld (estado),a
        ld de,(ticks)
.4:     halt
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,.0
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,200       ; ¨Transcurridos 4 segundos?
        sbc hl,bc
        jr c,.4
        xor a
        ld (estado),a
        ld bc,$0107
        call WRTVDP
        call presentacion_limpia
        call musica_historia
        ;
        ; Todos los cuadros de personaje son de 64x64 pixeles, 1024 bytes,
        ; se desplazan utilizando truco directo tabla de caracteres.
        ;
        ld hl,retrato_investigadora     ; Retrato de chica investigadora
        ld de,$08c0
        ld a,retrato_investigadora>>16
        call carga_retrato
        call entrada_derecha
        ; "Security failure"
        ld hl,$11a8
        ld de,mensaje_1
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_jefe              ; Retrato de jefe de investigaci¢n
        ld de,$0800
        ld a,retrato_jefe>>16
        call carga_retrato
        call entrada_izquierda
        ld hl,$1108
        ld de,mensaje_2
        call visual_mensaje_idioma
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
        LD BC,$A201
        CALL WRTVDP
        LD de,GRAFICA_EDIFICIO AND $FFFF
        ld hl,$0000
        ld bc,$1800
        call descompacta_rle_imagen
        ld a,(idioma)
        or a
        ld de,GRAFICA_COMPLEJO_EN AND $FFFF
        jr z,.912
        ld de,GRAFICA_COMPLEJO_ES AND $FFFF
.912:   ld hl,$0050
        ld bc,$0260
        call descompacta_rle_imagen
        ld hl,$1420
        ld de,mensaje_11        ; "INFECTION"
        call visual_mensaje_idioma
        ld hl,$14A0
        ld de,mensaje_11        ; "INFECTION"
        call visual_mensaje_idioma
        LD BC,$E201
        CALL WRTVDP
        ld hl,$2020
        ld (bits1),hl
        ld a,$b1
        ld (bits1+2),a
        LD HL,tabla_puntos
        ld de,sprites
        ld bc,48
        ldir
.800:   ld a,(ticks)
        ld b,a
        halt
        ld a,(ticks)
        cp b
        jr z,.800
        bit 0,a
        jr z,.805
        ;
        ; Mueve seudoaleatoriamente
        ;
        call mueve_puntos
        ;
        ; Duplica sprites para el otro edificio
        ;
.805:   call duplica_puntos
        ld hl,$1638
        ld de,bits1             ; Porcentaje
        call visual_mensaje0
        ld hl,$16b8
        ld de,bits1             ; Porcentaje
        call visual_mensaje0
        ld a,(bits1+1)
        add a,1
        cp $2a
        jr nz,.801
        ld a,(bits1)
        add a,1
        ld (bits1),a
        ld a,$20
.801:   ld (bits1+1),a
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        ld a,(bits1)
        cp $29
        jr nz,.800
        ld a,(bits1+1)
        cp $29
        jr nz,.800
        ;
        ; Retardo por cuadro de presentaci¢n.
        ;
        ld de,(ticks)
.806:   ld a,(ticks)
        ld b,a
        halt
        ld a,(ticks)
        cp b
        jr z,.806
        push de
        bit 0,a
        jr z,.807
        ;
        ; Mueve seudoaleatoriamente
        ;
        call mueve_puntos
        ;
        ; Duplica sprites para el otro edificio
        ;
.807:   call duplica_puntos
        pop de
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,200       ; ¨Transcurridos 5 segundos?
        sbc hl,bc
        jr c,.806
        CALL limpia_sprites
        halt
        call presentacion_limpia
        ld hl,retrato_investigadora   ; Retrato de chica investigadora
        ld de,$08c0
        ld a,retrato_investigadora>>16
        call carga_retrato
        call entrada_derecha
        ; "Them're through the building!"
        ld hl,$1180
        ld de,mensaje_3
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_jefe            ; Retrato de jefe
        ld de,$0800
        ld a,retrato_jefe>>16
        call carga_retrato
        call entrada_izquierda
        ; "Call the special team... What's that?"
        ld hl,$1108
        ld de,mensaje_4
        call visual_mensaje_idioma
        call retardo_cuadro
        call presentacion_limpia
        ; "Oh my god!... gritos y luego est tica"
        ld hl,$1150
        ld de,mensaje_5
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_zombies_1         ; Retrato zombies (izq)
        ld de,$0800
        ld a,retrato_zombies_1>>16
        call carga_retrato
        ld hl,retrato_zombies_2         ; Retrato zombies (der)
        ld de,$08c0
        ld a,retrato_zombies_2>>16
        call carga_retrato
        call entrada_doble
        ld hl,$1350
        ld de,mensaje_6
        call visual_mensaje_idioma
        call retardo_cuadro
        call presentacion_limpia
        ld hl,retrato_telefonista       ; Retrato de telefonista
        ld de,$0060
        ld a,retrato_telefonista>>16
        call carga_retrato
        call entrada_arriba
        ; "Emergency! Calling special team"
        ld hl,$0208
        ld de,mensaje_7
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_delta_1           ; Retrato de Delta-1
        ld de,$08c0
        ld a,retrato_delta_1>>16
        call carga_retrato
        call entrada_derecha
        ; "Delta 1 ready, I'll enter building A"
        ld hl,$1188
        ld de,mensaje_8
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_delta_2           ; Retrato de Delta-2
        ld de,$0800
        ld a,retrato_delta_2>>16
        call carga_retrato
        call entrada_izquierda
        ; "Delta 2 ready, I'll enter building B"
        ld hl,$1108
        ld de,mensaje_9
        call visual_mensaje_idioma
        call retardo_cuadro
        call retardo_cuadro
        jp .0

        ;
        ; Tabla para puntos seudoaleatorios
        ;
tabla_puntos:
        db  30 , 83 , 12 ,7
        db  30 , 48 ,  8 ,7
        db  50 , 47 , 12 ,7
        db  50 , 24 , 12 ,7
        db  70 , 57 , 12 ,7
        db  70 , 45 ,  8 ,7
        db  90 , 25 , 12 ,7
        db  90 , 52 , 12 ,7
        db 110 , 28 ,  8 ,7
        db 110 , 49 , 12 ,7
        db 130 , 64 , 12 ,7
        db 130 , 85 ,  8 ,7

        ;
        ; Mueve puntos seudoaleatoriamente
        ;
mueve_puntos:
        ld hl,sprites
        ld de,tabla_puntos
        ld b,12
.803:   ld a,r
        and $03
        ld c,a
        ld a,(de)
        add a,c
        inc de
        ld (hl),a
        inc hl
        ld a,r
        and $03
        sub 1
        ld c,a
        ld a,(hl)
        add a,c
        cp 24
        jr nc,$+4
        ld a,24
        cp 96
        jr c,$+4
        ld a,96
        inc de
        ld (hl),a
        inc hl
        inc hl
        ld a,(bits1)
        sub $20
        add a,a
        cp b
        jr c,.799
        ld (hl),$09
.799:   inc hl
        dec b
        inc de
        inc de
        ld a,r
        and $03
        ld c,a
        ld a,(de)
        add a,c
        inc de
        ld (hl),a
        inc hl
        ld a,r
        and $03
        sub 2
        ld c,a
        ld a,(hl)
        add a,c
        cp 24
        jr nc,$+4
        ld a,24
        cp 96
        jr c,$+4
        ld a,96
        inc de
        ld (hl),a
        inc hl
        inc hl
        ld a,(bits1)
        sub $20
        add a,a
        cp b
        jr c,.804
        ld (hl),$09
.804:   inc hl
        inc de
        inc de
        djnz .803
        ret

        ;
        ; Duplica puntos seudoaleatorios
        ;
duplica_puntos:
        ld hl,sprites
        ld de,sprites+48
        ld b,12
.809:   ld a,(hl)
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
        djnz .809
        ret

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
        call filvrm
        ld hl,$3050
        ld bc,$0008
        call filvrm
        ld hl,modo
        set 0,(hl)
        ld hl,pantalla
.1:     ld (hl),10
        inc hl
        ld a,h
        cp (pantalla+768)>>8
        jr nz,.1
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
        db $78,$0d
        db $08

        ;
        ; Movimiento de pistola
        ;
tabla_psg1:
        db $58,$03
        db $ac,$01
        db $d6,$00
        db $00
        db $b8
        db $10
        db $10
        db $10
        db $78,$04
        db $09

        ;
        ; Selecci¢n de opci¢n
        ;
tabla_psg2:
        db $d6,$00
        db $a8,$00
        db $8e,$00
        db $00
        db $b8
        db $10
        db $10
        db $10
        db $78,$20
        db $09

        ;
        ; Programa una tabla completa de sonido
        ;
programa_sonido_sel:
        ld hl,tabla_psg2
programa_sonido:
        xor a
.950:   ld e,(hl)
        call WRTPSG
        inc a
        inc hl
        cp 14
        jr nz,.950
        ret

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
        inc a           ; ¨Se oprimi¢ alg£n bot¢n?
        jr z,.2
        inc b
        ld a,b
        sub 5
        jr nz,.1
        inc a           ; Para que no sea cero
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
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push bc
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,150       ; ¨Transcurridos 3 segundos?
        sbc hl,bc
        jr c,.1
        ret

        ;
        ; Carga un retrato
        ;
carga_retrato:
        ex de,hl
        ld bc,$0840
        jp descompacta_rle_imagen

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
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,presentacion
        push de
        ld a,c
        sub 32
        ld c,a
        inc b
        ld a,b
        cp 9
        jr nz,.1
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
        jr z,.8
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
        jr .5

.4:     ld (hl),a
        add a,e
        add hl,de
        ld (hl),a
        add a,e
        add hl,de
        ld (hl),a
        add a,e
        add hl,de
        ld (hl),a
        add a,e
        add hl,de
        ld (hl),a
        add a,e
        add hl,de
        ld (hl),a
        add a,e
        add hl,de
        ld (hl),a
        add a,e
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
        jr z,.9
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
        jr c,.6
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
        jr .7

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
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
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
        ld a,(ix+d_seccion)
        and $30
        ld b,1          ; Finaliza mapa 1
        jr z,.1
        ld b,11         ; Finaliza mapa 2
        cp $10
        jr z,.1                         
        ld b,23         ; Finaliza mapa 3 
        cp $20
        jr z,.1
        ld b,33         ; Finaliza mapa 4
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
        LD HL,modo
        set 5,(hl)      ; Para que no haga parpadeo de mosaico pantalla PC
        LD HL,GRAFICA_HELICOPTERO AND $FFFF
        LD B,2
        CALL CARGAR_TOMA
        LD HL,modo
        set 0,(hl)
        set 2,(hl)      ; Define sprites jugadores
        ld b,25
        call aspas_helicoptero
        djnz $-3

        ;
        ; El cuadro de final se compone seg£n si uno o dos de los jugadores
        ; lo lograron.
        ;
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
        inc a   ; cp -1
        ld (hl),$00
        jr z,$+4
        ld (hl),$07
        inc hl
        ld (hl),$c4
        inc hl
        ld (hl),$98
        inc hl
        ld (hl),$04     ; La chica
        inc hl
        ld a,(jug2+d_vidas)
        inc a   ; cp -1
        ld (hl),$00
        jr z,$+4
        ld (hl),$09
        inc hl  
        ld (hl),$b4
        inc hl
        ld (hl),$78
        inc hl
        ld (hl),$cc     ; El chico
        inc hl
        ld a,(jug1+d_vidas)
        inc a   ; cp -1
        ld (hl),$00
        jr z,$+4
        ld (hl),$0a
        inc hl
        ld (hl),$ba
        inc hl
        ld (hl),$98
        inc hl
        ld (hl),$dc     ; La chica
        inc hl
        ld a,(jug2+d_vidas)
        inc a
        ld (hl),$00
        jr z,$+4
        ld (hl),$0a
        inc hl  
        ;
        ; Animaci¢n de carrerita hasta el helic¢ptero
        ;
.1:     call aspas_helicoptero
        bit 0,a
        jr z,.1
        and $0c
        cp $0c
        jr nz,$+4
        ld a,$04
        or $30
        ld (sprites_especiales),a
        or $70
        ld (sprites_especiales+2),a
        ld hl,sprites+12
        dec (hl)
        ld hl,sprites+8
        dec (hl)
        ld hl,sprites+4
        dec (hl)
        ld hl,sprites
        dec (hl)
        ld a,(hl)
        cp $78
        jr nz,.1
        ;
        ; Nuestros h‚roes entran al helic¢ptero.
        ;
        ld a,$d1
        ld (sprites),a
        ld (sprites+4),a
        ld (sprites+8),a
        ld (sprites+12),a
        ld b,10
        call aspas_helicoptero
        djnz $-3
        ;
        ; Salen unos amistosos zombies
        ;
        ld hl,tabla_zombies
        ld de,sprites+8
        ld bc,24
        ldir
.2:     call aspas_helicoptero
        bit 0,a
        jr z,.2
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
        cp $7c
        jr nz,$+4
        ld a,$74
        ld (hl),a
        inc hl
        inc hl
        inc hl
        inc hl
        djnz .3
        ld a,(sprites+24)
        cp $7C
        jr nz,.2
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
        ld a,(idioma)
        or a
        LD HL,GRAFICA_FIN_EN AND $FFFF
        jr z,.5
        LD HL,GRAFICA_FIN_ES AND $FFFF
.5:     LD B,4
        CALL CARGAR_TOMA
        ld bc,500
.4:     halt
        dec bc
        ld a,b
        or c
        jr nz,.4
        ld hl,ganado
        inc (hl)
        ld hl,modo
        res 5,(hl)
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
        halt
        push bc
        ld a,(ticks)
        and 7
        rlca
        rlca
        rlca
        rlca
        ld c,a
        ld b,0
        ld hl,tabla_aspas
        add hl,bc
        ld de,pantalla+$0147
        ld c,8
        ldir
        inc de
        inc de
        ld c,8
        ldir
        pop bc
        ld a,(ticks)
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
        jp inicia_historia
    endif

        ;
        ; Limpia la zona de historia para volver a nivel
        ; Hay que restaurar gr ficas.
        ;
zona_historia:
        ld hl,modo
        res 0,(hl)
        ld a,(ix+d_refx)
        or a
        jr nz,.1
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
        ld bc,indice_color_letras
        ld a,56
        call descompacta_color
        ld hl,graf_bitmap
        ld de,$01c0
        ld bc,1600
        call LDIRVM
        ld hl,graf_color
        ld de,$21c0
        ld bc,indice_graf_color
        ld a,200
        call descompacta_color
        ld hl,pantalla
        ld b,0
        ld (hl),$ff
        inc hl
        djnz $-3
        jp normalidad

.1:     ld hl,$3e00
        ld bc,$0100
        xor a
        call filvrm
        ld hl,letras
        ld de,$1000
        ld bc,$01c0
        call LDIRVM
        ld hl,color_letras
        ld de,$3000
        ld bc,indice_color_letras
        ld a,56
        call descompacta_color
        ld hl,graf_bitmap
        ld de,$11c0
        ld bc,1600
        call LDIRVM
        ld hl,graf_color
        ld de,$31c0
        ld bc,indice_graf_color
        ld a,200
        call descompacta_color
        ld hl,pantalla+512
        ld b,0
        ld (hl),$00
        inc hl
        djnz $-3
        jp normalidad

        ;
        ; Avanza la historia
        ;
avanza_historia:
        ld a,(ix+d_estado)
        or a
        ret z
        ld a,(ix+d_tiempo)
        sub 7           ; ¨Tiempo de limpiar?
        or (ix+d_tiempo+1)
        call z,zona_historia_2  ; Si, limpia
        ;
        ; Este es un truco, lo hace en tiempo 1, porque si espera al cero
        ; aparecer¡a un jefe. :)
        ;
        ld a,(ix+d_tiempo)
        dec a           ; ¨Tiempo de cambiar?
        or (ix+d_tiempo+1)
        ret nz
        ld a,(ix+d_estado)
        cp $fd          ; ¨Pasa de nivel?
        jp z,.1
        cp $ff          ; ¨Gana el juego?
        jp z,.2
        cp $fe          ; ¨Encuentro previo?
        jp nz,visualiza_historia
        ;
        ; El monigote b sico se transforma en grande y feo monstruo
        ;
        ld (ix+d_estado),0      ; Estado normal
        call zona_historia
        call carga_nivel
        call actualiza_indicadores
        res 3,(ix+d_objeto)     ; Elimina bandera o repetir¡a eternamente
        xor a
        ld (ix+d_tiempo),a      ; No va a aparecer ning£n jefe
        ld (ix+d_tiempo+1),a
        ld a,(ix+d_sprite)
        and $04                 ; Vuelve a sprite de caminando
        rlca
        rlca
        rlca
        rlca
        or $08
        ld (ix+d_sprite),a
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16                ; Observe que el primer monigote es la bala
        add hl,de
        push iy
        push hl
        pop iy
        ld (iy+d_tipo),12       ; Parpadeando
        ld (iy+d_paso),4        ; Velocidad lenta
        ld (iy+d_velocidad),4
        ld (iy+d_dx),12         ; Contador
        pop iy
        ret

        ;
        ; Ha pasado de nivel
        ;
.1:     call zona_historia      ; Elimina las imagenes de historia
        xor a
        ld (ix+d_estado),a      ; Estado normal
        ld (ix+d_tiempo),a      ; No va a aparecer ning£n jefe
        ld (ix+d_tiempo+1),a
        ld (ix+d_nivel),a       ; Piso 1
        ld (ix+d_rescatados),a  ; Cero cient¡ficos rescatados
        ld a,(ix+d_seccion)
        add a,$10               ; Siguiente mapa
        ld (ix+d_seccion),a
        ld (ix+d_energia),6     ; Rellena energ¡a
        ; Desactivado 02-abr-2011
;        inc (ix+d_vidas)        ; Proporciona una vida extra
        ld a,(ix+d_refx)
        inc a
        ld (ix+d_basex),a       ; Inicia coordenada X reaparici¢n.
        ld (ix+d_x),a           ; Coordenada X
        ld a,(ix+d_refy)
        add a,$10
        ld (ix+d_y),a           ; Coordenada y
        ld (ix+d_basey),a       ; Inicia coordenada Y reaparici¢n.
        ld (ix+d_paso),2
        ld (ix+d_velocidad),2
        ;
        ; Reinicia el mapa de objetos recogidos
        ;
        ld l,(ix+d_mapa)
        ld h,(ix+d_mapa+1)
        ld b,101
        ld (hl),0
        inc hl
        djnz $-3
        call musica_general
        ;
        ; Carga el nivel
        ;
        call carga_nivel
        ;
        ; Actualiza indicadores
        ;
        call actualiza_indicadores
        ;
        ; Para que el jugador se sienta ufano
        ;
        jp efecto_vida

        ;
        ; Ha ganado el juego
        ;
.2:     xor a
        ld (ix+d_estado),a      ; Estado normal
        ld (ix+d_tiempo),a      ; No va a aparecer ning£n jefe
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
        ;
        ; Limpieza r pida del  rea para mostrar los gr ficos
        ;
zona_historia_2:
        ld a,(ix+d_estado)
        inc a                   ; ¨Gana el juego?
        ret z                   ; S¡, deja lema final.
        ld a,(ix+d_refx)
        or a
        jr nz,.1
        ld hl,pantalla
        ld b,0
        ld (hl),$ff
        inc hl
        djnz $-3
        ld b,128
        ld (hl),$ff
        inc hl
        djnz $-3
        jr .2

.1:     ld hl,pantalla+384
        xor a
        ld b,a
        ld (hl),a
        inc hl
        djnz $-2
        ld b,128
        ld (hl),a
        inc hl
        djnz $-2
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
        jr z,.1         ; S¡, salta
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
        push af
        call mapea_simple
        pop af
        ld a,(hl)       ; Salva c¢digo siguiente estado
        inc hl
        push af
        ld a,(hl)       ; Obtiene n£mero de retrato
        jr nc,.0        ; Cambia seg£n jugador
        and $f0
        or $08
        jr .7
.0:     and $f0
.7:     push hl
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
        ld (hist_tem),a
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
        call mapea_normal
        push de
        call carga_retrato      ; Carga el retrato, a£n no visible
        pop de
        srl d
        rr e
        srl d
        rr e
        srl d
        rr e
        ld hl,pantalla
        add hl,de
        ld c,8                  ; 8 l¡neas en cada retrato
.6:     ld b,8                  ; 8 columnas en cada retrato
        ld (hl),l
        inc l
        djnz $-2
        ld a,l
        add a,24
        ld l,a
        dec c
        jr nz,.6
        pop hl
        call mapea_simple
        ld e,(hl)       ; Obtiene zona de texto
        inc hl
        ld d,(hl)
        pop hl
        ld a,(hl)       ; Obtiene ancho de texto
        and $0f
        ld b,a
        inc hl
        call mapea_normal
        ld a,(hist_tem)
        or a            ; ¨Alineaci¢n izquierda?
        jr z,.5         ; S¡, ya no hay que hacer nada
        ld a,15         ; Alinea a un caracter del retrato
        sub b
        add a,a
        add a,a
        add a,a
        add a,e
        ld e,a
.5:     ex de,hl
        call visual_mensaje_idioma
        ld (ix+d_tiempo),300 and 255
        ld (ix+d_tiempo+1),300 >> 8
        pop af
        or a            ; 0 - Ir a siguiente cuadro
        jr nz,.2
        inc (ix+d_estado)
        ret

.2:     dec a           ; 1 - Ir a sig. si rescat¢, de lo contrario brinca
        jr nz,.3
        inc (ix+d_estado)
        ld a,(ix+d_rescatados)
        or a
        ret nz
        inc (ix+d_estado)
        ret

.3:     dec a           ; 2 - Brincar sig. estado
        jr nz,.4
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
        dw retrato_delta_1,$0100+(retrato_delta_1>>16),$0080,$0200
        dw retrato_delta_2,$0000+(retrato_delta_2>>16),$1040,$1288
        dw retrato_telefonista,$0000+(retrato_telefonista>>16),$0000,$0248
        dw retrato_telefonista,$0100+(retrato_telefonista>>16),$10c0,$1240
        dw retrato_investigadora2,$0000+(retrato_investigadora2>>16),$0000,$0248
        dw retrato_investigadora3,$0100+(retrato_investigadora3>>16),$10c0,$1240
        dw retrato_jefe2a,$0000+(retrato_jefe2a>>16),$0000,$0248
        dw retrato_jefe3a,$0100+(retrato_jefe3a>>16),$10c0,$1240
        dw retrato_jefe2b,$0000+(retrato_jefe2b>>16),$0000,$0248
        dw retrato_jefe3b,$0100+(retrato_jefe3b>>16),$10c0,$1240

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
        ; Al hallar al jefe nuevamente
        ;
        dw historia_29a,historia_29b    ; Estado 29
        dw historia_30,historia_30      ; Estado 30
        dw historia_31a,historia_31b    ; Estado 31
        dw historia_32,historia_32      ; Estado 32
        ;
        ; Al finalizar mapa 4
        ;
        dw historia_33a,historia_33b    ; Estado 33
        dw historia_34,historia_34      ; Estado 34
        dw historia_35a,historia_35b    ; Estado 35
        dw historia_36a,historia_36b    ; Estado 36
        dw historia_37,historia_37      ; Estado 37
        dw historia_38a,historia_38b    ; Estado 38

