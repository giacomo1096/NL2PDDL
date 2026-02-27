(define (problem stacking-blocks)
  (:domain robotic-arm)
  
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
    (not (is-holding roboticarm none))
  )
  
  (:goal
    (is-on B A)
    (is-on C B)
    (is-on-table D)
    (is-free A)
    (is-free B)
    (is-free C)
    (is-free D)
    (not (is-holding roboticarm A))
    (not (is-holding roboticarm B))
    (not (is-holding roboticarm C))
    (not (is-holding roboticarm D))
  )
)