(define (problem parking-solvable)
    (:domain parking)

    (:objects
        ; Aggiungiamo curb3 come spazio di manovra
        curb1 curb2 curb3 - curb
        cara carb - car
    )

    (:init
        (= (total-cost) 0)

        ; --- Curb1 (Pieno) ---
        (at-curb-num cara curb1)
        (at-curb cara)
        (behind-car carb cara)

        ; --- Curb2 (Vuoto) ---
        (curb-clear curb2)

        ; --- Curb3 (Vuoto - Buffer necessario) ---
        (curb-clear curb3)

        ; --- Auto ---
        (car-clear carb)
    )

    (:goal
        (and
            ; Ora è possibile: CarB va su Curb3, CarA va su Curb2
            (at-curb-num cara curb2)
        )
    )

    (:metric minimize (total-cost))
)