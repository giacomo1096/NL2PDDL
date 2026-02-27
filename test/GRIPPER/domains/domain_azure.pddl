(define (domain structured-analysis)
  (:requirements :typing :fluents)
  
  (:types agent robot - agent gripper object room)
  
  (:predicates
    (is-operational ?r - robot)
    (has-gripper ?a - agent)
    (has-object ?r - room)
    (is-fixed ?o - object)
    (battery-level ?r - robot ?level - number)
  )
  
  (:action navigate
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (and (at ?r ?from) (is-operational ?r))
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )
  
  (:action fix_object
    :parameters (?r - robot ?o - object)
    :precondition (and (at ?r ?room) (is-operational ?r) (has-gripper ?r))
    :effect (is-fixed ?o)
  )
)