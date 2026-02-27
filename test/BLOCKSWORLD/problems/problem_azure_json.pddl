(define (problem roboticarm_problem)
  (:domain roboticarm_domain)
  
  (:objects 
    A B C D - block
    table - table
    roboticarm - roboticarm
  )
  
  (:init 
    (is-free A)
    (is-free B)
    (is-free C)
    (is-free D)
    (is-on-table table)
    (is-holding roboticarm none)
  )
  
  (:goal 
    (and 
      (is-on-table D)
      (is-free A)
      (is-free B)
      (is-free C)
      (is-free D)
      (not (is-holding roboticarm any))
    )
  )
)