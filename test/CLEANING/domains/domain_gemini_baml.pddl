(define (domain robot-cleaning)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot
    tile
  )

  (:predicates
    (at ?r - robot ?t - tile)
    (cleaned ?t - tile)
    (adjacent ?t1 - tile ?t2 - tile)
  )

  (:action move
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (at ?r ?from)
      (adjacent ?from ?to)
    )
    :effect (and
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )

  (:action clean
    :parameters (?r - robot ?t - tile)
    :precondition (and
      (at ?r ?t)
      (not (cleaned ?t))
    )
    :effect (and
      (cleaned ?t)
    )
  )
)