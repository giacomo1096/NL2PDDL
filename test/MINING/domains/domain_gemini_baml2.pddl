(define (domain gold-miner)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot location
    object
    obstacle
    tool gold - object
    laser bomb - tool
    soft-rock hard-rock - obstacle
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (arm-empty ?r - robot)
    (holding-laser ?r - robot ?la - laser)
    (holding-bomb ?r - robot ?bo - bomb)
    (holding-gold ?r - robot ?g - gold)

    (connected ?l1 - location ?l2 - location)
    (clear ?l - location)

    (gold-at ?g - gold ?l - location)
    (laser-at ?la - laser ?l - location)
    (bomb-at ?bo - bomb ?l - location)
    (soft-rock-at ?sr - soft-rock ?l - location)
    (hard-rock-at ?hr - hard-rock ?l - location)
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

  (:action pickup-laser
    :parameters (?r - robot ?la - laser ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (laser-at ?la ?loc)
      (arm-empty ?r)
    )
    :effect (and
      (not (arm-empty ?r))
      (holding-laser ?r ?la)
      (not (laser-at ?la ?loc))
    )
  )

  (:action putdown-laser
    :parameters (?r - robot ?la - laser ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (holding-laser ?r ?la)
    )
    :effect (and
      (not (holding-laser ?r ?la))
      (arm-empty ?r)
      (laser-at ?la ?loc)
    )
  )

  (:action pickup-bomb
    :parameters (?r - robot ?bo - bomb ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (bomb-at ?bo ?loc)
      (arm-empty ?r)
    )
    :effect (and
      (not (arm-empty ?r))
      (holding-bomb ?r ?bo)
      (not (bomb-at ?bo ?loc))
    )
  )

  (:action putdown-bomb
    :parameters (?r - robot ?bo - bomb ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (holding-bomb ?r ?bo)
    )
    :effect (and
      (not (holding-bomb ?r ?bo))
      (arm-empty ?r)
      (bomb-at ?bo ?loc)
    )
  )

  (:action pickup-gold
    :parameters (?r - robot ?g - gold ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (gold-at ?g ?loc)
      (arm-empty ?r)
    )
    :effect (and
      (not (arm-empty ?r))
      (holding-gold ?r ?g)
      (not (gold-at ?g ?loc))
    )
  )

  (:action putdown-gold
    :parameters (?r - robot ?g - gold ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (holding-gold ?r ?g)
    )
    :effect (and
      (not (holding-gold ?r ?g))
      (arm-empty ?r)
      (gold-at ?g ?loc)
    )
  )

  (:action destroy-soft-rock
    :parameters (?r - robot ?bo - bomb ?sr - soft-rock ?robot_loc - location ?rock_loc - location)
    :precondition (and
      (robot-at ?r ?robot_loc)
      (holding-bomb ?r ?bo)
      (soft-rock-at ?sr ?rock_loc)
      (connected ?robot_loc ?rock_loc)
      (not (clear ?rock_loc))
    )
    :effect (and
      (not (soft-rock-at ?sr ?rock_loc))
      (clear ?rock_loc)
      (not (holding-bomb ?r ?bo))
      (arm-empty ?r)
    )
  )

  (:action destroy-hard-rock
    :parameters (?r - robot ?la - laser ?hr - hard-rock ?robot_loc - location ?rock_loc - location)
    :precondition (and
      (robot-at ?r ?robot_loc)
      (holding-laser ?r ?la)
      (hard-rock-at ?hr ?rock_loc)
      (connected ?robot_loc ?rock_loc)
      (not (clear ?rock_loc))
    )
    :effect (and
      (not (hard-rock-at ?hr ?rock_loc))
      (clear ?rock_loc)
    )
  )
)