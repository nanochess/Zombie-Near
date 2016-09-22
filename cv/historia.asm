        ;
        ; Historia para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 17-ene-2011.
        ; Revisi¢n: 21-abr-2011. Comienza reducci¢n a 32K para Colecovision.
        ; Revisi¢n: 26-abr-2011. Se agregan retratos para minihistoria.
        ; Revisi¢n: 04-may-2011. Se agrega rutina para checksum de ROM.
        ; Revisi¢n: 09-may-2011. Se optimiza la historia.
        ; Revisi¢n: 12-may-2011. Se ponen letras grandes de final.
        ; Revisi¢n: 13-may-2011. Llama a m£sica de historia. Se agrega
        ;                        retardo despu‚s de selecci¢n de controlador,
        ;                        por si las moscas.
        ; Revisi¢n: 17-may-2011. Se reubica video $3c00 en $3800 (VDP).
        ; Revisi¢n: 27-jun-2011. Se elimina el checksum (afectaba mapeador
        ;                        Megacart). Se integran de nuevo las tres
        ;                        im genes de t¡tulo. Liga a la historia para
        ;                        el mapa 4.
        ; Revisi¢n: 28-jun-2011. Se integra de nuevo la historia, la
        ;                        secuencia del beso y el helic¢ptero. Se
        ;                        programan los sonidos de selecci¢n, mov. de
        ;                        pistola y alerta.
        ; Revisi¢n: 29-jun-2011. Se integra c¢digo de prueba para reproducir
        ;                        un video de 28 cuadros a 15 cuadros por seg.
        ; Revisi¢n: 05-jul-2011. Se compacta el video con RLE, la velocidad
        ;                        de descompactaci¢n es buena.
        ; Revisi¢n: 18-mar-2013. Se elimina el video y se pone el retrato
        ;                        est tico de zombies.
        ; Revisi¢n: 01-jul-2013. Permite introducir contrase¤a en la pantalla
        ;                        inicial para iniciar en mapa adelantado.
        ; Revisi¢n: 03-jul-2013. Se hace m s lento el sonido de campana en
        ;                        pantalla "Alert".
        ; Revisi¢n: 11-jul-2013. Se acelera velocidad inicial de jugadores al
        ;                        cambiar de nivel.
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
        out (KEYSEL),a
        ex (sp),hl
        ex (sp),hl
        in a,(JOY1)
        and $4f
        cp $05          ; Tecla 7 y bot¢n derecho
        jp nz,.887
.888:       
        ld hl,retrato_investigadora            
        ld de,$0000
        call carga_retrato
        ld hl,retrato_jefe            
        ld de,$0040
        call carga_retrato
        ld hl,retrato_investigadora3
        ld de,$0080
        call carga_retrato
        ld hl,retrato_jefe3a
        ld de,$00c0      
        call carga_retrato
        ld hl,retrato_jefe3b
        ld de,$08c0      
        call carga_retrato
        ld hl,retrato_telefonista            
        ld de,$0800
        call carga_retrato
        ld hl,retrato_beso1
        ld de,$0840
        call carga_retrato
        ld hl,retrato_beso2
        ld de,$0880
        call carga_retrato
        ld hl,retrato_delta_1            
        ld de,$1000
        call carga_retrato
        ld hl,retrato_delta_2
        ld de,$1040
        call carga_retrato
        ld hl,retrato_zombies_1
        ld de,$1080
        call carga_retrato
        ld hl,retrato_zombies_2
        ld de,$10c0
        call carga_retrato
        ld b,200
        halt
        djnz $-1
        ld hl,retrato_investigadora2
        ld de,$0080
        call carga_retrato
        ld hl,retrato_jefe2a
        ld de,$00c0      
        call carga_retrato
        ld hl,retrato_jefe2b
        ld de,$08c0      
        call carga_retrato
        ld b,200
        halt
        djnz $-1
        jp .888

        ; Para probar las tomas compactadas con RLE base
.887:   cp $01          ; Tecla 8 y bot¢n derecho
        jp nz,.890
