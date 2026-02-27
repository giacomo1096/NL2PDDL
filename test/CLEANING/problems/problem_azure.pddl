lisp
(define (problem clean-t2)
  (:domain robot-grid-cleaning)
  (:objects
    Robo - robot
    T1 T2 T3 - tile
    G1 - grid
  )
  (:init
    (is-robot Robo)
    (is-on-tile Robo T1)
    (not (is-clean T1))
    (not (is-clean T2))
    (not (is-clean T3))
    (not (is-on-tile Robo T2))
    (not (is-on-tile Robo T3))
    (is-tile-in-grid T1 G1)
    (is-tile-in-grid T2 G1)
    (is-tile-in-grid T3 G1)
  )
  (:goal
    (is-clean T2)
  )
)