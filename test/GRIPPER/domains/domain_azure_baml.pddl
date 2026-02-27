(define (domain robot-world)
  (:requirements :typing)

  (:types agent robot gripper object room - agent)

  (:predicates
    (at ?r - robot ?loc - room)
    (has-gripper ?r - robot)
    (fixing ?r - robot)
    (fixed ?o - object)
    (at ?o - object ?loc - room)
  )

  (:action navigate
    :parameters (?r - robot ?from ?to - room)
    :precondition (and (at ?r ?from))
    :effect (and
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )

  (:action pick-up
    :parameters (?r - robot ?o - object ?loc - room)
    :precondition (and
      (at ?r ?loc)
      (at ?o ?loc)
      (has-gripper ?r)
      (not (fixing ?r))
    )
    :effect (and
      (assign (fixing ?r) true)
      (assign (fixed ?o) true)
    )
  )

  (:action fix
    :parameters (?r - robot ?o - object ?loc - room)
    :precondition (and
      (at ?r ?loc)
      (at ?o ?loc)
      (has-gripper ?r)
      (fixing ?r)
    )
    :effect (assign (fixed ?o) true)
  )
)