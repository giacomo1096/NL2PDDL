(define (problem transport-valuable-cargo)
    (:domain mprime-strips)

    (:objects
        ; Luoghi
        rome milan - location

        ; Veicoli e Carico
        truck1 - vehicle
        package1 - cargo

        ; Risorse (In questo dominio sono oggetti fisici)
        fuel_rome - fuel             ; L'unità di carburante presente a Roma
        truck_cargo_space - space    ; Lo spazio di carico all'interno del camion
        milan_parking_spot - space   ; Lo spazio a Milano necessario per far arrivare il camion (requisito dell'azione move)
    )

    (:init
        (= (fuel-level truck1) 0)        
        (= (space-available truck1) 1)    
        (= (cargo-size package1) 1)       

        (= (fuel-amount fuel_rome) 1)
        (= (space-amount truck_cargo_space) 1)
        (= (space-amount milan_parking_spot) 1)

        (vehicle-at truck1 rome)
        (cargo-at package1 rome)
        
        (= (fuel-available rome) 1)
        (location-has-fuel rome fuel_rome)
        (fuel-at-location fuel_rome rome)

        (vehicle-has-space truck1 truck_cargo_space)
        (space-in-vehicle truck_cargo_space truck1)

        (= (space-available milan) 1)
        (location-has-space milan milan_parking_spot)
        (space-at-location milan_parking_spot milan)
        
    )

    (:goal
        (and
            (cargo-at package1 milan)
        )
    )
)