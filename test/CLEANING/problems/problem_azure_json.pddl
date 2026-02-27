
(define (problem clean-t2-row)
  (:domain grid-cleaning)
  (:objects
    Robo - robot
    T1 T2 T3 - tile
    G1 - grid
  )
  (:init
    (is-robot Robo)
    (is-on-tile Robo T1)
    (is-tile-in-grid T1 G1)
    (is-tile-in-grid T2 G1)
    (is-tile-in-grid T3 G1)
    ; All tiles are initially not clean
    ; (is-clean T1) not present
    ; (is-clean T2) not present
    ; (is-clean T3) not present
  )
  (:goal
    (is-clean T2)
  )
)