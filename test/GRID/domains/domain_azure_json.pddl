(define (domain robot-key-door)
  (:requirements :strips :typing)
  (:types
    agent
    robot - agent
    place
    key
    shape
    door
    lock
  )

  (:predicates
    ;; agent
    (is-robot ?a - agent)

    ;; robot
    (at-location ?r - robot ?p - place)
    (carrying-key ?r - robot ?k - key)
    (can-unlock ?r - robot ?d - door)

    ;; place
    (is-accessible ?p - place)

    ;; key
    (at-place ?k - key ?p - place)
    (has-shape ?k - key ?s - shape)

    ;; shape
    (is-key-shape ?s - shape)

    ;; door
    (at-place ?d - door ?p - place)
    (is-unlocked ?d - door)

    ;; lock
    (has-shape ?l - lock ?s - shape)
    (is-locked ?l - lock)
  )

  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (and
      (at-location ?r ?from)
      (is-accessible ?to)
    )
    :effect (and
      (not (at-location ?r ?from))
      (at-location ?r ?to)
    )
  )

  (:action pick-up-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
      (at-location ?r ?p)
      (at-place ?k ?p)
      (not (carrying-key ?r ?k))
    )
    :effect (and
      (carrying-key ?r ?k)
      (not (at-place ?k ?p))
    )
  )

  (:action drop-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
      (at-location ?r ?p)
      (carrying-key ?r ?k)
    )
    :effect (and
      (not (carrying-key ?r ?k))
      (at-place ?k ?p)
    )
  )

  (:action unlock-door
    :parameters (?r - robot ?d - door ?k - key ?l - lock ?s - shape ?p - place)
    :precondition (and
      (at-location ?r ?p)
      (at-place ?d ?p)
      (carrying-key ?r ?k)
      (has-shape ?k ?s)
      (has-shape ?l ?s)
      (is-locked ?l)
    )
    :effect (and
      (is-unlocked ?d)
      (not (is-locked ?l))
      (can-unlock ?r ?d)
    )
  )

  (:action lock-door
    :parameters (?r - robot ?d - door ?l - lock ?s - shape ?p - place)
    :precondition (and
      (at-location ?r ?p)
      (at-place ?d ?p)
      (has-shape ?l ?s)
      (not (is-unlocked ?d))
    )
    :effect (and
      (is-locked ?l)
      (not (is-unlocked ?d))
    )
  )
)