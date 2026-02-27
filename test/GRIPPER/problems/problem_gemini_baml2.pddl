(define (problem fix-machine-problem)
  (:domain repair)

  (:objects
    Workshop Warehouse - room
    Roby - robot
    Machine1 - object
    g1 - gripper
  )

  (:init
    (at-robot Roby Workshop)
    (at-object Machine1 Warehouse)
    (connected Workshop Warehouse)
    (connected Warehouse Workshop)
    (has-gripper Roby g1)
    (free g1)
  )

  (:goal
    (and
      (fixed Machine1)
    )
  )
)