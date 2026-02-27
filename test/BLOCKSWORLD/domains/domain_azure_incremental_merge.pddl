(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types
        block
        table
        roboticarm
    )

(predicates
  (free ?b - block)
  (on-table ?b - block)
  (on ?b1 - block ?b2 - block)
  (holding ?r - roboticarm ?b - block)
)

(:action pick-up
    :parameters (?r - roboticarm ?b - block)
    :precondition (and (is-free ?b) (is-on-table ?b) (not (is-holding ?r ?b)))
    :effect (and (not (is-on-table ?b)) (is-holding ?r ?b))
)

(:action put-down
    :parameters (?r - roboticarm ?b - block)
    :precondition (is-holding ?r ?b)
    :effect (and (not (is-holding ?r ?b)) (is-on-table ?b))
)

(:action stack
    :parameters (?r - roboticarm ?b1 - block ?b2 - block)
    :precondition (and (is-holding ?r ?b1) (is-free ?b2) (not (is-on ?b2 ?b1)))
    :effect (and (not (is-holding ?r ?b1)) (not (is-on-table ?b1)) (is-on ?b1 ?b2))
)

(:action unstack
    :parameters (?r - roboticarm ?b1 - block ?b2 - block)
    :precondition (and (is-holding ?r ?b1) (is-on ?b1 ?b2))
    :effect (and (not (is-holding ?r ?b1)) (is-on-table ?b1) (not (is-on ?b1 ?b2))
))
