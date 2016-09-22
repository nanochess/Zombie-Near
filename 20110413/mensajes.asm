        ;
        ; Mensajes de Zombie Near
        ;
        ; por Oscar Toledo Guti‚rrez.
        ;
        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez.
        ;
        ; Creaci¢n: 20-ene-2011. 
        ; Revisi¢n: 26-mar-2011. Correcci¢n I CAME -> I COME y HARMED ->
        ;                        HURT
        ; Revisi¢n: 29-mar-2011. Cambios en di logos.
        ; Revisi¢n: 02-abr-2011. Mejoras en di logos.
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
        ; Retrato (byte 1, bits 4-7):
        ; $10 - Delta
        ; $20 - Telefonista
        ; $30 - Cient¡fica 
        ; $40 - Jefe 1 
        ; $50 - Jefe 2 
        ;
        ; Longitud (byte 1, bits 0-3):
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
        db 0,$10 OR 9
        ; IT WAS SO / EASY!
        db $09,$14,$00,$17,$01,$13,$00,$13,$4f
        db $05,$01,$13,$19,$aE
        ; ­FUE TAN / FACIL!
        db $37,$06,$15,$05,$00,$14,$01,$4e
        db $06,$01,$03,$09,$0c,$ae

historia_1b:
        db 0,$10 OR 14
        ; NO ZOMBIE CAN / DEFEAT ME!
        db $0e,$0f,$00,$1a,$0f,$0d,$02,$09,$05,$00,$03,$01,$4e
        db $04,$05,$06,$05,$01,$14,$00,$0d,$05,$ae
        ; ­NINGUN ZOMBIE / PUEDE GANARME!
        db $37,$0e,$09,$0e,$07,$15,$0e,$00,$1a,$0f,$0d,$02,$09,$45
        db $10,$15,$05,$04,$05,$00,$07,$01,$0e,$01,$12,$0d,$05,$ae

historia_2:
        db 1,$20 OR 12
        ; WELL DONE! / SCIENTISTS / RESCUED- 00
        db $17,$05,$0c,$0c,$00,$04,$0f,$0e,$05,$6e
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$00,$3e,$bf
        ; ­BIEN HECHO! / CIENTIFICOS / HALLADOS- 00
        db $37,$02,$09,$05,$0e,$00,$08,$05,$03,$08,$0f,$6e
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$53
        db $08,$01,$0c,$0c,$01,$04,$0f,$13,$34,$3e,$bf

historia_3a:
        db 2,$10 OR 13
        ; I'M DOING / MY BEST
        db $09,$30,$0d,$00,$04,$0f,$09,$0e,$07,$00,$0d,$59
        db $02,$05,$13,$94
        ; HAGO MI MEJOR / ESFUERZO
        db $08,$01,$07,$0f,$00,$0d,$09,$00,$0d,$05,$0a,$0f,$52
        db $05,$13,$06,$15,$05,$12,$1a,$8f

historia_3b:
        db 2,$10 OR 12
        ; I LIKE TO / SAVE PEOPLE
        db $09,$00,$0c,$09,$0b,$05,$00,$14,$4f
        db $13,$01,$16,$05,$00,$10,$05,$0f,$10,$0c,$85
        ; ME GUSTA / SALVAR GENTE
        db $0d,$05,$00,$07,$15,$13,$14,$41
        db $13,$01,$0c,$16,$01,$12,$00,$07,$05,$0e,$14,$85

historia_4a:
        db 0,$10 OR 12
        ; I DIDN'T SAW / PEOPLE
        db $09,$00,$04,$09,$04,$0e,$30,$14,$00,$13,$01,$57
        db $10,$05,$0f,$10,$0c,$85
        ; ¨ACASO HABIA / ALGUIEN?
        db $35,$01,$03,$01,$13,$0f,$00,$08,$01,$02,$09,$41
        db $01,$0c,$07,$15,$09,$05,$0e,$af

historia_4b:
        db 0,$10 OR 13
        ; IT IS SO SAD
        db $09,$14,$00,$09,$13,$00,$13,$0f,$00,$13,$01,$84
        ; ES TAN TRISTE
        db $05,$13,$00,$14,$01,$0e,$00,$14,$12,$09,$13,$14,$85

historia_5:
        db 0,$20 OR 9
        ; WAIT! I'M / RECEIVING / SOMETHING
        db $17,$01,$09,$14,$2e,$00,$09,$30,$4d
        db $12,$05,$03,$05,$09,$16,$09,$0e,$47
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$87
        ; ­MOMENTO! / RECIBO / ALGO
        db $37,$0d,$0f,$0d,$05,$0e,$14,$0f,$6e
        db $12,$05,$03,$09,$02,$4f
        db $01,$0c,$07,$8f

