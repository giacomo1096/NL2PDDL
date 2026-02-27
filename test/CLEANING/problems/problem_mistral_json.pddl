(define (problem robot_cleaning_problem)
  (:domain robot_cleaning)

  (:objects
    Robo - robot
    T1 T2 T3 - tile
    left right - direction
  )

  (:init
    (at Robo T1)
    (not (at Robo T2))
    (not (at Robo T3))
    (is-dirty T1)
    (is-dirty T2)
    (is-dirty T3)
    (not (is-cleaning Robo))
    (= (battery-level Robo) 100)
    (adjacent T1 T2 left)
    (adjacent T2 T1 right)
    (adjacent T2 T3 left)
    (adjacent T3 T2 right)
  )

  (:goal
    (is-clean T2)
  )
)