
(define (domain taxi-domain)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    taxi person location - object
  )

  ;; Predicates
  (:predicates
    (is-empty ?t - taxi)
    (in-transit ?t - taxi)
    (in-taxi ?p - person ?t - taxi)
    (at-destination ?p - person)
    (has-taxi ?l - location ?t - taxi)
    (has-person ?l - location ?p - person)
  )

  ;; Functions (Fluents)
  (:functions
    (fuel-level ?t - taxi) - number
  )

  ;; Actions
  (:action drive
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (and
      (not (in-transit ?t))
      (has-taxi ?from ?t)
      (not (exists (?other-t - taxi) (has-taxi ?to ?other-t)))
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

  (:action board
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (has-taxi ?l ?t)
      (has-person ?l ?p)
      (not (in-transit ?t))
      (is-empty ?t)
      (not (at-destination ?p))
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
      (has-taxi ?l ?t)
      (in-taxi ?p ?t)
      (not (in-transit ?t))
    )
    :effect (and
      (not (in-taxi ?p ?t))
      (has-person ?l ?p)
      (is-empty ?t)
      (at