(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    minebot cell item lift rock ore
  )

(:predicates
    ;; minebot predicates
    (at ?b - minebot ?c - cell)
    (holding ?b - minebot ?i - item)
    (near-lift ?b - minebot ?l - lift)
    (can-mine ?b - minebot)

    ;; cell predicates
    (connected ?c1 - cell ?c2 - cell)
    (has-rock ?c - cell)
    (has-ore ?c - cell)
    (has-item ?c - cell ?i - item)
    (has-lift ?c - cell)

    ;; item predicates
    (is-mined ?i - item)
    (is-placed ?i - item)

    ;; lift predicates
    (operational ?l - lift)
    (occupied ?l - lift ?b - minebot)

    ;; rock predicates
    (broken ?r - rock)

    ;; ore predicates
    (extracted ?o - ore)
)

(:functions
    ;; minebot functions
    (battery-level ?b - minebot)

    ;; lift functions
    (current-floor ?l - lift)

    ;; rock functions
    (hardness ?r - rock)

    ;; ore functions
    (value ?o - ore)
)


(:action move
  :parameters (?b - minebot ?from - cell ?to - cell)
  :precondition (and (at ?b ?from) (connected ?from ?to) (> (battery-level ?b) 0))
  :effect (and (not (at ?b ?from)) (at ?b ?to) (decrease (battery-level ?b) 1))
)

(:action pick-up
  :parameters (?b - minebot ?i - item ?c - cell)
  :precondition (and (at ?b ?c) (has-item ?c ?i) (not (holding ?b ?i)))
  :effect (and (not (has-item ?c ?i)) (holding ?b ?i) (not (is-placed ?i)))
)

(:action put-down
  :parameters (?b - minebot ?i - item ?c - cell)
  :precondition (and (at ?b ?c) (holding ?b ?i) (not (has-item ?c ?i)))
  :effect (and (not (holding ?b ?i)) (has-item ?c ?i) (is-placed ?i))
)

(:action break-rock
  :parameters (?b - minebot ?r - rock ?c - cell)
  :precondition (and (at ?b ?c) (has-rock ?c) (not (broken ?r)) (> (battery-level ?b) 0) (can-mine ?b))
  :effect (and (broken ?r) (not (has-rock ?c)) (decrease (battery-level ?b) (hardness ?r)))
)

(:action mine-ore
  :parameters (?b - minebot ?o - ore ?c - cell ?i - item)
  :precondition (and (at ?b ?c) (has-ore ?c) (not (extracted ?o)) (not (holding ?b ?i)) (can-mine ?b) (> (battery-level ?b) 0))
  :effect (and (extracted ?o) (not (has-ore ?c)) (holding ?b ?i) (is-mined ?i) (decrease (battery-level ?b) 1))
)

(:action use-lift
  :parameters (?b - minebot ?l - lift ?c - cell ? )
