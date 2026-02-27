(define (domain fixingworld)
  (:requirements :strips :typing)

  (:types
    agent - object
    robot - agent
    gripper - object
    object - object
    room - object
  )

  (:predicates
    (at ?r - robot ?l - room)
    (has-gripper ?r - robot)
    (fixing ?r - robot)
    (fixed ?o - object)
    (in-room ?o - object ?r - room)
  )

  (:action navigate
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (at ?r ?from)
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )

  (:action pick-up
    :parameters (?r - robot ?o - object ?loc - room)
    :precondition (and (at ?r ?loc) (in-room ?o ?loc))
    :effect (and (fixing ?r) (not (in-room ?o ?loc)))
  )

  (:action fix
    :parameters (?r - robot ?o - object ?loc - room)
    :precondition (and (at ?r ?loc) (fixing ?r))
    :effect (and (fixed ?o) (not (fixing ?r)))
  )
)