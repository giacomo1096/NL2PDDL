
(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types robot agent container crane location harbor)

    (:predicates
        (at ?r - robot ?l - location)
        (loaded ?c - container)
        (clear ?l - location)
        (occupied ?l - location)
    )

    (:action move
        :parameters (?r - robot ?from - location ?to - location)
        :precondition (at ?r ?from)
        :effect (and
                 (not (at ?r ?from))
                 (at ?r ?to)
        )
    )

    (:action load
        :parameters (?r - robot ?c - container ?loc - location)
        :precondition (and
                       (at ?r ?loc)
                       (at ?c ?loc)
                       (not (loaded ?c))
        )
        :effect (loaded ?c)
    )

    (:action unload
        :parameters (?r - robot ?c - container ?loc - location)
        :precondition (and
                       (at ?r ?loc)
                       (at ?c ?loc)
                       (loaded ?c)
        )
        :effect (not (loaded ?c))
    )

    (:action move_crane
        :parameters (?cr - crane ?from - location ?to - location)
        :precondition (at ?cr ?from)
        :effect (and
                 (not (at ?cr ?from))
                 (at ?cr ?to)
        )
    )
)