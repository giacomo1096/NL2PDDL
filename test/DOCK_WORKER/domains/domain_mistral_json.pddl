```pddl
(define (domain robot-container-logistics)
  (:requirements :typing :fluents :equality)

  ;; Types
  (:types
    robot location container crane
  )

  ;; Predicates
  (:predicates
    ;; Robot predicates
    (at-location ?r - robot ?l - location)
    (is-carrying ?r - robot ?c - container)
    (is-empty ?r - robot)

    ;; Location predicates
    (has-crane ?l - location ?cr - crane)
    (has-container ?l - location ?c - container)
    (is-destination ?l - location)

    ;; Container predicates
    (is-loaded ?c - container)
    (is-unloaded ?c - container)
    (at-location ?c - container ?l - location)

    ;; Crane predicates
    (is-operational ?cr - crane)
    (is-lifting ?cr - crane ?c - container)
    (at-location ?cr - crane ?l - location)
  )

  ;; Functions
  (:functions
    (battery-level ?r - robot)
  )

  ;; Actions
  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (at-location ?r ?from)
      (> (battery-level ?r) 0)
      (not (= ?from ?to))
    )
    :effect (and
      (not (at-location ?r ?from))
      (at-location ?r ?to)
      (decrease (battery-level ?r) 1)
    )
  )

  (:action load
    :parameters (?r - robot ?c - container ?l - location ?cr - crane)
    :precondition (and
      (at-location ?r ?l)
      (at-location ?c ?l)
      (at-location ?cr ?l)
      (has-crane ?l ?cr)
      (is-operational ?cr)
      (is-empty ?r)
      (is-unloaded ?c)
      (not (is-lifting ?cr ?c))
    )
    :effect (and
      (is-carrying ?r ?c)
      (not (is-empty ?r))
      (not (at-location ?c ?l))
      (not (has-container ?l ?c