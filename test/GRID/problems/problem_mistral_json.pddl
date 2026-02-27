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
    ;; Robot initial state
    (at R1 RoomA)

    ;; Key properties
    (has-shape KeyQ square)

    ;; Door properties
    (has-shape Door1 square)
    (has-door RoomA Door1)
    (has-door RoomB Door1)
    (is-locked Door1)

    ;; Place adjacency
    (adjacent RoomA RoomB)
  )

  (:goal
    (at R1 RoomB)
  )
)