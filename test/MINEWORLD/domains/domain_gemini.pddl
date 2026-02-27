(define (domain minebot-world)
    (:requirements :strips :typing)

    (:types
        minebot cell item lift rock ore - object
    )

    (:predicates
        (at ?obj - object ?c - cell)
        (connected ?c1 - cell ?c2 - cell)
        (empty-hand ?m - minebot)
        (holding ?m - minebot ?i - item)
        (is-blocked ?c - cell)
        (is-broken ?r - rock)
        (is-mined ?o - ore)
        (is-on-ground ?i - item)
        (is-at-top-level ?l - lift)
    )

    (:action move
        :parameters (?m - minebot ?from - cell ?to - cell)
        :precondition (and
            (at ?m ?from)
            (connected ?from ?to)
            (not (is-blocked ?to))
        )
        :effect (and
            (not (at ?m ?from))
            (at ?m ?to)
        )
    )

    (:action pick-up
        :parameters (?m - minebot ?i - item ?c - cell)
        :precondition (and
            (at ?m ?c)
            (at ?i ?c)
            (is-on-ground ?i)
            (empty-hand ?m)
        )
        :effect (and
            (not (empty-hand ?m))
            (holding ?m ?i)
            (not (is-on-ground ?i))
            (not (at ?i ?c))
        )
    )

    (:action put-down
        :parameters (?m - minebot ?i - item ?c - cell)
        :precondition (and
            (at ?m ?c)
            (holding ?m ?i)
        )
        :effect (and
            (not (holding ?m ?i))
            (empty-hand ?m)
            (is-on-ground ?i)
            (at ?i ?c)
        )
    )

    (:action use-lift-to-top
        :parameters (?m - minebot ?l - lift ?c - cell)
        :precondition (and
            (at ?m ?c)
            (at ?l ?c)
            (not (is-at-top-level ?l))
        )
        :effect (and
            (is-at-top-level ?l)
        )
    )

    (:action use-lift-to-bottom
        :parameters (?m - minebot ?l - lift ?c - cell)
        :precondition (and
            (at ?m ?c)
            (at ?l ?c)
            (is-at-top-level ?l)
        )
        :effect (and
            (not (is-at-top-level ?l))
        )
    )

    (:action break-rock
        :parameters (?m - minebot ?r - rock ?c - cell)
        :precondition (and
            (at ?m ?c)
            (at ?r ?c)
            (is-blocked ?c)
            (not (is-broken ?r))
        )
        :effect (and
            (not (is-blocked ?c))
            (is-broken ?r)
        )
    )

    (:action mine-ore
        :parameters (?m - minebot ?o - ore ?c - cell)
        :precondition (and
            (at ?m ?c)
            (at ?o ?c)
            (not (is-mined ?o))
        )
        :effect (and
            (is-mined ?o)
        )
    )
)