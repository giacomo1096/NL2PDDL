(define (domain dwr-domain)
  (:requirements :typing :fluents :equality)

  ;; Types
  (:types
    robot location container crane
  )

  ;; Predicates (Boolean Attributes)
  (:predicates
    (at-location ?x - robot ?l - location) ; Robot is at location
    (is-carrying ?r - robot ?c - container) ; Robot is carrying container
    (is-empty ?r - robot) ; Robot is not carrying anything
    (has-crane ?l - location ?cr - crane) ; Location has crane
    (has-container ?l - location ?c - container) ; Location has container
    (is-destination ?l - location) ; Location is a target drop-off
    (is-loaded ?c - container) ; Container is being carried/held
    (is-unloaded ?c - container) ; Container is on the ground
    (at-location ?c - container ?l - location) ; Container is at location
    (is-operational ?cr - crane) ; Crane is functional
    (is-lifting ?cr - crane ?c - container) ; Crane is lifting container
    (at-location ?cr - crane ?l - location) ; Crane is at location
  )

  ;; Functions (Numeric Attributes)
  (:functions
    (battery-level ?r - robot) ; Energy level (decreases on movement)
  )

  ;; Action: move
  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (at-location ?r ?from)
      (> (battery-level ?r) 0)
      (not (equal ?from ?to))
    )
    :effect (and
      (not (at-location ?r ?from))
      (at-location ?r ?to)
      (decrease (battery-level ?r) 1)
    )
  )

  ;; Action: pick-up (robot picks up container from location)
  (:action pick-up
    :parameters (?r - robot ?c - container ?l - location)
    :precondition (and
      (at-location ?r ?l)
      (has-container ?l ?c)
      (is-unloaded ?c)
      (is-empty ?r)
    )
    :effect (and