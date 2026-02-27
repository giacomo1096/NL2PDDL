(define (problem grid-unlock-door)
    (:domain grid)

    (:objects
        rooma roomb - object ; Trattati come 'object' generici
        keyq - object
        square - object
    )

    (:init
        ; --- Definizione dei "tipi" (come da predicati) ---
        (place rooma)
        (place roomb)
        (key keyq)
        (shape square)

        ; --- Stato delle posizioni ---
        (at-robot rooma) ; Il robot è in RoomA
        (open rooma)     ; RoomA è aperta (necessario per rientrare)
        (locked roomb)   ; RoomB è bloccata (da "Door1")

        ; --- Stato della chiave e del robot ---
        (at keyq rooma)  ; La chiave è in RoomA
        (arm-empty)      ; Il braccio del robot è vuoto

        ; --- Informazioni su chiave e serratura ---
        (key-shape keyq square)      ; La chiave KeyQ è quadrata
        (lock-shape roomb square)    ; La serratura di RoomB richiede una chiave quadrata

        ; --- Connessioni ---
        (conn rooma roomb)
        (conn roomb rooma)
    )

    (:goal
        (and
            (at-robot roomb) ; L'obiettivo è che il robot sia in RoomB
        )
    )
)