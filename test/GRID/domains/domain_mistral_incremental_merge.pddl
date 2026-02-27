(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robot place key door shape
  )

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


(:action move
  :parameters (?r - robot ?from - place ?to - place)
  :precondition (and (at ?r ?from) (adjacent ?from ?to) (not (has-door ?from ?to)))
  :effect (and (not (at ?r ?from)) (at ?r ?to))
)

(:action move-through-door
  :parameters (?r - robot ?from - place ?to - place ?d - door)
  :precondition (and (at ?r ?from) (adjacent ?from ?to) (has-door ?from ?d) (is-unlocked ?d))
  :effect (and (not (at ?r ?from)) (at ?r ?to))
)

(:action pick-up-key
  :parameters (?r - robot ?k - key ?p - place)
  :precondition (and (at ?r ?p) (not (carrying-key ?r ?k)))
  :effect (carrying-key ?r ?k)
)

(:action unlock-door
  :parameters (?r - robot ?d - door ?k - key ?s - shape ?p - place)
  :precondition (and (at ?r ?p) (has-door ?p ?d) (carrying-key ?r ?k) (has-shape ?k ?s) (has-shape ?d ?s) (is-locked ?d))
  :effect (and (not (is-locked ?d)) (is-unlocked ?d))
)
 )
