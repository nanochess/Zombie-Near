        ;
        ; Zombie Near (antes Zombie Labs (antes Zombie Wars))
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011-2013
        ;
        ; Creaci¢n: 06-ene-2011.
        ; Revisi¢n: 21-abr-2011. Comienza reducci¢n a 32K para Colecovision.
        ; Revisi¢n: 23-abr-2011. Finaliza la reducci¢n. Operativo
        ;                        Correcci¢n de un error al poner esqueleto de
        ;                        jugador, pod¡a salirse de la tabla de
        ;                        monigotes si mor¡a suficientes veces.
        ; Revisi¢n: 25-abr-2011. Correcci¢n en manejo movimiento, si se
        ;                        oprim¡an dos botones de direcciones entonces
        ;                        el jugador iba el doble de r pido.
        ; Revisi¢n: 26-abr-2011. Correcci¢n en el c¢digo de zona_facil, pod¡a
        ;                        recibir un NMI enmedio del manejo de NMI
        ;                        atrasado. Se agrega logo de distribuidor.
        ; Revisi¢n: 28-abr-2011. Ajustes en tiempos VDP, es mejor un poco de
        ;                        lentitud que estar al borde de una falla.
        ;                        Correcci¢n de un fallo al arrancar el bucle
        ;                        de juego, no llamaba zona_dura/facil al
        ;                        limpiar la pantalla.
        ; Revisi¢n: 03-may-2011. Nuevo RST $30 para mostrar mensaje.
        ; Revisi¢n: 05-may-2011. Simplifica y vencer s, rutina pletter ahora
        ;                        usa RDVRM que incrementa su retardo. Detecta
        ;                        Coleco de 50 hz. Optimizaci¢n al leer
        ;                        joysticks y usa puertas "est ndar".
        ; Revisi¢n: 09-may-2011. La tabla caminable se reduce de 100 bytes a
        ;                        25 bytes.
        ; Revisi¢n: 11-may-2011. Se eliminan algunas variables sin usar. Se
        ;                        usa RST $20 para lee_bit y $28 p/zona_dura.
        ;                        Rellena tabla de sprites con $D0, as¡ evita
        ;                        proceso por parte del VDP de los £ltimos 4
        ;                        sprites.
        ; Revisi¢n: 12-may-2011. Se reduce el c¢digo que arma la tabla de
        ;                        sprites, dibuja_mosaico, maneja_entrada,
        ;                        disparo, maneja_dir, mueve_monstruos y
        ;                        otras optimizaciones menores. Se integra
        ;                        pantalla "THE END". Se modifica la
        ;                        descompactaci¢n de diccionario 8 para el
        ;                        nuevo m‚todo. Se comprimen los pisos de
        ;                        referencia para el descompactador.
        ; Revisi¢n: 13-may-2011. Se agrega retardo despu‚s de selecci¢n de
        ;                        controlador, por si las moscas.
        ; Revisi¢n: 14-may-2011. C¢digo de depuraci¢n para explorar mapas. Se
        ;                        elimina uno de los tres m‚todos para
        ;                        descompactar niveles, ya no hace falta.
        ; Revisi¢n: 17-may-2011. Se elimina uno de los tres m‚todos para
        ;                        descompactar niveles, ya no hace falta. Se
        ;                        reubica video $3c00 en $3800 (VDP) y tabla
        ;                        de sprites en $3b00, esto deja un espacio
        ;                        libre en VRAM desde $3b80 hasta $3fff (1152
        ;                        bytes) que es usado para contener la m£sica
        ;                        descompactada (ahora compactada en ROM).
        ;                        Nueva variable ef_rp.
        ; Revisi¢n: 27-jun-2011. Modificado para Megacart, se incorpora de
        ;                        nuevo el mapa 4.
        ; Revisi¢n: 28-jun-2011. Se vuelve a integrar c¢digo para escritura
        ;                        de pantalla y descompactaci¢n de imagenes
        ;                        de persiana y de apertura. Se ponen de
        ;                        nuevo todos los cuadros de animaci¢n de los
        ;                        jefes. Se descompactan las gr ficas, ya no
        ;                        hace falta Pletter.
        ; Revisi¢n: 29-jun-2011. Se integran 28 cuadros de video para prueba.
        ;                        Permite hacer pausa con la tecla de n£mero y
        ;                        permite quitar el sonido con la tecla de
        ;                        asterisco. Se integran de nuevo los trucos
        ;                        de depuraci¢n.
        ; Revisi¢n: 04-jul-2011. El logo de distribuidor ahora mide 128x16.
        ;                        Se integra sonido PCM de prueba.
        ; Revisi¢n: 05-jul-2011. Nueva rutina descompacta_rle_imagen2 para
        ;                        archivos compactados con bitmap y color
        ;                        alternados.
        ; Revisi¢n: 18-mar-2013. Se elimina el video y rutinas para sonido
        ;                        PCM. Se corrige un defecto al visualizar
        ;                        letra para historia, depend¡a de la
        ;                        repetici¢n de 1K de memoria RAM.
        ; Revisi¢n: 26-jun-2013. Se modifica el acceso a slots para permitir
        ;                        que la m£sica est‚ en otro slot.
        ; Revisi¢n: 27-jun-2013. La variable depura se combina con ganado.
        ;                        Para los jefes de los mapas 2 a 4 se pone
        ;                        una m£sica diferente. Los cient¡ficos se
        ;                        hacen blancos y las cient¡ficas se hacen
        ;                        amarillas.
        ; Revisi¢n: 01-jul-2013. Se agrega c¢digo en visual_linea para que
        ;                        derive un digito de la clave seg—n los
        ;                        jugadores vivos.
        ; Revisi¢n: 02-jul-2013. Un n£mero seudoaleatorio controla la
        ;                        posici¢n de las llaves, por cada mapa pueden
        ;                        cambiar de posici¢n dos llaves (cada llave
        ;                        puede estar en una de dos habitaciones). Se
        ;                        soluciona un defecto en lee_bit que
        ;                        ocasionaba basura en escenarios en casos
        ;                        especiales.
        ; Revisi¢n: 03-jul-2013. Hice que los dos jugadores se desplacen m s
        ;                        r pido ya que hay mayor necesidad de
        ;                        exploraci¢n. Al oprimir la tecla "1" se
        ;                        viste a los jugadores de negro :)
        ; Revisi¢n: 05-jul-2013. Correcci¢n cuando muere jugador, repon¡a con
        ;                        velocidad lenta. Se acelera velocidad del
        ;                        l ser.
        ;

        FNAME "zombnear.rom"

        ;
        ; Defina esto para activar soporte para el Opcode Super Game Module
        ;
SGM:            EQU 1

        ;
        ; Defina esto para activar trucos de depuraci¢n
        ;
PROGRAMADOR:    EQU 1

        ;
        ; En el Z80 la instrucci¢n JR es m s lenta que JP cuando se toma
        ; el salto, as¡ que he preferido usar JP, ­cada ciclo cuenta!
        ; excepto en lugares donde no importa el tiempo.
        ;

        ;
        ; Mapa de uso del ROM:
        ; $8000-$BFFF - Programa principal.
        ; $C000-$FFFF - Intercambio para acceder m s datos
        ;
        ; Total libre: 0 bytes de 32K (0%)
        ;              

        ;
        ; Las direcciones de lectura $FFC0-$FFFF mapean una nueva zona de
        ; 16 KB en $C000-$FFFF.
        ;
        ; La zona $8000-$BFFF est  fija a la p gina de 16 KB m s alta.
        ; La zona $C000-$FFFF inicia en el slot 0.
        ;
SLOT_0: EQU $FFC0
SLOT_1: EQU $FFC1
SLOT_2: EQU $FFC2
SLOT_3: EQU $FFC3
SLOT_4: EQU $FFC4
SLOT_5: EQU $FFC5
SLOT_6: EQU $FFC6
SLOT_7: EQU $FFC7

        ORG $8000,$BFFF
        FORG $1c000     ; SLOT_7

        DB $55,$AA      ; Reconoce cartucho y entra inmediato
;        DB $AA,$55      ; Reconoce cartucho y muestra pantalla Coleco
        DW 0            ; Apuntador a datos de sprites
        DW 0            ; Apuntador a indices de sprites
;        DW 0            ; Apuntador a espacio temporal en RAM
;        DW 0            ; Apuntador a joysticks

colores_pantalla_pc:
        db $fc
        db $f2
        db $f3
        db $f2

        DW INICIO       ; Direcci¢n de inicio del cartucho ROM

        JP wrtvrm       ; RST 08
        JP setwrt       ; RST 10
        JP vdp_copia_bloque     ; RST 18
        JP lee_bit      ; RST 20
        JP zona_dura    ; RST 28
        JP mensajito    ; RST 30
        JP checa_camino ; RST 38

        JP vector_nmi   ; NMI

        DB $1D," 2011 OSCAR TOLEDO G."
        DB "/"
        DB "ZOMBIE NEAR"
        DB "/"
        DB "1983"

tabla_monigotes:
        dw zombie5_izq  ; 69 Zombie 5 izq.
        dw zombie5_der  ; 70 Zombie 5 der.
        dw pascua       ; 71 Adorno gen‚rico
        dw jefe         ; 72 Jefe esperando
        dw chica        ; 73 Chica esperando
        dw entrada3     ; 74 Entrada jefe (norte)
        dw zombie4      ; 75 Zombie 4
        dw zombie1_aba  ; 76 Zombie 1 abajo
        dw zombie1_arr  ; 77 Zombie 1 arriba
        dw vida         ; 78 Vida
        dw entrada2     ; 79 Entrada jefe (sur)
        dw zombie3_izq  ; 80 Zombie 3 izq.
        dw zombie3_der  ; 81 Zombie 3 der.
        dw zombie3_arr  ; 82 Zombie 3 arriba
        dw zombie3_aba  ; 83 Zombie 3 abajo
        dw llave        ; 84 Llave del laboratorio
        dw cientifico   ; 85 Cient¡fico
        dw cientifica   ; 86 Cient¡fica (mismo sprite p/caber, color dif.)
        dw mancha       ; 87 Una manchita de sangre
        dw esqueleto    ; 88 Medio esqueletito
        dw mano_suelta  ; 89 Una manita suelta
        dw zombie1_izq  ; 90 Zombie 1 izq.
        dw zombie1_der  ; 91 Zombie 1 der.
        dw zombie2_izq  ; 92 Zombie 2 izq.
        dw zombie2_der  ; 93 Zombie 2 der.
        dw zombie2_arr  ; 94 Zombie 2 arriba
        dw zombie2_aba  ; 95 Zombie 2 abajo
        dw entrada1     ; 96 Entrada jefe (oeste)
;       dw nada         ; 97 Puerta con llave
;       dw nada         ; 98 Conexi¢n con otro piso
;       dw nada         ; 99 Sin uso

mueve_monstruos.15:
        dw mueve_monstruos.4           ; 1- Zombie tipo 1
        dw mueve_monstruos.8           ; 2- Zombie tipo 2
        dw mueve_monstruos.12          ; 3- Zombie tipo 3
        dw mueve_monstruos.17          ; 4- Zombie jefe
        dw mueve_monstruos.2           ; 5- Adorno, ignora
        dw mueve_monstruos.9           ; 6- Cient¡fico/a
        dw mueve_monstruos.22          ; 7- Llave
        dw mueve_monstruos.13          ; 8- Bala
        dw mueve_monstruos.16          ; 9- Bala en explosi¢n.
        dw mueve_monstruos.14          ; 10- Explosi¢n monstruo.
        dw mueve_monstruos.20          ; 11- Vida
        dw mueve_monstruos.25          ; 12- Transformaci¢n.
        dw mueve_monstruos.26          ; 13- Explosi¢n.
        dw mueve_monstruos.28          ; 14- Zombie/llave cayendo.
        dw mueve_monstruos.30          ; 15- L ser (inicial)
        dw mueve_monstruos.36          ; 16- L ser (disparo)
        dw mueve_monstruos.42          ; 17- Gatito

        ;
        ; Tabla para parpadeo de pantallas de computadora
        ;
dir_pantalla_pc:
        dw $224a
        dw $224b
        dw $2a4a
        dw $2a4b
        dw $324a
        dw $324b
        dw $324a
        dw $324b

vector_dir:
        dw vector_principal
        dw vector_cortina
        dw vector_persiana
        dw vector_borde
        dw vector_historia 

VDP:    equ $BE         ; Puerta del VDP
KEYSEL: equ $80         ; Selecci¢n del teclado
JOYSEL: equ $C0         ; Selecci¢n del joystick
JOY1:   equ $FC         ; Joystick 1
JOY2:   equ $FF         ; Joystick 2
PSG:    equ $FF         ; Chip de sonido
PSG2:   equ $50         ; Chip de sonido secundario (SGM)
                        ; Se puede definir a $60 para experimentar con
                        ; BlueMSX, activando el Opcode PSG en Machine Editor.

        ;
        ; Selecciona un slot
        ;
sel_slot0:
        ld hl,SLOT_0
sel_slot:
        ld (slot_actual),hl
        ld h,(hl)
        ret

        ;
        ; Escribe un registro del VDP
        ; C = Registro (0-7)
        ; B = Valor
        ;
WRTVDP:
        ld a,b
        out (VDP+1),a
        ld a,c
        or $80
        out (VDP+1),a
        ret

        ;
        ; Lee la VRAM
        ; HL = Direcci¢n (0000-3FFF)
        ; Devuelve en A el byte contenido
        ;
RDVRM:  ld a,l
        out (VDP+1),a
        ld a,h
        and $3f
        out (VDP+1),a
        push af         ; 11
        pop af          ; 10
        ex (sp),hl      ; 19
        ex (sp),hl      ; 19 = 59
        in a,(VDP)
        ret

        ;
        ; Escribe la VRAM
        ; HL = Direcci¢n (0000-3FFF)
        ; A = Byte
        ;
WRTVRM: push af
        rst $10         ; 10 del RET
        ex (sp),hl      ; 19
        ex (sp),hl      ; 19
        pop af          ; 10 = 59
        out (VDP),a
        ret             

        ;
        ; Pone la direcci¢n de escritura para el VRAM
        ; HL = Direcci¢n (0000-3FFF)
        ;
SETWRT:
        ld a,l
        out (VDP+1),a
        ld a,h
        or $40
        out (VDP+1),a
        ret

        ;
        ; Rellena una secci¢n de VRAM con un byte
        ; HL = Direcci¢n (0000-3FFF)
        ; BC = Total de bytes
        ; A = Byte a replicar
        ;
FILVRM:
        PUSH AF
        rst $10         ; 10 del RET
.1:     POP AF          ; 10 
        OUT (VDP),A
        PUSH AF         ; 11
        DEC BC          ; 6
        LD A,B          ; 4
        OR C            ; 4
        JP NZ,.1        ; 10 = 45 ciclos antes de OUT
        POP AF
        RET

        ;
        ; Copia RAM a VRAM
        ; HL = Direcci¢n origen en RAM
        ; DE = Direcci¢n destino en VRAM (0000-3FFF)
        ; BC = Total de bytes
        ;
LDIRVM:
        EX DE,HL
        rst $10         ; 10 (RET)
.1:     LD A,(DE)       ; 7
        OUT (VDP),A
        INC DE          ; 6
        DEC BC          ; 6
        LD A,B          ; 4
        OR C            ; 4
        JP NZ,.1        ; 10 = 37 ciclos antes de OUT
        RET

vdp_copia_bloque:
        OUTI            ; 16
        NOP             ; 4
        NOP             ; 4
        JP NZ,$-4       ; 10 = 34 ciclos
        RET

        ;
        ; Muestra un mensaje
        ; HL = Direcci¢n destino en VRAM
        ; La cadena terminada en FF est  en la direcci¢n de retorno.
        ;
mensajito:
        ex de,hl
        ex (sp),hl
        ex de,hl
.0:     ld a,(de)
        rst $08
        inc hl
        inc de
        ld a,(de)
        inc a
        jr nz,.0
        inc de
        ex de,hl
        ex (sp),hl
        ex de,hl
        ret

        ;
        ; Checa si un cuadro es caminable
        ;
checa_camino:
        ld d,0
        ld hl,caminable         ; Indexa en tabla
        ld a,e
        srl e                   ; 4 datos por cada byte
        srl e
        add hl,de
        ld e,a
        and 3                   ; Separa indicaci¢n de franja
        inc a
        ld d,a
        ld a,(hl)               ; Lee byte
.1:     rlca                    ; Corre hasta obtener dato
        rlca
        dec d
        jp nz,.1
        rrca
        ret

        ;
        ; Cuantos monigotes y adornos
        ;
MAX_MONIGOTES:  equ 12

        ;
        ; Offsets de variables de jugador
        ;
d_x:            equ 0   ; Coordenada X
d_y:            equ 1   ; Coordenada Y  
d_sprite:       equ 2   ; Sprite
d_color:        equ 3   ; Color
d_recarga:      equ 4   ; Tiempo para recarga de disparo
d_nivel:        equ 5   ; Nivel de juego
d_velocidad:    equ 6   ; Velocidad.
d_energia:      equ 7   ; Energ¡a
d_dx:           equ 4   ; Monigotes, direcci¢n X
d_dy:           equ 5   ; Monigotes, direcci¢n Y
d_paso:         equ 8   ; Paso
d_tipo:         equ 9   ; Monigotes, tipo
d_ultimo:       equ 10  ; Ultimo movimiento.
d_offset:       equ 12  ; Offset de pantalla (en VRAM)
d_refx:         equ 14  ; Referencia X (base nivel)
d_refy:         equ 15  ; Referencia Y (base nivel)
d_real:         equ 16  ; Offset de nivel (datos reales)
d_moni:         equ 18  ; Offset de lista de monigotes
d_vidas:        equ 20  ; Vidas
d_espera:       equ 21  ; Espera antes de m s da¤o.
d_basex:        equ 22  ; Base X de donde apareci¢.
d_basey:        equ 23  ; Base Y de donde apareci¢.
d_puntos:       equ 24  ; Puntos acumulados
d_objeto:       equ 27  ; Indica si lleva objetos
                        ; bit 0 = Lleva llave
                        ; bit 1 = Pasando por puerta
                        ; bit 2 = Esperando
                        ; bit 3 = Secuencia de encuentro
                        ; bit 4 = En lluvia de monstruos
                        ; bit 5 = Jugador muerto
                        ; bit 6 = Jugador inactivo
                        ; bit 7 = Victoria
d_trans:        equ 28  ; Ubicaci¢n del transportador (p gina oculta)
d_tiempo:       equ 30  ; Tiempo para que aparezca gran jefe
d_mapa:         equ 32  ; Apuntador a mapa modificado.
d_estado:       equ 34  ; Estado de historia
d_rescatados:   equ 35  ; Cient¡ficos rescatados (BCD)
d_temblor:      equ 36  ; Estado de temblor (no usado)
d_dirtem:       equ 37  ; Direcci¢n temblor (0=abajo, 1=izq, 2=der)(no usado)
d_linea:        equ 38  ; L¡nea para salvar pantalla en temblor
d_puerta:       equ 40  ; Puerta por restaurar.
d_mosaico:      equ 42  ; N£mero de mosaico de puerta.
d_seccion:      equ 43  ; Secci¢n (mapa)
                        ; bit 5 - 4 = Mapa
                        ;             00 = Mapa 1
                        ;             01 = Mapa 2
                        ;             10 = Mapa 3
                        ;             11 = Mapa 4
d_revivir:      equ 44  ; Tiempo para revivir

BASE_MOS:       equ $38 ; Caracter base de mosaicos gr ficos.

tabla_modo_2:
        DB $02          ; Registro 0 - Modo 2
        DB $82          ; Registro 1 - Modo 2, apaga video, sprites 16x16
        DB $0E          ; Registro 2 - Base pantalla $3800
        DB $FF          ; Registro 3 - Tabla color $2000
        DB $03          ; Registro 4 - Tabla caracteres $0000
        DB $76          ; Registro 5 - Tabla sprites $3B00
        DB $03          ; Registro 6 - Figuras sprites $1800
        DB $01          ; Registro 7 - Borde negro

        ;
        ; Todo lo que esta aqu¡ es necesario hacerlo s¢lo una vez.
        ;
