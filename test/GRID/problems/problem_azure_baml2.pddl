(define (problem robot-room-transfer)
  (:domain gridkeylock)

  (:objects
    R1 - robot
    RoomA RoomB - place
    Door1 - door
    Lock1 - lock
    KeyQ - key
    square - shape
  )

  (:init
    (at-location R1 RoomA)
    (at-place KeyQ RoomA)
    (at-place Door1 RoomA)
    (at-place Door1 RoomB)
    (has-shape KeyQ square)
    (has-shape Lock1 square)
    (is-locked Lock1)
    (can-unlock R1 Door1)
    (is-accessible RoomA)
    (is-key-shape square)
    (is-robot R1)
  )

  (:goal
    (and
      (at-location R1 RoomB)
    )
  )
)