historia_6:
        db 3,$30 OR 11
        ; PLEASE HELP / ME! I'M / SURROUNDED
        db $10,$0c,$05,$01,$13,$05,$00,$08,$05,$0c,$50
        db $0d,$05,$2e,$00,$09,$30,$4d
        db $13,$15,$12,$12,$0f,$15,$0e,$04,$05,$84
        ; ­AYUDA POR / FAVOR! ME / HAN RODEADO
        db $37,$01,$19,$15,$04,$01,$00,$10,$0f,$52
        db $06,$01,$16,$0f,$12,$2e,$00,$0d,$45
        db $08,$01,$0e,$00,$12,$0f,$04,$05,$01,$04,$8f

historia_7a:
        db 0,$10 OR 10
        ; I COME TO / SAVE YOU
        db $09,$00,$03,$0f,$0d,$05,$00,$14,$4f
        db $13,$01,$16,$05,$00,$19,$0f,$95
        ; HE VENIDO / A SALVARTE
        db $08,$05,$00,$16,$05,$0e,$09,$04,$4f
        db $01,$00,$13,$01,$0c,$16,$01,$12,$14,$85

historia_7b:
        db 0,$10 OR 11
        ; I'M HERE TO / RESCUE YOU
        db $09,$30,$0d,$00,$08,$05,$12,$05,$00,$14,$4f
        db $12,$05,$13,$03,$15,$05,$00,$19,$0f,$95
        ; ESTOY AQUI / PARA / RESCATARTE
        db $05,$13,$14,$0f,$19,$00,$01,$11,$15,$49
        db $10,$01,$12,$41
        db $12,$05,$13,$03,$01,$14,$01,$12,$14,$85

historia_8:
        db 0,$30 OR 12
        ; YOU'RE TOO / LATE / I'M INFECTED
        db $19,$0f,$15,$30,$12,$05,$00,$14,$0f,$4f
        db $0c,$01,$14,$45
        db $09,$30,$0d,$00,$09,$0e,$06,$05,$03,$14,$05,$84
        ; LLEGAS MUY / TARDE / ME INFECTE
        db $0c,$0c,$05,$07,$01,$13,$00,$0d,$15,$59
        db $14,$01,$12,$04,$45
        db $0d,$05,$00,$09,$0e,$06,$05,$03,$14,$85

historia_9a:
        db 0,$10 OR 11
        ; INFECTED? / HOW?
        db $09,$0e,$06,$05,$03,$14,$05,$04,$6f
        db $08,$0f,$17,$af
        ; ¨INFECTADA? / ¨COMO PASO?
        db $35,$09,$0e,$06,$05,$03,$14,$01,$04,$01,$6f
        db $35,$03,$0f,$0d,$0f,$00,$10,$01,$13,$0f,$af

historia_9b:
        db 0,$10 OR 12
        ; WHAT ARE YOU / SAYING?
        db $17,$08,$01,$14,$00,$01,$12,$05,$00,$19,$0f,$55
        db $13,$01,$19,$09,$0e,$07,$af
        ; ¨QUE ESTAS / DICIENDO?
        db $35,$11,$15,$05,$00,$05,$13,$14,$01,$53
        db $04,$09,$03,$09,$05,$0e,$04,$0f,$af

historia_10:
        db 4,$30 OR 12
        ; AARGH! HELP! / GRR!
        db $01,$01,$12,$07,$08,$2e,$00,$08,$05,$0c,$10,$6e
        db $07,$12,$12,$ae
        ; ­AARGH! / ­AYUDA! / ­GRR!
        db $37,$01,$01,$12,$07,$08,$6e
        db $37,$01,$19,$15,$04,$01,$6e
        db $37,$07,$12,$12,$ae
        
historia_11a:
        db 0,$10 OR 12
        ; POOR GIRL! / SHE WAS CUTE
        db $10,$0f,$0f,$12,$00,$07,$09,$12,$0c,$6e
        db $13,$08,$05,$00,$17,$01,$13,$00,$03,$15,$14,$85
        ; ­POBRECILLA! / ERA BONITA
        db $37,$10,$0f,$02,$12,$05,$03,$09,$0c,$0c,$01,$6e
        db $05,$12,$01,$00,$02,$0f,$0e,$09,$14,$81

historia_11b:
        db 0,$10 OR 10
        ; I COULDN'T / SAVE HER
        db $09,$00,$03,$0f,$15,$0c,$04,$0e,$30,$54
        db $13,$01,$16,$05,$00,$08,$05,$92
        ; NO PUDE / SALVARLA
        db $0e,$0f,$00,$10,$15,$04,$45
        db $13,$01,$0c,$16,$01,$12,$0c,$81

