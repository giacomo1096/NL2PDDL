(define (problem tiny-peg-solitaire-3holes)
    (:domain pegsolitaire-sequential)

    (:objects
        ; Le tre posizioni
        pos1 pos2 pos3 - location
    )

    (:init
        ; --- Geometria della scacchiera ---
        ; Definiamo le linee di salto valide (triplette: Da -> Sopra -> A)
        ; Salto verso destra
        (IN-LINE pos1 pos2 pos3)
        
        ; Salto verso sinistra (necessario per definire la bidirezionalità, 
        ; anche se in questo specifico puzzle non verrà usato)
        (IN-LINE pos3 pos2 pos1)

        ; --- Stato Iniziale dei Pioli ---
        (occupied pos1) ; Piolo in Pos1
        (occupied pos2) ; Piolo in Pos2
        (free pos3)     ; Pos3 è vuota

        ; --- Stato del Gioco ---
        ; Dobbiamo dire che siamo in uno stato "neutro" per poter iniziare una nuova mossa
        (move-ended)

        ; --- Costi ---
        (= (total-cost) 0)
    )

    (:goal
        (and
            ; L'obiettivo è avere un solo piolo sulla scacchiera.
            ; In questo scenario 1-2-3 con buco in 3, l'unica mossa possibile 
            ; (1 salta 2 e va in 3) lascia il piolo finale in pos3.
            
            (occupied pos3)
            (free pos1)
            (free pos2)

            ; È buona norma specificare che il turno deve essere concluso formalmente
            (move-ended)
        )
    )

    (:metric minimize (total-cost))
)