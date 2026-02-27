
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
	:precondition (and (is-at-robot ?dwr ?from))
	:effect (and (not (is-at-robot ?dwr ?from)) (is-at-robot ?dwr ?to))
  )
  (:action lift
	:parameters (?cr - crane ?c - container ?l - location)
	:precondition (and (crane-at-crane ?cr ?l) (located-in-container ?c ?l) (is-available-crane ?cr))
	:effect (and (not (is-available-crane ?cr)) (not (located-in-container ?c ?l)) (is-lifting-crane ?cr ?c))
  )
  (:action drop
	:parameters (?cr - crane ?c - container ?l - location)
	:precondition (and (crane-at-crane ?cr ?l) (is-lifting-crane ?cr ?c))
	:effect (and (not (is-lifting-crane ?cr ?c)) (is-available-crane ?cr) (located-in-container ?c ?l))
  )
  (:action load
	:parameters (?dwr - dockworkerrobot ?c - container ?cr - crane ?l - location)
	:precondition (and (is-at-robot ?dwr ?l) (crane-at-crane ?cr ?l) (is-lifting-crane ?cr ?c) (is-unloaded-dockworkerrobot ?dwr))
	:effect (and (not (is-lifting-crane ?cr ?c)) (is-available-crane ?cr) (not (is-unloaded-dockworkerrobot ?dwr)) (is-carrying-dockworkerrobot ?dwr ?c))
  )
  (:action unload
	:parameters (?dwr - dockworkerrobot ?c - container ?cr - crane ?l - location)
	:precondition (and (is-at-robot ?dwr ?l) (crane-at-crane ?cr ?l) (is-carrying-dockworkerrobot ?dwr ?c) (is-available-crane ?cr))
	:effect (and (not (is-carrying-dockworkerrobot ?dwr ?c)) (is-unloaded-dockworkerrobot ?dwr) (not (is-available-crane ?cr)) (is-lifting-crane ?cr ?c))
  )
)