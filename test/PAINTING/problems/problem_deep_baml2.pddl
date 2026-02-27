(define (problem paint-two-tiles)
  (:domain painting)

  (:objects
    PainterBot - robot
    Tile1 Tile2 - tile
    Black White - color
    d1 - direction
  )

  (:init
    (robot-at PainterBot Tile1)
    (robot-has-color PainterBot Black)
    (tile-has-color Tile1 White)
    (tile-has-color Tile2 Black)
  )

  (:goal
    (and
      (tile-has-color Tile1 Black)
      (tile-has-color Tile2 White)
    )
  )
)