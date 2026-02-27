lisp
(define (problem minebot-move-ore)
  (:domain minebot-domain)

  (:objects
    MineBot1 - minebot
    Cell1 Cell2 Cell3 - cell
    Item1 - ore
  )

  (:init
    ;; MineBot1 is at the Entrance (Cell1)
    (at-cell MineBot1 Cell1)

    ;; MineBot1 is not carrying anything (no (carrying ...) facts)

    ;; Item1 (Ore) is not picked up
    ;; (not (is-picked-up Item1)) -- by default, unless stated otherwise

    ;; Item1 (Ore) is placed in Tunnel (Cell2)
    (is-placed Item1 Cell2)

    ;; Item1 (Ore) has already been mined and is available
    (is-mined Item1)

    ;; Item1 (Ore) has not been collected yet
    ;; (not (is-collected Item1)) -- by default

    ;; Cell1, Cell2, Cell3 accessibility
    (is-accessible Cell1)
    (is-accessible Cell2)
    (is-accessible Cell3)

    ;; Cell1, Cell2, Cell3 have no ore except Cell2
    ;; (has-ore Cell2) -- not needed, since ore is represented as an object

    ;; Cell1, Cell2, Cell3 have no rocks
    ;; (not (has-rock Cell1))
    ;; (not (has-rock Cell2))
    ;; (not (has-rock Cell3))

    ;; Cell1, Cell2, Cell3 have no lifts
    ;; (not (has-lift Cell1))
    ;; (not (has-lift Cell2))
    ;; (not (has-lift Cell3))
  )

  (:goal
    (and
      (is-placed Item1 Cell3)
    )
  )
)