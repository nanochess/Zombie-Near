        ;
        ; Experimento de rolado vertical
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011
        ;
        ; Creaci¢n: 09-feb-2011. Basado en ZW.ASM
        ;

        ORG $4000

        FNAME "ROLADO.ROM"


        ;
        ; En el Z80 la instrucci¢n JR es m s lenta que JP cuando se toma
        ; el salto, as¡ que he preferido usar JP, ­cada ciclo cuenta!
        ; excepto en lugares donde no importa el tiempo.
        ;


        ;
        ; Mapa de uso de slots:
        ; $4000 - C¢digo y datos, fijo
        ; $6000 - C¢digo y datos, fijo
        ; $8000 - C¢digo y datos, fijo
        ; $a000 - Intercambiado sobre la marcha para acceder imagenes
        ;         compactadas, retratos e historia.
        ;

        ;
        ; Tecnicas de portabilidad
        ; * El uso de byte $0006 para obtener puerta VDP ($98)
        ;   En todos los MSX es puerta $98
        ; * El uso de byte $002B (bit 7 = 0 = 60 hz, 1= 50 hz)
        ; * El uso de byte $002C para detectar idioma de MSX.
        ;   bits 3 - 0
        ;     6 - Teclado espa¤ol.
        ; * El uso de byte $002D para detectar tipo de MSX.
        ;   $00 - MSX1
        ;   $01 - MSX2
        ;   $02 - MSX2+
        ;   $03 - MSX Turbo-R
        ;

        DB "AB"         ; Para que el MSX reconozca el cartucho
        DW INICIO

        DB "(c)2011 Oscar Toledo Gutierrez, "
        DB "http://nanochess.110mb.com/",0

ENASLT: EQU $0024       ; Activa slot
DISSCR: EQU $0041       ; Desactiva la pantalla
ENASCR: EQU $0044       ; Activa la pantalla
WRTVDP: EQU $0047       ; Escribe un registro VDP B=Dato, C=Reg
RDVRM:  EQU $004A       ; Lee VRAM HL=Dir, A=Dato
WRTVRM: EQU $004D       ; Escribe VRAM HL=Dir, A=Dato
SETRD:  EQU $0050       ; Pone dir. VDP para leer (HL)
SETWRT: EQU $0053       ; Pone dir. VDP para escribir (HL)
FILVRM: EQU $0056       ; Rellena VRAM, HL=Dir. BC=Total A=Dato
LDIRMV: EQU $0059       ; Copia de VRAM, HL=VRAM DE=Mem BC=Tam
LDIRVM: EQU $005C       ; Copia a VRAM, HL=Mem DE=VRAM BC=Tam
WRTPSG: EQU $0093       ; Escribe PSG, A=Reg. E=Dato
GTSTCK: EQU $00D5       ; Lee joystick, A=Joystick. A=Dir.
GTTRIG: EQU $00D8       ; Lee botones, A=Cual, A=$FF oprimido
RSLREG: EQU $0138       ; Lee estatus slot en A
WSLREG: EQU $013B       ; Escribe slot con A
RDVDP:  EQU $013E       ; Lee el registro de estatus del VDP en A
SNSMAT: EQU $0141       ; Lee l¡nea A del teclado en A

        ;
        ; Selecci¢n de slot, definidos aqu¡ por si alg£n d¡a quiero cambiar
        ; el mapeador.
        ;
        ; SLOT1
        ;    $6000 - Para mapeador tipo Konami 4
        ;    $7000 - Para mapeador tipo Konami 5 con SCC
        ; SLOT2
        ;    $8000 - Para mapeador tipo Konami 4
        ;    $9000 - Para mapeador tipo Konami 5 con SCC
        ; SLOT3
        ;    $A000 - Para mapeador tipo Konami 4
        ;    $B000 - Para mapeador tipo Konami 5 con SCC
        ;
SLOT1:  EQU $6000
SLOT2:  EQU $8000
SLOT3:  EQU $A000

