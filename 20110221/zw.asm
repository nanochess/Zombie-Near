        ;
        ; Zombie Near (antes Zombie Labs (antes Zombie Wars))
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright Oscar Toledo Guti‚rrez 2011
        ;
        ; Creaci¢n: 06-ene-2011.
        ; Revisi¢n: 07-ene-2011. Ya no ocurren movimientos desalineados. Los
        ;                        niveles se navegan ahora como laberintos.
        ;                        Los cuadros sin fondo toman info. de
        ;                        alrededor.
        ; Revisi¢n: 08-ene-2011. Los sprites de los jugadores se definen
        ;                        sobre la marcha para hacer espacio a m s
        ;                        sprites. Permite agregar "adornos" y objetos
        ;                        a los niveles. Permite recoger la llave y
        ;                        rescatar a los cient¡ficos. Permite usar la
        ;                        llave para traspasar puerta. Se implementa
        ;                        el zombie tipo 3 que persigue al jugador.
        ;                        Se implementa el disparo. Ya visualiza el
        ;                        sprite del gran jefe.
        ; Revisi¢n: 09-ene-2011. Se incorpora el gran jefe zombie. La bala
        ;                        empuja a los monstruos al impactarlos. Se
        ;                        agregan rutinas de relleno para efectos de
        ;                        sonido y m£sica. La mancha se vuelve verde
        ;                        obscuro. Se corrige movimiento de zombies 3
        ;                        y se hacen negros. Se agregan vidas, dan
        ;                        energ¡a. Los cient¡ficos, llaves y vidas
        ;                        solo aparecen una vez y desaparecen al ser
        ;                        tomados. Correcciones varias. Se agrega
        ;                        pausa con F1. Limpia pantalla antes de
        ;                        empezar juego (antes se ve¡an por instantes
        ;                        los caracteres). Las llaves y las vidas
        ;                        parpadean. Se empiezan a armar rutinas
        ;                        preliminares para presentaci¢n.
        ; Revisi¢n: 10-ene-2011. Se incorpora c¢digo para probar los
        ;                        retratitos. Se integran los retratitos. Se
        ;                        integra la pantalla de t¡tulo usando el
        ;                        descompactador de mi juego sin terminar
        ;                        Galaktis. Se integra pantalla de alerta.
        ; Revisi¢n: 11-ene-2011. Se integra pantalla de edificio. Se agregan
        ;                        mensajes de historia y rutinas para texto.
        ;                        Se integra pantalla de helic¢ptero. Ya
        ;                        muestra mensaje de juego terminado y
        ;                        vuelve a la presentaci¢n. Al salir de la
        ;                        £ltima habitaci¢n muestra retratito y lema.
        ;                        Cuando gana muestra pantalla de helic¢ptero
        ;                        peque¤a animaci¢n y final. La pistola ya se
        ;                        mueve para seleccionar modo de juego. Si
        ;                        juega un solo usuario, el monigote se
        ;                        controla con teclado o joystick. Se agregan
        ;                        retratos zombies para historia. Se agregan
        ;                        los puntitos temblorosos para edificio. Los
        ;                        adornos quedan debajo de todos los otros
        ;                        sprites. Correcci¢n en algunas situaciones
        ;                        del jugador 2. Nombre cambiado a ZOMBSLAB,
        ;                        Zombie Labs y Zombie Wars ya est n ocupados
        ;                        :(
        ; Revisi¢n: 12-ene-2011. El m¢dulo de sonido se pone por separado,
        ;                        ya llama a la rutina de generaci¢n de sonido
        ;                        y se agregan aqu¡ las variables. Los
        ;                        cient¡ficos dan un punto de vida. Las vidas
        ;                        califican como adorno as¡ que quedan debajo
        ;                        de lo dem s.
        ; Revisi¢n: 13-ene-2011. Ya incluye el archivo de m£sica. Nombre
        ;                        cambiado a Zombie Near. Se integra sonido de
        ;                        chicharra. Se combinan subrutinas para
        ;                        desplazar retratos, ahorra espacio.
        ; Revisi¢n: 14-ene-2011. Los niveles se mueven a su propio bloque de
        ;                        8K en la ROM, as¡ queda libre m s espacio
        ;                        para c¢digo y datos b sicos. Se centran
        ;                        mejor los porcentajes en presentaci¢n. Los
        ;                        sprites de los personajes cambian a la
        ;                        direcci¢n deseada a£n si no es posible
        ;                        moverse. Muestra letra de edificio junto a
        ;                        n£mero de piso. Ajustes en posici¢n
        ;                        mensajes de historia.
        ; Revisi¢n: 15-ene-2011. Nuevo c¢digo para activar 16 KB de ROM que
        ;                        funciona con subslots. Inicia las secciones
        ;                        de ROM (requerido para MSX2+ y MSX Turbo-R)
        ;                        Se amplia el total de mosaicos gr ficos a
        ;                        50 (medio centenar) :). El jefe zombie del
        ;                        piso 101 ahora requiere 50 impactos.
        ; Revisi¢n: 16-ene-2011. Se redise¤a el vector de interrupci¢n para
        ;                        admitir que se definan dos jefes zombies al
        ;                        mismo tiempo, se limita la actualizaci¢n de
        ;                        pantalla y todo para que quepa en 1/60 de
        ;                        segundo, porque resulta que lo anterior solo
        ;                        cab¡a en 1/50 de segundo. Se agregan seis
        ;                        retratos de jefe e investigadora con color
        ;                        modificado para historia extendida. Permite
        ;                        tener hasta tres mapas. C¢digo preliminar
        ;                        que activar  nuevos jefes zombies. Ya admite
        ;                        colocar zombies tipo 4 y verticales tipo 1.
        ;                        Gracias al espacio extra en sprites se
        ;                        agregan de nuevo figuras de las cient¡ficas.
        ; Revisi¢n: 17-ene-2011. Se agrega puerta norte para jefes. Ya
        ;                        aparecen todos los jefes en sus respectivas
        ;                        habitaciones. Correcci¢n en animaci¢n de
        ;                        final, tambi‚n retratos (A no ten¡a slot).
        ;                        Se agregan autodesplazamientos para nuevas
        ;                        puertas (mosaicos 40, 48 y 74). Ya incluye
        ;                        el archivo que contiene los mensajes de la
        ;                        historia extendida.
        ; Revisi¢n: 18-ene-2011. Se agregan franjas d_estado y d_rescatados.
        ;                        VISUAL_LINEA se modifica para visualizar
        ;                        n£mero variable. Ya cuenta cient¡ficos
        ;                        rescatados. Al completar mapa llama a
        ;                        historia, de ah¡ se decide si pasa a otro
        ;                        mapa o gana el juego. Se agregan monigotes
        ;                        de chica y jefe esperando. El jugador se
        ;                        mueve autom tico al hallar chica o jefe, e
        ;                        invoca historia. Nuevos tipos de monigote
        ;                        para parpadeo, explosi¢n y transformaci¢n.
        ;                        Todo lo relativo a presentaci¢n e historia
        ;                        se pone en HISTORIA.ASM. Incluye la portada
        ;                        alternativa de titulo para cuando se gana
        ;                        el juego. Mapa es agregado en estatus a
        ;                        n£mero de piso (A= 1-101, B= 102-202,
        ;                        C= 203-303).
        ; Revisi¢n: 19-ene-2011. Se incorpora un record. Se agrega un rastreo
        ;                        de teclado. Al oprimir F2 activa/desactiva
        ;                        el sonido. Se agregan trucos. Admite manejar
        ;                        jugador 2 con WASD+Tab. Se agregan dos vidas
        ;                        m s, si esta dif¡cil :). ­Lo declaro juego
        ;                        terminado! :D
        ; Revisi¢n: 20-ene-2011. Al poner pantalla negra reinicia color borde
        ;                        a negro. Usar trucos reinicia puntos a cero.
        ;                        Incluye archivos de datos extra para idioma
        ;                        espa¤ol. Nueva funci¢n visual_mensaje_idioma
        ;                        Llama mensajes traducidos para fin de juego,
        ;                        piso, energ¡a y pausa. Se documenta la
        ;                        compactaci¢n. No actualiza el transportador
        ;                        si gan¢ el juego.
        ; Revisi¢n: 21-ene-2011. Selecciona idioma espa¤ol autom ticamente si
        ;                        detecta BIOS espa¤ol o argentino de MSX1. Se
        ;                        integra un efecto de temblor para cuando se
        ;                        enfrenta el jefe, mueve la pantalla hacia
        ;                        abajo, izquierda o derecha por 4 ticks y
        ;                        luego restaura a su posici¢n original.
        ; Revisi¢n: 22-ene-2011. Nuevas variables ef_vol1-3 y ef_ruido.
        ; Revisi¢n: 24-ene-2011. Se colorean los jefes zombies. Maneja
        ;                        paredes 50 y 51 (pueden caminarse), sirven
        ;                        para huevo de pascua. Se corre la numeraci¢n
        ;                        de pisos para dar a entender que existe un
        ;                        piso oculto. Al salir de presentaci¢n limpia
        ;                        con pantalla negra. Se agregan gr ficas para
        ;                        habitaciones de pascua. Los jugadores bajan
        ;                        la pistola cuando hallan a personajes.
        ; Revisi¢n: 25-ene-2011. Las puertas se "abren" para dejar pasar al
        ;                        jugador. Al iniciar el juego, el jugador
        ;                        camina autom tico el primer cuadro. Se
        ;                        empieza a optimizar c¢digo, ya empiezo a
        ;                        estar apretado. Inicia otro buffer a $00 por
        ;                        sospecha de error al mostrar puntos en
        ;                        edificio (notado en BlueMSX). Se ponen las
        ;                        letras aqu¡ y las gr ficas de mosaico se
        ;                        mandan a $11000. Los sprites de jugadores
        ;                        ahora son bicolores :). Se agrega truco de
        ;                        alternar sprites para evitar problema de 4
        ;                        en l¡nea y tambi‚n desplazamiento en Y, hubo
        ;                        que redise¤ar la bala. La explosi¢n de bala
        ;                        ahora dura 4 cuadros, antes era s¢lo uno as¡
        ;                        que no se notaba. Mejora en calculo de
        ;                        impacto en monstruo peque¤o. Se agrega truco
        ;                        OSCURO.
        ; Revisi¢n: 26-ene-2011. Explosi¢n bala ahora un pixel m s abajo.
        ; Revisi¢n: 06-feb-2011. Las balas matan a los cient¡ficos. Disparar
        ;                        a un armario abre/cierra la puerta. Nuevas
        ;                        definiciones SLOT1/SLOT2/SLOT3. Cuando el
        ;                        jugador muere pone temporalmente un
        ;                        esqueletito antes de continuar, para hacer
        ;                        esto se mueve mapa actual a d_seccion y se
        ;                        usa un bit extra en d_objeto (bit 5). La
        ;                        explosi¢n de los jefes ahora es de
        ;                        diferentes colores seg£n el jefe.
        ; Revisi¢n: 07-feb-2011. Al pegarle a las consolas tambi‚n cambian.
        ;                        Ajuste en coordenadas de detecci¢n choque
        ;                        bala con muro, hacia la izquierda y arriba
        ;                        no llegaba al muro.
        ; Revisi¢n: 08-feb-2011. Elimino MIPOKE integr ndolo en el c¢digo de
        ;                        descompactaci¢n, tambi‚n se eliminan
        ;                        incrementos/decrementos por ajuste en el
        ;                        compactador (imagen.c), as¡ es m s suave.
        ;                        Ligera optimizaci¢n al cargar BC para
        ;                        actualizaci¢n en interrupci¢n.
        ; Revisi¢n: 10-feb-2011. El truco OSCURO ahora pone rojo obscuro a la
        ;                        chica. Nuevas variables ef_cont9 y ef_frec9,
        ;                        llama a efecto_pierde al perder una vida.
        ;                        Se corrige un defecto cuando el jugador 
        ;                        muere en habitaci¢n con jefe en modo de dos
        ;                        jugadores, no sal¡a el esqueletito.
        ; Revisi¢n: 11-feb-2011. Se agrega una paleta para MSX2.
        ; Revisi¢n: 15-feb-2011. Los indicadores de los jugadores ya no se
        ;                        actualizan en caso de muerto, victoria e
        ;                        historia, necesario cuando se usan trucos.
        ;                        Algunas optimizaciones menores (cp $ff a
        ;                        inc a / call + ret a jp / and 1 a rrca). Se
        ;                        mueven las gr ficas para hacer un poco m s
        ;                        de espacio continuo al final del ROM y se
        ;                        integra una foto m¡a y otra de Ad n.
        ; Revisi¢n: 17-feb-2011. La explosi¢n del jefe simple se pone gris de
        ;                        nuevo.
        ;

        ORG $4000

        FNAME "ZOMBNEAR.ROM"

        ;
        ; Ya hecho:
        ; o Admitir WASD y Tab para jugador 2. Asi ambos pueden jugar con
        ;   el teclado. (19-ene-2011)
        ; o Poner instrumentos a la m£sica (piano, flauta, 14-ene-2011)
        ; o La m£sica de fondo. (13-ene-2011)
        ; o Los efectos de sonido. (12-ene-2011)
        ; o Poner los adornos al £ltimo en la lista de monigotes para que
        ;   nunca aparezcan encima de los monigotes. (11-ene-2011)
        ; o La megapresentaci¢n espectacular. (11-ene-2011)
        ; o El megafinal espectacular. (11-ene-2011)
        ; o Integrar el gran jefe (09-ene-2011)
        ; o Urge el disparo (08-ene-2011)
        ; o Desarrollar el zombie tipo 3 (08-ene-2011)
        ; o Implementar las llaves (08-ene-2011)
        ; o Dispersar zombies por los niveles (08-ene-2011)
        ; o Dispersar cient¡ficos por los niveles. (08-ene-2011)
        ; o Decorar los niveles (08-ene-2011)
        ; o Sprites decorativos para esqueletitos y sangrita. (08-ene-2011)
        ; o Definir los sprites de los jugadores en tiempo real,
        ;   para hacer m s espacio para figuras. (08-ene-2011)
        ; o El laberinto y m s gr ficas. (07-ene-2011)
        ; o Tener un engine b sico y gr ficas preliminares. (06-ene-2011)
        ; o Un mont¢n de cosas.
        ;

        ;
        ; En el Z80 la instrucci¢n JR es m s lenta que JP cuando se toma
        ; el salto, as¡ que he preferido usar JP, ­cada ciclo cuenta!
        ; excepto en lugares donde no importa el tiempo.
        ;

        ;                                                    
        ; Al principio iba a ser un avance por pisos, sin retroceso, pero
        ; como quedaron tan peque¤os lo hice por habitaciones, pero se
        ; qued¢ el nombre de pisos :)
        ;
        ; El convertidor de imagenes BMP a formato MSX y el compactador
        ; de titulos, cortes¡a de mi juego no acabado Galaktis.
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
        ; Mapa de uso del ROM:                       Libre
        ; $00000 - C¢digo y datos b sicos            2.00K
        ; $06000 - Retratos (1K cada uno)              -
        ; $09400 - Aleatorio para edificio             -
        ; $0a000 - Mapa 1 (7344 bytes)               0.83K
        ; $0c000 - Mapa 2 (7344 bytes)               0.83K
        ; $0e000 - Mapa 3 (7344 bytes)               0.83K
        ; $10000 - Historia y mosaicos                 -
        ; $11780 - Inician im genes compactadas.       -
        ; $1FB00 - Libre                             1.00K
        ; $20000 - Final del ROM.
        ;                              Total libre:  5.49K de 128K
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

        DB " Feb/17/2011 "       ; Revisi¢n
        DB "ZOMBIE NEAR "
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
d_offset:       equ 12  ; Offset de pantalla (p gina oculta)
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
                        ; bit 4 = Sin uso
                        ; bit 5 = Jugador muerto
                        ; bit 6 = Jugador inactivo
                        ; bit 7 = Victoria
