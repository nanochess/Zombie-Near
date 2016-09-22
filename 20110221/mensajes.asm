        ;
        ; Mensajes de Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez.
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez.
        ;
        ; Creaci¢n: 20-ene-2011. Separado de HISTORIA.ASM. Traducci¢n al
        ;                        espa¤ol.
        ; Revisi¢n: 26-ene-2011. Ajustes en algunos mensajes.
        ; Revisi¢n: 06-feb-2011. Correcci¢n en mensaje_4 en espa¤ol, se
        ;                        remueve una l¡nea invisible.
        ;

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
        ; ­FUE TAN / FACIL!
        db $37,$06,$15,$05,$00,$14,$01,$0e,$fe
        db $06,$01,$03,$09,$0c,$2e,$ff

historia_1b:
        db 0,1,14
        ; NO ZOMBIE CAN / DEFEAT ME!
        db $0e,$0f,$00,$1a,$0f,$0d,$02,$09,$05,$00,$03,$01,$0e,$fe
        db $04,$05,$06,$05,$01,$14,$00,$0d,$05,$2e,$ff
        ; ­NINGUN ZOMBIE / PUEDE GANARME!
        db $37,$0e,$09,$0e,$07,$15,$0e,$00,$1a,$0f,$0d,$02,$09,$05,$fe
        db $10,$15,$05,$04,$05,$00,$07,$01,$0e,$01,$12,$0d,$05,$2e,$ff

historia_2:
        db 1,2,12
        ; WELL DONE! / SCIENTISTS / RESCUED- 00
        db $17,$05,$0c,$0c,$00,$04,$0f,$0e,$05,$2e,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$fe
        db $12,$05,$13,$03,$15,$05,$04,$34,$00,$40,$41,$ff
        ; ­BIEN HECHO! / CIENTIFICOS / HALLADOS- 00
        db $37,$02,$09,$05,$0e,$00,$08,$05,$03,$08,$0f,$2e,$fe
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$13,$fe
        db $08,$01,$0c,$0c,$01,$04,$0f,$13,$34,$40,$41,$ff

historia_3a:
        db 2,1,12
        ; I'M THE MAN!
        db $09,$30,$0d,$00,$14,$08,$05,$00,$0d,$01,$0e,$2e,$ff
        ; ­SOY SUPER!
        db $37,$13,$0f,$19,$00,$13,$15,$10,$05,$12,$2E,$FF

historia_3b:
        db 2,1,12
        ; I LIKE TO / SAVE PEOPLE
        db $09,$00,$0c,$09,$0b,$05,$00,$14,$0f,$fe
        db $13,$01,$16,$05,$00,$10,$05,$0f,$10,$0c,$05,$ff
        ; ME GUSTA / SALVAR GENTE
        db $0d,$05,$00,$07,$15,$13,$14,$01,$fe
        db $13,$01,$0c,$16,$01,$12,$00,$07,$05,$0e,$14,$05,$ff

historia_4a:
        db 0,1,12
        ; I DIDN'T SAW / PEOPLE
        db $09,$00,$04,$09,$04,$0e,$30,$14,$00,$13,$01,$17,$fe
        db $10,$05,$0f,$10,$0c,$05,$ff
        ; ¨ACASO HABIA / ALGUIEN?
        db $35,$01,$03,$01,$13,$0f,$00,$08,$01,$02,$09,$01,$fe
        db $01,$0c,$07,$15,$09,$05,$0e,$2f,$ff

historia_4b:
        db 0,1,12
        ; IT IS SO SAD
        db $09,$14,$00,$09,$13,$00,$13,$0f,$00,$13,$01,$04,$ff
        ; ES TAN TRISTE
        db $05,$13,$00,$14,$01,$0e,$00,$14,$12,$09,$13,$14,$05,$ff

historia_5:
        db 0,2,9
        ; WAIT! I'M / RECEIVING / SOMETHING
        db $17,$01,$09,$14,$2e,$00,$09,$30,$0d,$fe
        db $12,$05,$03,$05,$09,$16,$09,$0e,$07,$fe
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$07,$ff
        ; ­MOMENTO! / RECIBO / ALGO
        db $37,$0d,$0f,$0d,$05,$0e,$14,$0f,$2e,$fe
        db $12,$05,$03,$09,$02,$0f,$fe
        db $01,$0c,$07,$0f,$ff