tabla_modo_2:
        DB $02          ; Registro 0
        DB $A2          ; Registro 1
        DB $0F          ; Registro 2 - Base pantalla $3C00
        DB $FF          ; Registro 3 - Tabla color $2000
        DB $03          ; Registro 4 - Tabla caracteres $0000
        DB $7F          ; Registro 5 - Tabla sprites $3F80
        DB $03          ; Registro 6 - Figuras sprites $1800
        DB $01          ; Registro 7 - Borde negro

        ;
        ; Todo lo que esta aqu¡ es necesario hacerlo s¢lo una vez.
        ;
inicio:
        ;
        ; Inicia la pila e intercepta vector de interrupci¢n
        ;
        di
        ld sp,pila
        ei
        ;
        ; Mapea el resto del ROM en $8000-$BFFF
        ; Esta es la forma correcta de hacerlo, ya que
        ; cada slot puede tener subslots
        ;
        call RSLREG     ; Lee slot primario
        rrca
        rrca
        and $03         ; Indica mapeado primario de $4000
        ld c,a
        ld b,0
        ld hl,$FCC1     ; EXPTBL
        add hl,bc
        ld a,(hl)
        and $80         ; Obtiene bandera de expandido
        or c
        ld c,a
        inc hl
        inc hl
        inc hl
        inc hl
        ld a,(hl)       ; SLTTBL
        and $0c         ; Obtiene mapeado secundario de $4000
        or c            ; C contiene bit 7 = Indica expandido
                        ;            bit 6 - 4 = No importa
                        ;            bit 3 - 2 = Mapeado secundario
                        ;            bit 1 - 0 = Mapeado primario
        ld h,$80        ; La direcci¢n $8000
        call ENASLT
        ;
        ; Inicia los slots del MegaROM (Konami tipo 4)
        ;
        ; Es incre¡ble pero algunos emuladores (p.ej. MSKISS) no hacen esto,
        ; tambi‚n requerido para MSX2+ y MSX Turbo-R en BlueMSX
        ;
        di
        ld a,$01
        ld (SLOT1),a
        ld a,$02
        ld (SLOT2),a
        ld a,$03
        ld (SLOT3),a
        ld a,$c3
        ld ($fd9a),a
        ld hl,vector_int
        ld ($fd9b),hl
        ;
        ; Borra todas las variables habidas y por haber
        ; $e000-$efff
        ;
        ld hl,$e000
        xor a
.2:     ld (hl),a
        inc hl
        bit 4,h
        jr z,.2
        ;
        ; Detecta ciertas cosas que garantizan un MSX de
        ; Espa¤a, Argentina o Brasil.
        ;
        ld a,($002c)
        and $0f         ; Separa tipo de teclado
        cp $06          ; ¨Teclado espa¤ol?
        jr z,.0         ; Hecho, va a espa¤ol
        dec a           ; ¨Teclado internacional?
        jr nz,.1        ; No, es otro idioma, salta.
        ; Todav¡a puede ser Argentina o Brasil
        ld a,($002b)
        and $70         ; Separa tipo de fecha
        cp $20          ; ¨Fecha DD-MM-AA (Argentina/Brasil)?
        jr nz,.1        ; No, salta.
.0:     ld a,1          ; Selecciona idioma espa¤ol.
        ld (idioma),a
.1:
        ;
        ; Ahora puede activar interrupciones
        ;
        ei
        ;
        ; Inicia el VDP
        ;
        call vdp_modo_2
        ;
        ; Introducci¢n del juego
        ;
REINICIO:
        ;
        ; Entrada al juego
        ;
        ld hl,modo
        res 0,(hl)
        ld hl,$0000
        ld bc,$1800
        xor a
        call FILVRM
        ld hl,$2000
        ld bc,$1800
        ld a,$f1
        call FILVRM
        ;
        ; Procede a inicializar la pantalla oculta
        ;
        ld hl,pantalla
        ld c,24
        ld a,23
