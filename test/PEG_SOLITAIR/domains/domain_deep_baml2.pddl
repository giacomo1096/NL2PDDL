(define (domain peg-solitaire)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    peg location board move
  )

  (:predicates
    (peg-at ?p - peg ?l - location)
    (empty ?l - location)
    (on-board ?l - location ?b - board)
    (adjacent ?l1 - location ?l2 - location)
    (move-active ?m - move)
    (move-peg ?m - move ?p - peg)
  )

  (:action start-move
    :parameters (?m - move ?p - peg ?l - location ?b - board)
    :precondition (and
      (not (move-active ?m))
      (peg-at ?p ?l)
      (on-board ?l ?b)
    )
    :effect (and
      (move-active ?m)
      (move-peg ?m ?p)
    )
  )

  (:action jump
    :parameters (?m - move ?p - peg ?p2 - peg ?from - location ?over - location ?to - location ?b - board)
    :precondition (and
      (move-active ?m)
      (move-peg ?m ?p)
      (peg-at ?p ?from)
      (peg-at ?p2 ?over)
      (empty ?to)
      (adjacent ?from ?over)
      (adjacent ?over ?to)
      (on-board ?from ?b)
      (on-board ?over ?b)
      (on-board ?to ?b)
    )
    :effect (and
      (not (peg-at ?p ?from))
      (peg-at ?p ?to)
      (not (peg-at ?p2 ?over))
      (empty ?from)
      (empty ?over)
      (not (empty ?to))
    )
  )

  (:action end-move
    :parameters (?m - move ?p - peg)
    :precondition (and
      (move-active ?m)
      (move-peg ?m ?p)
    )
    :effect (and
      (not (move-active ?m))
      (not (move-peg ?m ?p))
    )
  )
)