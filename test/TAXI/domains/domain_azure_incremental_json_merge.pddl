(define (domain mydomain)
(:requirements :typing :fluents)
(:types vehicle location person)
(:types taxi vehicle)

(:predicates
  (is-moving)
  (is-occupied)
  (has-taxi)
  (is-in-taxi))

(:action move-vehicle
  :parameters (?v - vehicle ?from - location ?to - location)
  :precondition (and (has-taxi ?from) (is-moving ?v) (not (is-occupied ?v)))
  :effect (and (not (has-taxi ?from)) (has-taxi ?to))
)

(:action board-person
  :parameters (?p - person ?t - taxi ?l - location)
  :precondition (and (is-in-taxi ?p) (has-taxi ?l) (not (is-occupied ?t)))
  :effect (and (not (is-in-taxi ?p)) (is-occupied ?t)
))

(:action disembark-person
  :parameters (?p - person ?t - taxi ?l - location)
  :precondition (and (is-occupied ?t) (has-taxi ?l) (not (is-in-taxi ?p)))
  :effect (and (is-in-taxi ?p) (not (is-occupied ?t))
)))
