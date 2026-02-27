(define (domain snake-game)
  (:requirements :strips :typing :negative-preconditions :adl)

  (:types
    location
    point
  )

  (:predicates
    (adjacent ?l1 - location ?l2 - location)
    (snake-occupies ?l - location)
    (is-snake-head ?l - location)
    (point-at ?p - point ?l - location)
    (collected ?p - point)
  )

  (:action move
    :parameters (?from - location ?to - location)
    :precondition (and
      (adjacent ?from ?to)
      (is-snake-head ?from)
      (snake-occupies ?from)
      (not (snake-occupies ?to))
    )
    :effect (and
      (not (is-snake-head ?from))
      (is-snake-head ?to)
      (not (snake-occupies ?from))
      (snake-occupies ?to)
    )
  )

  (:action collect
    :parameters (?p - point ?l - location ?p_new - point ?l_new - location)
    :precondition (and
      (point-at ?p ?l)
      (is-snake-head ?l)
      (not (collected ?p))
      (collected ?p_new)
      (forall (?p2 - point) (not (point-at ?p2 ?l_new)))
    )
    :effect (and
      (collected ?p)
      (not (point-at ?p ?l))
      (not (collected ?p_new))
      (point-at ?p_new ?l_new)
    )
  )
)