.2:     ld b,8
        ld (hl),a
        inc hl
        djnz $-2
        ld b,16
        ld (hl),l
        inc hl
        djnz $-2
        ld b,8
        ld (hl),a
        inc hl
        djnz $-2
        dec c
        jp nz,.2
        ld hl,pantalla
        ld de,$3c00
        ld bc,$0300
        call LDIRVM
        ld hl,$0100
        ld (offset),hl
        ;
        ; Espera una actualizaci¢n del video
        ;
        halt
        ;
        ; A partir de ahora solo la rutina de interrupci¢n toca el VDP
        ;
        ld hl,modo
        set 0,(hl)      ; Controla sprites y pantalla
        ;
        ; Carga retratos para experimento
        ;
        ld hl,retrato_delta_1
        ld a,$03
        ld de,$00c0
        call carga_retrato
        ld hl,retrato_delta_2
        ld a,$03
        ld de,$0800
        call carga_retrato
        ld hl,retrato_telefonista
        ld a,$03
        ld de,$10c0
        call carga_retrato
        ld hl,retrato_jefe
        ld a,$03
        ld de,$0000
        call carga_retrato
        ld hl,retrato_investigadora
        ld a,$03
        ld de,$08c0
        call carga_retrato

        ;
        ; Bucle principal
        ;
.1:     ld de,creditos_finales
        ld c,0
jeje:   halt                    ; Actualizaci¢n, tambi‚n ahorra energ¡a.
        halt
        ld a,c
        inc c
        ld hl,$0840
        ld b,8
        exx
        ld de,letras
        exx
        or a
        jp z,pix0
        dec a
        jp z,pix1
        dec a
        jp z,pix2
        dec a
        jp z,pix3
        dec a
        jp z,pix4
        dec a
        jp z,pix5
        dec a
        jp z,pix6
        jp pix7

pix0:   push de
.1:     call linea_pix0
        inc h
        djnz .1
        pop de
        jp jeje2

pix1:   push de
.1:     call linea_pix1
        inc h
        djnz .1
        pop de
        jp jeje2

pix2:   push de
.1:     call linea_pix2
        inc h
        djnz .1
        pop de
        jp jeje2

pix3:   push de
.1:     call linea_pix3
        inc h
        djnz .1
        pop de
        jp jeje2

pix4:   push de
.1:     call linea_pix4
        inc h
        djnz .1
        pop de
        jp jeje2

pix5:   push de
.1:     call linea_pix5
        inc h
        djnz .1
        pop de
        jp jeje2

pix6:   push de
.1:     call linea_pix6
        inc h
        djnz .1
        pop de
        jp jeje2

pix7:   push de
.1:     call linea_pix7
        inc h
        djnz .1
        pop de
        ld hl,15
        add hl,de
        ex de,hl
        ld c,0
        jp jeje2

jeje2:
        ld hl,(ticks)
        ld a,l
        cp 254
        jp nc,.0
        cp 2
        jp nc,jeje
.0:     push bc
        push de
        ld d,a
        ld a,h
        dec a
        ld h,-1
.1:     inc h
        sub 5
        jp nc,.1
        add a,5
        ld hl,pantalla+24
        ld e,$18
        jp z,.2
        dec a
        ld hl,pantalla+256
        ld e,$00
        jp z,.2
        dec a
        ld hl,pantalla+536
        ld e,$18
        jp z,.2
        dec a
        ld hl,pantalla
        ld e,$00
        jp z,.2
        ld hl,pantalla+280
        ld e,$18
.2:     ld a,d
        cp 254
        jp nc,.5
        push hl
        ld c,8
.3:     ld b,8
.4:     ld (hl),e
        inc e
        inc l
        djnz .4
        ld a,e
        add a,24
        ld e,a
        ld a,l
        add a,24
        ld l,a
        dec c
        jp nz,.3
        pop hl
        jp .8

.5:     push hl
        ld e,23
        ld c,8
