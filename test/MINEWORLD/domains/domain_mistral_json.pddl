```pddl
(define (domain mining)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    minebot cell item lift rock ore - object
  )

  ;; Predicates
  (:predicates
    ;; Minebot predicates
    (at ?b - minebot ?c - cell)
    (holding ?b - minebot ?i - item)
    (near-lift ?b - minebot ?l - lift)
    (can-mine ?b - minebot)

    ;; Cell predicates
    (connected ?c1 - cell ?c2 - cell)
    (has-rock ?c - cell)
    (has-ore ?c - cell)
    (has-lift ?c - cell)
    (has-item ?c - cell ?i - item)

    ;; Lift predicates
    (operational ?l - lift)
    (occupied ?l - lift ?b - minebot)

    ;; Rock predicates
    (broken ?r - rock)

    ;; Ore predicates
    (extracted ?o - ore)
    (is-placed ?i - item)
  )

  ;; Functions (numeric attributes)
  (:functions
    (battery-level ?b - minebot)
    (rock-hardness ?r - rock)
    (ore-value ?o - ore)
    (distance ?c1 - cell ?c2 - cell)
  )

  ;; Actions
  (:action move
    :parameters (?b - minebot ?from - cell ?to - cell)
    :precondition (and (at ?b ?from)
                       (connected ?from ?to)
                       (> (battery-level ?b) (distance ?from ?to)))
    :effect (and (not (at ?b ?from))
                 (at ?b ?to)
                 (decrease (battery-level ?b) (distance ?from ?to)))
  )

  (:action mine-rock
    :parameters (?b - minebot ?c - cell ?r - rock)
    :precondition (and (at ?b ?c)
                       (has-rock ?c)
                       (can-mine ?b)
                       (> (battery-level ?b) (* 2 (rock-hardness ?r))))
    :effect (and (not (has-rock ?c))
                 (broken ?r)
                 (decrease (battery-level ?b) (* 2 (rock-hardness ?r