.889:   LD HL,GRAFICA_ALERTA_EN AND $FFFF
        LD B,4
        CALL CARGAR_TOMA
        ld b,200
        halt
        djnz $-1
        LD HL,GRAFICA_HELICOPTERO AND $FFFF
        LD B,2
        CALL CARGAR_TOMA
        ld b,200
        halt
        djnz $-1
        LD HL,GRAFICA_FIN_EN AND $FFFF
        LD B,4
        CALL CARGAR_TOMA
        ld b,200
        halt
        djnz $-1
        jr .889

.890:   cp $0d
        jr nz,.886
        ld a,(ganado)
        or $10
        ld (ganado),a
.885:   halt
        in a,(JOY1)
        and $4f
        cp $4f
        jr nz,.885
.886:   CALL PANTALLA_NEGRA
        ld hl,modo      ; Permite acceso directo al sonido
        set 3,(hl)
        call desactiva_video
        ;
        ; Carga pantalla de t¡tulo
        ;
        ; Presentaci¢n compactada (son 12288 bytes si no se compacta)
        ;
        ld hl,SLOT_1
        call sel_slot
        ld a,(ganado)
        and $0f
.559:   sub 3
        jr nc,.559
        add a,3
        ld hl,$0400
        ld bc,$1080
        ld de,GRAFICA_TITULO_1 AND $FFFF
        cp 2
        jr z,.555
        ld hl,$0500
        ld bc,$0e80
        ld de,GRAFICA_TITULO_2 AND $FFFF
        dec a
        jr z,.555
        ld hl,$0000
        ld bc,$1880
        ld de,GRAFICA_TITULO_3 AND $FFFF
.555:   call descompacta_rle_imagen
        ld de,GRAFICA_LOGO AND $FFFF
        ld hl,$0080
        ld bc,$0b78
        call descompacta_rle_imagen
        ld de,GRAFICA_COPYRIGHT AND $FFFF
        ld hl,$1680
        ld bc,$0280
        call descompacta_rle_imagen
        call sel_slot0
        ;
        ; Vuelve a definir sprite pistola en sprites h‚roes
        ; y restaura dos sprites que pueden ser borrados por historia
        ;
        rst $28 ; zona_dura
        LD HL,figuras_sprites
        LD DE,$1800
        LD BC,$0700
        CALL LDIRVM
        call zona_facil
        ld a,(ganado)
        and $0f
        jr z,.557
        rst $28 ; zona_dura
        LD HL,sprites_heroes+$90*8
        LD DE,$1800
        LD BC,$0040
        CALL LDIRVM
        call zona_facil
.557:

        ;
        ; Record
        ;
        ld a,(ganado)
        rlca
        rlca
        and 3           ; ¨Record establecido?
        jr z,.558       ; No, salta
        ld hl,bits1
        ld (hl),$08     ; H
        inc hl
        ld (hl),$09     ; I
        inc hl
        ld (hl),$00
        inc hl
        ld de,record
        call dos_digitos2
        call dos_digitos2
        call dos_digitos2
        ld (hl),$20
        ld a,(ganado)
        rlca
        rlca
        and 3
        add a,(hl)
        inc hl
        ld (hl),$00
        inc hl
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
        ; El HALT sincroniza para evitar NMI al escribir registro VDP
        ;
        call activa_video
        ld hl,SLOT_1
        call sel_slot
        ld de,GRAFICA_PANEL_EN AND $FFFF
        ld hl,$0d80
        ld bc,$0880
        call descompacta_rle_imagen
        call sel_slot0
        ld hl,modo
        set 0,(hl)      ; Controla sprites y pantalla
        ld hl,sprite_pistola
        ld de,sprites
        ld bc,8
        ldir
        xor a           ; Introducci¢n de clave
        ld (nivel1),a
        ld (nivel1+5),a ; Mapa inicial
.906:
        ld de,(ticks)
.1:     halt
        call decodifica
        ld a,(tecla)
        cp $ff
        jp z,.5
        push af
        ld a,$ff
        ld (tecla),a
        ld a,(nivel1)
        ld e,a
        ld d,0
        pop af
        ld hl,nivel1+1
        add hl,de
        ld (hl),a
        ld a,(nivel1)
        inc a
        ld (nivel1),a
        ld hl,tabla_psg3
        sub 4
        jp nz,.7
        ld (nivel1),a
        ld a,(nivel1+1)
        cp 6
        jr nz,.8
        ld a,(nivel1+2)
        cp 7
        jp nz,.10
        ld a,(nivel1+3)
        cp 3
        jp nz,.10
        ld a,(nivel1+4)
        cp 1
        jp c,.10
        cp 4
        jp nc,.10
        call clave_jugador
        ld a,1
        ld (nivel1+5),a
        jp seleccion

