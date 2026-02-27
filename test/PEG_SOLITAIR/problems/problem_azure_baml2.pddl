(define (problem three-hole-peg-solitaire)
  (:domain peg-solitaire)

  (:objects
    Pos1 Pos2 Pos3 - location
    peg1 peg2 - peg
    board1 - board
    move1 move2 move3 move4 - move
  )

  (:init
    (location-on-board Pos1 board1)
    (location-on-board Pos2 board1)
    (location-on-board Pos3 board1)
    (has-location board1 Pos1)
    (has-location board1 Pos2)
    (has-location board1 Pos3)
    (peg-at-location peg1 Pos1)
    (peg-at-location peg2 Pos2)
    (peg-on-board peg1 board1)
    (peg-on-board peg2 board1)
    (not (peg-eliminated peg1))
    (not (peg-eliminated peg2))
    (not (location-empty Pos1))
    (not (location-empty Pos2))
    (location-empty Pos3)
    ;; All moves are initially not started
    (not (move-initiated move1))
    (not (move-initiated move2))
    (not (move-initiated move3))
    (not (move-initiated move4))
    (not (move-continued move1))
    (not (move-continued move2))
    (not (move-continued move3))
    (not (move-continued move4))
    (not (move-ended move1))
    (not (move-ended move2))
    (not (move-ended move3))
    (not (move-ended move4))
  )

  (:goal
    (or
      (and
        (peg-eliminated peg1)
        (not (peg-eliminated peg2))
        (or (peg-at-location peg2 Pos1)
            (peg-at-location peg2 Pos2)
            (peg-at-location peg2 Pos3))
      )
      (and
        (peg-eliminated peg2)
        (not (peg-eliminated peg1))
        (or (peg-at-location peg1 Pos1)
            (peg-at-location peg1 Pos2)
            (peg-at-location peg1 Pos3))
      )
    )
  )
)