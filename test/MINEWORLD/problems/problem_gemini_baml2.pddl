(define (problem transport-ore-to-depot)
  (:domain mine-world)

  (:objects
    Cell1 Cell2 Cell3 - cell
    MineBot1 - minebot
    Item1 - ore
  )

  (:init
    (minebot-at MineBot1 Cell1)
    (hand-empty MineBot1)
    (item-at Item1 Cell2)
    (connected Cell1 Cell2)
    (connected Cell2 Cell1)
    (connected Cell2 Cell3)
    (connected Cell3 Cell2)
  )

  (:goal
    (and
      (item-at Item1 Cell3)
    )
  )
)