(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types
        block
        table
        roboticarm
    )

    (:predicates
        (free ?b - block)
        (on-table ?b - block)
        (on ?b1 - block ?b2 - block)
        (has-block ?t - table ?b - block)
        (holding ?r - roboticarm ?b - block)
    )

    (:action pick-up
        :parameters (?r - roboticarm ?b - block)
        :precondition (and (free ?b) (on-table ?b) (not (holding ?r ?b)))
        :effect (and (not (on-table ?b)) (holding ?r ?b))
    )

    (:action put-down
        :parameters (?r - roboticarm ?b - block)
        :precondition (holding ?r ?b)
        :effect (and (not (holding ?r ?b)) (on-table ?b))
    )

    (:action stack
        :parameters (?r - roboticarm ?b1 - block ?b2 - block)
        :precondition (and (holding ?r ?b1) (free ?b2) (on-table ?b2))
        :effect (and (not (holding ?r ?b1)) (not (on-table ?b2)) (on ?b1 ?b2))
    )

    (:action unstack
        :parameters (?r - roboticarm ?b1 - block ?b2 - block)
        :precondition (and (holding ?r ?b1) (on ?b1 ?b2))
        :effect (and (not (holding ?r ?b1)) (on-table ?b2))
    )
)