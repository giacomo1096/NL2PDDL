(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robot location container crane
    dockworkerrobot - robot
  )

(:predicates
    (is-at-robot ?arg0 - robot ?arg1 - location)
    (is-carrying-dockworkerrobot ?arg0 - dockworkerrobot ?arg1 - container)
    (is-unloaded-dockworkerrobot ?arg0 - dockworkerrobot)
    (located-in-container ?arg0 - container ?arg1 - location)
    (crane-at-crane ?arg0 - crane ?arg1 - location)
    (is-lifting-crane ?arg0 - crane ?arg1 - container)
    (is-available-crane ?arg0 - crane)
)

(:action move
	:parameters (?dwr - dockworkerrobot ?from - location ?to - location)
	:precondition (and (is-at ?dwr ?from))
	:effect (and (not (is-at ?dwr ?from)) (is-at ?dwr ?to))
)
(:action lift
	:parameters (?cr - crane ?c - container ?l - location)
	:precondition (and (crane-at ?cr ?l) (located-in ?c ?l) (is-available ?cr))
	:effect (and (not (is-available ?cr)) (not (located-in ?c ?l)) (is-lifting ?cr ?c))
)
(:action drop
	:parameters (?cr - crane ?c - container ?l - location)
	:precondition (and (crane-at ?cr ?l) (is-lifting ?cr ?c))
	:effect (and (not (is-lifting ?cr ?c)) (is-available ?cr) (located-in ?c ?l))
)
(:action load
	:parameters (?dwr - dockworkerrobot ?c - container ?cr - crane ?l - location)
	:precondition (and (is-at ?dwr ?l) (crane-at ?cr ?l) (is-lifting ?cr ?c) (is-unloaded ?dwr))
	:effect (and (not (is-lifting ?cr ?c)) (is-available ?cr) (not (is-unloaded ?dwr)) (is-carrying ?dwr ?c))
)
(:action unload
	:parameters (?dwr - dockworkerrobot ?c - container ?cr - crane ?l - location)
	:precondition (and (is-at ?dwr ?l) (crane-at ?cr ?l) (is-carrying ?dwr ?c) (is-available ?cr))
	:effect (and (not (is-carrying ?dwr ?c)) (is-unloaded ?dwr) (not (is-available ?cr)) (is-lifting ?cr ?c))
))
