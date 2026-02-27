lisp
(define (problem hiking-to-lookout)
  (:domain terrain-navigation)
  (:objects
    Trailhead River Rockface Lookout - location
    You - agent
    hill - hill
    waterbody - waterbody
    flat_terrain - terrain
  )
  (:init
    (at-location You Trailhead)
    (is-goal-location Lookout)
    (is-hill hill)
    (is-waterbody waterbody)
    (has-hill Rockface)
    (has-waterbody River)
    (not (has-hill Trailhead))
    (not (has-waterbody Trailhead))
    (not (has-hill Lookout))
    (not (has-waterbody Lookout))
  )
  (:goal
    (at-location You Lookout)
  )
)