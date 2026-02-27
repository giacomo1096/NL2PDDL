(define (domain robot-crane-container)
  (:requirements :strips :typing)
  (:types
    robot
    container
    crane
    location
  )

  (:predicates
    ;; Robot predicates
    (at-robot-location ?r - robot ?l - location)
    (holding-container ?r - robot)

    ;; Container predicates
    (at-container-location ?c - container ?l - location)
    (loaded-on-crane ?c - container)
    (held-by-robot ?c - container)

    ;; Crane predicates
    (at-crane-location ?cr - crane ?l - location)
    (crane-holding-container ?cr - crane)
    (available ?cr - crane)
  )

  ;; Move robot without container
  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (at-robot-location ?r ?from)
      (not (holding-container ?r))
    )
    :effect (and
      (not (at-robot-location ?r ?from))
      (at-robot-location ?r ?to)
    )
  )

  ;; Move robot with container
  (:action move-with-container
    :parameters (?r - robot ?from - location ?to - location ?c - container)
    :precondition (and
      (at-robot-location ?r ?from)
      (holding-container ?r)
      (held-by-robot ?c)
    )
    :effect (and
      (not (at-robot-location ?r ?from))
      (at-robot-location ?r ?to)
      (not (at-container-location ?c ?from))
      (at-container-location ?c ?to)
    )
  )

  ;; Load container onto crane
  (:action load-container-onto-crane
    :parameters (?cr - crane ?c - container ?l - location)
    :precondition (and
      (at-crane-location ?cr ?l)
      (at-container-location ?c ?l)
      (available ?cr)
      (not (crane-holding-container ?cr))
      (not (loaded-on-crane ?c))
      (not (held-by-robot ?c))
    )
    :effect (and
      (crane-holding-container ?cr)
      (loaded-on-crane ?c)
      (not (at-container-location ?c ?l))
      (not (available ?cr))
    )
  )

  ;; Unload container from crane
  (:action unload-container-from-crane
    :parameters (?cr - crane ?c - container ?l - location)
    :precondition (and
      (at-crane-location ?cr ?l)
      (crane-holding-container ?cr)
      (loaded-on-crane ?c)
    )
    :effect (and
      (not (crane-holding-container ?cr))
      (not (loaded-on-crane ?c))
      (at-container-location ?c ?l)
      (available ?cr)
    )
  )

  ;; Robot picks up container
  (:action robot-pickup-container
    :parameters (?r - robot ?c - container ?l - location)
    :precondition (and
      (at-robot-location ?r ?l)
      (at-container-location ?c ?l)
      (not (holding-container ?r))
      (not (held-by-robot ?c))
      (not (loaded-on-crane ?c))
    )
    :effect (and
      (holding-container ?r)
      (held-by-robot ?c)
      (not (at-container-location ?c ?l))
    )
  )

  ;; Robot drops container
  (:action robot-drop-container
    :parameters (?r - robot ?c - container ?l - location)
    :precondition (and
      (at-robot-location ?r ?l)
      (holding-container ?r)
      (held-by-robot ?c)
    )
    :effect (and
      (not (holding-container ?r))
      (not (held-by-robot ?c))
      (at-container-location ?c ?l)
    )
  )

  ;; Move crane
  (:action move-crane
    :parameters (?cr - crane ?from - location ?to - location)
    :precondition (and
      (at-crane-location ?cr ?from)
      (not (crane-holding-container ?cr))
    )
    :effect (and
      (not (at-crane-location ?cr ?from))
      (at-crane-location ?cr ?to)
    )
  )
)