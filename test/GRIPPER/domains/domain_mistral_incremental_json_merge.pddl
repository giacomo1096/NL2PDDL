(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robot gripper object room
  )


(:predicates
    (at ?r - robot ?l - room)
    (has-gripper ?r - robot)
    (is-busy ?r - robot)
    (holding ?g - gripper ?o - object)
    (is-active ?g - gripper)
    (is-broken ?o - object)
    (is-fixed ?o - object)
    (in-room ?o - object ?l - room)
    (connected ?l1 - room ?l2 - room)
    (has-object ?l - room ?o - object)
)

(:functions
    (battery-level ?r - robot)
)


(:action move
  :parameters (?r - robot ?from - room ?to - room)
  :precondition (and (at ?r ?from) (connected ?from ?to) (> (battery-level ?r) 0) (not (is-busy ?r)))
  :effect (and (not (at ?r ?from)) (at ?r ?to) (decrease (battery-level ?r) 1))
)

(:action pick
  :parameters (?r - robot ?g - gripper ?o - object ?l - room)
  :precondition (and (at ?r ?l) (has-gripper ?r) (in-room ?o ?l) (is-broken ?o) (not (is-fixed ?o)) (not (is-busy ?r)) (not (is-active ?g)) (not (holding ?g ?o)))
  :effect (and (holding ?g ?o) (is-active ?g) (is-busy ?r))
)

(:action drop
  :parameters (?r - robot ?g - gripper ?o - object ?l - room)
  :precondition (and (at ?r ?l) (has-gripper ?r) (holding ?g ?o) (is-broken ?o) (not (is-fixed ?o)) (is-busy ?r) (is-active ?g))
  :effect (and (not (holding ?g ?o)) (not (is-active ?g)) (not (is-busy ?r)) (is-fixed ?o))
))