.6:     ld b,8
.7:     ld (hl),e
        inc l
        djnz .7
        ld a,l
        add a,24
        ld l,a
        dec c
        jp nz,.6
        pop hl
.8:     ld de,pantalla
        or a
        sbc hl,de
        ld a,h
        cp 2
        jp nz,.9
        ld hl,$0180
.9:     ld (offset),hl
        pop de
        pop bc
        jp jeje

linea_pix0:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        ld bc,$0898
        outi
        jp nz,$-2
        exx
        djnz .1
        pop hl
        pop bc
        ret

linea_pix1:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld hl,15
        add hl,de
        ld a,(hl)
        ex af,af'
        ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        ld bc,letras+1
        add hl,bc
        ld bc,$0798
        outi
        jp nz,$-2
        ex af,af'
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        outi
        exx
        djnz .1
        pop hl
        pop bc
        ret

linea_pix2:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld hl,15
        add hl,de
        ld a,(hl)
        ex af,af'
        ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        ld bc,letras+2
        add hl,bc
        ld bc,$0698
        outi
        jp nz,$-2
        ex af,af'
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        ld b,$02
        outi
        jp nz,$-2
        exx
        djnz .1
        pop hl
        pop bc
        ret

linea_pix3:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld hl,15
        add hl,de
        ld a,(hl)
        ex af,af'
        ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        ld bc,letras+3
        add hl,bc
        ld bc,$0598
        outi
        jp nz,$-2
        ex af,af'
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        ld b,$03
        outi
        jp nz,$-2
        exx
        djnz .1
        pop hl
        pop bc
        ret

linea_pix4:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld hl,15
        add hl,de
        ld a,(hl)
        ex af,af'
        ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        ld bc,letras+4
        add hl,bc
        ld bc,$0498
        outi
        jp nz,$-2
        ex af,af'
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        ld b,$04
        outi
        jp nz,$-2
        exx
        djnz .1
        pop hl
        pop bc
        ret

linea_pix5:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld hl,15
        add hl,de
        ld a,(hl)
        ex af,af'
        ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        ld bc,letras+5
        add hl,bc
        ld bc,$0398
        outi
        jp nz,$-2
        ex af,af'
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        ld b,$05
        outi
        jp nz,$-2
        exx
        djnz .1
        pop hl
        pop bc
        ret

linea_pix6:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld hl,15
        add hl,de
        ld a,(hl)
        ex af,af'
        ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        ld bc,letras+6
        add hl,bc
        ld bc,$0298
        outi
        jp nz,$-2
        ex af,af'
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        ld b,$06
        outi
        jp nz,$-2
        exx
        djnz .1
        pop hl
        pop bc
        ret

linea_pix7:
        push bc
        push hl
        call SETWRT
        ld b,15
.1:     ld hl,15
        add hl,de
        ld a,(hl)
        ex af,af'
        ld a,(de)
        inc de
        exx
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        ld bc,letras+7
        add hl,bc
        ld c,$98
        outi
        ex af,af'
        add a,a
        add a,a
        ld l,a
        ld h,0
        add hl,hl
        add hl,de
        ld b,$07
        outi
        jp nz,$-2
        exx
        djnz .1
        pop hl
        pop bc
        ret

