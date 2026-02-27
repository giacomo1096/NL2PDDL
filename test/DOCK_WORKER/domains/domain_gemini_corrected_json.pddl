
(define (domain dock-worker-robot)
  (:requirements :typing :fluents)
  (:types
    robot location container crane
    dockworkerrobot - robot
  )

  (:predicates
    (is-at-robot ?r - robot ?l - location)
    (is-carrying ?dwr - dockworkerrobot ?c - container)
    (is-unloaded ?dwr - dockworkerrobot)
    (container-at ?c - container ?l - location)
    (crane-at ?cr - crane ?l - location)
    (is-lifting ?cr - crane ?c - container)
    (is-available ?cr - crane)
  )

  (:action move
    :parameters (?dwr - dockworkerrobot ?from - location ?to - location)
    :precondition (and 
        (is-at-robot ?dwr ?from)
    )
    :effect (and 
        (not (is-at-robot ?dwr ?from)) 
        (is-at-robot ?dwr ?to)
    )
  )

  (:action lift
    :parameters (?cr - crane ?c - container ?l - location)
    :precondition (and 
        (crane-at ?cr ?l) 
        (container-at ?c ?l) 
        (is-available ?cr)
    )
    :effect (and 
        (not (is-available ?cr)) 
        (not (container-at ?c ?l)) 
        (is-lifting ?cr ?c)
    )
  )

  (:action drop
    :parameters (?cr - crane ?c - container ?l - location)
    :precondition (and 
        (crane-at ?cr ?l) 
        (is-lifting ?cr ?c)
    )
    :effect (and 
        (not (is-lifting ?cr ?c)) 
        (is-available ?cr) 
        (container-at ?c ?l)
    )
  )

  (:action load
    :parameters (?dwr - dockworkerrobot ?c - container ?cr - crane ?l - location)
    :precondition (and 
        (is-at-robot ?dwr ?l) 
        (crane-at ?cr ?l) 
        (is-lifting ?cr ?c) 
        (is-unloaded ?dwr)
    )
    :effect (and 
        (not (is-lifting ?cr ?c)) 
        (is-available ?cr) 
        (not (is-unloaded ?dwr)) 
        (is-carrying ?dwr ?c)
    )
  )

  (:action unload
    :parameters (?dwr - dockworkerrobot ?c - container ?cr - crane ?l - location)
    :precondition (and 
        (is-at-robot ?dwr ?l) 
        (crane-at ?cr ?l) 
        (is-carrying ?dwr ?c) 
        (is-available ?cr)
    )
    :effect (and 
        (not (is-carrying ?dwr ?c)) 
        (is-unloaded ?dwr) 
        (not (is-available ?cr)) 
        (is-lifting ?cr ?c)
    )
  )
)