inicio:
        di      ; El Coleco no usa INT, pero mejor estar prevenidos.
        ;
        ; Inicia la pila
        ;
        ld sp,pila
        ;
        ; Borra todas las variables habidas y por haber
        ; $7000-$73b0
        ;
        ld hl,$73af
.2:     ld (hl),0
        dec hl
        bit 4,h
        jr nz,.2
        ;
        ; Inicia el Megacart
        ;
        call sel_slot0
        ;
        ; Inicia el sonido
        ;
        call inicia_sonido
        ;
        ; Inicia el VDP
        ;
        call vdp_modo_2
    if 1
        ;
        ; Muestra quien distribuye
        ;
        ld hl,$0648
        ld de,mensaje_12
        call visual_mensaje0
        ld hl,$0a40
        ld bc,$0280
        ld de,logo_distribuidor
        call descompacta_rle_imagen
        ld bc,150
        call retardo
        call pantalla_negra_rapida
        ;
        ; Logo del programador
        ;
        ld hl,$0658
        ld de,mensaje_20
        call visual_mensaje0
        ld hl,$0860
        ld bc,$0840
        ld de,logo_ot
        call descompacta_rle_imagen
        ld bc,150
        call retardo
        call pantalla_negra_rapida
    endif
        ;
        ; Introducci¢n del juego
        ;
REINICIO:
        call presentacion
        ld a,(ticks)
        ld b,a
        ld a,(ticks+1)
        xor b
        xor $b6         ; N£mero seudoaleatorio
        ld (sprites_especiales+1),a     ; Configuraci¢n de llaves
        ld a,(nivel1+5) ; Mapa inicial
        push af
        ld a,(sprites)  ; N£mero de jugadores
        push af
        call limpia_sprites
        halt
        call pantalla_negra
        ;
        ; Entrada al juego
        ;
        xor a
        ld (modo),a
        ;
        ; Procede a inicializar la pantalla 
        ;
        rst $28 ; zona_dura
        ld hl,$3800
        ld bc,$0300
        xor a
        call FILVRM
        ;
        ; Carga las letras (56 caracteres, replicados 3 veces para
        ; los bitmaps y 3 veces para el color)
        ;
        ld hl,letras
        ld de,$0000
        ld bc,$01a8
        call repetir
        ld hl,color_letras
        ld de,$2000
        ld bc,$01a8
        call repetir
        ;
        ; Carga los mosaicos para los niveles (50 diferentes)
        ;
        ld hl,graf_bitmap
        ld de,$01c0
        ld bc,1600
        call repetir
        ld hl,graf_color
        ld d,$21
        call repetir
        call zona_facil
        ;
        ; Espera una actualizaci¢n del video
        ;
        halt
        ;
        ; Estado inicial de los jugadores
        ;
        pop af
        cp $78          ; Checa coordenada Y de la pistola
        ld hl,jug_fuera
        jr z,$+5
        ld hl,jug1_inicial
        ld de,jug1
        ld bc,45
        ldir
        cp $69          ; Checa coordenada Y de la pistola
        ld hl,jug_fuera
        jr z,$+5
        ld hl,jug2_inicial
        ld c,45
        ldir
        pop af
        add a,a
        add a,a
        add a,a
        add a,a
        ld (jug1+d_seccion),a
        ld (jug2+d_seccion),a
        ld hl,bits1
        ld b,102        ; De paso inicia tambi‚n bits2
        ld (hl),0
        inc hl
        djnz $-3
        ;
        ; A partir de ahora solo la rutina de interrupci¢n toca el VDP
        ;
        ld a,5          ; Redefine sprites, controla sprites y pantalla
        ld (modo),a
        ;
        ; Comienza la m£sica
        ;
        ; Se hace aqu¡ porque a veces en depuraci¢n se puede seleccionar
        ; cuarto de jefe y cambia la m£sica.
        ;
        call musica_general
        ;
        ; Carga los niveles para cada uno y actualiza sus indicadores
        ;
    if 0  ; Depura mosaicos 09-abr-2011
        ld hl,$3800
        ld a,0
.1001:  ld b,16
.1000:  push bc
        push hl
        push af
        call dibuja_mosaico
        pop af
        pop hl
        pop bc
        inc a
        inc hl
        inc hl
        djnz .1000
        ld de,32
        add hl,de
        cp 80
        jr nz,.1001
        jr $
    else
        ld ix,jug1
        call actualiza_indicadores_nivel
        ld ix,jug2
        call actualiza_indicadores_nivel
    if 0
        ld ix,jug1
        jp .15

        ;
        ; Permite ver todos los mapas
        ;
.10:    halt
        ld ix,jug1
        out (KEYSEL),a
        ex (sp),hl
        ex (sp),hl
        in a,(JOY1)
        and $0f
        cp $0d          ; 1
        jr z,.11
        cp $07          ; 2
        jr z,.12
        cp $0c          ; 3
        jr z,.13
        cp $02          ; 4
        jr z,.14
        jr .10

.11:    ld bc,5
        call retardo
        ld a,(ix+d_seccion)
        sub $10
        and $30
        ld (ix+d_seccion),a
        ld (ix+d_nivel),0
        jp .15

.12:    ld bc,5
        call retardo
        ld a,(ix+d_seccion)
        add a,$10
        and $30
        ld (ix+d_seccion),a
        ld (ix+d_nivel),0
        jp .15

.13:    ld bc,5
        call retardo
        dec (ix+d_nivel)
        jp .15

.14:    ld bc,5
        call retardo
        inc (ix+d_nivel)
.15:    call actualiza_indicadores_nivel
        halt
        call actualiza_sprites
        jp .10

    endif
        ;
        ; Bucle principal
        ;
.1:     halt                    ; Actualizaci¢n, tambi‚n ahorra energ¡a.
        call actualiza_sprites  ; Coloca los sprites
        call maneja_entrada     ; Los jugadores y monstruos se mueven.
        ld ix,jug1
        call avanza_historia    ; Avanza la historia
        ld ix,jug2
        call avanza_historia    ; Avanza la historia
        ;
        ; Un c¢digo de bloqueo, mientras uno de los jugadores est‚ activo
        ; no puede continuar a:
        ;   o Fin de juego (volver a presentaci¢n)
        ;   o Victoria (pantalla de helic¢ptero)
        ;
        ld ix,jug1
        ld iy,jug2
        ld a,(ix+d_vidas)       ; Jugador 1
        or a                    ; ¨A£n vivo?
        jp m,.6
        bit 7,(ix+d_objeto)     ; ¨Triunfo?
        jr z,.5
.6:     ld a,(iy+d_vidas)       ; Jugador 2
        or a                    ; ¨A£n vivo?
        jp m,.7
        bit 7,(iy+d_objeto)     ; ¨Triunfo?
        jr z,.5
.7:     ld a,(ix+d_tiempo)
        or (ix+d_tiempo+1)
        or (iy+d_tiempo)
        or (iy+d_tiempo+1)
        jr nz,.5
        ld a,(ix+d_objeto)
        or (iy+d_objeto)        ; Bit 7 a 1 en cualquiera de los dos
        jp m,toma_final         ; Fin de juego, va a toma final
        jp REINICIO             ; Termin¢, va a la presentaci¢n.

.5:     call checa_pausa
        jr .1                   ; Repite incansablemente
    endif

        ;
        ; Escribe un bloque tres veces en VRAM
        ;
repetir:
        call .1
        call .1
.1:     push bc
        push hl
        push de
        call LDIRVM
        pop de
        ld a,d
        add a,8
        ld d,a
        pop hl
        pop bc
        ret

        ;
        ; Punto de entrada al recibir un NMI (Non-Maskable Interrupt),
        ; el Z80 la activa cuando ocurre un cambio de 1 a 0 (edge-sensitive)
        ; al contrario de INT que es level-sensitive.
        ;
        ; Por lo tanto se puede hacer un truco de "desactivar" NMI si dejamos
        ; que el procesador de video mantenga la interrupci¢n activa
        ;
vector_nmi:
        push af
        push bc
        push de
        push hl
        exx
        ex af,af'
        push af
        push bc
        push de
        push hl
        ld hl,modo
        bit 6,(hl)      ; ¨Demasiado ocupado para recibir NMI?
        jr nz,.0        ; S¡, salta
        ;
        ; Limpia la interrupci¢n
        ;
        in a,(VDP+1)    ; Leer este registro reinicia latches de dir. VDP
        call vector_int
        ld hl,(slot_actual)
        ld h,(hl)
        jr .1

.0:     set 7,(hl)      ; Anota NMI perdido
.1:     pop hl
        pop de
        pop bc
        pop af
        ex af,af'
        exx
        pop hl
        pop de
        pop bc
        pop af
        retn

zona_dura:
        push hl
        ld hl,modo
        set 6,(hl)
        pop hl
        ret

zona_facil:
        push hl
        ld hl,modo
        res 6,(hl)
        nop
        bit 7,(hl)      ; ¨Perdi¢ alg£n NMI?
        res 7,(hl)
        pop hl
        ret z           ; No, retorna
        ;
        ; Entonces la l¡nea de interrupci¢n continua activada, no llegar 
        ; ning£n NMI nuevo hasta que se lea el estatus del VDP
        ;
        push af
        push bc
        push de
        push hl
        exx
        ex af,af'
        push af
        push bc
        push de
        push hl
        ld hl,modo
        call vector_int
        ld hl,(slot_actual)
        ld h,(hl)
        pop hl
        pop de
        pop bc
        pop af
        ex af,af'
        exx
        pop hl
        pop de
        pop bc
        ;
        ; Limpia la interrupci¢n
        ;
        ; Lo hace hasta el £ltimo momento, as¡ reduce el tama¤o de pila en
        ; caso de que ya tenga que responder otro NMI.
        ;
        in a,(VDP+1)    ; Leer este registro reinicia latches de dir. VDP
        pop af
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
        bit 7,(hl)
        ret nz
        set 7,(hl)
        push hl
        ld a,(estado)
        ld hl,vector_dir
        add a,l
        ld l,a
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ex (sp),hl
        ret

        ;
        ; Cargando una imagen que se abre del centro hacia arriba y abajo
        ;
vector_cortina:
        call vector_sonido
        call LINEAS_ABRE
        LD HL,modo
        RES 7,(HL)
        RET

        ;
        ; Cargando una imagen que se abre como persiana
        ;
vector_persiana:
        call vector_sonido
        call LINEAS
        LD HL,modo
        RES 7,(HL)
        RET

        ;
        ; En historia
        ;
vector_historia:
        ld hl,(offset)
        ld de,$3800
        add hl,de
        rst $10
        ld hl,pantalla
        ld bc,$8000+VDP
        rst $18
        ld bc,$8000+VDP
        rst $18
        ld bc,$8000+VDP
        rst $18
        jp vector_presentacion

        ;
        ; Parpadeo de borde para mensaje de ALERTA
        ;
        ; El truco es que la imagen tiene fondo transparente, as¡
        ; que toda la pantalla parpadea de una forma muy bonita.
        ;
vector_borde:
        ld a,(ticks)
        sub e
        and $0c
        ld bc,$0107
        jr z,.8
        cp $04
        ld b,$06
        jr z,.8
        cp $08
        ld b,$08
        jr z,.8
        inc b
.8:     call WRTVDP

        ;
        ; Solo en el modo de juego se mete con el VDP
        ;
vector_principal:
        bit 0,(hl)      ; ¨Controlar VDP?
        jp z,vector_sonido ; No, salta a contar ticks y generar sonido
        bit 2,(hl)      ; ¨Definir sprites (modo de juego) ?
        jp z,vector_presentacion ; No, salta.
        ;
        ; Tick 0 - Redefine sprites y actualiza sprites
        ; Tick 2 - Redefine sprites y actualiza sprites
        ;
        ;
        ; Obtiene los sprites que est n usando los h‚roes...
        ;
        ld bc,sprites_heroes
        ld a,(sprites_especiales+0)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ex de,hl
        ld a,(sprites_especiales+2)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ld b,h
        ld c,l
        ;
        ; ...para definirlos en el momento.
        ;
        ld hl,$1800
        rst $10
        ld h,b
        ld l,c
        ex de,hl
        ld bc,$2000+VDP
        rst $18
        ex de,hl
        ld b,32
        rst $18
        ;
        ; Obtiene los sprites que est n usando los jefes...
        ;
        ld bc,sprites_jefes
        ld hl,(sprites_especiales+4)
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ex de,hl
        ld hl,(sprites_especiales+6)
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ld b,h
        ld c,l
        ;
        ; ...para definirlos en el momento.
        ;
        ld hl,$1f00
        rst $10
        ld h,b
        ld l,c
        ex de,hl
        ld bc,$8000+VDP
        rst $18
        ex de,hl
        ld b,128
        rst $18
        ;
        ; Actualiza los sprites
        ;
vector_presentacion:
        ld hl,$3B00
        rst $10
        ld hl,sprites
        ld bc,$7000+VDP
        rst $18
        ld hl,modo
        bit 2,(hl)      ; ¨Definir sprites (modo de juego) ?
        jr z,vector_sonido  ; No, salta.
        bit 5,(hl)      ; ¨En helic¢ptero?
        jr nz,vector_sonido  ; S¡, salta.
        ld hl,dir_pantalla_pc
        ld a,(ticks)
        and 7
        add a,a
        add a,l
        ld l,a
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        push hl
        srl h
        rr l
        srl h
        rr l
        srl h
        rr l
        ld a,h
        and $03
        or $38
        ld h,a
        call RDVRM
        cp l
        pop hl
        jr z,vector_sonido
        rst $10
        ld a,(ticks)
        and 24
        rrca
        rrca
        rrca
        add a,colores_pantalla_pc and 255
        ld l,a
        ld h,colores_pantalla_pc>>8
        ld a,(hl)
        out (VDP),a
        ;
        ; Subrutina que se encarga de contar ticks y generar sonido
        ;
vector_sonido:
        ld a,($0069)    ; ROM Coleco, cuadros por segundo
        cp 50
        jr z,.1
        ld hl,ciclo
        inc (hl)
        ld a,(hl)
        sub 6
        jr nz,.1
        ld (hl),a       ; Se come 1 de cada 6 ciclos
        ld hl,modo
        res 7,(hl)
        ret

        ;
        ; Aqu¡ cree que son 50 ciclos por segundo
        ;
.1:     call genera_sonido
        ;
        ; Incrementa ticks transcurridos
        ;
        ld hl,(ticks)
        inc hl
        ld (ticks),hl
        ld hl,modo
        res 7,(hl)
        ret

        ;
        ; El caracter 0 en todas las p ginas lo vuelve un bloque negro
        ;
caracter_negro:
        LD H,$20
        LD A,$F1
        CALL .0
        LD H,$28
        CALL .0
        LD H,$30
        CALL .0
        LD H,$00
        XOR A
        CALL .0
        LD H,$08
        CALL .0
        LD H,$10
.0:     LD L,0
        LD BC,8
        jp FILVRM

        ;
        ; Pantalla negra
        ; Realiza una secuencia de cortina de izquierda a derecha
        ;
PANTALLA_NEGRA:
        rst $28 ; zona_dura
        ld bc,$0107     ; Reinicia borde a negro
        call WRTVDP
        call caracter_negro
        call zona_facil
        halt
        LD DE,32
        LD C,32         ; 32 columnas
        ;
        ; Bucle de cortina
        ;
PANTALLA_NEGRA3:
        LD H,$38
        LD A,32
        SUB C
        LD L,A
        LD B,24         ; 24 l¡neas
        XOR A
PANTALLA_NEGRA2:
        rst $08
        ADD HL,DE
        DJNZ PANTALLA_NEGRA2
        LD A,(ticks)
        LD B,A
PANTALLA_NEGRA4:
        LD A,(ticks)
        CP B
        JR Z,PANTALLA_NEGRA4
        DEC C
        JR NZ,PANTALLA_NEGRA3
        ;
        ; Ahora limpia con toda calma
        ;
PANTALLA_NEGRA5:
        ld hl,$0000
.0:     push hl
        LD BC,256
        xor a
        rst $28 ; zona_dura
        CALL FILVRM
        call zona_facil
        pop hl
        inc h
        ld a,h
        cp $18
        jr nz,.0
        ld hl,$2000
.1:     push hl
        LD BC,256
        xor a
        rst $28 ; zona_dura
        CALL FILVRM
        call zona_facil
        pop hl
        inc h
        ld a,h
        cp $38
        jr nz,.1
        call zona_dura
        ld h,$38
.2:     ld a,l
        rst $08
        inc hl
        ld a,h
        cp $3B
        jr nz,.2
        JP zona_facil

        ;
        ; Pantalla negra r pida
        ; Lo mismo que la otra rutina, pero sin la cortina
        ;
PANTALLA_NEGRA_RAPIDA:
        rst $28 ; zona_dura
        call caracter_negro
        LD HL,$3800
        LD BC,$300
        XOR A
        CALL FILVRM
        call zona_facil
        JP PANTALLA_NEGRA5

        ;
        ; Carga una toma de la historia
        ; (gr fica compactada)
        ;
        ; HL = Offset 64K
        ; B = Estado de descarga (2 para cortina, 4 para persiana)
        ;
CARGAR_TOMA:
        DI
        LD (L_OFFSET),HL
        LD A,B
        LD (ESTADO),A
        LD HL,0
        LD (L_LINEA),HL
        EI
.1:     HALT                    ; Espera a que acabe de descompactarse
        LD A,(ESTADO)
        OR A
        JP NZ,.1
        RET

        ;
        ; Visualiza una imagen por apertura
        ;
LINEAS_ABRE:
        LD HL,(L_LINEA)
        LD A,L
        CP 96                   ; ¨Termin¢ los 96 pasos?
        JP NC,LINEAS8           ; S¡, vuelve a estado normal
        LD B,A
        LD DE,(L_OFFSET)
        LD A,95                 ; Descompacta l¡nea = 95 - paso
        SUB B
        PUSH AF
        AND 7
        LD L,A
        POP AF
        RRCA
        RRCA
        RRCA
        AND $1F
        LD H,A
        PUSH HL
        CALL LINEAS5            ; Descompacta bitmap
        POP HL
        SET 5,H
        CALL LINEAS5            ; Descompacta color
        LD A,(L_LINEA)
        ADD A,96                ; Descompacta l¡nea = 96 + paso
        PUSH AF
        AND 7
        LD L,A
        POP AF
        RRCA
        RRCA
        RRCA
        AND $1F
        LD H,A
        PUSH HL
        CALL LINEAS5            ; Descompacta bitmap
        POP HL
        SET 5,H
        CALL LINEAS5            ; Descompacta color
        LD HL,L_LINEA
        INC (HL)
        LD (L_OFFSET),DE
        RET

        ;
        ; Fin de descompactaci¢n, vuelve a estado normal
        ;
LINEAS8:
        XOR A
        LD (ESTADO),A
        RET

        ;
        ; Visualiza una imagen por l¡neas
        ;
LINEAS:
        LD HL,(L_LINEA)
        LD A,L
        CP 64           ; ¨Ya hizo los 64 pasos?
        JP NC,LINEAS8   ; S¡, vuelve a normal
        AND 7
        LD B,A
        ADD A,A         ; L¡nea base = (paso & 7) * 24 + (paso >> 3)
        ADD A,B
        LD H,A
        SRL L
        SRL L
        SRL L
        LD DE,(L_OFFSET)
        CALL LINEAS1    ; Descompacta 3 l¡neas separadas por 7 pixeles
        LD HL,L_LINEA
        INC (HL)
        LD (L_OFFSET),DE
        RET

        ;
        ; Descompacta l¡neas separadas en Y, Y+8 e Y+16
        ;
LINEAS1:
        LD B,$03
LINEAS6:
        PUSH BC
        PUSH HL
        CALL LINEAS5
        POP HL
        PUSH HL
        SET 5,H
        CALL LINEAS5
        POP HL
        POP BC
        INC H
        DJNZ LINEAS6
        RET

        ;
        ; Carga un retrato
        ;
