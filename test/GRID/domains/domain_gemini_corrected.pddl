
(define (domain mydomain)
  (:requirements :typing :fluents :existential-preconditions) ; Added :existential-preconditions for the 'unlock-door' action.

  (:types
    robot
    place
    key
    door
    lock
    shape
  )

  ; Added missing predicates that were used in actions but not declared.
  ; These describe the static relationships and dynamic locations in the world.
  (:predicates
    ; Dynamic predicates (fluents)
    (robot-is-empty ?r - robot)
    (is-robot-location ?p - place)
    (is-carried ?k - key)
    (is-locked ?d - door)
    (key-at ?k - key ?p - place)

    ; Static predicates
    (door-connects ?d - door ?p1 - place ?p2 - place)
    (door-has-lock ?d - door ?l - lock)
    (key-shape ?k - key ?s - shape)
    (lock-shape ?l - lock ?s - shape)
  )

  (:action move
    :parameters (?r - robot ?from - place ?to - place ?d - door)
    :precondition (and
        (is-robot-location ?from)
        (door-connects ?d ?from ?to)
        (not (is-locked ?d))
    )
    :effect (and
        (not (is-robot-location ?from))
        (is-robot-location ?to)
    )
  )

  (:action pickup-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
        (is-robot-location ?p)
        (key-at ?k ?p)
        (robot-is-empty ?r)
    )
    :effect (and
        (not (key-at ?k ?p))
        (not (robot-is-empty ?r))
        (is-carried ?k)
    )
  )

  (:action drop-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
        (is-robot-location ?p)
        (is-carried ?k)
    )
    :effect (and
        (key-at ?k ?p)
        (robot-is-empty ?r)
        (not (is-carried ?k))
    )
  )

  (:action unlock-door
    ; Corrected precondition to ensure the robot is at a place connected by the door.
    ; The original 'exists' clause was syntactically correct but required declaring the ':existential-preconditions' requirement.
    :parameters (?r - robot ?k - key ?d - door ?l - lock ?s - shape ?p - place)
    :precondition (and
        (is-robot-location ?p)
        (is-carried ?k)
        (is-locked ?d)
        (door-has-lock ?d ?l)
        (key-shape ?k ?s)
        (lock-shape ?l ?s)
        ; This condition ensures the robot is at one of the two places connected by the door.
        (exists (?p2 - place) (door-connects ?d ?p ?p2))
    )
    :effect (and
        (not (is-locked ?d))
    )
  )
)