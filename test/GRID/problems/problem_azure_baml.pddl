lisp
(define (problem robot-doors-rooma-to-roomb)
  (:domain robot-doors)
  (:objects
    R1 - robot
    RoomA RoomB - place
    Door1 - door
    Lock1 - lock
    KeyQ - key
    square - shape
  )
  (:init
    (at R1 RoomA)
    (at-key KeyQ RoomA)
    (at-door Door1 RoomA)
    (at-door Door1 RoomB)
    (has-lock Door1 Lock1)
    (is-locked Lock1)
    (has-shape-lock Lock1 square)
    (has-shape-key KeyQ square)
    (not (is-open Door1))
  )
  (:goal
    (at R1 RoomB)
  )
)