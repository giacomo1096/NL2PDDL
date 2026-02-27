(define (problem navigate-to-roomb)
  (:domain robot-keys-doors)
  (:objects
    R1 - robot
    RoomA RoomB - place
    KeyQ - key
    Door1 - door
    Lock1 - lock
    square-shape - shape
  )
  (:init
    ; Robot's initial state
    (is-robot-location RoomA)
    (robot-is-empty R1)

    ; Key's initial state
    (key-at KeyQ RoomA)
    (key-shape KeyQ square-shape)

    ; Door and Lock's initial state
    (is-locked Door1)
    (door-connects Door1 RoomA RoomB)
    (door-has-lock Door1 Lock1)
    (lock-shape Lock1 square-shape)
  )
  (:goal
    (and
      (is-robot-location RoomB)
    )
  )
)