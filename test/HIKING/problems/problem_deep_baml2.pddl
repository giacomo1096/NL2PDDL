(define (problem reach-lookout)
  (:domain hiking)

  (:objects
    hiker - agent
    Trailhead River Rockface Lookout - location
    water - water-body
    hill - hill
  )

  (:init
    (is-target Lookout)
    (agent-at hiker Trailhead)
    (has-terrain River water)
    (has-terrain Rockface hill)
  )

  (:goal
    (agent-at hiker Lookout)
  )
)