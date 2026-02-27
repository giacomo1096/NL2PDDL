lisp
(define (problem hiking-to-lookout)
  (:domain terrain-navigation)

  (:objects
    Trailhead River Rockface Lookout - location
    You - agent
    flat - terrain
    hill - hill
    waterbody - waterbody
  )

  (:init
    ;; Terrain attributes
    (is_passable flat)
    (is_steep hill)
    (not (is_crossable waterbody))

    ;; Location attributes
    (not (is_goal Trailhead))
    (not (is_goal River))
    (not (is_goal Rockface))
    (is_goal Lookout)

    ;; Agent location
    (at_location You Trailhead)
  )

  (:goal
    (at_location You Lookout)
  )
)