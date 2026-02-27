(define (domain robot-fixing)
  (:requirements :typing)

  (:types
    robot
    gripper
    object
    room
  )

  (:predicates
    (is-at ?r - robot ?l - room)
    (is-free ?g - gripper)
    (is-in ?o - object ?l - room)
    (is-fixed ?o - object)
    (are-connected ?from - room ?to - room)
  )

  (:action move
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (and
      (is-at ?r ?from)
      (are-connected ?from ?to)
    )
    :effect (and
      (not (is-at ?r ?from))
      (is-at ?r ?to)
    )
  )

  (:action fix
    :parameters (?r - robot ?g - gripper ?o - object ?l - room)
    :precondition (and
      (is-at ?r ?l)
      (is-in ?o ?l)
      (is-free ?g)
      (not (is-fixed ?o))
    )
    :effect (and
      (is-fixed ?o)
      (not (is-free ?g))
    )
  )
)