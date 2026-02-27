(define (problem build-tower-problem)
  (:domain blocks-world-arm)
  (:objects
    A B C D - block
    robot-arm - roboticarm
  )
  (:init
    (on-table A)
    (clear A)
    (on-table B)
    (clear B)
    (on-table C)
    (clear C)
    (on-table D)
    (clear D)
    (arm-empty robot-arm)
  )
  (:goal (and
    (on B A)
    (on C B)
    (on-table D)
    (clear C)
    (clear D)
    (arm-empty robot-arm)
  ))
)