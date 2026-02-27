(define (problem scan-two-cars)
  (:domain scanalyzer3d)

  (:objects
    Car-A Car-B - car
    Seg1 Seg2 Seg3 Seg4 - segment
  )

  (:init
    (car-at Car-A Seg1)
    (car-at Car-B Seg2)
    (segment-empty Seg3)
    (segment-empty Seg4)
  )

  (:goal
    (and
      (analyzed Car-A)
      (analyzed Car-B)
    )
  )
)