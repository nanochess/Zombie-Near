        ;
        ; Mensajes de Zombie Near
        ;
        ; por Oscar Toledo GutiÇrrez.
        ;
        ; (c) Copyright 2011 Oscar Toledo GutiÇrrez.
        ;
        ; Creaci¢n: 20-ene-2011.
        ; Revisi¢n: 21-abr-2011. Se eliminan mensajes en espa§ol.
        ; Revisi¢n: 23-abr-2011. Se agrega minihistoria.
        ; Revisi¢n: 26-abr-2011. Ajustes en minihistoria y se agregan nombres
        ;                        de personajes.
        ; Revisi¢n: 12-may-2011. Se elimina mensaje_20.
        ; Revisi¢n: 27-jun-2011. Se agregan los mensajes para el mapa 4.
        ; Revisi¢n: 01-jul-2013. Indica contrase§as para acceder mapas.
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
        ; $30 - Cient°fica 
        ; $40 - Jefe 1 
        ; $50 - Jefe 2 
        ;
        ; Longitud (byte 1, bits 0-3):
        ; Contiene la longitud m†xima de una l°nea, no debe exceder de 14
        ; caracteres.
        ;
        ; Letras:
        ; 01-1a - Alfabeto (A-Z)
        ; 20-29 - N£meros (0-9)
        ; 2e - !
        ; 2f - ?
        ; 30 - '
        ; 31 - %
        ; 34 - -
        ; 35 - :
        ; 3e - Din†mico (cuenta de cientçficos rescatados, decenas)
        ; 3f - Din†mico (cuenta de cientçficos rescatados, unidades)
        ;
        ; bits 5-0 - Letras.
        ; bit 6 - 0: Letra
        ;         1: Letra y cambio de l°nea
        ; bit 7 - 0: Letra
        ;         1: Letra y fin de mensaje
        ;
historia_1a:
        db 0,$10 OR 9
        ; IT WAS SO / EASY!
        db $09,$14,$00,$17,$01,$13,$00,$13,$4f
        db $05,$01,$13,$19,$aE

historia_1b:
        db 0,$10 OR 14
        ; NO ZOMBIE CAN / DEFEAT ME!
        db $0e,$0f,$00,$1a,$0f,$0d,$02,$09,$05,$00,$03,$01,$4e
        db $04,$05,$06,$05,$01,$14,$00,$0d,$05,$ae

historia_2:
        db 1,$20 OR 12
        ; WELL DONE! / SCIENTISTS / RESCUED- 00 / PASSWORD IS / 673X
        db $17,$05,$0c,$0c,$00,$04,$0f,$0e,$05,$6e
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$00,$3e,$7f
        db $10,$01,$13,$13,$17,$0f,$12,$04,$00,$09,$53
        db $34,$34,$00,$26,$27,$23,$3d,$00,$34,$b4

historia_3a:
        db 2,$10 OR 13
        ; I'M DOING / MY BEST
        db $09,$30,$0d,$00,$04,$0f,$09,$0e,$07,$00,$0d,$59
        db $02,$05,$13,$94

historia_3b:
        db 2,$10 OR 12
        ; I LIKE TO / SAVE PEOPLE
        db $09,$00,$0c,$09,$0b,$05,$00,$14,$4f
        db $13,$01,$16,$05,$00,$10,$05,$0f,$10,$0c,$85

historia_4a:
        db 0,$10 OR 12
        ; I DIDN'T SAW / PEOPLE
        db $09,$00,$04,$09,$04,$0e,$30,$14,$00,$13,$01,$57
        db $10,$05,$0f,$10,$0c,$85

historia_4b:
        db 0,$10 OR 13
        ; IT IS SO SAD
        db $09,$14,$00,$09,$13,$00,$13,$0f,$00,$13,$01,$84

