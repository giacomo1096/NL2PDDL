(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robotwaiter area plate food customer buffet
  )

(:predicates
    (is-holding-plate ?r - robotwaiter ?p - plate)
    (is-at ?r - robotwaiter ?a - area)
    (is-empty ?r - robotwaiter)
    (is-adjacent ?a1 - area ?a2 - area)
    (has-buffet ?a - area)
    (has-customer ?a - area ?c - customer)
    (is-empty ?p - plate)
    (is-filled ?p - plate ?f - food)
    (is-served ?p - plate ?c - customer)
    (is-available ?f - food ?b - buffet)
    (is-served ?c - customer)
    (has-order ?c - customer ?f - food)
    (has-food ?b - buffet ?f - food)
)

(:functions
    (battery-level ?r - robotwaiter)
)


(:action move
  :parameters (?r - robotwaiter ?from - area ?to - area)
  :precondition (and (is-at ?r ?from) (is-adjacent ?from ?to) (> (battery-level ?r) 0))
  :effect (and (not (is-at ?r ?from)) (is-at ?r ?to) (decrease (battery-level ?r) 1))
)

(:action pick-up-plate
  :parameters (?r - robotwaiter ?p - plate ?a - area)
  :precondition (and (is-at ?r ?a) (not (is-holding-plate ?r ?p)) (is-empty ?p) (is-empty ?r))
  :effect (and (is-holding-plate ?r ?p) (not (is-empty ?r)) (not (is-empty ?p)))
)

(:action put-down-plate
  :parameters (?r - robotwaiter ?p - plate ?a - area)
  :precondition (and (is-at ?r ?a) (is-holding-plate ?r ?p))
  :effect (and (not (is-holding-plate ?r ?p)) (is-empty ?r) (is-empty ?p) (is-at ?p ?a))
)

(:action fill-plate
  :parameters (?r - robotwaiter ?p - plate ?f - food ?b - buffet ?a - area)
  :precondition (and (is-at ?r ?a) (has-buffet ?a) (is-holding-plate ?r ?p) (is-empty ?p) (is-available ?f ?b) (has-food ?b ?f))
  :effect (and (not (is-empty ?p)) (is-filled ?p ?f) (not (is-available ?f ?b)))
)

(:action serve-customer
  :parameters (?r - robotwaiter ?p - plate ?f - food ?c - customer ?a - area)
  :precondition (and (is-at ?r ?a) (is-holding-plate ?r ?p) (is-filled ?p ?f) (has-customer ?a ?c) (has-order ?c ?f) (not (is-served ?c)))
  :effect (and (not (is-filled ?p ?f)) (is )
