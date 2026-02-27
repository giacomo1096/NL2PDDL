(define (problem minebot-problem-1)
    (:domain minebot-world)

    (:objects
        MineBot1 - minebot
        Cell1 Cell2 Cell3 - cell
        Item1 - item
    )

    (:init
        ; Robot initial state
        (at MineBot1 Cell1)
        (empty-hand MineBot1)

        ; Item initial state
        (at Item1 Cell2)
        (is-on-ground Item1)

        ; Map connections
        (connected Cell1 Cell2)
        (connected Cell2 Cell1)
        (connected Cell2 Cell3)
        (connected Cell3 Cell2)
    )

    (:goal (and
        (at Item1 Cell3)
    ))
)