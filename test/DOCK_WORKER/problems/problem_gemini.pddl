(define (problem dockyard-logistics-problem-1)
    (:domain dockyard-logistics)

    (:objects
        PierA PierB Warehouse - location
        C1 - container
        craneA craneW - crane
        Roby - dockworkerrobot
    )

    (:init
        ; Robot's initial state
        (is-at Roby PierA)
        (is-unloaded Roby)

        ; Container's initial state
        (located-in C1 PierA)

        ; Crane's initial state
        (crane-at craneA PierA)
        (crane-at craneW Warehouse)
        (is-available craneA)
        (is-available craneW)
    )

    (:goal (and
        (located-in C1 Warehouse)
    ))
)