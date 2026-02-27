```pddl
(define (domain robot-key-door)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    robot place key door shape
  )

  ;; Predicates
  (:predicates
    ;; Robot predicates
    (at ?r - robot ?p - place)
    (carrying-key ?r - robot ?k - key)

    ;; Place predicates
    (adjacent ?p1 - place ?p2 - place)
    (has-door ?p - place ?d - door)

    ;; Key predicates
    (has-shape ?k - key ?s - shape)

    ;; Door predicates
    (has-shape ?d - door ?s - shape)
    (is-locked ?d - door)
    (is-unlocked ?d - door)
  )

  ;; Actions
  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (and (at ?r ?from) (adjacent ?from ?to) (not (has-door ?from ?to)))
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )

  (:action move-through-door
    :parameters (?r - robot ?from - place ?to - place ?d - door)
    :precondition (and (at ?r ?from) (has-door ?from ?d) (is-unlocked ?d))
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )

  (:action pick-up-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and (at ?r ?p) (not (carrying-key ?r ?k)))
    :effect (carrying-key ?r ?k)
  )

  (:action unlock-door
    :parameters (?r - robot ?d - door ?k - key ?s - shape ?p - place)
    :precondition (and (at ?r ?p) (has-door ?p ?d) (is-locked ?d)
                       (carrying-key ?r ?k) (has-shape ?d ?s) (has-shape ?k ?s))
    :effect (and (not (is-locked ?d)) (is-unlocked ?d))
  )

  (:action lock-door
    :