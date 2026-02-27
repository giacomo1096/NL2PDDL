 (define (domain tilecleaning)
  (:requirements :strips :typing)
  (:types
    robot 
    tile    
  )

  (:predicates
    (at-tile ?r - robot ?t - tile)
    (clean ?t - tile)
    (adjacent ?t1 - tile ?t2 - tile)
  )

  (:action move
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and (at-tile ?r ?from) (adjacent ?from ?to))
    :effect (and (not (at-tile ?r ?from)) (at-tile ?r ?to))
  )

  (:action clean-tile
    :parameters (?r - robot ?t - tile)
    :precondition (and (at-tile ?r ?t) (not (clean ?t)))
    :effect (clean ?t)
  )
) 