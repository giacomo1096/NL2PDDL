(define (problem curiosity-collect-soil)
    (:domain mars-rover-exploration)

    (:objects
        ; Rover
        curiosity - rover

        ; Luoghi
        landingsite crater - waypoint
        base_station - lander

        ; Campioni
        soil_sample1 - soil-sample

        ; Strumenti (Necessari per l'azione analyze-sample)
        analyzer_tool - tool
    )

    (:init
        ; --- Configurazione Rover ---
        (rover-at curiosity landingsite)
        (equipped-with curiosity analyzer_tool)
        
        ; Capacità di stoccaggio (Fluents)
        (= (storage-used curiosity) 0) ; Attualmente vuoto
        (= (max-storage curiosity) 5)  ; Capacità sufficiente

        ; --- Configurazione Strumenti ---
        (supports-analysis analyzer_tool)

        ; --- Mappa e Connettività ---
        ; Il rover può viaggiare dal sito di atterraggio al cratere
        (can-travel landingsite crater)
        (can-travel crater landingsite)

        ; Visibilità per la comunicazione
        ; Il Lander è visibile dal Cratere (come da scenario)
        (can-communicate crater base_station)
        
        ; (Assumiamo sia visibile anche dal sito di atterraggio, anche se non strettamente necessario per il piano ottimale)
        (can-communicate landingsite base_station)

        ; --- Obiettivi Scientifici ---
        ; Il campione di suolo si trova nel cratere
        (sample-at soil_sample1 crater)

        ; Stati iniziali impliciti:
        ; (not (analyzed soil_sample1))
        ; (not (communicated soil_sample1))
        ; (not (visited crater))
    )

    (:goal
        (and
            ; L'obiettivo è comunicare i dati del campione
            (communicated soil_sample1)
        )
    )
)