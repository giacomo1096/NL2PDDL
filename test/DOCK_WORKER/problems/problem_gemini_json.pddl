(define (problem dockyard-logistics-problem-instance)
    (:domain dockyard-logistics)

    (:objects
        PierA PierB Warehouse - location
        C1 - container
        craneA craneW - crane
        Roby - dockworkerrobot
    )

    (:init
        ; Robot's initial position and state
        (is-at Roby PierA)
        (is-unloaded Roby)

        ; Container's initial location
        (located-in C1 PierA)

        ; Crane locations and availability
        (crane-at craneA PierA)
        (crane-at craneW Warehouse)
        (is-available craneA)
        (is-available craneW)
    )

    (:goal (and
        (located-in C1 Warehouse)
    ))
)