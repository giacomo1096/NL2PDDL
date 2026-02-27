(define (problem move-c1-to-warehouse)
  (:domain dockworker)

  (:objects
    Roby - robot
    PierA PierB Warehouse - location
    C1 - container
    CraneA CraneW - crane
  )

  (:init
    (robot-at Roby PierA)
    (container-at C1 PierA)
    (crane-at CraneA PierA)
    (crane-at CraneW Warehouse)
    (robot-empty Roby)
    (liftable C1)
    (crane-empty CraneA)
    (crane-empty CraneW)
  )

  (:goal
    (and
      (container-at C1 Warehouse)
    )
  )
)