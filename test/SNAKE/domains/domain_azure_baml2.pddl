(define (domain snake-game)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents)

  (:types
    snake-head - snake
    snake-segment - snake
    snake
    point
    field
    location
  )

  (:predicates
    (snake-at ?s - snake ?l - location)
    (snake-alive ?s - snake)
    (head-at ?h - snake-head ?l - location)
    (head-collects-point ?h - snake-head ?p - point)
    (segment-at ?sg - snake-segment ?l - location)
    (segment-follows ?sg1 - snake-segment ?sg2 - snake-segment)
    (point-at ?p - point ?l - location)
    (point-collected ?p - point)
    (location-in-field ?f - field ?l - location)
    (field-active ?f - field)
    (occupied-by-snake ?l - location ?s - snake)
    (occupied-by-point ?l - location ?p - point)
  )

  (:functions
    (snake-length ?s - snake) - number
  )

  (:action move-head
    :parameters (?h - snake-head ?s - snake ?from - location ?to - location ?f - field)
    :precondition (and
      (head-at ?h ?from)
      (snake-at ?s ?from)
      (snake-alive ?s)
      (location-in-field ?f ?to)
      (not (occupied-by-snake ?to ?s))
    )
    :effect (and
      (not (head-at ?h ?from))
      (head-at ?h ?to)
      (not (snake-at ?s ?from))
      (snake-at ?s ?to)
      (not (occupied-by-snake ?from ?s))
      (occupied-by-snake ?to ?s)
    )
  )

  (:action move-segment
    :parameters (?sg - snake-segment ?from - location ?to - location ?s - snake ?f - field)
    :precondition (and
      (segment-at ?sg ?from)
      (snake-at ?s ?from)
      (snake-alive ?s)
      (location-in-field ?f ?to)
      (not (occupied-by-snake ?to ?s))
    )
    :effect (and
      (not (segment-at ?sg ?from))
      (segment-at ?sg ?to)
      (not (snake-at ?s ?from))
      (snake-at ?s ?to)
      (not (occupied-by-snake ?from ?s))
      (occupied-by-snake ?to ?s)
    )
  )

  (:action collect-point
    :parameters (?h - snake-head ?s - snake ?p - point ?l - location)
    :precondition (and
      (head-at ?h ?l)
      (snake-at ?s ?l)
      (point-at ?p ?l)
      (snake-alive ?s)
      (not (point-collected ?p))
    )
    :effect (and
      (head-collects-point ?h ?p)
      (point-collected ?p)
      (not (occupied-by-point ?l ?p))
      (not (point-at ?p ?l))
      (increase (snake-length ?s) 1)
    )
  )

  (:action spawn-point
    :parameters (?f - field ?p - point ?l - location ?s - snake)
    :precondition (and
      (field-active ?f)
      (location-in-field ?f ?l)
      (not (occupied-by-point ?l ?p))
      (not (point-at ?p ?l))
      (not (point-collected ?p))
      (not (occupied-by-snake ?l ?s))
    )
    :effect (and
      (point-at ?p ?l)
      (occupied-by-point ?l ?p)
    )
  )

  (:action despawn-point
    :parameters (?f - field ?p - point ?l - location)
    :precondition (and
      (field-active ?f)
      (point-at ?p ?l)
    )
    :effect (and
      (not (point-at ?p ?l))
      (not (occupied-by-point ?l ?p))
    )
  )

  (:action die
    :parameters (?s - snake)
    :precondition (snake-alive ?s)
    :effect (not (snake-alive ?s))
  )
)
