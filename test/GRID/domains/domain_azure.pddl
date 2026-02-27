
(define (domain robot-keys-doors)
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
    ;; Robot predicates
    (at-location ?r - robot ?p - place)
    (carrying-key ?r - robot ?k - key)
    (can-unlock ?r - robot ?d - door)
    (is-robot ?a - agent)

    ;; Place predicates
    (is-accessible ?p - place)

    ;; Key predicates
    (at-place ?k - key ?p - place)
    (has-shape ?k - key ?s - shape)

    ;; Shape predicates
    (is-key-shape ?s - shape)

    ;; Door predicates
    (at-place-door ?d - door ?p - place)
    (is-unlocked ?d - door)

    ;; Lock predicates
    (has-shape-lock ?l - lock ?s - shape)
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
      (at-place-door ?d ?p)
      (carrying-key ?r ?k)
      (has-shape ?k ?s)
      (has-shape-lock ?l ?s)
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
      (at-place-door ?d ?p)
      (has-shape-lock ?l ?s)
      (not (is-unlocked ?d))
    )
    :effect (and
      (is-locked ?l)
      (not (is-unlocked ?d))
    )
  )
)