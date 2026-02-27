(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types
        agent
        robot
        gripper
        object
        room
    )
    (:predicates
        (at ?r - robot ?l - room)
        (has-gripper ?r - robot)
        (fixing ?r - robot)
        (fixed ?o - object)
        (at ?o - object ?l - room)
    )
    (:action navigate
        :parameters (?r - robot ?from - room ?to - room)
        :precondition (at ?r ?from)
        :effect (and
                 (not (at ?r ?from))
                 (at ?r ?to)
        )
    )
    (:action pick-up
        :parameters (?r - robot ?o - object ?loc - room)
        :precondition (and
                       (at ?r ?loc)
                       (at ?o ?loc)
                       (has-gripper ?r)
        )
        :effect (and
                 (fixing ?r)
                 (not (at ?o ?loc))
        )
    )
    (:action fix
        :parameters (?r - robot ?o - object)
        :precondition (and
                       (fixing ?r)
                       (at ?o ?loc)
        )
        :effect (fixed ?o)
    )
)