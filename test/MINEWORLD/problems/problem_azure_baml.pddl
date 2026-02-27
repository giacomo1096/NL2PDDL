lisp
(define (problem mining-simple-ore-delivery)
  (:domain mining)
  (:objects
    MineBot1 - minebot
    Cell1 Cell2 Cell3 - cell
    Item1 - ore
    Mine1 - mine
  )
  (:init
    ;; All cells are in the same mine
    (in-mine Cell1 Mine1)
    (in-mine Cell2 Mine1)
    (in-mine Cell3 Mine1)

    ;; Initial location of MineBot1
    (at-cell MineBot1 Cell1)

    ;; MineBot1 is not holding any item
    (not (holding-item MineBot1))

    ;; Ore is at Cell2
    (at-cell-ore Item1 Cell2)

    ;; No rocks, lifts, or other items present
  )
  (:goal
    (at-cell-ore Item1 Cell3)
  )
)