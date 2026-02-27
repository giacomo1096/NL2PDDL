(define (problem mineworld_problem)
  (:domain mine-world)

  (:objects
    MineBot1 - minebot
    Cell1 Cell2 Cell3 - cell
    Item1 - ore
  )
  (:init
    (ObjectIn MineBot1 Cell1)
    (ObjectIn Item1 Cell2)
    (Adjacent Cell1 Cell2)
    (Adjacent Cell2 Cell1)
    (Adjacent Cell2 Cell3)
    (Adjacent Cell3 Cell2)
  )

  (:goal
    (ObjectIn Item1 Cell3)
  )
)