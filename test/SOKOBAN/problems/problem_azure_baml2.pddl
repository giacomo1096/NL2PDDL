(define (problem walle-push-hallway)
    (:domain sokoban)

    (:objects
        walle - robot
 
        box1 - box
 
        tile1 tile2 tile3 - location
 
        right - direction
    )

    (:init 
        (adjacent-in-direction tile1 tile2 right)
        (adjacent-in-direction tile2 tile3 right)
 
        (is-goal-location tile3)
 
        (robot-at walle tile1)
         
        (facing-direction walle right) 
        (box-at box1 tile2)
    )

    (:goal
        (and
           (at-goal-location box1 tile3)
        )
    )
)