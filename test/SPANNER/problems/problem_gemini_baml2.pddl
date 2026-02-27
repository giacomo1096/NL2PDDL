(define (problem fix-gate-nut)
  (:domain spanner)

  (:objects
    Bob - man
    Shed Garden Gate - location
    Spanner - spanner
    Nut - nut
  )

  (:init
    (hands-empty Bob)
    (is-loose Nut)
    (is-usable Spanner)
    (man-at Bob Garden)
    (spanner-at Spanner Shed)
    (nut-at Nut Gate)
    (linked Shed Garden)
    (linked Garden Shed)
    (linked Garden Gate)
    (linked Gate Garden)
  )

  (:goal
    (and
      (is-tightened Nut)
    )
  )
)