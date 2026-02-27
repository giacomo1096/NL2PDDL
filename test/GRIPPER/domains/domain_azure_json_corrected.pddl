
(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types
        object
        room
        robot
    )

    (:predicates
        (has-gripper ?r - robot)
        (equipped-with-gripper ?r - robot)
        (requires-fixing ?o - object)
        (contains-object ?r - room ?o - object)
        (robot-at ?r - robot ?loc - room)
        (battery-level ?r - robot)
    )

    (:action navigate
        :parameters (?r - robot ?from - room ?to - room)
        :precondition (and (robot-at ?r ?from) (contains-object ?from ?o) (equipped-with-gripper ?r))
        :effect (and (not (robot-at ?r ?from)) (robot-at ?r ?to) (decrease (battery-level ?r) 1))
    )

    (:action fix_object
        :parameters (?r - robot ?o - object)
        :precondition (and (robot-at ?r ?loc) (contains-object ?loc ?o) (requires-fixing ?o) (equipped-with-gripper ?r))
        :effect (and (not (requires-fixing ?o)) (not (contains-object ?loc ?o)))
    )
)