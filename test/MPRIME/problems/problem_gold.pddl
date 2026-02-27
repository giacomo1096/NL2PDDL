(define (problem transport-pacco-roma-milano)
    (:domain mprime-strips)

    (:objects
        ; Luoghi
        roma milano - location

        ; Veicoli e Carico
        truck1 - vehicle
        pacco1 - cargo

        ; Livelli di Carburante (0 e 1)
        f0 f1 - fuel

        ; Livelli di Spazio (0 e 1)
        s0 s1 - space
    )

    (:init
        ; --- Topologia ---
        (conn roma milano)
        (not-equal roma milano) ; Necessario per l'azione 'donate' se fosse usata

        ; --- Logica delle Risorse (Matematica discreta) ---
        ; Definiamo che f0 è il "vicino inferiore" di f1 (necessario per consumare carburante)
        (fuel-neighbor f0 f1)
        
        ; Definiamo che s0 è il "vicino inferiore" di s1 (necessario per occupare/liberare spazio)
        (space-neighbor s0 s1)

        ; --- Posizioni Iniziali ---
        (at truck1 roma)
        (at pacco1 roma)

        ; --- Stato delle Risorse ---
        ; Roma ha 1 unità di carburante (f1)
        (has-fuel roma f1)
        
        ; Milano ha 0 unità di carburante (f0)
        (has-fuel milano f0)

        ; Il Truck ha 1 unità di spazio libero (s1)
        (has-space truck1 s1)
    )

    (:goal
        (and
            ; L'obiettivo è trasportare il pacco a Milano
            (at pacco1 milano)
        )
    )
)