creditos_finales:
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$1a,$0f,$0d,$02,$09,$05,$00,$0e,$05,$01,$12,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$03,$0f,$0e,$03,$05,$10,$14,$0f,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$08,$09,$13,$14,$0f,$12,$09,$01,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$10,$05,$12,$13,$0f,$0e,$01,$0a,$05,$13,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$01,$0e,$09,$0d,$01,$03,$09,$0f,$0e,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$07,$12,$01,$06,$09,$03,$01,$13,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$0e,$09,$16,$05,$0c,$05,$13,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$13,$0f,$0e,$09,$04,$0f,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$0d,$15,$13,$09,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$03,$15,$02,$09,$05,$12,$14,$01,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$0d,$01,$0e,$15,$01,$0c,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$0f,$13,$03,$01,$12,$00,$14,$0f,$0c,$05,$04,$0f,$00,$07
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $01,$19,$15,$04,$01,$00,$05,$13,$10,$05,$03,$09,$01,$0c,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$01,$04,$01,$0e,$00,$14,$0f,$0c,$05,$04,$0f,$00,$07
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $10,$12,$0f,$02,$01,$04,$0f,$12,$05,$13,$00,$02,$05,$14,$01
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$0f,$13,$03,$01,$12,$00,$14,$0f,$0c,$05,$04,$0f,$00,$07
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$01,$04,$01,$0e,$00,$14,$0f,$0c,$05,$04,$0f,$00,$07
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $03,$0f,$10,$19,$12,$09,$07,$08,$14,$00,$22,$20,$21,$21,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$0f,$13,$03,$01,$12,$00,$14,$0f,$0c,$05,$04,$0f,$00,$07
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$04,$09,$13,$10,$0f,$0e,$09,$02,$0c,$05,$00,$05,$0e,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$28,$00,$02,$09,$14,$13,$00,$0d,$0f,$0e,$0f,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

        ;
        ; Escribe un bloque tres veces en VRAM
        ;
repetir:
        ld a,3
.1:     push af
        push bc
        push hl
        push de
        call LDIRVM
        pop hl
        ld bc,$0800
        add hl,bc
        ex de,hl
        pop hl
        pop bc
        pop af
        dec a
        jp nz,.1
        ret

        ;
        ; Vector de interrupci¢n, llamado 50 o 60 veces por segundo
        ; Todos los registros son salvados por el BIOS MSX
        ;
        ; ­VITAL! - Ahorrar ciclos, cada ciclo es importante para tener
        ;           la m xima velocidad al acceder el VDP y que no ocurra
        ;           ning£n parpadeo o basura en el VRAM.
        ;
        ;           4300 microsegundos de retrazo vertical a 60 hz.
        ;
vector_int:
        ;
        ; Limpia la interrupci¢n
        ;
        call RDVDP
        ld hl,modo
        bit 7,(hl)
        ret nz
        set 7,(hl)
        ld a,(estado)
        ld e,a
        ld d,0
        ld hl,vector_dir
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        jp (hl)

vector_dir:
        dw vector_principal

        ;
        ; Solo en el modo de juego se mete con el VDP
        ;
vector_principal:
        ld hl,modo
        bit 0,(hl)      ; ¨Controlar VDP?
        jp z,vector_quieto ; No, salta a contar ticks y generar sonido

        ;
        ; Actualiza los sprites
        ;
vector_presentacion:
        ld hl,$3f80
        call SETWRT
        ld hl,sprites
        ld bc,$7098
        outi
        jp nz,$-2
        ;
        ; Actualiza la pantalla
        ;
.4:     ld hl,$3c00
        ld de,(offset)
        add hl,de
        call SETWRT
        ld hl,pantalla
        ld de,(offset)
        add hl,de
        ld bc,$8098
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
vector_quieto:
        ld hl,modo
        res 7,(hl)
        ;
        ; Subrutina que se encarga de contar ticks y generar sonido
        ;
vector_sonido:
        ld a,($002B)
        and $80         ; ¨60 hz?
        jp nz,.1        ; No, salta.
        ld hl,ciclo
        inc (hl)
        ld a,(hl)
        cp 6
        jp nz,.1
        ld (hl),0       ; Se come 1 de cada 6 ciclos
        ret

        ;
        ; Aqu¡ cree que son 50 ciclos por segundo
        ;
.1:     ; call genera_sonido
        ;
        ; Incrementa ticks transcurridos
        ;
        ld hl,(ticks)
        inc hl
        ld (ticks),hl
        ret

        ;
        ; Limpia los sprites.
        ; Los sprites se conservan buffereados en el modo 1
        ;
limpia_sprites:
        ld hl,sprites
        ld d,h
        ld e,l
        inc de
        ld bc,127
        ld (hl),$d1
        ldir
        ret

        ;
        ; Pone el modo de alta resoluci¢n
        ;
