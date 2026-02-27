
(define (domain terrain-navigation)
  (:requirements :strips :typing)
  
  (:types
    terrain
    hill - terrain
    waterbody - terrain
    location
    agent
  )

  (:predicates
    (is-passable ?t - terrain)
    (is-steep ?h - hill)
    (is-crossable ?w - waterbody)
    (is-goal ?l - location)
    (at-location ?a - agent ?l - location)
  )

  (:action walk
    :parameters (?a - agent ?from - location ?to - location ?t - terrain)
    :precondition (and
      (at-location ?a ?from)
      (is-passable ?t)
    )
    :effect (and
      (not (at-location ?a ?from))
      (at-location ?a ?to)
    )
  )

  (:action climb
    :parameters (?a - agent ?from - location ?to - location ?h - hill)
    :precondition (and
      (at-location ?a ?from)
      (is-steep ?h)
    )
    :effect (and
      (not (at-location ?a ?from))
      (at-location ?a ?to)
    )
  )

  (:action cross
    :parameters (?a - agent ?from - location ?to - location ?w - waterbody)
    :precondition (and
      (at-location ?a ?from)
      (is-crossable ?w)
    )
    :effect (and
      (not (at-location ?a ?from))
      (at-location ?a ?to)
    )
  )
)