(define (problem robot-world-problem)
  (:domain robot-world)
  
  (:objects
    Roby - robot
    Machine1 - object
    Workshop - room
    Warehouse - room
  )
  
  (:init
    (robot-at Roby Workshop)
    (equipped-with-gripper Roby)
    (requires-fixing Machine1)
    (contains-object Warehouse Machine1)
  )
  
  (:goal
    (and
      (not (requires-fixing Machine1))
      (contains-object Warehouse Machine1)
    )
  )
)