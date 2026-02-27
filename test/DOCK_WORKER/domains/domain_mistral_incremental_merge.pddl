(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robot location container crane
  )

(:predicates
    ;; Robot predicates
    (at-location-robot ?r - robot ?l - location)
    (is-carrying ?r - robot ?c - container)
    (is-empty ?r - robot)

    ;; Location predicates
    (has-crane ?l - location ?cr - crane)
    (has-container ?l - location ?c - container)
    (is-destination ?l - location)

    ;; Container predicates
    (is-loaded ?c - container)
    (is-unloaded ?c - container)
    (at-location-container ?c - container ?l - location)

    ;; Crane predicates
    (is-operational ?cr - crane)
    (is-lifting ?cr - crane ?c - container)
    (at-location-crane ?cr - crane ?l - location)
)

(:functions
    (battery-level ?r - robot)
)


(:action move
  :parameters (?r - robot ?from - location ?to - location)
  :precondition (and (at-location ?r ?from) (> (battery-level ?r) 0) (not (= ?from ?to)))
  :effect (and (not (at-location ?r ?from)) (at-location ?r ?to) (decrease (battery-level ?r) 1))
)

(:action pickup
  :parameters (?r - robot ?c - container ?l - location)
  :precondition (and (at-location ?r ?l) (at-location ?c ?l) (is-empty ?r) (not (is-carrying ?r ?c)) (is-unloaded ?c))
  :effect (and (not (is-empty ?r)) (is-carrying ?r ?c) (not (is-unloaded ?c)) (not (has-container ?l ?c)) (is-loaded ?c))
)

(:action drop
  :parameters (?r - robot ?c - container ?l - location)
  :precondition (and (at-location ?r ?l) (is-carrying ?r ?c) (not (has-container ?l ?c)))
  :effect (and (is-empty ?r) (not (is-carrying ?r ?c)) (has-container ?l ?c) (not (is-loaded ?c)) (is-unloaded ?c) (at-location ?c ?l))
)

(:action load-to-crane
  :parameters (?r - robot ?c - container ?l - location ?cr - crane)
  :precondition (and (at-location ?r ?l) (at-location ?cr ?l) (has-crane ?l ?cr) (is-carrying ?r ?c) (is-operational ?cr) (not (is-lifting ?cr ?c)))
  :effect (and (not (is-carrying ?r ?c)) (is-empty ?r) (is-lifting ?cr ?c) (not (is-loaded ?c)) (at-location ?c ?l))
)
 )
