(define (problem parking-numeric-2cars)
    (:domain parking)

    (:objects
        curb1 curb2 - curb
        cara carb - car
    )

    (:init
        ; --- Stato Iniziale Posizioni ---
        
        ; Curb1: [CarA] <- [CarB]
        (parked-at-curb cara curb1)
        (parked-behind carb cara)

        ; Curb2: Vuoto
        ; (Nessun predicato qui)

        ; --- Stato Iniziale Numerico (Fluents) ---

        ; Spazio disponibile sui cordoli
        ; Curb1 è "pieno" (supponiamo capacity 1 per la testa della fila, occupata da CarA)
        (= (curb-available-spaces curb1) 0)

        ; Curb2 è vuoto. Deve avere spazio per almeno 2 auto per permettere 
        ; lo spostamento di CarB e poi di CarA senza deadlock.
        (= (curb-available-spaces curb2) 2)

        ; Spazio disponibile dietro le auto
        ; CarA ha CarB dietro, quindi ha 0 spazi disponibili dietro
        (= (car-available-rear-spaces cara) 0)

        ; CarB è l'ultima della fila, quindi ha spazio libero dietro (supponiamo 1 slot)
        (= (car-available-rear-spaces carb) 1)
    )

    (:goal
        (and
            ; L'obiettivo è che CarA sia parcheggiata sul Curb2
            (parked-at-curb cara curb2)
        )
    )
)