d_trans:        equ 28  ; Ubicaci¢n del transportador (p gina oculta)
d_tiempo:       equ 30  ; Tiempo para que aparezca gran jefe
d_mapa:         equ 32  ; Apuntador a mapa modificado.
d_estado:       equ 34  ; Estado de historia
d_rescatados:   equ 35  ; Cient¡ficos rescatados (BCD)
d_temblor:      equ 36  ; Estado de temblor
d_dirtem:       equ 37  ; Direcci¢n temblor (0=abajo, 1=izq, 2=der)
d_linea:        equ 38  ; L¡nea para salvar pantalla en temblor
d_puerta:       equ 40  ; Puerta por restaurar.
d_mosaico:      equ 42  ; N£mero de mosaico de puerta.
d_seccion:      equ 43  ; Secci¢n (mapa)
                        ; bit 5 - 4 = Mapa
                        ;             00 = Mapa 1
                        ;             01 = Mapa 2
                        ;             10 = Mapa 3

BASE_MOSAICOS:  equ $38 ; Caracter base de mosaicos gr ficos.

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
        ; Sospecha de que a veces excede buffer de puntos
        ; $c000-$cfff
        ;
        ; No hay problema si la RAM est  replicada, malo
        ; ser¡a que llenara hasta $dfff, porque podr¡a
        ; pasarse sobre $ffff.
        ;
        ld hl,$c000
        xor a
.3:     ld (hl),a
        inc hl
        bit 4,h
        jr z,.3
    if 0
        ; Para comprobar presentaci¢n alternativa
        ld a,1
        ld (ganado),a
    endif
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
        ; Inicia el sonido
        ;
        call inicia_sonido
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
        call presentacion
        ld a,(sprites)
        push af
        call limpia_sprites
        halt
        call pantalla_negra
        ;
        ; Entrada al juego
        ;
        ld hl,modo
        res 0,(hl)
        ;
        ; Procede a inicializar la pantalla oculta
        ;
        ld hl,pantalla
        xor a
        ld b,a ; o sea 256
.2:     ld (hl),a
        inc hl
        djnz .2
.3:     ld (hl),a
        inc hl
        djnz .3
.4:     ld (hl),a
        inc hl
        djnz .4
        ld hl,$3c00
        ld bc,$0300
        xor a
        call FILVRM
        ;
        ; Carga las letras (56 caracteres, replicados 3 veces para
        ; los bitmaps y 3 veces para el color)
        ;
        ld hl,letras
        ld de,$0000
        ld bc,$01c0
        call repetir
        ld hl,color_letras
        ld de,$2000
        ld bc,$01c0
        call repetir
        ;
        ; Carga los mosaicos para los niveles (50 diferentes)
        ;
        ld a,8
        ld (SLOT3),a
        ld hl,graf_bitmap
        ld de,$01c0
        ld bc,1600
        call repetir
        ld hl,graf_color
        ld de,$21c0
        ld bc,1600
        call repetir
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
        jp z,$+6
        ld hl,jug1_inicial
        ld de,jug1
        ld bc,44
        ldir
        ld hl,bits1
        ld b,101
        ld (hl),0
        inc hl
        djnz $-3
        cp $68          ; Checa coordenada Y de la pistola
        ld hl,jug_fuera
        jp z,$+6
        ld hl,jug2_inicial
        ld de,jug2
        ld bc,44
        ldir
        ld hl,bits2
        ld b,101
        ld (hl),0
        inc hl
        djnz $-3
        ;
        ; A partir de ahora solo la rutina de interrupci¢n toca el VDP
        ;
        ld hl,modo
        set 2,(hl)      ; Redefine sprites
        set 0,(hl)      ; Controla sprites y pantalla
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
        ld ix,jug1
        ld a,(ix+d_vidas)
        inc a   ; cp -1
        call nz,carga_nivel
        call actualiza_indicadores
        ld ix,jug2
        ld a,(ix+d_vidas)
        inc a   ; cp -1
        call nz,carga_nivel
        call actualiza_indicadores
        ;
        ; Bucle principal
        ;
.1:     halt                    ; Actualizaci¢n, tambi‚n ahorra energ¡a.
        call actualiza_sprites  ; Coloca los sprites
        ld ix,jug1
        call realiza_temblor    ; Maneja efecto temblor
        ld ix,jug2
        call realiza_temblor    ; Maneja efecto temblor
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
        jp z,.5
.6:     ld a,(iy+d_vidas)       ; Jugador 2
        or a                    ; ¨A£n vivo?
        jp m,.7
        bit 7,(iy+d_objeto)     ; ¨Triunfo?
        jp z,.5
.7:     ld a,(ix+d_tiempo)
        or (ix+d_tiempo+1)
        jp nz,.5
        ld a,(iy+d_tiempo)
        or (iy+d_tiempo+1)
        jp nz,.5
        bit 7,(ix+d_objeto)
        jp nz,toma_final
        bit 7,(iy+d_objeto)
        jp nz,toma_final
        jp REINICIO             ; Termin¢, va a la presentaci¢n.

.5:     call checa_pausa
        jr .1                   ; Repite incansablemente

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
        ; Realiza un efecto de temblor
        ;
realiza_temblor:
        ld a,(ix+d_temblor)
        or a
        ret z
        ld a,(ix+d_dirtem)
        or a    ; Hacia abajo
        jp z,.0
        cp 1    ; Izquierda
        jp z,.4
        jp .8   ; Derecha

        ;
        ; Temblor hacia abajo
        ;
.0:     ld a,(ix+d_temblor)
        dec a
        ld (ix+d_temblor),a
        cp 7
        jp z,.2
        cp 3
        ret nz
        ;
        ; Mueve la pantalla una l¡nea hacia arriba
        ;
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld hl,32
        add hl,de
        ld a,11
.1:     ld bc,24
        ldir
        ld bc,8
        add hl,bc
        ex de,hl
        add hl,bc
        ex de,hl
        dec a
        jp nz,.1
        ; Restaura l¡nea desaparecida
        ld l,(ix+d_linea)
        ld h,(ix+d_linea+1)
        ld bc,24
        ldir
        ; Desplaza el transportador si hay uno
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        ret z
        ld de,-32
        add hl,de
        ld (ix+d_trans),l
        ld (ix+d_trans+1),h
        ret

        ;
        ; Mueve la pantalla una l¡nea hacia abajo
        ;
.2:     ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld hl,352
        add hl,de
        ld e,(ix+d_linea)
        ld d,(ix+d_linea+1)
        ld bc,24
        ldir
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld bc,408
        ex de,hl
        add hl,bc
        ex de,hl
        ld a,11
.3:     ld bc,-56
        add hl,bc
        ex de,hl
        add hl,bc
        ex de,hl
        ld bc,24
        ldir
        dec a
        jp nz,.3
        ld bc,-56
        ex de,hl
        add hl,bc
        ld b,24
        xor a           ; Llena la l¡nea de arriba con negro
        ld (hl),a
        inc hl
        djnz $-2
        ; Desplaza el transportador si hay uno
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        ret z
        ld de,32
        add hl,de
        ld (ix+d_trans),l
        ld (ix+d_trans+1),h
        ret

        ;
        ; Temblor hacia la izquierda
        ;
.4:     ld a,(ix+d_temblor)
        dec a
        ld (ix+d_temblor),a
        cp 7
        jp z,.6
        cp 3
        ret nz
        ;
        ; Mueve la pantalla una columna hacia la derecha
        ;
        exx
        ld l,(ix+d_linea)
        ld h,(ix+d_linea+1)
        exx
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld hl,22
        add hl,de
        ld e,l
        ld d,h
        inc de
        ld a,12
.5:     ex af,af'
        ld bc,23
        lddr
        exx
        ld a,(hl)
        inc hl
        exx
        ld (de),a
        ld bc,55
        add hl,bc
        ex de,hl
        add hl,bc
        ex de,hl
        ex af,af'
        dec a
        jp nz,.5
        ; Desplaza el transportador si hay uno
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        ret z
        inc (ix+d_trans)
        ret

        ;
        ; Mueve la pantalla una columna a la izquierda
        ;
.6:     exx
        ld l,(ix+d_linea)
        ld h,(ix+d_linea+1)
        exx
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld l,e
        ld h,d
        inc hl
        ld a,12
.7:     ex af,af'
        ld a,(de)
        exx
        ld (hl),a
        inc hl
        exx
        ld bc,23
        ldir
        xor a
        ld (de),a
        ld bc,9
        add hl,bc
        ex de,hl
        add hl,bc
        ex de,hl
        ex af,af'
        dec a
        jp nz,.7
        ; Desplaza el transportador si hay uno
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        ret z
        dec (ix+d_trans)
        ret

        ;
        ; Temblor hacia la derecha
        ;
