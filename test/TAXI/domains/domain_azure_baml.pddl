(define (domain taxi-domain)
  (:requirements :strips :typing)
  (:types taxi person location)

  (:predicates
    (at ?x - (either taxi person) ?l - location)
    (occupied ?t - taxi)
    (in-taxi ?p - person)
  )

  (:action move
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (at ?t ?from)
    :effect (and
      (not (at ?t ?from))
      (at ?t ?to)
    )
  )

  (:action board
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (at ?p ?l)
      (at ?t ?l)
      (not (in-taxi ?p))
    )
    :effect (and
      (not (at ?p ?l))
      (in-taxi ?p)
      (occupied ?t)
    )
  )

  (:action alight
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (in-taxi ?p)
      (at ?t ?l)
    )
    :effect (and
      (at ?p ?l)
      (not (in-taxi ?p))
    )
  )

  (:action update-taxi-occupied-empty
    :parameters (?t - taxi)
    :precondition (and
      (occupied ?t)
      (forall (?p - person) (not (in-taxi ?p)))
    )
    :effect (not (occupied ?t))
  )
)