historia_6:
        db 3,3,11
        ; PLEASE HELP / ME! I'M / SURROUNDED
        db $10,$0c,$05,$01,$13,$05,$00,$08,$05,$0c,$10,$fe
        db $0d,$05,$2e,$00,$09,$30,$0d,$fe
        db $13,$15,$12,$12,$0f,$15,$0e,$04,$05,$04,$ff
        ; ­AYUDA POR / FAVOR! ME / HAN RODEADO
        db $37,$01,$19,$15,$04,$01,$00,$10,$0f,$12,$fe
        db $06,$01,$16,$0f,$12,$2e,$00,$0d,$05,$fe
        db $08,$01,$0e,$00,$12,$0f,$04,$05,$01,$04,$0f,$ff

historia_7a:
        db 0,1,10
        ; I CAME TO / SAVE YOU
        db $09,$00,$03,$01,$0d,$05,$00,$14,$0f,$fe
        db $13,$01,$16,$05,$00,$19,$0f,$15,$ff
        ; HE VENIDO / A SALVARTE
        db $08,$05,$00,$16,$05,$0e,$09,$04,$0f,$fe
        db $01,$00,$13,$01,$0c,$16,$01,$12,$14,$05,$ff

historia_7b:
        db 0,1,11
        ; I'M HERE TO / RESCUE YOU
        db $09,$30,$0d,$00,$08,$05,$12,$05,$00,$14,$0f,$fe
        db $12,$05,$13,$03,$15,$05,$00,$19,$0f,$15,$ff
        ; ESTOY AQUI / PARA / RESCATARTE
        db $05,$13,$14,$0f,$19,$00,$01,$11,$15,$09,$fe
        db $10,$01,$12,$01,$fe
        db $12,$05,$13,$03,$01,$14,$01,$12,$14,$05,$ff

historia_8:
        db 0,3,12
        ; YOU'RE TOO / LATE / I'M INFECTED
        db $19,$0f,$15,$30,$12,$05,$00,$14,$0f,$0f,$fe
        db $0c,$01,$14,$05,$fe
        db $09,$30,$0d,$00,$09,$0e,$06,$05,$03,$14,$05,$04,$ff
        ; LLEGAS MUY / TARDE / ME INFECTE
        db $0c,$0c,$05,$07,$01,$13,$00,$0d,$15,$19,$fe
        db $14,$01,$12,$04,$05,$fe
        db $0d,$05,$00,$09,$0e,$06,$05,$03,$14,$05,$ff

historia_9a:
        db 0,1,11
        ; INFECTED? / HOW?
        db $09,$0e,$06,$05,$03,$14,$05,$04,$2f,$fe
        db $08,$0f,$17,$2f,$ff
        ; ¨INFECTADA? / ¨COMO PASO?
        db $35,$09,$0e,$06,$05,$03,$14,$01,$04,$01,$2f,$fe
        db $35,$03,$0f,$0d,$0f,$00,$10,$01,$13,$0f,$2f,$ff

historia_9b:
        db 0,1,12
        ; WHAT ARE YOU / SAYING?
        db $17,$08,$01,$14,$00,$01,$12,$05,$00,$19,$0f,$15,$fe
        db $13,$01,$19,$09,$0e,$07,$2f,$ff
        ; ¨QUE ESTAS / DICIENDO?
        db $35,$11,$15,$05,$00,$05,$13,$14,$01,$13,$fe
        db $04,$09,$03,$09,$05,$0e,$04,$0f,$2f,$ff

historia_10:
        db 4,3,12
        ; AARGH! HELP! / GRR!
        db $01,$01,$12,$07,$08,$2e,$00,$08,$05,$0c,$10,$2e,$fe
        db $07,$12,$12,$2e,$ff
        ; ­AARGH! / ­AYUDA! / ­GRR!
        db $37,$01,$01,$12,$07,$08,$2e,$fe
        db $37,$01,$19,$15,$04,$01,$2e,$fe
        db $37,$07,$12,$12,$2e,$ff
        
