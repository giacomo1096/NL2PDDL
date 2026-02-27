(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types agent area robot plate food buffet customer)
    (:predicates
        (is-moving ?a - agent)
        (has-plate ?r - robot)
        (serving-customer ?w - waiter)
        (adjacent ?a1 - area ?a2 - area)
        (is-held ?p - plate)
        (is-filled ?f - food)
        (has-food ?b - buffet)
        (is-served ?c - customer)
        (at ?a - area ?to - area)
    )
    (:action move-between-areas
        :parameters (?a - agent ?from - area ?to - area)
        :precondition (and (is-moving ?a) (adjacent ?from ?to))
        :effect (and (not (is-moving ?a)) (not (at ?a ?from)) (at ?a ?to))
    )

    (:action pick-up-plate
        :parameters (?r - robot ?p - plate)
        :precondition (and (not (has-plate ?r)) (is-held ?p))
        :effect (and (has-plate ?r) (not (is-held ?p))
    ))

    (:action fill-plate
        :parameters (?r - robot ?p - plate ?f - food ?b - buffet)
        :precondition (and (has-plate ?r) (is-held ?p) (has-food ?b) (not (is-filled ?f)))
        :effect (and (is-filled ?f)
    ))

    (:action serve-customer
        :parameters (?w - waiter ?c - customer)
        :precondition (and (serving-customer ?w) (is-served ?c))
        :effect (and (not (serving-customer ?w)) (is-served ?c)
    ))
)