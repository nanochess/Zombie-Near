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
        ; Revisi¢n: 21-jun-2012. Se elimina rutina de checksum.
        ; Revisi¢n: 22-jun-2012. Se integra pantalla alterna de t¡tulo para
        ;                        cuando se gana el juego. Adaptado para
        ;                        teclado de Tatung Einstein.
        ; Revisi¢n: 26-jun-2012. Ajustes para Tatung Einstein.
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
        xor a           
        ld (modo),a
        call espera_int
        CALL PANTALLA_NEGRA
        ;
        ; El HALT sincroniza para evitar NMI al escribir registro VDP
        ;
        call espera_int
        LD BC,$A201     ; Desactiva el video
        CALL WRTVDP
        ;
        ; Carga pantalla de t¡tulo
        ;
        ; Presentaci¢n compactada (son 12288 bytes si no se compacta)
        ;
        ld a,(ganado)
        rrca
        LD HL,logo_1    ; Bitmap
        jr nc,$+5
        LD HL,logo_21   ; Bitmap
        LD DE,$0000
        CALL unpack
        ld a,(ganado)
        rrca
        LD HL,logo_2    ; Color
        jr nc,$+5
        LD HL,logo_22   ; Bitmap
        LD DE,$2000
        CALL unpack
        ;
        ; Vuelve a definir sprite pistola en sprites h‚roes
        ; y restaura dos sprites que pueden ser borrados por historia
        ;
        LD HL,figuras_sprites
        LD DE,$1800
        CALL unpack
        ld a,(ganado)
        rrca
        jr nc,.557
        call zona_dura
        LD HL,sprites_heroes+$90*8
        LD DE,$1800
        LD BC,$0040
        CALL LDIRVM
        call zona_facil
.557:

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
        ld de,record
        call dos_digitos2
        call dos_digitos2
        call dos_digitos2
        ld (hl),$20
        ld a,(quien)
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
    if MEMOTECH=1
        call espera_int
    endif
        LD BC,$E201     ; Activa el video
        CALL WRTVDP
        ld hl,modo
        set 0,(hl)      ; Controla sprites y pantalla
        ld hl,sprite_pistola
        ld de,sprites
        ld bc,8
        ldir
.906:
        ld de,(ticks)
.1:     call espera_int
        call parpadeo_pistola
        ret z                   ; Retorna
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
        jr c,.1
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
        ld de,(ticks)
.904:   call parpadeo_pistola
        ret z                   ; Retorna
        or a
        sbc hl,de
        ld bc,18
        sbc hl,bc
        jr c,.904
        jr .906

        ;
        ; Minihistoria
        ;
.907:   call limpia_sprites
        call pantalla_negra
        call musica_historia
        ld hl,$0040
        ld de,mensaje_21
        ld c,$e1
        call visual_mensaje1
        ld hl,$0300
        ld de,mensaje_22
        ld c,$a1
        call visual_mensaje1
        ld de,(ticks)
.908:   call espera_int
        call boton_oprimido     ; ¨Se oprimi¢ alg£n bot¢n?
        jp z,.0
        ld hl,(ticks)
        or a
        sbc hl,de
        ld bc,1200              ; ¨24 segundos?
        sbc hl,bc
        jr c,.908

.909:   call pantalla_negra
        call espera_int
        ld ix,historia_retratos
.911:   call carga_dato
        ld a,h
        or l
        jr z,.910
        call carga_retrato
        call carga_dato
        call retardo_cuadro
        jr .911

.910:   call retardo_cuadro2
        call retardo_cuadro2
        call retardo_cuadro2
        jp .0

carga_dato:
        ld l,(ix+0)
        ld h,(ix+1)
        ld e,(ix+2)
        ld d,(ix+3)
        ld bc,4
        add ix,bc
        ret

parpadeo_pistola:
        call espera_int
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

historia_retratos:
        dw retrato_investigadora2,$0000,$0148,mensaje_23
        dw retrato_jefe2a,$00c0,$0478,mensaje_24
        dw retrato_telefonista,$0860,$0ba8,mensaje_25
        dw retrato_delta_1,$10c0,$1380,mensaje_26
        dw retrato_delta_2,$1000,$1648,mensaje_27
        dw 0

        ;
        ; Retardo de cinco segundos con detecci¢n de bot¢n para volver
        ; a presentaci¢n
        ;
retardo_cuadro:
        ld c,$21
        call visual_mensaje1
retardo_cuadro2:
        ld de,(ticks)
.0:     call espera_int
        call boton_oprimido
        pop hl
        jp z,presentacion.0
        push hl
        ld hl,(ticks)
        sbc hl,de
        ld bc,250
        sbc hl,bc
        jr c,.0
        call espera_int
        ret

        ;
        ; Detecta boton oprimido (barra de espacio)
        ; Devuelve bandera Z = 1 si bot¢n oprimido, 0 si no oprimido.
        ;
