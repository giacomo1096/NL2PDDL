(define (problem stack-three-tower)
  (:domain blocksworld)

  (:objects
    A B C D - block
    table1 - table
    arm1 - robotic-arm
  )

  (:init
    (on-table A table1)
    (on-table B table1)
    (on-table C table1)
    (on-table D table1)
    (clear A)
    (clear B)
    (clear C)
    (clear D)
    (arm-empty arm1)
  )

  (:goal
    (and
      (on-block B A)
      (on-block C B)
      (on-table D table1)
      (clear C)
      (clear D)
      (arm-empty arm1)
    )
  )
)