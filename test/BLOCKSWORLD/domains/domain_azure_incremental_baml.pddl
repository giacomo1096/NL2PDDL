(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types block table roboticarm)
  (:predicates
    (on-table ?b - block)
    (on ?b - block ?x - block)
    (clear ?b - block)
    (holding ?r - roboticarm ?b - block)
    (free ?r - roboticarm)
  )
  (:action place-on-table
    :parameters (?b - block ?r - roboticarm)
    :precondition (and (holding ?r ?b) (free ?r))
    :effect (and (not (holding ?r ?b)) (not (free ?r)) (on-table ?b))
  )

  (:action place-on-block
    :parameters (?b1 - block ?b2 - block ?r - roboticarm)
    :precondition (and (holding ?r ?b1) (free ?r) (clear ?b2))
    :effect (and (not (holding ?r ?b1)) (not (free ?r)) (on ?b1 ?b2))
  )

  (:action move-block
    :parameters (?b1 - block ?b2 - block ?r - roboticarm)
    :precondition (and (holding ?r ?b1) (free ?r) (clear ?b2) (on ?b1 ?b2))
    :effect (and (not (holding ?r ?b1)) (not (free ?r)) (not (on ?b1 ?b2)) (clear ?b1) (not (clear ?b2))
  ))
)