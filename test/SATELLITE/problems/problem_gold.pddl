(define (problem satellite-photo-mission)
    (:domain satellite)

    (:objects
        ; Satellite
        sat1 - satellite

        ; Strumento
        cam1 - instrument

        ; Modalità di immagine
        spectrograph - mode

        ; Direzioni (Obiettivi)
        stara planetx - direction
    )

    (:init
        ; --- Configurazione Hardware ---
        (on_board cam1 sat1)          ; La camera è a bordo del satellite
        (supports cam1 spectrograph)  ; La camera supporta la modalità spettrografo
        (calibration_target cam1 stara) ; La camera si calibra puntando StarA

        ; --- Stato Iniziale ---
        (pointing sat1 stara)         ; Il satellite punta già verso la stella di calibrazione
        
        ; Energia
        ; Poiché la camera è OFF, il satellite ha energia disponibile per accenderla.
        (power_avail sat1)            

        ; Nota: (power_on cam1) e (calibrated cam1) sono falsi (implicito per Closed World Assumption)
    )

    (:goal
        (and
            ; L'obiettivo è avere l'immagine del Pianeta X in modalità Spettrografo
            (have_image planetx spectrograph)
        )
    )
)