vdp_modo_2:
        LD hl,modo
        res 0,(hl)      ; No controla VDP
        res 2,(hl)      ; No define sprites
        LD HL,tabla_modo_2
        LD BC,$0800
.1:     PUSH BC
        LD B,(HL)
        CALL WRTVDP
        POP BC
        INC C
        INC HL
        DJNZ .1
        CALL limpia_sprites
        ;
        ; Limpia todo
        ; 
        LD HL,$0000
        LD BC,$1800
        XOR A
        CALL FILVRM
        LD HL,$2000
        LD BC,$1800
        XOR A
        CALL FILVRM
        LD HL,$3F80
        LD A,$D1
        LD BC,$0080
        CALL FILVRM
        ;
        ; Prepara para uso de pantalla de alta resoluci¢n
        ;
        LD HL,$3C00
        LD DE,pantalla
.2:     LD A,L
        LD (DE),A
        CALL WRTVRM
        INC DE
        INC HL
        LD A,H
        CP $3F
        JP NZ,.2
        LD BC,$E201     ; Activa el video
        CALL WRTVDP
        RET

        ;
        ; Carga un retrato
        ;
carga_retrato:
        ld (SLOT3),a    ; Banco del ROM con los retratos
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
        ; Las fantabulosas letras
        ; Incluye algunos gr ficos fantastirigillos
        ;