historia_11a:
        db 0,1,12
        ; POOR GIRL! / SHE WAS CUTE
        db $10,$0f,$0f,$12,$00,$07,$09,$12,$0c,$2e,$fe
        db $13,$08,$05,$00,$17,$01,$13,$00,$03,$15,$14,$05,$ff
        ; ­POBRECILLA! / ERA BONITA
        db $37,$10,$0f,$02,$12,$05,$03,$09,$0c,$0c,$01,$2e,$fe
        db $05,$12,$01,$00,$02,$0f,$0e,$09,$14,$01,$ff

historia_11b:
        db 0,1,10
        ; I COULDN'T / SAVE HER
        db $09,$00,$03,$0f,$15,$0c,$04,$0e,$30,$14,$fe
        db $13,$01,$16,$05,$00,$08,$05,$12,$ff
        ; NO PUDE / SALVARLA
        db $0e,$0f,$00,$10,$15,$04,$05,$fe
        db $13,$01,$0c,$16,$01,$12,$0c,$01,$ff

historia_12:
        db 1,2,11
        ; SCIENTISTS / RESCUED- 00 / GOOD WORK!
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$fe
        db $12,$05,$13,$03,$15,$05,$04,$34,$40,$41,$fe
        db $07,$0f,$0f,$04,$00,$17,$0f,$12,$0b,$2e,$ff
        ; CIENTIFICOS / HALLADOS- 00 / ­MUY BIEN!
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$13,$fe
        db $08,$01,$0c,$0c,$01,$04,$0f,$13,$34,$40,$41,$fe
        db $37,$0D,$15,$19,$00,$02,$09,$05,$0E,$2e,$ff

historia_13a:
        db 2,1,7
        ; I'M THE / BEST!
        db $09,$30,$0d,$00,$14,$08,$05,$fe
        db $02,$05,$13,$14,$2e,$ff
        ; ­SOY EL / MEJOR!
        db $37,$13,$0f,$19,$00,$05,$0c,$fe
        db $0d,$05,$0a,$0f,$12,$2e,$ff

historia_13b:
        db 2,1,11
        ; I'M / UNBEATABLE!
        db $09,$30,$0d,$fe
        db $15,$0e,$02,$05,$01,$14,$01,$02,$0c,$05,$2e,$ff
        ; ­SOY / INVENCIBLE!
        db $37,$13,$0f,$19,$fe
        db $09,$0e,$16,$05,$0e,$03,$09,$02,$0c,$05,$2e,$ff

historia_14a:
        db 0,1,12
        ; WHAT / SCIENTISTS?
        db $17,$08,$01,$14,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$2f,$ff
        ; ¨CUALES / CIENTIFICOS?
        db $35,$03,$15,$01,$0c,$05,$13,$fe
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$13,$2f,$ff

historia_14b:
        db 0,1,12
        ; THERE ARE / SCIENTISTS?
        db $14,$08,$05,$12,$05,$00,$01,$12,$05,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$2f,$ff
        ; ¨HAY / CIENTIFICOS?
        db $35,$08,$01,$19,$fe
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$13,$2f,$ff

historia_15:
        db 0,2,14
        ; THERE IS / ANOTHER SIGNAL
        db $14,$08,$05,$12,$05,$00,$09,$13,$fe
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$13,$09,$07,$0e,$01,$0c,$ff
        ; HAY OTRA / FRAGIL SE¥al
        db $08,$01,$19,$00,$0f,$14,$12,$01,$fe
        db $06,$12,$01,$07,$09,$0C,$00,$13,$05,$36,$01,$0c,$ff

historia_16:
        db 3,4,12
        ; HELP ME! I'M / HIDDEN BUT / SOMETHING / FOLLOWS ME!
        db $08,$05,$0c,$10,$00,$0d,$05,$2e,$00,$09,$30,$0d,$fe
        db $08,$09,$04,$04,$05,$0e,$00,$02,$15,$14,$fe
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$07,$fe
        db $06,$0f,$0c,$0c,$0f,$17,$13,$00,$0d,$05,$2e,$ff
        ; ­AYUDENME! / ESTOY OCULTO / PERO ­ALGO / ME SIGUE!
        db $37,$01,$19,$15,$04,$05,$0e,$0d,$05,$2e,$fe
        db $05,$13,$14,$0f,$19,$00,$0f,$03,$15,$0c,$14,$0f,$fe
        db $10,$05,$12,$0f,$00,$37,$01,$0c,$07,$0f,$fe
        db $0d,$05,$00,$13,$09,$07,$15,$05,$2e,$ff

