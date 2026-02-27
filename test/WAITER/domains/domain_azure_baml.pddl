(define (domain robotwaiter-domain)
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
    ;; robotwaiter predicates
    (at-robotwaiter-area ?r - robotwaiter ?a - area)
    (holding-plate ?r - robotwaiter)

    ;; area predicates
    (adjacent ?a1 - area ?a2 - area)

    ;; plate predicates
    (at-plate-area ?p - plate ?a - area)
    (held-by ?p - plate ?r - robotwaiter)
    (filled-with-food ?p - plate)

    ;; food predicates
    (at-food-buffet ?f - food ?b - buffet)
    (on-plate ?f - food ?p - plate)

    ;; buffet predicates
    (at-buffet-area ?b - buffet ?a - area)

    ;; customer predicates
    (at-customer-area ?c - customer ?a - area)
    (served ?c - customer)
  )

  (:action move
    :parameters (?r - robotwaiter ?from - area ?to - area)
    :precondition (and
      (at-robotwaiter-area ?r ?from)
      (adjacent ?from ?to)
    )
    :effect (and
      (not (at-robotwaiter-area ?r ?from))
      (at-robotwaiter-area ?r ?to)
    )
  )

  (:action pickup-plate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and
      (at-robotwaiter-area ?r ?a)
      (at-plate-area ?p ?a)
      (not (held-by ?p ?r))
      (not (holding-plate ?r))
    )
    :effect (and
      (held-by ?p ?r)
      (not (at-plate-area ?p ?a))
      (holding-plate ?r)
    )
  )

  (:action putdown-plate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and
      (at-robotwaiter-area ?r ?a)
      (held-by ?p ?r)
      (holding-plate ?r)
    )
    :effect (and
      (not (held-by ?p ?r))
      (at-plate-area ?p ?a)
      (not (holding-plate ?r))
    )
  )

  (:action fill-plate-with-food
    :parameters (?r - robotwaiter ?p - plate ?f - food ?b - buffet ?a - area)
    :precondition (and
      (at-robotwaiter-area ?r ?a)
      (at-buffet-area ?b ?a)
      (held-by ?p ?r)
      (not (filled-with-food ?p))
      (at-food-buffet ?f ?b)
    )
    :effect (and
      (filled-with-food ?p)
      (on-plate ?f ?p)
      (not (at-food-buffet ?f ?b))
    )
  )

  (:action serve-customer
    :parameters (?r - robotwaiter ?p - plate ?c - customer ?a - area)
    :precondition (and
      (at-robotwaiter-area ?r ?a)
      (at-customer-area ?c ?a)
      (held-by ?p ?r)
      (filled-with-food ?p)
    )
    :effect (and
      (served ?c)
      (not (held-by ?p ?r))
      (not (holding-plate ?r))
      (at-plate-area ?p ?a)
    )
  )
)