
(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robot place key door shape
  )
  (:predicates
    (at ?r - robot ?p - place)
    (carryingkey ?r - robot ?k - key)
    (adjacent ?p1 - place ?p2 - place)
    (hasdoor ?p - place ?d - door)
    (hasshape ?k - key ?s - shape)
    (hasshape ?d - door ?s - shape)
    (islocked ?d - door)
    (isunlocked ?d - door)
  )
  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (and (at ?r ?from) (adjacent ?from ?to) (not (hasdoor ?from ?to)))
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )
  (:action movethroughdoor
    :parameters (?r - robot ?from - place ?to - place ?d - door)
    :precondition (and (at ?r ?from) (adjacent ?from ?to) (hasdoor ?from ?d) (isunlocked ?d))
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )
  (:action pickupkey
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and (at ?r ?p) (not (carryingkey ?r ?k)))
    :effect (carryingkey ?r ?k)
  )
  (:action unlockdoor
    :parameters (?r - robot ?d - door ?k - key ?s - shape ?p - place)
    :precondition (and (at ?r ?p) (hasdoor ?p ?d) (carryingkey ?r ?k) (hasshape ?k ?s) (hasshape ?d ?s) (islocked ?d))
    :effect (and (not (islocked ?d)) (isunlocked ?d))
  )
)