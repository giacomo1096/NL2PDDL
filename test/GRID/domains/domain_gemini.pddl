(define (domain robot-navigation-keys)
  (:requirements :strips :typing)

  (:types
    robot
    place
    key
    door
    lock
    shape
  )

  (:predicates
    ; Mutable predicates
    (is-robot-location ?p - place)
    (robot-is-empty ?r - robot)
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
      (or (door-connects ?d ?from ?to)
          (door-connects ?d ?to ?from))
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
    :parameters (?r - robot ?k - key ?d - door ?l - lock ?s - shape ?p-robot - place ?p-other - place)
    :precondition (and
      (is-robot-location ?p-robot)
      (or (door-connects ?d ?p-robot ?p-other)
          (door-connects ?d ?p-other ?p-robot))
      (is-locked ?d)
      (is-carried ?k)
      (key-shape ?k ?s)
      (door-has-lock ?d ?l)
      (lock-shape ?l ?s)
    )
    :effect (and
      (not (is-locked ?d))
    )
  )
)