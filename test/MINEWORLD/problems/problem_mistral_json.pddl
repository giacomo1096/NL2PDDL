(define (problem mining-problem-1)
  (:domain mining)

  (:objects
    MineBot1 - minebot
    Cell1 Cell2 Cell3 - cell
    Item1 - ore
  )

  (:init
    ;; Minebot initial state
    (at MineBot1 Cell1)
    (can-mine MineBot1)
    (= (battery-level MineBot1) 100)

    ;; Cell connections (bidirectional)
    (connected Cell1 Cell2)
    (connected Cell2 Cell1)
    (connected Cell2 Cell3)
    (connected Cell3 Cell2)

    ;; Distance values (arbitrary but consistent)
    (= (distance Cell1 Cell2) 10)
    (= (distance Cell2 Cell1) 10)
    (= (distance Cell2 Cell3) 10)
    (= (distance Cell3 Cell2) 10)

    ;; Ore placement
    (has-ore Cell2 Item1)
    (= (ore-value Item1) 50)

    ;; Initial item state
    (not (holding MineBot1 Item1))
    (not (extracted Item1))
    (not (is-placed Item1))
  )

  (:goal (and
    (at MineBot1 Cell3)
    (holding MineBot1 Item1)
    (extracted Item1)
  ))
)