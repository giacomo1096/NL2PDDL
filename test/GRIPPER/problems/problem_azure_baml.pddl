(define (problem fixing_problem)
  (:domain fixingworld)
  
  (:objects
    Roby - robot
    Workshop Warehouse - room
    Machine1 - object
  )
  
  (:init
    (at Roby Workshop)
    (in-room Machine1 Warehouse)
    (broken Machine1)
    (has-gripper Roby)
  )
  
  (:goal
    (fixed Machine1)
  )
)