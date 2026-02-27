(define (problem collect-diamond)
  (:domain vgdl)

  (:objects
    Ava - avatar
    Diamond1 - diamond
    Wall1 - wall
    Exit1 - exitdoor
    position-1-1 position-2-1 position-1-2 position-2-2 - position
    orientation-right - orientation
  )

  (:init
    (at-avatar Ava position-1-1)
    (has-orientation-avatar Ava orientation-right)
    (at-diamond Diamond1 position-2-1)
    (at-wall Wall1 position-1-2)
    (at-exitdoor Exit1 position-2-2)
    (not (is-collected-diamond Diamond1))
    (not (is-open-exitdoor Exit1))
    (is-alive-avatar Ava)
  )

  (:goal
    (and
      (is-collected-diamond Diamond1)
    )
  )
)