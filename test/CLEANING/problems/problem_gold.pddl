(define (problem clean-row-t2)
    (:domain floor-tile)

    (:objects
        robo - robot
        t1 t2 t3 - tile
    )

    (:init
        ; --- Stato iniziale del Robot ---
        (robot-at robo t1)

        ; --- Stato iniziale delle Piastrelle ---
        ; T1 non è (clear) perché il robot è sopra
        (clear t2)
        (clear t3)

        ; (Assumiamo che 'not cleaned' sia lo stato di default)
        ; (not (cleaned t1))
        ; (not (cleaned t2))
        ; (not (cleaned t3))

        ; --- Definizione della Mappa (come da descrizione) ---
        (left t1 t2)
        (right t2 t1)
        (right t3 t2)
        (left t2 t3)
    )

    (:goal
        (and
            (cleaned t2) ; L'obiettivo è pulire T2
        )
    )
)