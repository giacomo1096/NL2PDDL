(define (problem clean-middle-tile)
  (:domain robot-grid-cleaning)
  (:objects
    Robo - robot
    T1 T2 T3 - tile
  )
  (:init
    (at-robot-tile Robo T1)
    ; All tiles are initially not cleaned
    (not (cleaned T1))
    (not (cleaned T2))
    (not (cleaned T3))
  )
  (:goal
    (cleaned T2)
  )
)