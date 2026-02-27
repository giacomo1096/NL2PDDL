(define (domain mydomain)
(:requirements :typing :fluents)
(:types block table roboticarm))

(predicates
  (on-table ?b - block)
  (on ?b - block ?x - block)
  (clear ?b - block)
  (holding ?r - roboticarm ?b - block)
  (free ?r - roboticarm)
)

(:action place-on-table
  :parameters (?b - block)
  :precondition (and (holding) (free))
  :effect (and (not (holding)) (not (free)) (on-table ?b))
)

(:action place-on-block
  :parameters (?b1 - block ?b2 - block)
  :precondition (and (holding) (free) (clear ?b2))
  :effect (and (not (holding)) (not (free)) (on ?b1 ?b2))
)

(:action move-block
  :parameters (?b1 - block ?b2 - block)
  :precondition (and (holding) (free) (clear ?b2) (on ?b1 ?b2))
  :effect (and (not (holding)) (not (free)) (not (on ?b1 ?b2)) (clear ?b1) (not (clear ?b2))
))
