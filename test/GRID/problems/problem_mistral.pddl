(define (problem robot-key-door-problem)
  (:domain robot-key-door)

  (:objects
    R1 - robot
    RoomA RoomB - place
    KeyQ - key
    Door1 - door
    square - shape
  )

  (:init
    (at R1 RoomA)
    (has-shape KeyQ square)
    (has-shape Door1 square)
    (has-door RoomA Door1)
    (has-door RoomB Door1)
    (adjacent RoomA RoomB)
    (is-locked Door1)
  )

  (:goal
    (at R1 RoomB)
  )
)