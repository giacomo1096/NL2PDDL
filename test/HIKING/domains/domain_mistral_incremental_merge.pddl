(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    terrain - object
    hill - terrain
    waterbody - terrain
    location - object
    goallocation - location
  )

(:predicates
    (is-traversable ?t - terrain)
    (requires-climbing ?h - hill)
    (requires-swimming ?w - waterbody)
    (is-visited ?l - location)
    (is-reached ?g - goallocation)
)


(:action walk
  :parameters (?from - location ?to - location ?t - terrain)
  :precondition (and (is-traversable ?t)
                     (not (requires-climbing ?t))
                     (not (requires-swimming ?t))
                     (is-visited ?from)
                     (not (is-visited ?to)))
  :effect (and (not (is-visited ?from))
               (is-visited ?to)))

(:action climb
  :parameters (?from - location ?to - location ?h - hill)
  :precondition (and (requires-climbing ?h)
                     (is-visited ?from)
                     (not (is-visited ?to)))
  :effect (and (not (is-visited ?from))
               (is-visited ?to)))

(:action swim
  :parameters (?from - location ?to - location ?w - waterbody)
  :precondition (and (requires-swimming ?w)
                     (is-visited ?from)
                     (not (is-visited ?to)))
  :effect (and (not (is-visited ?from))
               (is-visited ?to)))

(:action reach_goal
  :parameters (?l - location ?g - goallocation)
  :precondition (and (is-visited ?l)
                     (not (is-reached ?g)))
  :effect (is-reached ?g))
 )