.8:     ld a,(ix+d_temblor)
        dec a
        ld (ix+d_temblor),a
        cp 7
        jp z,.10
        cp 3
        ret nz
        ;
        ; Mueve la pantalla una columna hacia la izquierda
        ;
        exx
        ld l,(ix+d_linea)
        ld h,(ix+d_linea+1)
        exx
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld l,e
        ld h,d
        inc hl
        ld a,12
.9:     ex af,af'
        ld bc,23
        ldir
        exx
        ld a,(hl)
        inc hl
        exx
        ld (de),a
        ld bc,9
        add hl,bc
        ex de,hl
        add hl,bc
        ex de,hl
        ex af,af'
        dec a
        jp nz,.9
        ; Desplaza el transportador si hay uno
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        ret z
        dec (ix+d_trans)
        ret

        ;
        ; Mueve la pantalla una columna a la derecha
        ;
.10:    exx
        ld l,(ix+d_linea)
        ld h,(ix+d_linea+1)
        exx
        ld e,(ix+d_offset)
        ld d,(ix+d_offset+1)
        ld hl,22
        add hl,de
        ld e,l
        ld d,h
        inc de
        ld a,12
.11:    ex af,af'
        ld a,(de)
        exx
        ld (hl),a
        inc hl
        exx
        ld bc,23
        lddr
        xor a
        ld (de),a
        ld bc,55
        add hl,bc
        ex de,hl
        add hl,bc
        ex de,hl
        ex af,af'
        dec a
        jp nz,.11
        ; Desplaza el transportador si hay uno
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        ret z
        inc (ix+d_trans)
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
        dw vector_cortina
        dw vector_persiana
        dw vector_borde

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
        jp z,.8
        cp $04
        ld bc,$0607
        jp z,.8
        cp $08
        ld bc,$0807
        jp z,.8
        ld bc,$0907
.8:     call WRTVDP

        ;
        ; Solo en el modo de juego se mete con el VDP
        ;
vector_principal:
        ld hl,modo
        bit 0,(hl)      ; ¨Controlar VDP?
        jp z,vector_quieto ; No, salta a contar ticks y generar sonido
        bit 2,(hl)      ; ¨Definir sprites (modo de juego) ?
        jp z,vector_presentacion        ; No, salta.
        ld a,(ticks)
        rrca
        jp c,.0
        ;
        ; Tick 0 - Redefine sprites y actualiza sprites
        ; Tick 2 - Redefine sprites y actualiza sprites
        ;
        ;
        ; Obtiene los sprites que est n usando los h‚roes...
        ;
        ld bc,sprites_heroes
        ld hl,(sprites_especiales+0)
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,bc
        ex de,hl
        ld hl,(sprites_especiales+2)
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
        call SETWRT
        ld h,b
        ld l,c
        ex de,hl
        ld bc,$2098
        outi
        jp nz,$-2
        ex de,hl
        ld b,32
        outi
        jp nz,$-2
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
        call SETWRT
        ld h,b
        ld l,c
        ex de,hl
        ld bc,$8098
        outi
        jp nz,$-2
        ex de,hl
        ld b,128
        outi
        jp nz,$-2
        ;
        ; Actualiza los sprites
        ;
        ld hl,$3f80
        call SETWRT
        ld hl,sprites
        ld bc,$7098
        outi
        jp nz,$-2
        ld hl,modo
        res 7,(hl)
        jp vector_sonido

        ;
        ; Actualiza los sprites (ticks 1 y 3)
        ;
.0:     ld hl,$3f80
        call SETWRT
    if 0
        ;
        ; Ahora es innecesario, pues acomod‚ el sprite del cuerpo y de la
        ; cara, m s la bala, para que no ocurra parpadeo.
        ;
        ld hl,sprites
        ld bc,$1098
        outi
        jp nz,$-2
        ld hl,sprites+108
        ld bc,$0498
        outi
        jp nz,$-2
        ld a,l
        sub 8
        ld l,a
        cp 12
        jp nz,$-13
    else
        ld hl,sprites
        ld bc,$7098
        outi
        jp nz,$-2
    endif
        ;
        ; Solo puede actualizar media pantalla
        ; tick 1 = Pantalla superior
        ; tick 3 = Pantalla inferior
        ;
        ld a,(ticks)
        and 2
        ld hl,$3c00
        ld de,pantalla
        jp z,.1
        ld hl,$3d80
        ld de,pantalla+384
.1:     call SETWRT
        ex de,hl
        ld bc,$8098
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        ld b,128
        outi
        jp nz,$-2
        ld hl,modo
        res 7,(hl)
        jp vector_sonido

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
.1:     call genera_sonido
        ;
        ; Incrementa ticks transcurridos
        ;
        ld hl,(ticks)
        inc hl
        ld (ticks),hl
        ;
        ; Explora el teclado
        ;
        ; Primero salva la matriz completa, £til para verificar
        ; combinaci¢n WASD+Tab al mover jugador 2
        ;
explora_teclado:
        ld hl,matriz
        ld de,$0008
.0:     ld a,d
        call SNSMAT
        ld (hl),a
        inc hl
        inc d
        dec e
        jp nz,.0
        ;
        ; Anula algunas teclas
        ;
        ld a,(matriz+6)
        or $1f
        ld (matriz+6),a
        ld a,(matriz+7)
        or $70
        ld (matriz+7),a
        ;
        ; Seudodecodificaci¢n del teclado
        ;
        ld hl,matriz
        ld bc,$0800
.3:     ld a,(hl)
        cp $ff
        jp nz,.1
        inc hl
        ld a,c
        add a,8
        ld c,a
        djnz .3
        ld a,$ff
        ld (tecla),a
        ld (tecla2),a
        ld hl,conteo
        ld a,(hl)
        or a
        ret z
        dec (hl)
        ret

.1:     rrca
        jp nc,.2
        inc c
        jp .1

.2:     ld a,c
        ld (tecla2),a   ; Anota tecla actual sin antirebote
        ld a,(conteo)
        or a
        ld a,3
        ld (conteo),a
        ret nz          ; ¨Antirebote listo?, no retorna
        ld a,c
        ld (tecla),a    ; Anota nueva tecla con antirebote
        ret

        ;
        ; Pantalla negra
        ; Realiza una secuencia de cortina de izquierda a derecha
        ;
PANTALLA_NEGRA:
        LD HL,modo
        RES 0,(HL)
        ld bc,$0107     ; Reinicia borde a negro
        call WRTVDP
        ;
        ; El caracter 0 en todas las p ginas lo vuelve un bloque negro
        ;
        LD HL,$2000
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$2800
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$3000
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$0000
        LD BC,8
        XOR A
        CALL FILVRM
        LD HL,$0800
        LD BC,8
        XOR A
        CALL FILVRM
        LD HL,$1000
        LD BC,8
        XOR A
        CALL FILVRM
        LD DE,32
        LD C,32         ; 32 columnas
        ;
        ; Bucle de cortina
        ;
PANTALLA_NEGRA3:
        LD H,$3C
        LD A,32
        SUB C
        LD L,A
        LD B,24         ; 24 l¡neas
        XOR A
PANTALLA_NEGRA2:
        CALL WRTVRM
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
        LD HL,$0000     ; Patrones
        LD BC,6144
        XOR A
        CALL FILVRM
        LD HL,$2000     ; Colores
        LD BC,6144
        XOR A
        CALL FILVRM
        LD HL,pantalla  ; Buffer de pantalla
PANTALLA_NEGRA1:
        LD (HL),L
        INC HL
        LD A,H
        CP (pantalla+768)>>8
        JR NZ,PANTALLA_NEGRA1
PANTALLA_NEGRA0:
        LD HL,pantalla
        LD DE,$3C00     ; Pantalla real
        LD BC,768
        JP LDIRVM

        ;
        ; Pantalla negra r pida
        ; Lo mismo que la otra rutina, pero sin la cortina
        ;
PANTALLA_NEGRA_RAPIDA:
        LD HL,modo
        RES 0,(HL)
        LD HL,$2000
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$2800
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$3000
        LD BC,8
        LD A,$F1
        CALL FILVRM
        LD HL,$0000
        LD BC,8
        XOR A
        CALL FILVRM
        LD HL,$0800
        LD BC,8
        XOR A
        CALL FILVRM
        LD HL,$1000
        LD BC,8
        XOR A
        CALL FILVRM
        LD HL,$3C00
        LD BC,$300
        XOR A
        CALL FILVRM
        LD HL,$0000
        LD BC,6144
        XOR A
        CALL FILVRM
        LD HL,$2000
        LD BC,6144
        XOR A
        CALL FILVRM
        LD HL,pantalla
        JP PANTALLA_NEGRA1

        ;
        ; Carga una toma de la historia
        ; (gr fica compactada)
        ;
        ; HL = Offset 64K
        ; E = P gina de MegaROM
        ; B = Estado de descarga (2 para cortina, 4 para persiana)
        ;
CARGAR_TOMA:
        LD A,H
        AND $E0
        OR E
        RLCA
        RLCA
        RLCA
        DI
        LD (L_PAGINA),A         ; Crea la p gina
        LD A,H
        AND $1F
        OR $A0                  ; Mapea direcci¢n a slot 3
        LD H,A
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
        LD A,(L_PAGINA)
        LD (SLOT3),A
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
        LD C,$08
        CALL LINEAS10           ; Descompacta bitmap
        SET 5,H
        CALL LINEAS10           ; Descompacta color
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
        CALL LINEAS10           ; Descompacta bitmap
        SET 5,H
        CALL LINEAS10           ; Descompacta color
    IF 0
        ;
        ; C¢digo antiguo 
        ;
        LD A,(L_LINEA)
        CP 63
        JR NZ,LINEAS0
        LD HL,$1000
        LD BC,$0808
LINEAS9:
        PUSH BC
        CALL LINEAS10
        SET 5,H
        CALL LINEAS10
        RES 5,H
        POP BC
        INC L
        LD A,L
        CP 8
        JR NZ,LINEAS9
        LD L,0
        INC H
        DJNZ LINEAS9
LINEAS0:
    ENDIF
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
        LD A,(L_PAGINA)
        LD (SLOT3),A
        CALL LINEAS1    ; Descompacta 3 l¡neas separadas por 7 pixeles
        LD HL,L_LINEA
        INC (HL)
        LD (L_OFFSET),DE
        RET

        ;
        ; Descompacta l¡neas separadas en Y, Y+8 e Y+16
        ;
LINEAS1:
        LD BC,$0308
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
        ; Descompactaci¢n RLE
        ;
        ; Es com£n la secuencia:
        ;   INC DE
        ;   BIT 6,D
        ;   CALL NZ,LINEAS7
        ;
        ; Es para detectar si el apuntador de descompactaci¢n sale
        ; del slot de 8K y pasar a la siguiente p gina.
        ;
        ; Ordenes:
        ;  00     =  Final
        ;  01-7F  =  Copia 1 a 127 veces.
        ;  FE-80  =  Repite 1 a 127 veces.
        ;  FF     =  Sin uso.
        ;
LINEAS10:
        LD A,(DE)
        INC DE
        OR A                    ; ¨Fin de tramo?
        JP NZ,LINEAS5+2         ; No, contin£a
        BIT 6,D
        CALL NZ,LINEAS7         
        RET
LINEAS5:
        LD A,(DE)               ; Obtiene orden
        INC DE
        OR A                    ; ¨ $00-$7F ?
        JP P,LINEAS2            ; S¡, salta
        CPL                   
        LD B,A
        BIT 6,D
        CALL NZ,LINEAS7
        LD A,(DE)
        INC DE
        EX AF,AF'
        BIT 6,D
        CALL NZ,LINEAS7
LINEAS3:
        CALL SETWRT
        LD A,L
        EX AF,AF'
        OUT ($98),A
        EX AF,AF'
        ADD A,C
        LD L,A
        DJNZ LINEAS3
        RET C                   ; Retorna si termin¢ la l¡nea
        JP LINEAS5
LINEAS2:
        LD B,A
        BIT 6,D
        CALL NZ,LINEAS7
