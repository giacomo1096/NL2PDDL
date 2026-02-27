(define (problem walle-push-box)
    (:domain typed-sokoban)

    (:objects
        ; Le tre piastrelle del corridoio
        tile1 tile2 tile3 - LOC
        
        ; La direzione richiesta
        right - DIR
        
        ; La scatola
        box1 - BOX
    )

    (:init
        ; --- Topologia (Corridoio Lineare) ---
        ; Tile1 è adiacente a Tile2 verso destra
        (adjacent tile1 tile2 right)
        
        ; Tile2 è adiacente a Tile3 verso destra
        (adjacent tile2 tile3 right)

        ; --- Posizioni Iniziali ---
        (at-robot tile1)   ; Wall-E inizia sulla Tile1 (Sinistra)
        (at box1 tile2)    ; Box1 è sulla Tile2 (Centro)

        ; --- Stato delle Celle ---
        ; Tile3 è libera (clear). 
        ; Tile1 e Tile2 non sono 'clear' perché occupate rispettivamente da robot e scatola.
        (clear tile3)
    )

    (:goal
        (and
            ; L'obiettivo è che la scatola sia sulla Tile3 (Destra)
            (at box1 tile3)
        )
    )
)