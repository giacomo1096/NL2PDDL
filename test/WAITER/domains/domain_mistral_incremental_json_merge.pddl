(define (domain restaurant_domain)
  (:requirements :typing :fluents)

  (:types
    robotwaiter area plate food customer - object
    buffet - area
  )


(:predicates
	(is-holding-plate-robotwaiter ?r - robotwaiter ?p - plate)
	(is-at-robotwaiter ?r - robotwaiter ?a - area)
	(is-empty-robotwaiter ?r - robotwaiter)
	(is-adjacent-area ?a1 - area ?a2 - area)
	(has-buffet-area ?a - area)
	(has-customer-area ?c - customer ?a - area)
	(is-empty-plate ?p - plate)
	(is-filled-plate ?p - plate ?f - food)
	(is-served-plate ?p - plate ?c - customer)
	(is-available-food ?f - food ?b - buffet)
	(is-served-customer ?c - customer)
	(has-order-customer ?c - customer ?f - food)
	(has-food-buffet ?b - buffet ?f - food)
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
  :precondition (and (is-at ?r ?a) (has-buffet ?a) (is-holding-plate ?r ?p) (is-available ?f ?b) (is-empty ?p))
  :effect (and (is-filled ?p ?f) (not (is-empty ?p)) (not (is-available ?f ?b)))
)

(:action serve-plate
  :parameters (?r - robotwaiter ?p - plate ?c - customer ?a - area)
  :precondition (and (is-at ?r ?a) (has-customer ?a ?c) (is-holding-plate ?r ?p) (not (is-empty ?p)) (has-order ?c ?f) (is-filled ?p ?f))
  :effect (and (not (is-holding-plate ?r ?p)) (is-empty ?r) (is-served ?p ?c))))
