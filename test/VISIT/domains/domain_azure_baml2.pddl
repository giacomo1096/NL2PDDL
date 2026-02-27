(define (domain grid-visit)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    robot
    place
    grid
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
      (not (robot-at ?r ?to))
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action visit
    :parameters (?r - robot ?p - place)
    :precondition (and
      (robot-at ?r ?p)
      (not (visited ?p))
    )
    :effect (visited ?p)
  )
)
