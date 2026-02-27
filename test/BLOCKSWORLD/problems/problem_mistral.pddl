(define (problem blocks-world-problem)
  (:domain blocks-world)

  (:objects
    A B C D - block
    roboticarm1 - roboticarm
    table1 - table
  )

  (:init
    (on-table A)
    (on-table B)
    (on-table C)
    (on-table D)
    (clear A)
    (clear B)
    (clear C)
    (clear D)
    (empty roboticarm1)
  )

  (:goal
    (and
      (on C B)
      (on B A)
      (on-table D)
      (clear C)
      (clear D)
      (empty roboticarm1)
    )
  )
)