LINEAS4:
        CALL SETWRT
        LD A,(DE)
        INC DE
        OUT ($98),A
        BIT 6,D
        CALL NZ,LINEAS7
        LD A,L
        ADD A,C
        LD L,A
        DJNZ LINEAS4
        RET C                   ; Retorna si termin¢ la l¡nea
        JP LINEAS5

        ;
        ; Cambia a siguiente slot, no es necesario que sea r pida,
        ; raramente ocurre
        ;
LINEAS7:
        LD A,(L_PAGINA)
        INC A
        LD (L_PAGINA),A
        LD DE,SLOT3
        LD (DE),A
    IF SLOT3<>$A000
        LD DE,$A000    
    ENDIF
        RET

        ;
        ; Visualiza un mensaje multiidioma
        ;
visual_mensaje_idioma:
        ld a,$08
        ld (SLOT3),a
        ld a,(idioma)
        or a
        jp z,visual_mensaje
        ; Brinca el mensaje en ingl‚s para alcanzar el espa¤ol.
.1:     ld a,(de)
        inc de
        inc a
        jp nz,.1

        ;
        ; Visualiza un mensaje
        ; HL = Dir. VRAM
        ; DE = Ap. a mensaje (terminado en FF, FE=cambio del linea)
        ;
VISUAL_MENSAJE:
        PUSH HL
        LD HL,modo
        RES 0,(HL)
        POP HL
        LD C,$21                ; Verdes para letra inicial
.1:     PUSH HL
        CALL VISUAL_LINEA       ; Visualiza una l¡nea
        POP HL
        INC H                   ; Pasa a siguiente l¡nea
        CP $FE                  ; ¨Acab¢ el mensaje?
        JP Z,.1                 ; No, contin£a
        LD HL,modo
        SET 0,(HL)
        RET

        ;
        ; Visualiza letras
        ; HL = Destino en VRAM
        ; DE = Mensaje terminado en $FE o $FF
        ; C = Color base (se har  OR $10 para brillante)
        ;
visual_color:
        ld a,(de)
        inc de
        cp $fe
        ret nc
        call visual_letra
        jp visual_color

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
        LD A,(DE)
        INC DE
        CP $FE
        RET NC
        CP $40
        CALL NC,deriva_numero
        CALL VISUAL_LETRA
        LD C,$a1
        JP VISUAL_LINEA

        ;
        ; Deriva n£mero
        ;
deriva_numero:
        ld a,(ix+d_rescatados)
        jp nz,.1        ; Salta si es d¡gito bajo ($41)
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
        EX DE,HL
        LD L,A
        LD H,0
        ADD HL,HL
        ADD HL,HL
        ADD HL,HL
        LD A,L
        ADD A,LETRAS AND 255
        LD L,A
        LD A,H
        ADC A,LETRAS>>8
        LD H,A
        EX DE,HL
        ;
        ; Copia bitmap de la letra
        ;
        LD B,8
VISUAL_LETRA1:
        LD A,(DE)
        CALL WRTVRM
        INC DE
        INC HL
        DJNZ VISUAL_LETRA1
        POP HL
        ;
        ; Pone color de la letra
        ;
        PUSH HL
        SET 5,H
        LD A,$F1        ; El primer pixel es brillante :)
        CALL WRTVRM
        INC HL
        LD B,5
        LD A,C
        OR $10          ; Color brillante para siguientes 5 l¡neas
VISUAL_LETRA2:
        CALL WRTVRM
        INC HL
        DJNZ VISUAL_LETRA2
        LD A,C          ; Ultimas dos en obscuro
        CALL WRTVRM
        INC HL
        CALL WRTVRM
        POP HL
        PUSH HL
        SRL H
        RR L
        SRL H
        RR L
        SRL H
        RR L
        LD DE,pantalla
        ADD HL,DE
        LD (HL),L       ; Anota en pantalla oculta para actualizar
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
        ; Carga los sprites fijos
        ;
        LD HL,figuras_sprites
        LD DE,$1800
        LD BC,$0780
        CALL LDIRVM
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
        ;
        ; Carga una paleta de lujo en MSX2
        ;
        ld a,($002d)    ; Obtiene modelo de MSX
        or a            ; ¨MSX 1?
        ret z           ; S¡, retorna
        xor a           ; Indice de paleta
        out ($99),a
        ld a,$90        ; Registro de indice de paleta
        out ($99),a
        ld hl,paleta
        ld bc,$209a     ; 32 bytes por la puerta $9A
        otir
        ret

        ; Formato de color:
        ;
        ; bit 7 6 5 4 3 2 1 0
        ;     0 r r r 0 a a a - byte 0
        ;     0 0 0 0 0 v v v - byte 1
paleta:
        db $00,$00      ; 0 - Transparente
        db $00,$00      ; 1 - Negro
        db $22,$05      ; 2 - Verde medio
        db $33,$06      ; 3 - Verde claro
        db $06,$00      ; 4 - Azul profundo
        db $27,$03      ; 5 - Azul claro
        db $51,$01      ; 6 - Cafe
        db $27,$06      ; 7 - Cielo
        db $63,$02      ; 8 - Rosado obscuro (para caras)
        db $74,$03      ; 9 - Rosado claro (para caras)
        db $60,$05      ; 10 - Amarillo
        db $64,$06      ; 11 - Amarillo claro
        db $11,$04      ; 12 - Verde obscuro
        db $55,$00      ; 13 - Morado
        db $55,$05      ; 14 - Gris
        db $77,$07      ; 15 - Blanco

        ;
        ; Trucos del juego
        ;
truquitos:
        push af
        ld a,$ff
        ld (tecla),a
        ld a,(truco)
        add a,a
        add a,a
        add a,a
        ld e,a
        ld d,0
        ld hl,lista_trucos
        add hl,de
        pop af
        ld c,a
        ld b,4
.1:     ld a,(hl)
        cp c            ; ¨Tecla?
        jp nz,.2
        inc hl
        ld a,(hl)
        cp $f0
        jp c,.3
        jp nz,.4
        ;
        ; CONEJO
        ;
        ld a,1
        ld (jug1+d_velocidad),a
        ld (jug2+d_velocidad),a
        call efecto_rescate
        jp .0

.4:     sub $f1
        jp nz,.5
        ;
        ; GANZUA
        ;
        ld ix,jug1
        set 0,(ix+d_objeto)
        ld ix,jug2
        set 0,(ix+d_objeto)
        call efecto_llave
        jp .0

.5:     dec a
        jp nz,.6
        ;
        ; MAXIMO
        ;
        ld a,6
        ld (jug1+d_energia),a
        ld (jug2+d_energia),a
        call efecto_vida
.0:     xor a
        ld ix,jug1
        ld (ix+d_puntos),a
        ld (ix+d_puntos+1),a
        ld (ix+d_puntos+2),a
        call actualiza_indicadores
        xor a
        ld ix,jug2
        ld (ix+d_puntos),a
        ld (ix+d_puntos+1),a
        ld (ix+d_puntos+2),a
        call actualiza_indicadores
        xor a
.3:     ld (truco),a
        ret

        ;
        ; OSCURO
        ;
.6:     ld a,1                  ; Negro para chico
        ld (jug1+d_color),a
        ld a,6                  ; Rojo obscuro para chica
        ld (jug2+d_color),a
        jp .0

.2:     inc hl
        inc hl
        dec b
        jp nz,.1
        xor a           ; Reinicia trucos
        ld (truco),a
        ret

        ;
        ; Trucos para Zombie Near
        ; CONEJO - Velocidad de jugadores al doble
        ; GANZUA - Llave para ambos
        ; MAXIMO - Energ¡a al m ximo
        ; OSCURO - Esquema de color obscuro (prueba)
        ;
        ; $16 A   $17 B   $18 C   $19 D
        ; $1A E   $1B F   $1C G   $1D H
        ; $1E I   $1F J   $20 K   $21 L
        ; $22 M   $23 N   $24 O   $25 P
        ; $26 Q   $27 R   $28 S   $29 T
        ; $2A U   $2B V   $2C W   $2D X
        ; $2E Y   $2F Z
lista_trucos:
        ; estado 0
        db $18,1,$1C,6,$22,11,$24,19
        ; estado 1
        db $24,2,-1,0,-1,0,-1,0
        ; estado 2
        db $23,3,-1,0,-1,0,-1,0
        ; estado 3
        db $1a,4,-1,0,-1,0,-1,0
        ; estado 4
        db $1f,5,-1,0,-1,0,-1,0
        ; estado 5
        db $24,16,-1,0,-1,0,-1,0
        ; estado 6
        db -1,0,$16,7,-1,0,-1,0
        ; estado 7
        db -1,0,$23,8,-1,0,-1,0
        ; estado 8
        db -1,0,$2F,9,-1,0,-1,0
        ; estado 9
        db -1,0,$2A,10,-1,0,-1,0
        ; estado 10
        db -1,0,$16,17,-1,0,-1,0
        ; estado 11
        db -1,0,-1,0,$16,12,-1,0
        ; estado 12
        db -1,0,-1,0,$2d,13,-1,0
        ; estado 13
        db -1,0,-1,0,$1e,14,-1,0
        ; estado 14
        db -1,0,-1,0,$22,15,-1,0
        ; estado 15
        db -1,0,-1,0,$24,18,-1,0
        ; estado 16
        db $3f,$f0,-1,0,-1,0,-1,0
        ; estado 17
        db $3f,$f1,-1,0,-1,0,-1,0
        ; estado 18
        db $3f,$f2,-1,0,-1,0,-1,0
        ; estado 19
        db $28,20,-1,0,-1,0,-1,0
        ; estado 20
        db $18,21,-1,0,-1,0,-1,0
        ; estado 21
        db $2a,22,-1,0,-1,0,-1,0
        ; estado 22
        db $27,23,-1,0,-1,0,-1,0
        ; estado 23
        db $24,24,-1,0,-1,0,-1,0
        ; estado 24
        db $3f,$f3,-1,0,-1,0,-1,0

        ;
        ; Checa si se oprimi¢ F1 para hacer pausa
        ; Checa si se oprimi¢ F2 para activar/desactivar sonido
        ;
checa_pausa:
    if 0        ; Para probar el efecto de temblor
        ld a,(tecla)
        cp $37
        jp nz,.123
        ld a,$ff
        ld (tecla),a
        ld a,4
        ld (jug1+d_temblor),a
.123:
    endif
        ld a,(depura)
        cp 3            ; ¨Llave activada?
        jp nz,.2
        ld a,(tecla)
        cp $3f          ; Enter
        jp z,truquitos
        cp $30          ; Teclas normales
        jp c,truquitos
.2:     ld a,(tecla)
        cp $36          ; ¨F2?
    if 0
        jp z,experimento_historia
    endif
        jp nz,.0
        ld a,$ff
        ld (tecla),a
        ld a,(modo)
        xor $10         ; Activa/desactiva sonido
        ld (modo),a
.0:     ld a,(tecla)
        cp $35          ; F1
        ret nz          ; ¨Oprimido?, no, retorna
        ld a,$ff
        ld (tecla),a
        ld hl,modo
        set 1,(hl)      ; Desactiva sonido
        ;
        ; Salva contenido de pantalla oculta
        ;
        ld hl,pantalla+$016c
        ld b,7
.4:     ld a,(hl)
        push af
        inc hl
        djnz .4
        ;
        ; Antirebote
        ;
        call pausa_1
        ld b,10
.1:     halt
        djnz .1
        ;
        ; Lazo principal de pausa
        ;
.3:     ld a,(ticks)
        and $10
        jp z,.6
        call pausa_1
        jp .7

.6:     call pausa_2
.7:     halt
        ld a,(tecla)
        cp $35          ; ¨F1 oprimido?
        jp nz,.3        ; No, sigue esperando
        ld a,$ff
        ld (tecla),a
        ;
        ; Restaura pantalla
        ;
        ld hl,pantalla+$0172
        ld b,7
.5:     pop af
        ld (hl),a
        dec hl
        djnz .5
        ;
        ; Antirebote
        ;
        ld b,10
.9:     halt
        djnz .9
        ld hl,modo
        res 1,(hl)      ; Reactiva sonido
        ret

pausa_1:
        ld hl,pantalla+$016c
        ld (hl),0
        inc hl
        ld (hl),$10     ; P
        inc hl
        ld (hl),$01     ; A
        inc hl
        ld (hl),$15     ; U
        inc hl
        ld (hl),$13     ; S
        inc hl
        ld a,(idioma)
        or a
        ld (hl),$05     ; E
        jp z,$+5
        ld (hl),$01     ; A
        inc hl
        ld (hl),0
        ret

