(define (domain mining)
  (:requirements :strips :typing)
  (:types
    agent
    minebot - agent
    mine
    cell
    item
    lift
    rock - item
    ore - item
  )

  (:predicates
    ;; minebot predicates
    (at-cell ?m - minebot ?c - cell)
    (holding-item ?m - minebot)
    (using-lift ?m - minebot)

    ;; cell predicates
    (in-mine ?c - cell ?mine - mine)

    ;; item predicates
    (at-cell-item ?i - item ?c - cell)
    (held-by ?i - item ?m - minebot)

    ;; lift predicates
    (at-cell-lift ?l - lift ?c - cell)

    ;; rock predicates
    (at-cell-rock ?r - rock ?c - cell)
    (broken ?r - rock)

    ;; ore predicates
    (at-cell-ore ?o - ore ?c - cell)
    (mined ?o - ore)
  )

  (:action move
    :parameters (?m - minebot ?from - cell ?to - cell ?mine - mine)
    :precondition (and
      (at-cell ?m ?from)
      (in-mine ?from ?mine)
      (in-mine ?to ?mine)
    )
    :effect (and
      (not (at-cell ?m ?from))
      (at-cell ?m ?to)
    )
  )

  (:action pickup-item
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (at-cell-item ?i ?c)
      (not (holding-item ?m))
    )
    :effect (and
      (held-by ?i ?m)
      (not (at-cell-item ?i ?c))
      (holding-item ?m)
    )
  )

  (:action putdown-item
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (held-by ?i ?m)
      (holding-item ?m)
    )
    :effect (and
      (not (held-by ?i ?m))
      (at-cell-item ?i ?c)
      (not (holding-item ?m))
    )
  )

  (:action use-lift
    :parameters (?m - minebot ?l - lift ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (at-cell-lift ?l ?c)
      (not (using-lift ?m))
    )
    :effect (and
      (using-lift ?m)
    )
  )

  (:action stop-using-lift
    :parameters (?m - minebot)
    :precondition (and
      (using-lift ?m)
    )
    :effect (and
      (not (using-lift ?m))
    )
  )

  (:action break-rock
    :parameters (?m - minebot ?r - rock ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (at-cell-rock ?r ?c)
      (not (broken ?r))
    )
    :effect (and
      (broken ?r)
    )
  )

  (:action mine-ore
    :parameters (?m - minebot ?o - ore ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (at-cell-ore ?o ?c)
      (not (mined ?o))
    )
    :effect (and
      (mined ?o)
    )
  )
)