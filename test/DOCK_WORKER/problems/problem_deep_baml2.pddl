(define (problem move-container-to-warehouse)
  (:domain dwr)

  (:objects
    Roby - robot
    C1 - container
    PierA PierB Warehouse - location
    cranePA craneWH - crane
  )

  (:init
    (robot-at Roby PierA)
    (container-at C1 PierA)
    (crane-at cranePA PierA)
    (crane-at craneWH Warehouse)
    (robot-free Roby)
    (crane-free cranePA)
    (crane-free craneWH)
  )

  (:goal
    (container-at C1 Warehouse)
  )
)