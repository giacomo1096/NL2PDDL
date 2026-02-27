(define (problem robot_repair_problem)
  (:domain robot_repair_domain)

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
    (has-gripper Roby)
    (not (is-busy Roby))
    (not (holding Roby_gripper Machine1))
    (is-active Roby_gripper)
    (is-broken Machine1)
    (not (is-fixed Machine1))
    (in-room Machine1 Warehouse)
    (connected Workshop Warehouse)
    (has-object Warehouse Machine1)
    (= (battery-level Roby) 100)
  )

  ;; Goal
  (:goal (is-fixed Machine1))
)