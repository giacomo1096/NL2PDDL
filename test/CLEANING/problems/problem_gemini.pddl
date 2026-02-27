(define (problem clean-tile-2)
  (:domain robot-cleaner)
  (:objects
    Robo - robot
    T1 T2 T3 - tile
  )
  (:init
    (robot-at Robo T1)
    (right T1 T2)
    (left T2 T1)
    (right T2 T3)
    (left T3 T2)
  )
  (:goal (and
    (is-clean T2)
  ))
)