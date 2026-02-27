(define (domain hanoi)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    disc peg
  )

  (:predicates
    (on-peg ?d - disc ?p - peg)
    (on-disc ?d1 - disc ?d2 - disc)
    (clear ?d - disc)
    (holding ?d - disc)
    (smaller ?d1 - disc ?d2 - disc)
    (empty ?p - peg)
    (hand-empty)
  )

  (:action unstack-from-disc
    :parameters (?d1 - disc ?d2 - disc)
    :precondition (and
      (hand-empty)
      (clear ?d1)
      (on-disc ?d1 ?d2)
    )
    :effect (and
      (not (hand-empty))
      (holding ?d1)
      (not (clear ?d1))
      (not (on-disc ?d1 ?d2))
      (clear ?d2)
    )
  )

  (:action stack-on-disc
    :parameters (?d1 - disc ?d2 - disc)
    :precondition (and
      (holding ?d1)
      (clear ?d2)
      (smaller ?d1 ?d2)
    )
    :effect (and
      (not (holding ?d1))
      (hand-empty)
      (not (clear ?d2))
      (on-disc ?d1 ?d2)
      (clear ?d1)
    )
  )

  (:action unstack-from-peg
    :parameters (?d - disc ?p - peg)
    :precondition (and
      (hand-empty)
      (clear ?d)
      (on-peg ?d ?p)
    )
    :effect (and
      (not (hand-empty))
      (holding ?d)
      (not (clear ?d))
      (not (on-peg ?d ?p))
      (empty ?p)
    )
  )

  (:action stack-on-peg
    :parameters (?d - disc ?p - peg)
    :precondition (and
      (holding ?d)
      (empty ?p)
    )
    :effect (and
      (not (holding ?d))
      (hand-empty)
      (not (empty ?p))
      (on-peg ?d ?p)
      (clear ?d)
    )
  )
)