.8:     ld a,(nivel1+1)
        cp 3
        jr nz,.9
        ld a,(nivel1+2)
        cp 9
        jp nz,.10
        ld a,(nivel1+3)
        cp 2
        jp nz,.10
        ld a,(nivel1+4)
        cp 1
        jp c,.10
        cp 4
        jp nc,.10
        call clave_jugador
        ld a,2
        ld (nivel1+5),a
        jp seleccion

.9:     ld a,(nivel1+1)
        cp 8
        jr nz,.10
        ld a,(nivel1+2)
        cp 4
        jp nz,.10
        ld a,(nivel1+3)
        cp 5
        jp nz,.10
        ld a,(nivel1+4)
        cp 1
        jp c,.10
        cp 4
        jp nc,.10
        call clave_jugador
        ld a,3
        ld (nivel1+5),a
        jp seleccion

.10:    ld hl,tabla_psg4
.7:     call programa_sonido
        ld b,3
.6:     push bc
        halt
        call decodifica
        call parpadeo_pistola
        pop bc
        jp z,seleccion
        djnz .6
        call psg_silencio
        ld de,(ticks)

.5:     call parpadeo_pistola
        jp z,seleccion          ; Retorna
        ld a,c
        rrca            ; ¨Arriba?
        jr nc,.900
        rrca
        rrca            ; ¨Abajo?
        jr nc,.901
        or a
        sbc hl,de
        ld bc,800       ; ¨Transcurridos 16 segundos?
        sbc hl,bc
        jp c,.1
        jr .907

        ; Pistola arriba
.900:
        ld a,(sprites)
        cp $69
        jr z,.903
        sub $0F
        jr .903

        ; Pistola abajo
.901:   ld a,(sprites)
        cp $87
        jr z,.903
        add a,$0F
.903:   ld (sprites),a
        ld (sprites+4),a
        ld hl,tabla_psg1
        call programa_sonido
        ld de,(ticks)
.904:   call parpadeo_pistola
        jp z,seleccion          ; Retorna
        or a
        sbc hl,de
        ld a,l
        cp 15
        jr c,$+4
        ld a,15
        or $90
        out (PSG),a
        or $b0
        out (PSG),a
        xor $60
        out (PSG),a
        ld bc,18
        and a
        sbc hl,bc
        jr c,.904
        call psg_silencio
        jp .906

        ;
        ; Minihistoria
        ;
.907:   call limpia_sprites
        halt
        LD HL,GRAFICA_ALERTA_EN AND $FFFF
        LD B,4
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
        ld a,(ticks)
        sub e
        push hl
        add a,a
        ld l,a
        ld h,0
        rl h
        ld a,$ff
        ld bc,$fffd
.41:    inc a
        add hl,bc
        jp c,.41
        pop hl
        and 15
        or $90
        out (PSG),a
        or $b0
        out (PSG),a
        xor $60
        out (PSG),a
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
        call psg_silencio
        halt
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
;        ld a,retrato_investigadora>>16
        call carga_retrato
        call entrada_derecha
        ; "Security failure"
        ld hl,$11a8
        ld de,mensaje_1
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_jefe              ; Retrato de jefe de investigaci¢n
        ld de,$0800
