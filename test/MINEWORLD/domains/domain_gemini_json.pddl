(define (domain minebot-world)
  (:requirements :typing)

  (:types
    minebot
    cell
    item
    lift
    rock
    ore
    - object
  )

  (:predicates
    (is-blocked ?c - cell)
    (empty-hand ?m - minebot)
    (is-on-ground ?i - item)
    (is-at-top-level ?l - lift)
    (is-broken ?r - rock)
    (is-mined ?o - ore)
    (at ?obj - object ?loc - cell)
    (connected ?from - cell ?to - cell)
    (holding ?m - minebot ?i - item)
  )

  (:action move
    :parameters (?m - minebot ?from - cell ?to - cell)
    :precondition (and
      (at ?m ?from)
      (connected ?from ?to)
      (not (is-blocked ?to))
    )
    :effect (and
      (not (at ?m ?from))
      (at ?m ?to)
    )
  )

  (:action pick-up
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (at ?m ?c)
      (at ?i ?c)
      (is-on-ground ?i)
      (empty-hand ?m)
    )
    :effect (and
      (not (empty-hand ?m))
      (holding ?m ?i)
      (not (at ?i ?c))
      (not (is-on-ground ?i))
    )
  )

  (:action put-down
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (at ?m ?c)
      (holding ?m ?i)
    )
    :effect (and
      (not (holding ?m ?i))
      (empty-hand ?m)
      (at ?i ?c)
      (is-on-ground ?i)
    )
  )

  (:action use-lift-to-top
    :parameters (?m - minebot ?l - lift ?c - cell)
    :precondition (and
      (at ?m ?c)
      (at ?l ?c)
      (not (is-at-top-level ?l))
    )
    :effect (and
      (is-at-top-level ?l)
    )
  )

  (:action use-lift-to-bottom
    :parameters (?m - minebot ?l - lift ?c - cell)
    :precondition (and
      (at ?m ?c)
      (at ?l ?c)
      (is-at-top-level ?l)
    )
    :effect (and
      (not (is-at-top-level ?l))
    )
  )

  (:action break-rock
    :parameters (?m - minebot ?r - rock ?c - cell)
    :precondition (and
      (at ?m ?c)
      (at ?r ?c)
      (is-blocked ?c)
      (not (is-broken ?r))
    )
    :effect (and
      (not (is-blocked ?c))
      (is-broken ?r)
    )
  )

  (:action mine-ore
    :parameters (?m - minebot ?o - ore ?c - cell)
    :precondition (and
      (at ?m ?c)
      (at ?o ?c)
      (not (is-mined ?o))
    )
    :effect (and
      (is-mined ?o)
    )
  )
)