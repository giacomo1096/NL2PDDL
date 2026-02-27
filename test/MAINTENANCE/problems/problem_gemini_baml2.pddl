(define (problem assign-and-maintain)
    (:domain airplane-maintenance)

    (:objects
        ; Oggetti principali
        plane1 - airplane
        mike - mechanic
        lhr cdg - airport
        
        ; Giorni (Necessari per la logica next-day del dominio)
        sunday monday - day
    )

    (:init
        ; --- Linea Temporale ---
        (next-day sunday monday)

        ; --- Schedulazione Aereo ---
        ; L'aereo è programmato per essere a Londra (LHR) di Lunedì
        (airplane-scheduled-at plane1 lhr monday)

        ; --- Stato Iniziale Meccanico ---
        ; Mike è disponibile il giorno prima (Domenica) a Parigi (CDG).
        ; Questo rispetta il vincolo che "non è ancora assegnato per Lunedì".
        ; Il planner dovrà spostarlo.
        (assigned-to mike cdg sunday)

        ; (not (serviced plane1)) è implicito.
    )

    (:goal
        (and
            ; L'obiettivo è che l'aereo sia stato revisionato
            (serviced plane1)
        )
    )
)