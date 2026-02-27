(define (problem collect-the-diamond)
  (:domain vgdl)

  (:objects
    Ava - avatar
    Diamond1 - diamond
    Wall1 - wall
    Exit1 - exitdoor
    pos-1-1 pos-2-1 pos-1-2 pos-2-2 - grid
  )

  (:init
    (at-avatar Ava pos-1-1)
    (at-diamond Diamond1 pos-2-1)
    (at-wall Wall1 pos-1-2)
    (at-exitdoor Exit1 pos-2-2)

    (is-clear pos-1-1)
    (is-clear pos-2-1)
    (is-clear pos-2-2)

    (left-of pos-1-1 pos-2-1)
    (right-of pos-2-1 pos-1-1)
    (up-of pos-1-1 pos-1-2)
    (down-of pos-1-2 pos-1-1)
    (left-of pos-1-2 pos-2-2)
    (right-of pos-2-2 pos-1-2)
    (up-of pos-2-1 pos-2-2)
    (down-of pos-2-2 pos-2-1)
  )

  (:goal
    (and
      (holding-diamond Ava Diamond1)
      (collected Diamond1)
    )
  )
)