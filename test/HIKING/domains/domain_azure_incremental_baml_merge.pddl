(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types terrain location action)
)

(predicates
  (terrain)
  (hill)
  (waterbody)
  (location)
  (action)
  (walk)
  (climb)
)

(:action walk
  :parameters (?loc - location ?dest - location)
  :precondition ()
  :effect (and
           (not (at ?loc))
           (at ?dest ?loc)
  )
)

(:action climb
  :parameters (?loc - location ?dest - location)
  :precondition ()
  :effect (and
           (not (at ?loc))
           (at ?dest ?loc)
  )
))
