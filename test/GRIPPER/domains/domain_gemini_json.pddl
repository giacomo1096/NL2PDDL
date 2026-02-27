(define (domain generated-domain)
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
    (is-fixed ?o - object)
    (is-in ?o - object ?l - room)
    (are-connected ?l1 - room ?l2 - room)
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
    )
  )
)