(define (problem tile-ordering)
  (:domain n-puzzle)

  (:objects
    Tile1 Tile2 Tile3 - tile
    Blank - blank
    Pos1 Pos2 Pos3 Pos4 - position
    Board1 - board
  )

  (:init
    (tile-at-position Tile2 Pos1)
    (tile-at-position Tile3 Pos2)
    (tile-at-position Tile1 Pos3)
    (blank-at-position Blank Pos4)
    (has-position Board1 Pos1)
    (has-position Board1 Pos2)
    (has-position Board1 Pos3)
    (has-position Board1 Pos4)
    (adjacent-horizontal Pos1 Pos2)
    (adjacent-horizontal Pos2 Pos1)
    (adjacent-vertical Pos1 Pos3)
    (adjacent-vertical Pos3 Pos1)
    (adjacent-vertical Pos2 Pos4)
    (adjacent-vertical Pos4 Pos2)
    (adjacent-horizontal Pos3 Pos4)
    (adjacent-horizontal Pos4 Pos3)
  )

  (:goal
    (and
      (tile-at-position Tile1 Pos1)
      (tile-at-position Tile2 Pos2)
      (tile-at-position Tile3 Pos3)
      (blank-at-position Blank Pos4)
    )
  )
)