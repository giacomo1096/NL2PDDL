(define (problem clean-tile-T2)
  (:domain tilecleaner)

  (:objects
    Robo - robot
    T1 T2 T3 - tile
  )

  (:init
    (at Robo T1)
    (adjacent T1 T2)
    (adjacent T2 T1)
    (adjacent T2 T3)
    (adjacent T3 T2)
  )

  (:goal
    (and
      (cleaned T2)
    )
  )
)