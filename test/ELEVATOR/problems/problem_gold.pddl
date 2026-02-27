(define (problem passenger-to-floor2)
    (:domain miconic)

    (:objects
        ; Piani
        f0 f1 f2 - floor ; Piano 0 (Terra), Piano 1, Piano 2
        
        ; Passeggeri
        passengera - passenger
    )

    (:init
        ; --- Definizione della struttura dell'edificio (Relazioni 'above') ---
        ; f0 è sotto f1
        (above f1 f0)
        
        ; f1 è sotto f2
        (above f2 f1)
        
        ; f0 è sotto f2 (implicito, ma lo definiamo per completezza strutturale)
        (above f2 f0)

        ; --- Stato Iniziale del Passeggero ---
        ; Posizione di partenza: f0
        (origin passengera f0)
        
        ; Destinazione: f2
        (destin passengera f2)
        
        ; (not (boarded passengera)) e (not (served passengera)) sono impliciti.

        ; --- Stato Iniziale dell'Ascensore ---
        (lift-at f0) ; L'ascensore è al Piano 0
    )

    (:goal
        (and
            (served passengera) ; L'obiettivo è che il passeggeroA sia servito (abbia raggiunto la sua destinazione finale)
        )
    )
)