
(define (domain robot_repair_domain)
  (:requirements :typing :fluents :durative-actions)

  ;; Types
  (:types
    robot gripper object room
  )

  ;; Predicates
  (:predicates
    (at ?r - robot ?l - room)
    (has-gripper ?r - robot)
    (is-busy ?r - robot)
    (holding ?g - gripper ?o - object)
    (is-active ?g - gripper)
    (is-broken ?o - object)
    (is-fixed ?o - object)
    (in-room ?o - object ?l - room)
    (connected ?l1 - room ?l2 - room)
    (has-object ?l - room ?o - object)
  )

  ;; Functions
  (:functions
    (battery-level ?r - robot)
  )

  ;; Actions
  (:action move
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (and
      (at ?r ?from)
      (connected ?from ?to)
      (not (is-busy ?r))
    )
    :effect (and
      (not (at ?r ?from))
      (at ?r ?to)
      (decrease (battery-level ?r) 1)
    )
  )

  (:action pick-up
    :parameters (?r - robot ?g - gripper ?o - object ?l - room)
    :precondition (and
      (at ?r ?l)
      (has-gripper ?r)
      (in-room ?o ?l)
      (not (is-busy ?r))
      (not (is-broken ?o))
      (not (is-fixed ?o))
      (not (holding ?g ?o))
    )
    :effect (and
      (holding ?g ?o)
      (is-active ?g)
      (not (in-room ?o ?l))
      (decrease (battery-level ?r) 2)
    )
  )

  (:action drop
    :parameters (?r - robot ?g - gripper ?o - object ?l - room)
    :precondition (and
      (at ?r ?l)
      (has-gripper ?r)
      (holding ?g ?o)
      (not