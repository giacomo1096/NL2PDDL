(define (problem robot-repair-problem)
  (:domain robot-repair)

  ;; Objects
  (:objects
    Roby - robot
    Roby_gripper - gripper
    Machine1 - object
    Workshop Warehouse - room
  )

  ;; Initial state
  (:init
    (at Roby Workshop)
    (has-gripper Roby Roby_gripper)
    (not (is-busy Roby))
    (not (holding Roby_gripper Machine1))
    (not (is-active Roby_gripper))
    (is-broken Machine1)
    (not (is-fixed Machine1))
    (in-room Machine1 Warehouse)
    (connected Workshop Warehouse)
    (= (battery-level Roby) 10)
  )

  ;; Goal
  (:goal (is-fixed Machine1))
)