;        ld a,retrato_jefe>>16
        call carga_retrato
        call entrada_izquierda
        ld hl,$1108
        ld de,mensaje_2
        call visual_mensaje_idioma
        call retardo_cuadro
        ;
        ; Edificio compactado, solo verde m s sprites
        ;
        xor a
        ld (estado),a
        CALL PANTALLA_NEGRA_RAPIDA
        ld hl,modo
        res 0,(hl)
        rst $28 ; zona_dura
        LD HL,sprites_heroes+$400
        LD DE,$1840
        LD BC,$0040
        CALL LDIRVM
        call zona_facil
        call desactiva_video
        ld hl,SLOT_2
        call sel_slot
        LD de,GRAFICA_EDIFICIO AND $FFFF
        ld hl,$0000
        ld bc,$1800
        call descompacta_rle_imagen
        ld hl,SLOT_1
        call sel_slot
        ld de,GRAFICA_COMPLEJO_EN AND $FFFF
        ld hl,$0050
        ld bc,$0260
        call descompacta_rle_imagen
        ld hl,SLOT_0
        call sel_slot
        ld hl,$1420
        ld de,mensaje_11        ; "INFECTION"
        call visual_mensaje_idioma
        ld hl,$14A0
        ld de,mensaje_11        ; "INFECTION"
        call visual_mensaje_idioma
        call activa_video
        ld hl,modo
        set 0,(hl)
        ld hl,$2020
        ld (bits1),hl
        ld a,$b1
        ld (bits1+2),a
        LD HL,tabla_puntos
        ld de,sprites
        ld bc,48
        ldir
        ld de,(ticks)
.800:   ld a,(ticks)
        ld b,a
        halt
        ld a,(ticks)
        cp b
        jr z,.800
        push de
        bit 0,a
        jr z,.805
        ;
        ; Mueve puntos seudoaleatoriamente
        ;
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
        dec a
        bit 0,b
        jr z,$+3
        dec a
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
        ;
        ; Para el otro edificio duplica los sprites de puntos
        ;
.805:   ld hl,sprites
        ld de,sprites+48
        ld bc,$0cff
.809:   ldi
        ld a,(hl)
        cpl
        sub 15
        ld (de),a
        inc hl
        inc de
        ldi
        ldi
        djnz .809
        ld hl,(bits1)
        ld a,h
        cp $28
        jr nz,.806
        ld a,l
        cp $29
        jr z,.807
.806:   inc h
        ld a,h
        cp $2a
        jr nz,.801
        inc l
        ld h,$20
.801:   ld (bits1),hl
        ld hl,$1638
        ld de,bits1             ; Porcentaje
        call visual_mensaje0
        ld hl,$16b8
        ld de,bits1             ; Porcentaje
        call visual_mensaje0
.807:   call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        pop de
        jp z,presentacion
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,300       ; ¨Transcurridos 6 segundos?
        sbc hl,bc
        jp c,.800
        CALL limpia_sprites
        halt
        call presentacion_limpia
        ld hl,retrato_investigadora   ; Retrato de chica investigadora
        ld de,$08c0
        call carga_retrato
        call entrada_derecha
        ; "Them're through the building!"
        ld hl,$1180
        ld de,mensaje_3
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_jefe            ; Retrato de jefe
        ld de,$0800
        call carga_retrato
        call entrada_izquierda
        ; "Call the special team... What's that?"
        ld hl,$1108
        ld de,mensaje_4
        call visual_mensaje_idioma
        call retardo_cuadro
        call presentacion_limpia
        ld hl,$0100
        ld (offset),hl
        ; "Oh my god!... gritos y luego est tica"
        ld hl,$1150
        ld de,mensaje_5
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_zombies_1         ; Retrato zombies (izq)
        ld de,$0800
        call carga_retrato
        ld hl,retrato_zombies_2         ; Retrato zombies (der)
        ld de,$08c0
        call carga_retrato
        call entrada_doble
        ld hl,$1350
        ld de,mensaje_6
        call visual_mensaje_idioma
        call retardo_cuadro
        call presentacion_limpia
        ld hl,retrato_telefonista       ; Retrato de telefonista
        ld de,$0060
        call carga_retrato
        call entrada_arriba
        ; "Emergency! Calling special team"
        ld hl,$0208
        ld de,mensaje_7
        call visual_mensaje_idioma
        call retardo_cuadro
        halt
        ld hl,$0100
        ld (offset),hl
        ld hl,pantalla
        ld b,$00        ; 256
        ld (hl),10
        inc hl
        djnz $-3
        ld hl,retrato_delta_1           ; Retrato de Delta-1
        ld de,$08c0
        call carga_retrato
        call entrada_derecha
        ; "Delta 1 ready, I'll enter building A"
        ld hl,$1188
        ld de,mensaje_8
        call visual_mensaje_idioma
        call retardo_cuadro
        ld hl,retrato_delta_2           ; Retrato de Delta-2
        ld de,$0800
        call carga_retrato
        call entrada_izquierda
        ; "Delta 2 ready, I'll enter building B"
        ld hl,$1108
        ld de,mensaje_9
        call visual_mensaje_idioma
        call retardo_cuadro
        call retardo_cuadro
        jp .0

