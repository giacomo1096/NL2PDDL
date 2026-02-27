(define (domain robot_waiter_2)

    (:requirements :strips :typing :disjunctive-preconditions :negative-preconditions)

    (:types
        entity area - object
        robot plate buffet costumer - entity
    )

    (:predicates
        (adjacent ?a1 - area ?a2 - area) 
        (has_food ?p - plate) 
        (served ?c - costumer) 
        (holding ?p - plate ?r - robot) 
        (hands_full)                        
        (at ?o - entity ?a - area) 
    )

    (:action move 
        :parameters (?a1 - area ?a2 - area ?r - robot)
        :precondition (and
            (at ?r ?a1)
            (or (adjacent ?a1 ?a2) (adjacent ?a2 ?a1))
        )
        :effect (and
            (not (at ?r ?a1))
            (at ?r ?a2)
        )
    )

    (:action pick_up 
        :parameters (?p - plate ?a - area ?r -robot)
        :precondition (and
            (at ?r ?a)
            (at ?p ?a)
            (not (hands_full))
        )
        :effect (and
            (holding ?p ?r)
            (hands_full)
            (not (at ?p ?a))
        )
    )

    (:action present 
        :parameters (?p - plate ?c - costumer ?a - area ?r - robot)
        :precondition (and
            (holding ?p ?r)
            (has_food ?p)
            (at ?r ?a)
            (at ?c ?a)
            (not (served ?c))
        )
        :effect (and
            (served ?c)
            (not (holding ?p ?r))
            (not (hands_full))
        )
    )

    (:action fill 
        :parameters (?p - plate ?a - area ?r - robot ?b - buffet)
        :precondition (and
            (holding ?p ?r)
            (not (has_food ?p))
            (at ?r ?a)
            (at ?b ?a)
        )
        :effect (and
            (has_food ?p)
        )
    )
)