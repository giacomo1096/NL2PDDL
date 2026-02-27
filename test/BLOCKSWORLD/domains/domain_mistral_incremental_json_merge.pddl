(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    block roboticarm table
  )


(:predicates
    (clear ?b - block)
    (on ?b1 - block ?b2 - block)
    (on-table ?b - block)
    (holding ?r - roboticarm ?b - block)
    (empty ?r - roboticarm)
)


(:action pick-up
  :parameters (?r - roboticarm ?b - block)
  :precondition (and (clear ?b) (on-table ?b) (empty ?r))
  :effect (and (not (on-table ?b)) (not (clear ?b)) (not (empty ?r)) (holding ?r ?b))
)

(:action put-down
  :parameters (?r - roboticarm ?b - block)
  :precondition (and (holding ?r ?b))
  :effect (and (not (holding ?r ?b)) (on-table ?b) (clear ?b) (empty ?r))
)

(:action stack
  :parameters (?r - roboticarm ?b1 - block ?b2 - block)
  :precondition (and (holding ?r ?b1) (clear ?b2) (not (= ?b1 ?b2)))
  :effect (and (not (holding ?r ?b1)) (not (clear ?b2)) (on ?b1 ?b2) (clear ?b1) (empty ?r))
)

(:action unstack
  :parameters (?r - roboticarm ?b1 - block ?b2 - block)
  :precondition (and (on ?b1 ?b2) (clear ?b1) (empty ?r))
  :effect (and (not (on ?b1 ?b2)) (clear ?b2) (not (empty ?r)) (holding ?r ?b1))
))
