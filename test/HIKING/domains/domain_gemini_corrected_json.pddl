
(define (domain hiking-domain)
  (:requirements :typing)
  (:types
    location
    terrain goallocation - location
    hill waterbody - terrain
  )

  (:predicates
    (at ?loc - location)
    (connected ?from - location ?to - location)
    (is-walkable-terrain ?t - terrain)
    (is-climbable-hill ?h - hill)
    (is-crossable-waterbody ?w - waterbody)
    (is-reached-goallocation ?g - goallocation)
  )

  (:action walk
    :parameters (?from - location ?to - terrain)
    :precondition (and 
        (at ?from) 
        (connected ?from ?to) 
        (is-walkable-terrain ?to)
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
        (is-climbable-hill ?to)
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
        (is-crossable-waterbody ?to)
    )
    :effect (and 
        (not (at ?from)) 
        (at ?to)
    )
  )

  (:action finish
    :parameters (?g - goallocation)
    :precondition (at ?g)
    :effect (is-reached-goallocation ?g)
  )
)