historia_5:
        db 0,$20 OR 9
        ; WAIT! I'M / RECEIVING / SOMETHING
        db $17,$01,$09,$14,$2e,$00,$09,$30,$4d
        db $12,$05,$03,$05,$09,$16,$09,$0e,$47
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$87

historia_6:
        db 3,$30 OR 11
        ; PLEASE HELP / ME! I'M / SURROUNDED
        db $10,$0c,$05,$01,$13,$05,$00,$08,$05,$0c,$50
        db $0d,$05,$2e,$00,$09,$30,$4d
        db $13,$15,$12,$12,$0f,$15,$0e,$04,$05,$84

historia_7a:
        db 0,$10 OR 10
        ; I COME TO / SAVE YOU
        db $09,$00,$03,$0f,$0d,$05,$00,$14,$4f
        db $13,$01,$16,$05,$00,$19,$0f,$95

historia_7b:
        db 0,$10 OR 11
        ; I'M HERE TO / RESCUE YOU
        db $09,$30,$0d,$00,$08,$05,$12,$05,$00,$14,$4f
        db $12,$05,$13,$03,$15,$05,$00,$19,$0f,$95

historia_8:
        db 0,$30 OR 12
        ; YOU'RE TOO / LATE / I'M INFECTED
        db $19,$0f,$15,$30,$12,$05,$00,$14,$0f,$4f
        db $0c,$01,$14,$45
        db $09,$30,$0d,$00,$09,$0e,$06,$05,$03,$14,$05,$84

historia_9a:
        db 0,$10 OR 11
        ; INFECTED? / HOW?
        db $09,$0e,$06,$05,$03,$14,$05,$04,$6f
        db $08,$0f,$17,$af

historia_9b:
        db 0,$10 OR 12
        ; WHAT ARE YOU / SAYING?
        db $17,$08,$01,$14,$00,$01,$12,$05,$00,$19,$0f,$55
        db $13,$01,$19,$09,$0e,$07,$af

historia_10:
        db 4,$30 OR 12
        ; AARGH! HELP! / GRR!
        db $01,$01,$12,$07,$08,$2e,$00,$08,$05,$0c,$10,$6e
        db $07,$12,$12,$ae
        
historia_11a:
        db 0,$10 OR 12
        ; POOR GIRL! / SHE WAS CUTE
        db $10,$0f,$0f,$12,$00,$07,$09,$12,$0c,$6e
        db $13,$08,$05,$00,$17,$01,$13,$00,$03,$15,$14,$85

historia_11b:
        db 0,$10 OR 10
        ; I COULDN'T / SAVE HER
        db $09,$00,$03,$0f,$15,$0c,$04,$0e,$30,$54
        db $13,$01,$16,$05,$00,$08,$05,$92

historia_12:
        db 1,$20 OR 11
        ; SCIENTISTS / RESCUED- 00 / GOOD WORK! / PASSWORD IS / 392X
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$3e,$7f
        db $07,$0f,$0f,$04,$00,$17,$0f,$12,$0b,$6e
        db $10,$01,$13,$13,$17,$0f,$12,$04,$00,$09,$53
        db $34,$34,$00,$23,$29,$22,$3d,$00,$34,$b4

historia_13a:
        db 2,$10 OR 7
        ; I'M THE / BEST!
        db $09,$30,$0d,$00,$14,$08,$45
        db $02,$05,$13,$14,$ae

historia_13b:
        db 2,$10 OR 11
        ; I'M / UNBEATABLE!
        db $09,$30,$4d
        db $15,$0e,$02,$05,$01,$14,$01,$02,$0c,$05,$ae

historia_14a:
        db 0,$10 OR 12
        ; WHAT / SCIENTISTS?
        db $17,$08,$01,$54
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$af

historia_14b:
        db 0,$10 OR 12
        ; THERE ARE / SCIENTISTS?
        db $14,$08,$05,$12,$05,$00,$01,$12,$45
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$13,$af

