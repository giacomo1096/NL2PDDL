(define (problem transport-c1-to-warehouse)
    (:domain dock-worker-robot-simple)

    (:objects
        ; Luoghi
        piera pierb warehouse - location

        ; Robot
        roby - robot

        ; Container
        c1 - container
    )

    (:init
        ; --- Connessioni (Bidirezionali) ---
        (adjacent piera warehouse)
        (adjacent warehouse piera)
        (adjacent warehouse pierb)
        (adjacent pierb warehouse)

        ; --- Stato iniziale del robot ---
        (atl roby piera)      ; Roby è al PierA
        (unloaded roby)     ; Roby è scarico

        ; --- Stato iniziale del container ---
        (in c1 piera)         ; C1 è al PierA
    )

    (:goal
        (and
            (in c1 warehouse) ; L'obiettivo è che C1 sia nel magazzino
        )
    )
)