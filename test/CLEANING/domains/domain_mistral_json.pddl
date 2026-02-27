
(define (domain robot_cleaning)
  (:requirements :typing :fluents)

  (:types
    robot tile grid direction - object
  )

  (:predicates
    (at ?r - robot ?t - tile)
    (is-cleaning ?r - robot)
    (is-clean ?t - tile)
    (is-dirty ?t - tile)
    (adjacent ?t1 - tile ?t2 - tile ?d - direction)
  )

  (:functions
    (battery-level ?r - robot)
  )

  (:action move
    :parameters (?r - robot ?from - tile ?to - tile ?d - direction)
    :precondition (and (at ?r ?from)
                       (adjacent ?from ?to ?d)
                       (> (battery-level ?r) 0)
                       (not (is-cleaning ?r)))
    :effect (and (not (at ?r ?from))
                 (at ?r ?to)
                 (decrease (battery-level ?r) 1))
  )

  (:action start-cleaning
    :parameters (?r - robot ?t - tile)
    :precondition (and (at ?r ?t)
                       (is-dirty ?t)
                       (> (battery-level ?r) 0)
                       (not (is-cleaning ?r)))
    :effect (and (is-cleaning ?r)
                 (not (is-dirty ?t))
                 (is-clean ?t)
                 (decrease (battery-level ?r) 1))
  )

  (:action stop-cleaning
    :parameters (?r - robot)
    :precondition (is-cleaning ?r)
    :effect (not (is-cleaning ?r))
  )

  (:action recharge
    :parameters (?r - robot)
    :precondition (and (< (battery-level ?r) 100)
                       (not (is-cleaning ?r)))
    :effect (increase (battery-level ?r) 100)
  )
)