pausa_2:
        ld hl,pantalla+$016c
        xor a
        ld b,7
.1:     ld (hl),a
        inc hl
        djnz .1
        ret

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
        ld a,(ix+d_nivel)
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        ld d,h
        ld e,l
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,de
        ld a,(ix+d_seccion)
        and $30
        ld de,mapa1
        ld b,$05
        jp z,.4
        ld de,mapa2
        ld b,$06
        cp $10
        jp z,.4
        ld de,mapa3
        ld b,$07
.4:     add hl,de
        ;
        ; Selecciona slot ROM y copia a RAM
        ;
        di
        ld a,b
        ld (SLOT3),a
        ld a,h
        and $1f
        or $a0
        ld h,a
        ld e,(ix+d_real)
        ld d,(ix+d_real+1)
        push de
        ld bc,12*6
        ldir
        pop hl
        ei
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
        cp 99
        call z,inicio_jugador
        cp 98
        call z,final_jugador
        cp 97
        call z,anota_transportador
        cp 90
        call nc,agrega_monigote
        cp 87
        call nc,agrega_adorno
        cp 79
        call nc,agrega_monigote
        cp 78
        call nc,agrega_adorno
        cp 72
        call nc,agrega_monigote
        cp 67
        call nc,agrega_adorno
        cp 50
        call nc,mosaico_especial
        add a,a
        add a,a
        add a,BASE_MOSAICOS
        ld (de),a
        inc de
        inc a
        ld (de),a
        ex de,hl
        ld bc,31
        add hl,bc
        inc a
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
        ld bc,-31
        add hl,bc
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
        ; Anota el inicio de un jugador
        ;
inicio_jugador:
        ld a,12
        sub b
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refx)
        ld (ix+d_x),a
        ld (ix+d_basex),a
        ld a,6
        sub c
        add a,a
        add a,a
        add a,a
        add a,a
        add a,(ix+d_refy)
        ld (ix+d_y),a
        ld (ix+d_basey),a
final_jugador:
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
        jp z,agrega_objeto
        ld de,-16
        add hl,de
        jp .1

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
        jp z,agrega_objeto
        ld de,16
        add hl,de
        jp .1

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
        push hl
        sub 67
        ld hl,tabla_monigotes
        add a,a
        ld e,a
        ld d,0
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ex (sp),hl
        ret

tabla_monigotes:
        dw pascua       ; 67 Adorno gen‚rico
        dw pascua       ; 68 Adorno gen‚rico
        dw pascua       ; 69 Adorno gen‚rico
        dw pascua       ; 70 Adorno gen‚rico
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
        dw nada         ; 97 Puerta con llave
        dw nada         ; 98 Conexi¢n con otro piso
        dw nada         ; 99 Sin uso

pascua:
        ld a,e
        add a,a
        add a,$ac
        ex af,af'
        ld a,15
adorno:
        ex af,af'
        ld de,$0000
        ld bc,$0105
        jp anota_monigote

jefe:
        ld a,$90
        jp personaje

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
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        ld hl,300
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        call musica_esperando
        pop hl
        pop de
        pop bc
        ld a,20 ; Puerta oeste
        ret

entrada2:
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        ld hl,300
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        call musica_esperando
        pop hl
        pop de
        pop bc
        ld a,40 ; Puerta sur
        ret
               
entrada3:
        xor a
        dec hl
        ld (hl),a
        dec hl
        ld (hl),a
        ld hl,300
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
        call musica_esperando
        pop hl
        pop de
        pop bc
        ld a,21 ; Puerta norte
        ret
               
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

vida:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 1,(hl)      ; ¨Ya tomada?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
        ld a,$3c
        ld de,$0000
        ld bc,$010b
        ex af,af'
        ld a,9
        ex af,af'
        jp anota_monigote

llave:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 2,(hl)      ; ¨Ya usada?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
        ld a,$10
        ld de,$0000
        ld bc,$0107
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

cientifico:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 0,(hl)      ; ¨Ya rescatado?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
        ld a,$30
        ld de,$0000
        ld bc,$0306
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

cientifica:
        ld c,(ix+d_nivel)
        ld b,0
        ld e,(ix+d_mapa)
        ld d,(ix+d_mapa+1)
        ex de,hl
        add hl,bc
        bit 0,(hl)      ; ¨Ya rescatada?
        ex de,hl
        jp nz,nada      ; S¡, ya no aparece
        ld a,$80
        ld de,$0000
        ld bc,$0306
        ex af,af'
        ld a,9
        ex af,af'
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
        jp zombie1

zombie1_aba:
        ld a,$60
        ld de,$0100
        jp zombie1

zombie1_izq:
        ld a,$50
        ld de,$00ff
        jp zombie1

zombie1_der:
        ld a,$40
        ld de,$0001
zombie1:
        ld bc,$0301
        ex af,af'
        ld a,3
        ex af,af'
        jp anota_monigote

zombie2_izq:
        ld a,$50
        ld de,$00ff
        jp zombie2

zombie2_der:
        ld a,$40
        ld de,$0001
        jp zombie2

zombie2_arr:
        ld a,$70
        ld de,$ff00
        jp zombie2

zombie2_aba:
        ld a,$60
        ld de,$0100
zombie2:
        ld bc,$0202
        ex af,af'
        ld a,11
        ex af,af'
        jp anota_monigote

zombie3_izq:
        ld a,$50
        ld de,$00ff
        jp zombie3

zombie3_der:
        ld a,$40
        ld de,$0001
        jp zombie3

zombie3_arr:
        ld a,$70
        ld de,$ff00
        jp zombie3

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
        inc hl
        inc hl
        inc hl
        ld a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,(ix+d_refy)
        ld (hl),a
        inc hl
        pop hl
        pop de
        pop bc
        ;
        ; No es posible poner fondo en el mismo cuadro cuando se escoge
        ; un objeto, adorno o monigote, as¡ que lo deriva de los
        ; alrededores
        ;
estima_cuadro:
        ld a,c
        cp 6
        jp z,.1
        push de
        push hl
        ld de,-12
        add hl,de
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.1:     ld a,b
        cp 12
        jp z,.2
        push de
        push hl
        dec hl
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.2:     ld a,b
        cp 1
        jp z,.3
        push de
        push hl
        inc hl
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.3:     ld a,c
        cp 1
        jp z,.4
        push de
        push hl
        ld de,12
        add hl,de
        ld e,(hl)
        ld d,0
        ld hl,caminable
        add hl,de
        bit 1,(hl)
        ld a,e
        pop hl
        pop de
        ret nz
.4:     xor a
        ret

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
        jp nz,.1
        ld de,25+32     ; Zona de indicadores del jugador 2
.1:     add hl,de
        ;
        ; Visualiza la puntuaci¢n actual
        ;
        push hl
        inc hl
        inc hl
        ld a,(ix+d_refy)
        or a
        ld a,$2B        ; 1
        jp z,.2
        ld a,$2C        ; 2
.2:     ld (hl),a
        inc hl
        ld (hl),$15     ; U
        inc hl
        ld (hl),$10     ; P
        pop hl
        ld de,32
        add hl,de
        push hl
        ld a,(ix+d_puntos)
        call dos_digitos
        ld a,(ix+d_puntos+1)
        call dos_digitos
        ld a,(ix+d_puntos+2)
        call dos_digitos
        ld (hl),$20     ; Un cero de relleno
        pop hl
        ld de,64        ; Separa una l¡nea
        add hl,de
        ;
        ; Visualiza la energ¡a actual
        ;
        push hl
        ld (hl),$05     ; E
        inc hl
        ld (hl),$0e     ; N
        inc hl
        ld (hl),$05     ; E
        inc hl
        ld (hl),$12     ; R
        inc hl
        ld (hl),$07     ; G
        inc hl
        ld a,(idioma)
        or a
        ld (hl),$19     ; Y
        jp z,.8
        ld (hl),$09     ; I
        inc hl
        ld (hl),$01     ; A
.8:     pop hl
        ld de,32
        add hl,de
        push hl
        ld a,(ix+d_energia)
        or a
        ld b,a
        ld a,$1c
        jp z,.3
        ld a,$1b
.3:     ld (hl),a
        inc hl
        ld c,1
.4:     inc c
        ld a,b
        cp c
        ld a,$1e
        jp c,.5
        ld a,$1d
.5:     ld (hl),a
        inc hl
        ld a,c
        cp 6
        jp nz,.4
        ld (hl),$1f
        pop hl
        ld de,64        ; Separa una l¡nea
        add hl,de
        ;
        ; Visualiza el piso actual
        ;
        push hl
        inc hl
        ld a,(idioma)
        or a
        jp z,.9
        ld (hl),$0e     ; N
        inc hl
        ld (hl),$09     ; I
        inc hl
        ld (hl),$16     ; V
        inc hl
        ld (hl),$05     ; E
        inc hl
        ld (hl),$0c     ; L
        jp .10

.9:     ld (hl),$06     ; F
        inc hl
        ld (hl),$0C     ; L
        inc hl
        ld (hl),$0F     ; O
        inc hl
        ld (hl),$0F     ; O
        inc hl
        ld (hl),$12     ; R
.10:    pop hl
        ld de,32
        add hl,de
        push hl
        inc hl
        ld a,(ix+d_refy)
        or a
        ld a,$32        ; A
        jp z,.7
        ld a,$33        ; B
.7:     ld (hl),a
        inc hl
        ld (hl),$34     ; -
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
        call digito_decimal
        push af
        dec hl
        ld a,(hl)
        add a,d
        ld (hl),a
        inc hl
        pop af
        ld b,10
        call digito_decimal
        ld b,1
        call digito_decimal
        pop hl
        ld de,65        ; Separa una l¡nea
        add hl,de
        ;
        ; Indica el n£mero de vidas y muestra la llave (si la trae)
        ;
        ld a,(ix+d_vidas)
        add a,$20
        ld (hl),a
        inc hl
        inc hl
        ld (hl),$2a     ; Corazoncito
        inc hl
        inc hl
        bit 0,(ix+d_objeto)
        ld (hl),$00
        ret z
        ld (hl),$2d     ; Llave
        ret

        ;
        ; Digito decimal
        ;
digito_decimal:
        ld c,$1f
.1:     inc c
        sub b
        jp nc,.1
        add a,b
        ld (hl),c
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
        ld (sprites_especiales+0),hl
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
        ld (sprites_especiales+2),hl
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
        bit 5,(ix+d_objeto)     ; ¨Muerto?
        jp nz,.9        ; S¡, no actualiza y de una vez desaparece jugador
        bit 7,(ix+d_objeto)     ; ¨Victoria?
        jp nz,.9        ; S¡, no actualiza y de una vez desaparece jugador
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        jp nz,.9        ; S¡, no actualiza y de una vez desaparece jugador
        ld l,(ix+d_trans)
        ld h,(ix+d_trans+1)
        ld a,h
        or l
        jp z,.7
        push de
        ld a,(ticks)
        and $0c         ; No debe ser m s r pido o no se notar  cambio.
        add a,BASE_MOSAICOS+$90
        ld d,a
        ld (hl),d
        inc hl
        inc d
        ld a,l
        and $1f
        jp z,.14
        cp $18          ; ¨En borde? puede suceder por temblor
        jp z,.14        ; Si, no actualiza
        ld (hl),d
.14:    ld a,d
        ld de,31
        add hl,de
        ld d,a
        inc d
        ld (hl),d
        inc d
        inc hl
        ld a,l
        and $1f
        jp z,.15
        cp $18          ; ¨En borde? puede suceder por temblor
        jp z,.15        ; Si, no actualiza
        ld (hl),d
.15:    pop de
        ;
        ; Actualiza el sprite correspondiente al jugador
        ;
.7:
        ; Ya comprobado antes
;        ld a,(ix+d_estado)
;        or a                    ; ¨En historia?
;        jp nz,.9                ; S¡, desaparece
;        bit 7,(ix+d_objeto)     ; ¨Triunfo?
;        jp nz,.9
        ld a,(ix+d_vidas)
        inc a ; cp $ff           ; ¨Muerto?
        jp nz,.1
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
        jp z,.6
        ld a,$0f
