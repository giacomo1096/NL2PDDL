(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    terrain goallocation
    hill waterbody - terrain
  )

(:predicates
(is-walkable-terrain ?x - terrain)
(is-climbable-hill ?x - hill)
(is-crossable-waterbody ?x - waterbody)
(is-reached-goallocation ?x - goallocation)
)

(:action walk
    :parameters (?from - terrain ?to - terrain)
    :precondition (and (at ?from) (connected ?from ?to) (is-walkable ?to))
    :effect (and (not (at ?from)) (at ?to))
)
(:action climb
    :parameters (?from - terrain ?to - hill)
    :precondition (and (at ?from) (connected ?from ?to) (is-climbable ?to))
    :effect (and (not (at ?from)) (at ?to))
)
(:action cross
    :parameters (?from - terrain ?to - waterbody)
    :precondition (and (at ?from) (connected ?from ?to) (is-crossable ?to))
    :effect (and (not (at ?from)) (at ?to))
)
(:action finish
    :parameters (?g - goallocation)
    :precondition (at ?g)
    :effect (is-reached ?g)
))
