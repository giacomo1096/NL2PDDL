(define (domain blocksworld)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    block
    table
    robotic-arm
  )

  (:predicates
    (on-table ?b - block)
    (on-block ?b1 - block ?b2 - block)
    (clear ?b - block)
    (held-by-arm ?b - block ?a - robotic-arm)
    (arm-empty ?a - robotic-arm)
  )

  (:action pick-up
    :parameters (?a - robotic-arm ?b - block)
    :precondition (and
      (on-table ?b)
      (clear ?b)
      (arm-empty ?a)
      (not (held-by-arm ?b ?a))
    )
    :effect (and
      (not (on-table ?b))
      (held-by-arm ?b ?a)
      (not (clear ?b))
      (not (arm-empty ?a))
    )
  )

  (:action put-down
    :parameters (?a - robotic-arm ?b - block)
    :precondition (and
      (held-by-arm ?b ?a)
      (not (on-table ?b))
    )
    :effect (and
      (not (held-by-arm ?b ?a))
      (on-table ?b)
      (clear ?b)
      (arm-empty ?a)
    )
  )

  (:action stack
    :parameters (?a - robotic-arm ?b1 - block ?b2 - block)
    :precondition (and
      (held-by-arm ?b1 ?a)
      (clear ?b2)
      (not (on-block ?b1 ?b2))
      (not (on-table ?b1))
    )
    :effect (and
      (not (held-by-arm ?b1 ?a))
      (on-block ?b1 ?b2)
      (not (clear ?b2))
      (clear ?b1)
      (arm-empty ?a)
    )
  )

  (:action unstack
    :parameters (?a - robotic-arm ?b1 - block ?b2 - block)
    :precondition (and
      (on-block ?b1 ?b2)
      (clear ?b1)
      (arm-empty ?a)
      (not (held-by-arm ?b1 ?a))
    )
    :effect (and
      (not (on-block ?b1 ?b2))
      (held-by-arm ?b1 ?a)
      (clear ?b2)
      (not (clear ?b1))
      (not (arm-empty ?a))
    )
  )
)
