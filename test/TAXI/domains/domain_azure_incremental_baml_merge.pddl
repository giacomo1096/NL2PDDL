(define (domain mydomain)
(:requirements :typing :fluents)
(:types vehicle location person)
)

(predicates
  (at-taxi ?t - taxi ?l - location)
  (occupied ?t - taxi)
  (at-person ?p - person ?l - location)
  (in-taxi ?p - person)
)

(:action move
  :parameters (?t - taxi ?from - location ?to - location)
  :precondition (and
    (at ?t ?from)
    (not (occupied))
  )
  :effect (and
    (not (at ?t ?from))
    (at ?t ?to)
  )
)

(:action pickup
  :parameters (?p - person ?t - taxi ?loc - location)
  :precondition (and
    (at ?p ?loc)
    (at ?t ?loc)
    (not (in-taxi))
  )
  :effect (and
    (assign (in-taxi) true)
    (assign (occupied) true for ?t)
  )
)

(:action dropoff
  :parameters (?p - person ?t - taxi ?dest - location)
  :precondition (and
    (in-taxi)
    (at ?t ?dest)
  )
  :effect (and
    (not (in-taxi) )
    (assign (occupied) false for ?t)
    (assign (at) ?dest for ?p)
  )
))
