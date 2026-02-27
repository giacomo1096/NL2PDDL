(define (domain tile-painting)
  (:requirements :strips :typing :fluents :numeric-fluents)

  (:types
    robot
    tile
    color
    direction
  )

  (:predicates
    (robot-at ?r - robot ?t - tile)
    (robot-holds-color ?r - robot ?c - color)
    (robot-hand-empty ?r - robot)
    (is-painted ?t - tile ?c - color)
    (is-unpainted ?t - tile)
    (adjacent ?from-tile - tile ?to-tile - tile ?d - direction)
  )

  (:functions
    (total-cost) - number
  )

  (:action move
    :parameters (?r - robot ?from - tile ?to - tile ?d - direction)
    :precondition (and
      (robot-at ?r ?from)
      (adjacent ?from ?to ?d)
    )
    :effect (and
      (robot-at ?r ?to)
      (not (robot-at ?r ?from))
      (increase (total-cost) 1)
    )
  )

  (:action pickup-color
    :parameters (?r - robot ?c - color ?t - tile)
    :precondition (and
      (robot-at ?r ?t)
      (robot-hand-empty ?r)
    )
    :effect (and
      (robot-holds-color ?r ?c)
      (not (robot-hand-empty ?r))
      (increase (total-cost) 1)
    )
  )

  (:action drop-color
    :parameters (?r - robot ?c - color ?t - tile)
    :precondition (and
      (robot-at ?r ?t)
      (robot-holds-color ?r ?c)
    )
    :effect (and
      (robot-hand-empty ?r)
      (not (robot-holds-color ?r ?c))
      (increase (total-cost) 1)
    )
  )

  (:action paint
    :parameters (?r - robot ?c - color ?robot_tile - tile ?paint_tile - tile ?d - direction)
    :precondition (and
      (robot-at ?r ?robot_tile)
      (robot-holds-color ?r ?c)
      (is-unpainted ?paint_tile)
      (adjacent ?robot_tile ?paint_tile ?d)
    )
    :effect (and
      (is-painted ?paint_tile ?c)
      (not (is-unpainted ?paint_tile))
      (increase (total-cost) 1)
    )
  )
)