(define (domain grid-cleaning)
  (:requirements :typing)
  (:types
    agent
    robot - agent
    tile
    grid
  )

  (:predicates
    (is-robot ?a - agent)
    (is-on-tile ?r - robot ?t - tile)
    (is-clean ?t - tile)
    (is-tile-in-grid ?t - tile ?g - grid)
  )

  (:action move-up
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (is-on-tile ?r ?from)
      (not (= ?from ?to))
    )
    :effect (and
      (not (is-on-tile ?r ?from))
      (is-on-tile ?r ?to)
    )
  )

  (:action move-down
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (is-on-tile ?r ?from)
      (not (= ?from ?to))
    )
    :effect (and
      (not (is-on-tile ?r ?from))
      (is-on-tile ?r ?to)
    )
  )

  (:action move-left
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (is-on-tile ?r ?from)
      (not (= ?from ?to))
    )
    :effect (and
      (not (is-on-tile ?r ?from))
      (is-on-tile ?r ?to)
    )
  )

  (:action move-right
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (is-on-tile ?r ?from)
      (not (= ?from ?to))
    )
    :effect (and
      (not (is-on-tile ?r ?from))
      (is-on-tile ?r ?to)
    )
  )

  (:action clean
    :parameters (?r - robot ?t - tile)
    :precondition (and
      (is-on-tile ?r ?t)
      (not (is-clean ?t))
    )
    :effect (is-clean ?t)
  )
)