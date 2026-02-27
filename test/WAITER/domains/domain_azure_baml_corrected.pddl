(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types agent robot waiter area plate food buffet customer)

    (:predicates
        (at ?r - robot ?l - area)
        (holding-plate ?r - robot)
        (battery ?r - robot)
        (filled ?p - plate)
        (at ?p - plate ?l - area)
        (adjacent ?l - area)
        (served ?c - customer)
    )

    (:action move
        :parameters (?r - robot ?from - area ?to - area)
        :precondition (and
            (at ?r ?from)
            (at ?to ?from)
            (> (battery ?r) 0)
        )
        :effect (and
            (not (at ?r ?from))
            (at ?r ?to)
            (decrease (battery ?r) 1)
        )
    )

    (:action pickup
        :parameters (?r - robot ?p - plate ?loc - area)
        :precondition (and
            (at ?r ?loc)
            (at ?p ?loc)
            (not (holding-plate ?r))
        )
        :effect (and
            (assign (holding-plate ?r) true)
            (not (at ?p ?loc))
        )
    )

    (:action fill-plate
        :parameters (?r - robot ?p - plate ?f - food ?loc - area)
        :precondition (and
            (holding-plate ?r)
            (at ?p ?loc)
            (not (filled ?p))
        )
        :effect (assign (filled ?p) true)
    )

    (:action serve
        :parameters (?r - robot ?c - customer ?p - plate ?loc - area)
        :precondition (and
            (holding-plate ?r)
            (at ?c ?loc)
            (filled ?p)
        )
        :effect (and
            (assign (holding-plate ?r) false)
            (assign (served ?c) true)
        )
    )
)