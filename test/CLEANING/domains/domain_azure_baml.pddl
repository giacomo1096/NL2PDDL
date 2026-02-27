(define (domain robot-grid-cleaning)
  (:requirements :typing)
  (:types
    agent
    robot - agent
    tile
    grid
  )
  (:predicates
    (at-robot-tile ?r - robot ?t - tile)
    (cleaned ?t - tile)
  )
  (:action move-up
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (at-robot-tile ?r ?from)
      (not (at-robot-tile ?r ?to))
    )
    :effect (and
      (not (at-robot-tile ?r ?from))
      (at-robot-tile ?r ?to)
    )
  )
  (:action move-down
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (at-robot-tile ?r ?from)
      (not (at-robot-tile ?r ?to))
    )
    :effect (and
      (not (at-robot-tile ?r ?from))
      (at-robot-tile ?r ?to)
    )
  )
  (:action move-left
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (at-robot-tile ?r ?from)
      (not (at-robot-tile ?r ?to))
    )
    :effect (and
      (not (at-robot-tile ?r ?from))
      (at-robot-tile ?r ?to)
    )
  )
  (:action move-right
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (at-robot-tile ?r ?from)
      (not (at-robot-tile ?r ?to))
    )
    :effect (and
      (not (at-robot-tile ?r ?from))
      (at-robot-tile ?r ?to)
    )
  )
  (:action clean-tile
    :parameters (?r - robot ?t - tile)
    :precondition (and
      (at-robot-tile ?r ?t)
      (not (cleaned ?t))
    )
    :effect (cleaned ?t)
  )
)