(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types
        object
    )

(:predicates
  (has-gripper)
  (equipped-with-gripper)
  (requires-fixing)
  (contains-object)
)

(:action navigate
  :parameters (?r - robot ?from - room ?to - room)
  :precondition (and (robot-at ?r ?from) (contains-object ?from ?o) (equipped-with-gripper ?r))
  :effect (and (not (robot-at ?r ?from)) (robot-at ?r ?to) (decrease (battery-level ?r) 1)
))

(:action fix_object
  :parameters (?r - robot ?o - object)
  :precondition (and (robot-at ?r ?r) (contains-object ?r ?o) (requires-fixing ?o) (equipped-with-gripper ?r))
  :effect (and (not (requires-fixing ?o)) (not (contains-object ?r ?o))
)))
