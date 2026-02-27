(define (domain structured-analysis)
  (:requirements :typing)
  
  (:types terrain hill waterbody location action)
  
  (:predicates
    (has-hill ?t - terrain)
    (has-waterbody ?t - terrain)
    (has-goal ?l - location)
    (can-walk ?a - action)
    (can-climb ?a - action)
  )
  
  (:functions
    (steepness ?h - hill)
    (depth ?w - waterbody)
  )
  
  (:action walk
    :parameters (?t - terrain ?from - location ?to - location)
    :precondition (and (has-hill ?t) (can-walk walk) (at ?from ?t))
    :effect (and (not (at ?from ?t)) (at ?to ?t))
  )
  
  (:action climb
    :parameters (?h - hill ?from - location ?to - location)
    :precondition (and (steepness ?h) (can-climb climb) (at ?from ?h))
    :effect (and (not (at ?from ?h)) (at ?to ?h))
  )
  
  (:action swim
    :parameters (?w - waterbody ?from - location ?to - location)
    :precondition (and (depth ?w) (can-walk swim) (at ?from ?w))
    :effect (and (not (at ?from ?w)) (at ?to ?w))
  )
)