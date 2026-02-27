(define (problem visit-hallway)
    (:domain robot-visit) ; Assumi che il tuo dominio si chiami 'robot-visit' o simile

    (:objects

        ; Le stanze (Places)
        room1 room2 room3 - place
    )

    (:init
        ; --- Connessioni (Corridoio lineare: 1 <-> 2 <-> 3) ---
        ; Room1 collegata a Room2
        (connected room1 room2)
        (connected room2 room1)

        ; Room2 collegata a Room3
        (connected room2 room3)
        (connected room3 room2)

        ; --- Stato Iniziale del Robot ---
        (at-robot room1)

        ; --- Stato di Visita Iniziale ---
        (visited room1) ; La stanza di partenza è già visitata
        
        ; (not (visited room2)) e (not (visited room3)) sono impliciti (Closed World Assumption)
    )

    (:goal
        (and
            ; L'obiettivo è aver visitato tutte le stanze
            (visited room1)
            (visited room2)
            (visited room3)
        )
    )
)