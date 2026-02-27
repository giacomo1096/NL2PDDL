lisp
(define (problem mine-world-simple-ore-transfer)
  (:domain mine-world)
  (:objects
    MineBot1 - minebot
    Cell1 Cell2 Cell3 - cell
    Item1 - ore
  )
  (:init
    (at-cell MineBot1 Cell1)
    (is-accessible Cell1)
    (is-accessible Cell2)
    (is-accessible Cell3)
    (is-placed Item1 Cell2)
    (not (carrying MineBot1 Item1))
    (not (is-picked-up Item1))
    (not (is-collected Item1))
    (not (has-rock Cell1))
    (not (has-rock Cell2))
    (not (has-rock Cell3))
    (not (has-lift Cell1))
    (not (has-lift Cell2))
    (not (has-lift Cell3))
  )
  (:goal
    (is-placed Item1 Cell3)
  )
)