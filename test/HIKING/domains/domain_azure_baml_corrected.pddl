
(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types terrain location action)
    
    (:predicates
        (terrain ?loc - location)
        (hill ?loc - location)
        (waterbody ?loc - location)
        (location ?loc - location)
        (action ?act - action)
        (walk ?loc - location ?dest - location)
        (climb ?loc - location ?dest - location)
    )

    (:action walk
        :parameters (?loc - location ?dest - location)
        :precondition ()
        :effect (and
                 (not (at ?loc))
                 (at ?dest ?loc)
        )
    )

    (:action climb
        :parameters (?loc - location ?dest - location)
        :precondition ()
        :effect (and
                 (not (at ?loc))
                 (at ?dest ?loc)
        )
    )
)