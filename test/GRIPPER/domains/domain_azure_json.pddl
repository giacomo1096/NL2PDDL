(define (domain structured-analysis)
  (:requirements :typing)
  
  (:types object robot room)
  
  (:predicates
    (robot-at ?r - robot ?from - room)
    (is-operational ?r - robot)
    (has-object ?c - room ?o - object)
    (has-gripper ?r - robot)
    (is-fixed ?o - object)
  )
  
  (:action navigate
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (and (robot-at ?r ?from) (is-operational ?r))
    :effect (and (not (robot-at ?r ?from)) (robot-at ?r ?to))
  )
  
  (:action fix_object
    :parameters (?r - robot ?o - object)
    :precondition (and (robot-at ?r ?c) (has-object ?c ?o) (is-operational ?r) (has-gripper ?r))
    :effect (and (not (has-object ?c ?o)) (is-fixed ?o))
  )
)