lisp
(define (problem robot-keys-doors-problem)
  (:domain robot-keys-doors)
  (:objects
    R1 - robot
    RoomA RoomB - place
    Door1 - door
    KeyQ - key
    square - shape
  )
  (:init
    (at-location R1 RoomA)
    (at-place KeyQ RoomA)
    (has-shape KeyQ square)
    (at-place-door Door1 RoomA)
    (at-place-door Door1 RoomB)
    (is-locked Door1)
    (is-key-shape square)
    (is-accessible RoomA)
    (is-accessible RoomB)
    (is-robot R1)
  )
  (:goal
    (at-location R1 RoomB)
  )
)