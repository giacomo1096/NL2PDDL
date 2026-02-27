(define (domain blocksworld)
  (:requirements :strips :typing :negative-preconditions)
  (:types
    block
    table
    robotic-arm
  )
  (:predicates
    (on-table ?b - block ?t - table)
    (on-block ?b1 - block ?b2 - block)
    (clear ?b - block)
    (held-by-arm ?b - block ?a - robotic-arm)
    (arm-empty ?a - robotic-arm)
  )
  (:action pick-up-from-table
    :parameters (?b - block ?t - table ?a - robotic-arm)
    :precondition (and
      (on-table ?b ?t)
      (clear ?b)
      (arm-empty ?a)
    )
    :effect (and
      (not (on-table ?b ?t))
      (not (clear ?b))
      (held-by-arm ?b ?a)
      (not (arm-empty ?a))
    )
  )
  (:action put-down-on-table
    :parameters (?b - block ?t - table ?a - robotic-arm)
    :precondition (and
      (held-by-arm ?b ?a)
    )
    :effect (and
      (on-table ?b ?t)
      (clear ?b)
      (arm-empty ?a)
      (not (held-by-arm ?b ?a))
    )
  )
  (:action stack
    :parameters (?b1 - block ?b2 - block ?a - robotic-arm)
    :precondition (and
      (held-by-arm ?b1 ?a)
      (clear ?b2)
    )
    :effect (and
      (on-block ?b1 ?b2)
      (clear ?b1)
      (arm-empty ?a)
      (not (held-by-arm ?b1 ?a))
      (not (clear ?b2))
    )
  )
  (:action unstack
    :parameters (?b1 - block ?b2 - block ?a - robotic-arm)
    :precondition (and
      (on-block ?b1 ?b2)
      (clear ?b1)
      (arm-empty ?a)
    )
    :effect (and
      (held-by-arm ?b1 ?a)
      (clear ?b2)
      (not (arm-empty ?a))
      (not (on-block ?b1 ?b2))
      (not (clear ?b1))
    )
  )
)