.6:     ld (de),a
        inc de
        ;
        ; Le pone su carita
        ;
        ld a,(ix+d_refx)
        or a
        ld a,(sprites_especiales+0)
        jp z,.16
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
        jp nz,.13       ; S¡, no actualiza
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
        jp nz,.4        ; S¡, salta.
.13:    ld a,$d1
        ld (de),a
        inc de
        inc de
        inc de
        inc de
        ld bc,16
        add hl,bc
        jp .5

.4:     ld c,5          ; Desplazamiento sprite bala/explosi¢n.
        cp 8
        jp z,.8
        cp 9
        jp z,.8
        ld c,-1         ; Desplazamiento sprite com£n
        cp 4            ; ¨Jefe zombie?
        jp nz,.8
        inc hl
        inc hl
        ld a,(ix+d_refx)
        or a
        ld a,(hl)
        jp nz,.11
        push hl
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        ld (sprites_especiales+4),hl
        pop hl           
        ex af,af'
        ld a,$e0        ; Sprite definido 1
        ex af,af'
        jp .10

.11:    push hl
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        ld (sprites_especiales+6),hl
        pop hl
        ex af,af'
        ld a,$f0        ; Sprite definido 2
        ex af,af'
.10:    add a,color_jefes and 255
        ld c,a
        ld a,color_jefes>>8
        adc a,0
        ld b,a
        dec hl
        dec hl
        ld a,(hl)
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        dec a
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
        ;
        ; Segundo cuadro en X+16,Y
        ;
        dec hl
        ld a,(hl)
        add a,16
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        dec a
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
        ;
        ; Tercer cuadro en X,Y+16
        ;
        dec hl
        ld a,(hl)
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        add a,15
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
        ;
        ; Cuarto cuadro en X+16,Y+16
        ;
        dec hl
        ld a,(hl)
        add a,16
        inc de
        ld (de),a
        dec de
        inc hl
        ld a,(hl)
        add a,15
        ld (de),a
        inc de
        inc de
        inc hl
        ex af,af'
        ld (de),a
        inc de
        inc hl
        ld a,(bc)
        ld (de),a
        inc de
        jp .12

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
        ld a,(hl)
        ld (de),a
        inc de
        inc hl
        ld a,(hl)
        ld (de),a
        inc de
.12:    ld bc,13
        add hl,bc
.5:     pop bc
        dec b
        jp nz,.3
        ret

        ;
        ; Colores de los jefes
        ;
color_jefes:
        ; Jefe zombie 1 izq.
        db 15,15,15,15
        db 15,15,15,15
        db 15,15,15,15
        db 15,15,15,15
        ; Jefe zombie 1 der.
        db 15,15,15,15
        db 15,15,15,15
        db 15,15,15,15
        db 15,15,15,15
        ; Jefe zombie 2 izq.
        db 11,10,10,10
        db 11,10,10,10
        db 11,10,10,10
        db 11,10,10,10
        ; Jefe zombie 2 der.
        db 10,11,10,10
        db 10,11,10,10
        db 10,11,10,10
        db 10,11,10,10
        ; Jefe zombie 3 izq.
        db 3,2,8,2
        db 3,2,8,2
        db 3,2,8,2
        db 3,2,8,2
        ; Jefe zombie 3 der.
        db 2,3,2,8
        db 2,3,2,8
        db 2,3,2,8
        db 2,3,2,8

        ;
        ; Maneja la entrada del usuario
        ;
maneja_entrada:
        ld ix,jug1
        ld a,(jug2+d_objeto)
        bit 6,a         ; ¨Jugador 2 activo?
        jp nz,.5        ; No, controla jugador 1 con teclado y joystick
        ld a,(jug1+d_objeto)
        bit 6,a         ; ¨Jugador 1 activo?
        jp z,.1         ; S¡, salta a dos jugadores.
        ;
        ; Solo el jugador 2 est  activo
        ; Controla con teclado y joystick
        ;
        ld ix,jug2
.5:     xor a           ; Barra de espacio
        call GTTRIG
        or a
        jp nz,.2
        ld a,1          ; Joystick 1, bot¢n A
        call GTTRIG
        or a
        jp nz,.2
        ld a,3          ; Joystick 1, bot¢n B
        call GTTRIG
        or a
        jp z,.3
.2:     call disparo
.3:     xor a           ; Teclas del cursor
        call GTSTCK
        or a
        jp nz,.4
        ld a,1          ; Joystick 1
        call GTSTCK
.4:     jp maneja_dir

        ;
        ; Modo de dos jugadores, el jugador 1 con teclado,
        ; el jugador 2 con joystick o WASD+Tab
        ;
.1:     ld ix,jug1
        xor a           ; Barra de espacio
        call GTTRIG
        or a
        call nz,disparo
        xor a           ; Teclas del cursor
        call GTSTCK
        call maneja_dir
        ld ix,jug2
        ld a,1          ; Joystick 1, bot¢n A
        call GTTRIG
        or a
        call nz,disparo
        ld a,3          ; Joystick 1, bot¢n B
        call GTTRIG
        or a
        call nz,disparo
        ld a,(matriz+7)
        and $08         ; TAB
        call z,disparo
        ld a,1          ; Joystick 1
        call GTSTCK
        or a
        jp nz,.6
        ld a,(TECLA2)
        ld b,1
        ld a,(matriz+5)
        and $10         ; W
        jp z,.7
        ld b,3
        ld a,(matriz+3)
        and $02         ; D
        jp z,.7
        ld b,5
        ld a,(matriz+5)
        and $01         ; S
        jp z,.7
        ld b,7
        ld a,(matriz+2)
        and $40         ; A
        jp z,.7
        ld b,0
.7:     ld a,b
.6:     jp maneja_dir

        ;
        ; El jugador dispara
        ;
disparo:
        ld a,(ix+d_vidas)
        inc a ; cp $ff  ; ¨Muerto?
        ret z           ; S¡, ignora
        bit 5,(ix+d_objeto)     ; ¨Muerto (temporalmente)?
        ret nz                  ; S¡, ignora
        bit 3,(ix+d_objeto)     ; ¨En secuencia autom tica 1?
        ret nz                  ; S¡, ignora
        bit 2,(ix+d_objeto)     ; ¨En secuencia autom tica 2?
        ret nz                  ; S¡, ignora.
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        ret nz          ; S¡, ignora
        ld a,(ix+d_recarga)
        or a            ; ¨Disparo listo?
        ret nz          ; No, ignora
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,9
        add hl,de
        ld a,(hl)       
        sbc hl,de       ; Siempre Carry es 0 (el add no provoca acarreo)
        or a            ; ¨A£n hay bala?
        ret nz          ; S¡, ignora disparo
        ld (ix+d_recarga),15
        ld a,(ix+d_sprite)
        and $30         ; ¨Mira a la derecha?
        ld de,$fe06
        ld bc,$0004
        jp z,.1
        cp $10          ; ¨Mira a la izquierda?
        ld de,$fefa
        ld bc,$00fc
        jp z,.1
        cp $30          ; ¨Mira arriba?
        ld de,$fa00
        ld bc,$fc00
        jp z,.1         ; o tal vez abajo.
        ld de,$0300
        ld bc,$0400
.1:     ld a,(ix+d_sprite)
        and $3c
        jp z,.2
        cp $10
        jp nz,.3
.2:     inc d           ; Tiene la cabeza baja.
.3:     push hl
        pop iy
        ld a,(ix+d_x)
        add a,e
        ld (iy+d_x),a
        ld a,(ix+d_y)
        add a,d
        ld (iy+d_y),a
        ld (iy+d_dx),c
        ld (iy+d_dy),b
        ld a,(ix+d_refx)
        ld (iy+d_refx),a
        ld a,(ix+d_refy)
        ld (iy+d_refy),a
        ld (iy+d_sprite),$08
        ld (iy+d_color),$0b
        ld (iy+d_velocidad),1
        ld (iy+d_paso),1
        ld (iy+d_tipo),8
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
        ld a,3                  ; Marcha a la derecha
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
        xor a                   ; Se queda quieto
        push af
        jp .2

        ;
        ; Comienza dialogo
        ; 
.4:     res 2,(ix+d_objeto)
        call musica_esperando
        ld a,(ix+d_seccion)
        and $30
        cp $10
        ld a,7
        jp z,.5
        ld a,17
.5:     call inicia_historia
        pop af
        ret

.2:
maneja_dir_2:   ; Para tener m s etiquetas
        bit 1,(ix+d_objeto)     ; ¨Puerta por restaurar?
        call nz,restaura_puerta 
        ;
        ; Cuenta el tiempo para que aparezca gran jefe o para
        ; que termine indicaci¢n de juego terminado.
        ;
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
        bit 5,(ix+d_objeto)     ; ¨Muerto temporalmente?
        jp z,.18
        res 5,(ix+d_objeto)
        call jugador_atrapado
        jp .9

.18:    call musica_batalla
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ld de,16
        add hl,de
        ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $60
        jp c,.10
        ;
        ; El jugador se halla a la derecha, nuestro
        ; amistoso monstruo le dar  una sorpresa a la izquierda.
        ;
        ld a,(ix+d_refx)
        ld (hl),a       ; Posici¢n X.
        inc hl
        ld a,(ix+d_refy)
        sub $20
        ld (hl),a       ; Posici¢n Y.
        inc hl
        ld (hl),$10     ; Sprite, andando a la derecha
        inc hl
        ld de,$0101
        jp .11

        ;
        ; El jugador se halla a la izquierda, nuestro
        ; amistoso monstruo caer  a la derecha
        ;
.10:    ld a,(ix+d_refx)
        add a,$a0
        ld (hl),a        ; Posici¢n X.
        inc hl
        ld a,(ix+d_refy)
        sub $20
        ld (hl),a       ; Posici¢n Y.
        inc hl
        ld (hl),$00     ; Sprite, andando a la izquierda
        inc hl
        ld de,$01ff

.11:    ld (hl),$0f     ; Color
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
        jp nz,.14
        ld (hl),50      ; 50 impactos para detener al jefe zombie.
.14:    inc hl
        ld (hl),1       ; Paso actual (copia de velocidad)
        inc hl
        ld (hl),4       ; Tipo de monigote
        inc hl
        xor a
        ld (hl),a       ; Ultimo movimiento
        inc hl
        ld a,(ix+d_nivel)
        cp 54           ; Piso 55, mapa 1
        ld d,$00
        jp z,.15
        cp 35           ; Piso 36, mapa 2
        ld d,$00
        jp z,.15
        cp 92           ; Piso 93, mapa 2
        ld d,$00
        jp z,.15
        cp 72           ; Piso 73, mapa 3
        ld d,$00
        jp z,.15
        cp 46           ; Piso 47, mapa 3
        ld d,$01
        jp z,.15
        cp 99           ; Piso 100, mapa 3
        ld d,$00
        jp z,.15
        ld a,(ix+d_seccion)
        and $30
        ld d,$00
        jp z,.15
        cp $10
        ld d,$21
        jp z,.15
        ld d,$43
    if 0
        ld d,$01        ; Jefe zombie que echa carrera
        ld d,$21        ; Chica zombie, carrera
        ld d,$43        ; Zombie malevolo que brinca y corre
        ld d,$00        ; Jefe zombie normal que brinca
    endif
.15:    ld (hl),d
        inc hl
        inc hl
        inc hl
        ld a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,(ix+d_refy)
        ld (hl),a
        inc hl
.9:
        bit 5,(ix+d_objeto)     ; ¨Muerto (temporalmente)?
        jp nz,.13
        bit 7,(ix+d_objeto)     ; ¨Triunfo?
        jp nz,.13
        ld a,(ix+d_estado)
        or a            ; ¨En historia?
        jp nz,.13       ; S¡, sale.
        ld a,(ix+d_vidas)
        inc a ; cp $ff  ; ¨Muerto?
        jp nz,.12
.13:    pop af          ; No acepta m s entradas
        jp .2
