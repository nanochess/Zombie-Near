        ;
        ; Historia para Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez
        ;
        ; Creaci¢n: 17-ene-2011.
        ;

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
        db $12,$05,$13,$03,$15,$05,$04,$35,$00,$40,$40,$ff

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
        ; I DIDN'T SEE / PEOPLE
        db $09,$00,$04,$09,$04,$0e,$30,$14,$00,$13,$05,$05,$fe
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
        ; I CAME TO / SAVE YOU
        db $09,$00,$03,$01,$0d,$05,$00,$14,$0f,$fe
        db $13,$01,$16,$05,$00,$19,$0f,$15,$ff

historia_7b:
        db 0,1,11
        ; I'M HERE TO / RESCUE YOU
        db $09,$30,$0d,$00,$08,$05,$12,$05,$00,$14,$0f,$fe
        db $12,$05,$13,$03,$15,$05,$00,$19,$0f,$15,$ff

historia_8:
        db 0,3,10
        ; YOU'RE TOO / LATE
        db $19,$0f,$15,$30,$12,$05,$00,$14,$0f,$0f,$fe
        db $0c,$01,$14,$05,$ff

historia_9a:
        db 0,1,12
        ; NEVER I'M / LATE SWEETIE
        db $0e,$05,$16,$05,$12,$00,$09,$30,$0d,$fe
        db $0c,$01,$14,$05,$00,$13,$17,$05,$05,$14,$09,$05,$ff

historia_9b:
        db 0,1,12
        ; WHAT ARE YOU / SAYING?
        db $17,$08,$01,$14,$00,$01,$12,$05,$00,$19,$0f,$15,$fe
        db $13,$01,$19,$09,$0e,$07,$2f,$ff

historia_10:
        db 4,3,12
        ; I'M INFECTED / AARGH!
        db $09,$30,$0d,$00,$09,$0e,$06,$05,$03,$14,$05,$04,$fe
        db $01,$01,$12,$07,$08,$2e,$ff

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
        db $12,$05,$13,$03,$15,$05,$04,$35,$00,$40,$40,$ff

historia_13a:
        db 2,1,11
        ; I'M / INVENCIBLE!
        db $09,$30,$0d,$fe
        db $09,$0e,$16,$05,$0e,$03,$09,$02,$0c,$05,$2e,$ff

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
        db 3,4,11
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
        db $12,$05,$13,$03,$15,$05,$04,$35,$00,$40,$40,$ff

historia_25a:
        db 2,1,11
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

