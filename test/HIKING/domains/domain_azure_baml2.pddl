(define (domain hiking)
  (:requirements :strips :typing)

  (:types
    terrain
    hill - terrain
    waterbody - terrain
    location
    agent
  )

  (:predicates
    (at-location ?a - agent ?l - location)
    (is-goal-location ?l - location)
    (has-hill ?t - terrain)
    (has-waterbody ?t - terrain)
    (is-hill ?h - hill)
    (is-waterbody ?w - waterbody)
  )

  (:action walk
    :parameters (?a - agent ?from - location ?to - location ?terrain - terrain)
    :precondition (and (at-location ?a ?from)
                       (not (has-hill ?terrain))
                       (not (has-waterbody ?terrain)))
    :effect (and (not (at-location ?a ?from))
                 (at-location ?a ?to))
  )

  (:action climb
    :parameters (?a - agent ?from - location ?to - location ?hill - hill)
    :precondition (and (at-location ?a ?from)
                       (is-hill ?hill))
    :effect (and (not (at-location ?a ?from))
                 (at-location ?a ?to))
  )

  (:action cross-waterbody
    :parameters (?a - agent ?from - location ?to - location ?waterbody - waterbody)
    :precondition (and (at-location ?a ?from)
                       (is-waterbody ?waterbody))
    :effect (and (not (at-location ?a ?from))
                 (at-location ?a ?to))
  )

  (:action reach-goal
    :parameters (?a - agent ?goal - location)
    :precondition (and (at-location ?a ?goal)
                       (is-goal-location ?goal))
    :effect (and)
  )
)