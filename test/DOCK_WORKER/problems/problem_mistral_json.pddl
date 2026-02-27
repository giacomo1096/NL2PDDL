(define (problem robot-container-logistics-problem)
  (:domain robot-container-logistics)

  ;; Objects
  (:objects
    Roby - robot
    C1 - container
    PierA PierB Warehouse - location
    CraneA CraneWarehouse - crane
  )

  ;; Initial state
  (:init
    ;; Robot state
    (at-location Roby PierA)
    (is-empty Roby)
    (= (battery-level Roby) 100)

    ;; Container state
    (at-location C1 PierA)
    (has-container PierA C1)
    (is-unloaded C1)

    ;; Crane state
    (has-crane PierA CraneA)
    (has-crane Warehouse CraneWarehouse)
    (at-location CraneA PierA)
    (at-location CraneWarehouse Warehouse)
    (is-operational CraneA)
    (is-operational CraneWarehouse)

    ;; Location connections (bidirectional)
    (connected PierA Warehouse)
    (connected Warehouse PierA)
    (connected Warehouse PierB)
    (connected PierB Warehouse)

    ;; Destination
    (is-destination Warehouse)
  )

  ;; Goal
  (:goal (and
    (at-location C1 Warehouse)
    (has-container Warehouse C1)
    (is-unloaded C1)
  ))
)