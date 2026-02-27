(define (domain mine-world)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    minebot
    mine
    cell
    item
    lift
    rock - item
    ore - item
    environment
    object
  )

  (:predicates
    (minebot-at-cell ?m - minebot ?c - cell)
    (minebot-in-mine ?m - minebot ?mine - mine)
    (holding-item ?m - minebot ?i - item)
    (minebot-in-lift ?m - minebot ?l - lift)
    (minebot-busy ?m - minebot)
    (mine-has-cell ?mine - mine ?c - cell)
    (mine-has-lift ?mine - mine ?l - lift)
    (cell-adjacent ?c1 - cell ?c2 - cell)
    (cell-in-mine ?c - cell ?mine - mine)
    (cell-has-lift ?c - cell ?l - lift)
    (item-at-cell ?i - item ?c - cell)
    (item-in-lift ?i - item ?l - lift)
    (item-mined ?i - item)
    (lift-at-cell ?l - lift ?c - cell)
    (lift-in-mine ?l - lift ?mine - mine)
    (lift-occupied ?l - lift)
    (rock-at-cell ?r - rock ?c - cell)
    (rock-broken ?r - rock)
    (ore-at-cell ?o - ore ?c - cell)
    (ore-mined ?o - ore)
    (environment-safe)
    (object-accessible ?o - object)
  )

  (:action move
    :parameters (?m - minebot ?from - cell ?to - cell)
    :precondition (and
      (minebot-at-cell ?m ?from)
      (cell-adjacent ?from ?to)
      (not (minebot-busy ?m))
      (not (exists (?r - rock) (rock-at-cell ?r ?to)))
      (object-accessible ?to)
    )
    :effect (and
      (not (minebot-at-cell ?m ?from))
      (minebot-at-cell ?m ?to)
    )
  )

  (:action pickup-item
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (minebot-at-cell ?m ?c)
      (item-at-cell ?i ?c)
      (not (holding-item ?m ?i))
      (not (minebot-busy ?m))
      (object-accessible ?i)
      (not (exists (?r - rock) (rock-at-cell ?r ?c)))
    )
    :effect (and
      (holding-item ?m ?i)
      (not (item-at-cell ?i ?c))
    )
  )

  (:action putdown-item
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (minebot-at-cell ?m ?c)
      (holding-item ?m ?i)
      (not (minebot-busy ?m))
      (object-accessible ?c)
      (not (exists (?r - rock) (rock-at-cell ?r ?c)))
    )
    :effect (and
      (not (holding-item ?m ?i))
      (item-at-cell ?i ?c)
    )
  )

  (:action enter-lift
    :parameters (?m - minebot ?l - lift ?c - cell)
    :precondition (and
      (minebot-at-cell ?m ?c)
      (lift-at-cell ?l ?c)
      (not (minebot-in-lift ?m ?l))
      (not (lift-occupied ?l))
      (not (minebot-busy ?m))
      (object-accessible ?l)
    )
    :effect (and
      (not (minebot-at-cell ?m ?c))
      (minebot-in-lift ?m ?l)
      (lift-occupied ?l)
    )
  )

  (:action exit-lift
    :parameters (?m - minebot ?l - lift ?c - cell)
    :precondition (and
      (minebot-in-lift ?m ?l)
      (lift-at-cell ?l ?c)
      (not (minebot-busy ?m))
      (object-accessible ?c)
    )
    :effect (and
      (not (minebot-in-lift ?m ?l))
      (minebot-at-cell ?m ?c)
      (not (lift-occupied ?l))
    )
  )

  (:action load-item-into-lift
    :parameters (?m - minebot ?i - item ?l - lift ?c - cell)
    :precondition (and
      (minebot-at-cell ?m ?c)
      (lift-at-cell ?l ?c)
      (holding-item ?m ?i)
      (not (lift-occupied ?l))
      (not (minebot-busy ?m))
      (object-accessible ?l)
    )
    :effect (and
      (not (holding-item ?m ?i))
      (item-in-lift ?i ?l)
      (lift-occupied ?l)
    )
  )

  (:action unload-item-from-lift
    :parameters (?m - minebot ?i - item ?l - lift ?c - cell)
    :precondition (and
      (minebot-at-cell ?m ?c)
      (lift-at-cell ?l ?c)
      (item-in-lift ?i ?l)
      (not (holding-item ?m ?i))
      (not (minebot-busy ?m))
      (object-accessible ?l)
    )
    :effect (and
      (not (item-in-lift ?i ?l))
      (holding-item ?m ?i)
      (not (lift-occupied ?l))
    )
  )

  (:action break-rock
    :parameters (?m - minebot ?r - rock ?c - cell)
    :precondition (and
      (minebot-at-cell ?m ?c)
      (rock-at-cell ?r ?c)
      (not (rock-broken ?r))
      (not (minebot-busy ?m))
      (object-accessible ?r)
    )
    :effect (and
      (rock-broken ?r)
      (not (rock-at-cell ?r ?c))
    )
  )

  (:action mine-ore
    :parameters (?m - minebot ?o - ore ?c - cell)
    :precondition (and
      (minebot-at-cell ?m ?c)
      (ore-at-cell ?o ?c)
      (not (ore-mined ?o))
      (not (minebot-busy ?m))
      (object-accessible ?o)
      (environment-safe)
    )
    :effect (and
      (ore-mined ?o)
      (item-mined ?o)
      (not (ore-at-cell ?o ?c))
    )
  )

  (:action enter-mine
    :parameters (?m - minebot ?mine - mine ?c - cell)
    :precondition (and
      (mine-has-cell ?mine ?c)
      (minebot-at-cell ?m ?c)
      (not (minebot-in-mine ?m ?mine))
      (not (minebot-busy ?m))
      (object-accessible ?mine)
    )
    :effect (and
      (minebot-in-mine ?m ?mine)
    )
  )

  (:action exit-mine
    :parameters (?m - minebot ?mine - mine ?c - cell)
    :precondition (and
      (mine-has-cell ?mine ?c)
      (minebot-at-cell ?m ?c)
      (minebot-in-mine ?m ?mine)
      (not (minebot-busy ?m))
      (object-accessible ?mine)
    )
    :effect (and
      (not (minebot-in-mine ?m ?mine))
    )
  )

  (:action set-busy
    :parameters (?m - minebot)
    :precondition (not (minebot-busy ?m))
    :effect (minebot-busy ?m)
  )

  (:action clear-busy
    :parameters (?m - minebot)
    :precondition (minebot-busy ?m)
    :effect (not (minebot-busy ?m))
  )
)
