(define (problem fix-machine)
  (:domain structured-analysis)
  
  (:objects
    Roby - robot
    Machine1 - object
    Workshop - room
    Warehouse - room
  )
  
  (:init
    (at Roby Workshop)
    (equipped-with-gripper Roby)
    (requires-fixing Machine1)
    (contains-object Warehouse Machine1)
  )
  
  (:goal
    (and
      (contains-object Warehouse Machine1)
      (not (requires-fixing Machine1))
    )
  )
)