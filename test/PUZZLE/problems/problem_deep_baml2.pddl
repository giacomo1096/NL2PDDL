(define (problem tile-ordering)
  (:domain n-puzzle)

  (:objects
    Tile1 Tile2 Tile3 - tile
    Pos1 Pos2 Pos3 Pos4 - position
  )

  (:init
    (at Tile2 Pos1)
    (at Tile3 Pos2)
    (at Tile1 Pos3)
    (blank Pos4)
    (adjacent-up Pos1 Pos2)
    (adjacent-down Pos2 Pos1)
    (adjacent-right Pos1 Pos3)
    (adjacent-left Pos3 Pos1)
    (adjacent-right Pos2 Pos4)
    (adjacent-left Pos4 Pos2)
    (adjacent-up Pos3 Pos4)
    (adjacent-down Pos4 Pos3)
  )

  (:goal
    (and
      (at Tile1 Pos1)
      (at Tile2 Pos2)
      (at Tile3 Pos3)
    )
  )
)