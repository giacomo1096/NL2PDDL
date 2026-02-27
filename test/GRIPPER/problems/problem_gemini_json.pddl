(define (problem fix-machine1-problem)
    (:domain robot-fixer)
    (:objects
        Roby - robot
        gripper1 - gripper
        Machine1 - object
        Workshop Warehouse - room
    )
    (:init
        (is-at-room Roby Workshop)
        (is-located-in Machine1 Warehouse)
        (is-free gripper1)
    )
    (:goal (and
        (is-fixed Machine1)
    ))
)