carga_retrato:
        push hl
        ld hl,SLOT_2
        call sel_slot
        pop hl
        ex de,hl
        ld bc,$0840
        call descompacta_rle_imagen
        jp sel_slot0

        ;
        ; Descompactaci¢n RLE de imagen
        ; HL = Destino VRAM
        ; DE = Buffer origen
        ; B = L¡neas
        ; C = Bytes por l¡nea.
        ;
descompacta_rle_imagen:
        push bc
        push hl
.1:     push bc
        push hl
        rst $28 ; zona_dura
        call descompacta_rle_bloque
        call zona_facil
        pop hl
        pop bc
        inc h
        djnz .1
        pop hl
        pop bc
        set 5,h
.2:     push bc
        push hl
        rst $28 ; zona_dura
        call descompacta_rle_bloque
        call zona_facil
        pop hl
        pop bc
        inc h
        djnz .2
        ret

        ;
        ; Descompactaci¢n RLE de imagen 2
        ; HL = Destino VRAM
        ; DE = Buffer origen
        ; B = L¡neas
        ; C = Bytes por l¡nea.
        ;
descompacta_rle_imagen2:
.1:     push bc
        push hl
        rst $28 ; zona_dura
        call descompacta_rle_bloque
        call zona_facil
        pop hl
        pop bc
        push bc
        push hl
        set 5,h
        rst $28 ; zona_dura
        call descompacta_rle_bloque
        call zona_facil
        pop hl
        pop bc
        inc h
        djnz .1
        ret

        ;
        ; Descompactaci¢n RLE de bloque
        ;
        ; HL = Destino VRAM
        ; DE = Buffer origen
        ; C = Bytes.
        ;
        ; Ordenes:
        ;  00     =  Sin uso.
        ;  01-3F  =  Copia 1 a 63 veces.
        ;  40-7F  =  Repite 00 o FF.
        ;  80     =  Repetici¢n de patr¢n
        ;  FE-81  =  Repite 1 a 126 veces.
        ;  FF     =  Sin uso.
        ;
descompacta_rle_bloque:
        rst $10
.1:
        LD A,(DE)               ; Obtiene orden
        INC DE
        CP $80
        JP Z,.5                 ; Salta si es orden de repetici¢n de patr¢n
        JP M,.2                 ; Salta si es $00-$7F
        CPL                     ; Repetici¢n simple
        LD B,A
        LD A,(DE)
        INC DE
.3:
        OUT (VDP),A             ; 11
        DEC C                   ; 4
        PUSH AF                 ; 11
        POP AF                  ; 10
        DJNZ .3                 ; 13 = 38 ciclos antes de OUT
        JP NZ,.1                ; Retorna si termin¢ la l¡nea
        ret

.2:     CP $40
        jp c,.8
        and $3f
        rra
        ld b,a
        sbc a,a
        inc b
        jr .3

.8:     LD B,A
.4:
        LD A,(DE)               ; 7
        INC DE                  ; 6
        OUT (VDP),A             ; 11
        NOP                     ; 4
        DEC C                   ; 4
        DJNZ .4                 ; 13 = 34 ciclos antes de OUT
        JP NZ,.1                ; Retorna si termin¢ la l¡nea
        ret

        ;
        ; Repetici¢n de patr¢n
        ;
.5:     LD A,(DE)
        AND $F0         ; N£mero de veces
        RRCA
        RRCA
        RRCA
        RRCA
        LD B,A
.7:     LD A,D
        EXX
        LD H,A
        EXX
        LD A,E
        EXX
        LD L,A
        EXX
        LD A,C
        EXX
        LD C,A
        LD A,(HL)
        AND $0F         ; N£mero de bytes
        LD B,A
        INC HL
.6:     LD A,(HL)               ; 7
        INC HL                  ; 6
        NOP                     ; 4
        OUT (VDP),A             ; 11
        DEC C                   ; 4
        DJNZ .6                 ; 13 = 30 ciclos antes de OUT
        LD A,C
        EXX
        LD C,A
        DJNZ .7
        EXX
        LD A,L
        EXX
        LD E,A
        EXX
        LD A,H
        EXX
        LD D,A
        JP NZ,.1                ; Retorna si termin¢ la l¡nea
        RET

        ;
        ; Descompactaci¢n RLE
        ;
        ; Ordenes:
        ;  00     =  Limpieza de l¡nea
        ;  01-20  =  Copia 1 a 32 veces.
        ;  21-6F  =  Sin uso.
        ;  70-7F  =  Limpieza de l¡nea con color
        ;  80-BF  =  Repite 00 o FF de 1 a 32 veces.
        ;  C0-DE  =  Sin uso.
        ;  FE-DF  =  Repite 1 a 32 veces.
        ;  FF     =  Sin uso.
        ;
LINEAS5:
        ld a,(estado)
        cp 4
        jr nz,$+5
        ld a,(SLOT_2)
        ld c,8
        ld a,(de)               ; Obtiene orden
        inc de
        or a
        jp z,.1
        cp $70
        jp c,.2
        cp $80
        jp nc,.2
        and $0f                 ; Separa el color
        rrca                    ; Corrimiento a posici¢n correcta.
        rrca
        rrca
        rrca
        ld b,32                 ; 32 bytes (una l¡nea de color)
        jp .4-1

.1:     ld b,32                 ; 32 bytes (una l¡nea de pixeles)
        bit 5,h                 ; ¨Trama de bitmap?
        ld a,$ff                ; Llena a $FF
        jp z,.4-1
        ld a,$01                ; Es color, llena a $01 (transparente)
        jp .4-1

.3:
        ld a,(de)               ; Obtiene orden
        inc de
.2:
        or a                    ; ¨Limpieza de l¡nea?
        jp p,.5                 ; ¨ $00-$7F ?, s¡, salta
        cp $c0                  ; ¨Limpieza 00/FF?
        jp nc,.7
        and $3f
        rra
        ld b,a
        sbc a,a
        inc b
        jp .4-1

.7:     cpl
        ld b,a
        ld a,(de)
        inc de
        ex af,af'
.4:
        ld a,l
        out (VDP+1),a
        ld a,h
        or $40
        out (VDP+1),a
        nop                     ; 4
        nop                     ; 4
        nop                     ; 4
        ld a,l                  ; 4
        add a,c                 ; 4
        ld l,a                  ; 4
        ex af,af'               ; 4 = 28 ciclos antes de OUT
        out (VDP),a             ; 11
        ex af,af'               ; 4
        djnz .4                 ; 13 si toma
        jp nc,.3
        ret                     ; Retorna si termin¢ la l¡nea

.5:
        ld b,a
.6:
        ld a,l
        out (VDP+1),a
        ld a,h
        or $40
        out (VDP+1),a
        nop
        ld a,l                  ; 4
        add a,c                 ; 4
        ld l,a                  ; 4
        ld a,(de)               ; 7
        inc de                  ; 6  = 29 ciclos antes de OUT
        out (VDP),a             ; 12
        djnz .6                 ; 13 si toma
        jp nc,.3
        ret                     ; Retorna si termin¢ la l¡nea

        ;
        ; Visualiza un mensaje
        ;
visual_mensaje_idioma:
        ;
        ; Visualiza un mensaje de ROM
        ; HL = Dir. VRAM
        ; DE = Ap. a mensaje (terminado en FF, FE=cambio del linea)
        ;
VISUAL_MENSAJE0:
        LD C,$21                ; Verdes para letra inicial
VISUAL_MENSAJE1:
        rst $28 ; zona_dura
.1:     PUSH HL
        CALL VISUAL_LINEA       ; Visualiza una l¡nea
        POP HL
        INC H                   ; Pasa a siguiente l¡nea
        rlca                    ; ¨Acab¢ el mensaje?
        jr nc,.1                ; No, contin£a
        jp zona_facil

        ;
        ; Visualiza una l¡nea de texto
        ; HL = Destino en VRAM
        ; DE = Mensaje terminado en $FE o $FF
        ; C = Color base para primera letra, posteriores ser n $A1
        ;
        ; Tambi‚n deriva n£mero si halla c¢digos $40 o $41, usado
        ; para mostrar cuenta de cient¡ficos rescatados.
        ;
VISUAL_LINEA:
        ld a,(de)
        inc de
        push af
        and $3f
        cp $3d
        call z,deriva_clave
        CP $3e
        CALL NC,deriva_numero
        CALL VISUAL_LETRA
        ld c,$A1
        pop af
        cp $40
        ret nc
        jr VISUAL_LINEA

        ;
        ; Deriva clave
        ;
deriva_clave:
        ld a,(jug1+d_vidas)     ; Jugador 1
        or a                    ; ¨A£n vivo?
        ld a,(jug2+d_vidas)     ; Jugador 2
        jp m,.1
        or a                    ; ¨A£n vivo?
        ld a,$21
        ret m
        ld a,$23
        ret

.1:     or a                    ; ¨A—n vivo?
        ld a,$20
        ret m
        ld a,$22
        ret

        ;
        ; Deriva n£mero
        ;
deriva_numero:
        ld a,(ix+d_rescatados)
        jr nz,.1        ; Salta si es d¡gito bajo ($41)
        rrca            ; Corre
        rrca
        rrca
        rrca
.1:     and $0f
        add a,$20       ; N£mero
        ret

        ;
        ; Visualiza una letra
        ; HL = Destino en VRAM, autoincremente a siguiente letra
        ; A = Letra
        ; C = Color
        ;
VISUAL_LETRA:
        PUSH DE
        PUSH HL
        PUSH BC
        EX DE,HL
        LD L,A
        LD H,0
        ADD HL,HL
        ADD HL,HL
        ADD HL,HL
        LD BC,LETRAS
        ADD HL,BC
        LD BC,8
        CALL LDIRVM     ; Copia bitmap de la letra
        POP BC
        POP HL
        ;
        ; Pone color de la letra
        ;
        PUSH HL
        SET 5,H
        LD A,$F1        ; El primer pixel es brillante :)
        rst $08
        INC HL
        LD B,5
        LD A,C
        OR $10          ; Color brillante para siguientes 5 l¡neas
VISUAL_LETRA2:
        rst $08
        INC HL
        DJNZ VISUAL_LETRA2
        LD A,C          ; Ultimas dos en obscuro
        rst $08
        INC HL
        rst $08
        RES 5,H
        SRL H
        RR L
        SRL H
        RR L
        SRL H
        RR L
        ld a,(estado)
        cp 8
        jr nz,.0
        ld a,l
        ld de,(offset)
        sbc hl,de
        ld de,pantalla
        add hl,de
        ld (hl),a
        pop hl
        ld de,8
        add hl,de
        pop de
        ret

.0:     LD DE,$3800
        ADD HL,DE
        LD A,L
        rst $08
        POP HL
        LD DE,8
        ADD HL,DE
        POP DE
        RET

        ;
        ; Limpia los sprites.
        ; Los sprites se conservan buffereados en el modo 1
        ;
limpia_sprites:
        ld hl,sprites
        ld b,128
.1:     ld (hl),$d1
        inc hl
        djnz .1
        ret

        ;
        ; Pone el modo de alta resoluci¢n
        ; Coleco entra con las interrupciones del VDP desactivadas
        ; Esta rutina activa las interrupciones hasta justo antes del retorno
        ;
vdp_modo_2:
        xor a
        ld (modo),a     ; No controla VDP, no define sprites
        LD HL,tabla_modo_2
        LD BC,$0800
.1:     PUSH BC
        LD B,(HL)
        CALL WRTVDP
        POP BC
        INC C
        INC HL
        DJNZ .1
        ;
        ; Limpia todo
        ; 
        LD HL,$3B00
        LD A,$D0
        LD C,$80
        CALL FILVRM
        CALL limpia_sprites
        ;
        ; Carga los sprites fijos
        ; 12-may-2011. Innecesario, lo hace la presentaci¢n
        ;
;        LD HL,figuras_sprites
;        LD DE,$1800
;        LD BC,$0700
;        CALL LDIRVM
        ;
        ; Prepara para uso de pantalla de alta resoluci¢n
        ;
        call prepara_alta_resolucion
        ld bc,$e201     ; Activa el video e interrupciones
        jp WRTVDP

        ;
        ; Prepara para uso de pantalla de alta resoluci¢n
        ;
prepara_alta_resolucion:
        xor a           ; Patrones
        ld h,a
        ld l,a
        LD BC,6144
        CALL FILVRM
        LD H,$20        ; Colores
        LD B,$18
        CALL FILVRM
        ld h,$38
.2:     ld a,l
        rst $08
        inc hl
        ld a,h
        cp $3B
        jr nz,.2
        ret

        ;
        ; Activa el video
        ;
activa_video:
        halt
        LD BC,$E201     ; Activa el video
        JP WRTVDP

        ;
        ; Desactiva el video
        ;
desactiva_video:
        halt
        LD BC,$A201     ; Desactiva el video
        JP WRTVDP

        ;
        ; Trucos del juego
        ;

    if programador=1
        ;
        ; 1 - Vestidos de negro
        ;
truquitos_1:
        ld a,1
        ld (jug1+d_color),a
        ld (jug2+d_color),a
        call efecto_rescate
        jr trucos

        ;
        ; 2 - Llave
        ;
truquitos_2:
        ld ix,jug1
        set 0,(ix+d_objeto)
        ld ix,jug2
        set 0,(ix+d_objeto)
        call efecto_llave
        jr trucos

trucos_proximo_piso:
        inc (ix+d_nivel)
        ld a,(ix+d_vidas)
        inc a   ; cp -1
        call nz,carga_nivel
        ret

        ;
        ; 3 - Energ¡a
        ;
truquitos_3:
        ld a,6
        ld (jug1+d_energia),a
        ld (jug2+d_energia),a
        call efecto_vida
        jr trucos

trucos_mapa:
        ld (ix+d_nivel),-1
        ld a,(ix+d_seccion)
        add a,$10
        and $30
        ld (ix+d_seccion),a
        ret

        ;
        ; 6 - Toma final
        ;
truquitos_6:
        ld ix,jug1
        set 7,(ix+d_objeto)
        ld ix,jug2
        set 7,(ix+d_objeto)
        jr trucos

        ;
        ; 4 - Siguiente mapa
        ;
truquitos_4:
        ld ix,jug1
        call trucos_mapa
        ld ix,jug2
        call trucos_mapa
;       jr truquitos_5

        ;
        ; 5 - Pr¢ximo piso
        ;
truquitos_5:
        ld ix,jug1
        call trucos_proximo_piso
        ld ix,jug2
        call trucos_proximo_piso
;       jp trucos
    
trucos:
        ld a,$ff
        ld (tecla),a
        ld ix,jug1
        call .0
        ld ix,jug2
.0:     xor a
        ld (ix+d_puntos),a
        ld (ix+d_puntos+1),a
        ld (ix+d_puntos+2),a
        jp actualiza_indicadores
    endif

        ;
        ; Trucos para Zombie Near
        ; 1 - Velocidad de jugadores al doble
        ; 2 - Llave para ambos
        ; 3 - Energ¡a al m ximo
        ; 4 - Pasa a siguiente mapa
        ; 5 - Pasa a siguiente piso
        ;

        ;
        ; Seudodecodificaci¢n del teclado
        ;
decodifica:
        out (KEYSEL),a
        ex (sp),hl
        ex (sp),hl
        in a,(JOY1)
        and $0f
        cp $0f
        jr nz,.6
        in a,(JOY2)
        and $0f
.6:     ld hl,tabla_teclado
        add a,l
        ld l,a
        ld a,h
        adc a,0
        ld h,a
        ld a,(hl)
        cp $ff
        jr nz,.7
        ld (tecla),a
        ld hl,conteo
        ld a,(hl)
        or a
        ret z
        dec (hl)
        ret

.7:     ld c,a
        ld a,(conteo)
        or a
        ld a,3
        ld (conteo),a
        ret nz          ; ¨Antirebote listo?, no retorna
        ld a,c
        ld (tecla),a    ; Anota nueva tecla con antirebote
        ret

tabla_teclado:
        db $ff,$08,$04,$05,$12,$07,$10,$02
        db $13,$11,$00,$09,$03,$01,$06,$ff

        ;
        ; Checa si se oprimi¢ F1 para hacer pausa
        ; Checa si se oprimi¢ F2 para activar/desactivar sonido
        ;
checa_pausa:
        call decodifica
    if programador=1
        ld a,(tecla)
        cp $01          ; 1 - Vestidos de negro
        jp z,truquitos_1
        ld a,(ganado)
        bit 4,a         ; ¨Llave activada?
        jr z,.2
        ld a,(tecla)
        cp $02          ; 2 - Energ¡a
        jp z,truquitos_3
        cp $03          ; 3 - Llave
        jp z,truquitos_2
        cp $07          ; 7 - Siguiente mapa
        jp z,truquitos_4
        cp $09          ; 9 - Siguiente habitaci¢n
        jp z,truquitos_5
        cp $05          ; 5 - Beso
        jp z,truquitos_6
    endif
.2:
        ld a,(tecla)
        cp $10          ; ¨S¡mbolo de n£mero?
        jp nz,.0
        ld a,(modo)
        xor $10         ; Activa/desactiva sonido
        ld (modo),a
        ld a,$ff
        ld (tecla),a
.0:
        cp $11          ; ¨Asterisco?
        ret nz          ; ¨Oprimido?, no, retorna
        ld a,$ff
        ld (tecla),a
        ld hl,modo
        set 1,(hl)      ; Desactiva sonido
        ;
        ; Salva contenido de pantalla oculta
        ;
        rst $28 ; zona_dura
        ld hl,$3800+$016c
        ld b,7
.4:     call RDVRM
        push af
        inc hl
        djnz .4
        call zona_facil
        ;
        ; Antirebote
        ;
        call pausa_1
        ld b,10
.1:     halt
        call decodifica
        djnz .1
        ;
        ; Lazo principal de pausa
        ;
.3:     ld a,(ticks)
        and $10
        call pausa_1
        halt
        call decodifica
        ld a,(tecla)
        cp $11          ; ¨Asterisco oprimido?
        jr nz,.3        ; No, sigue esperando
        ld a,$ff
        ld (tecla),a
        ;
        ; Restaura pantalla
        ;
        rst $28 ; zona_dura
        ld hl,$3800+$0172
        ld b,7
.5:     pop af
        rst $08 ; WRTVRM
        dec hl
        djnz .5
        call zona_facil
        ;
        ; Antirebote
        ;
        ld b,10
.9:     halt
        call decodifica
        djnz .9
        ld hl,modo
        res 1,(hl)      ; Reactiva sonido
        ret

pausa_1:
        ld hl,$3800+$016c
        jr z,pausa_2
        rst $28 ; zona_dura
        rst $30
        db $00,$10,$01,$15,$13,$05,$00,$ff
        jp zona_facil

pausa_2:
        rst $28 ; zona_dura
        rst $30
        db $00,$00,$00,$00,$00,$00,$00,$ff
        jp zona_facil

        ;
        ; Carga un nivel
        ;
carga_nivel:
        xor a           ; No hay transportador
        ld (ix+d_trans),a
        ld (ix+d_trans+1),a
        ;
        ; Limpia la tabla de monigotes correspondiente
        ;
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,MAX_MONIGOTES*16
        xor a
.3:     ld (hl),a
        inc hl
        djnz .3
        ;
        ; Busca el nivel
        ;
        ld a,(sprites_especiales+1)
        ld b,a
        ld a,(ix+d_seccion)
        and $30
        ld de,reemplazo_mapa1
        ld hl,mapa1
        jr z,.4
        srl b
        srl b
        ld de,reemplazo_mapa2
        ld hl,mapa2
        cp $10
        jr z,.4
        srl b
        srl b
        ld de,reemplazo_mapa3
        ld hl,mapa3
        cp $20
        jr z,.4
        srl b
        srl b
        ld de,reemplazo_mapa4
        ld hl,mapa4
.4:     

        ;
        ; Selecciona slot ROM y copia a RAM
        ;
        ld a,(ix+d_nivel)
        call indice_nivel
        ld e,(ix+d_real)
        ld d,(ix+d_real+1)
        push de
        call descompacta_nivel
        pop hl
        ;
        ; Dibuja en pantalla oculta
        ;
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld c,6
.1:     push de
        ld b,12
