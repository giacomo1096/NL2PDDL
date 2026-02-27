
(define (domain robot_waiter)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    robotwaiter area plate food customer
    buffet - area
  )

  ;; Predicates
  (:predicates
    ;; Robot Waiter predicates
    (is-holding-plate ?r - robotwaiter ?p - plate)
    (is-at ?r - robotwaiter ?a - area)
    (is-empty ?r - robotwaiter)

    ;; Area predicates
    (is-adjacent ?a1 - area ?a2 - area)
    (has-buffet ?a - area)
    (has-customer ?a - area ?c - customer)

    ;; Plate predicates
    (is-empty ?p - plate)
    (is-filled ?p - plate ?f - food)
    (is-served ?p - plate ?c - customer)

    ;; Food predicates
    (is-available ?f - food ?b - buffet)

    ;; Customer predicates
    (is-served ?c - customer)
    (has-order ?c - customer ?f - food)
  )

  ;; Actions
  (:action move
    :parameters (?r - robotwaiter ?from - area ?to - area)
    :precondition (and (is-at ?r ?from) (is-adjacent ?from ?to) (not (is-holding-plate ?r ?p)))
    :effect (and (not (is-at ?r ?from)) (is-at ?r ?to))
  )

  (:action take-plate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and (is-at ?r ?a) (is-empty ?p) (not (is-holding-plate ?r ?p)))
    :effect (and (is-holding-plate ?r ?p) (not (is-empty ?r)))
  )

  (:action put-plate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and (is-at ?r ?a) (is-holding-plate ?r ?p))
    :effect (and (not (is-holding-plate ?r ?p)) (is-empty ?r) (is-empty ?p))
  )

  (:action fill-plate