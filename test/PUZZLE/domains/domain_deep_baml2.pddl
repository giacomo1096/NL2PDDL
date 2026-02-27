(define (domain n-puzzle)
  (:requirements :strips :typing)
  (:types
    tile
    position
  )
  (:predicates
    (at ?t - tile ?p - position)
    (blank ?p - position)
    (adjacent-up ?p1 - position ?p2 - position)
    (adjacent-down ?p1 - position ?p2 - position)
    (adjacent-left ?p1 - position ?p2 - position)
    (adjacent-right ?p1 - position ?p2 - position)
  )
  (:action move-up
    :parameters (?t - tile ?from - position ?to - position)
    :precondition (and
      (at ?t ?from)
      (blank ?to)
      (adjacent-up ?from ?to)
    )
    :effect (and
      (not (at ?t ?from))
      (at ?t ?to)
      (not (blank ?to))
      (blank ?from)
    )
  )
  (:action move-down
    :parameters (?t - tile ?from - position ?to - position)
    :precondition (and
      (at ?t ?from)
      (blank ?to)
      (adjacent-down ?from ?to)
    )
    :effect (and
      (not (at ?t ?from))
      (at ?t ?to)
      (not (blank ?to))
      (blank ?from)
    )
  )
  (:action move-left
    :parameters (?t - tile ?from - position ?to - position)
    :precondition (and
      (at ?t ?from)
      (blank ?to)
      (adjacent-left ?from ?to)
    )
    :effect (and
      (not (at ?t ?from))
      (at ?t ?to)
      (not (blank ?to))
      (blank ?from)
    )
  )
  (:action move-right
    :parameters (?t - tile ?from - position ?to - position)
    :precondition (and
      (at ?t ?from)
      (blank ?to)
      (adjacent-right ?from ?to)
    )
    :effect (and
      (not (at ?t ?from))
      (at ?t ?to)
      (not (blank ?to))
      (blank ?from)
    )
  )
)