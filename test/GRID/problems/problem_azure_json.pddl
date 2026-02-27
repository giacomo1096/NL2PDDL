lisp
(define (problem robot-key-door-instance-1)
  (:domain robot-key-door)

  (:objects
    R1 - robot
    RoomA RoomB - place
    Door1 - door
    KeyQ - key
    Square - shape
    Door1_Lock - lock
  )

  (:init
    (is-robot R1)
    (at-location R1 RoomA)
    (is-accessible RoomA)
    ;; RoomB is not accessible until the door is unlocked

    (at-place KeyQ RoomA)
    (has-shape KeyQ Square)
    (is-key-shape Square)

    ;; Door1 is between RoomA and RoomB; we represent its place as RoomA for the robot to interact with
    (at-place Door1 RoomA)
    ;; Door1 is initially locked
    (not (is-unlocked Door1))

    (has-shape Door1_Lock Square)
    (is-locked Door1_Lock)
  )

  (:goal
    (at-location R1 RoomB)
  )
)