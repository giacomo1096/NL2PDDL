(define (problem mine-world-problem-1)
  (:domain mine-world)

  (:objects
    MineBot1 - minebot
    Cell1 - cell
    Cell2 - cell
    Cell3 - cell
    Item1 - ore
  )

  (:init
    ;; Cell connections (bidirectional)
    (connected Cell1 Cell2)
    (connected Cell2 Cell1)
    (connected Cell2 Cell3)
    (connected Cell3 Cell2)

    ;; Initial positions and states
    (at MineBot1 Cell1)
    (has-ore Cell2 Item1)
    (can-mine MineBot1)
    (= (battery-level MineBot1) 10)  ; Assuming initial battery level

    ;; Default states
    (not (holding MineBot1 Item1))
    (not (is-mined Item1))
    (not (is-placed Item1))
  )

  (:goal (and
    (at MineBot1 Cell3)
    (holding MineBot1 Item1)
    (is-mined Item1)
  ))
)