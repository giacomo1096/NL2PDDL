(define (domain robot-cleaner)
  (:requirements :typing)

  (:types
    robot
    tile
  )

  (:predicates
    (robot-at ?r - robot ?t - tile)
    (is-clean ?t - tile)
    (up ?from - tile ?to - tile)
    (down ?from - tile ?to - tile)
    (left ?from - tile ?to - tile)
    (right ?from - tile ?to - tile)
  )

  (:action move-up
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (robot-at ?r ?from)
      (up ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action move-down
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (robot-at ?r ?from)
      (down ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action move-left
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (robot-at ?r ?from)
      (left ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action move-right
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (robot-at ?r ?from)
      (right ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action clean
    :parameters (?r - robot ?t - tile)
    :precondition (and
      (robot-at ?r ?t)
      (not (is-clean ?t))
    )
    :effect (and
      (is-clean ?t)
    )
  )
)