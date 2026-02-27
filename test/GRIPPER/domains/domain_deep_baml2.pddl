(define (domain robot-fixing)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot gripper object room
  )

  (:predicates
    (robot-at ?r - robot ?rm - room)
    (has-gripper ?r - robot ?g - gripper)
    (gripper-holding ?g - gripper ?o - object)
    (object-at ?o - object ?rm - room)
    (fixed ?o - object)
    (gripper-free ?g - gripper)
  )

  (:action move
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (and (robot-at ?r ?from))
    :effect (and (not (robot-at ?r ?from)) (robot-at ?r ?to))
  )

  (:action pick
    :parameters (?r - robot ?rm - room ?o - object ?g - gripper)
    :precondition (and (robot-at ?r ?rm)
                      (object-at ?o ?rm)
                      (has-gripper ?r ?g)
                      (gripper-free ?g))
    :effect (and (not (object-at ?o ?rm))
                 (not (gripper-free ?g))
                 (gripper-holding ?g ?o))
  )

  (:action drop
    :parameters (?r - robot ?rm - room ?g - gripper ?o - object)
    :precondition (and (robot-at ?r ?rm)
                      (gripper-holding ?g ?o)
                      (has-gripper ?r ?g))
    :effect (and (object-at ?o ?rm)
                 (gripper-free ?g)
                 (not (gripper-holding ?g ?o)))
  )

  (:action fix
    :parameters (?r - robot ?g - gripper ?o - object)
    :precondition (and (gripper-holding ?g ?o)
                      (has-gripper ?r ?g))
    :effect (and (fixed ?o))
  )
)