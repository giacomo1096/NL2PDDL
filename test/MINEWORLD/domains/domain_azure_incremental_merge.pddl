(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types robot minebot - robot cell item lift rock ore environment)


(:predicates
  (robot-is-moving)
  (robot-has-item)
  (robot-battery-level)

  (minebot-is-navigating)
  (minebot-is-mining)
  (minebot-fuel-level)

  (cell-is-occupied)
  (cell-has-item)

  (item-is-picked-up)
  (item-is-put-down)

  (lift-is-operational)
  (lift-has-minebot)

  (rock-is-broken)
  (rock-has-ore)

  (ore-is-mined)
  (ore-is-processed)

  (environment-has-obstacle)
  (environment-has-resource)
)

(:action move
    :parameters (?mb - minebot ?from - cell ?to - cell)
    :precondition (and (is-navigating ?mb) (is-occupied ?from) (not (is-occupied ?to)))
    :effect (and (not (is-occupied ?from)) (is-occupied ?to)))

(:action pick-up
    :parameters (?mb - minebot ?item - item ?from - cell)
    :precondition (and (is-navigating ?mb) (is-occupied ?from) (has-item ?item) (not (is-picked-up ?item)))
    :effect (and (not (has-item ?item)) (is-picked-up ?item)))

(:action put-down
    :parameters (?mb - minebot ?item - item ?to - cell)
    :precondition (and (is-navigating ?mb) (is-occupied ?to) (is-picked-up ?item) (not (has-item ?item)))
    :effect (and (not (is-picked-up ?item)) (has-item ?item)))

(:action use-lift
    :parameters (?mb - minebot ?lift - lift ?from - cell ?to - cell)
    :precondition (and (is-navigating ?mb) (is-occupied ?from) (is-operational ?lift) (has-minebot ?lift) (not (is-occupied ?to)))
    :effect (and (not (is-occupied ?from)) (is-occupied ?to)))

(:action break-rock
    :parameters (?mb - minebot ?rock - rock ?cell - cell)
    :precondition (and (is-navigating ?mb) (is-occupied ?cell) (not (is-broken ?rock)))
    :effect (and (not (has-ore ?rock)) (is-broken ?rock)))

(:action mine-ore
    :parameters (?mb - minebot ?ore - ore ?rock - rock)
    :precondition (and (is-navigating ?mb) (is-broken ?rock) (not (is-mined ?ore)))
    :effect (and (not (has-ore ?rock)) (is-mined ?ore)))

(:action process-ore
    :parameters (?mb - minebot ?ore - ore)
    :precondition (and (is-navigating ?mb) (is-mined ?ore) (not (is-processed ?ore)))
    :effect (is-processed ?ore)))
