(define (problem fix-machine1-problem)
    (:domain robot-fixer)
    (:objects
        Roby - robot
        Gripper1 - gripper
        Machine1 - object
        Workshop - room
        Warehouse - room
    )
    (:init
        (is-at-room Roby Workshop)
        (is-located-in Machine1 Warehouse)
        (is-free Gripper1)
    )
    (:goal
        (and
            (is-fixed Machine1)
        )
    )
)