historia_17a:
        db 0,1,11
        ; YOU'RE HERE / GREAT!
        db $19,$0F,$15,$30,$12,$05,$00,$08,$05,$12,$05,$FE
        db $07,$12,$05,$01,$14,$2E,$FF
        ; ESTAS AQUI / ­GRANDIOSO!
        db $05,$13,$14,$01,$13,$00,$01,$11,$15,$09,$fe
        db $37,$07,$12,$01,$0e,$04,$09,$0f,$13,$0f,$2e,$ff

historia_17b:
        db 0,1,12
        ; APPEARS THAT / I'M ON TIME / TO SAVE YOU
        db $01,$10,$10,$05,$01,$12,$13,$00,$14,$08,$01,$14,$fe
        db $09,$30,$0d,$00,$0f,$0e,$00,$14,$09,$0d,$05,$fe
        db $14,$0f,$00,$13,$01,$16,$05,$00,$19,$0f,$15,$ff
        ; LLEGUE A / TIEMPO PARA / SALVARTE
        db $0c,$0c,$05,$07,$15,$05,$00,$01,$fe
        db $14,$09,$05,$0d,$10,$0f,$00,$10,$01,$12,$01,$fe
        db $13,$01,$0c,$16,$01,$12,$14,$05,$ff

historia_18:
        db 0,4,13
        ; SO YOU FOUGHT / YOUR WAY
        db $13,$0f,$00,$19,$0f,$15,$00,$06,$0f,$15,$07,$08,$14,$fe
        db $19,$0f,$15,$12,$00,$17,$01,$19,$ff
        ; PELEASTE MUY / BIEN
        db $10,$05,$0c,$05,$01,$13,$14,$05,$00,$0d,$15,$19,$fe
        db $02,$09,$05,$0e,$ff

historia_19a:
        db 0,1,10
        ; EXCUSE ME?
        db $05,$18,$03,$15,$13,$05,$00,$0d,$05,$2f,$ff
        ; ¨PERDON?
        db $35,$10,$05,$12,$04,$0f,$0e,$2f,$ff

historia_19b:
        db 0,1,13
        ; IT IS MY WORK
        db $09,$14,$00,$09,$13,$00,$0d,$19,$00,$17,$0f,$12,$0b,$ff
        ; ES MI TRABAJO
        db $05,$13,$00,$0d,$09,$00,$14,$12,$01,$02,$01,$0a,$0f,$ff

historia_20:
        db 0,4,14
        ; I WASN'T GOING / TO SHOW MY / POWERS
        db $09,$00,$17,$01,$13,$0e,$30,$14,$00,$07,$0f,$09,$0e,$07,$fe
        db $14,$0f,$00,$13,$08,$0f,$17,$00,$0d,$19,$fe
        db $10,$0f,$17,$05,$12,$13,$ff
        ; NO PENSABA / MOSTRAR MIS / PODERES
        db $0e,$0f,$00,$10,$05,$0e,$13,$01,$02,$01,$fe
        db $0d,$0f,$13,$14,$12,$01,$12,$00,$0d,$09,$13,$fe
        db $10,$0f,$04,$05,$12,$05,$13,$ff

historia_21a:
        db 0,1,13
        ; WAIT! ARE YOU / THE BAD GUY?
        db $17,$01,$09,$14,$2e,$00,$01,$12,$05,$00,$19,$0f,$15,$fe
        db $14,$08,$05,$00,$02,$01,$04,$00,$07,$15,$19,$2f,$ff
        ; ­ESPERA! ¨TU / ERES EL MALO?
        db $37,$05,$13,$10,$05,$12,$01,$2e,$00,$35,$14,$15,$fe
        db $05,$12,$05,$13,$00,$05,$0c,$00,$0d,$01,$0c,$0f,$2f,$ff

historia_21b:
        db 0,1,14
        ; HARMED YOU ALL / THE PEOPLE?
        db $08,$01,$12,$0D,$05,$04,$00,$19,$0F,$15,$00,$01,$0C,$0C,$FE
        db $14,$08,$05,$00,$10,$05,$0f,$10,$0c,$05,$2f,$ff
        ; ¨TU LASTIMASTE / A LA GENTE?
        db $35,$14,$15,$00,$0c,$01,$13,$14,$09,$0d,$01,$13,$14,$05,$fe
        db $01,$00,$0c,$01,$00,$07,$05,$0e,$14,$05,$2f,$ff

