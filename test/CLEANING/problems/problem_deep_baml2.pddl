(define (problem clean-t2)
  (:domain floor-cleaning)

  (:objects
    Robo - robot
    T1 T2 T3 - tile
  )

  (:init
    (robot-at Robo T1)
    (adjacent T1 T2)
    (adjacent T2 T1)
    (adjacent T2 T3)
    (adjacent T3 T2)
  )

  (:goal
    (clean T2)
  )
)