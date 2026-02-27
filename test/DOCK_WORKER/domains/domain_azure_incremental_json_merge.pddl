(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types 
        robot agent container crane location harbor
    )

:predicates
  (is-idle)
  (is-loaded)
  (is-operational)
  (has-dock)
  (has-container)

:function
  (battery-level) - numeric

(:action move-robot
  :parameters (?r - robot ?from - location ?to - location)
  :precondition (and (is-idle ?r) (has-dock ?from) (has-dock ?to) (> (battery-level ?r) 0))
  :effect (and (not (has-dock ?from)) (has-dock ?to) (decrease (battery-level ?r) 1)
)

(:action load-container
  :parameters (?c - container ?cr - crane ?l - location)
  :precondition (and (is-operational ?cr) (has-dock ?l) (has-container ?l ?c) (not (is-loaded ?c)))
  :effect (and (not (has-container ?l ?c)) (is-loaded ?c)
)

(:action unload-container
  :parameters (?c - container ?cr - crane ?l - location)
  :precondition (and (is-operational ?cr) (has-dock ?l) (not (has-container ?l ?c)) (is-loaded ?c))
  :effect (and (has-container ?l ?c) (not (is-loaded ?c))
))
