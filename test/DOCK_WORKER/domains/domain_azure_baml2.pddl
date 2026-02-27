(define (domain dockworker)
  (:requirements :strips :typing)

  (:types
    robot
    container
    crane
    location
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (container-at ?c - container ?l - location)
    (crane-at ?cr - crane ?l - location)
    (robot-holding ?r - robot ?c - container)
    (crane-holding ?cr - crane ?c - container)
    (crane-available ?cr - crane)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (robot-at ?r ?from) (not (= ?from ?to)))
    :effect (and (not (robot-at ?r ?from)) (robot-at ?r ?to))
  )

  (:action load
    :parameters (?r - robot ?c - container ?l - location ?cr - crane)
    :precondition (and (robot-at ?r ?l) (container-at ?c ?l) (crane-at ?cr ?l) (crane-available ?cr) (not (robot-holding ?r ?c)) (not (crane-holding ?cr ?c)))
    :effect (and (robot-holding ?r ?c) (not (container-at ?c ?l)))
  )

  (:action unload
    :parameters (?r - robot ?c - container ?l - location ?cr - crane)
    :precondition (and (robot-at ?r ?l) (crane-at ?cr ?l) (crane-available ?cr) (robot-holding ?r ?c))
    :effect (and (not (robot-holding ?r ?c)) (container-at ?c ?l))
  )
)