clave_jugador:
        cp $01
        ld c,$69
        jr z,.1
        cp $02
        ld c,$78
        jr z,.1
        ld c,$87
.1:     ld a,c
        ld (sprites),a
        ld (sprites+4),a
        ret

        ;
        ; Tabla para puntos seudoaleatorios
        ;
tabla_puntos:
        db  28 , 83 , 12 ,7
        db  28 , 48 ,  8 ,7
        db  48 , 47 , 12 ,7
        db  48 , 24 , 12 ,7
        db  68 , 57 , 12 ,7
        db  68 , 45 ,  8 ,7
        db  88 , 25 , 12 ,7
        db  88 , 52 , 12 ,7
        db 108 , 28 ,  8 ,7
        db 108 , 49 , 12 ,7
        db 128 , 64 , 12 ,7
        db 128 , 85 ,  8 ,7

        ;
        ; Limpia solo la secci¢n de di logos
        ;
presentacion_limpia_2:
        rst $28 ; zona_dura
        ld hl,$3050
        ld bc,$0008
        xor a
        call filvrm
        call zona_facil
        ld hl,pantalla+256
        ld b,128
.1:     ld (hl),10
        inc hl
        djnz .1
        ld hl,256
        ld (offset),hl
        ld a,8
        ld (estado),a
        halt
        ret

        ;
        ; Limpia la pantalla en preparaci¢n para entrada de retratos
        ;
presentacion_limpia:
        rst $28 ; zona_dura
        ld hl,$2050     ; Caracter $0a
        ld bc,$0008
        xor a
        call filvrm
        ld hl,$2850
        ld bc,$0008
        call filvrm
.0:     ld hl,$3050
        ld bc,$0008
        call filvrm
        call zona_facil
        ld hl,pantalla
        ld bc,384
.1:     ld (hl),10
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,.1
        ld a,8
        ld (estado),a
        halt
        ld hl,0
        ld (offset),hl
        halt
        ld hl,384
        ld (offset),hl
        halt
        ret

    if 1
        ;
        ; Limpia la pantalla en preparaci¢n para video
        ;
presentacion_limpia3:
        rst $28 ; zona_dura
        ld hl,$2000     ; Caracter $00
        ld bc,$0008
        xor a
        call filvrm
        ld hl,$2800
        ld bc,$0008
        call filvrm
.0:     ld hl,$3000
        ld bc,$0008
        call filvrm
        call zona_facil
        ld hl,pantalla
        ld bc,384
.1:     ld (hl),0
        inc hl
        dec bc
        ld a,b
        or c
        jp nz,.1
        ld a,8
        ld (estado),a
        halt
        ld hl,0
        ld (offset),hl
        halt
        ld hl,384
        ld (offset),hl
        halt
        ret
    endif

parpadeo_pistola:
        halt
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
        ld hl,(ticks)
        ret

sprite_pistola:
        db $69,$88,$04,$0e      ; La pistola (color obscuro)
        db $69,$88,$00,$0f      ; La pistola (color brillante)

        ;
        ; Retardo de cinco segundos con detecci¢n de bot¢n para volver
        ; a presentaci¢n
        ;
retardo_cuadro:
        ld de,(ticks)
.0:     halt
        call boton_oprimido
        pop hl
        jp z,presentacion.0
        push hl
        ld hl,(ticks)
        sbc hl,de
        ld bc,150
        sbc hl,bc
        jr c,.0
        halt
        ret

seleccion:
        call programa_sonido_sel
        ld bc,$2000
.1:     halt
        ld a,c
        srl a
        or $90
        out (PSG),a
        or $b0
        out (PSG),a
        xor $60
        out (PSG),a
        inc c
        djnz .1
        jp psg_silencio

        ;
        ; Sonido de chicharra
        ;
