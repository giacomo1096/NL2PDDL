(define (domain taxi_simplest2)

    (:requirements :strips :equality :typing :conditional-effects :negative-preconditions)

    (:types 
        taxi
        location
        person
    )

    (:predicates 
        (plocation ?p - person ?l - location)  
        (tlocation ?t - taxi ?l - location)   
        (inTaxi ?p - person ?t - taxi) 
        (connects ?l1 - location ?l2)  
        (empty ?t - taxi) 

    )

    (:action get_in
        :parameters (?p - person ?t - taxi ?l - location)
        :precondition (and
            (plocation ?p ?l)
            (tlocation ?t ?l)
            (not (inTaxi ?p ?t))
            (empty ?t)
         )
        :effect (and 
            (inTaxi ?p ?t)
            (not (plocation ?p ?l))
            (not (empty ?t))
        )
    )

    (:action get_out
        :parameters (?p - person ?t - taxi ?l - location)
        :precondition (and 
            (inTaxi ?p ?t)
            (tlocation ?t ?l)
            (not (empty ?t))
        )
        :effect (and 
            (not (inTaxi ?p ?t))
            (plocation ?p ?l)
            (empty ?t)
        )
    )

    (:action move
    :parameters (?t - taxi ?l1 - location ?l2 - location)
    :precondition (and 
        (tlocation ?t ?l1)
        (connects ?l1 ?l2)
    )
    :effect (and 
        (not (tlocation ?t ?l1)) 
        (tlocation ?t ?l2)
    )
)

)