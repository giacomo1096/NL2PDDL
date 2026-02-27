
(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types agent robot place key door)

  (:predicates
    (has-key ?r - robot)
    (shape ?k - key)
    (shape ?d - door)
  )

  (:action pick-up
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and (at ?r ?p) (at ?k ?p) (not (has-key ?r ?k)))
    :effect (and (not (at ?k ?p)) (has-key ?r ?k))
  )

  (:action unlock
    :parameters (?r - robot ?d - door ?k - key)
    :precondition (and (at ?r ?p) (at ?d ?p) (has-key ?r ?k) (shape ?k ?d))
    :effect (and (not (at ?d ?p)) (not (has-key ?r ?k))
  ))

  (:action move-through-door
    :parameters (?r - robot ?d - door ?p1 - place ?p2 - place)
    :precondition (and (at ?r ?p1) (at ?d ?p1) (not (at ?d ?p2)))
    :effect (and (not (at ?d ?p1)) (at ?d ?p2))
  )
)