.12:
        ;
        ; Cuenta el tiempo para la recarga del disparo
        ;
        ld a,(ix+d_recarga)
        or a
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
        ; Ahora chi, ¨que movimiento queria?
        ;
        cp 1
        push af
        call z,mov_arriba
        pop af
        cp 3
        push af
        call z,mov_derecha
        pop af
        cp 5
        push af
        call z,mov_abajo
        pop af
        cp 7
        push af
        call z,mov_izquierda
        pop af
    if 0
        cp 2
        push af
        call z,mov_arriba
        call z,mov_derecha
        pop af
        cp 4
        push af
        call z,mov_derecha
        call z,mov_abajo
        pop af
        cp 6
        push af
        call z,mov_abajo
        call z,mov_izquierda
        pop af
        cp 8
        push af
        call z,mov_izquierda
        call z,mov_arriba
        pop af
    endif
        ;
        ; Detecta si cambia de piso
        ;
        ld a,(ix+d_x)
        and $0f
        jp nz,.2
        ld a,(ix+d_y)
        and $0f
        jp nz,.2
        ld de,0
        call accede_casilla
        cp 50
        jp z,.4
        cp 51
        jp z,.4
        cp 98
        jp z,.4
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
        call carga_nivel
        call actualiza_indicadores
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
        ld hl,.15
        add a,a
        add a,l
        ld l,a
        ld a,h
        adc a,0
        ld h,a
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a
        ex (sp),hl
        ret

.15:    dw .4           ; 1- Zombie tipo 1
        dw .8           ; 2- Zombie tipo 2
        dw .12          ; 3- Zombie tipo 3
        dw .17          ; 4- Zombie jefe
        dw .2           ; 5- Adorno, ignora
        dw .9           ; 6- Cient¡fico/a
        dw .22          ; 7- Llave
        dw .13          ; 8- Bala
        dw .16          ; 9- Bala en explosi¢n.
        dw .14          ; 10- Explosi¢n monstruo.
        dw .20          ; 11- Vida
        dw .25          ; 12- Transformaci¢n.
        dw .26          ; 13- Explosi¢n.

        ;
        ; Explosi¢n y cambio
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
        ld (ix+d_energia),50    ; 50 impactos para detener al jefe zombie.
        inc a
        ld (ix+d_velocidad),a
        ld (ix+d_paso),a
        ld (ix+d_tipo),4
        ld (ix+d_ultimo),0
        ld a,(iy+d_seccion)
        and $30
        ld d,$00        ; Jefe zombie normal
        jp z,.27
        cp $10
        ld d,$21        ; Chica zombie, carrera
        jp z,.27
        ld d,$43        ; Zombie malevolo que brinca y corre
.27:    ld (ix+d_ultimo+1),d
        call musica_batalla
        jp .2

        ;
        ; Transformaci¢n.
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
        ; Llave
        ;
.22:    ld a,(ticks)
        and $0c
        ld c,$0a
        jp z,.23
        cp $04
        ld c,$0b
        jp z,.23
        cp $08
        ld c,$0f
        jp z,.23
        ld c,$0b
.23:    ld (ix+d_color),c
        jp .7

        ;
        ; Vida
        ;
.20:    ld a,(ticks)
        and $0c
        ld c,$06
        jp z,.21
        cp $04
        ld c,$08
        jp z,.21
        cp $08
        ld c,$09
        jp z,.21
        ld c,$08
.21:    ld (ix+d_color),c
        jp .7

        ;
        ; Explosi¢n
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
        jp nz,.18
        ld a,$04        ; El cuadro 3 es el cuadro 1 replicado
.18:    or c
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
.7:     ld a,(iy+d_vidas)
        inc a ; cp $ff
        jp z,.2
        bit 5,(iy+d_objeto)     ; ¨Muerto (temporalmente)?
        jp nz,.2
        ld a,(ix+d_x)
        sub (iy+d_x)
        jp nc,.5
        neg 
.5:     cp 13
        jp nc,.2
        ld a,(ix+d_y)
        sub (iy+d_y)
        jp nc,.6
        neg
.6:     cp 13
        jp nc,.2
        ld a,(ix+d_tipo)
        cp 5
        jp c,.10
        cp 6
        jp nz,.11
        ;
        ; Toc¢ un cient¡fico
        ;
        ld (ix+d_tipo),0     ; Lo quita
        push bc
        push hl
        push ix
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        add hl,de
        set 0,(hl)          ; Ya no aparece m s
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
        ld (ix+d_tipo),0     ; La quita
        set 0,(iy+d_objeto)     ; Indica que la lleva
        push bc
        push hl
        push ix
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        add hl,de
        set 2,(hl)          ; Ya no aparece m s
        push iy
        pop ix
        call actualiza_indicadores
        call efecto_llave
        pop ix
        pop hl
        pop bc
        jp .2

        ;
        ; Recuperaci¢n de energ¡a
        ;
.19:    ld (ix+d_tipo),0        ; La quita
        ld (iy+d_energia),6
        push bc
        push hl
        push ix
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        add hl,de
        set 1,(hl)          ; Ya no aparece m s
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
        ; El jugador cae
        ;
jugador_cae:
        ld (ix+d_tiempo),150
        ld (ix+d_tiempo+1),0
        set 5,(ix+d_objeto)     ; Muerto temporalmente
        call efecto_pierde
        ld l,(ix+d_moni)
        ld h,(ix+d_moni+1)
        ex de,hl
        ld hl,16+d_tipo
        add hl,de
        ld a,(hl)
        ex de,hl
        cp 4                    ; ¨Est  con un jefe (ocupa 4 sprites) ?
        ld de,16*(MAX_MONIGOTES-4) ; Empieza por el final para...
                                   ; ...que quede debajo de todo lo dem s
        jp z,.0
        ld de,16*(MAX_MONIGOTES-1) ; Empieza por el final para...
                                   ; ...que quede debajo de todo lo dem s
.0:     add hl,de
        ; Busca una entrada libre
.1:     ld a,(hl)
        or a
        jp z,.2
        ld de,-16
        add hl,de
        jp .1

        ;
        ; Pone esqueletito
        ;
.2:     ld a,(ix+d_x)
        ld (hl),a
        inc hl
        ld a,(ix+d_y)
        sub 6           ; Necesario por ajuste de bala (usa tipo 9)
        ld (hl),a
        inc hl
        ld b,150        ; Duraci¢n
        ld (hl),$18     ; Sprite
        inc hl
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
        ld (hl),$09     ; Tipo de monigote
        inc hl
        ld (hl),a       ; Ultimo movimiento
        inc hl
        ld (hl),a
        inc hl
        inc hl
        inc hl
        ld a,(ix+d_refx)
        ld (hl),a
        inc hl
        ld a,(ix+d_refy)
        ld (hl),a
        ret

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
        ld (ix+d_paso),2
        ld (ix+d_velocidad),2
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
        ld l,(ix+d_offset)
        ld h,(ix+d_offset+1)
        ld de,$00c6
        add hl,de
        ld de,mensaje_10
        ld bc,11
        ld a,(idioma)
        or a
        jp z,.7
        dec hl
        ld de,mensaje_10a
        ld bc,14
.7:     ld a,$08
        ld (SLOT3),a
        ex de,hl
        ldir
        ;
        ; Tiempo para cerrar la tienda
        ;
        ld hl,200
        ld (ix+d_tiempo),l
        ld (ix+d_tiempo+1),h
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
        ld a,(ix+d_temblor)
        cp 3
        jp nc,.5
        ld (ix+d_puerta),l
        ld (ix+d_puerta+1),h
        ld (hl),BASE_MOSAICOS
        inc hl
        ld (hl),BASE_MOSAICOS+1
        ld de,31
        add hl,de
        ld (hl),BASE_MOSAICOS+2
        inc hl
        ld (hl),BASE_MOSAICOS+3
.5:     pop hl
        ret

        ;
        ; Restaura una puerta despu‚s de traspasarla
        ;
restaura_puerta:
        ld a,(ix+d_temblor)
        cp 3
        ret nc
        res 1,(ix+d_objeto)
        ld l,(ix+d_puerta)
        ld h,(ix+d_puerta+1)
        ld a,(ix+d_mosaico)
        add a,a
        add a,a
        add a,BASE_MOSAICOS
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
        inc a
        ld bc,31
        add hl,bc
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
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
        jp nz,.1
        inc hl
        ld a,(ix+d_puntos+1)
        cp (hl)
        ret c
        jp nz,.1
        inc hl
        ld a,(ix+d_puntos+2)
        cp (hl)
        ret c
        ret z
        ;
        ; Nuevo record
        ;
.1:     ld a,(ix+d_puntos)
        ld (record),a
        ld a,(ix+d_puntos+1)
        ld (record+1),a
        ld a,(ix+d_puntos+2)
        ld (record+2),a
        ld a,(ix+d_refx)
        or a
        ld a,1
        jp z,.2
        ld a,2
.2:     ld (quien),a
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
        cp 6
        jp z,.11
        or a
        jp z,.7
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
        ; ­Wiii!, ­Monstruo matado!
        ;
        ld a,(iy+d_sprite)
        and $e0
        rrca
        rrca
        ld hl,color_explosion_jefes
        ld e,a
        ld d,0
        add hl,de
        ld e,(iy+d_x)
        ld d,(iy+d_y)
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),8
        ld (iy+d_paso),8
        ld a,(hl)
        inc hl
        ld (iy+d_color),a
        ld bc,16
        add iy,bc
        ld a,e
        add a,$10
        ld (iy+d_x),a
        ld (iy+d_y),d
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),9
        ld (iy+d_paso),9
        ld a,(hl)
        inc hl
        ld (iy+d_color),a
        ld bc,16
        add iy,bc
        ld (iy+d_x),e
        ld a,d
        add a,$10
        ld (iy+d_y),a
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),10
        ld (iy+d_paso),10
        ld a,(hl)
        inc hl
        ld (iy+d_color),a
        ld bc,16
        add iy,bc
        ld a,e
        add a,$10
        ld (iy+d_x),a
        ld a,d
        add a,$10
        ld (iy+d_y),a
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),7
        ld (iy+d_paso),7
        ld a,(hl)
        inc hl
        ld (iy+d_color),a
        ld bc,16
        add iy,bc
        ld a,e
        add a,$08
        ld (iy+d_x),a
        ld a,d
        add a,$08
        ld (iy+d_y),a
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),11
        ld (iy+d_paso),11
        ld a,(hl)
        inc hl
        ld (iy+d_color),a
        ld bc,16
        add iy,bc
        ld a,e
        add a,$08
        ld (iy+d_x),a
        ld a,d
        add a,$08
        ld (iy+d_y),a
        ld (iy+d_sprite),$10    ; Llave
        ld (iy+d_tipo),7
        ld (iy+d_velocidad),1
        ld (iy+d_paso),1
        ld (iy+d_color),11
        call efecto_megamonstruo
        call musica_triunfo
        ld hl,puntos_megamonstruo
        ld (salva_puntos),hl
        ;
        ; La bala termina
        ;
.14:    ld (ix+d_sprite),$0c
        ld (ix+d_color),9
        ld (ix+d_tipo),9
        ld (ix+d_paso),4
        ld (ix+d_velocidad),4
        call efecto_explota
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
        ; La bala peg¢ en un monstruo/cient¡fico
        ;
        ld a,(iy+d_tipo)
        cp 6            ; Los cient¡ficos caen al primer balazo
        jp z,.16
        dec (iy+d_energia)
        jp nz,.10
        ;
        ; ­Wiii!, ­Monstruo matado!
        ;
        cp 1
        ld hl,puntos_monstruo_1
        jp z,.15
        cp 2
        ld hl,puntos_monstruo_2
        jp z,.15
        ld hl,puntos_monstruo_3
.15:    ld (salva_puntos),hl
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),8
        ld (iy+d_paso),8
        ld (iy+d_color),14
        call efecto_monstruo
        jp .14

        ;
        ; El jugador es un perfecto idiota, mat¢ un cient¡fico
        ;
.16:    ld hl,puntos_cero
        ld (salva_puntos),hl
        ld (iy+d_sprite),$20
        ld (iy+d_tipo),10
        ld (iy+d_velocidad),8
        ld (iy+d_paso),8
        ld (iy+d_color),6       ; Nube de sangre
        call efecto_monstruo
        ld (ix+d_sprite),$0c
        ld (ix+d_color),9
        ld (ix+d_tipo),9
        ld (ix+d_paso),4
        ld (ix+d_velocidad),4
        call efecto_explota
        pop hl
        pop iy
        pop bc
        push hl
        ld e,(iy+d_nivel)
        ld d,0
        ld l,(iy+d_mapa)
        ld h,(iy+d_mapa+1)
        add hl,de
        set 0,(hl)          ; Ya no aparece m s
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
        jp z,.100
        jp p,.101
        ld a,(iy+d_x)
        and $0f
        cp 4
        jp c,.102
        ld a,(iy+d_x)
        sub 4
        ld (iy+d_x),a
        jp .102

