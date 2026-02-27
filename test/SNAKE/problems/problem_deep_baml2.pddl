(define (problem snake-3x3-spawn)
    (:domain snake-game)

    (:objects
        ; Grid Locations (Row_Col)
        l11 l12 l13
        l21 l22 l23
        l31 l32 l33 - location

        ; Apples
        apple1 apple2 - point
        
        ; Dummy point needed to satisfy the 'collect' action signature for the last apple
        dummy_end - point
    )

    (:init
        ; --- Grid Topology (Adjacency) ---
        ; Row 1
        (adjacent l11 l12) (adjacent l12 l11)
        (adjacent l12 l13) (adjacent l13 l12)
        ; Row 2
        (adjacent l21 l22) (adjacent l22 l21)
        (adjacent l22 l23) (adjacent l23 l22)
        ; Row 3
        (adjacent l31 l32) (adjacent l32 l31)
        (adjacent l32 l33) (adjacent l33 l32)
        ; Columns
        (adjacent l11 l21) (adjacent l21 l11)
        (adjacent l21 l31) (adjacent l31 l21)
        (adjacent l12 l22) (adjacent l22 l12)
        (adjacent l22 l32) (adjacent l32 l22)
        (adjacent l13 l23) (adjacent l23 l13)
        (adjacent l23 l33) (adjacent l33 l23)

        ; --- Snake Initial State ---
        ; Head and Tail at (1,1)
        (is-snake-head l11)
        (snake-occupies l11)

        ; --- Apples State ---
        ; Apple 1 is currently on board at (1,2)
        (point-at apple1 l12)

        ; Apple 2 is waiting. 
        ; In this domain logic, waiting items must be marked 'collected' 
        ; so the 'collect' action can un-collect them (spawn them).
        (collected apple2)

        ; Dummy end point (also waiting)
        (collected dummy_end)
    )

    (:goal
        (and
            ; Goal: Both real apples have been collected
            (collected apple1)
            (collected apple2)
        )
    )
)