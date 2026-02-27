(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types vehicle location person)
  (:predicates
    (at-taxi ?t taxi ?l location)
    (occupied ?t taxi)
    (at-person ?p person ?l location)
    (in-taxi ?p person)
  )
  (:action move
    :parameters (?t taxi ?from location ?to location)
    :precondition (and
      (at ?t ?from)
      (not (occupied ?t))
    )
    :effect (and
      (not (at ?t ?from))
      (at ?t ?to)
    )
  )
  (:action pickup
    :parameters (?p person ?t taxi ?loc location)
    :precondition (and
      (at ?p ?loc)
      (at ?t ?loc)
      (not (in-taxi ?p))
    )
    :effect (and
      (assign (in-taxi ?p) true)
      (assign (occupied ?t) true)
    )
  )
  (:action dropoff
    :parameters (?p person ?t taxi ?dest location)
    :precondition (and
      (in-taxi ?p)
      (at ?t ?dest)
    )
    :effect (and
      (assign (in-taxi ?p) false)
      (assign (occupied ?t) false)
      (assign (at ?p) ?dest)
    )
  )
)