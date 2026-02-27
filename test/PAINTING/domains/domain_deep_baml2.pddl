(define (domain painting)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot tile color direction
  )

  (:predicates
    (robot-at ?r - robot ?t - tile)
    (robot-has-color ?r - robot ?c - color)
    (tile-has-color ?t - tile ?c - color)
  )

  (:action move
    :parameters (?r - robot ?from - tile ?to - tile)
    :precondition (and
      (robot-at ?r ?from)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action change-color
    :parameters (?r - robot ?c_old - color ?c_new - color)
    :precondition (and
      (robot-has-color ?r ?c_old)
    )
    :effect (and
      (not (robot-has-color ?r ?c_old))
      (robot-has-color ?r ?c_new)
    )
  )

  (:action paint
    :parameters (?r - robot ?t - tile ?c_old - color ?c_new - color ?d - direction)
    :precondition (and
      (robot-at ?r ?t)
      (robot-has-color ?r ?c_new)
      (tile-has-color ?t ?c_old)
    )
    :effect (and
      (not (tile-has-color ?t ?c_old))
      (tile-has-color ?t ?c_new)
    )
  )
)