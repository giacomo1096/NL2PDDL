(define (domain dockworker)
  (:requirements :strips :typing)

  (:types
    robot
    location
    container
    crane
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (holding ?r - robot ?c - container)
    (robot-empty ?r - robot)
    (container-at ?c - container ?l - location)
    (liftable ?c - container)
    (crane-at ?cr - crane ?l - location)
    (crane-holding ?cr - crane ?c - container)
    (crane-empty ?cr - crane)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (robot-at ?r ?from))
    :effect (and (not (robot-at ?r ?from)) (robot-at ?r ?to))
  )

  (:action lift
    :parameters (?cr - crane ?c - container ?l - location)
    :precondition (and (crane-at ?cr ?l) (container-at ?c ?l) (crane-empty ?cr) (liftable ?c))
    :effect (and (not (container-at ?c ?l)) (crane-holding ?cr ?c) (not (crane-empty ?cr)) (not (liftable ?c)))
  )

  (:action place
    :parameters (?cr - crane ?c - container ?l - location)
    :precondition (and (crane-at ?cr ?l) (crane-holding ?cr ?c))
    :effect (and (container-at ?c ?l) (not (crane-holding ?cr ?c)) (crane-empty ?cr) (liftable ?c))
  )

  (:action load
    :parameters (?r - robot ?cr - crane ?c - container ?l - location)
    :precondition (and (robot-at ?r ?l) (crane-at ?cr ?l) (robot-empty ?r) (crane-holding ?cr ?c))
    :effect (and (not (robot-empty ?r)) (holding ?r ?c) (not (crane-holding ?cr ?c)) (crane-empty ?cr))
  )

  (:action unload
    :parameters (?r - robot ?cr - crane ?c - container ?l - location)
    :precondition (and (robot-at ?r ?l) (crane-at ?cr ?l) (holding ?r ?c) (crane-empty ?cr))
    :effect (and (not (holding ?r ?c)) (robot-empty ?r) (not (crane-empty ?cr)) (crane-holding ?cr ?c))
  )
)