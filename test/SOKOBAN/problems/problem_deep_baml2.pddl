(define (problem push-box-task)
  (:domain sokoban)

  (:objects
    Wall-E - robot
    Box1 - box
    Tile1 Tile2 Tile3 - location
    Right - direction
  )

  (:init
    (robot-at Wall-E Tile1)
    (box-at Box1 Tile2)
    (clear Tile3)
    (is-target Tile3)
    (adjacent Tile1 Tile2 Right)
    (adjacent Tile2 Tile3 Right)
  )

  (:goal
    (and
      (box-at Box1 Tile3)
    )
  )
)