(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
     taxi person location
  )

(:predicates
    (is-empty ?t - taxi)
    (in-transit ?t - taxi)
    (in-taxi ?p - person ?t - taxi)
    (at-destination ?p - person)
    (has-taxi ?l - location ?t - taxi)
    (has-person ?l - location ?p - person)
    (fuel-level ?t - taxi)
)

(:functions
    (fuel-level ?t - taxi)
)


(:action drive
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (and
        (not (in-transit ?t))
        (has-taxi ?from ?t)
        (not (has-taxi ?to ?t))
        (> (fuel-level ?t) 0)
        (is-empty ?t)
    )
    :effect (and
        (not (has-taxi ?from ?t))
        (has-taxi ?to ?t)
        (in-transit ?t)
        (decrease (fuel-level ?t) 1)
    )
)

(:action arrive
    :parameters (?t - taxi ?l - location)
    :precondition (and
        (in-transit ?t)
        (has-taxi ?l ?t)
    )
    :effect (and
        (not (in-transit ?t))
        (not (is-empty ?t))
    )
)

(:action board
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
        (has-person ?l ?p)
        (has-taxi ?l ?t)
        (not (in-transit ?t))
        (not (in-taxi ?p ?t))
        (is-empty ?t)
    )
    :effect (and
        (not (has-person ?l ?p))
        (in-taxi ?p ?t)
        (not (is-empty ?t))
    )
)

(:action alight
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
        (in-taxi ?p ?t)
        (has-taxi ?l ?t)
        (not (in-transit ?t))
        (not (at-destination ?p))
    )
    :effect (and
        (not (in-taxi ?p ?t))
        (has-person ?l ?p)
        (is-empty ?t)
        (at-destination ?p)
    )
)

(:action refuel
    :parameters (?t - taxi ?l - location)
    :precondition (and
        (has-taxi ?l ?t)
        (not (in-transit ?t))
        (< (fuel-level ?t) 10)
    )
    :effect (increase (fuel-level ?t) 100)
    )
)
