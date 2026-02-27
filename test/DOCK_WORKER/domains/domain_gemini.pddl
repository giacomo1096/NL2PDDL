(define (domain dockyard-logistics)
    (:requirements :typing)

    (:types
        location container crane - object
        robot - object
        dockworkerrobot - robot
    )

    (:predicates
        ; Robot / Dockworker Robot predicates
        (is-at ?r - robot ?l - location)
        (is-unloaded ?dr - dockworkerrobot)
        (is-carrying ?dr - dockworkerrobot ?c - container)

        ; Crane predicates
        (crane-at ?cr - crane ?l - location)
        (is-available ?cr - crane)
        (is-lifting ?cr - crane ?c - container)

        ; Container predicates
        (located-in ?c - container ?l - location)
    )

    (:action move
        :parameters (?r - robot ?from - location ?to - location)
        :precondition (and
            (is-at ?r ?from)
        )
        :effect (and
            (not (is-at ?r ?from))
            (is-at ?r ?to)
        )
    )

    (:action lift
        :parameters (?cr - crane ?c - container ?l - location)
        :precondition (and
            (crane-at ?cr ?l)
            (located-in ?c ?l)
            (is-available ?cr)
        )
        :effect (and
            (not (is-available ?cr))
            (is-lifting ?cr ?c)
            (not (located-in ?c ?l))
        )
    )

    (:action drop
        :parameters (?cr - crane ?c - container ?l - location)
        :precondition (and
            (crane-at ?cr ?l)
            (is-lifting ?cr ?c)
        )
        :effect (and
            (is-available ?cr)
            (not (is-lifting ?cr ?c))
            (located-in ?c ?l)
        )
    )

    (:action load
        :parameters (?dr - dockworkerrobot ?c - container ?cr - crane ?l - location)
        :precondition (and
            (is-at ?dr ?l)
            (crane-at ?cr ?l)
            (is-lifting ?cr ?c)
            (is-unloaded ?dr)
        )
        :effect (and
            (is-available ?cr)
            (not (is-lifting ?cr ?c))
            (not (is-unloaded ?dr))
            (is-carrying ?dr ?c)
        )
    )

    (:action unload
        :parameters (?dr - dockworkerrobot ?c - container ?cr - crane ?l - location)
        :precondition (and
            (is-at ?dr ?l)
            (is-carrying ?dr ?c)
            (crane-at ?cr ?l)
            (is-available ?cr)
        )
        :effect (and
            (not (is-carrying ?dr ?c))
            (is-unloaded ?dr)
            (not (is-available ?cr))
            (is-lifting ?cr ?c)
        )
    )
)