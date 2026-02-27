(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types agent robot place key door)
  (:predicates
    (at ?r - robot ?l - place)
    (carrying-key ?r - robot)
    (matching-key ?r - robot)
    (shape ?k - key)
    (at ?k - key ?l - place)
    (shape ?d - door)
    (locked ?d - door)
    (at ?p - place ?l - place)
  )
  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (at ?r ?from)
    :effect (and
             (not (at ?r ?from))
             (at ?r ?to)
            )
  )
  (:action pickup-key
    :parameters (?r - robot ?k - key ?loc - place)
    :precondition (and
                   (at ?r ?loc)
                   (at ?k ?loc)
                   (shape ?k)
                   (not (carrying-key ?r))
                  )
    :effect (and
             (carrying-key ?r)
             (not (at ?k ?loc))
            )
  )
  (:action unlock-door
    :parameters (?r - robot ?d - door ?loc - place)
    :precondition (and
                   (at ?r ?loc)
                   (at ?d ?loc)
                   (shape ?d)
                   (carrying-key ?r)
                   (matching-key ?r)
                  )
    :effect (and
             (not (matching-key ?r))
             (not (locked ?d))
            )
  )
)