boton_oprimido:
        ld c,$ff
    if MEMOTECH=1
        ld a,$fb
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(KEY1)     ; Lee para tener tecla
        bit 7,a
        jr nz,$+4
        res 0,c         ; Arriba
        ld a,$bf
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(KEY1)     ; Lee para tener tecla
        bit 7,a
        jr nz,$+4
        res 2,c         ; Abajo
        ld a,$df
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(KEY1)     ; Lee para tener tecla
        bit 7,a
        jr nz,$+4
        res 6,c         ; Disparo
        ld a,$fb
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(KEY1)     ; Lee para tener tecla
        bit 1,a
        jr nz,$+4
        res 0,c         ; Arriba
        ld a,$ef
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(KEY1)     ; Lee para tener tecla
        bit 1,a         ; S
        jr nz,$+4
        res 2,c         ; Abajo
        ld a,$fb
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(KEY2)     ; Lee para tener tecla
        bit 0,a         ; Tab
        jr nz,$+4
        res 6,c         ; Disparo
    else
        ld a,$0e
        out (PSG+0),a  ; Teclado
        ld a,$f7
        out (PSG+1),a
        ex (sp),hl
        ex (sp),hl
        ld a,$0f
        out (PSG+0),a  ; Teclado
        in a,(PSG)
        bit 6,a
        jr nz,$+4
        res 0,c         ; Arriba
        ld a,$0e
        out (PSG+0),a  ; Teclado
        ld a,$fd
        out (PSG+1),a
        ex (sp),hl
        ex (sp),hl
        ld a,$0f
        out (PSG+0),a  ; Teclado
        in a,(PSG)
        bit 5,a
        jr nz,$+4
        res 2,c         ; Abajo
        ld a,$0e
        out (PSG+0),a  ; Teclado
        ld a,$fe
        out (PSG+1),a
        ex (sp),hl
        ex (sp),hl
        ld a,$0f
        out (PSG+0),a  ; Teclado
        in a,(PSG)
        bit 6,a
        jr nz,$+4
        res 6,c         ; Disparo
        ld a,$0e
        out (PSG+0),a  ; Teclado
        ld a,$f7
        out (PSG+1),a
        ex (sp),hl
        ex (sp),hl
        ld a,$0f
        out (PSG+0),a  ; Teclado
        in a,(PSG)
        bit 6,a
        jr nz,$+4
        res 0,c         ; Arriba
        ld a,$0e
        out (PSG+0),a  ; Teclado
        ld a,$bf
        out (PSG+1),a
        ex (sp),hl
        ex (sp),hl
        ld a,$0f
        out (PSG+0),a  ; Teclado
        in a,(PSG)
        bit 5,a         ; S
        jr nz,$+4
        res 2,c         ; Abajo
        ld a,$0e
        out (PSG+0),a  ; Teclado
        ld a,$fb
        out (PSG+1),a
        ex (sp),hl
        ex (sp),hl
        ld a,$0f
        out (PSG+0),a  ; Teclado
        in a,(PSG)
        bit 5,a         ; Tab
        jr nz,$+4
        res 6,c         ; Disparo
    endif
        ld a,c
        and $40
        ret

        ;
        ; Final
        ;
toma_final:
        call limpia_sprites
        call espera_int
        call musica_silencio
        call espera_int
        LD HL,modo
        res 2,(hl)      ; Para que suelte el modo especial de pantalla
        set 5,(hl)      ; Para que no haga parpadeo de mosaico pantalla PC
        call PANTALLA_NEGRA
        ;
        ; El HALT sincroniza para evitar NMI al escribir registro VDP
        ;
        call espera_int
        LD BC,$A201     ; Desactiva el video
        CALL WRTVDP
        ;
        ; Carga pantalla de fin
        ;
        LD HL,fin_1    ; Bitmap
        LD DE,$0000
        CALL unpack
        LD HL,fin_2    ; Color
        LD DE,$2000
        CALL unpack
    if MEMOTECH=1
        call espera_int
    endif
        LD BC,$E201     ; Activa el video
        CALL WRTVDP
        call musica_final
        ld bc,600
        call retardo
        ld hl,ganado
        inc (hl)
        ld hl,modo
        res 5,(hl)
        jp REINICIO

        ;
        ; Un retardo con duraci¢n BC, sin interrupci¢n
        ;
retardo:
        ld de,(ticks)
.0:     call espera_int
        ld hl,(ticks)
        or a
        sbc hl,de
        sbc hl,bc
        jr c,.0
        ret

        ;
        ; Limpia la zona de historia para volver a nivel
        ; Hay que restaurar gr ficas.
        ;
zona_historia:
        push ix
        push iy
        call zona_dura
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
        call zona_facil
        ld hl,color_letras
        ld de,$2000
        call unpack
        ld hl,graf_bitmap
        ld de,$01c0
        call unpack
        ld de,$21c0
        jr .2

.1:     ld hl,$3a00
        xor a
        call filvrm
        ld hl,letras
        ld de,$1000
        ld bc,$01a8
        call LDIRVM
        call zona_facil
        ld hl,color_letras
        ld de,$3000
        call unpack
        ld hl,graf_bitmap
        ld de,$11c0
        call unpack
        ld de,$31c0
.2:     ld hl,graf_color
        call unpack
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
        ld (ix+d_paso),2
        ld (ix+d_velocidad),2
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
        call zona_dura
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
        call zona_dura
        ld hl,$3800
        add hl,de
        ld c,8                  ; 8 l¡neas en cada retrato
.6:     ld b,8                  ; 8 columnas en cada retrato
        ld a,l
        call WRTVRM
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
        dw retrato_investigadora2,$0100+(retrato_investigadora2>>16),$10c0,$1240
        dw retrato_jefe2a,$0000+(retrato_jefe2a>>16),$0000,$0248
        dw retrato_jefe2a,$0100+(retrato_jefe2a>>16),$10c0,$1240
        dw retrato_jefe2b,$0000+(retrato_jefe2b>>16),$0000,$0248
        dw retrato_jefe2b,$0100+(retrato_jefe2b>>16),$10c0,$1240

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
