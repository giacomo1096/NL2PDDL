
(define (domain taxi-domain)
  (:requirements :strips :typing)
  
  (:types
    taxi
    person
    location
  )
  
  (:predicates
    (at-location ?x - (either taxi person) ?l - location)
    (occupied ?t - taxi)
    (in-taxi ?p - person ?t - taxi)
    (is-destination ?l - location ?p - person)
  )
  
  (:action move
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (at-location ?t ?from)
    :effect (and
      (not (at-location ?t ?from))
      (at-location ?t ?to)
    )
  )
  
  (:action board
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (at-location ?p ?l)
      (at-location ?t ?l)
      (not (in-taxi ?p ?t))
      (not (occupied ?t))
    )
    :effect (and
      (not (at-location ?p ?l))
      (in-taxi ?p ?t)
      (occupied ?t)
    )
  )
  
  (:action disembark
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and
      (in-taxi ?p ?t)
      (at-location ?t ?l)
    )
    :effect (and
      (not (in-taxi ?p ?t))
      (at-location ?p ?l)
      (not (occupied ?t))
    )
  )
)
