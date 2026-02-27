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
    (is-holding-plate ?r - robotwaiter)
    (is-adjacent ?a1 - area ?a2 - area)
    (is-filled ?p - plate)
    (is-held-by-robot ?p - plate)
    (is-available ?f - food)
    (has-food ?b - buffet)
    (is-served ?c - customer)
    (is-waiting ?c - customer)
  )

  (:action move
    :parameters (?r - robotwaiter ?from - area ?to - area)
    :precondition (is-adjacent ?from ?to)
    :effect ()
  )

  (:action pick-up-plate
    :parameters (?r - robotwaiter ?p - plate)
    :precondition (and
      (not (is-holding-plate ?r))
      (not (is-held-by-robot ?p))
    )
    :effect (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
    )
  )

  (:action put-down-plate
    :parameters (?r - robotwaiter ?p - plate)
    :precondition (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
    )
    :effect (and
      (not (is-holding-plate ?r))
      (not (is-held-by-robot ?p))
    )
  )

  (:action fill-plate
    :parameters (?r - robotwaiter ?p - plate ?f - food ?b - buffet)
    :precondition (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
      (not (is-filled ?p))
      (is-available ?f)
      (has-food ?b)
    )
    :effect (is-filled ?p)
  )

  (:action serve-customer
    :parameters (?r - robotwaiter ?p - plate ?c - customer)
    :precondition (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
      (is-filled ?p)
      (is-waiting ?c)
      (not (is-served ?c))
    )
    :effect (and
      (is-served ?c)
      (not (is-waiting ?c))
      (not (is-filled ?p))
    )
  )
)