historia_22:
        db 4,5,11
        ; DO YOU WANT / TO SEE / SOMETHING / SCARY?
        db $04,$0f,$00,$19,$0f,$15,$00,$17,$01,$0e,$14,$fe
        db $14,$0f,$00,$13,$05,$05,$fe
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$07,$fe
        db $13,$03,$01,$12,$19,$2f,$ff
        ; ¨QUIERES / VER ALGO / REALMENTE / ESPANTOSO?
        db $35,$11,$15,$09,$05,$12,$05,$13,$FE
        db $16,$05,$12,$00,$01,$0c,$07,$0f,$fe
        db $12,$05,$01,$0c,$0d,$05,$0e,$14,$05,$fe
        db $05,$13,$10,$01,$0e,$14,$0f,$13,$0f,$2f,$ff

historia_23a:
        db 0,1,11
        ; THAT WAS A / EVIL BOSS!
        db $14,$08,$01,$14,$00,$17,$01,$13,$00,$01,$fe
        db $05,$16,$09,$0c,$00,$02,$0f,$13,$13,$2e,$ff
        ; ­ESE SI QUE / ERA UN JEFE / MALVADO!
        db $37,$05,$13,$05,$00,$13,$09,$00,$11,$15,$05,$fe
        db $05,$12,$01,$00,$15,$0e,$00,$0a,$05,$06,$05,$fe
        db $0d,$01,$0c,$16,$01,$04,$0f,$2e,$ff

historia_23b:
        db 0,1,14
        ; SO MANY HARMED / INNOCENTS!
        db $13,$0f,$00,$0d,$01,$0e,$19,$00,$08,$01,$12,$0d,$05,$04,$fe
        db $09,$0e,$0e,$0f,$03,$05,$0e,$14,$13,$2e,$ff
        ; ­TANTOS / INOCENTES / LASTIMADOS!
        db $37,$14,$01,$0e,$14,$0f,$13,$fe
        db $09,$0e,$0f,$03,$05,$0e,$14,$05,$13,$fe
        db $0c,$01,$13,$14,$09,$0d,$01,$04,$0f,$13,$2e,$ff

historia_24:
        db 1,2,11
        ; MISSION / COMPLETE! / SCIENTISTS / RESCUED- 00
        db $0d,$09,$13,$13,$09,$0f,$0e,$fe
        db $03,$0f,$0d,$10,$0c,$05,$14,$05,$2e,$fe
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$fe
        db $12,$05,$13,$03,$15,$05,$04,$34,$40,$41,$ff
        ; ­MISION / COMPLETA! / CIENTIFICOS / HALLADOS- 00
        db $37,$0D,$09,$13,$09,$0F,$0E,$FE
        db $03,$0f,$0d,$10,$0c,$05,$14,$01,$2e,$fe
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$13,$fe
        db $08,$01,$0c,$0c,$01,$04,$0f,$13,$34,$40,$41,$ff

historia_25a:
        db 2,1,12
        ; I'M SO GOOD!
        db $09,$30,$0d,$00,$13,$0F,$00,$07,$0f,$0f,$04,$2e,$ff
        ; ­SOY TAN / BUENO!
        db $37,$13,$0f,$19,$00,$14,$01,$0e,$fe
        db $02,$15,$05,$0e,$0f,$2e,$ff

historia_25b:
        db 2,1,12
        ; I'M PROUD OF / MYSELF!
        db $09,$30,$0d,$00,$10,$12,$0f,$15,$04,$00,$0f,$06,$fe
        db $0d,$19,$13,$05,$0c,$06,$2e,$ff
        ; ­ESTOY / ORGULLOSA!
        db $37,$05,$13,$14,$0f,$19,$fe
        db $0f,$12,$07,$15,$0c,$0c,$0f,$13,$01,$2e,$ff

