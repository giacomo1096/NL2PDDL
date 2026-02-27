(define (problem cleaning-robot-problem)
  (:domain cleaning-robot)

  ;; Objects
  (:objects
    Robo - robot
    T1 T2 T3 - tile
    left right - direction
    grid1 - grid
  )

  ;; Initial state
  (:init
    ;; Robot position
    (at Robo T1)
    (not (at Robo T2))
    (not (at Robo T3))

    ;; Cleaning status
    (not (is-cleaning Robo))

    ;; Tile cleanliness
    (is-dirty T1)
    (is-dirty T2)
    (is-dirty T3)

    ;; Adjacency relations
    (adjacent T1 T2 right)
    (adjacent T2 T1 left)
    (adjacent T2 T3 right)
    (adjacent T3 T2 left)

    ;; Battery level
    (= (battery-level Robo) 100)
  )

  ;; Goal
  (:goal (is-clean T2))
)