(define (problem move-container-to-warehouse)
  (:domain dockworker)

  (:objects
    Roby - robot
    C1 - container
    PierA PierB Warehouse - location
    crane_PierA crane_Warehouse - crane
  )

  (:init
    (robot-at Roby PierA)
    (container-at C1 PierA)
    (crane-at crane_PierA PierA)
    (crane-at crane_Warehouse Warehouse)
    (crane-available crane_PierA)
    (crane-available crane_Warehouse)
  )

  (:goal
    (and
      (container-at C1 Warehouse)
    )
  )
)