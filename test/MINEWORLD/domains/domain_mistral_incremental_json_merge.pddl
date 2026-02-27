(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    minebot cell item lift rock ore - object
  )


(:predicates
	(at ?b - minebot ?c - cell)
	(holding ?b - minebot ?i - item)
	(near-lift ?b - minebot ?l - lift)
	(can-mine ?b - minebot)
	(connected ?c1 - cell ?c2 - cell)
	(has-rock ?c - cell)
	(has-ore ?c - cell)
	(has-lift ?c - cell)
	(operational ?l - lift)
	(occupied ?l - lift ?b - minebot)
	(broken ?r - rock)
	(extracted ?o - ore)
)

(:functions
	(battery-level ?b - minebot)
	(current-floor ?l - lift)
	(hardness ?r - rock)
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
  :effect (and (not (has-item ?c ?i)) (holding ?b ?i))
)

(:action put-down
  :parameters (?b - minebot ?i - item ?c - cell)
  :precondition (and (at ?b ?c) (holding ?b ?i) (not (has-item ?c ?i)))
  :effect (and (not (holding ?b ?i)) (has-item ?c ?i))
)

(:action break-rock
  :parameters (?b - minebot ?r - rock ?c - cell)
  :precondition (and (at ?b ?c) (has-rock ?c) (not (broken ?r)) (> (battery-level ?b) 0) (can-mine ?b))
  :effect (and (broken ?r) (decrease (battery-level ?b) (hardness ?r)))
))
