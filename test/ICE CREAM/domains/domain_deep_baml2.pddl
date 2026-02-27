(define (domain ice-cream-assembly)
  (:requirements :strips :typing :negative-preconditions :conditional-effects)
  (:types
    ice-cream-order
    ingredient
    assembled-ice-cream
  )
  (:predicates
    (has-ingredient ?o - ice-cream-order ?i - ingredient)
    (assembled-from ?a - assembled-ice-cream ?o - ice-cream-order)
    (packaged ?a - assembled-ice-cream)
    (delivered ?a - assembled-ice-cream)
  )
  (:action add-ingredient
    :parameters (?o - ice-cream-order ?i - ingredient)
    :precondition (not (has-ingredient ?o ?i))
    :effect (has-ingredient ?o ?i)
  )
  (:action assemble
    :parameters (?a - assembled-ice-cream ?o - ice-cream-order)
    :precondition (and (not (packaged ?a)) (not (delivered ?a)))
    :effect (and
              (forall (?o2 - ice-cream-order)
                (not (assembled-from ?a ?o2))
              )
              (assembled-from ?a ?o)
            )
  )
  (:action package
    :parameters (?a - assembled-ice-cream ?o - ice-cream-order)
    :precondition (and (assembled-from ?a ?o) (not (packaged ?a)))
    :effect (packaged ?a)
  )
  (:action deliver
    :parameters (?a - assembled-ice-cream ?o - ice-cream-order)
    :precondition (and (assembled-from ?a ?o) (packaged ?a) (not (delivered ?a)))
    :effect (delivered ?a)
  )
)