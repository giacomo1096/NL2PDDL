(define (domain taxi-domain)
  (:requirements :typing)

  (:types
    taxi
    location
    person
  )

  (:predicates
    (taxi-at ?t - taxi ?l - location)
    (taxi-empty ?t - taxi)
    (person-at ?p - person ?l - location)
    (in-taxi ?p - person ?t - taxi)
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

  (:action pickup-person
    :parameters (?t - taxi ?p - person ?l - location)
    :precondition (and
      (taxi-at ?t ?l)
      (person-at ?p ?l)
      (taxi-empty ?t)
    )
    :effect (and
      (not (person-at ?p ?l))
      (in-taxi ?p ?t)
      (not (taxi-empty ?t))
    )
  )

  (:action dropoff-person
    :parameters (?t - taxi ?p - person ?l - location)
    :precondition (and
      (taxi-at ?t ?l)
      (in-taxi ?p ?t)
    )
    :effect (and
      (not (in-taxi ?p ?t))
      (person-at ?p ?l)
      (taxi-empty ?t)
    )
  )
)