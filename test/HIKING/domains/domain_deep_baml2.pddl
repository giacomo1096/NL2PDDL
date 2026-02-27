(define (domain hiking)
  (:requirements :strips :typing :negative-preconditions :existential-preconditions :universal-preconditions)

  (:types
    agent
    terrain
    hill - terrain
    water-body - terrain
    location
  )

  (:predicates
    (agent-at ?a - agent ?l - location)
    (has-terrain ?l - location ?t - terrain)
    (is-target ?gl - location)
  )

  (:action walk
    :parameters (?a - agent ?from - location ?to - location)
    :precondition (and
      (agent-at ?a ?from)
      (forall (?h - hill) (not (has-terrain ?to ?h)))
    )
    :effect (and
      (not (agent-at ?a ?from))
      (agent-at ?a ?to)
    )
  )

  (:action climb
    :parameters (?a - agent ?from - location ?to - location)
    :precondition (and
      (agent-at ?a ?from)
      (exists (?h - hill) (has-terrain ?to ?h))
    )
    :effect (and
      (not (agent-at ?a ?from))
      (agent-at ?a ?to)
    )
  )
)