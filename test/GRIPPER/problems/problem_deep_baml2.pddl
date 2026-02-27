(define (problem fix-machine1)
  (:domain robot-fixing)

  (:objects
    Roby - robot
    Workshop Warehouse - room
    Machine1 - object
    gripper - gripper
  )

  (:init
    (robot-at Roby Workshop)
    (object-at Machine1 Warehouse)
    (has-gripper Roby gripper)
    (gripper-free gripper)
    (not (fixed Machine1))
  )

  (:goal
    (and
      (fixed Machine1)
    )
  )
)