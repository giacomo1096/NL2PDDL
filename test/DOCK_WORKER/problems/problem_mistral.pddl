(define (problem dwr-problem-1)
  (:domain dwr-domain)

  ;; Objects
  (:objects
    Roby - robot
    C1 - container
    PierA PierB Warehouse - location
    CraneA CraneW - crane
  )

  ;; Initial State
  (:init
    ;; Robot state
    (at-location Roby PierA)
    (is-empty Roby)
    (= (battery-level Roby) 10)

    ;; Container state
    (at-location C1 PierA)
    (has-container PierA C1)
    (is-unloaded C1)

    ;; Crane state
    (has-crane PierA CraneA)
    (has-crane Warehouse CraneW)
    (at-location CraneA PierA)
    (at-location CraneW Warehouse)
    (is-operational CraneA)
    (is-operational CraneW)

    ;; Location connections (bidirectional)
    (connected PierA Warehouse)
    (connected Warehouse PierA)
    (connected Warehouse PierB)
    (connected PierB Warehouse)

    ;; Destination status
    (is-destination Warehouse)
    (not (is-destination PierA))
    (not (is-destination PierB))
  )

  ;; Goal
  (:goal (and
    (at-location C1 Warehouse)
    (is-unloaded C1)
    (not (is-carrying Roby C1))
  ))
)