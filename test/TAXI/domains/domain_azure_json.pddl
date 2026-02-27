(define (domain taxi-domain)
  (:requirements :strips :typing)
  (:types
    taxi
    person
    location
  )

  (:predicates
    (occupied ?t - taxi)
    (at-location-taxi ?t - taxi ?l - location)
    (at-location-person ?p - person ?l - location)
    (in-taxi ?p - person ?t - taxi)
    (is-destination ?l - location)
  )

  (:action move
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (at-location-taxi ?t ?from)
    :effect (and
      (not (at-location-taxi ?t ?from))
      (at-location-taxi ?t ?to)
    )
  )

  (:action board
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (at-location-person ?p ?l)
      (at-location-taxi ?t ?l)
      (not (in-taxi ?p ?t))
      (not (occupied ?t))
    )
    :effect (and
      (not (at-location-person ?p ?l))
      (in-taxi ?p ?t)
      (occupied ?t)
    )
  )

  (:action disembark
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (in-taxi ?p ?t)
      (at-location-taxi ?t ?l)
    )
    :effect (and
      (not (in-taxi ?p ?t))
      (at-location-person ?p ?l)
      (not (occupied ?t))
    )
  )
)