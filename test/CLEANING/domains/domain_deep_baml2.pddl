(define (domain floor-cleaning)
  (:requirements :strips :typing :negative-preconditions)
  (:types
    robot
    tile
  )
  (:predicates
    (robot-at ?r - robot ?t - tile)
    (clean ?t - tile)
    (adjacent ?t1 - tile ?t2 - tile)
  )
  (:action move
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (robot-at ?r ?from)
      (adjacent ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )
  (:action clean
    :parameters (?r - robot ?t - tile)
    :precondition (and
      (robot-at ?r ?t)
      (not (clean ?t))
    )
    :effect (and
      (clean ?t)
    )
  )
)