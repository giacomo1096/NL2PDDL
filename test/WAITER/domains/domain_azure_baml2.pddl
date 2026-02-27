(define (domain restaurantwaiter)
  (:requirements :strips :typing)

  (:types
    robotwaiter
    area
    plate
    food
    buffet
    customer
  )

  (:predicates
    (at-robotwaiter-area ?r - robotwaiter ?a - area)
    (holding-plate ?r - robotwaiter)
    (adjacent ?a1 - area ?a2 - area)
    (at-plate-area ?p - plate ?a - area)
    (held-by ?p - plate ?r - robotwaiter)
    (filled-with-food ?p - plate)
    (at-food-buffet ?f - food ?b - buffet)
    (on-plate ?f - food ?p - plate)
    (at-buffet-area ?b - buffet ?a - area)
    (at-customer-area ?c - customer ?a - area)
    (served ?c - customer)
  )

  (:action move
    :parameters (?r - robotwaiter ?from - area ?to - area)
    :precondition (and (at-robotwaiter-area ?r ?from) (adjacent ?from ?to))
    :effect (and (not (at-robotwaiter-area ?r ?from)) (at-robotwaiter-area ?r ?to))
  )

  (:action pickup-plate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and (at-robotwaiter-area ?r ?a) (at-plate-area ?p ?a) (not (held-by ?p ?r)) (not (holding-plate ?r)))
    :effect (and (held-by ?p ?r) (not (at-plate-area ?p ?a)) (holding-plate ?r))
  )

  (:action putdown-plate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and (at-robotwaiter-area ?r ?a) (held-by ?p ?r) (holding-plate ?r))
    :effect (and (not (held-by ?p ?r)) (at-plate-area ?p ?a) (not (holding-plate ?r)))
  )

  (:action fill-plate-with-food
    :parameters (?r - robotwaiter ?p - plate ?f - food ?b - buffet ?a - area)
    :precondition (and (held-by ?p ?r) (at-robotwaiter-area ?r ?a) (at-buffet-area ?b ?a) (at-food-buffet ?f ?b) (not (filled-with-food ?p)))
    :effect (and (on-plate ?f ?p) (filled-with-food ?p) (not (at-food-buffet ?f ?b)))
  )

  (:action serve-customer
    :parameters (?r - robotwaiter ?p - plate ?f - food ?c - customer ?a - area)
    :precondition (and (held-by ?p ?r) (filled-with-food ?p) (on-plate ?f ?p) (at-robotwaiter-area ?r ?a) (at-customer-area ?c ?a) (not (served ?c)))
    :effect (and (served ?c) (not (held-by ?p ?r)) (not (holding-plate ?r)) (at-plate-area ?p ?a))
  )
)