.101:   ld a,(iy+d_x)
        and $0f
        jp z,.102
        cp 13
        jp nc,.102
        ld a,(iy+d_x)
        add a,4
        ld (iy+d_x),a
        jp .102

.100:   ld a,(iy+d_y)
        or a
        jp p,.103
        ld a,(iy+d_y)
        and $0f
        cp 4
        jp c,.102
        ld a,(iy+d_y)
        sub 4
        ld (iy+d_y),a
        jp .102

.103:   ld a,(iy+d_y)
        and $0f
        jp z,.102
        cp 13
        jp nc,.102
        ld a,(iy+d_y)
        add a,4
        ld (iy+d_y),a
.102:
        ld hl,puntos_bala
        ld (salva_puntos),hl
        ld a,(iy+d_velocidad)
        cp 1
        jp z,.14
        dec (iy+d_velocidad)
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
        jp c,.1
        cp $ad
        jp nc,.1
        ld a,(ix+d_y)
        add a,(ix+d_dy)
        ld (ix+d_y),a
        sub (ix+d_refy)
        cp 4
        jp c,.1
        cp $4d
        jp nc,.1
        ld a,(ix+d_dx)
        or a
        jp z,.2
        jp p,.4
        ; Bala a la izquierda
        ld de,$0308
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

        ; Bala a la derecha
.4:     ld de,$0308
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

.2:     ld a,(ix+d_dy)
        or a
        jp p,.3
        ; Bala para arriba
        ld de,$0800
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

        ; Bala para abajo
.3:     ld de,$0800
        call mov_libre0
        jp nc,.5
        pop hl
        pop iy
        pop bc
        ret

        ;
        ; La bala se va, y se va, y se va, y se fue...
        ;
.1:     ld (ix+d_tipo),0
        pop hl
        pop iy
        pop bc
        ret

        ;
        ; La bala peg¢ en algo
        ;
.5:     ld (ix+d_sprite),$0c
        ld (ix+d_color),9
        ld (ix+d_tipo),9
        ld (ix+d_paso),4
        ld (ix+d_velocidad),4
        cp 31
        jp z,.17
        cp 35
        jp z,.17
        and $fe
        cp 28           ; ¨Le peg¢ a un armario?
        jp z,.17
        call efecto_explota
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
        cp 31
        ld e,35
        jp z,.18
        cp 35
        ld e,31
        jp z,.18
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
        add a,a
        add a,a
        add a,BASE_MOSAICOS
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
        ld bc,31
        add hl,bc
        inc a
        ld (hl),a
        inc hl
        inc a
        ld (hl),a
        call efecto_explota
        pop hl
        pop iy
        pop bc
        ret

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
        ; Inteligencia artificial de los monstruos
        ;
        include "ia.asm"

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
        ; Movimiento hacia arriba
        ;
mov_arriba:
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or $30
        or c
        ld (ix+d_sprite),a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        or a
        ret z
        ld de,$ff00
        call mov_libre
        ret nc
        dec (ix+d_y)
        ld de,mov_arriba
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Movimiento hacia abajo
        ;
mov_abajo:
        ld a,(ix+d_x)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or $20
        or c
        ld (ix+d_sprite),a
        ld a,(ix+d_y)
        sub (ix+d_refy)
        cp $50
        ret nc
        ld de,$0100
        call mov_libre
        ret nc
        inc (ix+d_y)
        ld de,mov_abajo
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Movimiento a la izquierda
        ;
mov_izquierda:
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or $10
        or c
        ld (ix+d_sprite),a
        ld a,(ix+d_x)
        sub (ix+d_refx)
        ret z
        ld de,$00ff
        call mov_libre
        ret nc
        dec (ix+d_x)
        ld de,mov_izquierda
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Movimiento a la derecha
        ;
mov_derecha:
        ld a,(ix+d_y)
        and $0f
        jp nz,mov_previo
        ld a,(ix+d_sprite)
        and $c0
        ld c,a
        ld a,(ticks)
        and $0c
        or c
        ld (ix+d_sprite),a
        ld a,(ix+d_x)
        sub (ix+d_refx)
        cp $b0
        ret nc
        ld de,$0001
        call mov_libre
        ret nc
        inc (ix+d_x)
        ld de,mov_derecha
        ld (ix+d_ultimo),e
        ld (ix+d_ultimo+1),d
        scf
        ret

        ;
        ; Verifica si puede moverse libremente
        ;
mov_libre:
        ld a,e
        or a
        jp z,.1
        bit 7,e
        jp nz,.1
        ld a,e
        add a,15
        ld e,a
.1:     ld a,d
        or a
        jp z,.2
        bit 7,d
        jp nz,.2
        ld a,d
        add a,15
        ld d,a
.2:     call accede_casilla
        cp 97   ; ¨Transportador?
        jp z,.3
        push hl
        ld e,a
        ld d,0
        ld hl,caminable
        add hl,de
        bit 0,(hl)
        pop hl
        ret z
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
        ld d,0
        ld hl,caminable
        add hl,de
        bit 0,(hl)
        pop hl
        pop de
        ret z
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
        ; Valores iniciales
        ;
jug_fuera:              ; Invisible
        db $10,$10      ; Coordenada X,Y actual, cambiada al leer nivel
        db 0,0          ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw pantalla     ; Ap. a pantalla oculta
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

jug1_inicial:           ; El chico
        db $01,$10      ; Coordenada X,Y actual, cambiada al leer nivel
        db 0,7          ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw pantalla     ; Ap. a pantalla oculta
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
        dw linea1       ; Espacio para salvar l¡nea si hace temblor
        dw 0            ; Espacio para volver a poner puerta
        db 0            ; N£mero de mosaico de puerta
        db 0            ; Secci¢n

jug2_inicial:           ; La chica
        db $41,$70      ; Coordenada X,Y actual, cambiada al leer nivel
        db 64,9         ; Sprite y color
        db 0,0          ; Tiempo de recarga de disparo y piso menos 1
        db 2,6,2        ; Velocidad, energ¡a y paso (debe ser igual a vel.)
        db 0
        db 0,0          ; Ultimo movimiento
        dw pantalla+392 ; Ap. a pantalla oculta
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
        dw linea2       ; Espacio para salvar l¡nea si hace temblor
        dw 0            ; Espacio para volver a poner puerta
        db 0            ; N£mero de mosaico de puerta
        db 0            ; Secci¢n.

        ;
        ; Otros m¢dulos tan grandes e importantes que merecen su
        ; propio archivo.
        ;
        include "sonido.asm"

        include "historia.asm"

        ;
        ; Los sprites bellamente dibujados :)
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
        db 3,0,0,0,0,0,0,0,0,3  ; 0-9
        db 3,3,0,0,0,0,0,0,0,0  ; 10-19
        db 0,0,0,0,0,0,0,0,0,0  ; 20-29
        db 0,0,0,0,0,0,0,0,0,0  ; 30-39
        db 0,0,0,0,0,0,0,0,0,0  ; 40-49
        db 1,1,0,0,0,0,0,0,0,0  ; 50-59
        db 0,0,0,0,0,0,0,0,0,0  ; 60-69
        db 0,0,1,1,0,1,1,1,1,0  ; 70-79
        db 1,1,1,1,1,1,1,1,1,1  ; 80-89
        db 1,1,1,1,1,1,0,0,1,1  ; 90-99

        include "musica.asm"

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

        ;
        ; Datos para animaci¢n puntos aleatorios en edificio
        ;
        include "aleato.asm"

        ORG $A000
        FORG $A000

        include "mapa1.asm"

        ORG $A000
        FORG $C000

        include "mapa2.asm"

        ORG $A000
        FORG $E000

        include "mapa3.asm"

        ORG $A000
        FORG $10000

        include "mensajes.asm"

        org $aa90
        forg $10a90
        include "graficas.asm"

        FORG $11710
        ORG $11710
GRAFICA_TITULO_EN:
        INCBIN "TITULO.DAT"
GRAFICA_TITULO_ES:
        INCBIN "TITULO3.DAT"
GRAFICA_ALERTA_EN:
        INCBIN "ALERTA.DAT"
GRAFICA_ALERTA_ES:
        INCBIN "ALERTA2.DAT"
GRAFICA_EDIFICIO_EN:
        INCBIN "EDIFICIO.DAT"
GRAFICA_EDIFICIO_ES:
        INCBIN "EDIFICI2.DAT"
GRAFICA_HELICOPTERO:
        INCBIN "HELICOP.DAT"
GRAFICA_FIN_EN:         ; THE END
        INCBIN "FIN.DAT"
GRAFICA_FIN_ES:         ; FIN
        INCBIN "FIN2.DAT"
GRAFICA_TITULO2_EN:
        INCBIN "TITULO2.DAT"
GRAFICA_TITULO2_ES:
        INCBIN "TITULO4.DAT"
GRAFICA_OSCAR:
        INCBIN "OSCAR.DAT"
GRAFICA_ADAN:
        INCBIN "ADAN.DAT"

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
        ; Salva un pedazo de l¡nea para efecto de temblor
        ; Se usan 24 bytes para temblor vertical y 12 bytes para horizontal.
        ;
linea1: RB 24
linea2: RB 24

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

jug2:   ; Datos del jugador 2
        RB 44

monigotes:      ; Tabla de monigotes
        RB (MAX_MONIGOTES*2)*16

        ;
        ; El nivel actual
        ;
nivel1: RB 12*6 ; Nivel actual (jugador 1)
nivel2: RB 12*6 ; Nivel actual (jugador 2)

        ;
        ; Mapa de pisos, un byte por piso.
        ; bit 0 = Cient¡fico rescatado
        ; bit 1 = Vida usada
        ; bit 2 = Llave tomada
        ;
bits1:  RB 101  ; Cosas modificadas en el mapa (jugador 1)
bits2:  RB 101  ; Cosas modificadas en el mapa (jugador 2)

salva_puntos:   RB 2

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

ef_band:        RB 1    ; Banderas de efectos
ef_ritmo:       RB 1    ; Contador de ritmo
ef_cont1:       RB 1    ; Contador (toma llave)
ef_cont2:       RB 1    ; Contador (rescate cient¡fico)
ef_cont3:       RB 1    ; Contador (tocado)
ef_frec3:       RB 2    ; Frecuencia (tocado)
ef_cont4:       RB 1    ; Contador (disparo)
ef_frec4:       RB 2    ; Frecuencia (disparo)
ef_cont5:       RB 1    ; Contador (explota)
ef_frec5:       RB 2    ; Frecuencia (explota)
ef_cont6:       RB 1    ; Contador (monstruo/megamonstruo)
ef_frec6:       RB 2    ; Frecuencia (monstruo/megamonstruo)
ef_frec7:       RB 2    ; Frecuencia (monstruo/megamonstruo)
ef_frec8:       RB 2    ; Frecuencia (monstruo/megamonstruo)
ef_cont7:       RB 1    ; Contador (berrido)
ef_cont8:       RB 1    ; Contador (vida extra)
ef_cont9:       RB 1    ; Contador (pierde vida)
ef_frec9:       RB 2    ; Frecuencia (pierde vida)
ef_inicio:      RB 2    ; Base de m£sica en reproducci¢n.
ef_ap:          RB 2    ; Apuntador a m£sica en reproducci¢n
ef_t:           RB 1    ; Tiempo base de reproducci¢n
ef_ta:          RB 1    ; Tiempo actual de reproducci¢n
ef_cn:          RB 1    ; Conteo de notas para acordes
ef_n:           RB 1    ; Nota actual (melod¡a)
ef_b:           RB 1    ; Nota actual (bajo)
ef_ac1:         RB 1    ; Acorde 1
ef_ac2:         RB 1    ; Acorde 2
ef_ac3:         RB 1    ; Acorde 3
ef_env:         RB 1    ; Informaci¢n de envolvente

ganado:         RB 1    ; Indica si el juego se ha ganado
record:         RB 3    ; Record (BCD)
quien:          RB 1    ; Qui‚n hizo el record (jugador 1 ¢ 2)

idioma:         RB 1    ; Idioma (0=Ingl‚s, 1=Espa¤ol)

        ORG $F0F0
PILA:   

