
(define (domain robot-key-door)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    robot place key door shape
  )

  ;; Predicates
  (:predicates
    (at ?r - robot ?p - place)
    (carrying-key ?r - robot ?k - key)
    (adjacent ?p1 - place ?p2 - place)
    (has-door ?p - place ?d - door)
    (has-shape ?k - key ?s - shape)
    (has-shape ?d - door ?s - shape)
    (is-locked ?d - door)
    (is-unlocked ?d - door)
  )

  ;; Actions
  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (and
      (at ?r ?from)
      (adjacent ?from ?to)
      (not (exists (?d - door)
        (and
          (has-door ?from ?d)
          (is-locked ?d)
        )
      ))
    )
    :effect (and
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )

  (:action pick-up-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
      (at ?r ?p)
      ;; Assuming keys are at places (implicit in problem)
    )
    :effect (carrying-key ?r ?k)
  )

  (:action unlock-door
    :parameters (?r - robot ?d - door ?k - key ?p - place ?s - shape)
    :precondition (and
      (at ?r ?p)
      (has-door ?p ?d)
      (is-locked ?d)
      (carrying-key ?r ?k)
      (has-shape ?k ?s)
      (has-shape ?d ?s)
    )
    :effect (and
      (not (is-locked ?d))
      (is-unlocked ?d)
      (not (carrying-key ?r ?k)) ; Key is consumed
    )
  )
)