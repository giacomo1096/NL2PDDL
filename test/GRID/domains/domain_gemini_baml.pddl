(define (domain robot-keys-doors)
  (:requirements :typing)

  (:types
    robot place key door lock shape
  )

  (:predicates
    (at-robot ?r - robot ?p - place)
    (handempty ?r - robot)
    (holding ?r - robot ?k - key)
    (connected ?p1 - place ?p2 - place ?d - door)
    (at-key ?k - key ?p - place)
    (key-shape ?k - key ?s - shape)
    (unlocked ?d - door)
    (door-has-lock ?d - door ?l - lock)
    (lock-shape ?l - lock ?s - shape)
  )

  (:action move
    :parameters (?r - robot ?from - place ?to - place ?d - door)
    :precondition (and
      (at-robot ?r ?from)
      (connected ?from ?to ?d)
      (unlocked ?d)
    )
    :effect (and
      (not (at-robot ?r ?from))
      (at-robot ?r ?to)
    )
  )

  (:action pickup-key
    :parameters (?r - robot ?p - place ?k - key)
    :precondition (and
      (at-robot ?r ?p)
      (at-key ?k ?p)
      (handempty ?r)
    )
    :effect (and
      (holding ?r ?k)
      (not (handempty ?r))
      (not (at-key ?k ?p))
    )
  )

  (:action drop-key
    :parameters (?r - robot ?p - place ?k - key)
    :precondition (and
      (at-robot ?r ?p)
      (holding ?r ?k)
    )
    :effect (and
      (not (holding ?r ?k))
      (handempty ?r)
      (at-key ?k ?p)
    )
  )

  (:action unlock-door
    :parameters (?r - robot ?p - place ?p2 - place ?d - door ?k - key ?l - lock ?s - shape)
    :precondition (and
      (at-robot ?r ?p)
      (connected ?p ?p2 ?d)
      (holding ?r ?k)
      (door-has-lock ?d ?l)
      (key-shape ?k ?s)
      (lock-shape ?l ?s)
      (not (unlocked ?d))
    )
    :effect (and
      (unlocked ?d)
    )
  )
)