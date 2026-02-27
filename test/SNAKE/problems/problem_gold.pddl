(define (problem snake-3x3-collect-apples)
    (:domain snake)

    (:objects
        ; Definiamo i 9 punti della griglia 3x3
        p1-1 p1-2 p1-3
        p2-1 p2-2 p2-3
        p3-1 p3-2 p3-3
    )

    (:init
        ; --- Adiacenze della Griglia (3x3) ---
        ; Definizione bidirezionale (su, giù, destra, sinistra)
        
        ; Riga 1
        (isAdjacent p1-1 p1-2) (isAdjacent p1-2 p1-1)
        (isAdjacent p1-2 p1-3) (isAdjacent p1-3 p1-2)
        
        ; Riga 2
        (isAdjacent p2-1 p2-2) (isAdjacent p2-2 p2-1)
        (isAdjacent p2-2 p2-3) (isAdjacent p2-3 p2-2)
        
        ; Riga 3
        (isAdjacent p3-1 p3-2) (isAdjacent p3-2 p3-1)
        (isAdjacent p3-2 p3-3) (isAdjacent p3-3 p3-2)
        
        ; Colonne (Verticali)
        (isAdjacent p1-1 p2-1) (isAdjacent p2-1 p1-1)
        (isAdjacent p2-1 p3-1) (isAdjacent p3-1 p2-1)
        
        (isAdjacent p1-2 p2-2) (isAdjacent p2-2 p1-2)
        (isAdjacent p2-2 p3-2) (isAdjacent p3-2 p2-2)
        
        (isAdjacent p1-3 p2-3) (isAdjacent p2-3 p1-3)
        (isAdjacent p2-3 p3-3) (isAdjacent p3-3 p2-3)

        ; --- Stato Iniziale del Serpente ---
        ; Serpente lungo 1 in (1,1)
        (headSnake p1-1)
        (tailSnake p1-1)
        (blocked p1-1) ; Il corpo occupa la posizione (1,1)

        ; --- Stato delle Mele ---
        ; Mela 1 è attualmente sul tabellone in (1,2)
        (isPoint p1-2)

        ; --- Logica di Spawn ---
        ; Mela 2 (in 2,2) è "in attesa" di spawnare (spawn corrente)
        (spawn p2-2)
        
        ; Dopo che Mela 2 è spawnata, il prossimo nella lista è il dummy (fine gioco)
        (nextSpawn p2-2 dummyPoint)
    )

    (:goal
        (and
            ; L'obiettivo è aver mangiato entrambe le mele.
            ; Nel dominio, questo si traduce in:
            ; 1. La coda di spawn ha raggiunto il punto finale (dummyPoint)
            ; 2. Il serpente ha mangiato l'ultima mela, quindi la sua testa si trova lì.
            
            (spawn dummyPoint) ; Tutte le mele previste sono apparse
            (headSnake p2-2)   ; Il serpente ha raggiunto l'ultima mela
            
            ; Opzionalmente potremmo dire che non ci sono più mele sul tabellone, 
            ; ma headSnake p2-2 + spawn dummyPoint garantisce che la sequenza è completa.
        )
    )
)