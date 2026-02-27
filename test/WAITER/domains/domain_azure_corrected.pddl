(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types agent robot waiter area plate food buffet customer)
  
  (:predicates
    (moving ?a - agent)
    (has-plate ?r - robot)
    (serving-customer ?w - waiter)
    (adjacent ?a1 - area ?a2 - area)
    (held ?p - plate)
    (filled ?f - food)
    (has-food ?b - buffet)
    (served ?c - customer)
  )

  (:functions
    (battery-level ?r - robot)
  )

  (:action move-between-areas
    :parameters (?a - agent ?from - area ?to - area)
    :precondition (and (moving ?a) (adjacent ?from ?to))
    :effect (and (not (moving ?a)) (not (at ?a ?from)) (at ?a ?to))
  )

  (:action pick-up-plate
    :parameters (?r - robot ?p - plate)
    :precondition (and (not (has-plate ?r)) (held ?p))
    :effect (and (has-plate ?r) (not (held ?p))
  ))

  (:action fill-plate
    :parameters (?r - robot ?p - plate ?f - food ?b - buffet)
    :precondition (and (has-plate ?r) (held ?p) (has-food ?b) (not (filled ?f)))
    :effect (and (filled ?f))
  )

  (:action serve-customer
    :parameters (?w - waiter ?c - customer)
    :precondition (and (serving-customer ?w) (served ?c))
    :effect (and (not (serving-customer ?w)) (served ?c))
  )
)