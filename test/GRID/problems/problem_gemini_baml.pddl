(define (problem move-robot-to-roomb)
  (:domain robot-keys-doors)

  (:objects
    R1 - robot
    RoomA RoomB - place
    KeyQ - key
    Door1 - door
    Lock1 - lock
    square - shape
  )

  (:init
    (at-robot R1 RoomA)
    (handempty R1)
    (at-key KeyQ RoomA)
    (connected RoomA RoomB Door1)
    (connected RoomB RoomA Door1)
    (key-shape KeyQ square)
    (door-has-lock Door1 Lock1)
    (lock-shape Lock1 square)
  )

  (:goal (and
    (at-robot R1 RoomB)
  ))
)