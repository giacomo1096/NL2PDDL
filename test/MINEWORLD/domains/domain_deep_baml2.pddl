(define (domain mine-world)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    minebot mine cell item lift
    rock ore - item
  )

  (:predicates
    (minebot-at ?m - minebot ?c - cell)
    (carrying ?m - minebot ?i - item)
    (using-lift ?m - minebot ?l - lift)
    (cell-in-mine ?c - cell ?m - mine)
    (item-at ?i - item ?c - cell)
    (lift-at ?l - lift ?c - cell)
    (broken ?r - rock)
    (mined ?o - ore)
  )

  (:action move
    :parameters (?mb - minebot ?from ?to - cell)
    :precondition (and
      (minebot-at ?mb ?from)
      (not (minebot-at ?mb ?to))
    )
    :effect (and
      (minebot-at ?mb ?to)
      (not (minebot-at ?mb ?from))
    )
  )

  (:action pick-up
    :parameters (?mb - minebot ?i - item ?c - cell)
    :precondition (and
      (minebot-at ?mb ?c)
      (item-at ?i ?c)
      (not (carrying ?mb ?i))
    )
    :effect (and
      (carrying ?mb ?i)
      (not (item-at ?i ?c))
    )
  )

  (:action use-lift
    :parameters (?mb - minebot ?l - lift ?c - cell)
    :precondition (and
      (minebot-at ?mb ?c)
      (lift-at ?l ?c)
      (not (using-lift ?mb ?l))
    )
    :effect (and
      (using-lift ?mb ?l)
    )
  )

  (:action break-rock
    :parameters (?mb - minebot ?r - rock ?c - cell)
    :precondition (and
      (minebot-at ?mb ?c)
      (item-at ?r ?c)
      (not (broken ?r))
    )
    :effect (and
      (broken ?r)
    )
  )

  (:action mine-ore
    :parameters (?mb - minebot ?o - ore ?c - cell)
    :precondition (and
      (minebot-at ?mb ?c)
      (item-at ?o ?c)
      (not (mined ?o))
    )
    :effect (and
      (mined ?o)
    )
  )

  (:action put-down
    :parameters (?mb - minebot ?i - item ?c - cell)
    :precondition (and
      (minebot-at ?mb ?c)
      (carrying ?mb ?i)
    )
    :effect (and
      (item-at ?i ?c)
      (not (carrying ?mb ?i))
    )
  )
)