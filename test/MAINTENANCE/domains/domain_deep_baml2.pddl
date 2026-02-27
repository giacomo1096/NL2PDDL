(define (domain airplane-maintenance)
  (:requirements :strips :typing :negative-preconditions)
  (:types
    airplane
    mechanic
    airport
    day
  )
  (:predicates
    (scheduled-at ?a - airplane ?ap - airport ?d - day)
    (maintenance-performed ?a - airplane ?ap - airport ?d - day)
    (assigned-to ?m - mechanic ?ap - airport ?d - day)
  )
  (:action assign-mechanic
    :parameters (?m - mechanic ?ap - airport ?d - day)
    :precondition (and
      (not (assigned-to ?m ?ap ?d))
    )
    :effect (and
      (assigned-to ?m ?ap ?d)
    )
  )
  (:action unassign-mechanic
    :parameters (?m - mechanic ?ap - airport ?d - day)
    :precondition (and
      (assigned-to ?m ?ap ?d)
    )
    :effect (and
      (not (assigned-to ?m ?ap ?d))
    )
  )
  (:action perform-maintenance
    :parameters (?m - mechanic ?a - airplane ?ap - airport ?d - day)
    :precondition (and
      (scheduled-at ?a ?ap ?d)
      (assigned-to ?m ?ap ?d)
      (not (maintenance-performed ?a ?ap ?d))
    )
    :effect (and
      (maintenance-performed ?a ?ap ?d)
    )
  )
)