historia_12:
        db 1,$20 OR 11
        ; SCIENTISTS / RESCUED- 00 / GOOD WORK!
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$3e,$7f
        db $07,$0f,$0f,$04,$00,$17,$0f,$12,$0b,$ae
        ; CIENTIFICOS / HALLADOS- 00 / ­MUY BIEN!
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$53
        db $08,$01,$0c,$0c,$01,$04,$0f,$13,$34,$3e,$7f
        db $37,$0D,$15,$19,$00,$02,$09,$05,$0E,$ae

historia_13a:
        db 2,$10 OR 7
        ; I'M THE / BEST!
        db $09,$30,$0d,$00,$14,$08,$45
        db $02,$05,$13,$14,$ae
        ; ­SOY EL / MEJOR!
        db $37,$13,$0f,$19,$00,$05,$4c
        db $0d,$05,$0a,$0f,$12,$ae

historia_13b:
        db 2,$10 OR 11
        ; I'M / UNBEATABLE!
        db $09,$30,$4d
        db $15,$0e,$02,$05,$01,$14,$01,$02,$0c,$05,$ae
        ; ­SOY / INVENCIBLE!
        db $37,$13,$0f,$59
        db $09,$0e,$16,$05,$0e,$03,$09,$02,$0c,$05,$ae

historia_14a:
        db 0,$10 OR 12
        ; WHAT / SCIENTISTS?
        db $17,$08,$01,$54
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$af
        ; ¨CUALES / CIENTIFICOS?
        db $35,$03,$15,$01,$0c,$05,$53
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$13,$af

historia_14b:
        db 0,$10 OR 12
        ; THERE ARE / SCIENTISTS?
        db $14,$08,$05,$12,$05,$00,$01,$12,$45
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$af
        ; ¨HAY / CIENTIFICOS?
        db $35,$08,$01,$59
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$13,$af

historia_15:
        db 0,$20 OR 14
        ; THERE IS / ANOTHER SIGNAL
        db $14,$08,$05,$12,$05,$00,$09,$53
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$13,$09,$07,$0e,$01,$8c
        ; HAY OTRA / FRAGIL SE¥al
        db $08,$01,$19,$00,$0f,$14,$12,$41
        db $06,$12,$01,$07,$09,$0C,$00,$13,$05,$36,$01,$8c

historia_16:
        db 3,$40 OR 12
        ; HELP ME! I'M / HIDDEN BUT / SOMETHING / FOLLOWS ME!
        db $08,$05,$0c,$10,$00,$0d,$05,$2e,$00,$09,$30,$4d
        db $08,$09,$04,$04,$05,$0e,$00,$02,$15,$54
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$47
        db $06,$0f,$0c,$0c,$0f,$17,$13,$00,$0d,$05,$ae
        ; ­AYUDENME! / ESTOY OCULTO / PERO ­ALGO / ME SIGUE!
        db $37,$01,$19,$15,$04,$05,$0e,$0d,$05,$6e
        db $05,$13,$14,$0f,$19,$00,$0f,$03,$15,$0c,$14,$4f
        db $10,$05,$12,$0f,$00,$37,$01,$0c,$07,$4f
        db $0d,$05,$00,$13,$09,$07,$15,$05,$ae

historia_17a:
        db 0,$10 OR 11
        ; YOU'RE HERE / GREAT!
        db $19,$0F,$15,$30,$12,$05,$00,$08,$05,$12,$45
        db $07,$12,$05,$01,$14,$ae
        ; ESTAS AQUI / ­GRANDIOSO!
        db $05,$13,$14,$01,$13,$00,$01,$11,$15,$49
        db $37,$07,$12,$01,$0e,$04,$09,$0f,$13,$0f,$ae

historia_17b:
        db 0,$10 OR 12
        ; APPEARS THAT / I'M ON TIME / TO SAVE YOU
        db $01,$10,$10,$05,$01,$12,$13,$00,$14,$08,$01,$54
        db $09,$30,$0d,$00,$0f,$0e,$00,$14,$09,$0d,$45
        db $14,$0f,$00,$13,$01,$16,$05,$00,$19,$0f,$95
        ; LLEGUE A / TIEMPO PARA / SALVARTE
        db $0c,$0c,$05,$07,$15,$05,$00,$41
        db $14,$09,$05,$0d,$10,$0f,$00,$10,$01,$12,$41
        db $13,$01,$0c,$16,$01,$12,$14,$85

