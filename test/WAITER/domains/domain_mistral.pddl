
(define (domain robot-waiter)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    robotwaiter area plate food customer buffet
  )

  ;; Predicates
  (:predicates
    (is-holding-plate ?r - robotwaiter ?p - plate)
    (is-at ?r - robotwaiter ?a - area)
    (is-empty ?r - robotwaiter)
    (is-adjacent ?a1 - area ?a2 - area)
    (has-buffet ?a - area ?b - buffet)
    (has-customer ?a - area ?c - customer)
    (is-empty-plate ?p - plate)
    (is-filled ?p - plate ?f - food)
    (is-served ?p - plate ?c - customer)
    (is-available ?f - food ?b - buffet)
    (is-served-customer ?c - customer)
    (has-order ?c - customer ?f - food)
  )

  ;; Functions (Fluents)
  (:functions
    (battery-level ?r - robotwaiter)
  )

  ;; Actions
  (:action move
    :parameters (?r - robotwaiter ?from - area ?to - area)
    :precondition (and
      (is-at ?r ?from)
      (is-adjacent ?from ?to)
      (> (battery-level ?r) 0)
    )
    :effect (and
      (not (is-at ?r ?from))
      (is-at ?r ?to)
      (decrease (battery-level ?r) 1)
    )
  )

  (:action pick-up-plate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and
      (is-at ?r ?a)
      (is-empty ?r)
      (is-empty-plate ?p)
    )
    :effect (and
      (not (is-empty ?r))
      (is-holding-plate ?r ?p)
      (not (is-empty-plate ?p))
    )
  )

  (:action fill-plate
    :parameters (?r - robotwaiter ?p - plate ?f - food ?b - buffet ?a - area)
    :precondition (and
      (is