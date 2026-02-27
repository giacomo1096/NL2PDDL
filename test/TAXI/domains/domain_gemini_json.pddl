(define (domain taxi-domain)
  (:requirements :typing)

  (:types
    taxi
    location
    person
  )

  (:predicates
    (at ?o - (either person taxi) ?l - location)
    (is-empty ?t - taxi)
    (in-taxi ?p - person ?t - taxi)
    (destination ?p - person ?l - location)
    (at-destination ?p - person)
  )

  (:action drive
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (and
      (at ?t ?from)
    )
    :effect (and
      (not (at ?t ?from))
      (at ?t ?to)
    )
  )

  (:action pick-up
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (at ?p ?l)
      (at ?t ?l)
      (is-empty ?t)
    )
    :effect (and
      (not (at ?p ?l))
      (not (is-empty ?t))
      (in-taxi ?p ?t)
    )
  )

  (:action drop-off
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (in-taxi ?p ?t)
      (at ?t ?l)
      (destination ?p ?l)
    )
    :effect (and
      (not (in-taxi ?p ?t))
      (is-empty ?t)
      (at ?p ?l)
      (at-destination ?p)
    )
  )
)