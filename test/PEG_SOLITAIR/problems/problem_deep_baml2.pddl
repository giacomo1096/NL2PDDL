(define (problem three-peg-row)
  (:domain peg-solitaire)

  (:objects
    board - board
    Pos1 Pos2 Pos3 - location
    peg1 peg2 - peg
    m1 - move
  )

  (:init
    ;; Board layout
    (on-board Pos1 board)
    (on-board Pos2 board)
    (on-board Pos3 board)
    
    ;; Initial peg positions
    (peg-at peg1 Pos1)
    (peg-at peg2 Pos2)
    
    ;; Empty locations
    (empty Pos3)
    
    ;; Adjacency relationships
    (adjacent Pos1 Pos2)
    (adjacent Pos2 Pos1)
    (adjacent Pos2 Pos3)
    (adjacent Pos3 Pos2)
  )

  (:goal
    (and
      ;; Only one peg remains at Pos3
      (peg-at peg1 Pos3)
      ;; Other positions are empty
      (empty Pos1)
      (empty Pos2)
    )
  )
)