.2:     push bc
        ld a,(hl)               ; Casilla del mapa
        cp 98
        call z,estima_cuadro
        cp 97
        call z,anota_transportador
        cp 90
        call nc,agrega_monigote
        cp 84
        call nc,agrega_adorno
        cp 79
        call nc,agrega_monigote
        cp 78
        call nc,agrega_adorno
        cp 72
        call nc,agrega_monigote
        cp 67
        call nc,agrega_adorno
        cp 61
        call z,agrega_monigote
        cp 52
        jp nc,$+8
        cp 50
        call nc,mosaico_especial
        ex de,hl
        call dibuja_mosaico
        ex de,hl
        pop bc
        inc hl
        djnz .2
        pop de
        push bc
        ld bc,64
        ex de,hl
        add hl,bc
        ex de,hl
        pop bc
        dec c
        jp nz,.1
        ret

        ;
        ; Dibuja un mosaico gr fico
        ;
        ; Entrada: A = N£mero de mosaico
        ;          HL = Apuntador a buffer de pantalla
        ;
        ; Modifica: A = Borrado
        ;           HL = Desplazado 2 caracteres a la derecha
        ;
dibuja_mosaico:
        push bc
        push de
        ;
        ; Mosaicos recuperados
        ;
        cp 5
        jr c,.12
        cp 9
        jr c,.13
.12:    cp 16
        jr c,.14
        cp 20
        jr c,.15
.14:    cp 52
        jp c,.19
        sub 32
.15:    sub 7
.13:    sub 5
        add a,a
        add a,a
        ld c,a
        ld b,0
        push hl
        ld hl,.10
        add hl,bc
        ld d,(hl)
        inc hl
        ld e,(hl)
        inc hl
        ld b,(hl)
        inc hl
        ld c,(hl)
        pop hl
        jp .3

.10:
        ; 5 - Pared 1, uni¢n norte con oeste
        db BASE_MOS+20,BASE_MOS+4
        db BASE_MOS+8,BASE_MOS+23
        ; 6 - Pared 1, uni¢n norte con este
        db BASE_MOS+4,BASE_MOS+25
        db BASE_MOS+26,BASE_MOS+13
        ; 7 - Pared 1, uni¢n sur con oeste
        db BASE_MOS+8,BASE_MOS+29
        db BASE_MOS+30,BASE_MOS+18
        ; 8 - Pared 1, uni¢n sur con este
        db BASE_MOS+32,BASE_MOS+33
        db BASE_MOS+18,BASE_MOS+35
        ; 16 - Pared 2, uni¢n norte con oeste
        db BASE_MOS+64,BASE_MOS+48
        db BASE_MOS+52,BASE_MOS+67
        ; 17 - Pared 2, uni¢n norte con este
        db BASE_MOS+48,BASE_MOS+69
        db BASE_MOS+70,BASE_MOS+57
        ; 18 - Pared 2, uni¢n sur con oeste
        db BASE_MOS+52,BASE_MOS+73
        db BASE_MOS+74,BASE_MOS+62
        ; 19 - Pared 2, uni¢n sur con este
        db BASE_MOS+76,BASE_MOS+57
        db BASE_MOS+62,BASE_MOS+79
        ; 52 - Escritorio con taza y dona
        db BASE_MOS+1,BASE_MOS+3
        db BASE_MOS+5,BASE_MOS+7
        ; 53 - Piso con s¡mbolo de biopeligro
        db BASE_MOS+10,BASE_MOS+11
        db BASE_MOS+14,BASE_MOS+15
        ; 54 - Computadora con pantalla verde
        db BASE_MOS+96,BASE_MOS+17
        db BASE_MOS+98,BASE_MOS+99
        ; 55 - Maceta con flores
        db BASE_MOS+145,BASE_MOS+147
        db BASE_MOS+149,BASE_MOS+151
        ; 56 - Pared 1 norte con ventila
        db BASE_MOS+4,BASE_MOS+4
        db BASE_MOS+19,BASE_MOS+6
        ; 57 - Pared 1 norte con pizarr¢n
        db BASE_MOS+4,BASE_MOS+4
        db BASE_MOS+21,BASE_MOS+6
        ; 58 - Caja de cart¢n (2)
        db BASE_MOS+173,BASE_MOS+22
        db BASE_MOS+24,BASE_MOS+27
        ; 59 - Piso vertical (1)
        db BASE_MOS+31,BASE_MOS+28
        db BASE_MOS+28,BASE_MOS+31
        ; 60 - Piso vertical (2)
        db BASE_MOS+28,BASE_MOS+31
        db BASE_MOS+31,BASE_MOS+28
        ; 61 - M quina l ser (1)
        db BASE_MOS+49,BASE_MOS+51
        db BASE_MOS+54,BASE_MOS+55
        ; 62 - M quina l ser (2)
        db BASE_MOS+58,BASE_MOS+59
        db BASE_MOS+61,BASE_MOS+63
        ; 63 - M quina l ser (3)
        db BASE_MOS+65,BASE_MOS+66
        db BASE_MOS+68,BASE_MOS+71
        ; 64 - M quina l ser (4)
        db BASE_MOS+72,BASE_MOS+75
        db BASE_MOS+77,BASE_MOS+78
        ; 65 - Monumento al C (1)
        db BASE_MOS+153,BASE_MOS+155
        db BASE_MOS+157,BASE_MOS+159
        ; 66 - Monumento al C (2)
        db BASE_MOS+34,BASE_MOS+196
        db BASE_MOS+197,BASE_MOS+198

.19:    add a,a
        add a,a
        add a,BASE_MOS
        ld d,a
        ;
        ; Mosaicos con caracteres duplicados del lado derecho
        ;
        cp 2*4+BASE_MOS
        jr c,.0
        cp 12*4+BASE_MOS
        jr z,.0
        cp 15*4+BASE_MOS
        jr z,.0
        cp 4*4+BASE_MOS
        jr z,.0
        ;
        ; Mosaicos con caracteres duplicados del lado de abajo
        ;
        jr c,.4
        cp 13*4+BASE_MOS
        jr z,.4
        cp 14*4+BASE_MOS
        jr z,.4
        cp 40*4+BASE_MOS
        jr nc,.7
        cp 36*4+BASE_MOS
        jr nc,.0
.7:

        inc a
        ld e,a
        inc a
        ld b,a
        inc a
        jr .9

.4:     inc a
        ld e,a
        ld b,d
        jr .9
       
.0:     ld e,a
        inc a
        inc a
        ld b,a
.9:     ld c,a
       
.3:
        rst $28 ; zona_dura
        ld a,d
        rst $08     
        inc hl
        ld a,e
        rst $08
        ld de,31
        add hl,de
        ld a,b
        rst $08
        inc hl
        ld a,c  
        rst $08
        call zona_facil
.2:     ld de,-31
        add hl,de
        pop de
        pop bc
        ret

        ;
        ; Mosaico especial
        ;
mosaico_especial:
        cp 50
        ld a,4          ; Pared sur 1
        ret z
        ld a,15         ; Pared sur 2
        ret

        ;
        ; Anota un transportador
        ;
anota_transportador:
        ld (ix+d_trans),e
        ld (ix+d_trans+1),d
        jp estima_cuadro

        ;
        ; Agrega un adorno
        ;
agrega_adorno:
        push bc
        push de
        push hl
        push af
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16*(MAX_MONIGOTES-1) ; Empieza por el final para...
                                   ; ...que queden debajo de todo lo dem s
        add hl,de
        ; Busca una entrada libre
.1:     ld a,(hl)
        or a
        jr z,agrega_objeto
        ld de,-16
        add hl,de
        jr .1

        ;
        ; Agrega un monigote
        ;
agrega_monigote:
        push bc
        push de
        push hl
        push af
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16        ; Primera entrada reservada para bala
        add hl,de
        ; Busca una entrada libre
.1:     ld a,(hl)
        or a
        jr z,agrega_objeto
        add hl,de
        jr .1

        ;
        ; Deriva coordenadas X,Y
        ;
agrega_objeto:
        ld a,12
        sub b
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,6
        sub c
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refy)
        ld (hl),a
        inc hl
        pop af
        cp 61
        jp z,laser
        push hl
        sub 69
        ld hl,tabla_monigotes
        add a,a
        ld e,a          ; Usado por huevos de pascua
        add a,l
        ld l,a
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ex (sp),hl
        ret

        ;
        ; Ubica disparo l ser
        ;
laser:  dec hl
        dec hl
        ld a,(hl)
        sub 7
        ld (hl),a
        inc hl
        ld a,(hl)
        add a,11
        ld (hl),a
        inc hl
        ld a,$08
        ld de,$0000
        ld bc,$010f
        ex af,af'
        ld a,15         ; Iba a ser 13 (morado), pero no se ve
        ex af,af'
        jp anota_monigote

pascua:
        ld a,$bc
        ex af,af'
        ld a,15
        ex af,af'
        ld de,0
        ld bc,$0311
        jp anota_monigote

adorno:
        ex af,af'
        ld de,$0000
        ld bc,$0105
        jp anota_monigote

jefe:
        ld a,$90
        jr personaje

chica:
        ld a,$8c
personaje:
        set 3,(ix+d_objeto)     ; Inicia secuencia autom tica
        ld de,$0000
        ld bc,$0105
        ex af,af'
        ld a,15
        ex af,af'
        jp anota_monigote

entrada1:
        ld a,20 ; Puerta oeste
entrada_general:
        push af
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        ld hl,300
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        call musica_esperando
        pop af
        pop hl
        pop de
        pop bc
        ret

entrada2:
        ld a,40 ; Puerta sur
        jr entrada_general
               
entrada3:
        ld a,21 ; Puerta norte
        jr entrada_general
               
nada:
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        pop hl
        pop de
        pop bc
        jp estima_cuadro

        ;
        ; Detecta si un objeto ya fue tomado/destruido
        ; IX = Ap. a jugador (usa d_nivel y d_mapa)
        ; A = Mascara
        ;
objeto_tomado:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        srl b
        rr c
        jr nc,.1
        rlca
        rlca
        rlca
        rlca
.1:     add hl,bc
        and (hl)                ; ¨Ya tomada?
        ex de,hl
        ld d,b
        ld e,b
        ret

        ;
        ; Borra un objeto del mapa
        ; IY = Ap. a jugador (usa d_nivel y d_mapa)
        ; A = Mascara
        ;
        ; Devuelve D = 0
        ;
objeto_borra:
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        srl d
        rr e
        jr nc,.2
        rlca
        rlca
        rlca
        rlca
.2:     add hl,de
        or (hl)
        ld (hl),a               ; Ya no aparece m s
        ret

        ;
        ; Finaliza un monigote
        ;
finaliza_monigote:
        inc hl
        inc hl
        inc hl
        ld a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,(ix+d_refy)
        ld (hl),a
        ret

vida:
        ld a,2
        call objeto_tomado
        jp nz,nada      ; S¡, ya no aparece
        ld a,$3c
        ld bc,$010b
        ex af,af'
        ld a,9
        ex af,af'
        jp anota_monigote

llave:
        ld a,4
        call objeto_tomado
        jp nz,nada      ; S¡, ya no aparece
        ld a,$10
        ld bc,$0107
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

cientifica:
        nop             ; Importante, vea abajo
cientifico:
        ex af,af'
        ld a,1
        call objeto_tomado
        jp nz,nada      ; S¡, ya no aparece
        ex af,af'
        ld bc,$0306
        cp cientifica and 255 ; Queda la parte baja de la direcci¢n en A
        jr z,.1
        ld a,15
        ex af,af'
        ld a,$30
        jp anota_monigote

.1:
        ld a,11
        ex af,af'
        ld a,$80
        jp anota_monigote

mancha:
        ld a,$14
        ex af,af'
        ld a,6
        jp adorno

esqueleto:
        ld a,$18
        ex af,af'
        ld a,15
        jp adorno

mano_suelta:
        ld a,$1c
        ex af,af'
        ld a,15
        jp adorno
               
        ;
        ; Un zombie tipo 4 es un zombie tipo 3 con posici¢n fija que
        ; se activa despu‚s de un tiempo, es un poco m s lento para
        ; perseguir al jugador.
        ;
zombie4:
        ld a,$94
        ld de,$0000
        ld bc,$0203
        ex af,af'
        ld a,15         ; Iba a ser 13 (morado), pero no se ve
        ex af,af'
        jp anota_monigote

zombie1_arr:
        ld a,$70
        ld de,$ff00
        jr zombie1

zombie1_aba:
        ld a,$60
        ld de,$0100
        jr zombie1

zombie5_izq:
        ld a,$6c
        ld de,$00ff
        jr zombie5

zombie5_der:
        ld a,$b4
        ld de,$0001
zombie5:
        ld bc,$0201
        ex af,af'
        ld a,15
        ex af,af'
        jr anota_monigote

zombie1_izq:
        ld a,$50
        ld de,$00ff
        jr zombie1

zombie1_der:
        ld a,$40
        ld de,$0001
zombie1:
        ld bc,$0301
        ex af,af'
        ld a,3
        ex af,af'
        jr anota_monigote

zombie2_izq:
        ld a,$50
        ld de,$00ff
        jr zombie2

zombie2_der:
        ld a,$40
        ld de,$0001
        jr zombie2

zombie2_arr:
        ld a,$70
        ld de,$ff00
        jr zombie2

zombie2_aba:
        ld a,$60
        ld de,$0100
zombie2:
        ld bc,$0202
        ex af,af'
        ld a,11
        ex af,af'
        jr anota_monigote

zombie3_izq:
        ld a,$50
        ld de,$00ff
        jr zombie3

zombie3_der:
        ld a,$40
        ld de,$0001
        jr zombie3

zombie3_arr:
        ld a,$70
        ld de,$ff00
        jr zombie3

zombie3_aba:
        ld a,$60
        ld de,$0100
zombie3:
        ld bc,$0103
        ex af,af'
        ld a,1
        ex af,af'
;       jp anota_monigote

anota_monigote:
        ld (hl),a       ; Sprite
        inc hl
        ex af,af'
        ld (hl),a       ; Color
        ex af,af'
        inc hl
        ld (hl),e       ; Dir. X
        inc hl
        ld (hl),d       ; Dir. Y
        inc hl
        ld (hl),b       ; Velocidad
        inc hl
        ld a,c
        inc a
        ld (hl),a       ; Energ¡a (2, 3 y 4 por tipo de monstruo)
        inc hl
        ld (hl),b       ; Paso actual (copia de velocidad)
        inc hl
        ld (hl),c       ; Tipo de monigote
        inc hl
        xor a
        ld (hl),a       ; Ultimo movimiento
        inc hl
        ld (hl),a
        call finaliza_monigote
        pop hl
        pop de
        pop bc
        ld a,(hl)
        cp 61           ; L ser
        ret z
        ;
        ; No es posible poner fondo en el mismo cuadro cuando se escoge
        ; un objeto, adorno o monigote, as¡ que lo deriva de los
        ; alrededores
        ;
estima_cuadro:
        push de
        ld a,c
        cp 6
        jr z,.1
        push hl
        ld de,-12
        add hl,de
        ld e,(hl)
        rst $38 ; checa_camino
        rrca
        ld a,e
        pop hl
        jr c,.5
.1:     ld a,b
        cp 12
        jr z,.2
        push hl
        dec hl
        ld e,(hl)
        rst $38 ; checa_camino
        rrca
        ld a,e
        pop hl
        jr c,.5
.2:     ld a,b
        cp 1
        jr z,.3
        push hl
        inc hl
        ld e,(hl)
        rst $38 ; checa_camino
        rrca
        ld a,e
        pop hl
        jr c,.5
.3:     ld a,c
        cp 1
        jr z,.4
        push hl
        ld de,12
        add hl,de
        ld e,(hl)
        rst $38 ; checa_camino
        rrca
        ld a,e
        pop hl
        jr c,.5
.4:     xor a
.5:     pop de
        ret
        
        ;
        ; Carga nivel y actualiza los indicadores
        ;
actualiza_indicadores_nivel:        
        ld a,(ix+d_vidas)
        inc a   ; cp -1
        call nz,carga_nivel
        ;
        ; Actualiza los indicadores
        ;
actualiza_indicadores:
        ld a,(ix+d_vidas)
        inc a           ; ¨Muerto?
        ret z           ; S¡, retorna.
        bit 7,(ix+d_objeto)     ; ¨Triunfo?
        ret nz          ; S¡, retorna.
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        ret nz          ; S¡, retorna.
        ld l,(ix+d_offset)
        ld h,(ix+d_offset+1)
        ld a,(ix+d_refy)
        or a
        ld de,32-8      ; Zona de indicadores del jugador 1
        jr nz,.1
        ld e,25+32      ; Zona de indicadores del jugador 2
.1:     add hl,de
        ;
        ; Visualiza la puntuaci¢n actual
        ;
        inc hl
        inc hl
        ld a,(ix+d_refy)
        or a
        ld a,$2B        ; 1
        jr z,.2
        ld a,$2C        ; 2
.2:
        rst $28 ; zona_dura
        rst $08     
        inc hl
        rst $30
        db $15,$10,$ff  ; UP
        ld de,27
        add hl,de
        ld a,(ix+d_puntos)
        call dos_digitos
        ld a,(ix+d_puntos+1)
        call dos_digitos
        ld a,(ix+d_puntos+2)
        call dos_digitos
        ld a,$20
        rst $08     ; Un cero de relleno
        ld de,58        ; Separa una l¡nea
        add hl,de
        ;
        ; Visualiza la energ¡a actual
        ;
        rst $30
        db $05,$0e,$05,$12,$07,$19,$ff
        ld de,26
        add hl,de
        ld a,(ix+d_energia)
        or a
        ld b,a
        ld a,$1c
        jr z,.3
        dec a
.3:     rst $08
        inc hl
        ld c,1
.4:     inc c
        ld a,b
        cp c
        ld a,$1e
        jr c,.5
        dec a
.5:     rst $08
        inc hl
        ld a,c
        cp 6
        jr nz,.4
        ld a,$1f
        rst $08
        ld de,58        ; Separa una l¡nea
        add hl,de
        ;
        ; Visualiza el piso actual
        ;
        inc hl
        rst $30
        db $06,$0c,$0f,$0f,$12,$ff
        ld de,26
        add hl,de
        inc hl
        ld a,(ix+d_refy)
        or a
        ld a,$32        ; A
        jr z,.7
        inc a           ; B
.7:     rst $08
        inc hl
        ld a,$34
        rst $08
        inc hl
        ld a,(ix+d_seccion)
        rrca
        rrca
        rrca
        rrca
        and $03
        ld d,a
        ld a,(ix+d_nivel)
        inc a
        add a,d
        add a,d
        ld b,100
        push af
        ld a,$1f
        add a,d
        ld c,a
        pop af
        call digito_decimal+2
        ld b,10
        call digito_decimal
        ld b,1
        call digito_decimal
        ld de,59        ; Separa una l¡nea
        add hl,de
        ;
        ; Indica el n£mero de vidas y muestra la llave (si la trae)
        ;
        ld a,(ix+d_vidas)
        cp 10
        jr nc,.11
        add a,$20
        rst $08
        xor a
        jr .12

.11:    ld b,$1f
.13:    inc b
        sub 10
        jr nc,.13
        add a,10+$20
        push af
        ld a,b
        rst $08
        pop af
.12:    inc hl
        rst $08
        inc hl
        ld a,$2a
        rst $08
        inc hl
        inc hl
        xor a
        bit 0,(ix+d_objeto)
        jr z,$+4
        ld a,$2d
        rst $08
        jp zona_facil

        ;
        ; Digito decimal
        ;
digito_decimal:
        ld c,$1f
.1:     inc c
        sub b
        jr nc,.1
        add a,b
        push af
        ld a,c
        rst $08
        pop af
        inc hl
        ret

        ;
        ; Dibuja dos digitos
        ;
dos_digitos:
        push af
        rrca
        rrca
        rrca
        rrca
        call un_digito
        pop af
un_digito:
        and $0f
        add a,$20
        rst $08
        inc hl
        ret

        ;
        ; Dibuja dos digitos, incluye soporte hexadecimal
        ; porque sirve para mostrar checksum.
        ;
dos_digitos2:
        ld a,(de)
        inc de
        push af
        rrca
        rrca
        rrca
        rrca
        call un_digito2
        pop af
