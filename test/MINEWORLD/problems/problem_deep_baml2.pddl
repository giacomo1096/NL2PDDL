(define (problem ore-transport)
  (:domain mine-world)

  (:objects
    MineBot1 - minebot
    Cell1 Cell2 Cell3 - cell
    Item1 - ore
    mine - mine
  )

  (:init
    (minebot-at MineBot1 Cell1)
    (item-at Item1 Cell2)
    (cell-in-mine Cell1 mine)
    (cell-in-mine Cell2 mine)
    (cell-in-mine Cell3 mine)
  )

  (:goal
    (and
      (item-at Item1 Cell3)
    )
  )
)