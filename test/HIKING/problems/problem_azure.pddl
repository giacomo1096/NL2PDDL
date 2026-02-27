lisp
(define (problem terrain-hiking)
  (:domain terrain-navigation)

  (:objects
    Trailhead River Rockface Lookout - location
    You - agent
    flat - terrain
    hill - hill
    waterbody - waterbody
  )

  (:init
    (at-location You Trailhead)
    (is-passable flat)
    (is-steep hill)
    (is-crossable waterbody)
    (is-goal Lookout)
  )

  (:goal
    (and
      (at-location You Lookout)
      (is-goal Lookout)
    )
  )
)