historia_18:
        db 0,$40 OR 13
        ; SO YOU FOUGHT / YOUR WAY
        db $13,$0f,$00,$19,$0f,$15,$00,$06,$0f,$15,$07,$08,$54
        db $19,$0f,$15,$12,$00,$17,$01,$99
        ; PELEASTE MUY / BIEN
        db $10,$05,$0c,$05,$01,$13,$14,$05,$00,$0d,$15,$59
        db $02,$09,$05,$8e

historia_19a:
        db 0,$10 OR 10
        ; EXCUSE ME?
        db $05,$18,$03,$15,$13,$05,$00,$0d,$05,$af
        ; ¨PERDON?
        db $35,$10,$05,$12,$04,$0f,$0e,$af

historia_19b:
        db 0,$10 OR 13
        ; IT IS MY WORK
        db $09,$14,$00,$09,$13,$00,$0d,$19,$00,$17,$0f,$12,$8b
        ; ES MI TRABAJO
        db $05,$13,$00,$0d,$09,$00,$14,$12,$01,$02,$01,$0a,$8f

historia_20:
        db 0,$40 OR 14
        ; I WASN'T GOING / TO SHOW MY / POWERS
        db $09,$00,$17,$01,$13,$0e,$30,$14,$00,$07,$0f,$09,$0e,$47
        db $14,$0f,$00,$13,$08,$0f,$17,$00,$0d,$59
        db $10,$0f,$17,$05,$12,$93
        ; NO PENSABA / MOSTRAR MIS / PODERES
        db $0e,$0f,$00,$10,$05,$0e,$13,$01,$02,$41
        db $0d,$0f,$13,$14,$12,$01,$12,$00,$0d,$09,$53
        db $10,$0f,$04,$05,$12,$05,$93

historia_21a:
        db 0,$10 OR 13
        ; WAIT! ARE YOU / THE BAD GUY?
        db $17,$01,$09,$14,$2e,$00,$01,$12,$05,$00,$19,$0f,$55
        db $14,$08,$05,$00,$02,$01,$04,$00,$07,$15,$19,$af
        ; ­ESPERA! ¨TU / ERES EL MALO?
        db $37,$05,$13,$10,$05,$12,$01,$2e,$00,$35,$14,$55
        db $05,$12,$05,$13,$00,$05,$0c,$00,$0d,$01,$0c,$0f,$af

historia_21b:
        db 0,$10 OR 14
        ; DO YOU HURT / EVERYBODY?
        db $04,$0f,$00,$19,$0f,$15,$00,$08,$15,$12,$54
        db $05,$16,$05,$12,$19,$02,$0f,$04,$19,$af
        ; ¨TU LASTIMASTE / A LA GENTE?
        db $35,$14,$15,$00,$0c,$01,$13,$14,$09,$0d,$01,$13,$14,$45
        db $01,$00,$0c,$01,$00,$07,$05,$0e,$14,$05,$af

historia_22:
        db 4,$50 OR 13
        ; DO YOU WANT / TO SEE / SOMETHING / REALLY SCARY?
        db $04,$0f,$00,$19,$0f,$15,$00,$17,$01,$0e,$54
        db $14,$0f,$00,$13,$05,$45
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$47
        db $12,$05,$01,$0c,$0c,$19,$00,$13,$03,$01,$12,$19,$af
        ; ¨QUIERES / VER ALGO / REALMENTE / ESPANTOSO?
        db $35,$11,$15,$09,$05,$12,$05,$53
        db $16,$05,$12,$00,$01,$0c,$07,$4f
        db $12,$05,$01,$0c,$0d,$05,$0e,$14,$45
        db $05,$13,$10,$01,$0e,$14,$0f,$13,$0f,$af

historia_23a:
        db 0,$10 OR 12
        ; WHAT A NASTY / ZOMBIE!
        db $17,$08,$01,$14,$00,$01,$00,$0e,$01,$13,$14,$59
        db $1a,$0f,$0d,$02,$09,$05,$ae
        ; ­QUE ZOMBIE / MAS PODRIDO!
        db $37,$11,$15,$05,$00,$1A,$0F,$0D,$02,$09,$45
        db $0D,$01,$13,$00,$10,$0F,$04,$12,$09,$04,$0F,$AE

historia_23b:
        db 0,$10 OR 14
        ; SO MANY HARMED / INNOCENTS!
        db $13,$0f,$00,$0d,$01,$0e,$19,$00,$08,$01,$12,$0d,$05,$44
        db $09,$0e,$0e,$0f,$03,$05,$0e,$14,$13,$ae
        ; ­TANTOS / INOCENTES / LASTIMADOS!
        db $37,$14,$01,$0e,$14,$0f,$53
        db $09,$0e,$0f,$03,$05,$0e,$14,$05,$53
        db $0c,$01,$13,$14,$09,$0d,$01,$04,$0f,$13,$ae

