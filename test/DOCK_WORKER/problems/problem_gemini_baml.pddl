(define (problem transport-c1-to-warehouse)
  (:domain robot-crane-logistics)

  (:objects
    PierA PierB Warehouse - location
    Roby - robot
    C1 - container
    CraneA CraneW - crane
  )

  (:init
    (robot-at Roby PierA)
    (robot-empty Roby)
    (container-at C1 PierA)
    (liftable C1)
    (crane-at CraneA PierA)
    (crane-empty CraneA)
    (crane-at CraneW Warehouse)
    (crane-empty CraneW)
  )

  (:goal (and
    (container-at C1 Warehouse)
  ))
)