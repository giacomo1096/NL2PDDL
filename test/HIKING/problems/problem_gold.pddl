(define (problem hiking-to-lookout)
    (:domain hiking)

    (:objects
        ; Definiamo le quattro location
        trailhead - loc
        river - loc
        rockface - loc
        lookout - loc
    )

    (:init
        ; --- Posizione iniziale ---
        (at trailhead) ; L'escursionista inizia al Trailhead

        ; --- Tipi di terreno ---
        (isWater river)  ; Il fiume è acqua
        (isHill rockface) ; La parete rocciosa è una collina

        ; --- Connessioni (Adiacenze) ---
        ; (Definite in entrambe le direzioni per le azioni)
        (adjacent trailhead river)
        (adjacent river trailhead)

        (adjacent trailhead rockface)
        (adjacent rockface trailhead)

        (adjacent rockface lookout)
        (adjacent lookout rockface)
    )

    (:goal
        (and
            (at lookout) ; L'obiettivo è raggiungere il Lookout
        )
    )
)