un_digito2:
        and $0f
        cp $0a
        jr c,$+4
        sub a,$29
        add a,$20
        ld (hl),a
        inc hl
        ret

        ;
        ; Actualiza los sprites
        ;
actualiza_sprites:
        ;
        ; Jugador 1
        ;
        ld de,sprites
        ld bc,sprites+16        ; Offset monigotes
        ld ix,jug1
        ld l,(ix+d_sprite)
        ld h,0
        ld a,l
        ld (sprites_especiales+0),a
        ld (ix+d_sprite),0      ; Usa sprite definido
        push hl
        call actualiza_jugador
        pop hl
        ld (ix+d_sprite),l
        ;
        ; Jugador 2
        ;
        ld de,sprites+8
        ld bc,sprites+64        ; Offset monigotes
        ld ix,jug2
        ld l,(ix+d_sprite)
        ld h,0
        ld a,l
        ld (sprites_especiales+2),a
        ld (ix+d_sprite),4      ; Usa sprite definido
        push hl
        call actualiza_jugador
        pop hl
        ld (ix+d_sprite),l
        ret

        ;
        ; Dado un c¢digo de sprite de un jugador, indexa sprite de carita
        ;
sprite_carita:
        db $b0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
        db $b0,$c4,$c0,$c4,$c0,$c4,$c0,$c4
        db $b0,$c8,$b0,$c8,$b0,$c8,$b0,$c8
        db $c0,$cc,$c0,$cc,$c0,$cc,$c0,$cc
        db $b0,$d0,$c0,$d0,$c0,$d0,$c0,$d0
        db $b0,$d4,$c0,$d4,$c0,$d4,$c0,$d4
        db $b0,$d8,$b0,$d8,$b0,$d8,$b0,$d8
        db $a0,$dc,$a0,$dc,$a0,$dc,$a0,$dc
        db $00,$00,$00,$00,$c1,$c0,$c1,$d0

        ;
        ; Actualiza el sprite de un jugador
        ;
actualiza_jugador:
        bit 6,(ix+d_objeto)     ; ¨No existe?
        ret nz
        ;
        ; Actualiza la animaci¢n del transportador
        ; lo hace incluso si el jugador est  muerto,
        ; pero no lo hace si ya gan¢ el juego o est  en historia.
        ;
        bit 7,(ix+d_objeto)     ; ¨Victoria?
        jp nz,.9        ; S¡, no actualiza y de una vez desaparece jugador
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        jp nz,.9        ; S¡, no actualiza y de una vez desaparece jugador
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        jr z,.7
        ld a,(ticks)
        and $0c         ; No debe ser m s r pido o no se notar  cambio.
        srl a
        srl a
        add a,36
        call dibuja_mosaico
        ;
        ; Actualiza el sprite correspondiente al jugador
        ;
.7:
        ; Ya comprobado antes
        bit 5,(ix+d_objeto)     ; ¨Muerto?
        jp nz,.9        ; S¡, no actualiza y de una vez desaparece jugador
;        ld a,(ix+d_estado)
;        or a                    ; ¨En historia?
;        jp nz,.9                ; S¡, desaparece
;        bit 7,(ix+d_objeto)     ; ¨Triunfo?
;        jp nz,.9
        ld a,(ix+d_vidas)
        inc a ; cp $ff           ; ¨Muerto?
        jr nz,.1
.9:     ld a,$d1
        ld (de),a
        inc de
        inc de
        inc de
        inc de
        ld (de),a
        jp .2

.1:     ld a,(ix+d_y)
        dec a
        ld (de),a
        inc de
        ld a,(ix+d_x)
        ld (de),a
        inc de
        ld a,(ix+d_sprite)
        ld (de),a
        inc de
        ld a,(ix+d_espera)
        and 8
        ld a,(ix+d_color)
        jr z,.6
        ld a,$0f
.6:     ld (de),a
        inc de
        ;
        ; Le pone su carita
        ;
        ld a,(ix+d_refx)
        or a
        ld a,(sprites_especiales+0)
        jr z,.16
        ld a,(sprites_especiales+2)
.16:    srl a
        ld hl,sprite_carita
        add a,l
        ld l,a
        ld a,h
        adc a,0
        ld h,a
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        and $f0
        rrca
        rrca
        rrca
        rrca
        neg
        dec a
        add a,(ix+d_y)
        ld (de),a
        inc de
        ld a,l
        and 1
        neg
        add a,(ix+d_x)
        ld (de),a
        inc de
        ld a,h
        ld (de),a
        inc de
        ld a,10
        ld (de),a
        inc de
        ;
        ; Actualiza sprites de monigotes/adornos/objetos
        ;
.2:     ld d,b
        ld e,c
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,MAX_MONIGOTES
.3:     push bc
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        jr nz,.13       ; S¡, no actualiza
        push hl
        ld a,l
        add a,d_tipo    ; Tipo de monigote
        ld l,a
        ld a,h
        adc a,0
        ld h,a
        ld a,(hl)       ; Obtiene
        ld c,a
        pop hl
        or a            ; ¨Hay algo?
        jr nz,.4        ; S¡, salta.
.13:    ld a,$d1
        ld (de),a
        inc de
        inc de
        inc de
        inc de
        ld bc,16
        jp .12

.4:     ld c,5          ; Desplazamiento sprite bala/explosi¢n.
        cp 8
        jr z,.8
        cp 9
        jr z,.8
        ld c,-1         ; Desplazamiento sprite com£n
        cp 4            ; ¨Jefe zombie?
        jr nz,.8
        inc hl
        inc hl
        ld a,(ix+d_refx)
        or a
        ld a,(hl)
        push hl
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        jp nz,.11
        ld (sprites_especiales+4),hl
        pop hl           
        ex af,af'
        ld a,$e0        ; Sprite definido 1
        jp .10

.11:    ld (sprites_especiales+6),hl
        pop hl
        ex af,af'
        ld a,$f0        ; Sprite definido 2
.10:    ex af,af'
        cp 64           ; ¨Jefe 3?
        jr c,.14
        ld c,a
        ld a,(ix+d_seccion)
        cpl
        and $30         ; ¨Mapa 4?
        ld a,c
        jr nz,.14       ; No, salta.
        add a,32        ; S¡, otro esquema de color
.14:    rrca
        rrca
        and $fc
        add a,color_jefes and 255
        ld c,a
        ld a,color_jefes>>8
        adc a,0
        ld b,a
        dec hl
        dec hl
        ld a,(hl)
        inc de
        ld (de),a
        ld a,-1
        call comun_sprite_jefe
        ;
        ; Segundo cuadro en X+16,Y
        ;
        add a,16
        inc de
        ld (de),a
        ld a,-1
        call comun_sprite_jefe
        ;
        ; Tercer cuadro en X,Y+16
        ;
        inc de
        ld (de),a
        ld a,15
        call comun_sprite_jefe
        ;
        ; Cuarto cuadro en X+16,Y+16
        ;
        add a,16
        inc de
        ld (de),a
        ld a,15
        call comun_sprite_jefe
        ld bc,16
        jr .12

.8:     ld a,(hl)
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        add a,c
        ld (de),a
        inc de
        inc de
        inc hl
        ldi
        ldi
        ld bc,12
.12:    add hl,bc
.5:     pop bc
        dec b
        jp nz,.3
        ret

comun_sprite_jefe:
        dec de
        inc hl
        add a,(hl)
        dec hl
        ld (de),a
        inc de
        inc de
        ex af,af'
        ld (de),a
        add a,4
        ex af,af'
        inc de
        ld a,(bc)
        ld (de),a
        inc bc
        inc de
        ld a,(hl)
        ret

        ;
        ; Colores de los jefes
        ;
color_jefes:
        ; Jefe zombie izq. (gen‚rico)
        db 15,15,15,15
        ; Jefe zombie der. (gen‚rico)
        db 15,15,15,15
        ; Chica zombie izq. (mapa 2)
        db 11,10,10,10
        ; Chica zombie der. (mapa 2)
        db 10,11,10,10
        ; Superjefe izq. (mapa 3)
        db 3,2,8,2
        ; Superjefe der. (mapa 3)
        db 2,3,2,8
        ; Superjefe izq. (mapa 4)
        db 15,3,9,3
        ; Superjefe der. (mapa 4)
        db 3,15,3,9

reemplazo_mapa1:
        db 9,23,45,88

reemplazo_mapa2:
        db 5,22,28,24

reemplazo_mapa3:
        db 84,91,93,55

reemplazo_mapa4:
        db 4,24,5,18

        ;
        ; Indice en el nivel
        ; A = Habitaci¢n desde 0
        ; HL = Apuntador a mapa
        ; DE = Reemplazo de habitaciones
        ; B = Indicaci¢n de reemplazo
        ;
indice_nivel:
        ; El primer bit controla el reemplazo de dos habitaciones
        bit 0,b
        jr z,.2
        ex de,hl
        cp (hl)
        ex de,hl
        jr nz,.3
        ld a,102
        jr .2

.3:     ex de,hl
        inc hl
        cp (hl)
        dec hl
        ex de,hl
        jr nz,.2
        ld a,103

.2:     inc de
        inc de

        ; El segundo bit controla el reemplazo de otras dos habitaciones
        bit 1,b
        jr z,.5
        ex de,hl
        cp (hl)
        ex de,hl
        jr nz,.4
        ld a,104
        jr .5

.4:     ex de,hl
        inc hl
        cp (hl)
        ex de,hl
        jr nz,.5
        ld a,105

.5:     or a            ; ¨Habitaci¢n cero?
        ret z           ; Ya est  ah¡, retorna
        ld d,0
        ld b,a
        push hl
        ld hl,SLOT_1    ; Mapas
        call sel_slot
        pop hl
.1:     bit 7,(hl)      ; Brinca diccionario
        inc hl
        jp z,.1
        ld e,(hl)       ; Brinca compactado
        add hl,de
        djnz .1
        push hl
        call sel_slot0  ; Normal
        pop hl
        ret

        ;
        ; Lee un bit
        ;
lee_bit:
        rrc c
        jr nc,.1
        dec b
        jr z,.3
        inc hl
.1:     ld a,(hl)
        and c
        jr z,.2
        ex af,af'
        scf
        rla
        ex af,af'
        ret

.4:     db 0                    ; Garantiza que queda en $8000-$BFFF

.3:     ld hl,.4                ; Necesita un cero fijo para otros 8 bits
.2:     ex af,af'
        add a,a
        ex af,af'
        ret

        ;
        ; Descompacta un nivel
        ; El algoritmo es similar a la decodificaci¢n Huffman
        ;
descompacta_nivel:
        push hl
        ld hl,SLOT_1    ; Mapas
        call sel_slot
        pop hl
        push hl
        exx
        pop de
        exx
        ; Mide el diccionario
.1:     bit 7,(hl)
        inc hl
        jr z,.1
        ld bc,$ff01     ; Pone este valor para que salte byte de tama¤o
        rst $20 ; lee_bit
        dec hl          ; Retrocede para tener...
        ld a,l          ; ...tama¤o de diccionario en A
        ld b,(hl)       ; ...y tama¤o de datos compactados
        push bc
        push de
        push hl
        push af
        ld hl,mapa_ref1
        jr z,.2
        ld hl,mapa_ref2
.2:     ld bc,$06ff
.16:    ldi
        ld a,10
.17:    ldi
        dec hl
        dec a
        jr nz,.17
        inc hl
        ldi
        djnz .16
        pop af
        pop hl
        pop de
        pop bc
        inc hl          ; Adelanta otra vez a byte compactado
        dec b           ; Descuenta el byte de tama¤o
        exx
        sub e
        exx
        cp 9
        jp nc,.7

        ; Diccionario 8
.5:
        rst $20 ; lee_bit  0 - Sin cambio
        jr z,.6
        rst $20 ; lee_bit  100 - S¡mbolo 0
        rst $20 ; lee_bit  101 - S¡mbolo 1
        ex af,af'
        and 3
        cp 2
        jr c,.15
        ex af,af'
        rst $20 ; lee_bit  1100 - S¡mbolo 2
        ex af,af' ;        1101 - S¡mbolo 3
        and 3     ;        1110 - S¡mbolo 4
        add a,2  
        cp 5
        jr nz,.15
        rst $20 ; lee_bit  11110 - S¡mbolo 5
        ex af,af'
        and 1
        ld a,5
        jr z,.15
        rst $20 ; lee_bit  111110 - S¡mbolo 6
        ex af,af' ;        111111 - S¡mbolo 7
        and 1
        add a,6
.15:    exx
        ld l,a
        ld h,0
        add hl,de
        ld a,(hl)
        and $7f
        exx
        ld (de),a
.6:     inc de
        ld a,b
        or a
        jr nz,.5
        jp .11

        ; Diccionario 15
.7:
        rst $20 ; lee_bit  0 - Sin cambio
        jr z,.8
        rst $20 ; lee_bit  1xx - S¡mbolos 0-3
        jr nz,.9
        rst $20 ; lee_bit
        rst $20 ; lee_bit
        ex af,af'
        and 3
        jr .10

.9:
        rst $20 ; lee_bit  11xxx - S¡mbolos 4-10
        rst $20 ; lee_bit
        rst $20 ; lee_bit
        ex af,af'
        and 7
        add a,4
        cp 11
        jr nz,.10
        rst $20 ; lee_bit  11111xx - S¡mbolos 11-14
        rst $20 ; lee_bit
        ex af,af'
        and 3
        add a,11
.10:    exx
        ld l,a
        ld h,0
        add hl,de
        ld a,(hl)
        and $7f
        exx
        ld (de),a
.8:     inc de
        ld a,b
        or a
        jr nz,.7
        ;
        ; Usa un piso diferente para jefes m ximos de mapa 1, 2 y 4.
        ;
.11:    ld a,(ix+d_nivel)
        cp 100
        push hl
        call sel_slot0
        pop hl
        ret nz
        ld l,(ix+d_real)
        ld h,(ix+d_real+1)
        ld b,72
.12:    ld a,(hl)
        or a
        jr z,.13
        cp 9
        jr nz,.14
        ld (hl),60
        jr .14

.13:    ld (hl),59
.14:    inc hl
        djnz .12
        ret

mapa_ref1:
        db 5,1,6
        db 2,0,3
        db 2,0,3
        db 2,0,3
        db 2,0,3
        db 7,4,8

mapa_ref2:
        db 16,12,17
        db 13,10,14
        db 13,10,14
        db 13,10,14
        db 13,10,14
        db 18,15,19

        ;
        ; Valores iniciales
        ;
jug_fuera:              ; Invisible
        db $10,$10      ; Coordenada X,Y actual, cambiada al leer nivel
        db 0,0          ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw $3800        ; Ap. a pantalla 
        db 0,0          ; Base X,Y visual
        dw 0            ; Ap. a nivel cargado
        dw monigotes    ; Lista de monigotes
        db -1           ; Sin vidas
        db 0            ; Espera antes de recibir m s da¤o.
        db $10,$10      ; Coordenadas X,Y donde apareci¢
        db 0,0,0        ; Puntos en BCD (alto a bajo)
        db $40          ; Objetos (bit 0 = Llave)
        dw 0            ; Monitor para transportador
        dw 0            ; Tiempo para que aparezca gran jefe
        dw bits1        ; Mapa modificado
        db 0            ; Estado historia
        db 0            ; Cient¡ficos rescatados (BCD)
        db 0            ; Estado temblor
        db 0            ; Direcci¢n del temblor
        dw 0            ; Espacio para salvar l¡nea si hace temblor
        dw 0            ; Espacio para volver a poner puerta
        db 0            ; N£mero de mosaico de puerta
        db 0            ; Secci¢n.
        db 0            ; Tiempo para revivir.

jug1_inicial:           ; El chico
        db $01,$10      ; Coordenada X,Y actual, cambiada al leer nivel
        db 0,7          ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 1,6,1        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw $3800        ; Ap. a pantalla 
        db 0,0          ; Base X,Y visual
        dw nivel1       ; Ap. a nivel cargado
        dw monigotes    ; Lista de monigotes
        db 4            ; Cuatro vidas
        db 0            ; Espera antes de recibir m s da¤o.
        db $01,$10      ; Coordenadas X,Y donde apareci¢
        db 0,0,0        ; Puntos en BCD (alto a bajo)
        db 0            ; Objetos (bit 0 = Llave)
        dw 0            ; Monitor para transportador
        dw 0            ; Tiempo para que aparezca gran jefe
        dw bits1        ; Mapa modificado
        db 0            ; Estado historia
        db 0            ; Cient¡ficos rescatados (BCD)
        db 0            ; Estado temblor
        db 0            ; Direcci¢n del temblor
        dw 0
        dw 0            ; Espacio para volver a poner puerta
        db 0            ; N£mero de mosaico de puerta
        db 0            ; Secci¢n
        db 0            ; Tiempo para revivir.

jug2_inicial:           ; La chica
        db $41,$70      ; Coordenada X,Y actual, cambiada al leer nivel
        db 64,9         ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 1,6,1        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw $3800+392    ; Ap. a pantalla 
        db $40,$60      ; Base X,Y visual
        dw nivel2       ; Ap. a nivel cargado
        dw monigotes+MAX_MONIGOTES*16       ; Lista de monigotes
        db 4            ; Cuatro vidas
        db 0            ; Espera antes de recibir m s da¤o.
        db $41,$70      ; Coordenadas X,Y donde apareci¢
        db 0,0,0        ; Puntos en BCD (alto a bajo)
        db 0            ; Objetos (bit 0 = Llave)
        dw 0            ; Monitor para transportador
        dw 0            ; Tiempo para que aparezca gran jefe
        dw bits2        ; Mapa modificado
        db 0            ; Estado historia
        db 0            ; Cient¡ficos rescatados (BCD)
        db 0            ; Estado temblor
        db 0            ; Direcci¢n del temblor
        dw 0
        dw 0            ; Espacio para volver a poner puerta
        db 0            ; N£mero de mosaico de puerta
        db 0            ; Secci¢n.
        db 0            ; Tiempo para revivir.

        ;
        ; Otros m¢dulos tan grandes e importantes que merecen su
        ; propio archivo.
        ;
        include "sonido.asm"

        include "historia.asm"

        ;
        ; Los sprites bellamente dibujados :), incluyendo gr ficas de 8x8.
        ;
        include "sprites.asm"

        ;
        ; Banderas de mosaicos:
        ; bit 0 = 1 = Caminable
        ;     1 = 1 = Utilizable como fondo
        ;             Se usa por objetos para determinar de los alrededores
        ;             que fondo usar.
        ;
caminable:
        db $c0
        db $00
        db $3f
        db $00
        db $00
        db $00
        db $00
        db $00
        db $00
        db $00
        db $00
        db $00
        db $05
        db $10
        db $03
        db $c0
        db $00
        db $15
        db $51
        db $54
        db $55
        db $55
        db $55
        db $55
        db $05

        ; Gr ficas
        include "graficas.asm"

        ds $c000-$,$ff

        org $c000,$ffff
        forg $4000      ; SLOT_1
        include "mapas.asm"
GRAFICA_LOGO:           ; El logo de Zombie Near
        INCBIN "LOGO.DAT"
GRAFICA_PANEL_EN:       ; El panel de juego en ingl‚s
        INCBIN "PANELENG.DAT"
GRAFICA_TITULO_1:       ; El dibujo principal del t¡tulo
        INCBIN "TITULO1.DAT"
GRAFICA_TITULO_2:       ; Imagen alternativa de t¡tulo (ganando una vez)
        INCBIN "TITULO2.DAT"
GRAFICA_TITULO_3:       ; Imagen alternativa de t¡tulo (ganando 2 veces)
        INCBIN "TITULO3.DAT"
GRAFICA_COPYRIGHT:      ; El copyright
        INCBIN "COPYRIGH.DAT"
GRAFICA_COMPLEJO_EN:    ; Texto que dice "COMPLEX"
        INCBIN "COMPLENG.DAT"

        ds $10000-$,$ff

        org $c000,$ffff
        forg $8000      ; SLOT_2
GRAFICA_ALERTA_EN:      ; Letras "ALERT"
        INCBIN "ALERTA.DAT"
GRAFICA_EDIFICIO:       ; Imagen de los dos edificios
        INCBIN "EDIFICIO.DAT"