historia_15:
        db 0,$20 OR 14
        ; THERE IS / ANOTHER SIGNAL
        db $14,$08,$05,$12,$05,$00,$09,$53
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$13,$09,$07,$0e,$01,$8c

historia_16:
        db 3,$40 OR 12
        ; HELP ME! I'M / HIDDEN BUT / SOMETHING / FOLLOWS ME!
        db $08,$05,$0c,$10,$00,$0d,$05,$2e,$00,$09,$30,$4d
        db $08,$09,$04,$04,$05,$0e,$00,$02,$15,$54
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$47
        db $06,$0f,$0c,$0c,$0f,$17,$13,$00,$0d,$05,$ae

historia_17a:
        db 0,$10 OR 11
        ; YOU'RE HERE / GREAT!
        db $19,$0F,$15,$30,$12,$05,$00,$08,$05,$12,$45
        db $07,$12,$05,$01,$14,$ae

historia_17b:
        db 0,$10 OR 12
        ; APPEARS THAT / I'M ON TIME / TO SAVE YOU
        db $01,$10,$10,$05,$01,$12,$13,$00,$14,$08,$01,$54
        db $09,$30,$0d,$00,$0f,$0e,$00,$14,$09,$0d,$45
        db $14,$0f,$00,$13,$01,$16,$05,$00,$19,$0f,$95

historia_18:
        db 0,$40 OR 13
        ; SO YOU FOUGHT / YOUR WAY
        db $13,$0f,$00,$19,$0f,$15,$00,$06,$0f,$15,$07,$08,$54
        db $19,$0f,$15,$12,$00,$17,$01,$99

historia_19a:
        db 0,$10 OR 10
        ; EXCUSE ME?
        db $05,$18,$03,$15,$13,$05,$00,$0d,$05,$af

historia_19b:
        db 0,$10 OR 13
        ; IT IS MY WORK
        db $09,$14,$00,$09,$13,$00,$0d,$19,$00,$17,$0f,$12,$8b

historia_20:
        db 0,$40 OR 14
        ; I WASN'T GOING / TO SHOW MY / POWERS
        db $09,$00,$17,$01,$13,$0e,$30,$14,$00,$07,$0f,$09,$0e,$47
        db $14,$0f,$00,$13,$08,$0f,$17,$00,$0d,$59
        db $10,$0f,$17,$05,$12,$93

historia_21a:
        db 0,$10 OR 13
        ; WAIT! ARE YOU / THE BAD GUY?
        db $17,$01,$09,$14,$2e,$00,$01,$12,$05,$00,$19,$0f,$55
        db $14,$08,$05,$00,$02,$01,$04,$00,$07,$15,$19,$af

historia_21b:
        db 0,$10 OR 14
        ; DO YOU HURT / EVERYBODY?
        db $04,$0f,$00,$19,$0f,$15,$00,$08,$15,$12,$54
        db $05,$16,$05,$12,$19,$02,$0f,$04,$19,$af

historia_22:
        db 4,$50 OR 13
        ; DO YOU WANT / TO SEE / SOMETHING / REALLY SCARY?
        db $04,$0f,$00,$19,$0f,$15,$00,$17,$01,$0e,$54
        db $14,$0f,$00,$13,$05,$45
        db $13,$0f,$0d,$05,$14,$08,$09,$0e,$47
        db $12,$05,$01,$0c,$0c,$19,$00,$13,$03,$01,$12,$19,$af

historia_23a:
        db 0,$10 OR 12
        ; WHAT A NASTY / ZOMBIE!
        db $17,$08,$01,$14,$00,$01,$00,$0e,$01,$13,$14,$59
        db $1a,$0f,$0d,$02,$09,$05,$ae

historia_23b:
        db 0,$10 OR 14
        ; SO MANY HARMED / INNOCENTS!
        db $13,$0f,$00,$0d,$01,$0e,$19,$00,$08,$01,$12,$0d,$05,$44
        db $09,$0e,$0e,$0f,$03,$05,$0e,$14,$13,$ae

