(define (problem hallway-inspection)
  (:domain grid-visitor)

  (:objects
    PatrolBot - robot
    Room1 Room2 Room3 - place
  )

  (:init
    (robot-at PatrolBot Room1)
    (visited Room1)
    (connected Room1 Room2)
    (connected Room2 Room1)
    (connected Room2 Room3)
    (connected Room3 Room2)
  )

  (:goal
    (and
      (visited Room1)
      (visited Room2)
      (visited Room3)
    )
  )
)