GRAFICA_FIN_EN:         ; THE END
        INCBIN "FIN.DAT"

        ;
        ; Animaci¢n de las aspas del helic¢ptero
        ;
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

        ; Investigadora con computadora
retrato_investigadora:
        incbin "retrato1.dat"

        ; Jefe
retrato_jefe:
        incbin "retrato2.dat"

        ; Telefonista
retrato_telefonista:
        incbin "retrato3.dat"

        ; Delta 1
retrato_delta_1:
        incbin "retrato4.dat"

        ; Delta 2
retrato_delta_2:
        incbin "retrato5.dat"

        ; Zombies (lado izq.)
retrato_zombies_1:
        incbin "retrato6.dat"

        ; Zombies (lado der.)
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

        ;
        ; Beso (lado izquierdo)
        ;
retrato_beso1:
        incbin "retrato14.dat"

        ;
        ; Beso (lado derecho)
        ;
retrato_beso2:
        incbin "retrato15.dat"

        ds $10000-$,$ff

        org $c000,$ffff
        forg $c000      ; SLOT_3

        ; M£sica
        include "musica.asm"

        ds $10000-$,$ff

        org $c000,$ffff
        forg $10000     ; SLOT_4

        ds $10000-$,$ff

        org $c000,$ffff
        forg $14000     ; SLOT_5
        ds $10000-$,$ff

        org $c000,$ffff
        forg $18000     ; SLOT_6
        ds $10000-$,$ff

        org $c000,$ffff
        forg $00000     ; SLOT_0

        ;   ddmmaa
        DB "Jul/11/2013 " 

        DB "ZOMBIE NEAR "
        DB "(c)2011 Oscar Toledo G.",0

        ;
        ; Maneja la entrada del usuario
        ;
maneja_entrada:
        ld a,(jug2+d_objeto)
        bit 6,a         ; ¨Jugador 2 activo?
        jr nz,.1        ; No, controla jugador 1
        ld a,(jug1+d_objeto)
        bit 6,a         ; ¨Jugador 1 activo?
        jr nz,.2        ; No, controla jugador 2
        call .2
        ; jp .1

        ;
        ; El jugador 1 con controlador 1
        ;
.1:     ld ix,jug1      ; Jugador 1
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(JOY1)     ; Lee para tener bot¢n 2
        ld b,a
        out (JOYSEL),a  ; Joystick
        ex (sp),hl
        ex (sp),hl
        in a,(JOY1)     ; Joystick 1
        push af
        and b
        cpl
        and $40
        call disparo
        pop af
        and $0f
        jp maneja_dir

        ;
        ; El jugador 2 con controlador 2
        ;
.2:     ld ix,jug2      ; Jugador 2
        out (KEYSEL),a  ; Teclado
        ex (sp),hl
        ex (sp),hl
        in a,(JOY2)     ; Lee para tener bot¢n 2
        ld b,a
        out (JOYSEL),a  ; Joystick
        ex (sp),hl
        ex (sp),hl
        in a,(JOY2)     ; Joystick 2
        push af
        and b
        cpl
        and $40
        call disparo
        pop af
        and $0f
        jp maneja_dir

        ;
        ; El jugador dispara
        ;
disparo:
        jr nz,.4        ; Salta si bot¢n oprimido
        ;
        ; El jugador solt¢ el bot¢n, entonces le permite volver
        ; a disparar, justo como una pistola.
        ;
        res 7,(ix+d_recarga)   
        ret

.4:     ld a,(ix+d_vidas)
        inc a ; cp $ff  ; ¨Muerto?
        ret z           ; S¡, ignora
        ld a,(ix+d_objeto)
        and $2c
        ret nz
;        bit 5,(ix+d_objeto)     ; ¨Muerto (temporalmente)?
;        ret nz                  ; S¡, ignora
;        bit 3,(ix+d_objeto)     ; ¨En secuencia autom tica 1?
;        ret nz                  ; S¡, ignora
;        bit 2,(ix+d_objeto)     ; ¨En secuencia autom tica 2?
;        ret nz                  ; S¡, ignora.
        ld a,(ix+d_estado)      ; ¨En historia?
        or (ix+d_recarga)       ; ¨Disparo listo (cuenta 0 y bot¢n suelto)?
        ret nz          ; No, ignora
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,9
        add hl,de
        ld a,(hl)       
        sbc hl,de       ; Siempre Carry es 0 (el add no provoca acarreo)
        or a            ; ¨A£n hay bala?
        ret nz          ; S¡, ignora disparo
        ld (ix+d_recarga),15+128
        ld a,(ix+d_sprite)
        and $30         ; ¨Mira a la derecha?
        ld de,$fe06
        ld bc,$0004
        jr z,.1
        cp $10          ; ¨Mira a la izquierda?
        ld de,$fefa
        ld c,$fc
        jr z,.1
        cp $30          ; ¨Mira arriba?
        ld de,$fa00
        ld bc,$fc00
        jr z,.1         ; o tal vez abajo.
        ld d,$03
        ld b,$04
.1:     ld a,(ix+d_sprite)
        and $3c
        jr z,.2
        cp $10
        jr nz,.3
.2:     inc d           ; Tiene la cabeza baja.
.3:     ld a,(ix+d_x)
        add a,e
        ld (hl),a
        inc hl
        ld a,(ix+d_y)
        add a,d
        ld (hl),a
        inc hl
        ld (hl),$08     ; d_sprite
        inc hl
        ld (hl),$0b     ; d_color
        inc hl
        ld (hl),c       ; d_dx
        inc hl
        ld (hl),b       ; d_dy
        inc hl
        ld (hl),1       ; d_velocidad
        inc hl
        inc hl
        ld (hl),1       ; d_paso
        inc hl
        ld (hl),8       ; d_tipo
        ld de,5
        add hl,de
        ld a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,(ix+d_refy)
        ld (hl),a
        jp efecto_disparo

        ;
        ; Mueve un jugador en una direcci¢n
        ;
maneja_dir:
        push af
        bit 3,(ix+d_objeto)     ; ¨Secuencia de encuentro?
        jp z,.1
        ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $50                  ; ¨Lleg¢ al punto?
        jp z,.3                 ; S¡, cambia a secuencia de espera
        cp $10                  ; ¨Atravesando la puerta?
        push af
        call c,abre_puerta      ; S¡, abre la puerta
        pop af
        call z,restaura_puerta  ; Termin¢, cierra la puerta
        pop af
        ld a,$0d                ; Marcha a la derecha
        push af
        jp .2

.3:     res 3,(ix+d_objeto)
        set 2,(ix+d_objeto)     ; Secuencia de espera
        ld (ix+d_tiempo),50
        ld (ix+d_tiempo+1),0
        ld a,(ix+d_refx)
        or a
        ld (ix+d_sprite),$88    ; Jugador 1 baja la pistola
        jp z,.1
        ld (ix+d_sprite),$8c    ; Jugador 2 baja la pistola
.1:     bit 2,(ix+d_objeto)     ; ¨Secuencia de espera?
        jp z,.2
        ld a,(ix+d_tiempo)
        dec a
        jp z,.4
        pop af
        ld a,$0f                ; Se queda quieto
        push af
        jp .2

        ;
        ; Comienza dialogo
        ; 
.4:     res 2,(ix+d_objeto)
        call musica_esperando
        ld a,(ix+d_seccion)
        and $30
        ld b,7                  ; Cuando la chica se hace zombie
        cp $10
        jr z,.5
        ld b,17                 ; Cuando se descubre el jefe malo
        cp $20
        jr z,.5
        ld b,29                 ; Cuando el jefe "vuelve"
.5:     ld a,b
        call inicia_historia
        pop af
        ret

.2:
maneja_dir_2:   ; Para tener m s etiquetas
        bit 1,(ix+d_objeto)     ; ¨Puerta por restaurar?
        call nz,restaura_puerta

        ;
        ; Cuenta el tiempo para revivir al jugador
        ;
        ld a,(ix+d_revivir)
        or a
        jr z,.18
        dec (ix+d_revivir)
        jr nz,.18
        res 5,(ix+d_objeto)
        call jugador_atrapado
.18:

        ;
        ; Cuenta el tiempo para que aparezca gran jefe o para
        ; que termine indicaci¢n de juego terminado.
        ;
        bit 5,(ix+d_objeto)     ; No cuenta mientras est‚ muerto
        jp nz,.9
        ld l,(ix+d_tiempo)
        ld h,(ix+d_tiempo+1)
        ld a,h
        or l
        jp z,.9
        dec hl
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        bit 7,(ix+d_objeto)     ; ¨Triunfo?
        jp nz,.9
        ld a,(ix+d_vidas)
        inc a ; cp $ff          ; ¨Muerto?
        jp z,.9
        ld a,h
        or l
        jp nz,.9
        bit 4,(ix+d_objeto)     ; ¨Lluvia de monstruos?
        jp nz,.20
        call musica_batalla
        ld a,(ix+d_nivel)
        cp 73                   ; ¨Mapa 4, habitaci¢n 74?
        jp nz,.19
        set 4,(ix+d_objeto)     ; Lluvia de monstruos
        ld a,(ix+d_seccion)
        and $30                 ; Inicia contador de monstruos
        ld (ix+d_seccion),a
.20:    call llueve_monstruo
        jp .9

.19:    ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16
        add hl,de
        ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $60
        ld a,(ix+d_refx)
        jp c,.10
        ;
        ; El jugador se halla a la derecha, nuestro
        ; amistoso monstruo le dar  una sorpresa a la izquierda.
        ;
        ld (hl),a       ; Posici¢n X.
        inc hl
        ld a,(ix+d_refy)
        sub $20
        ld (hl),a       ; Posici¢n Y.
        inc hl
        ld (hl),$10     ; Sprite, andando a la derecha
        ld de,$0101
        jr .11

        ;
        ; El jugador se halla a la izquierda, nuestro
        ; amistoso monstruo caer  a la derecha
        ;
.10:    add a,$a0
        ld (hl),a        ; Posici¢n X.
        inc hl
        ld a,(ix+d_refy)
        sub $20
        ld (hl),a       ; Posici¢n Y.
        inc hl
        ld (hl),$00     ; Sprite, andando a la izquierda
        ld de,$01ff

.11:    inc hl
        ld (hl),$0f     ; Color
        inc hl
        ld (hl),e       ; Dir. X
        inc hl
        ld (hl),d       ; Dir. Y
        inc hl
        ld (hl),1       ; Velocidad
        inc hl
        ld a,(ix+d_nivel)
        cp 100
        ld (hl),25      ; 25 impactos para detener al jefe zombie.
        jr nz,.14
        ld (hl),50      ; 50 impactos para detener al jefe zombie.
.14:    inc hl
        ld (hl),1       ; Paso actual (copia de velocidad)
        inc hl
        ld (hl),4       ; Tipo de monigote
        inc hl
        ld (hl),0       ; Ultimo movimiento
        inc hl
        ld a,(ix+d_nivel)
        ;
        ; Los siguientes pisos tienen un jefe que echa "carrera"
        ;
        ld d,$01
        cp 46           ; Piso 47, mapa 3
        jr z,.15
        cp 50           ; Piso 51, mapa 4
        jr z,.15
        cp 66           ; Piso 66, mapa 4
        jr nz,.21
        ld a,(ix+d_seccion)
        and $0f
        cp 4            ; ¨Ultimo jefe?
        jr z,.15        ; S¡, lo hace que eche "carrera" para sorprender

        ;
        ; Los dem s pisos tienen un jefe normal
        ;
.21:    ld d,$00
        ;
        ; Los otros dos jefes se manejan en la historia
        ;
;        ld a,(ix+d_seccion)
;        and $30
;        jr z,.15
;        cp $10
;        ld d,$21
;        jr z,.15
;        ld d,$43
    if 0
        ld d,$01        ; Jefe zombie que echa carrera
        ld d,$21        ; Chica zombie, carrera
        ld d,$43        ; Zombie malevolo que brinca y corre
        ld d,$00        ; Jefe zombie normal que brinca
    endif
.15:    ld (hl),d
        call finaliza_monigote
.9:
        bit 5,(ix+d_objeto)     ; ¨Muerto (temporalmente)?
        jr nz,.13
        bit 7,(ix+d_objeto)     ; ¨Triunfo?
        jr nz,.13
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        jr nz,.13       ; S¡, sale.
        ld a,(ix+d_vidas)
        inc a ; cp $ff  ; ¨Muerto?
        jr nz,.12
.13:    pop af          ; No acepta m s entradas
        jp .2
.12:
        ;
        ; Cuenta el tiempo para la recarga del disparo
        ;
        ld a,(ix+d_recarga)
        and $7f
        jp z,.7
        dec (ix+d_recarga)
.7:
        ;
        ; Tiempo de espera para no recibir da¤o.
        ;
        ld a,(ix+d_espera)
        or a
        jp z,.1
        dec (ix+d_espera)
.1:     pop af

        ;
        ; Velocidad del jugador
        ;
        dec (ix+d_paso)
        jp nz,mueve_monstruos
        ld l,(ix+d_velocidad)
        ld (ix+d_paso),l
        ld l,(ix+d_real)
        ld h,(ix+d_real+1)
        ;
        ; Autodesplazamiento al cambiar de zona de juego
        ;
        push af
        ld a,(ix+d_x)
        sub (ix+d_refx)
        add a,$0f
        and $f0
        ld e,a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        add a,$0f
        and $f0
        ld d,a
        call accede_casilla2
        cp 48           ; Puerta (este)
        jp z,.17        ; Va a la izquierda.
        cp 40           ; Puerta (sur)
        jp z,.8         ; Va arriba.
        cp 79           ; Puerta de la habitaci¢n del jefe (sur)
        jp z,.8         ; Va arriba.
        ld de,0
        call accede_casilla
        cp 96           ; Puerta de la habitaci¢n del jefe (oeste)
        jp z,.5         ; Va a la derecha.
        cp 20           ; Puerta (oeste)
        jp z,.5         ; Va a la derecha.
        cp 74           ; Puerta de la habitaci¢n del jefe (norte)
        jp z,.16        ; Va abajo.
        cp 21           ; Puerta (norte)
        jp nz,.6        ; No, salta.
.16:    call abre_puerta
        pop af
        call mov_abajo
        ld a,(ix+d_y)
        and $0f
        jp nz,.2
        set 1,(ix+d_objeto)
        jp .2

.5:     call abre_puerta
        pop af
        call mov_derecha
        ld a,(ix+d_x)
        and $0f
        jp nz,.2
        set 1,(ix+d_objeto)
        jp .2

.8:     call abre_puerta
        pop af
        call mov_arriba
        ld a,(ix+d_y)
        and $0f
        jp nz,.2
        set 1,(ix+d_objeto)
        jp .2

.17:    call abre_puerta
        pop af
        call mov_izquierda
        ld a,(ix+d_x)
        and $0f
        jp nz,.2
        set 1,(ix+d_objeto)
        jp .2

.6:     pop af
        ;
        ; Ahora si, ¨qu‚ movimiento deseaba?
        ;
        rrca
        jr c,.61
        call mov_arriba
        jr .64

.61:    rrca
        jr c,.62
        call mov_derecha
        jr .64

.62:    rrca
        jr c,.63
        call mov_abajo
        jr .64

.63:    rrca
        jr c,.64
        call mov_izquierda
.64:
        ;
        ; Detecta si cambia de piso
        ;
        ld a,(ix+d_x)
        or (ix+d_y)
        and $0f
        jp nz,.2
        ld de,0
        call accede_casilla
        cp 50
        jr z,.4
        cp 51
        jr z,.4
        cp 98
        jr z,.4
        cp 97           ; ¨Transportador?
        jp nz,.2
        res 0,(ix+d_objeto)     ; Le quita la llave al jugador
        call musica_avance
.4:     ld a,(ix+d_y)
        sub (ix+d_refy)
        ld de,$4f00
        ld b,-10
        jp z,.3
        cp $50
        ld de,$b100
        ld b,10
        jp z,.3
        ld a,(ix+d_x)
        sub (ix+d_refx)
        ld b,-1
        ld de,$00af
        jp z,.3
        ld b,1
        ld de,$0051
.3:     ld a,(ix+d_nivel)
        cp 100          ; ¨Estaba en el piso 101?
        push af         ; No se puede checar despu‚s de la suma...
        add a,b         ; ...o confundir¡a con piso 102
        ld (ix+d_nivel),a
        pop af
        jp z,muestra_lema       ; Entonces gan¢.
        ld a,(ix+d_x)
        add a,e
        ld (ix+d_x),a
        ld (ix+d_basex),a
        ld a,(ix+d_y)
        add a,d
        ld (ix+d_y),a
        ld (ix+d_basey),a
        call actualiza_indicadores_nivel
.2:
        ;
        ; Mueve los monigotes
        ;
mueve_monstruos:
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        ret nz          ; S¡, no actualiza
        bit 6,(ix+d_objeto)     ; ¨No existe?
        ret nz
        ld e,(ix+d_moni)
        ld d,(ix+d_moni+1)
        ld l,(ix+d_real)
        ld h,(ix+d_real+1)
        push ix
        pop iy
        push de
        pop ix
        ld b,MAX_MONIGOTES
.1:     ld a,(ix+d_tipo)
        or a
        jp z,.2
        dec (ix+d_paso) ; ¨Ya puede moverse?
        jp nz,.2        ; No, salta.
        ld a,(ix+d_velocidad)
        ld (ix+d_paso),a
.3:     ld a,(ix+d_tipo)
        dec a
        push hl
        ld hl,mueve_monstruos.15
        add a,a
        add a,l
        ld l,a
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ex (sp),hl
        ret

        ;
        ; 17 - Anima gatito
        ;
.42:    ld a,(ix+d_dx)
        or a
        jr nz,.43
        ld a,r
        cpl
        and 31
        jp nz,.2
        ld de,$01ac
        jr .44
        
.43:    dec a
        ld de,$02b0
        jr z,.44
        ld de,$00bc
.44:    ld (ix+d_sprite),e
        ld (ix+d_dx),d
        jp .2

        ;
        ; 16 - Mueve bala de l ser
        ;
.36:    ld a,(ix+d_x)
        add a,(ix+d_dx)
        add a,(ix+d_dx)
        ld (ix+d_x),a
        sub (iy+d_refx)
        cp 2
        jr c,.37
        push de
        push hl
        ld l,(ix+d_ultimo)
        ld h,(ix+d_y)
        ld e,(ix+d_ultimo+1)
        ld d,(ix+d_dy)
        add hl,de
        add hl,de
        ld (ix+d_ultimo),l
        ld (ix+d_y),h
        ld a,h
        sub (iy+d_refy)
        pop hl
        pop de
        cp 2
        jr c,.37
        cp $50
        jp c,.38
.37:    ld (ix+d_tipo),0
        jp .2

        ;
        ; Colorea la bala
        ;
.38:    ld a,(ticks)
        and $0c
        ld c,1
        jr z,.41
        cp $08
        ld c,15
        jr z,.41
        dec c
.41:    ld (ix+d_color),c
        ;
        ; Verifica si toca al jugador 
        ;
        ld c,6
        jp .45

        ;
        ; 15 - Bala para l ser
        ;
.30:    ld (ix+d_color),c
        ld a,(ix+d_dy)
        inc a
        ld (ix+d_dy),a
        sub 80          ; ¨1.6 segundos?
        jp nz,.38       ; No, salta.
        ld (ix+d_dy),25 ; Cadencia de disparo = 80 - 25 = 55 ticks
        ld a,(ix+d_x)   ; ¨L ser a la izquierda?
        sub (iy+d_x)
        jp c,.38        ; S¡, no dispara
        cp $10
        jp c,.38
        push bc
        push de
        push hl
        ld l,(iy+d_moni)
        ld h,(iy+d_moni+1)
.31:    ld de,16
        add hl,de
        ld de,d_tipo
        add hl,de
        ld a,(hl)
        sbc hl,de
        or a
        jr z,.32
        jr .31