historia_24:
        db 1,$20 OR 11
        ; MISSION / COMPLETE! / SCIENTISTS / RESCUED- 00
        db $0d,$09,$13,$13,$09,$0f,$4e
        db $03,$0f,$0d,$10,$0c,$05,$14,$05,$6e
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$3e,$bf
        ; ­MISION / COMPLETA! / CIENTIFICOS / HALLADOS- 00
        db $37,$0D,$09,$13,$09,$0F,$4e
        db $03,$0f,$0d,$10,$0c,$05,$14,$01,$6e
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$53
        db $08,$01,$0c,$0c,$01,$04,$0f,$13,$34,$3e,$bf

historia_25a:
        db 2,$10 OR 11
        ; I DESERVE / A MEDAL
        db $09,$00,$04,$05,$13,$05,$12,$16,$45
        db $01,$00,$0d,$05,$04,$01,$8c
        ; MEREZCO UNA / MEDALLA
        db $0d,$05,$12,$05,$1a,$03,$0f,$00,$15,$0e,$41
        db $0d,$05,$04,$01,$0c,$0c,$81

historia_25b:
        db 2,$10 OR 12
        ; I'M PROUD OF / MYSELF!
        db $09,$30,$0d,$00,$10,$12,$0f,$15,$04,$00,$0f,$46
        db $0d,$19,$13,$05,$0c,$06,$ae
        ; ­ME SIENTO / ORGULLOSA!
        db $37,$0d,$05,$00,$13,$09,$05,$0e,$14,$4f
        db $0f,$12,$07,$15,$0c,$0c,$0f,$13,$01,$ae

historia_26a:
        db 0,$10 OR 12
        ; I DIDN'T SAW / ANYBODY
        db $09,$00,$04,$09,$04,$0e,$30,$14,$00,$13,$01,$57
        db $01,$0e,$19,$02,$0f,$04,$99
        ; NO VI A / NADIE
        db $0e,$0f,$00,$16,$09,$00,$41
        db $0e,$01,$04,$09,$85

historia_26b:
        db 0,$10 OR 7
        ; PEOPLE? / WHERE?
        db $10,$05,$0F,$10,$0C,$05,$6f
        db $17,$08,$05,$12,$05,$af
        ; ¨GENTE? / ¨DONDE?
        db $35,$07,$05,$0e,$14,$05,$6f
        db $35,$04,$0f,$0e,$04,$05,$af

historia_27:
        db 0,$20 OR 12
        ; THE SENSORS / LOCATED A / HIDDEN FLOOR
        db $14,$08,$05,$00,$13,$05,$0e,$13,$0f,$12,$53
        db $0c,$0f,$03,$01,$14,$05,$04,$00,$41
        db $08,$09,$04,$04,$05,$0e,$00,$06,$0c,$0f,$0f,$92
        ; LOS SENSORES / HALLARON UN / PISO OCULTO
        db $0c,$0f,$13,$00,$13,$05,$0e,$13,$0f,$12,$05,$53
        db $08,$01,$0c,$0c,$01,$12,$0f,$0e,$00,$15,$4e
        db $10,$09,$13,$0F,$00,$0f,$03,$15,$0c,$14,$8f

historia_28a:
        db 3,$10 OR 14
        ; I CAN'T WAIT / TO KILL SOME / MORE ZOMBIES
        db $09,$00,$03,$01,$0e,$30,$14,$00,$17,$01,$09,$54
        db $14,$0f,$00,$0b,$09,$0c,$0c,$00,$13,$0f,$0d,$45
        db $0d,$0f,$12,$05,$00,$1a,$0f,$0d,$02,$09,$05,$93
        ; ­BIEN! ACABARE / CON MAS / ZOMBIES
        db $37,$02,$09,$05,$0e,$2e,$00,$01,$03,$01,$02,$01,$12,$45
        db $03,$0f,$0e,$00,$0d,$01,$53
        db $1a,$0f,$0d,$02,$09,$05,$93

historia_28b:
        db 3,$10 OR 12
        ; WHY ZOMBIES / DON'T JUST / DROP DEAD?
        db $17,$08,$19,$00,$1a,$0f,$0d,$02,$09,$05,$53
        db $04,$0f,$0e,$30,$14,$00,$0a,$15,$13,$54
        db $04,$12,$0f,$10,$00,$04,$05,$01,$04,$af
        ; LOS ZOMBIES / DEBERIAN / MORIRSE Y YA
        db $0c,$0f,$13,$00,$1a,$0f,$0d,$02,$09,$05,$53
        db $04,$05,$02,$05,$12,$09,$01,$4e
        db $0d,$0f,$12,$09,$12,$13,$05,$00,$19,$00,$19,$81