letras:
        db $00,$00,$00,$00,$00,$00,$00,$00      ; $00 Espacio
        db $38,$6c,$c6,$c6,$fe,$c6,$c6,$00      ; $01 A
        db $fc,$c6,$c6,$fc,$c6,$c6,$fc,$00      ; $02 B
        db $3c,$66,$c0,$c0,$c0,$66,$3c,$00      ; $03 C
        db $f8,$cc,$c6,$c6,$c6,$cc,$f8,$00      ; $04 D
        db $FE,$C0,$C0,$FC,$C0,$C0,$FE,$00      ; $05 E
        db $FE,$C0,$C0,$FC,$C0,$C0,$C0,$00      ; $06 F
        db $3C,$66,$C0,$CE,$C6,$66,$3C,$00      ; $07 G
        db $c6,$c6,$c6,$fe,$c6,$c6,$c6,$00      ; $08 H
        db $78,$30,$30,$30,$30,$30,$78,$00      ; $09 I
        db $06,$06,$06,$06,$c6,$c6,$7c,$00      ; $0A J
        db $c6,$c6,$cc,$f8,$cc,$c6,$c6,$00      ; $0B K
        db $C0,$C0,$C0,$C0,$C0,$C0,$FE,$00      ; $0C L
        db $c6,$ee,$fe,$d6,$d6,$c6,$c6,$00      ; $0D M
        db $C6,$e6,$f6,$DE,$CE,$C6,$C6,$00      ; $0E N
        db $38,$6c,$C6,$C6,$C6,$6c,$38,$00      ; $0F O
        db $Fc,$C6,$C6,$fc,$c0,$C0,$C0,$00      ; $10 P
        db $38,$6c,$c6,$c6,$c6,$6c,$36,$03      ; $11 Q
        db $Fc,$C6,$C6,$fC,$d8,$Cc,$C6,$00      ; $12 R
        db $7c,$c6,$c0,$7c,$06,$c6,$7c,$00      ; $13 S
        db $fc,$30,$30,$30,$30,$30,$30,$00      ; $14 T
        db $C6,$C6,$C6,$C6,$C6,$c6,$7c,$00      ; $15 U
        db $c6,$c6,$c6,$6c,$6c,$38,$10,$00      ; $16 V
        db $c6,$c6,$c6,$d6,$fe,$fe,$6c,$00      ; $17 W
        db $c6,$c6,$6c,$38,$6c,$c6,$c6,$00      ; $18 X
        db $C6,$C6,$6C,$38,$30,$30,$30,$00      ; $19 Y
        db $fe,$0c,$18,$30,$60,$c0,$fe,$00      ; $1A Z
        db $ff,$c0,$c0,$c0,$c0,$c0,$c0,$ff      ; $1B Energ¡a llena (izq)
        db $ff,$c0,$c0,$c0,$c0,$c0,$c0,$ff      ; $1C Energ¡a vacia (izq)
        db $ff,$00,$00,$00,$00,$00,$00,$ff      ; $1D Energ¡a llena (medio)
        db $ff,$00,$00,$00,$00,$00,$00,$ff      ; $1E Energ¡a vacia (medio)
        db $c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0      ; $1F Energ¡a (der)
        db $7c,$c6,$ce,$DE,$f6,$e6,$7c,$00      ; $20 0
        db $30,$70,$30,$30,$30,$30,$78,$00      ; $21 1
        db $7C,$C6,$06,$3c,$60,$C0,$FE,$00      ; $22 2
        db $7C,$C6,$0c,$38,$0c,$C6,$7C,$00      ; $23 3
        db $1E,$36,$66,$c6,$fe,$06,$06,$00      ; $24 4
        db $FE,$C0,$C0,$Fc,$06,$0c,$F8,$00      ; $25 5
        db $3E,$60,$c0,$fc,$C6,$c6,$7c,$00      ; $26 6
        db $FE,$06,$0C,$18,$30,$30,$30,$00      ; $27 7
        db $7C,$C6,$c6,$7c,$c6,$C6,$7C,$00      ; $28 8
        db $7c,$c6,$C6,$7e,$06,$0c,$78,$00      ; $29 9
        db $00,$6C,$fe,$fe,$7c,$38,$10,$00      ; $2A Coraz¢n
        db $30,$70,$30,$30,$30,$30,$78,$00      ; $2B 1 (para 1UP)
        db $7C,$C6,$06,$3c,$60,$C0,$FE,$00      ; $2C 2 (para 2UP)
        db $3c,$30,$3c,$30,$78,$CC,$CC,$78      ; $2D Llave
        db $18,$3c,$3c,$3c,$18,$00,$18,$18      ; $2E !
        db $7C,$C6,$0C,$18,$18,$00,$18,$18      ; $2F ?
        db $0C,$18,$30,$00,$00,$00,$00,$00      ; $30 '
        db $c0,$cc,$18,$30,$60,$cc,$0c,$00      ; $31 %
        db $38,$6c,$c6,$c6,$fe,$c6,$c6,$00      ; $32 A (para piso)
        db $fc,$c6,$c6,$fc,$c6,$c6,$fc,$00      ; $33 B (para piso)
        db $00,$00,$00,$fc,$00,$00,$00,$00      ; $34 -
        db $30,$30,$00,$30,$30,$60,$c6,$7c      ; $35 ¨
        db $FE,$00,$C6,$e6,$de,$Ce,$C6,$00      ; $36 ¥
        db $18,$18,$00,$18,$3c,$3c,$3c,$18      ; $37 ­

        ;
        ; El color de las fantabulosas letras, usado exclusivamente para
        ; los indicadores.
        ;
        ; Para la historia se usan otros colores.
        ;
color_letras:
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $00
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $01
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $02
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $03
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $04
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $05
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $06
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $07
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $08
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $09
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0A
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0B
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0C
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0D
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0E
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $0F
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $10
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $11
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $12
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $13
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $14
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $15
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $16
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $17
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $18
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $19
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $1A
        db $f8,$f8,$f9,$f9,$f8,$f8,$f6,$f8      ; $1b
        db $f4,$f4,$f5,$f5,$f4,$f4,$f1,$f4      ; $1c
        db $f8,$f8,$f9,$f9,$f8,$f8,$f6,$f8      ; $1d
        db $f4,$f4,$f5,$f5,$f4,$f4,$f1,$f4      ; $1e
        db $f1,$f1,$f1,$f1,$f1,$f1,$f1,$f1      ; $1f
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $20
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $21
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $22
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $23
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $24
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $25
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $26
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $27
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $28
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $29
        db $11,$91,$81,$81,$81,$81,$61,$11      ; $2A
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2B
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2C
        db $b1,$b1,$b1,$b1,$a1,$a1,$a1,$a1      ; $2D
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2E
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $2F
        db $31,$31,$21,$31,$31,$21,$21,$21      ; $30
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $31
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $32
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $33
        db $f1,$f1,$f1,$f1,$f1,$e1,$e1,$e1      ; $34
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $35
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $36
        db $31,$31,$31,$31,$31,$21,$21,$21      ; $37

        db "What are you looking for? :)",0

        DS $A000-$,255      ; Rellena a 24K

        ; Comienza retrato investigadora