.32:    ex de,hl
        push ix
        push de
        push ix
        pop hl
        ld bc,16
        ldir            ; Duplica el disparo
        pop ix
        ld (ix+d_tipo),16       ; Disparo real
        ld (ix+d_dx),-1
        ld (ix+d_ultimo),0
        ld a,(iy+d_y)
        sub (ix+d_y)
        ld l,a
        jr z,.33
        jr nc,.34
        neg
        call laser_divisor
        ld a,l
        neg
        ld (ix+d_ultimo+1),a
        ld (ix+d_dy),-1
        jr .35

.34:    call laser_divisor
.33:    ld (ix+d_ultimo+1),l
        ld (ix+d_dy),0
.35:    call efecto_laser
        pop ix
        pop hl
        pop de
        pop bc
        jp .38

        ;
        ; 14 - Zombie/llave cayendo
        ;
.28:    ld a,(iy+d_y)
        ld e,(iy+d_refy)
        sub e
        and $f0
        add a,16
        ld c,a
        ld a,(ix+d_velocidad)
        dec a
        ld d,4
        jr z,.29
        dec a
        ld d,8
        jr z,.29
        ld d,12
.29:    ld a,(ix+d_y)
        add a,d
        ld (ix+d_y),a
        sub e
        add a,16
        cp c
        jp c,.2
        ld a,c
        sub 16
        add a,e
        ld (ix+d_y),a
        ld a,(ix+d_sprite)
        cp $10                  ; ¨Cae llave?
        ld (ix+d_tipo),7        ; Ahora es llave
        jp z,.2
        ld (ix+d_tipo),1        ; Ahora mueve monstruo
        jp .2

        ;
        ; 13 - Explosi¢n y cambio
        ;
.26:    ld a,(ix+d_sprite)
        add a,4
        ld (ix+d_sprite),a
        cp $30
        jp nz,.2
        ld a,(ix+d_y)
        sub 16
        ld (ix+d_y),a
        xor a
        ld (ix+d_sprite),a      ; Sprite, andando a la izquierda
        ld (ix+d_color),15      ; Color
        ld (ix+d_dx),a
        ld (ix+d_dy),a
        ld (ix+d_ultimo),a
        ld (ix+d_energia),50    ; 50 impactos para detener al jefe zombie.
        inc a
        ld (ix+d_velocidad),a
        ld (ix+d_paso),a
        ld (ix+d_tipo),4
        ld a,(iy+d_seccion)
        and $30         ; Para mapa 1...
        ld d,$00        ; ...jefe zombie normal (no usado)
        jr z,.27
        cp $10          ; Para mapa 2...
        ld d,$21        ; ...chica zombie, carrera
        jr z,.27        
        cp $20          ; Para mapas 3 y 4...
        ld d,$43        ; ...zombie mal‚volo que brinca y corre
        jr z,.27        
        ld (ix+d_energia),75    ; 75 impactos en mapa 4.
.27:    ld (ix+d_ultimo+1),d
        call musica_batalla2
        jp .2

        ;
        ; 12 - Transformaci¢n.
        ;
.25:    ld a,(ix+d_color)
        xor $0f
        ld (ix+d_color),a
        dec (ix+d_dx)
        jp nz,.2
        ld (ix+d_tipo),13
        ld (ix+d_sprite),$20
        ld (ix+d_velocidad),8
        ld (ix+d_paso),8
        ld (ix+d_color),14
        jp .2

        ;
        ; 7 - Llave
        ;
.22:    ld a,(ticks)
        and $0c
        ld c,$0a
        jr z,.23
        inc c
        cp $08
        jr nz,.23
        ld c,$0f
.23:    ld (ix+d_color),c
        jp .7

        ;
        ; 11 - Vida
        ;
.20:    ld a,(ticks)
        and $0c
        ld c,$06
        jr z,.21
        cp $08
        ld c,$09
        jr z,.21
        dec c
.21:    ld (ix+d_color),c
        jp .7

        ;
        ; 10 - Explosi¢n monstruo
        ;
.14:    ld a,(ix+d_sprite)
        add a,4
        ld (ix+d_sprite),a
        cp $30
        jp nz,.2
.16:    xor a
        ld (ix+d_tipo),a
        jp .2

        ;
        ; El/la cient¡fico/cient¡fica mueve su manita
.9:
        ld a,(ix+d_sprite)
        and $f0
        ld c,a
        ld a,(ticks)
        and $0c
        cp $0c
        jr nz,$+4
        ld a,$04        ; El cuadro 3 es el cuadro 1 replicado
        or c
        ld (ix+d_sprite),a
        jp .7

.13:    call mueve_bala
        jp .2

.17:    call mueve_jefe
        ;
        ; Verifica si el jugador toca al jefe
        ;
        bit 5,(iy+d_objeto)     ; ¨Muerto (temporalmente)?
        jp nz,.2
        bit 7,(iy+d_objeto)     ; ¨Victoria?
        jp nz,.2
        ld a,(iy+d_vidas)
        inc a ; cp $ff          ; ¨Muerto?
        jp z,.2
        ld a,(iy+d_x)
        add a,8
        sub (ix+d_x)
        cp $20
        jp nc,.2
        ld a,(iy+d_y)
        add a,8
        sub (ix+d_y)
        cp $20
        jp nc,.2
        jp .10

.12:    call mueve_monstruo_3
        jp .7

.8:     call mueve_monstruo_2
        jp .7

.4:     call mueve_monstruo_1
        ;
        ; Verifica si el jugador toca el monstruo/adorno/objeto
        ;
.7:     ld c,13                 ; Distancia
        ;
        ; Punto de entrada para bala l ser
        ;
.45:    ld a,(iy+d_vidas)
        inc a ; cp $ff
        jp z,.2
        bit 5,(iy+d_objeto)     ; ¨Muerto (temporalmente)?
        jp nz,.2
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp nc,.5
        neg 
.5:     cp c
        jp nc,.2
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nc,.6
        neg
.6:     cp c
        jp nc,.2
        ld a,(ix+d_tipo)
        cp 15 
        jp z,.10
        cp 16
        jp z,.10
        cp 5
        jp c,.10
        cp 6
        jp nz,.11
        ;
        ; Toc¢ un cient¡fico
        ;
        push bc
        push hl
        push ix
        ld a,1                  ; Ya no aparece m s
        call objeto_borra
        ld (ix+d_tipo),d        ; Lo quita
        ;
        ; Un punto extra de energ¡a
        ;
        ld a,(iy+d_energia)
        cp 6
        jp z,$+6
        inc (iy+d_energia)
        ;
        ; Cuenta como rescatado
        ;
        ld a,(iy+d_rescatados)
        add a,1
        daa
        ld (iy+d_rescatados),a
        push iy
        pop ix
        ld hl,puntos_cientifico
        call agrega_puntos
        call actualiza_indicadores
        call efecto_rescate
        pop ix
        pop hl
        pop bc
        jp .2

        ;
        ; Toc¢ la llave
        ;
.11:    cp 7
        jp nz,.19
        set 0,(iy+d_objeto)     ; Indica que la lleva
        push bc
        push hl
        push ix
        ld a,4                  ; Ya no aparece m s
        call objeto_borra
        ld (ix+d_tipo),d        ; La quita
        push iy
        pop ix
        call actualiza_indicadores
        call efecto_llave
        pop ix
        pop hl
        pop bc
        jp .2

        ;
        ; Malet¡n de energ¡a: recuperaci¢n 
        ;
.19:    ld a,(iy+d_energia)
        cp 6
        ld (iy+d_energia),6
        jr nz,.191
        inc (iy+d_vidas)
.191:   push bc
        push hl
        push ix
        ld a,2                  ; Ya no aparece m s
        call objeto_borra
        ld (ix+d_tipo),d        ; Lo quita
        push iy
        pop ix
        call actualiza_indicadores
        call efecto_vida
        pop ix
        pop hl
        pop bc
        jp .2
        
        ;
        ; Toc¢ un monstruo
        ;
.10:
        ld a,(iy+d_espera)
        or a            ; ¨El jugador puede recibir da¤o?      
        jp nz,.2        ; No, salta.
        push bc
        push hl
        push ix
        call efecto_tocado
        ld a,(ix+d_tipo)
        cp 16           ; ¨Bala l ser?
        jp z,.24
        cp 4            ; ¨Jefe zombie?
        jp z,.24        ; S¡, salta, ni se inmuta.
        ld a,(ix+d_paso)
        add a,20        ; El monstruo se hace lento
        ld (ix+d_paso),a
.24:    ld a,(iy+d_paso)
        add a,5         ; El jugador se hace lento
        ld (iy+d_paso),a
        ld a,50
        ld (iy+d_espera),a
        dec (iy+d_energia)
        push iy
        pop ix
        call actualiza_indicadores
        ld a,(ix+d_energia)
        or a
        call z,jugador_cae
        pop ix
        pop hl
        pop bc
.2:     ld de,16
        add ix,de
        dec b
        jp nz,.1
        ret

        ;
        ; Divisor para obtener  ngulo del l ser
        ;
laser_divisor:
        ld l,0
        ld h,a
        ld a,(ix+d_x)
        sub (iy+d_x)
        cp h
        jp c,.3
        ld e,a
        ld d,0
        ld c,l
        ld a,h
        ld hl,0
        ld b,16
        or a
.1:     rl c
        rla
        rl l
        rl h
        sbc hl,de
        jr nc,.2
        add hl,de
.2:     ccf
        djnz .1
        ex de,hl
        rl c
        ld l,c
        rla
        ld h,a
        ret

.3:     ld hl,$00ff
        ret

        ;
        ; El jugador cae
        ;
jugador_cae:
        ld (ix+d_revivir),150
        set 5,(ix+d_objeto)     ; Muerto temporalmente
        ld a,(ix+d_refx)
        call efecto_pierde
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,d_tipo
        add hl,de
        ex de,hl
        ld hl,16
        add hl,de
        ld a,(hl)
        ex de,hl
        cp 4                    ; ¨Est  con un jefe (ocupa 4 sprites) ?
        ld de,16*(MAX_MONIGOTES-4) ; Empieza por el final para...
                                   ; ...que quede debajo de todo lo dem s
        jr z,.0
        ld e,16*(MAX_MONIGOTES-1)  ; Empieza por el final para...
                                   ; ...que quede debajo de todo lo dem s
.0:     add hl,de
        ; Busca una entrada libre
.1:     ld a,(hl)
        or a
        jr z,.2
        ld de,-16
        add hl,de
        jr .1

        ;
        ; Pone esqueletito
        ;
.2:     ld de,-d_tipo
        add hl,de
        ld a,(ix+d_x)
        ld (hl),a
        inc hl
        ld a,(ix+d_y)
        sub 6           ; Necesario por ajuste de bala (usa tipo 9)
        ld (hl),a
        inc hl
        ld a,(ix+d_nivel)
        cp 100          ; ¨Est  en la habitaci¢n del jefe m ximo?
        jr nz,.3        ; No, salta.
        ld a,(ix+d_seccion)
        and $30         ; ¨Est  en mapas 2, 3 ¢ 4?
        jr z,.3         ; No, salta.
        ld (hl),$6c     ; Esqueleto arrastr ndose
        ld bc,$0301
        ld d,1          ; Para que desaparezca en tiempo 150 / 3.
        jr .4
        
.3:     ld (hl),$18     ; Esqueleto cl sico
        ld bc,$9609     ; Duraci¢n = 150, tipo = 9 (explosi¢n)
        ld d,0
.4:     inc hl
        ld a,(ix+d_color)
        ld (hl),a       ; Color
        inc hl
        xor a
        ld (hl),a       ; Dir. X
        inc hl
        ld (hl),a       ; Dir. Y
        inc hl
        ld (hl),b       ; Velocidad
        inc hl
        ld (hl),a
        inc hl
        ld (hl),b       ; Paso actual (copia de velocidad)
        inc hl
        ld (hl),c       ; Tipo de monigote
        inc hl
        ld (hl),d       ; Ultimo movimiento
        inc hl
        ld (hl),a
        jp finaliza_monigote

        ;
        ; Jugador atrapado por un monstruo, pierde una vida
        ;
        ; Notese que al reiniciar la posici¢n tambi‚n reinicia el
        ; sprite y direcci¢n de movimiento, porque queda a un pixel
        ; del inicio real con el fin de evitar un molesto flicker
        ; de cambio entre zonas y si no se hiciera as¡, al tratar de
        ; moverse se ir¡a en direcci¢n equivocada, ocasionando un
        ; bucle infinito.
        ;
jugador_atrapado:
        ld a,(ix+d_basex)
        add a,4         ; Necesario o puede trabarse
        and $f0
        sub (ix+d_refx)
        jp nz,.1
        ld c,$00
        inc a
        ld hl,mov_derecha
        jp .2

.1:     cp $b0
        jp nz,.2
        ld c,$10
        dec a
        ld hl,mov_izquierda
.2:     add a,(ix+d_refx)
        ld (ix+d_x),a
        ld a,(ix+d_basey)
        add a,4         ; Necesario o puede trabarse
        and $f0
        sub (ix+d_refy)
        jp nz,.3
        ld c,$20
        inc a
        ld hl,mov_abajo
        jp .4

.3:     cp $50
        jp nz,.4
        ld c,$30
        dec a
        ld hl,mov_arriba
.4:     add a,(ix+d_refy)
        ld (ix+d_y),a
        ld (ix+d_ultimo),l
        ld (ix+d_ultimo+1),h
        ld a,(ix+d_sprite)
        and $c0
        or c
        ld (ix+d_sprite),a
        ld (ix+d_paso),1
        ld (ix+d_velocidad),1
        dec (ix+d_vidas)
        jp m,.5
        ld (ix+d_energia),6
        jp actualiza_indicadores

.5:     call musica_fracaso
        ; call actualiza_indicadores    ; Innecesario
        ;
        ; Elimina los monigotes
        ; 
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld b,MAX_MONIGOTES*16
.6:     ld (hl),0
        inc hl
        djnz .6
        ;
        ; Mensaje de fin de juego
        ;
        rst $28 ; zona_dura
        ld l,(ix+d_offset)
        ld h,(ix+d_offset+1)
        ld de,$00c6
        add hl,de
        rst $30
        db $00,$07,$01,$0d,$05,$00,$0f,$16,$05,$12,$00,$ff
        call zona_facil
        ;
        ; Tiempo para cerrar la tienda
        ;
        ld (ix+d_tiempo),200
        ld (ix+d_tiempo+1),0
        ret

        ;
        ; Abre una puerta si el jugador camina por ella
        ;
abre_puerta:
        cp 79
        jp z,.1
        cp 96
        jp z,.2
        cp 74
        jp nz,.3
        ld a,21
        jp .3

.2:     ld a,20
        jp .3

.1:     ld a,40
.3:     ld (ix+d_mosaico),a
        cp 22
        ld de,$0000
        jp c,.4
        ld de,$0f0f
.4:     ld a,(ix+d_y)
        add a,d
        sub (ix+d_refy)
        and $f0
        push hl
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        ld a,(ix+d_x)
        add a,e
        sub (ix+d_refx)
        and $f0
        rrca
        rrca
        rrca
        add a,l
        ld l,a
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        add hl,de
        ld (ix+d_puerta),l
        ld (ix+d_puerta+1),h
        xor a
        call dibuja_mosaico
        pop hl
        ret

        ;
        ; Restaura una puerta despu‚s de traspasarla
        ;
restaura_puerta:
        res 1,(ix+d_objeto)
        ld l,(ix+d_puerta)
        ld h,(ix+d_puerta+1)
        ld a,(ix+d_mosaico)
        call dibuja_mosaico
        jp efecto_explota

        ;
        ; Agrega puntos
        ;
agrega_puntos:
        inc hl
        inc hl
        ld a,(ix+d_puntos+2)
        add a,(hl)
        daa
        ld (ix+d_puntos+2),a
        dec hl
        ld a,(ix+d_puntos+1)
        adc a,(hl)
        daa
        ld (ix+d_puntos+1),a
        dec hl
        ld a,(ix+d_puntos)
        adc a,(hl)
        daa
        ld (ix+d_puntos),a
        ld hl,record
        cp (hl)
        ret c
        jr nz,.1
        inc hl
        ld a,(ix+d_puntos+1)
        cp (hl)
        ret c
        jr nz,.1
        inc hl
        ld a,(ix+d_puntos+2)
        cp (hl)
        ret c
        ret z
        ;
        ; Nuevo record
        ;
.1:     ld l,(ix+d_puntos)
        ld h,(ix+d_puntos+1)
        ld (record),hl
        ld a,(ix+d_puntos+2)
        ld (record+2),a
        ld a,(ix+d_refx)
        or a
        ld a,1
        jr z,.2
        inc a
.2:     rrca
        rrca
        ld h,a
        ld a,(ganado)
        and $3f
        or h
        ld (ganado),a
        ret

        ;
        ; Color para la explosi¢n de los jefes
        ;
        ; El orden es como sigue:
        ;
        ;     1   2
        ;       5
        ;     3   4
        ;
color_explosion_jefes:
        db 14,14,14,14,15,0,0,0 ; Jefe simple
        db 13,13,13,13,11,0,0,0 ; Chica zombie
        db 6,6,6,6,8,0,0,0      ; Jefe malvado

        ;
        ; Mueve bala
        ;
mueve_bala:
        push bc
        push iy
        push hl
        ld l,(iy+d_moni)
        ld h,(iy+d_moni+1)
        ld de,16
        add hl,de
        push hl
        pop iy
        ld b,MAX_MONIGOTES-1
.6:     ld a,(iy+d_tipo)
        or a
        jp z,.7
        cp 11           ; ¨Vida?
        jp z,.11
        cp 6            ; ¨Cient¡fico/a?
        jp z,.11
        cp 17           ; ¨Gatito?
        jp z,.11
        cp 5
        jp nc,.7
        cp 4
        jp nz,.11
        ;
        ; Comprobaci¢n para monstruos grandotes
        ;
        ld a,(ix+d_x)
        add a,8
        sub (iy+d_x)
        cp $1c
        jp nc,.7
        ld a,(ix+d_y)
        add a,8
        sub (iy+d_y)
        cp $1c
        jp nc,.7
        ;
        ; La bala peg¢ en un monstruo
        ;
        dec (iy+d_energia)
        ld hl,puntos_bala
        ld (salva_puntos),hl
        jp nz,.14       ; El monstruo grande ni se inmuta.
        ;
        ; ­Wiii!, ­Monstruo grande muerde el polvo!
        ;
        ld a,(iy+d_sprite)
        and $e0
        rrca
        rrca
        ld hl,color_explosion_jefes
        ld e,a
        ld d,0
        add hl,de
        ld a,(iy+d_x)
        ld (iy+d_x+32),a
        add a,$08
        ld (iy+d_x+64),a
        ld (iy+d_x+80),a
        add a,$08
        ld (iy+d_x+16),a
        ld (iy+d_x+48),a
        ld a,(iy+d_y)
        ld (iy+d_y+16),a
        add a,$08
        ld (iy+d_y+64),a
        ld (iy+d_y+80),a
        add a,$08
        ld (iy+d_y+32),a
        ld (iy+d_y+48),a
        push iy
        ld bc,$0508
.106:   ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld a,(hl)
        ld (iy+d_color),a
        ld a,c
        cp 11
        jr c,.107
        ld a,7
        jr z,.107
        ld a,11
.107:   ld (iy+d_velocidad),a
        ld (iy+d_paso),a
        inc hl
        inc c
        ld de,16
        add iy,de
        djnz .106
        pop iy
        pop af
        pop hl
        push hl
        push af
        ld de,d_nivel
        add hl,de
        ld a,(hl)
        cp 66                   ; ¨Habitaci¢n 67, mapa 4?
        jr nz,.104
        pop af
        pop hl
        push hl
        push af
        ld e,d_seccion
        add hl,de
        inc (hl)
        ld a,(hl)
        and $0f
        cp 5                    ; ¨5 monstruos matados?
        jr z,.104
        pop bc
        pop hl
        push hl
        push bc
        push af
        call musica_esperando
        pop af
        ;
        ; Aparece otro monstruo, cada vez m s r pido.
        ;
        ld de,d_tiempo
        add hl,de
        dec a
        ld (hl),160
        jr z,.105
        dec a
        ld (hl),120
        jr z,.105
        dec a
        ld (hl),80
        jr z,.105
        ld (hl),40
        jr .105

