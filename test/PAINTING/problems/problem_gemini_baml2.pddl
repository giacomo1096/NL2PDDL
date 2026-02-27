(define (problem paint-two-tiles-pattern)
  (:domain tile-painting)

  (:objects
    PainterBot - robot
    Tile1 Tile2 - tile
    Black White - color
    left right - direction
  )

  (:init
    (= (total-cost) 0)

    (robot-at PainterBot Tile1)
    (robot-holds-color PainterBot Black)

    (is-unpainted Tile1)
    (is-unpainted Tile2)

    (adjacent Tile1 Tile2 right)
    (adjacent Tile2 Tile1 left)
  )

  (:goal
    (and
      (is-painted Tile1 Black)
      (is-painted Tile2 White)
    )
  )
)