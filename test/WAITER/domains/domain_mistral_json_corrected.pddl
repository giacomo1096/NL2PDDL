Here's the corrected PDDL domain file with all syntax errors fixed, balanced parentheses, proper keyword prefixes, and consistent parameter usage:

```pddl
(define (domain restaurant_domain)
  (:requirements :typing :fluents :action-costs)

  (:types
    robotwaiter area plate food customer - object
    buffet - area
  )

  (:predicates
    (is-holding-plate ?r - robotwaiter ?p - plate)
    (is-at ?r - robotwaiter ?a - area)
    (is-empty-robotwaiter ?r - robotwaiter)
    (is-adjacent ?a1 - area ?a2 - area)
    (has-buffet ?a - area)
    (has-customer ?a - area ?c - customer)
    (is-empty-plate ?p - plate)
    (is-filled-plate ?p - plate ?f - food)
    (is-served-plate ?p - plate ?c - customer)
    (is-available-food ?f - food ?b - buffet)
    (is-served-customer ?c - customer)
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
    :precondition (and (is-at ?r ?a) (not (is-holding-plate ?r ?p)) (is-empty-plate ?p) (is-empty-robotwaiter ?r))
    :effect (and (is-holding-plate ?r ?p) (not (is-empty-robotwaiter ?r)) (not (is-empty-plate ?p)))
  )

  (:action put-down-plate
    :parameters (?r -