historia_24:
        db 1,$20 OR 12
        ; MISSION / COMPLETE! / SCIENTISTS / RESCUED- 00 / PASSWORD IS / 845X
        db $0d,$09,$13,$13,$09,$0f,$4e
        db $03,$0f,$0d,$10,$0c,$05,$14,$05,$6e
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$3e,$7f
        db $10,$01,$13,$13,$17,$0f,$12,$04,$00,$09,$53
        db $34,$34,$00,$28,$24,$25,$3d,$00,$34,$b4

historia_25a:
        db 2,$10 OR 11
        ; I DESERVE / A MEDAL
        db $09,$00,$04,$05,$13,$05,$12,$16,$45
        db $01,$00,$0d,$05,$04,$01,$8c

historia_25b:
        db 2,$10 OR 12
        ; I'M PROUD OF / MYSELF!
        db $09,$30,$0d,$00,$10,$12,$0f,$15,$04,$00,$0f,$46
        db $0d,$19,$13,$05,$0c,$06,$ae

historia_26a:
        db 0,$10 OR 12
        ; I DIDN'T SAW / ANYBODY
        db $09,$00,$04,$09,$04,$0e,$30,$14,$00,$13,$01,$57
        db $01,$0e,$19,$02,$0f,$04,$99

historia_26b:
        db 0,$10 OR 7
        ; PEOPLE? / WHERE?
        db $10,$05,$0F,$10,$0C,$05,$6f
        db $17,$08,$05,$12,$05,$af

historia_27:
        db 0,$20 OR 12
        ; THE SENSORS / LOCATED A / HIDDEN FLOOR
        db $14,$08,$05,$00,$13,$05,$0e,$13,$0f,$12,$53
        db $0c,$0f,$03,$01,$14,$05,$04,$00,$41
        db $08,$09,$04,$04,$05,$0e,$00,$06,$0c,$0f,$0f,$92

historia_28a:
        db 3,$10 OR 14
        ; I CAN'T WAIT / TO KILL SOME / MORE ZOMBIES
        db $09,$00,$03,$01,$0e,$30,$14,$00,$17,$01,$09,$54
        db $14,$0f,$00,$0b,$09,$0c,$0c,$00,$13,$0f,$0d,$45
        db $0d,$0f,$12,$05,$00,$1a,$0f,$0d,$02,$09,$05,$93

historia_28b:
        db 3,$10 OR 12
        ; WHY ZOMBIES / DON'T JUST / DROP DEAD?
        db $17,$08,$19,$00,$1a,$0f,$0d,$02,$09,$05,$53
        db $04,$0f,$0e,$30,$14,$00,$0a,$15,$13,$54
        db $04,$12,$0f,$10,$00,$04,$05,$01,$04,$af

historia_29a:
        db 0,$10 OR 13
        ; WHAT IS THIS?
        db $17,$08,$01,$14,$00,$09,$13,$00,$14,$08,$09,$13,$af

historia_29b:
        db 0,$10 OR 13
        ; AGAIN YOU!
        db $01,$07,$01,$09,$0e,$00,$19,$0f,$15,$ae

historia_30:
        db 0,$40 OR 11
        ; I'M BACK / TO CRUSH / YOU
        db $09,$30,$0d,$00,$02,$01,$03,$0b,$00,$14,$4f
        db $03,$12,$15,$13,$08,$00,$19,$0f,$95

historia_31a:
        db 0,$10 OR 14
        ; I'LL MAKE SURE / TO GET YOU / BACK TO HELL
        db $09,$30,$0c,$0c,$00,$0d,$01,$0b,$05,$00,$13,$15,$12,$45
        db $14,$0f,$00,$07,$05,$14,$00,$19,$0f,$55
        db $02,$01,$03,$0b,$00,$14,$0f,$00,$08,$05,$0c,$8c

