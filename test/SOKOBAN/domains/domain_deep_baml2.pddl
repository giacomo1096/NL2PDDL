(define (domain sokoban)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot
    box
    location
    direction
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (box-at ?b - box ?l - location)
    (is-target ?l - location)
    (clear ?l - location)
    (adjacent ?l1 - location ?l2 - location ?d - direction)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location ?d - direction)
    :precondition (and
      (robot-at ?r ?from)
      (adjacent ?from ?to ?d)
      (clear ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
      (clear ?from)
      (not (clear ?to))
    )
  )

  (:action push
    :parameters (?r - robot ?b - box ?rl - location ?bl - location ?nl - location ?d - direction)
    :precondition (and
      (robot-at ?r ?rl)
      (box-at ?b ?bl)
      (adjacent ?rl ?bl ?d)
      (adjacent ?bl ?nl ?d)
      (clear ?nl)
    )
    :effect (and
      (not (robot-at ?r ?rl))
      (robot-at ?r ?bl)
      (not (box-at ?b ?bl))
      (box-at ?b ?nl)
      (clear ?rl)
      (not (clear ?nl))
    )
  )
)