
(define (domain blocks-world)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    block roboticarm table
  )

  ;; Predicates
  (:predicates
    (clear ?b - block)          ; Block ?b has nothing on top of it
    (on ?b1 - block ?b2 - block) ; Block ?b1 is directly on top of block ?b2
    (on-table ?b - block)       ; Block ?b is on the table
    (holding ?r - roboticarm ?b - block) ; Arm ?r is holding block ?b
    (empty ?r - roboticarm)     ; Arm ?r is not holding any block
  )

  ;; Actions
  (:action pick-up
    :parameters (?r - roboticarm ?b - block)
    :precondition (and
      (clear ?b)
      (on-table ?b)
      (empty ?r)
    )
    :effect (and
      (not (on-table ?b))
      (not (clear ?b))
      (not (empty ?r))
      (holding ?r ?b)
    )
  )

  (:action put-down
    :parameters (?r - roboticarm ?b - block)
    :precondition (and
      (holding ?r ?b)
    )
    :effect (and
      (not (holding ?r ?b))
      (on-table ?b)
      (clear ?b)
      (empty ?r)
    )
  )

  (:action stack
    :parameters (?r - roboticarm ?b1 - block ?b2 - block)
    :precondition (and
      (holding ?r ?b1)
      (clear ?b2)
    )
    :effect (and
      (not (holding ?r ?b1))
      (not (clear ?b2))
      (on ?b1 ?b2)
      (clear ?b1)
      (empty ?r)
    )
  )

  (:action unstack
    :parameters (?r - roboticarm ?b1 - block ?b2 - block)
    :precondition (and
      (on ?b1 ?b2)
      (clear ?b1)
      (empty ?r)
    )
    :effect (and
      (not (on ?b1 ?b2))
      (