
(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types 
        robot agent container crane location harbor
    )

    (:predicates
        (is-idle ?r - robot)
        (is-loaded ?c - container)
        (is-operational ?cr - crane)
        (has-dock ?l - location)
        (has-container ?l - location ?c - container)
    )

    (:functions
        (battery-level) - numeric
    )

    (:action move-robot
        :parameters (?r - robot ?from - location ?to - location)
        :precondition (and (is-idle ?r) (has-dock ?r ?from) (has-dock ?r ?to) (> (battery-level) 0))
        :effect (and (not (has-dock ?r ?from)) (has-dock ?r ?to) (decrease (battery-level) 1))
    )

    (:action load-container
        :parameters (?c - container ?cr - crane ?l - location)
        :precondition (and (is-operational ?cr) (has-dock ?cr ?l) (has-container ?l ?c) (not (is-loaded ?c)))
        :effect (and (not (has-container ?l ?c)) (is-loaded ?c))
    )

    (:action unload-container
        :parameters (?c - container ?cr - crane ?l - location)
        :precondition (and (is-operational ?cr) (has-dock ?cr ?l) (not (has-container ?l ?c)) (is-loaded ?c))
        :effect (and (has-container ?l ?c) (not (is-loaded ?c)))
    )
)