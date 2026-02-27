(define (domain robotic-blocks-world)
  (:requirements :strips :typing)

  (:types
    block
    tool
    roboticarm - tool
  )

  (:predicates
    (on ?b1 - block ?b2 - block)
    (on-table ?b - block)
    (is-clear ?b - block)
    (is-empty ?a - roboticarm)
    (holding ?a - roboticarm ?b - block)
  )

  (:action pick-up
    :parameters (?a - roboticarm ?b - block)
    :precondition (and
      (is-empty ?a)
      (on-table ?b)
      (is-clear ?b)
    )
    :effect (and
      (holding ?a ?b)
      (not (on-table ?b))
      (not (is-empty ?a))
      (not (is-clear ?b))
    )
  )

  (:action put-down
    :parameters (?a - roboticarm ?b - block)
    :precondition (and
      (holding ?a ?b)
    )
    :effect (and
      (is-empty ?a)
      (on-table ?b)
      (is-clear ?b)
      (not (holding ?a ?b))
    )
  )

  (:action stack
    :parameters (?a - roboticarm ?b1 - block ?b2 - block)
    :precondition (and
      (holding ?a ?b1)
      (is-clear ?b2)
    )
    :effect (and
      (is-empty ?a)
      (on ?b1 ?b2)
      (is-clear ?b1)
      (not (is-clear ?b2))
      (not (holding ?a ?b1))
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
      (holding ?a ?b1)
      (is-clear ?b2)
      (not (on ?b1 ?b2))
      (not (is-empty ?a))
      (not (is-clear ?b1))
    )
  )
)