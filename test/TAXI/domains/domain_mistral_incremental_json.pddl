Here's the corrected and merged PDDL domain with proper syntax, balanced parentheses, and consistent naming:

```lisp
(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    taxi person location
  )
  (:predicates
    (isempty ?t - taxi)
    (intransit ?t - taxi)
    (intaxi ?p - person ?t - taxi)
    (atdestination ?p - person)
    (hastaxi ?l - location ?t - taxi)
    (hasperson ?l - location ?p - person)
  )
  (:functions
    (fuellevel ?t - taxi)
  )
  (:action drive
    :parameters (?t - taxi ?from - location ?to - location)
    :precondition (and (not (intransit ?t))
                       (hastaxi ?from ?t)
                       (not (hastaxi ?to ?t))
                       (> (fuellevel ?t) 0)
                       (isempty ?t))
    :effect (and (not (hastaxi ?from ?t))
                 (hastaxi ?to ?t)
                 (intransit ?t)
                 (decrease (fuellevel ?t) 1))
  )
  (:action arrive
    :parameters (?t - taxi ?l - location)
    :precondition (and (intransit ?t)
                       (hastaxi ?l ?t))
    :effect (and (not (intransit ?t))
                 (not (isempty ?t)))
  )
  (:action board
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and (hasperson ?l ?p)
                       (hastaxi ?l ?t)
                       (not (intransit ?t))
                       (not (intaxi ?p ?t))
                       (isempty ?t))
    :effect (and (not (hasperson ?l ?p))
                 (intaxi ?p ?t)
                 (not (isempty ?t)))
  )
  (:action alight
    :parameters (?p - person ?t - taxi ?l - location)
    :precondition (and (intaxi ?p ?t)
                       (hastaxi ?l ?t)
                       (not (intransit ?t)))
    :effect