tabla_psg:
        db $80,$10
        db $a0,$28
        db $cf,$3f
        db $90
        db $b0
        db $d0
        db $ff

        ;
        ; Movimiento de pistola
        ;
tabla_psg1:
        db $88,$35
        db $ac,$1a
        db $c6,$0d
        db $90
        db $b0
        db $d0
        db $ff

        ;
        ; Selecci¢n de opci¢n
        ;
tabla_psg2:
        db $86,$0d
        db $a8,$0a
        db $ce,$08
        db $90
        db $b0
        db $d0
        db $ff

        ;
        ; Tecla
        ;
tabla_psg3:
        db $86,$0d
        db $ab,$06
        db $c6,$03
        db $90
        db $b0
        db $d0
        db $ff

        ;
        ; Contrase¤a incorrecta
        ;
tabla_psg4:
        db $89,$3f
        db $ad,$1f
        db $cf,$0f
        db $90
        db $b0
        db $d0
        db $ff

        ;
        ; Programa una tabla completa de sonido
        ;
programa_sonido_sel:
        ld hl,tabla_psg2
programa_sonido:
        xor a
.950:   ld a,(hl)
        out (PSG),A
        inc hl
        ld a,(hl)
        inc a
        jr nz,.950
        ret

        ;
        ; Detecta boton oprimido (cualquiera de los dos botones de joy1/2)
        ; Devuelve bandera Z = 1 si bot¢n oprimido, 0 si no oprimido.
        ;
boton_oprimido:
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(JOY1)     ; 1
        ld b,a
        in a,(JOY2)     ; 2
        and b
        ld b,a
        out (JOYSEL),a  ; Joystick
        ex (sp),hl
        ex (sp),hl
        in a,(JOY1)     ; 1
        ld c,a
        in a,(JOY2)     ; 2
        and c
        ld c,a
        and b
        and $40         ; Separa bot¢n 1 ¢ 2 de controlador 1 ¢ 2
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
        push bc
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        pop bc
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
        ld hl,pantalla+$0000
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
        ld hl,pantalla+$0020
        ld a,l
        sub b
        ld l,a
        ; Cargado antes
;        ld de,32       
        ld c,$18
.3:     push hl
        ld a,c
        cp e    ; cp $20
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
.7:     ld (hl),a
        pop hl
        inc c
        inc hl
        djnz .3
        pop bc
.9:     pop de
        push bc
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        pop bc
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
        ; Final
        ;
toma_final:
        call limpia_sprites
        halt
        call musica_silencio
        halt
        LD HL,modo
        res 2,(hl)      ; Para que suelte el modo especial de pantalla
        set 5,(hl)      ; Para que no haga parpadeo de mosaico pantalla PC
        call PANTALLA_NEGRA
        ;
        ; Los dos jugadores deben ganar para que aparezca la secuencia
        ; del beso.
        ;
        ld a,(jug1+d_vidas)
        inc a   ; cp -1
        jr z,.0
        ld a,(jug2+d_vidas)
        inc a   ; cp -1
        jr z,.0
        call presentacion_limpia
        ld hl,retrato_delta_1           ; Retrato de Delta-1
        ld de,$08c0
        call carga_retrato
        call entrada_derecha
        ld hl,retrato_delta_2           ; Retrato de Delta-2
        ld de,$0800
        call carga_retrato
        call entrada_izquierda
        ;
        ; Secuencia de mensajes
        ;
        ld ix,secuencia_beso
        ld b,7
.6:     push bc
        call presentacion_limpia_2
        ld l,(ix+0)
        ld h,(ix+1)
        ld e,(ix+2)
        ld d,(ix+3)
        call visual_mensaje_idioma
        ld a,(ticks)
        ld b,a
.7:     halt
        ld a,(ticks)
        sub b
        cp 250
        jr c,.7
        ld bc,4
        add ix,bc
        pop bc
        djnz .6
        ;
        ; Imagen del beso
        ;
        call musica_amor
        call presentacion_limpia
        ld hl,retrato_beso1          ; Retrato beso (izq)
        ld de,$0800
        call carga_retrato
        ld hl,retrato_beso2          ; Retrato beso (der)
        ld de,$08c0
        call carga_retrato
        call entrada_doble
        ld bc,600
        call retardo
        xor a
        ld (estado),a
        call PANTALLA_NEGRA_RAPIDA

        ;
        ; Se prepara para mostrar helic¢ptero
        ;
