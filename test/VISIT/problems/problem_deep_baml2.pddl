(define (problem visit-three-rooms)
  (:domain visit-all)

  (:objects
    PatrolBot - robot
    Room1 Room2 Room3 - place
  )

  (:init
    (robot-at PatrolBot Room1)
    (connected Room1 Room2)
    (connected Room2 Room3)
    (visited Room1)
  )

  (:goal
    (and
      (visited Room1)
      (visited Room2)
      (visited Room3)
    )
  )
)