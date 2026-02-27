(define (domain repair)
  (:requirements :strips :typing)

  (:types
    robot
    gripper
    object
    room
  )

  (:predicates
    (at-robot ?r - robot ?rm - room)
    (has-gripper ?r - robot ?g - gripper)
    (free ?g - gripper)
    (fixed ?o - object)
    (at-object ?o - object ?rm - room)
    (connected ?from - room ?to - room)
  )

  (:action move
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (and (at-robot ?r ?from) (connected ?from ?to))
    :effect (and (not (at-robot ?r ?from)) (at-robot ?r ?to))
  )

  (:action fix
    :parameters (?r - robot ?g - gripper ?o - object ?rm - room)
    :precondition (and (at-robot ?r ?rm) (at-object ?o ?rm) (has-gripper ?r ?g) (free ?g) (not (fixed ?o)))
    :effect (and (fixed ?o))
  )
)