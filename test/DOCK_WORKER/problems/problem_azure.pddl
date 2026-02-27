lisp
(define (problem move-container-to-warehouse)
  (:domain robot-container-crane)
  (:objects
    Roby - robot
    C1 - container
    PierA PierB Warehouse - location
    Crane_PierA Crane_Warehouse - crane
  )
  (:init
    (robot-at Roby PierA)
    (not (is-loaded Roby))
    (is-at-location C1 PierA)
    (has-crane PierA)
    (has-crane Warehouse)
    (not (has-crane PierB))
    (is-operational Crane_PierA)
    (is-operational Crane_Warehouse)
  )
  (:goal
    (is-at-location C1 Warehouse)
  )
)