(define (domain vgdl)
  (:requirements :strips :typing)

  (:types
    wall sword dirt exitdoor diamond boulder crab butterfly - object
    object avatar grid position orientation game
  )

  (:predicates
    (at-object ?o - object ?p - position)
    (has-orientation-object ?o - object ?ori - orientation)
    (at-wall ?w - wall ?p - position)
    (at-sword ?s - sword ?p - position)
    (at-dirt ?d - dirt ?p - position)
    (is-destroyed-dirt ?d - dirt)
    (at-exitdoor ?e - exitdoor ?p - position)
    (is-open-exitdoor ?e - exitdoor)
    (at-diamond ?d - diamond ?p - position)
    (is-collected-diamond ?d - diamond)
    (at-boulder ?b - boulder ?p - position)
    (is-movable-boulder ?b - boulder)
    (at-crab ?c - crab ?p - position)
    (has-orientation-crab ?c - crab ?ori - orientation)
    (is-alive-crab ?c - crab)
    (at-butterfly ?b - butterfly ?p - position)
    (has-orientation-butterfly ?b - butterfly ?ori - orientation)
    (is-alive-butterfly ?b - butterfly)
    (at-avatar ?a - avatar ?p - position)
    (has-orientation-avatar ?a - avatar ?ori - orientation)
    (is-alive-avatar ?a - avatar)
    (is-occupied-position ?p - position)
  )

  (:action move-avatar
    :parameters (?a - avatar ?from - position ?to - position)
    :precondition (and (at-avatar ?a ?from) (is-alive-avatar ?a) (not (is-occupied-position ?to)))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to))
  )

  (:action turn-avatar
    :parameters (?a - avatar ?ori - orientation)
    :precondition (and (is-alive-avatar ?a))
    :effect (and (has-orientation-avatar ?a ?ori))
  )

  (:action collect-diamond
    :parameters (?a - avatar ?d - diamond ?p - position)
    :precondition (and (at-avatar ?a ?p) (at-diamond ?d ?p) (not (is-collected-diamond ?d)))
    :effect (and (is-collected-diamond ?d) (not (at-diamond ?d ?p)))
  )

  (:action destroy-dirt
    :parameters (?a - avatar ?d - dirt ?p - position)
    :precondition (and (at-avatar ?a ?p) (at-dirt ?d ?p) (not (is-destroyed-dirt ?d)))
    :effect (and (is-destroyed-dirt ?d) (not (at-dirt ?d ?p)))
  )

  (:action open-exitdoor
    :parameters (?a - avatar ?e - exitdoor ?p - position)
    :precondition (and (at-avatar ?a ?p) (at-exitdoor ?e ?p) (not (is-open-exitdoor ?e)))
    :effect (and (is-open-exitdoor ?e))
  )

  (:action exit-level
    :parameters (?a - avatar ?e - exitdoor ?p - position)
    :precondition (and (at-avatar ?a ?p) (at-exitdoor ?e ?p) (is-open-exitdoor ?e))
    :effect (and (not (is-alive-avatar ?a)))
  )

  (:action push-boulder
    :parameters (?a - avatar ?b - boulder ?from - position ?to - position ?next - position)
    :precondition (and (at-avatar ?a ?from) (at-boulder ?b ?to) (is-movable-boulder ?b) (not (is-occupied-position ?next)))
    :effect (and (not (at-boulder ?b ?to)) (at-boulder ?b ?next) (not (at-avatar ?a ?from)) (at-avatar ?a ?to))
  )

  (:action pick-up-sword
    :parameters (?a - avatar ?s - sword ?p - position)
    :precondition (and (at-avatar ?a ?p) (at-sword ?s ?p))
    :effect (and (not (at-sword ?s ?p)))
  )

  (:action attack-crab
    :parameters (?a - avatar ?c - crab ?p - position)
    :precondition (and (at-avatar ?a ?p) (at-crab ?c ?p) (is-alive-crab ?c))
    :effect (and (not (is-alive-crab ?c)) (not (at-crab ?c ?p)))
  )

  (:action attack-butterfly
    :parameters (?a - avatar ?b - butterfly ?p - position)
    :precondition (and (at-avatar ?a ?p) (at-butterfly ?b ?p) (is-alive-butterfly ?b))
    :effect (and (not (is-alive-butterfly ?b)) (not (at-butterfly ?b ?p)))
  )

  (:action crab-move
    :parameters (?c - crab ?from - position ?to - position)
    :precondition (and (at-crab ?c ?from) (is-alive-crab ?c) (not (is-occupied-position ?to)))
    :effect (and (not (at-crab ?c ?from)) (at-crab ?c ?to))
  )

  (:action crab-turn
    :parameters (?c - crab ?ori - orientation)
    :precondition (and (is-alive-crab ?c))
    :effect (and (has-orientation-crab ?c ?ori))
  )

  (:action butterfly-move
    :parameters (?b - butterfly ?from - position ?to - position)
    :precondition (and (at-butterfly ?b ?from) (is-alive-butterfly ?b) (not (is-occupied-position ?to)))
    :effect (and (not (at-butterfly ?b ?from)) (at-butterfly ?b ?to))
  )

  (:action butterfly-turn
    :parameters (?b - butterfly ?ori - orientation)
    :precondition (and (is-alive-butterfly ?b))
    :effect (and (has-orientation-butterfly ?b ?ori))
  )

  (:action avatar-die
    :parameters (?a - avatar)
    :precondition (and (is-alive-avatar ?a))
    :effect (and (not (is-alive-avatar ?a)))
  )
)