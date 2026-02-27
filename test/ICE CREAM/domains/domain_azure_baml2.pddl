(define (domain icecream)
  (:requirements :strips :typing)

  (:types
    icecreamorder
    ingredient
    package
    delivery
    order
  )

  (:predicates
    (has-ingredient ?o - icecreamorder ?i - ingredient)
    (packaged ?o - icecreamorder)
    (delivered ?o - icecreamorder)
    (contains-order ?p - package ?o - icecreamorder)
    (delivered ?p - package)
    (delivers-package ?d - delivery ?p - package)
    (fulfilled ?ord - order)
  )

  (:action add-ingredient
    :parameters (?o - icecreamorder ?i - ingredient)
    :precondition (and (not (has-ingredient ?o ?i)) (not (packaged ?o)))
    :effect (and (has-ingredient ?o ?i))
  )

  (:action package-icecreamorder
    :parameters (?p - package ?o - icecreamorder)
    :precondition (and (not (packaged ?o)) (not (contains-order ?p ?o)))
    :effect (and (packaged ?o) (contains-order ?p ?o))
  )

  (:action deliver-package
    :parameters (?d - delivery ?p - package ?o - icecreamorder)
    :precondition (and (contains-order ?p ?o) (packaged ?o) (not (delivers-package ?d ?p)) (not (delivered ?p)) (not (delivered ?o)))
    :effect (and (delivers-package ?d ?p) (delivered ?p) (delivered ?o))
  )

  (:action fulfill-order
    :parameters (?o - icecreamorder ?ord - order)
    :precondition (and (delivered ?o) (not (fulfilled ?ord)))
    :effect (and (fulfilled ?ord))
  )
)