historia_29a:
        db 0,$10 OR 13
        ; WHAT IS THIS?
        db $17,$08,$01,$14,$00,$09,$13,$00,$14,$08,$09,$13,$af
        ; ¨QUE ES ESTO?
        db $35,$11,$15,$05,$00,$05,$13,$00,$05,$13,$14,$0f,$af

historia_29b:
        db 0,$10 OR 13
        ; AGAIN YOU!
        db $01,$07,$01,$09,$0e,$00,$19,$0f,$15,$ae
        ; ­OTRA VEZ TU!
        db $37,$0F,$14,$12,$01,$00,$16,$05,$1A,$00,$14,$15,$ae

historia_30:
        db 0,$40 OR 11
        ; I'M BACK / TO CRUSH / YOU
        db $09,$30,$0d,$00,$02,$01,$03,$0b,$00,$14,$4f
        db $03,$12,$15,$13,$08,$00,$19,$0f,$95
        ; HE VUELTO / PARA / ANIQUILARTE
        db $08,$05,$00,$16,$15,$05,$0c,$14,$4f
        db $10,$01,$12,$41
        db $01,$0e,$09,$11,$15,$09,$0c,$01,$12,$14,$85

historia_31a:
        db 0,$10 OR 14
        ; I'LL MAKE SURE / TO GET YOU / BACK TO HELL
        db $09,$30,$0c,$0c,$00,$0d,$01,$0b,$05,$00,$13,$15,$12,$45
        db $14,$0f,$00,$07,$05,$14,$00,$19,$0f,$55
        db $02,$01,$03,$0b,$00,$14,$0f,$00,$08,$05,$0c,$8c
        ; ME ASEGURARE / DE REGRESARTE / AL AVERNO
        db $0d,$05,$00,$01,$13,$05,$07,$15,$12,$01,$12,$45
        db $04,$05,$00,$12,$05,$07,$12,$05,$13,$01,$12,$14,$45
        db $01,$0c,$00,$01,$16,$05,$12,$0e,$8f

historia_31b:
        db 0,$10 OR 12
        ; THIS TIME / YOU WILL NOT / GET BACK
        db $14,$08,$09,$13,$00,$14,$09,$0d,$45
        db $19,$0f,$15,$00,$17,$09,$0c,$0c,$00,$0e,$0f,$54
        db $07,$05,$14,$00,$02,$01,$03,$8b
        ; ESTA VEZ / NO VOLVERAS
        db $05,$13,$14,$01,$00,$16,$05,$5a
        db $0e,$0f,$00,$16,$0f,$0c,$16,$05,$12,$01,$93

historia_32:
        db 4,$50 OR 12
        ; YOU WILL BE / A ZOMBIE!
        db $19,$0f,$15,$00,$17,$09,$0c,$0c,$00,$02,$45
        db $01,$00,$1a,$0f,$0d,$02,$09,$05,$ae
        ; ­SERAS UNO / DE NOSOTROS!
        db $37,$13,$05,$12,$01,$13,$00,$15,$0E,$4F
        db $04,$05,$00,$0E,$0F,$13,$0F,$14,$12,$0F,$13,$ae

historia_33a:
        db 0,$10 OR 14
        ; ANOTHER DAY / ANOTHER ZOMBIE
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$04,$01,$59
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$1a,$0f,$0d,$02,$09,$85
        ; OTRO DIA Y / OTRO ZOMBIE
        db $0f,$14,$12,$0f,$00,$04,$09,$01,$00,$59
        db $0f,$14,$12,$0f,$00,$1a,$0f,$0d,$02,$09,$85

historia_33b:
        db 0,$10 OR 11
        ; WHAT A UGLY / ZOMBIE!
        db $17,$08,$01,$14,$00,$01,$00,$15,$07,$0c,$59
        db $1a,$0f,$0d,$02,$09,$85
        ; ­QUE ZOMBIE / TAN FEO!
        db $37,$11,$15,$05,$00,$1a,$0f,$0d,$02,$09,$45
        db $14,$01,$0e,$00,$06,$05,$0f,$ae

historia_34:
        db 1,$20 OR 13
        ; THAT IS ALL! / SCIENTISTS / RESCUED- 00
        db $14,$08,$01,$14,$00,$09,$13,$00,$01,$0c,$0c,$6e
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$3e,$bf
        ; ­ESO ES TODO! / CIENTIFICOS / HALLADOS- 00
        db $37,$05,$13,$0f,$00,$05,$13,$00,$14,$0f,$04,$0f,$6e
        db $03,$09,$05,$0e,$14,$09,$06,$09,$03,$0f,$53
        db $08,$01,$0c,$0c,$01,$04,$0f,$13,$34,$3e,$bf

