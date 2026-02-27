
(define (domain taxi)
  (:requirements :typing :fluents)

  (:types
    taxi person location - object
  )

  (:predicates
    (is-empty ?t - taxi)
    (in-transit ?t - taxi)
    (in-taxi ?p - person ?t - taxi)
    (at-destination ?p - person)
    (has-taxi ?l - location ?t - taxi)
    (has-person ?l - location ?p - person)
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
    )
  )

  (:action pick-up
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (not (in-transit ?t))
      (has-taxi ?l ?t)
      (has-person ?l ?p)
      (not (at-destination ?p))
      (is-empty ?t)
    )
    :effect (and
      (not (is-empty ?t))
      (not (has-person ?l ?p))
      (in-taxi ?p ?t)
    )
  )

  (:action drop-off
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (not (in-transit ?t))
      (has-taxi ?l ?t)
      (in-taxi ?p ?t)
    )
    :effect (and