.0:     call musica_final
        ;
        ; Carga pantalla de helic¢ptero
        ;
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
        ld hl,tabla_heroes
        ld de,sprites
        ld bc,16
        ldir
        ld a,(jug1+d_vidas)
        inc a
        jr nz,.9
        xor a
        ld (sprites+3),a
        ld (sprites+11),a
.9:     ld a,(jug2+d_vidas)
        inc a
        jr nz,.10
        xor a
        ld (sprites+7),a
        ld (sprites+15),a
.10:
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
        ld ix,sprites
        dec (ix+12)
        dec (ix+8)
        dec (ix+4)
        dec (ix+0)
        ld a,(ix+0)
        cp $78
        jr nz,.1
        ;
        ; Nuestros h‚roes entran al helic¢ptero.
        ;
        ld a,$d1
        ld (ix+0),a
        ld (ix+4),a
        ld (ix+8),a
        ld (ix+12),a
        ld hl,$0000
        ld (offset),hl
        ld hl,modo
        res 2,(hl)
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
        rrca
        jr nc,.2
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
        ;
        ; Recordar que se necesitan 4 ticks para actualizar toda la
        ; pantalla cuando bit 2 de modo est  puesto.
        ;
        HALT
        ld hl,$3800+$0147
.4:     ld a,l
        rst $08  ; WRTVRM
        inc l
        ld a,l
        cp $59
        jr nz,.4
        HALT
        HALT
        HALT
        ;
        ; Carga pantalla de final
        ;
        LD HL,GRAFICA_FIN_EN AND $FFFF
        LD B,4
        CALL CARGAR_TOMA
        ld bc,600
        call retardo
        ld hl,ganado
        ld a,(hl)
        inc a
        and $0f
        ld b,a
        ld a,(hl)
        and $f0
        or b
        ld (hl),a
        ld hl,modo
        res 5,(hl)
        jp REINICIO

        ;
        ; Un retardo con duraci¢n BC, sin interrupci¢n
        ;
retardo:
        ld de,(ticks)
.0:     halt
        ld hl,(ticks)
        or a
        sbc hl,de
        sbc hl,bc
        jr c,.0
        ret

tabla_heroes:
        db $c0,$78,$00,$07
        db $c4,$98,$04,$09
        db $b4,$78,$cc,$0a
        db $ba,$98,$dc,$0a

tabla_zombies:
        db $80,$00,$40,$03
        db $80,$e0,$50,$03
        db $90,$00,$40,$01
        db $90,$e0,$50,$01
        db $c0,$88,$70,$0b
        db $c0,$a0,$70,$0b

        ;
        ; Animaci¢n de las aspas del helic¢ptero
        ;
        ; Esto est  desaprovechado porque la pantalla se actualiza cada
        ; 4 ticks.
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
        ld hl,SLOT_2
        call sel_slot
        ld hl,tabla_aspas
        add hl,bc
        ld de,$3800+$0147
        ld c,8
        CALL LDIRVM
        ex de,hl
        ld de,$3800+$0151
        ld c,8
        CALL LDIRVM
        call sel_slot0
        pop bc
        ld a,(ticks)
        ret

        ;
        ; Limpia la zona de historia para volver a nivel
        ; Hay que restaurar gr ficas.
        ;
zona_historia:
        push ix
        push iy
        rst $28 ; zona_dura
        ld bc,$0100
        ld a,(ix+d_refx)
        or a
        jr nz,.1
        ld hl,$3800
        ld a,$ff
        call filvrm
        ld hl,letras
        ld de,$0000
        ld bc,$01a8
        call LDIRVM
        ld hl,color_letras
        ld de,$2000
        ld bc,$01a8
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$01c0
        ld bc,1600
        call LDIRVM
        ld de,$21c0
        jr .2

.1:     ld hl,$3a00
        xor a
        call filvrm
        ld hl,letras
        ld de,$1000
        ld bc,$01a8
        call LDIRVM
        ld hl,color_letras
        ld de,$3000
        ld bc,$01a8
        call LDIRVM
        ld hl,graf_bitmap
        ld de,$11c0
        ld bc,1600
        call LDIRVM
        ld de,$31c0