retrato_investigadora:
        incbin "retrato1.dat"

        ; Comienza retrato jefe
retrato_jefe:
        incbin "retrato2.dat"

        ; Comienza retrato telefonista
retrato_telefonista:
        incbin "retrato3.dat"

        ; Comienza retrato Delta 1
retrato_delta_1:
        incbin "retrato4.dat"

        ; Comienza retrato Delta 2
retrato_delta_2:
        incbin "retrato5.dat"

        ; Comienza retrato zombies (lado izq.)
retrato_zombies_1:
        incbin "retrato6.dat"

        ; Comienza retrato zombies (lado der.)
retrato_zombies_2:
        incbin "retrato7.dat"

        ;
        ; La investigadora platicando con jugador 1
        ;
retrato_investigadora2:
        incbin "retrato8.dat"

        ;
        ; El jefe platicando con jugador 1
        ;
retrato_jefe2a:
        incbin "retrato9.dat"

        ;
        ; El jefe malvado platicando con jugador 1
        ;
retrato_jefe2b:
        incbin "retrato10.dat"

        ;
        ; La investigadora platicando con jugador 2
        ;
retrato_investigadora3:
        incbin "retrato11.dat"

        ;
        ; El jefe platicando con jugador 2
        ;
retrato_jefe3a:
        incbin "retrato12.dat"

        ;
        ; El jefe malvado platicando con jugador 2
        ;
retrato_jefe3b:
        incbin "retrato13.dat"

        FORG $20000
        ORG $E000

pantalla:
        RB 768
sprites:
        RB 128
sprites_especiales:
        RB 16   ; Offset de sprites redefinidos.
                ; Actualmente +0 = Sprite jugador 1
                ;             +2 = Sprite jugador 2
                ;             +4 = Sprite jefe 1
                ;             +6 = Sprite jefe 2

        ;
        ; Variables usadas por el n£cleo
        ;
ticks:  RB 2
ciclo:  RB 1
L_OFFSET2: RB 2
L_PAGINA2: RB 1
L_OFFSET: RB 2
L_LINEA:  RB 2
L_PAGINA: RB 1

        ;
        ; Modo del vector de interrupci¢n.
        ; bit 0 = 1 = Controlar pantalla y sprites
        ;     1 = 1 = En pausa, quitar sonido.
        ;     2 = 1 = Redefinir sprites h‚roes (usado durante juego)
        ;     3 = 1 = No usar sonido (para la chicharra de presentaci¢n)
        ;     4 = 1 = Sonido desactivado
        ;     7 = 1 = Dentro de interrupci¢n.
        ;
modo:   RB 1
estado: RB 1
csprit: RB 1    ; Corrimiento sprites
offset: RB 2    ; Offset actualizaci¢n video
tecla:  RB 1    ; Tecla oprimida con antirebote
tecla2: RB 1    ; Tecla oprimida 
conteo: RB 1    ; Conteo antirebote
truco:  RB 1    ; Estado de truco
matriz: RB 8    ; Matriz del teclado
depura: RB 1    ; Llave para activar trucos

idioma:         RB 1    ; Idioma (0=Ingl‚s, 1=Espa¤ol)

        ORG $F0F0
PILA:   

