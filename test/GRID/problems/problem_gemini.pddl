(define (problem robot-nav-keys-problem-1)
  (:domain robot-navigation-keys)
  (:objects
    R1 - robot
    RoomA RoomB - place
    KeyQ - key
    Door1 - door
    Lock1 - lock
    square - shape
  )
  (:init
    ; Robot's initial state
    (is-robot-location RoomA)
    (robot-is-empty R1)

    ; Map layout
    (door-connects Door1 RoomA RoomB)

    ; Door/Lock/Key properties
    (is-locked Door1)
    (door-has-lock Door1 Lock1)
    (lock-shape Lock1 square)
    (key-shape KeyQ square)
    (key-at KeyQ RoomA)
  )
  (:goal (and
    (is-robot-location RoomB)
  ))
)