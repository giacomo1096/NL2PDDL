(define (problem reach-lookout)
  (:domain hiking)

  (:objects
    Trailhead River Rockface Lookout - location
    You - agent
    hill - hill
    waterbody - waterbody
    terrain - terrain
  )

  (:init
    (at-location You Trailhead)
    (is-goal-location Lookout)
    (is-hill hill)
    (is-waterbody waterbody)
  )

  (:goal
    (and
      (at-location You Lookout)
    )
  )
)