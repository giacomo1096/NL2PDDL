(define (problem three-block-tower)
  (:domain blocksworld)

  (:objects
    A B C D - block
    table - table
    roboticarm - robotic-arm
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
    (arm-empty roboticarm)
  )

  (:goal
    (and
      (on-block B A)
      (on-block C B)
      (on-table A)
      (on-table D)
      (clear C)
      (clear D)
      (arm-empty roboticarm)
    )
  )
)