historia_26a:
        db 0,1,10
        ; MAYBE I'M / BLIND?
        db $0D,$01,$19,$02,$05,$00,$09,$30,$0D,$fe
        db $02,$0c,$09,$0e,$04,$2f,$ff
        ; ¨TAL VEZ / SOY CIEGO?
        db $35,$14,$01,$0c,$00,$16,$05,$1a,$fe
        db $13,$0f,$19,$00,$03,$09,$05,$07,$0f,$2f,$ff

historia_26b:
        db 0,1,11
        ; PEOPLE? / WHERE?
        db $10,$05,$0F,$10,$0C,$05,$2F,$FE
        db $17,$08,$05,$12,$05,$2f,$ff
        ; ¨GENTE? / ¨DONDE?
        db $35,$07,$05,$0e,$14,$05,$2f,$fe
        db $35,$04,$0f,$0e,$04,$05,$2f,$ff

historia_27:
        db 0,2,14
        ; I'VE SENT / AN HELICOPTER
        db $09,$30,$16,$05,$00,$13,$05,$0e,$14,$fe
        db $01,$0e,$00,$08,$05,$0c,$09,$03,$0f,$10,$14,$05,$12,$ff
        ; TE MANDE UN / HELICOPTERO
        db $14,$05,$00,$0d,$01,$0e,$04,$05,$00,$15,$0e,$fe
        db $08,$05,$0c,$09,$03,$0f,$10,$14,$05,$12,$0f,$ff

historia_28a:
        db 5,1,11
        ; I'LL BE ON / TIME TO / WATCH TV!
        db $09,$30,$0c,$0c,$00,$02,$05,$00,$0f,$0e,$fe
        db $14,$09,$0d,$05,$00,$14,$0f,$fe
        db $17,$01,$14,$03,$08,$00,$14,$16,$2e,$ff
        ; ESTARE A / TIEMPO / ­PARA VER / TV!
        db $05,$13,$14,$01,$12,$05,$00,$01,$fe
        db $14,$09,$05,$0d,$10,$0f,$fe
        db $37,$10,$01,$12,$01,$00,$16,$05,$12,$fe
        db $14,$16,$2e,$ff

historia_28b:
        db 5,1,12
        ; I'VE TO FEED / MY CATS
        db $09,$30,$16,$05,$00,$14,$0f,$00,$06,$05,$05,$04,$fe
        db $0d,$19,$00,$03,$01,$14,$13,$ff
        ; TENGO QUE / ALIMENTAR A / MIS GATOS
        db $14,$05,$0e,$07,$0f,$00,$11,$15,$05,$fe
        db $01,$0c,$09,$0d,$05,$0e,$14,$01,$12,$00,$01,$fe
        db $0d,$09,$13,$00,$07,$01,$14,$0f,$13,$ff

        ;
        ; Los mensajes de la historia b sica.
        ; No deben ser m s de tres l¡neas por mensaje.
        ;
mensaje_1:
        db $14,$08,$05,$12,$05,$00,$09,$13,$00,$01,$fe  ; THERE IS A
        db $13,$05,$03,$15,$12,$09,$14,$19,$fe          ; SECURITY
        db $02,$12,$05,$01,$03,$08,$FF                  ; BREACH
        ; HAY UNA / BRECHA DE / SEGURIDAD
        db $08,$01,$19,$00,$15,$0e,$01,$fe
        db $02,$12,$05,$03,$08,$01,$00,$04,$05,$fe
        db $13,$05,$07,$15,$12,$09,$04,$01,$04,$ff

mensaje_2:
        db $03,$0C,$0F,$13,$05,$00              ; CLOSE
        db $04,$0f,$17,$0e,$FE                  ; DOWN
        db $14,$08,$05,$00                      ; THE
        db $07,$01,$14,$05,$13,$FF              ; GATES
        ; CIERRE / LAS / PUERTAS
        db $03,$09,$05,$12,$12,$05,$00,$0c,$01,$13,$fe
        db $10,$15,$05,$12,$14,$01,$13,$ff

mensaje_3:
        db $14,$08,$05,$0D,$30,$12,$05,$00      ; THEM'RE
        db $14,$08,$12,$0F,$15,$07,$08,$FE      ; THROUGH
        db $14,$08,$05,$00                      ; THE
        db $02,$15,$09,$0C,$04,$09,$0E,$07,$2E  ; BUILDING!
        db $FF
        ; ­SE DISPERSARON / POR EL / EDIFICIO!
        db $37,$13,$05,$00
        db $04,$09,$13,$10,$05,$12,$13,$01,$12,$0f,$0e,$fe
        db $10,$0f,$12,$00,$05,$0c,$fe
        db $05,$04,$09,$06,$09,$03,$09,$0f,$2e,$ff

