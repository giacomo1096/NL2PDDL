(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types 
        robot
        minebot
        cell
        item
        lift
        rock
        ore
        environment
    )
    (:predicates
        (is-moving ?robot - robot)
        (has-item ?robot - robot)
        (is-navigating ?minebot - minebot)
        (is-mining ?minebot - minebot)
        (is-occupied ?cell - cell)
        (has-item ?cell - cell)
        (is-picked-up ?item - item)
        (is-put-down ?item - item)
        (is-operational ?lift - lift)
        (has-minebot ?lift - lift)
        (is-broken ?rock - rock)
        (has-ore ?rock - rock)
        (is-mined ?ore - ore)
        (is-processed ?ore - ore)
        (has-obstacle ?environment - environment)
        (has-resource ?environment - environment)
    )
    (:functions
        (battery-level)
        (fuel-level)
    )
    (:action move
        :parameters (?mb ?from ?to)
        :precondition (and (is-navigating ?mb) (is-occupied ?from) (not (is-occupied ?to)))
        :effect (and (not (is-occupied ?from)) (is-occupied ?to))
    )

    (:action pick-up
        :parameters (?mb ?from ?item)
        :precondition (and (is-navigating ?mb) (is-occupied ?from) (has-item ?item) (not (is-picked-up ?item)))
        :effect (and (not (has-item ?item)) (is-picked-up ?item))
    )

    (:action put-down
        :parameters (?mb ?to ?item)
        :precondition (and (is-navigating ?mb) (is-occupied ?to) (is-picked-up ?item) (not (has-item ?item)))
        :effect (and (not (is-picked-up ?item)) (has-item ?item))
    )

    (:action use-lift
        :parameters (?mb ?from ?to ?lift)
        :precondition (and (is-navigating ?mb) (is-occupied ?from) (is-operational ?lift) (has-minebot ?lift) (not (is-occupied ?to)))
        :effect (and (not (is-occupied ?from)) (is-occupied ?to))
    )

    (:action break-rock
        :parameters (?mb ?cell ?rock)
        :precondition (and (is-navigating ?mb) (is-occupied ?cell) (not (is-broken ?rock)))
        :effect (and (not (has-ore ?rock)) (is-broken ?rock))
    )

    (:action mine-ore
        :parameters (?mb ?rock ?ore)
        :precondition (and (is-navigating ?mb) (is-broken ?rock) (not (is-mined ?ore)))
        :effect (and (not (has-ore ?rock)) (is-mined ?ore))
    )

    (:action process-ore
        :parameters (?mb ?ore)
        :precondition (and (is-navigating ?mb) (is-mined ?ore) (not (is-processed ?ore)))
        :effect (is-processed ?ore)
    )
)