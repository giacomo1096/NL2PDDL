(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types terrain location action)
    (:types hill waterbody
    (:types walk climb)
    )

(predicates
  (has-hill)
  (has-waterbody)
  (has-goal)
  (can-walk)
  (can-climb)
)

(functions
  (steepness)
  (depth)
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
))
