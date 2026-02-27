(define (domain dwr)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot
    location
    container
    crane
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (robot-carrying-container ?r - robot ?c - container)
    (container-at ?c - container ?l - location)
    (crane-at ?cr - crane ?l - location)
    (crane-holding-container ?cr - crane ?c - container)
    (robot-free ?r - robot)
    (crane-free ?cr - crane)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (robot-at ?r ?from)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action load
    :parameters (?r - robot ?l - location ?cr - crane ?c - container)
    :precondition (and
      (robot-at ?r ?l)
      (crane-at ?cr ?l)
      (crane-holding-container ?cr ?c)
      (robot-free ?r)
    )
    :effect (and
      (not (robot-free ?r))
      (robot-carrying-container ?r ?c)
      (not (crane-holding-container ?cr ?c))
      (crane-free ?cr)
    )
  )

  (:action unload
    :parameters (?r - robot ?l - location ?cr - crane ?c - container)
    :precondition (and
      (robot-at ?r ?l)
      (crane-at ?cr ?l)
      (crane-free ?cr)
      (robot-carrying-container ?r ?c)
    )
    :effect (and
      (not (robot-carrying-container ?r ?c))
      (robot-free ?r)
      (crane-holding-container ?cr ?c)
      (not (crane-free ?cr))
    )
  )

  (:action pickup
    :parameters (?cr - crane ?l - location ?c - container)
    :precondition (and
      (crane-at ?cr ?l)
      (crane-free ?cr)
      (container-at ?c ?l)
    )
    :effect (and
      (crane-holding-container ?cr ?c)
      (not (crane-free ?cr))
      (not (container-at ?c ?l))
    )
  )

  (:action putdown
    :parameters (?cr - crane ?l - location ?c - container)
    :precondition (and
      (crane-at ?cr ?l)
      (crane-holding-container ?cr ?c)
    )
    :effect (and
      (not (crane-holding-container ?cr ?c))
      (crane-free ?cr)
      (container-at ?c ?l)
    )
  )
)