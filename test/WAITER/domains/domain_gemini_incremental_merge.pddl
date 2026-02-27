(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robot
    area
    plate
    food
    customer
    buffet - area
  )

(:predicates
    (hand-empty ?r - robot)
    (is-full ?p - plate)
    (is-waiting ?c - customer)
    (food-available ?b - buffet)
)

(:action move
    :parameters (?r - robot ?from - area ?to - area)
    :precondition (and
        (robot-at ?r ?from)
        (adjacent ?from ?to)
    )
    :effect (and
        (not (robot-at ?r ?from))
        (robot-at ?r ?to)
    )
)
(:action pick-up
    :parameters (?r - robot ?p - plate ?a - area)
    :precondition (and
        (robot-at ?r ?a)
        (plate-at ?p ?a)
        (hand-empty ?r)
    )
    :effect (and
        (not (plate-at ?p ?a))
        (not (hand-empty ?r))
        (holding ?r ?p)
    )
)
(:action fill-plate
    :parameters (?r - robot ?p - plate ?b - buffet)
    :precondition (and
        (robot-at ?r ?b)
        (holding ?r ?p)
        (not (is-full ?p))
        (food-available ?b)
    )
    :effect (and
        (is-full ?p)
    )
)
(:action serve
    :parameters (?r - robot ?p - plate ?c - customer ?a - area)
    :precondition (and
        (robot-at ?r ?a)
        (customer-at ?c ?a)
        (holding ?r ?p)
        (is-full ?p)
        (is-waiting ?c)
    )
    :effect (and
        (not (is-waiting ?c))
        (not (holding ?r ?p))
        (not (is-full ?p))
        (hand-empty ?r)
        (plate-at ?p ?a)
    )
))
