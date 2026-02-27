(define (domain taxi)
  (:requirements :strips :typing)

  (:types
    taxi
    person
    location
  )

  (:predicates
    (at ?t - taxi ?l - location)
    (at-person ?p - person ?l - location)
    (occupied ?t - taxi)
    (in-taxi ?p - person ?t - taxi)
  )

  (:action move
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (and (at ?t ?from))
    :effect (and (not (at ?t ?from)) (at ?t ?to))
  )

  (:action board
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and (at-person ?p ?l) (at ?t ?l) (not (in-taxi ?p ?t)))
    :effect (and (not (at-person ?p ?l)) (in-taxi ?p ?t) (occupied ?t))
  )

  (:action alight
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and (in-taxi ?p ?t) (at ?t ?l))
    :effect (and (at-person ?p ?l) (not (in-taxi ?p ?t)))
  )

  (:action update-taxi-occupied-empty
    :parameters (?t - taxi)
    :precondition (and (occupied ?t)
      (forall (?p - person) (not (in-taxi ?p ?t)))
    )
    :effect (and (not (occupied ?t)))
  )
)