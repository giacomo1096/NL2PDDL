(define (domain sat)
  (:requirements :strips :typing)

  (:types
    variable
    clause
  )

  (:predicates
    (assigned-true ?v - variable)
    (assigned-false ?v - variable)
    (satisfied ?c - clause)
  )

  (:action assign-variable-true
    :parameters (?v - variable)
    :precondition (and (not (assigned-true ?v)) (not (assigned-false ?v)))
    :effect (and (assigned-true ?v) (not (assigned-false ?v)))
  )

  (:action assign-variable-false
    :parameters (?v - variable)
    :precondition (and (not (assigned-false ?v)) (not (assigned-true ?v)))
    :effect (and (assigned-false ?v) (not (assigned-true ?v)))
  )

  (:action satisfy-clause
    :parameters (?c - clause)
    :precondition (and (not (satisfied ?c)))
    :effect (and (satisfied ?c))
  )
)