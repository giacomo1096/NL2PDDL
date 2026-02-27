
(define (domain hiking-navigation)
  (:requirements :strips :typing)
  
  (:types
    location ;; A general type for all places
    terrain goallocation - location ;; terrain and goallocation are specific types of locations
    hill waterbody - terrain ;; hill and waterbody are specific types of terrain
  )

  (:predicates
    (at ?loc - location)
    (connected ?from - location ?to - location)
    (is-walkable ?t - terrain)
    (is-climbable ?h - hill)
    (is-crossable ?w - waterbody)
    (is-reached ?g - goallocation)
  )

  (:action walk
    :parameters (?from - location ?to - terrain)
    :precondition (and
        (at ?from)
        (connected ?from ?to)
        (is-walkable ?to)
    )
    :effect (and
        (not (at ?from))
        (at ?to)
    )
  )

  (:action climb
    :parameters (?from - location ?to - hill)
    :precondition (and
        (at ?from)
        (connected ?from ?to)
        (is-climbable ?to)
    )
    :effect (and
        (not (at ?from))
        (at ?to)
    )
  )

  (:action cross
    :parameters (?from - location ?to - waterbody)
    :precondition (and
        (at ?from)
        (connected ?from ?to)
        (is-crossable ?to)
    )
    :effect (and
        (not (at ?from))
        (at ?to)
    )
  )

  (:action finish
    :parameters (?g - goallocation)
    :precondition (at ?g)
    :effect (is-reached ?g)
  )
)