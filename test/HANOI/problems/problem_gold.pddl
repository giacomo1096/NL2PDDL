(define (problem hanoi-3-disks)
    (:domain hanoi)

    (:objects
        ; Dischi
        d1 d2 d3 
        
        ; Pioli
        peg1 peg2 peg3
    )

    (:init
        ; --- Relazioni di Grandezza (Dischi) ---
        (smaller d1 d2) ; D1 è più piccolo di D2
        (smaller d1 d3) ; D1 è più piccolo di D3
        (smaller d2 d3) ; D2 è più piccolo di D3

        ; --- Relazioni di Grandezza (Dischi vs Pioli) ---
        ; Affinché un disco possa essere spostato su un piolo vuoto, 
        ; il disco deve essere considerato "più piccolo" del piolo.
        (smaller d1 peg1) (smaller d1 peg2) (smaller d1 peg3)
        (smaller d2 peg1) (smaller d2 peg2) (smaller d2 peg3)
        (smaller d3 peg1) (smaller d3 peg2) (smaller d3 peg3)

        ; --- Configurazione Iniziale (Tutti su Peg1) ---
        ; La pila è ordinata: D1 su D2, D2 su D3, D3 su Peg1
        (on d1 d2)
        (on d2 d3)
        (on d3 peg1)

        ; --- Stato "Clear" (Cosa è libero sopra?) ---
        (clear d1)   ; D1 è in cima alla pila, quindi è libero
        (clear peg2) ; Il piolo 2 è vuoto
        (clear peg3) ; Il piolo 3 è vuoto
        
        ; Nota: peg1 NON è clear perché ha sopra d3.
    )

    (:goal
        (and
            ; L'obiettivo è ricostruire la pila su Peg3
            (on d1 d2)
            (on d2 d3)
            (on d3 peg3)
        )
    )
)