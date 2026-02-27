
(define (domain robot-repair)
  (:requirements :typing :fluents :durative-actions)

  ;; Types
  (:types
    robot gripper object room
  )

  ;; Predicates
  (:predicates
    (at ?r - robot ?l - room)
    (has-gripper ?r - robot ?g - gripper)
    (is-busy ?r - robot)
    (holding ?g - gripper ?o - object)
    (is-active ?g - gripper)
    (is-broken ?o - object)
    (is-fixed ?o - object)
    (in-room ?o - object ?l - room)
    (connected ?l1 - room ?l2 - room)
  )

  ;; Functions (Fluents)
  (:functions
    (battery-level ?r - robot)
  )

  ;; Actions
  (:durative-action move
    :parameters (?r - robot ?from - room ?to - room)
    :duration (= ?duration 1)
    :condition (and
      (at start (at ?r ?from))
      (at start (connected ?from ?to))
      (at start (> (battery-level ?r) 0))
      (at start (not (is-busy ?r))))
   
    :effect (and
      (at end (not (at ?r ?from)))
      (at end (at ?r ?to))
      (at end (decrease (battery-level ?r) 1))
    ))
  

  (:durative-action pick-up
    :parameters (?r - robot ?g - gripper ?o - object ?l - room)
    :duration (= ?duration 1)
    :condition (and
      (at start (at ?r ?l))
      (at start (has-gripper ?r ?g))
      (at start (in-room ?o ?l))
      (at start (is-broken ?o))
      (at start (not (is-active ?g)))
      (at start (not (is-busy ?r)))
      (at start (> (battery-level ?r) 0)))
    
    :effect (and
      (at end (holding ?g ?o))
      (at end (is-active ?g))
      (at end (is-busy ?r)))))