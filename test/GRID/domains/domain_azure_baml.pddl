(define (domain robot-doors)
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
    ;; Location predicates
    (at ?r - robot ?p - place)
    (at-key ?k - key ?p - place)
    (at-door ?d - door ?p - place)

    ;; Key predicates
    (held-by ?k - key ?r - robot)
    (has-shape-key ?k - key ?s - shape)

    ;; Robot predicates
    (holding-key ?r - robot)

    ;; Door predicates
    (is-open ?d - door)
    (has-lock ?d - door ?l - lock)

    ;; Lock predicates
    (is-locked ?l - lock)
    (has-shape-lock ?l - lock ?s - shape)
  )

  ;; Move action
  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (at ?r ?from)
    :effect (and
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )

  ;; Pickup key action
  (:action pickup-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
      (at ?r ?p)
      (at-key ?k ?p)
      (not (held-by ?k ?r))
    )
    :effect (and
      (held-by ?k ?r)
      (not (at-key ?k ?p))
      (holding-key ?r)
    )
  )

  ;; Drop key action
  (:action drop-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
      (at ?r ?p)
      (held-by ?k ?r)
    )
    :effect (and
      (not (held-by ?k ?r))
      (at-key ?k ?p)
      (not (holding-key ?r))
    )
  )

  ;; Unlock door action
  (:action unlock-door
    :parameters (?r - robot ?k - key ?d - door ?l - lock ?s - shape ?p - place)
    :precondition (and
      (at ?r ?p)
      (at-door ?d ?p)
      (held-by ?k ?r)
      (has-lock ?d ?l)
      (not (is-open ?d))
      (is-locked ?l)
      (has-shape-key ?k ?s)
      (has-shape-lock ?l ?s)
    )
    :effect (and
      (not (is-locked ?l))
      (is-open ?d)
    )
  )

  ;; Lock door action
  (:action lock-door
    :parameters (?r - robot ?d - door ?l - lock ?p - place)
    :precondition (and
      (at ?r ?p)
      (at-door ?d ?p)
      (has-lock ?d ?l)
      (is-open ?d)
      (not (is-locked ?l))
    )
    :effect (and
      (is-locked ?l)
      (not (is-open ?d))
    )
  )

  ;; Open door action
  (:action open-door
    :parameters (?r - robot ?d - door ?l - lock ?p - place)
    :precondition (and
      (at ?r ?p)
      (at-door ?d ?p)
      (has-lock ?d ?l)
      (not (is-locked ?l))
      (not (is-open ?d))
    )
    :effect (and
      (is-open ?d)
    )
  )

  ;; Close door action
  (:action close-door
    :parameters (?r - robot ?d - door ?l - lock ?p - place)
    :precondition (and
      (at ?r ?p)
      (at-door ?d ?p)
      (has-lock ?d ?l)
      (is-open ?d)
    )
    :effect (and
      (not (is-open ?d))
    )
  )
)