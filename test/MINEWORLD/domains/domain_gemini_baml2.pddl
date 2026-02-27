(define (domain mine-world)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    minebot - agent
    cell - location
    ore - item
    item rock lift - physobj
    agent location physobj - object
  )

  (:predicates
    (minebot-at ?m - minebot ?c - cell)
    (hand-empty ?m - minebot)
    (holding-item ?m - minebot ?i - item)
    (connected ?from - cell ?to - cell)
    (item-at ?i - item ?c - cell)
    (rock-at ?r - rock ?c - cell)
    (lift-at ?l - lift ?c - cell)
    (lift-connects ?l - lift ?from - cell ?to - cell)
  )

  (:action move
    :parameters (?m - minebot ?from - cell ?to - cell)
    :precondition (and
      (minebot-at ?m ?from)
      (connected ?from ?to)
    )
    :effect (and
      (not (minebot-at ?m ?from))
      (minebot-at ?m ?to)
    )
  )

  (:action pickup-item
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (minebot-at ?m ?c)
      (item-at ?i ?c)
      (hand-empty ?m)
    )
    :effect (and
      (not (item-at ?i ?c))
      (not (hand-empty ?m))
      (holding-item ?m ?i)
    )
  )

  (:action putdown-item
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (minebot-at ?m ?c)
      (holding-item ?m ?i)
    )
    :effect (and
      (not (holding-item ?m ?i))
      (hand-empty ?m)
      (item-at ?i ?c)
    )
  )

  (:action use-lift
    :parameters (?m - minebot ?l - lift ?from - cell ?to - cell)
    :precondition (and
      (minebot-at ?m ?from)
      (lift-at ?l ?from)
      (lift-connects ?l ?from ?to)
    )
    :effect (and
      (not (minebot-at ?m ?from))
      (minebot-at ?m ?to)
    )
  )

  (:action break-rock
    :parameters (?m - minebot ?r - rock ?c - cell)
    :precondition (and
      (minebot-at ?m ?c)
      (rock-at ?r ?c)
      (hand-empty ?m)
    )
    :effect (and
      (not (rock-at ?r ?c))
    )
  )
)
