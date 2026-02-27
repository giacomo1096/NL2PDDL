(define (domain visit-all)
  (:requirements :strips :typing :negative-preconditions)
  (:types
    robot
    place
  )
  (:predicates
    (robot-at ?r - robot ?p - place)
    (visited ?p - place)
    (connected ?p1 - place ?p2 - place)
  )
  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (and
      (robot-at ?r ?from)
      (connected ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
      (visited ?to)
    )
  )
)