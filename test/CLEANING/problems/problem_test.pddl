(define (problem clean-middle-tile)
  (:domain tilecleaning)

  (:objects
    Robo - robot
    T1 T2 T3 - tile
  )

  (:init
    (at-tile Robo T1)
    (adjacent T1 T2)
    (adjacent T2 T1)
    (adjacent T2 T3)
    (adjacent T3 T2)
    (dirty T2)

    ;; all dirty except the ones marked clean
    ;; so leave T2 dirty by omitting (clean T2)
  )

  (:goal
    (clean T2)
  )
)
