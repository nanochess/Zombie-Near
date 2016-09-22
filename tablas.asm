        ; Una parte de las gr ficas compactadas con RLE
GRAFICA_EDIFICIO:       ; Imagen de los dos edificios
        INCBIN "EDIFICIO.DAT"
GRAFICA_COMPLEJO_EN:    ; Texto que dice "COMPLEX"
        INCBIN "COMPLENG.DAT"
GRAFICA_FIN_EN:         ; THE END
        INCBIN "FIN.DAT"
GRAFICA_FIN_ES:         ; FIN
        INCBIN "FIN2.DAT"

        ; Mensajes
        ;
        ; Es importante que est‚n aqu¡ porque el proceso es complejo y
        ; necesita RAM mientras los procesa.
        ;
        include "mensajes.asm"

GRAFICA_TITULO_1:       ; El dibujo principal del t¡tulo
        INCBIN "TITULO1.DAT"
GRAFICA_TITULO_2:       ; Imagen alternativa de t¡tulo (ganando una vez)
        INCBIN "TITULO2.DAT"
GRAFICA_TITULO_3:       ; Imagen alternativa de t¡tulo (ganando 2 veces)
        INCBIN "TITULO3.DAT"
GRAFICA_COPYRIGHT:      ; El copyright
        INCBIN "COPYRIGH.DAT"
