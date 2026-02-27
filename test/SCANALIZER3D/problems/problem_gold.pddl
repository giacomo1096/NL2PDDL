(define (problem scanalyzer-circular-4seg)
    (:domain scanalyzer3d)

    (:objects
        ; I 4 segmenti della piattaforma
        seg1 seg2 seg3 seg4 - segment

        ; Le auto reali
        car-a car-b - car

        ; Auto "fittizie" per rappresentare i segmenti vuoti
        ; (Necessarie perché l'azione rotate-4 richiede un'auto su ogni segmento)
        empty1 empty2 - car
    )

    (:init
        ; --- Metrica ---
        (= (total-cost) 0)

        ; --- Topologia e Scansionatori ---
        ; Definiamo il ciclo di rotazione a 4 segmenti (S1->S2->S3->S4->S1)
        ; Definiamo tutte le permutazioni valide del ciclo per permettere la rotazione continua
        (CYCLE-4 seg1 seg2 seg3 seg4)
        (CYCLE-4 seg2 seg3 seg4 seg1)
        (CYCLE-4 seg3 seg4 seg1 seg2)
        (CYCLE-4 seg4 seg1 seg2 seg3)

        ; Definiamo dove sono gli scanner.
        ; L'azione 'analyze-4' analizza l'auto che si trova nel PRIMO segmento passato al predicato.
        ; Lo scenario dice che gli scanner sono su Seg1 e Seg3.
        
        ; Scanner su Seg1 (Analizza l'auto su seg1 mentre ruota)
        (CYCLE-4-WITH-ANALYSIS seg1 seg2 seg3 seg4)
        
        ; Scanner su Seg3 (Analizza l'auto su seg3 mentre ruota)
        (CYCLE-4-WITH-ANALYSIS seg3 seg4 seg1 seg2)

        ; --- Stato Iniziale ---
        ; Car-A su Seg1
        (on car-a seg1)
        
        ; Car-B su Seg2
        (on car-b seg2)
        
        ; Seg3 e Seg4 sono vuoti (usiamo le auto fittizie)
        (on empty1 seg3)
        (on empty2 seg4)

        ; Nessuna auto è analizzata all'inizio (implicito)
    )

    (:goal
        (and
            ; L'obiettivo è che entrambe le auto reali siano analizzate
            (analyzed car-a)
            (analyzed car-b)
        )
    )

    (:metric minimize (total-cost))
)