mensaje_4:
        db $03,$01,$0c,$0c,$00                  ; CALL
        db $13,$10,$05,$03,$09,$01,$0c,$fe      ; SPECIAL
        db $14,$05,$01,$0d,$00                  ; TEAM
        db $0e,$0f,$17,$2E                      ; NOW!
        db $FF
        ; LLAME AL / EQUIPO / TACTICO
        db $0c,$0c,$01,$0d,$05,$00,$01,$0c,$fe
        db $05,$11,$15,$09,$10,$0f,$fe
        db $14,$01,$03,$14,$09,$03,$0f,$ff

mensaje_5:
        db $17,$08,$01,$14,$30,$13,$00          ; WHAT'S
        db $14,$08,$01,$14,$2F                  ; THAT?
        db $FF
        ; ¨QUE ES ESO?
        db $35,$11,$15,$05,$00,$05,$13,$00
        db $05,$13,$0f,$2f,$ff

mensaje_6:
        db $00,$0F,$08,$00,$0D,$19,$00          ; OH MY
        db $07,$0F,$04,$2E,$00,$FF              ; GOD!
        ; ­SANTO CIELO!
        db $37,$13,$01,$0e,$14,$0f,$00
        db $03,$09,$05,$0c,$0f,$2e,$ff

mensaje_7:
        db $05,$0d,$05,$12,$07,$05,$0e,$03,$19,$2e,$fe  ; EMERGENCY!
        db $03,$01,$0c,$0c,$09,$0e,$07,$fe      ; CALLING
        db $04,$05,$0c,$14,$01,$00              ; DELTA
        db $14,$05,$01,$0d,$ff                  ; TEAM
        ; ­URGENTE! / LLAMANDO / EQUIPO / DELTA
        db $37,$15,$12,$07,$05,$0e,$14,$05,$2e,$fe
        db $0c,$0c,$01,$0d,$01,$0e,$04,$0f,$fe
        db $05,$11,$15,$09,$10,$0f,$fe
        db $04,$05,$0c,$14,$01,$ff

mensaje_8:
        db $04,$05,$0c,$14,$01,$00,$21,$00      ; DELTA 1
        db $12,$05,$01,$04,$19,$2e,$fe          ; READY!
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$12,$fe              ; ENTER
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING A
        db $01,$ff
        ; ­DELTA 1 LISTO! / ENTRANDO AL / EDIFICIO A
        db $37,$04,$05,$0c,$14,$01,$00,$21,$00,$0c,$09,$13,$14,$0f,$2e,$fe
        db $05,$0e,$14,$12,$01,$0e,$04,$0f,$00,$01,$0c,$fe
        db $05,$04,$09,$06,$09,$03,$09,$0f,$00,$01,$ff

mensaje_9:
        db $04,$05,$0c,$14,$01,$00,$22,$00      ; DELTA 2
        db $12,$05,$01,$04,$19,$2e,$fe          ; READY!
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$12,$FE              ; ENTER
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING B
        db $02,$ff
        ; ­DELTA 2 LISTA! / ENTRANDO AL / EDIFICIO B
        db $37,$04,$05,$0c,$14,$01,$00,$22,$00,$0c,$09,$13,$14,$01,$2e,$fe
        db $05,$0e,$14,$12,$01,$0e,$04,$0f,$00,$01,$0c,$fe
        db $05,$04,$09,$06,$09,$03,$09,$0f,$00,$02,$ff

mensaje_10:     ; GAME OVER
        db $00,$07,$01,$0d,$05,$00,$0f,$16,$05,$12,$00,$ff
mensaje_10a:    ; FIN DE JUEGO
        db $00,$06,$09,$0e,$00,$04,$05,$00,$0a,$15,$05,$07,$0f,$00,$ff

mensaje_11:     ; INFECTION
        db $09,$0e,$06,$05,$03,$14,$09,$0f,$0e,$ff
        ; INFECCION
        db $09,$0e,$06,$05,$03,$03,$09,$0f,$0e,$ff

