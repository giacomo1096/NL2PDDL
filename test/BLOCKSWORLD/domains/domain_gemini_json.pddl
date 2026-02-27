(define (domain blocks-world-arm)
  (:requirements :strips :typing)

  (:types
    block table tool - object
    roboticarm - tool
  )

  (:predicates
    (is-clear ?b - block)
    (on-table ?b - block)
    (is-empty ?a - roboticarm)
    (holding ?a - roboticarm ?b - block)
    (on ?b1 - block ?b2 - block)
  )

  (:action pick-up
    :parameters (?a - roboticarm ?b - block)
    :precondition (and
      (is-empty ?a)
      (on-table ?b)
      (is-clear ?b)
    )
    :effect (and
      (not (on-table ?b))
      (not (is-empty ?a))
      (holding ?a ?b)
    )
  )

  (:action put-down
    :parameters (?a - roboticarm ?b - block)
    :precondition (and
      (holding ?a ?b)
    )
    :effect (and
      (on-table ?b)
      (is-empty ?a)
      (not (holding ?a ?b))
      (is-clear ?b)
    )
  )

  (:action stack
    :parameters (?a - roboticarm ?b1 - block ?b2 - block)
    :precondition (and
      (holding ?a ?b1)
      (is-clear ?b2)
    )
    :effect (and
      (not (holding ?a ?b1))
      (not (is-clear ?b2))
      (is-empty ?a)
      (on ?b1 ?b2)
      (is-clear ?b1)
    )
  )

  (:action unstack
    :parameters (?a - roboticarm ?b1 - block ?b2 - block)
    :precondition (and
      (is-empty ?a)
      (on ?b1 ?b2)
      (is-clear ?b1)
    )
    :effect (and
      (not (on ?b1 ?b2))
      (not (is-empty ?a))
      (holding ?a ?b1)
      (is-clear ?b2)
    )
  )
)