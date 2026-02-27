(define (domain sokoban)
  (:requirements :strips :typing :negative-preconditions :existential-preconditions)

  (:types
    robot
    box
    location
    direction
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (facing-direction ?r - robot ?d - direction)
    (pushing-box ?r - robot ?b - box)
    (box-at ?b - box ?l - location)
    (at-goal-location ?b - box ?l - location)
    (is-goal-location ?l - location)
    (adjacent-in-direction ?l1 - location ?l2 - location ?d - direction)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location ?d - direction )
    :precondition (and
      (robot-at ?r ?from)
      (adjacent-in-direction ?from ?to ?d)
      (facing-direction ?r ?d)
      (not (robot-at ?r ?to))
      (not (exists (?b - box) (box-at ?b ?to)))
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action turn
    :parameters (?r - robot ?old - direction ?new - direction)
    :precondition (and
      (facing-direction ?r ?old)
      (not (facing-direction ?r ?new))
    )
    :effect (and
      (not (facing-direction ?r ?old))
      (facing-direction ?r ?new)
    )
  )

  (:action push-box
    :parameters (?r - robot ?b - box ?from - location ?boxfrom - location ?to - location ?boxto - location ?d - direction)
    :precondition (and
      (robot-at ?r ?from)
      (box-at ?b ?boxfrom)
      (adjacent-in-direction ?from ?boxfrom ?d)
      (adjacent-in-direction ?boxfrom ?boxto ?d)
      (facing-direction ?r ?d)
      (not (robot-at ?r ?boxfrom))
      (not (box-at ?b ?boxto))
      (not (robot-at ?r ?boxto))
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?boxfrom)
      (not (box-at ?b ?boxfrom))
      (box-at ?b ?boxto)
      (pushing-box ?r ?b)
    )
  )

  (:action stop-pushing
    :parameters (?r - robot ?b - box)
    :precondition (pushing-box ?r ?b)
    :effect (and
      (not (pushing-box ?r ?b))
    )
  )

  (:action achieve-goal
    :parameters (?b - box ?l - location)
    :precondition (and
      (box-at ?b ?l)
      (is-goal-location ?l)
    )
    :effect (and
      (at-goal-location ?b ?l)
    )
  )
)