historia_35a:
        db 2,$10 OR 13
        ; TIME FOR MY / VICTORY DANCE
        db $14,$09,$0d,$05,$00,$06,$0f,$12,$00,$0d,$59
        db $16,$09,$03,$14,$0f,$12,$19,$00,$04,$01,$0e,$03,$85
        ; HORA DE MI / BAILE DE LA / VICTORIA
        db $08,$0f,$12,$01,$00,$04,$05,$00,$0d,$49
        db $02,$01,$09,$0c,$05,$00,$04,$05,$00,$0c,$41
        db $16,$09,$03,$14,$0f,$12,$09,$81

historia_35b:
        db 2,$10 OR 13
        ; I'M TIRED
        db $09,$30,$0d,$00,$14,$09,$12,$05,$84
        ; ESTOY AGOTADA
        db $05,$13,$14,$0f,$19,$00,$01,$07,$0f,$14,$01,$04,$81

historia_36a:
        db 0,$10 OR 9
        ; ARE YOU / KIDDING?
        db $01,$12,$05,$00,$19,$0f,$55
        db $0b,$09,$04,$04,$09,$0e,$07,$af
        ; ¨BROMEAS?
        db $35,$02,$12,$0f,$0d,$05,$01,$13,$af

historia_36b:
        db 0,$10 OR 13
        ; NO TIME FOR / SAVING PEOPLE
        db $0e,$0f,$00,$14,$09,$0d,$05,$00,$06,$0f,$52
        db $13,$01,$16,$09,$0e,$07,$00,$10,$05,$0f,$10,$0c,$85
        ; NO HUBO / TIEMPO
        db $0e,$0f,$00,$08,$15,$02,$4f
        db $14,$09,$05,$0d,$10,$8f

historia_37:
        db 0,$20 OR 13
        ; I'VE SENT YOU / A HELICOPTER
        db $09,$30,$16,$05,$00,$13,$05,$0e,$14,$00,$19,$0f,$55
        db $01,$00,$08,$05,$0c,$09,$03,$0f,$10,$14,$05,$92
        ; TE MANDE UN / HELICOPTERO
        db $14,$05,$00,$0d,$01,$0e,$04,$05,$00,$15,$4e
        db $08,$05,$0c,$09,$03,$0f,$10,$14,$05,$12,$8f

historia_38a:
        db 5,$10 OR 10
        ; I'LL BE ON / TIME TO / WATCH TV!
        db $09,$30,$0c,$0c,$00,$02,$05,$00,$0f,$4e
        db $14,$09,$0d,$05,$00,$14,$4f
        db $17,$01,$14,$03,$08,$00,$14,$16,$ae
        ; ESTARE A / TIEMPO / ­PARA VER / TV!
        db $05,$13,$14,$01,$12,$05,$00,$41
        db $14,$09,$05,$0d,$10,$4f
        db $37,$10,$01,$12,$01,$00,$16,$05,$52
        db $14,$16,$ae

historia_38b:
        db 5,$10 OR 12
        ; I'VE TO FEED / MY CATS
        db $09,$30,$16,$05,$00,$14,$0f,$00,$06,$05,$05,$44
        db $0d,$19,$00,$03,$01,$14,$93
        ; TENGO QUE / ALIMENTAR A / MIS GATITOS
        db $14,$05,$0e,$07,$0f,$00,$11,$15,$45
        db $01,$0c,$09,$0d,$05,$0e,$14,$01,$12,$00,$41
        db $0d,$09,$13,$00,$07,$01,$14,$09,$14,$0f,$93

        ;
        ; Los mensajes de la historia b sica.
        ; No deben ser m s de tres l¡neas por mensaje.
        ;
mensaje_1:
        db $14,$08,$05,$12,$05,$00,$09,$13,$00,$41  ; THERE IS A /
        db $13,$05,$03,$15,$12,$09,$14,$59          ; SECURITY /
        db $02,$12,$05,$01,$03,$88                  ; BREACH
        ; HAY UNA / BRECHA DE / SEGURIDAD
        db $08,$01,$19,$00,$15,$0e,$41
        db $02,$12,$05,$03,$08,$01,$00,$04,$45
        db $13,$05,$07,$15,$12,$09,$04,$01,$84

mensaje_2:
        db $03,$0C,$0F,$13,$05,$00              ; CLOSE
        db $04,$0f,$17,$4e                  ; DOWN /
        db $14,$08,$05,$00                      ; THE
        db $07,$01,$14,$05,$93              ; GATES
        ; CIERRE / LAS / PUERTAS
        db $03,$09,$05,$12,$12,$05,$00,$0c,$01,$53
        db $10,$15,$05,$12,$14,$01,$93

