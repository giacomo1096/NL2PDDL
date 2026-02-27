(define (domain icecream)
  (:requirements :strips :typing)

  (:types
    icecreamorder
    ingredient
  )

  (:predicates
    (has-ingredient ?o - icecreamorder ?i - ingredient)
    (assembled ?o - icecreamorder)
    (packaged ?o - icecreamorder)
    (delivered ?o - icecreamorder)
  )

  (:action add-ingredient
    :parameters (?o - icecreamorder ?i - ingredient)
    :precondition (and (not (assembled ?o)) (not (has-ingredient ?o ?i)))
    :effect (and (has-ingredient ?o ?i))
  )

  (:action assemble-order
    :parameters (?o - icecreamorder)
    :precondition (and (not (assembled ?o)))
    :effect (and (assembled ?o))
  )

  (:action package-order
    :parameters (?o - icecreamorder)
    :precondition (and (assembled ?o) (not (packaged ?o)))
    :effect (and (packaged ?o))
  )

  (:action deliver-order
    :parameters (?o - icecreamorder)
    :precondition (and (packaged ?o) (not (delivered ?o)))
    :effect (and (delivered ?o))
  )
)