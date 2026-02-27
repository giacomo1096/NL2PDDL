(define (domain container-robot)
  (:requirements :typing)
  (:types
    robot
    container
    crane
    location
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (is-loaded ?r - robot)
    (is-loaded-on-robot ?c - container)
    (is-at-location ?c - container ?l - location)
    (is-operational ?cr - crane)
    (has-crane ?l - location)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (robot-at ?r ?from)
      (not (= ?from ?to))
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action load
    :parameters (?r - robot ?c - container ?l - location ?cr - crane)
    :precondition (and
      (robot-at ?r ?l)
      (is-at-location ?c ?l)
      (has-crane ?l)
      (is-operational ?cr)
      (not (is-loaded ?r))
      (not (is-loaded-on-robot ?c))
    )
    :effect (and
      (is-loaded ?r)
      (is-loaded-on-robot ?c)
      (not (is-at-location ?c ?l))
    )
  )

  (:action unload
    :parameters (?r - robot ?c - container ?l - location ?cr - crane)
    :precondition (and
      (robot-at ?r ?l)
      (has-crane ?l)
      (is-operational ?cr)
      (is-loaded ?r)
      (is-loaded-on-robot ?c)
    )
    :effect (and
      (not (is-loaded ?r))
      (not (is-loaded-on-robot ?c))
      (is-at-location ?c ?l)
    )
  )
)