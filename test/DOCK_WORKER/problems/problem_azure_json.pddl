lisp
(define (problem move-c1-to-warehouse)
  (:domain container-robot)

  (:objects
    Roby - robot
    C1 - container
    PierA PierB Warehouse - location
    Crane_PierA Crane_Warehouse - crane
  )

  (:init
    (robot-at Roby PierA)
    (is-at-location C1 PierA)
    (not (is-loaded Roby))
    (not (is-loaded-on-robot C1))
    (has-crane PierA)
    (has-crane Warehouse)
    (is-operational Crane_PierA)
    (is-operational Crane_Warehouse)
    ; Connections (for move actions, assumed to be handled externally or in domain)
    ; If needed, can be encoded as comments or additional predicates
  )

  (:goal
    (is-at-location C1 Warehouse)
  )
)