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
        (battery-level ?r - robot)
    )
    (:action move-robot
        :parameters (?r - robot ?from - location ?to - location)
        :precondition (and (is-idle ?r) (has-dock ?from) (has-dock ?to) (> (battery-level ?r) 0))
        :effect (and (not (has-dock ?from)) (has-dock ?to) (decrease (battery-level ?r) 1))
    )
    (:action load-container
        :parameters (?c - container ?cr - crane ?l - location)
        :precondition (and (is-operational ?cr) (has-dock ?l) (has-container ?l ?c) (not (is-loaded ?c)))
        :effect (and (not (has-container ?l ?c)) (is-loaded ?c))
    )
    (:action unload-container
        :parameters (?c - container ?cr - crane ?l - location)
        :precondition (and (is-operational ?cr) (has-dock ?l) (not (has-container ?l ?c)) (is-loaded ?c))
        :effect (and (has-container ?l ?c) (not (is-loaded ?c))
    ))
)