mensaje_3:
        db $14,$08,$05,$0D,$30,$12,$05,$00      ; THEM'RE
        db $14,$08,$12,$0F,$15,$07,$48      ; THROUGH /
        db $14,$08,$05,$00                      ; THE
        db $02,$15,$09,$0C,$04,$09,$0E,$07,$AE  ; BUILDING!
        ; ­SE DISPERSARON / POR EL / EDIFICIO!
        db $37,$13,$05,$00
        db $04,$09,$13,$10,$05,$12,$13,$01,$12,$0f,$4e
        db $10,$0f,$12,$00,$05,$4c
        db $05,$04,$09,$06,$09,$03,$09,$0f,$ae

mensaje_4:
        db $03,$01,$0c,$0c,$00                  ; CALL
        db $13,$10,$05,$03,$09,$01,$4c      ; SPECIAL /
        db $14,$05,$01,$0d,$00                  ; TEAM
        db $0e,$0f,$17,$aE                      ; NOW!
        ; LLAME AL / EQUIPO / TACTICO
        db $0c,$0c,$01,$0d,$05,$00,$01,$4c
        db $05,$11,$15,$09,$10,$4f
        db $14,$01,$03,$14,$09,$03,$8f

mensaje_5:
        db $17,$08,$01,$14,$30,$13,$00          ; WHAT'S
        db $14,$08,$01,$14,$aF                  ; THAT?
        ; ¨QUE ES ESO?
        db $35,$11,$15,$05,$00,$05,$13,$00
        db $05,$13,$0f,$af

mensaje_6:
        db $00,$0F,$08,$00,$0D,$19,$00          ; OH MY
        db $07,$0F,$04,$2E,$80              ; GOD!
        ; ­SANTO CIELO!
        db $37,$13,$01,$0e,$14,$0f,$00
        db $03,$09,$05,$0c,$0f,$ae

mensaje_7:
        db $05,$0d,$05,$12,$07,$05,$0e,$03,$19,$6e  ; EMERGENCY! /
        db $03,$01,$0c,$0c,$09,$0e,$47      ; CALLING /
        db $04,$05,$0c,$14,$01,$00              ; DELTA
        db $14,$05,$01,$8d                  ; TEAM
        ; ­URGENTE! / LLAMANDO / EQUIPO / DELTA
        db $37,$15,$12,$07,$05,$0e,$14,$05,$6e
        db $0c,$0c,$01,$0d,$01,$0e,$04,$4f
        db $05,$11,$15,$09,$10,$4f
        db $04,$05,$0c,$14,$81

mensaje_8:
        db $04,$05,$0c,$14,$01,$00,$21,$00      ; DELTA 1
        db $12,$05,$01,$04,$19,$6e          ; READY! /
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$52              ; ENTER /
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING A
        db $81
        ; ­DELTA 1 LISTO! / ENTRANDO AL / EDIFICIO A
        db $37,$04,$05,$0c,$14,$01,$00,$21,$00,$0c,$09,$13,$14,$0f,$6e
        db $05,$0e,$14,$12,$01,$0e,$04,$0f,$00,$01,$4c
        db $05,$04,$09,$06,$09,$03,$09,$0f,$00,$81

mensaje_9:
        db $04,$05,$0c,$14,$01,$00,$22,$00      ; DELTA 2
        db $12,$05,$01,$04,$19,$6e         ; READY! /
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$52              ; ENTER /
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING B
        db $82
        ; ­DELTA 2 LISTA! / ENTRANDO AL / EDIFICIO B
        db $37,$04,$05,$0c,$14,$01,$00,$22,$00,$0c,$09,$13,$14,$01,$6e
        db $05,$0e,$14,$12,$01,$0e,$04,$0f,$00,$01,$4c
        db $05,$04,$09,$06,$09,$03,$09,$0f,$00,$82

mensaje_10:     ; GAME OVER
        db $07,$01,$0d,$05,$00,$0f,$16,$05,$12
mensaje_10a:    ; FIN DE JUEGO
        db $06,$09,$0e,$00,$04,$05,$00,$0a,$15,$05,$07,$0f

mensaje_11:     ; INFECTION
        db $09,$0e,$06,$05,$03,$14,$09,$0f,$8e
        ; INFECCION
        db $09,$0e,$06,$05,$03,$03,$09,$0f,$8e

mensaje_12:     ; DISTRIBUTED BY
        db $00,$04,$09,$13,$14,$12,$09,$02,$15,$14,$05,$04,$00,$02,$99
        ; DISTRIBUIDO POR
        db $04,$09,$13,$14,$12,$09,$02,$15,$09,$04,$0f,$00,$10,$0f,$92
        
