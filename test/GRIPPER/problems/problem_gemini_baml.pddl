(define (problem fix-machine-problem)
  (:domain robot-world)
  (:objects
    Workshop Warehouse - room
    Roby - robot
    Machine1 - object
    roby_gripper - gripper
  )
  (:init
    (connected Workshop Warehouse)
    (connected Warehouse Workshop)
    (robot-at Roby Workshop)
    (object-at Machine1 Warehouse)
    (equipped Roby roby_gripper)
    (gripper-free roby_gripper)
  )
  (:goal
    (and
      (fixed Machine1)
    )
  )
)