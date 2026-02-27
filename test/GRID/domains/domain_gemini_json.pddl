(define (domain robot-keys-doors)
  (:requirements :typing :existential-preconditions)

  (:types
    robot
    place
    key
    door
    lock
    shape
  )

  (:predicates
    (robot-is-empty ?r - robot)
    (is-robot-location ?p - place)
    (is-carried ?k - key)
    (is-locked ?d - door)
    (key-at ?k - key ?p - place)
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
      (not (robot-is-empty ?r))
    )
    :effect (and
      (key-at ?k ?p)
      (robot-is-empty ?r)
      (not (is-carried ?k))
    )
  )

  (:action unlock-door
    :parameters (?r - robot ?k - key ?d - door ?l - lock ?s - shape ?p - place)
    :precondition (and
      (is-robot-location ?p)
      (is-carried ?k)
      (not (robot-is-empty ?r))
      (is-locked ?d)
      (door-has-lock ?d ?l)
      (key-shape ?k ?s)
      (lock-shape ?l ?s)
      (exists (?p2 - place) (door-connects ?d ?p ?p2))
    )
    :effect (and
      (not (is-locked ?d))
    )
  )
)