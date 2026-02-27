(define (domain screw)
    (:requirements :strips)

    (:predicates
        (ROOM ?r) (OBJECTS ?o) (GRIPPER ?g)
        (rob_room ?r) (obj_room ?r ?o)
        (fixed_obj ?o) (can_fix ?o ?g)

    )

    (:action move
        :parameters (?from ?to)
        :precondition (and 
            (ROOM ?from) (ROOM ?to)
            (rob_room ?from)
        )
        :effect (and
            (not (rob_room ?from))
            (rob_room ?to)
        )
    )

    (:action fix_obj
        :parameters (?o ?r ?g)
        :precondition (and 
            (OBJECTS ?o) (ROOM ?r) (GRIPPER ?g) (not (fixed_obj ?o))
            (rob_room ?r) (obj_room ?r ?o) (can_fix ?o ?g)
        )
        :effect (and
            (fixed_obj ?o)
        )
    )

)