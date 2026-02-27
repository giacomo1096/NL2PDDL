(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types 
    block
    table
    roboticarm
  )

  (:predicates
    (on-table ?b - block)
    (on ?b - block ?x - object)
    (clear ?b - block)
    (holding ?r - roboticarm ?b - block)
    (empty ?r - roboticarm)
  )

  (:action pick-up
    :parameters (?r - roboticarm ?b - block ?x - object)
    :precondition (and (not (holding ?r ?b)) (not (on-table ?b)) (clear ?b))
    :effect (and (holding ?r ?b) (not (empty ?r)) (not (on ?b ?x)))
  )

  (:action put-down
    :parameters (?r - roboticarm ?b - block ?x - object)
    :precondition (and (holding ?r ?b) (not (empty ?r)))
    :effect (and (not (holding ?r ?b)) (empty ?r) (on ?b ?x))
  )

  (:action move-block
    :parameters (?r - roboticarm ?b - block ?x - object)
    :precondition (and (holding ?r ?b) (not (empty ?r)) (clear ?b) (on ?b ?y) (clear ?y))
    :effect (and (not (on ?b ?y)) (on ?b ?x))
  )
)