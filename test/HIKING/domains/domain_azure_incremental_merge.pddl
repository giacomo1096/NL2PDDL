(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types terrain location action
          hill waterbody
          walk climb)
  ; Add domain-specific predicates, actions, and goals here
)

(predicates
  (has-hill ?t - terrain)
  (has-waterbody ?t - terrain)
  (steepness ?h - hill)
  (depth ?w - waterbody)
  (has-goal ?l - location)
  (can-walk ?a - action)
  (can-climb ?a - action)
)

(functions
  ; No numeric attributes
)

(define (action walk
   :parameters (?t - terrain ?from - location ?to - location)
   :precondition (and (has-hill ?t) (can-walk walk) (at ?from ?t))
   :effect (and (not (at ?from ?t)) (at ?to ?t))
)

(define (action climb
   :parameters (?h - hill ?from - location ?to - location)
   :precondition (and (steepness ?h) (can-climb climb) (at ?from ?h))
   :effect (and (not (at ?from ?h)) (at ?to ?h))
)

(define (action swim
   :parameters (?w - waterbody ?from - location ?to - location)
   :precondition (and (depth ?w) (can-walk swim) (at ?from ?w))
   :effect (and (not (at ?from ?w)) (at ?to ?w))
))