historia_31b:
        db 0,$10 OR 12
        ; THIS TIME / YOU WILL NOT / GET BACK
        db $14,$08,$09,$13,$00,$14,$09,$0d,$45
        db $19,$0f,$15,$00,$17,$09,$0c,$0c,$00,$0e,$0f,$54
        db $07,$05,$14,$00,$02,$01,$03,$8b

historia_32:
        db 4,$50 OR 12
        ; YOU WILL BE / A ZOMBIE!
        db $19,$0f,$15,$00,$17,$09,$0c,$0c,$00,$02,$45
        db $01,$00,$1a,$0f,$0d,$02,$09,$05,$ae

historia_33a:
        db 0,$10 OR 14
        ; ANOTHER DAY / ANOTHER ZOMBIE
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$04,$01,$59
        db $01,$0e,$0f,$14,$08,$05,$12,$00,$1a,$0f,$0d,$02,$09,$85

historia_33b:
        db 0,$10 OR 11
        ; WHAT A UGLY / ZOMBIE!
        db $17,$08,$01,$14,$00,$01,$00,$15,$07,$0c,$59
        db $1a,$0f,$0d,$02,$09,$85

historia_34:
        db 1,$20 OR 13
        ; THAT IS ALL! / SCIENTISTS / RESCUED- 00
        db $14,$08,$01,$14,$00,$09,$13,$00,$01,$0c,$0c,$6e
        db $13,$03,$09,$05,$0e,$14,$09,$13,$14,$53
        db $12,$05,$13,$03,$15,$05,$04,$34,$3e,$bf

historia_35a:
        db 2,$10 OR 13
        ; TIME FOR MY / VICTORY DANCE
        db $14,$09,$0d,$05,$00,$06,$0f,$12,$00,$0d,$59
        db $16,$09,$03,$14,$0f,$12,$19,$00,$04,$01,$0e,$03,$85

historia_35b:
        db 2,$10 OR 13
        ; I'M TIRED
        db $09,$30,$0d,$00,$14,$09,$12,$05,$84

historia_36a:
        db 0,$10 OR 9
        ; ARE YOU / KIDDING?
        db $01,$12,$05,$00,$19,$0f,$55
        db $0b,$09,$04,$04,$09,$0e,$07,$af

historia_36b:
        db 0,$10 OR 13
        ; NO TIME FOR / SAVING PEOPLE
        db $0e,$0f,$00,$14,$09,$0d,$05,$00,$06,$0f,$52
        db $13,$01,$16,$09,$0e,$07,$00,$10,$05,$0f,$10,$0c,$85

historia_37:
        db 0,$20 OR 13
        ; I'VE SENT YOU / A HELICOPTER
        db $09,$30,$16,$05,$00,$13,$05,$0e,$14,$00,$19,$0f,$55
        db $01,$00,$08,$05,$0c,$09,$03,$0f,$10,$14,$05,$92

historia_38a:
        db 5,$10 OR 10
        ; I'LL BE ON / TIME TO / WATCH TV!
        db $09,$30,$0c,$0c,$00,$02,$05,$00,$0f,$4e
        db $14,$09,$0d,$05,$00,$14,$4f
        db $17,$01,$14,$03,$08,$00,$14,$16,$ae

historia_38b:
        db 5,$10 OR 12
        ; I'VE TO FEED / MY CATS
        db $09,$30,$16,$05,$00,$14,$0f,$00,$06,$05,$05,$44
        db $0d,$19,$00,$03,$01,$14,$93

        ;
        ; Los mensajes de la historia b†sica.
        ; No deben ser m†s de tres l°neas por mensaje.
        ;
mensaje_1:
        db $14,$08,$05,$12,$05,$00,$09,$13,$00,$41  ; THERE IS A /
        db $13,$05,$03,$15,$12,$09,$14,$59          ; SECURITY /
        db $02,$12,$05,$01,$03,$88                  ; BREACH

