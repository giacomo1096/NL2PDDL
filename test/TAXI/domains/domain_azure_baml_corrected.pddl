
(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types vehicle location person)
  
  (:predicates
    (at-taxi ?t - vehicle ?l - location)
    (occupied ?t - vehicle)
    (at-person ?p - person ?l - location)
    (in-taxi ?p - person)
  )

  (:action move
    :parameters (?t - vehicle ?from - location ?to - location)
    :precondition (and
      (at-taxi ?t ?from)
      (not (occupied ?t))
    )
    :effect (and
      (not (at-taxi ?t ?from))
      (at-taxi ?t ?to)
    )
  )

  (:action pickup
    :parameters (?p - person ?t - vehicle ?loc - location)
    :precondition (and
      (at-person ?p ?loc)
      (at-taxi ?t ?loc)
      (not (in-taxi ?p))
    )
    :effect (and
      (assign (in-taxi ?p) true)
      (assign (occupied ?t) true)
    )
  )

  (:action dropoff
    :parameters (?p - person ?t - vehicle ?dest - location)
    :precondition (and
      (in-taxi ?p)
      (at-taxi ?t ?dest)
    )
    :effect (and
      (assign (in-taxi ?p) false)
      (assign (occupied ?t) false)
      (assign (at-person ?p) ?dest)
    )
  )
)