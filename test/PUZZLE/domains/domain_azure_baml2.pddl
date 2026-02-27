(define (domain n-puzzle)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    tile
    blank
    board
    position
  )

  (:predicates
    (tile-at-position ?t - tile ?p - position)
    (blank-at-position ?b - blank ?p - position)
    (adjacent-horizontal ?p1 - position ?p2 - position)
    (adjacent-vertical ?p1 - position ?p2 - position)
    (has-position ?bd - board ?p - position)
  )

  (:action move-tile-horizontal
    :parameters (?t - tile ?b - blank ?from - position ?to - position ?bd - board)
    :precondition (and
      (tile-at-position ?t ?from)
      (blank-at-position ?b ?to)
      (adjacent-horizontal ?from ?to)
      (has-position ?bd ?from)
      (has-position ?bd ?to)
    )
    :effect (and
      (not (tile-at-position ?t ?from))
      (tile-at-position ?t ?to)
      (not (blank-at-position ?b ?to))
      (blank-at-position ?b ?from)
    )
  )

  (:action move-tile-vertical
    :parameters (?t - tile ?b - blank ?from - position ?to - position ?bd - board)
    :precondition (and
      (tile-at-position ?t ?from)
      (blank-at-position ?b ?to)
      (adjacent-vertical ?from ?to)
      (has-position ?bd ?from)
      (has-position ?bd ?to)
    )
    :effect (and
      (not (tile-at-position ?t ?from))
      (tile-at-position ?t ?to)
      (not (blank-at-position ?b ?to))
      (blank-at-position ?b ?from)
    )
  )

  (:action move-blank-horizontal
    :parameters (?b - blank ?t - tile ?from - position ?to - position ?bd - board)
    :precondition (and
      (blank-at-position ?b ?from)
      (tile-at-position ?t ?to)
      (adjacent-horizontal ?from ?to)
      (has-position ?bd ?from)
      (has-position ?bd ?to)
    )
    :effect (and
      (not (blank-at-position ?b ?from))
      (blank-at-position ?b ?to)
      (not (tile-at-position ?t ?to))
      (tile-at-position ?t ?from)
    )
  )

  (:action move-blank-vertical
    :parameters (?b - blank ?t - tile ?from - position ?to - position ?bd - board)
    :precondition (and
      (blank-at-position ?b ?from)
      (tile-at-position ?t ?to)
      (adjacent-vertical ?from ?to)
      (has-position ?bd ?from)
      (has-position ?bd ?to)
    )
    :effect (and
      (not (blank-at-position ?b ?from))
      (blank-at-position ?b ?to)
      (not (tile-at-position ?t ?to))
      (tile-at-position ?t ?from)
    )
  )
)