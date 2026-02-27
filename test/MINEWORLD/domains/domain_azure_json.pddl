(define (domain minebot-domain)
  (:requirements :strips :typing)
  (:types
    agent
    minebot - agent
    mine
    cell
    item
    lift
    rock
    ore
  )

  (:predicates
    ;; agent
    (is-active ?a - agent)

    ;; minebot
    (at-cell ?m - minebot ?c - cell)
    (carrying ?m - minebot ?i - item)
    (in-lift ?m - minebot ?l - lift)

    ;; mine
    (is-operational ?mn - mine)

    ;; cell
    (has-rock ?c - cell)
    (has-ore ?c - cell)
    (has-lift ?c - cell)
    (is-accessible ?c - cell)

    ;; item
    (is-picked-up ?i - item)
    (is-placed ?i - item ?c - cell)

    ;; lift
    (is-at-cell ?l - lift ?c - cell)
    (is-operational ?l - lift)

    ;; rock
    (is-broken ?r - rock)

    ;; ore
    (is-mined ?o - ore)
    (is-collected ?o - ore)
  )

  (:action move
    :parameters (?m - minebot ?from - cell ?to - cell)
    :precondition (and
      (at-cell ?m ?from)
      (is-accessible ?to)
      (not (= ?from ?to))
    )
    :effect (and
      (not (at-cell ?m ?from))
      (at-cell ?m ?to)
    )
  )

  (:action pick-up
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (is-placed ?i ?c)
      (not (carrying ?m ?i))
      (not (is-picked-up ?i))
    )
    :effect (and
      (carrying ?m ?i)
      (is-picked-up ?i)
      (not (is-placed ?i ?c))
    )
  )

  (:action put-down
    :parameters (?m - minebot ?i - item ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (carrying ?m ?i)
    )
    :effect (and
      (not (carrying ?m ?i))
      (is-placed ?i ?c)
      (not (is-picked-up ?i))
    )
  )

  (:action enter-lift
    :parameters (?m - minebot ?l - lift ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (is-at-cell ?l ?c)
      (not (in-lift ?m ?l))
    )
    :effect (and
      (in-lift ?m ?l)
      (not (at-cell ?m ?c))
    )
  )

  (:action exit-lift
    :parameters (?m - minebot ?l - lift ?c - cell)
    :precondition (and
      (in-lift ?m ?l)
      (is-at-cell ?l ?c)
    )
    :effect (and
      (not (in-lift ?m ?l))
      (at-cell ?m ?c)
    )
  )

  (:action move-lift
    :parameters (?l - lift ?from - cell ?to - cell)
    :precondition (and
      (is-at-cell ?l ?from)
      (is-accessible ?to)
      (not (= ?from ?to))
      (is-operational ?l)
    )
    :effect (and
      (not (is-at-cell ?l ?from))
      (is-at-cell ?l ?to)
    )
  )

  (:action break-rock
    :parameters (?m - minebot ?r - rock ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (has-rock ?c)
      (not (is-broken ?r))
    )
    :effect (and
      (is-broken ?r)
      (not (has-rock ?c))
    )
  )

  (:action mine-ore
    :parameters (?m - minebot ?o - ore ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (has-ore ?c)
      (not (is-mined ?o))
    )
    :effect (and
      (is-mined ?o)
      (not (has-ore ?c))
    )
  )

  (:action collect-ore
    :parameters (?m - minebot ?o - ore ?c - cell)
    :precondition (and
      (at-cell ?m ?c)
      (is-mined ?o)
      (not (is-collected ?o))
    )
    :effect (and
      (is-collected ?o)
    )
  )
)