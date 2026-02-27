Here's the corrected PDDL domain file with balanced parentheses, proper syntax, and all required elements:

```lisp
(define (domain restaurant)
  (:requirements :typing :fluents :equality)

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
    :effect (