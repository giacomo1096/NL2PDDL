(define (problem roboticarm_problem)
  (:domain roboticarm_domain)
  
  (:objects 
    A B C D - block
    table - table
    roboticarm - roboticarm
  )
  
  (:init 
    (on-table D)
    (on-table A)
    (on-table C)
    (on-table B)
    (clear A)
    (clear B)
    (clear C)
    (clear D)
    (free roboticarm)
  )
  
  (:goal 
    (and 
      (on B A)
      (on C B)
      (on-table D)
    )
  )
)