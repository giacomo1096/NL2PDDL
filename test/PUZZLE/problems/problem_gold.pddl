(define (problem puzzle-2x2-sort)
    (:domain n-puzzle)

    (:objects
        ; Le tessere (Tiles)
        tile1 tile2 tile3

        ; Le posizioni (Positions)
        pos1 pos2 pos3 pos4
    )

    (:init
        ; --- Definizione dei "Tipi" (tramite predicati unari) ---
        (tile tile1) (tile tile2) (tile tile3)
        (position pos1) (position pos2) (position pos3) (position pos4)

        ; --- Mappa della Griglia (Connessioni) ---
        ; Griglia:
        ; Pos1 | Pos2
        ; Pos3 | Pos4

        ; Movimenti Verticali
        ; Se sposto una tessera in ALTO (Up): da Pos3 a Pos1, da Pos4 a Pos2
        (valid-up pos3 pos1)
        (valid-up pos4 pos2)

        ; Se sposto una tessera in BASSO (Down): da Pos1 a Pos3, da Pos2 a Pos4
        (valid-down pos1 pos3)
        (valid-down pos2 pos4)

        ; Movimenti Orizzontali
        ; Se sposto una tessera a SINISTRA (Left): da Pos2 a Pos1, da Pos4 a Pos3
        (valid-left pos2 pos1)
        (valid-left pos4 pos3)

        ; Se sposto una tessera a DESTRA (Right): da Pos1 a Pos2, da Pos3 a Pos4
        (valid-right pos1 pos2)
        (valid-right pos3 pos4)

        ; --- Stato Iniziale ---
        ; Pos1: Tile 2
        ; Pos2: Tile 3
        ; Pos3: Tile 1
        ; Pos4: Empty
        
        (at tile2 pos1)
        (at tile3 pos2)
        (at tile1 pos3)
        (blank pos4)
    )

    (:goal
        (and
            ; --- Configurazione Finale (Ordinata) ---
            ; Pos1: Tile 1
            ; Pos2: Tile 2
            ; Pos3: Tile 3
            ; Pos4: Empty

            (at tile1 pos1)
            (at tile2 pos2)
            (at tile3 pos3)
            (blank pos4)
        )
    )
)