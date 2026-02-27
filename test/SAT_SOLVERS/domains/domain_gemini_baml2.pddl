(define (domain sat)
  (:requirements :strips :typing :negative-preconditions :conditional-effects)

  (:types
    variable
    clause
  )

  (:predicates
    (value-true ?v - variable)
    (value-false ?v - variable)
    (unassigned ?v - variable)
    (in-clause-pos ?v - variable ?c - clause)
    (in-clause-neg ?v - variable ?c - clause)
    (satisfied ?c - clause)
  )

  (:action set-true
    :parameters (?v - variable)
    :precondition (and (not (value-true ?v)) (not (value-false ?v)))
    :effect (and (value-true ?v)
                 (forall (?c - clause)
                   (when (in-clause-pos ?v ?c)
                     (satisfied ?c))))
  )

  (:action set-false
    :parameters (?v - variable)
    :precondition (and (not (value-true ?v)) (not (value-false ?v)))
    :effect (and (value-false ?v)
                 (forall (?c - clause)
                   (when (in-clause-neg ?v ?c)
                     (satisfied ?c))))
  )
)