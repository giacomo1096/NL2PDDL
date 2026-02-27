(define (domain taxi-service)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    taxi person location
  )

  (:predicates
    (taxi-at ?t - taxi ?l - location)
    (carrying-person ?t - taxi ?p - person)
    (person-at ?p - person ?l - location)
    (destination ?p - person ?l - location)
  )

  (:action move
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (and
      (taxi-at ?t ?from)
    )
    :effect (and
      (not (taxi-at ?t ?from))
      (taxi-at ?t ?to)
    )
  )

  (:action pickup
    :parameters (?t - taxi ?p - person ?loc - location)
    :precondition (and
      (taxi-at ?t ?loc)
      (person-at ?p ?loc)
      (not (carrying-person ?t ?p))
    )
    :effect (and
      (carrying-person ?t ?p)
      (not (person-at ?p ?loc))
    )
  )

  (:action dropoff
    :parameters (?t - taxi ?p - person ?loc - location)
    :precondition (and
      (taxi-at ?t ?loc)
      (carrying-person ?t ?p)
    )
    :effect (and
      (not (carrying-person ?t ?p))
      (person-at ?p ?loc)
    )
  )
)