.104:   ld (iy+d_sprite+80),$10    ; Llave
        ld (iy+d_tipo+80),7
        ld (iy+d_velocidad+80),1
        ld (iy+d_paso+80),1
        ld (iy+d_color+80),11
        call musica_triunfo
.105:   call efecto_megamonstruo
        ld hl,puntos_megamonstruo
        ld (salva_puntos),hl
        ;
        ; La bala termina
        ;
.14:    call bala_explota
        pop hl
        pop iy
        pop bc
        push bc
        push iy
        push hl
        push ix
        push iy
        pop ix
        ld hl,(salva_puntos)
        call agrega_puntos
        call actualiza_indicadores
        pop ix
        pop hl
        pop iy
        pop bc
        ret

        ;
        ; Comprobaci¢n para monstruos chiquitos y cient¡ficos
        ;
.11:
        ld a,(ix+d_x)
        add a,4
        sub (iy+d_x)
        cp 12
        jp nc,.7
        ld a,(ix+d_y)
        add a,4
        sub (iy+d_y)
        cp 12
        jp nc,.7
        ;
        ; La bala peg¢ en un monstruo/cient¡fico/cient¡fica/vida/gatito
        ;
        ld a,(iy+d_tipo)
        cp 17           ; Los gatitos caen al primer balazo.
        jr z,.16
        cp 11           ; Las vidas desaparecen al primer balazo
        jr z,.16
        cp 6            ; Los cient¡ficos caen al primer balazo
        jr z,.16
        dec (iy+d_energia)
        jr nz,.10
        ;
        ; ­Wiii!, ­Monstruo matado!
        ;
        cp 1
        ld hl,puntos_monstruo_1
        jr z,.15
        cp 2
        ld hl,puntos_monstruo_2
        jr z,.15
        ld hl,puntos_monstruo_3
.15:    ld (salva_puntos),hl
        ld (iy+d_color),14
        call bala_explota2
        jp .14+3

        ;
        ; El jugador es un perfecto idiota, mat¢ un cient¡fico o destruy¢
        ; una vida.
        ;
.16:    ld hl,puntos_cero
        ld (salva_puntos),hl
        cp 11                   ; ¨Vida?
        ld bc,$0106             ; Nube de sangre
        jr nz,.9
        ld bc,$020b             ; Nube dorada para vida
.9:     ld (iy+d_color),c
        push bc
        call bala_explota2
        pop af
        pop hl
        pop iy
        pop bc
        push hl
        call objeto_borra       ; Ya no aparece m s
        pop hl
        ret

        ;
        ; El monstruo se atonta un instante
        ;
.10:    ld (iy+d_paso),5
        ;
        ; Empuje de la bala
        ;
        ld a,(ix+d_dx)
        or a
        jr z,.100
        jp p,.101
        ld a,(iy+d_x)
        and $0f
        cp 4
        jr c,.102
        ld a,(iy+d_x)
        sub 4
        ld (iy+d_x),a
        jr .102

.101:   ld a,(iy+d_x)
        and $0f
        jr z,.102
        cp 13
        jr nc,.102
        ld a,(iy+d_x)
        add a,4
        ld (iy+d_x),a
        jr .102

.100:   ld a,(ix+d_dy)
        or a
        jp p,.103
        ld a,(iy+d_y)
        and $0f
        cp 4
        jr c,.102
        ld a,(iy+d_y)
        sub 4
        ld (iy+d_y),a
        jr .102

.103:   ld a,(iy+d_y)
        and $0f
        jr z,.102
        cp 13
        jr nc,.102
        ld a,(iy+d_y)
        add a,4
        ld (iy+d_y),a
.102:
        ld hl,puntos_bala
        ld (salva_puntos),hl
        ld a,(iy+d_velocidad)
        dec a
        jp z,.14
        ld (iy+d_velocidad),a
        jp .14

.7:     ld de,16
        add iy,de
        dec b
        jp nz,.6
        pop hl
        push hl
        ld a,(ix+d_x)
        add a,(ix+d_dx)
        ld (ix+d_x),a
        sub (ix+d_refx)
        cp 4
        jr c,.1
        cp $ad
        jr nc,.1
        ld a,(ix+d_y)
        add a,(ix+d_dy)
        ld (ix+d_y),a
        sub (ix+d_refy)
        cp 4
        jr c,.1
        cp $4d
        jr nc,.1
        ld a,(ix+d_dx)
        or a
        ld de,$0800     ; Bala para arriba/abajo
        jp z,.2
        ld de,$0308     ; Bala a la izquierda/derecha
.2:     call mov_libre0
        jr nc,.5
        jr .19

        ;
        ; La bala se va, y se va, y se va, y se fue...
        ;
.1:     ld (ix+d_tipo),0
.19:    pop hl
        pop iy
        pop bc
        ret

        ;
        ; La bala peg¢ en algo
        ;
.5:     call bala_explota
        cp 31           ; ¨Consola 1?
        jr z,.17
        cp 35           ; ¨Consola 2?
        jr z,.17
        cp 24           ; ¨Computadora apagada?
        jr z,.17
        cp 54           ; ¨Computadora encendida?
        jr z,.17
        cp 43           ; ¨Caja de cart¢n 1?
        jr z,.17
        cp 58           ; ¨Caja de cart¢n 2?
        jr z,.17
        and $fe
        cp 28           ; ¨Le peg¢ a un armario?
        jr z,.17
        pop hl
        pop iy
        pop bc
        ret

.17:    ld a,(ix+d_x)
        sub (ix+d_refx)
        add a,e
        and $f0
        ld e,a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        add a,d
        and $f0
        ld d,a
        push de
        ld a,e
        rrca
        rrca
        rrca
        rrca
        ld e,a
        ld a,d
        rrca
        ld d,a
        rrca
        add a,d
        add a,e
        ld e,a
        ld d,0
        add hl,de
        ld a,(hl)
        cp 24
        ld e,54
        jr z,.18
        cp 54
        ld e,24
        jr z,.18
        cp 31
        ld e,35
        jr z,.18
        cp 35
        ld e,31
        jr z,.18
        cp 43
        ld e,58
        jr z,.18
        cp 58
        ld e,43
        jr z,.18
        xor 1
        ld e,a
.18:    ld a,e
        ld (hl),a
        ex af,af'
        pop de
        pop hl
        pop iy
        push iy
        push hl
        ld l,(iy+d_offset)
        ld h,(iy+d_offset+1)
        ld a,e
        rrca
        rrca
        rrca
        ld c,a
        ld b,0
        add hl,bc
        ld e,d
        ld d,0
        add hl,de
        add hl,de
        add hl,de
        add hl,de
        ex af,af'
        call dibuja_mosaico
        pop hl
        pop iy
        pop bc
        ret

        ;
        ; La bala explota
        ;
bala_explota2:
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),8
        ld (iy+d_paso),8
        call efecto_monstruo
bala_explota:
        ld (ix+d_sprite),$0c
        ld (ix+d_color),9
        ld (ix+d_tipo),9
        ld (ix+d_paso),4
        ld (ix+d_velocidad),4
        jp efecto_explota

        ; Puntos por matar a un cient¡fico
puntos_cero:
        db $00,$00,$00

        ; Puntos por rescatar un cient¡fico
puntos_cientifico:
        db $00,$01,$00

        ; Diez puntos por atinar una bala
puntos_bala:
        db $00,$00,$01

        ; Cien puntos por monstruo simple
puntos_monstruo_1:
        db $00,$00,$10

        ; Doscientos cincuenta puntos por monstruo tipo 2
puntos_monstruo_2:
        db $00,$00,$25

        ; Quinientos puntos por monstruo tipo 3
puntos_monstruo_3:
        db $00,$00,$50

        ; Diez mil puntos por acabar con el megamonstruo
puntos_megamonstruo:
        db $00,$10,$00

        ;
        ; Realiza el movimiento previo
        ;
mov_previo:
        push hl
        ld l,(ix+d_ultimo)
        ld h,(ix+d_ultimo+1)
        ex (sp),hl
        ret

        ;
        ; Anima sprite vertical
        ;
anima_sprite_v:
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        cp $0c          ; ¨Sprite 3?
        jp nz,$+5
        ld a,$04        ; El cuadro 3 es el cuadro 1 replicado
        or d
        or c
        ld (ix+d_sprite),a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        ret

        ;
        ; Movimiento hacia arriba
        ;
mov_arriba:
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld d,$30
        call anima_sprite_v
        ret z
        ld de,$ff00
        call mov_libre
        ret nc
        dec (ix+d_y)
        ld (ix+d_ultimo),mov_arriba and 255
        ld (ix+d_ultimo+1),mov_arriba>>8
        ret

        ;
        ; Movimiento hacia abajo
        ;
mov_abajo:
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld d,$20
        call anima_sprite_v
        cp $50
        ret nc
        ld de,$0100
        call mov_libre
        ret nc
        inc (ix+d_y)
        ld (ix+d_ultimo),mov_abajo and 255
        ld (ix+d_ultimo+1),mov_abajo>>8
        ret

        ;
        ; Anima un sprite horizontal
        ;
anima_sprite_h:
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or d
        or c
        ld (ix+d_sprite),a
        ld a,(ix+d_x)
        sub (ix+d_refx)
        ret

        ;
        ; Movimiento a la izquierda
        ;
mov_izquierda:
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld d,$10
        call anima_sprite_h
        ret z
        ld de,$00ff
        call mov_libre
        ret nc
        dec (ix+d_x)
        ld (ix+d_ultimo),mov_izquierda and 255
        ld (ix+d_ultimo+1),mov_izquierda>>8
        ret

        ;
        ; Movimiento a la derecha
        ;
mov_derecha:
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld d,$00
        call anima_sprite_h
        cp $b0
        ret nc
        ld de,$0001
        call mov_libre
        ret nc
        inc (ix+d_x)
        ld (ix+d_ultimo),mov_derecha and 255
        ld (ix+d_ultimo+1),mov_derecha>>8
        ret

        ;
        ; Verifica si puede moverse libremente
        ;
mov_libre:
        ld a,e
        or a
        jr z,.1
        bit 7,e
        jr nz,.1
        ld a,e
        add a,15
        ld e,a
.1:     ld a,d
        or a
        jr z,.2
        bit 7,d
        jr nz,.2
        ld a,d
        add a,15
        ld d,a
.2:     call accede_casilla
        cp 97   ; ¨Transportador?
        jr z,.3
        push hl
        ld e,a
        rst $38 ; checa_camino
        pop hl
        ret nc
        scf
        ret

.3:     bit 0,(ix+d_objeto)     ; ¨Tiene la llave?
        scf
        ret nz                  ; Si, puede caminar el transportador
        ccf
        ret

        ;
        ; Detecci¢n de movimiento libre para bala
        ;
mov_libre0:
        push de
        call accede_casilla
        push hl
        ld e,a
        rst $38 ; checa_camino
        ld a,e
        pop hl
        pop de
        ret nc
        scf
        ret

        ;
        ; Accede una casilla del nivel
        ;
accede_casilla:
        ld a,(ix+d_x)
        sub (ix+d_refx)
        add a,e
        ld e,a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        add a,d
        ld d,a
accede_casilla2:
        ld a,e
        rrca
        rrca
        rrca
        rrca
        and $0f
        ld e,a
        ld a,d
        and $f0
        rrca
        ld d,a
        rrca
        add a,d
        add a,e
        push hl
        ld e,a
        ld d,0
        add hl,de
        ld a,(hl)
        pop hl
        ret

        ;
        ; Inteligencia artificial de los monstruos
        ;
        include "ia.asm"

        ; Mensajes
        include "mensajes.asm"

        ;
        ; Logo para distribuidor
        ;
logo_distribuidor:
        incbin "coll.dat"
logo_ot:
        incbin "milogo.dat"
GRAFICA_HELICOPTERO:    ; La imagen final del helic¢ptero
        INCBIN "HELICOP.DAT"

        ; Gr ficas de los mosaicos
        include "combina1.asm"
        ; Colores de los mosaicos
        include "combina2.asm"
        ; Sprites est ticos
        include "combina3.asm"

;        db "What are you looking for? :)",0

        DS $10000-$,$ff      ; Rellena a 32K

        ORG $7000,$73B0
        ;
        ; El Coleco solo dispone de un 1K de RAM
        ;
sprites:
        RB 128
sprites_especiales:
        RB 8    ; Offset de sprites redefinidos.
                ; Actualmente +0 = Sprite jugador 1
                ;             +1 = Configuraci¢n llaves para esta partida
                ;             +2 = Sprite jugador 2
                ;             +3 = Sin uso
                ;             +4 = Sprite jefe 1 (2 bytes)
                ;             +6 = Sprite jefe 2 (2 bytes)

pantalla:       ; Espacio para media pantalla (12 l¡neas por 32 caracteres)
                ; Usado por historia.
        ;
        ; Nota: en la inicializaci¢n depende de que jug1 y jug2 est‚n juntos
        ;
jug1:   ; Datos del jugador 1
jug1_x: RB 1    ; Coordenada X 
jug1_y: RB 1    ; Coordenada Y
jug1_s: RB 1    ; Sprite correspondiente
jug1_c: RB 1    ; Color
jug1_r: RB 1    ; Recarga de disparo
jug1_n: RB 1    ; Pantalla que est  jugando
jug1_l: RB 1    ; Velocidad
jug1_e: RB 1    ; Energia restante
jug1_a: RB 1    ; Paso
jug1_p: RB 3    ; Puntuaci¢n (BCD)
jug1_o: RB 2    ; Offset pantalla
jug1_f: RB 1    ; Referencia X
jug1_g: RB 1    ; Referencia Y
jug1_d: RB 2    ; Apunta al nivel que esta jugando
jug1_m: RB 2    ; Su tabla de amistosos monigotes
jug1_v: RB 1    ; Vidas restantes ($ff = muerto)
        RB 1    ; Tiempo de espera antes de recibir m s da¤o.
        RB 2    ; Base X y Y de donde empieza si pierde una vida.
        RB 3    ; Puntos
        RB 1    ; Objetos
        RB 2    ; Monitor para transportador
        RB 2    ; Tiempo para que aparezca gran jefe
        RB 2    ; Su mapa modificado de nivel
        RB 1    ; Estado de historia
        RB 1    ; Cient¡ficos rescatados
        RB 1    ; Temblor
        RB 1    ; Direcci¢n del temblor
        RB 2    ; L¡nea donde salva temblor
        RB 2    ; Puerta por restaurar
        RB 1    ; N£mero de mosaico
        RB 1    ; Secci¢n (mapa)
        RB 1    ; Tiempo para revivir

jug2:   ; Datos del jugador 2
        RB 45

monigotes:      ; Tabla de monigotes
        RB (MAX_MONIGOTES*2)*16

        ;
        ; El nivel actual
        ;
nivel1: RB 12*6 ; Nivel actual (jugador 1)
nivel2: RB 12*6 ; Nivel actual (jugador 2)

        ;
        ; En la inicializaci¢n depende de que bits1 y bits2 est‚n juntos
        ;
        ; Mapa de pisos, cuatro bits por piso.
        ; bit 0 = Cient¡fico rescatado
        ; bit 1 = Vida usada
        ; bit 2 = Llave tomada
        ;
bits1:  RB 51  ; Cosas modificadas en el mapa (jugador 1)
bits2:  RB 51  ; Cosas modificadas en el mapa (jugador 2)

salva_puntos:   RB 2

        ;
        ; Variables usadas por el n£cleo
        ;
ticks:  RB 2
ciclo:  RB 1

        ;
        ; Modo del vector de interrupci¢n.
        ; bit 0 = 1 = Controlar pantalla y sprites
        ;     1 = 1 = En pausa, quitar sonido.
        ;     2 = 1 = Redefinir sprites h‚roes (usado durante juego)
        ;     3 = 1 = No usar sonido (para la chicharra de presentaci¢n)
        ;     4 = 1 = Sonido desactivado
        ;     5 = 1 = En helic¢ptero
        ;     6 = 1 = No tocar registros VDP
        ;     7 = 1 = Dentro de interrupci¢n.
        ;
modo:   RB 1
estado: RB 1
offset: RB 2    ; Offset actualizaci¢n video
hist_tem: RB 1  ; Byte temporal de historia.
L_OFFSET: RB 2
L_LINEA:  RB 2

        ;
        ; Variables del generador de sonido
        ;
        ; Las siguientes se cargan directo en el PSG
        ;
ef_voz1:        RB 2    ; Frecuencia voz 1
ef_voz2:        RB 2    ; Frecuencia voz 2
ef_voz3:        RB 2    ; Frecuencia voz 3
ef_ruido:       RB 1    ; Ruido
ef_mezc:        RB 1    ; Mezclador
ef_vol1:        RB 1    ; Volumen voz 1
ef_vol2:        RB 1    ; Volumen voz 2
ef_vol3:        RB 1    ; Volumen voz 3
ef_envo:        RB 2    ; Frecuencia envolvente
ef_envm:        RB 1    ; Modo envolvente
ef_jeje:        RB 1    ; Volumen voz 4
ef_cont:        RB 1    ; Control SN76489

    ifdef SGM
        ;
        ; Las siguientes se cargan directo en el PSG AY-3-8910
        ; incorporado en el Super Game Module
        ;
ef2_voz1:       RB 2    ; Frecuencia voz 1
ef2_voz2:       RB 2    ; Frecuencia voz 2
ef2_voz3:       RB 2    ; Frecuencia voz 3
ef2_ruido:      RB 1    ; Ruido
ef2_mezc:       RB 1    ; Mezclador
ef2_vol1:       RB 1    ; Volumen voz 1
ef2_vol2:       RB 1    ; Volumen voz 2
ef2_vol3:       RB 1    ; Volumen voz 3
    endif

ef_band:        RB 1    ; Banderas de efectos
ef_cont1:       RB 1    ; Contador (toma llave)
ef_cont2:       RB 1    ; Contador (rescate cient¡fico)
ef_cont3:       RB 1    ; Contador (tocado)
ef_cont4:       RB 1    ; Contador (disparo)
ef_cont5:       RB 1    ; Contador (explota)
ef_cont6:       RB 1    ; Contador (monstruo/megamonstruo)
ef_frec6:       RB 2    ; Frecuencia (monstruo/megamonstruo)
ef_frec7:       RB 2    ; Frecuencia (monstruo/megamonstruo)
ef_frec8:       RB 2    ; Frecuencia (monstruo/megamonstruo)
ef_cont7:       RB 1    ; Contador (berrido)
ef_cont8:       RB 1    ; Contador (vida extra)
ef_cont9:       RB 1    ; Contador (pierde vida) m s bit 7 0=normal, 1= gudo
ef_frec9:       RB 2    ; Frecuencia (pierde vida)
ef_cont10:      RB 1    ; Contador (l ser)
ef_frec10:      RB 2    ; Frecuencia (l ser)
ef_cont11:      RB 1    ; Contador (rasca)

ef_t:           RB 1    ; Tiempo base de reproducci¢n
ef_cn:          RB 1    ; Conteo de notas para acordes
ef_inicio:      RB 2    ; Base de m£sica en reproducci¢n.
ef_ap:          RB 2    ; Apuntador a m£sica en reproducci¢n
ef_n1:          RB 1    ; Nota 1
ef_i1:          RB 1    ; Instrumento 1
ef_f1:          RB 1    ; Forma 1
ef_n2:          RB 1    ; Nota 2
ef_i2:          RB 1    ; Instrumento 2
ef_f2:          RB 1    ; Forma 2
ef_n3:          RB 1    ; Nota 3
ef_i3:          RB 1    ; Instrumento 3
ef_f3:          RB 1    ; Forma 3
ef_n4:          RB 1    ; Nota 4
ef_f4:          RB 1    ; Forma 4

ganado:         RB 1    ; Varias banderas.
                        ; bit 3-0 = Cuantas veces ha ganado.
                        ; bit 4 = Depuraci¢n activada
                        ; bit 7-6 = Qui‚n hizo el record (jugador 1 ¢ 2)
record:         RB 3    ; Record (BCD)

tecla:          RB 1    ; Tecla oprimida actualmente con antirebote
conteo:         RB 1    ; Conteo para antirebote
slot_actual:    RB 2    ; Slot seleccionado actualmente

        ORG $7400
PILA:   

