(define (problem paul_to_hospital)
    (:domain taxi_simplest2)

    (:objects
        ; Luoghi
        station hospital - location

        ; Taxi
        taxi1 - taxi

        ; Persone
        paul - person
    )

    (:init
        ; --- Posizioni iniziali ---
        (tlocation taxi1 station)  ; Il taxi è alla stazione
        (plocation paul station)   ; Paul è alla stazione

        ; --- Stato iniziale del taxi ---
        (empty taxi1)              ; Il taxi è vuoto

        ; --- Connessioni (mappa) ---
        ; (Devono essere bidirezionali per permettere andata e ritorno)
        (connects station hospital)
        (connects hospital station)
    )

    (:goal
        (and
            (plocation paul hospital) ; L'obiettivo è che Paul sia all'ospedale
        )
    )
)