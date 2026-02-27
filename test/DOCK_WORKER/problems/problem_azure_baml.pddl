lisp
(define (problem move-c1-to-warehouse)
  (:domain robot-crane-container)

  (:objects
    Roby - robot
    C1 - container
    PierA PierB Warehouse - location
    crane_PierA crane_Warehouse - crane
  )

  (:init
    ;; Robot initial state
    (at-robot-location Roby PierA)
    ;; Roby is not holding a container
    ;; (holding-container Roby) is false by default (not present)

    ;; Container initial state
    (at-container-location C1 PierA)
    ;; C1 is not held by robot
    ;; (held-by-robot C1) is false by default (not present)
    ;; C1 is not loaded on a crane
    ;; (loaded-on-crane C1) is false by default (not present)

    ;; Crane initial state
    (at-crane-location crane_PierA PierA)
    (available crane_PierA)
    ;; (crane-holding-container crane_PierA) is false by default (not present)

    (at-crane-location crane_Warehouse Warehouse)
    (available crane_Warehouse)
    ;; (crane-holding-container crane_Warehouse) is false by default (not present)

    ;; Connections (bidirectional)
    (connected PierA Warehouse)
    (connected Warehouse PierA)
    (connected Warehouse PierB)
    (connected PierB Warehouse)
  )

  (:goal
    (at-container-location C1 Warehouse)
  )
)