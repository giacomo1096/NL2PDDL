(define (problem free-blocked-car)
    (:domain parking)

    (:objects
        ; Veicoli
        car_a car_b - car

        ; Cordoli (File)
        curb1 curb2 - curb

        ; Spazi (Slot logici)
        ; sp_c1: Spazio sul cordolo 1 (dove c'è CarA)
        ; sp_behind_a: Spazio dietro CarA (dove c'è CarB)
        ; sp_behind_b: Spazio dietro CarB (vuoto)
        ; sp_c2_slot1, sp_c2_slot2: Spazi sul cordolo 2 (vuoti)
        sp_c1 sp_behind_a sp_behind_b sp_c2_slot1 sp_c2_slot2 - space

        ; Locations (Luoghi fisici associati agli spazi)
        loc_c1 loc_behind_a loc_behind_b loc_c2_slot1 loc_c2_slot2 - location
    )

    (:init
        ; --- Costi ---
        (= (total-cost) 0)

        ; --- Definizione della Struttura (Mappa statica) ---
        
        ; Configurazione Curb1
        (is-curb-location loc_c1 curb1)
        (curb-has-space curb1 sp_c1)
        (space-at-curb sp_c1 curb1)

        ; Configurazione Curb2 (Ha 2 slot per permettere lo spostamento)
        (is-curb-location loc_c2_slot1 curb2)
        (curb-has-space curb2 sp_c2_slot1)
        (space-at-curb sp_c2_slot1 curb2)

        (is-curb-location loc_c2_slot2 curb2)
        (curb-has-space curb2 sp_c2_slot2)
        (space-at-curb sp_c2_slot2 curb2)

        ; Configurazione Spazi dietro le auto
        ; Spazio dietro CarA
        (is-behind-car-location loc_behind_a car_a)
        (space-behind-car sp_behind_a car_a)

        ; Spazio dietro CarB
        (is-behind-car-location loc_behind_b car_b)
        (space-behind-car sp_behind_b car_b)


        ; --- Stato Iniziale (Posizione Auto) ---

        ; CarA è sul Curb1 (Occupando sp_c1)
        (parked car_a)
        (car-at-curb car_a curb1)
        (car-at-space car_a sp_c1)
        (car-at-location car_a loc_c1)
        ; Lo spazio occupato NON è available
        ; (not (space-available sp_c1)) implicito

        ; CarB è dietro CarA (Occupando sp_behind_a)
        (parked car_b)
        (car-at-behind-car car_b car_a)
        (car-at-space car_b sp_behind_a)
        (car-at-location car_b loc_behind_a)
        ; Lo spazio occupato NON è available
        ; (not (space-available sp_behind_a)) implicito


        ; --- Spazi Liberi (Available) ---
        ; Curb2 è vuoto (entrambi gli slot)
        (space-available sp_c2_slot1)
        (space-available sp_c2_slot2)

        ; Dietro CarB è vuoto
        (space-available sp_behind_b)
    )

    (:goal
        (and
            ; L'obiettivo è che CarA sia parcheggiata sul Curb2
            (car-at-curb car_a curb2)
        )
    )

    (:metric minimize (total-cost))
)