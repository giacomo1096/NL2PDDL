(define (problem minebot-problem-1)
    (:domain minebot-world)
    (:objects
        minebot1 - minebot
        cell1 cell2 cell3 - cell
        item1 - ore
    )
    (:init
        ; MineBot initial state
        (at minebot1 cell1)
        (empty-hand minebot1)

        ; Item initial state
        (at item1 cell2)
        (is-on-ground item1)

        ; Map connectivity
        (connected cell1 cell2)
        (connected cell2 cell1)
        (connected cell2 cell3)
        (connected cell3 cell2)
    )
    (:goal
        (and
            (at item1 cell3)
        )
    )
)