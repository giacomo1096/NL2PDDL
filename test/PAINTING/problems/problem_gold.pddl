(define (problem paint-vertical-solvable)
    (:domain floor-tile)

    (:objects
        painterbot - robot
        tile1 tile2 safe-tile - tile ; Aggiunta la safe-tile
        black white - color
    )

    (:init
        ; --- Mappa Verticale a 3 celle ---
        ; [Safe-Tile] -> (Sopra)
        ; [Tile1]     -> (Centro)
        ; [Tile2]     -> (Sotto)

        ; Safe-Tile è sopra Tile1
        (up safe-tile tile1)
        (down tile1 safe-tile)

        ; Tile1 è sopra Tile2
        (up tile1 tile2)
        (down tile2 tile1)

        ; --- Stato Iniziale ---
        ; Il robot inizia sulla safe-tile (o su tile1, basta che possa risalire)
        (robot-at painterbot safe-tile) 
        
        (robot-has painterbot black)

        ; --- Disponibilità Colori ---
        (available-color black)
        (available-color white)

        ; --- Stato delle Tessere ---
        ; Tutte le tessere tranne quella del robot sono 'clear'
        (clear tile1)
        (clear tile2)
        ; (safe-tile non è clear perché c'è il robot)

        (= (total-cost) 0)
    )

    (:goal
        (and
            (painted tile1 black)
            (painted tile2 white)
        )
    )

    (:metric minimize (total-cost))
)