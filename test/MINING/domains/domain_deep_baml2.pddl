(define (domain gold-mining)
  (:requirements :strips :typing :negative-preconditions)
  (:types
    robot
    location
    object
    obstacle
    laser bomb gold - object
    soft-rock hard-rock - obstacle
  )
  (:predicates
    (robot-at ?r - robot ?l - location)
    (holding ?r - robot ?o - object)
    (arm-empty ?r - robot)
    (connected ?l1 - location ?l2 - location)
    (clear ?l - location)
    (object-at ?o - object ?l - location)
    (obstacle-at ?obs - obstacle ?l - location)
  )
  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (robot-at ?r ?from)
      (connected ?from ?to)
      (clear ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )
  (:action pickup
    :parameters (?r - robot ?o - object ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (object-at ?o ?loc)
      (arm-empty ?r)
    )
    :effect (and
      (holding ?r ?o)
      (not (object-at ?o ?loc))
      (not (arm-empty ?r))
    )
  )
  (:action putdown
    :parameters (?r - robot ?o - object ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (holding ?r ?o)
    )
    :effect (and
      (not (holding ?r ?o))
      (object-at ?o ?loc)
      (arm-empty ?r)
    )
  )
  (:action use-bomb
    :parameters (?r - robot ?b - bomb ?current_loc - location ?target_loc - location ?obs - soft-rock)
    :precondition (and
      (robot-at ?r ?current_loc)
      (holding ?r ?b)
      (connected ?current_loc ?target_loc)
      (obstacle-at ?obs ?target_loc)
    )
    :effect (and
      (not (holding ?r ?b))
      (arm-empty ?r)
      (not (obstacle-at ?obs ?target_loc))
      (clear ?target_loc)
    )
  )
  (:action use-laser
    :parameters (?r - robot ?l - laser ?current_loc - location ?target_loc - location ?obs - hard-rock)
    :precondition (and
      (robot-at ?r ?current_loc)
      (holding ?r ?l)
      (connected ?current_loc ?target_loc)
      (obstacle-at ?obs ?target_loc)
    )
    :effect (and
      (not (holding ?r ?l))
      (arm-empty ?r)
      (not (obstacle-at ?obs ?target_loc))
      (clear ?target_loc)
    )
  )
)