mensaje_2:
        db $03,$0C,$0F,$13,$05,$00              ; CLOSE
        db $04,$0f,$17,$4e                  ; DOWN /
        db $14,$08,$05,$00                      ; THE
        db $07,$01,$14,$05,$93              ; GATES

mensaje_3:
        db $14,$08,$05,$19,$30,$12,$05,$00      ; THEY'RE
        db $14,$08,$12,$0F,$15,$07,$48      ; THROUGH /
        db $14,$08,$05,$00                      ; THE
        db $02,$15,$09,$0C,$04,$09,$0E,$07,$AE  ; BUILDING!

mensaje_4:
        db $03,$01,$0c,$0c,$00                  ; CALL
        db $13,$10,$05,$03,$09,$01,$4c      ; SPECIAL /
        db $14,$05,$01,$0d,$00                  ; TEAM
        db $0e,$0f,$17,$aE                      ; NOW!

mensaje_5:
        db $17,$08,$01,$14,$30,$13,$00          ; WHAT'S
        db $14,$08,$01,$14,$aF                  ; THAT?

mensaje_6:
        db $00,$0F,$08,$00,$0D,$19,$00          ; OH MY
        db $07,$0F,$04,$2E,$80              ; GOD!

mensaje_7:
        db $05,$0d,$05,$12,$07,$05,$0e,$03,$19,$6e  ; EMERGENCY! /
        db $03,$01,$0c,$0c,$09,$0e,$47      ; CALLING /
        db $04,$05,$0c,$14,$01,$00              ; DELTA
        db $14,$05,$01,$8d                  ; TEAM

mensaje_8:
        db $04,$05,$0c,$14,$01,$00,$21,$00      ; DELTA 1
        db $12,$05,$01,$04,$19,$6e          ; READY! /
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$52              ; ENTER /
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING A
        db $81

mensaje_9:
        db $04,$05,$0c,$14,$01,$00,$22,$00      ; DELTA 2
        db $12,$05,$01,$04,$19,$6e         ; READY! /
        db $09,$30,$0c,$0c,$00                  ; I'LL
        db $05,$0e,$14,$05,$52              ; ENTER /
        db $02,$15,$09,$0c,$04,$09,$0e,$07,$00  ; BUILDING B
        db $82

mensaje_11:     ; INFECTION
        db $09,$0e,$06,$05,$03,$14,$09,$0f,$8e

mensaje_12:     ; DISTRIBUTED BY
        db $04,$09,$13,$14,$12,$09,$02,$15,$14,$05,$04,$00,$02,$99

mensaje_13:     ; I'VE BEEN / THINKING / ABOUT US
        db $09,$30,$16,$05,$00,$02,$05,$05,$4e
        db $14,$08,$09,$0e,$0b,$09,$0e,$47
        db $01,$02,$0f,$15,$14,$00,$15,$93

mensaje_14:     ; WHAT ARE YOU / TRYING TO / SAY?
        db $17,$08,$01,$14,$00,$01,$12,$05,$00,$19,$0f,$55
        db $14,$12,$19,$09,$0e,$07,$00,$14,$4f
        db $13,$01,$19,$af

mensaje_15:     ; WE SURVIVED
        db $17,$05,$00,$13,$15,$12,$16,$09,$16,$05,$84

mensaje_16:     ; SO?
        db $13,$0f,$af

mensaje_17:     ; I LOVE YOU
        db $09,$00,$0c,$0f,$16,$05,$00,$19,$0f,$95

mensaje_18:     ; I ---
        db $09,$00,$34,$34,$b4

mensaje_19:     ; DON'T SPEAK
        db $04,$0f,$0e,$30,$14,$00,$13,$10,$05,$01,$8b

mensaje_20:     ; A GAME BY
        db $01,$00,$07,$01,$0d,$05,$00,$02,$99

