(define (domain grid-visitor)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot
    place
  )

  (:predicates
    (robot-at ?r - robot ?p - place)
    (connected ?from - place ?to - place)
    (visited ?p - place)
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

  (:action visit
    :parameters (?r - robot ?p - place)
    :precondition (and
      (robot-at ?r ?p)
      (not (visited ?p))
    )
    :effect (and
      (visited ?p)
    )
  )
)