.2:     ld hl,graf_color
        ld bc,1600
        call LDIRVM
        call zona_facil
        pop iy
        pop ix
        ret

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
        call actualiza_indicadores_nivel
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
        ld (ix+d_paso),1
        ld (ix+d_velocidad),1
        ;
        ; Reinicia el mapa de objetos recogidos
        ;
        ld l,(ix+d_mapa)
        ld h,(ix+d_mapa+1)
        ld b,51
        ld (hl),0
        inc hl
        djnz $-3
        call musica_general
        ;
        ; Carga el nivel y actualiza indicadores
        ;
        call actualiza_indicadores_nivel
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
;        jp inicia_historia
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
        rst $28 ; zona_dura
        ld bc,384
        ld a,(ix+d_refx)
        or a
        ld hl,$3800
        ld a,$ff
        jr z,.1
        ld hl,$3980
        xor a
.1:     call FILVRM
        jp zona_facil

        ;
        ; Visualiza cuadro de historia
        ; ix = apunta a jugador
        ;
visualiza_historia:
        ld hl,tabla_historia-4
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
        ld hl,tabla_retratos-16
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
        push de
        push hl
        ld hl,modo
        set 5,(hl)      ; Para que no actualice mosaico pantallas PC
        pop hl
        call carga_retrato      ; Carga el retrato, a£n no visible
        pop de
        srl d
        rr e
        srl d
        rr e
        srl d
        rr e
        rst $28 ; zona_dura
        ld hl,$3800
        add hl,de
        ld c,8                  ; 8 l¡neas en cada retrato
.6:     ld b,8                  ; 8 columnas en cada retrato
        ld a,l
        rst $08    
        inc l
        djnz $-3
        ld a,l
        add a,24
        ld l,a
        dec c
        jr nz,.6
        call zona_facil
        ld hl,modo
        res 5,(hl)      ; Actualiza mosaico pantallas PC
        pop hl
        ld e,(hl)       ; Obtiene zona de texto
        inc hl
        ld d,(hl)
        pop hl
        ld a,(hl)       ; Obtiene ancho de texto
        and $0f
        ld b,a
        inc hl
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
.8:     inc (ix+d_estado)
        ret

.3:     dec a           ; 2 - Brincar sig. estado
        jr nz,.4
        inc (ix+d_estado)
        jr .8

.4:                     ; 3 - Volver a juego
        add a,$fc       ; 4 - Volver a juego con efecto
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
        dw retrato_delta_1,$0100+(retrato_delta_1>>16),$0080,$0200
        dw retrato_delta_2,$0000+(retrato_delta_2>>16),$1040,$1288
        dw retrato_telefonista,$0000+(retrato_telefonista>>16),$0000,$0248
        dw retrato_telefonista,$0100+(retrato_telefonista>>16),$10c0,$1240
        dw retrato_investigadora2,$0000+(retrato_investigadora2>>16),$0000,$0248
        dw retrato_investigadora3,$0100+(retrato_investigadora3>>16),$10c0,$1240
        dw retrato_jefe2a,$0000+(retrato_jefe2a>>16),$0000,$0248
        dw retrato_jefe3a,$0100+(retrato_jefe2a>>16),$10c0,$1240
        dw retrato_jefe2b,$0000+(retrato_jefe2b>>16),$0000,$0248
        dw retrato_jefe3b,$0100+(retrato_jefe2b>>16),$10c0,$1240

        ;
        ; Estados de la historia
        ;
tabla_historia:
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

        ;
        ; Secuencia del beso
        ;
secuencia_beso:
        dw $11b0,mensaje_13     ; 1. He estado pensando en t¡
        dw $1108,mensaje_14     ; 2. ¨Qu‚ tratas de decirme?
        dw $1198,mensaje_15     ; 1. Sobrevivimos.
        dw $1108,mensaje_16     ; 2. ¨Entonces?
        dw $11a8,mensaje_17     ; 1. Yo te amo
        dw $11c8,mensaje_18     ; 1. Yo...
        dw $1108,mensaje_19     ; 2. No hables

