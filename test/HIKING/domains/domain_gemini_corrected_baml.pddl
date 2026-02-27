
(define (domain hiking-domain)
    (:requirements :typing) ; :fluents is often implied and not strictly needed for this structure

    (:types
        terrain goallocation - object
        hill waterbody - terrain
    )

    (:predicates
        ; Location predicates
        (at ?t - terrain)
        (connected ?from - terrain ?to - terrain)
        
        ; Goal state predicates
        (goal-is-at ?g - goallocation ?t - terrain)
        (is-reached ?g - goallocation)

        ; Terrain property predicates (These were missing)
        (is-walkable ?t - terrain)
        (is-climbable ?h - hill)
        (is-crossable ?w - waterbody)
    )

    (:action walk
        :parameters (?from - terrain ?to - terrain)
        :precondition (and 
            (at ?from)
            (connected ?from ?to)
            (is-walkable ?to)
        )
        :effect (and 
            (not (at ?from))
            (at ?to)
        )
    )

    (:action climb
        :parameters (?from - terrain ?to - hill)
        :precondition (and 
            (at ?from)
            (connected ?from ?to)
            (is-climbable ?to)
        )
        :effect (and 
            (not (at ?from))
            (at ?to)
        )
    )

    (:action cross
        :parameters (?from - terrain ?to - waterbody)
        :precondition (and 
            (at ?from)
            (connected ?from ?to)
            (is-crossable ?to)
        )
        :effect (and 
            (not (at ?from))
            (at ?to)
        )
    )

    (:action finish
        :parameters (?g - goallocation ?t - terrain)
        :precondition (and 
            (at ?t)
            (goal-is-at ?g ?t)
        )
        :effect (and 
            (is-reached ?g)
        )
    )
)