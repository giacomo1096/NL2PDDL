
(define (domain mine-world)
  (:requirements :typing)
  
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
    
    ;; mine
    (is-operational ?m - mine)
    
    ;; minebot
    (at-cell ?mb - minebot ?c - cell)
    (carrying ?mb - minebot ?i - item)
    (in-lift ?mb - minebot ?l - lift)
    
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
    :parameters (?mb - minebot ?from - cell ?to - cell)
    :precondition (and
      (at-cell ?mb ?from)
      (is-accessible ?to)
      (not (= ?from ?to))
    )
    :effect (and
      (not (at-cell ?mb ?from))
      (at-cell ?mb ?to)
    )
  )

  (:action pick-up
    :parameters (?mb - minebot ?i - item ?c - cell)
    :precondition (and
      (at-cell ?mb ?c)
      (is-placed ?i ?c)
      (not (carrying ?mb ?i))
      (not (is-picked-up ?i))
    )
    :effect (and
      (carrying ?mb ?i)
      (is-picked-up ?i)
      (not (is-placed ?i ?c))
    )
  )

  (:action put-down
    :parameters (?mb - minebot ?i - item ?c - cell)
    :precondition (and
      (at-cell ?mb ?c)
      (carrying ?mb ?i)
    )
    :effect (and
      (not (carrying ?mb ?i))
      (is-placed ?i ?c)
      (not (is-picked-up ?i))
    )
  )

  (:action enter-lift
    :parameters (?mb - minebot ?l - lift ?c - cell)
    :precondition (and
      (at-cell ?mb ?c)
      (is-at-cell ?l ?c)
      (not (in-lift ?mb ?l))
    )
    :effect (and
      (in-lift ?mb ?l)
      (not (at-cell ?mb ?c))
    )
  )

  (:action exit-lift
    :parameters (?mb - minebot ?l - lift ?c - cell)
    :precondition (and
      (in-lift ?mb ?l)
      (is-at-cell ?l ?c)
    )
    :effect (and
      (not (in-lift ?mb ?l))
      (at-cell ?mb ?c)
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
    :parameters (?mb - minebot ?r - rock ?c - cell)
    :precondition (and
      (at-cell ?mb ?c)
      (has-rock ?c)
      (not (is-broken ?r))
    )
    :effect (and
      (is-broken ?r)
      (not (has-rock ?c))
    )
  )

  (:action mine-ore
    :parameters (?mb - minebot ?o - ore ?c - cell)
    :precondition (and
      (at-cell ?mb ?c)
      (has-ore ?c)
      (not (is-mined ?o))
    )
    :effect (and
      (is-mined ?o)
      (not (has-ore ?c))
    )
  )

  (:action collect-ore
    :parameters (?mb - minebot ?o - ore ?c - cell)
    :precondition (and
      (at-cell ?mb ?c)
      (is-mined ?o)
      (not (is-collected ?o))
    )
    :effect (and
      (is-collected ?o)
    )
  )
)
