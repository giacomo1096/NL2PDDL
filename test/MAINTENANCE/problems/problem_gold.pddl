(define (problem schedule-maintenance-monday)
    (:domain maintenance-scheduling-domain)

    (:objects
        ; Aereo
        plane1 - plane

        ; Giorni
        monday - day

        ; Aeroporti
        lhr cdg - airport
    )

    (:init
        ; --- Tempo Corrente ---
        (today monday)

        ; --- Schedulazione Voli ---
        ; Plane1 si trova a Londra (LHR) di Lunedì
        (at plane1 monday lhr)

        ; --- Stato Iniziale ---
        ; (not (done plane1)) è implicito
    )

    (:goal
        (and
            ; L'obiettivo è che la manutenzione sia fatta
            (done plane1)
        )
    )
)