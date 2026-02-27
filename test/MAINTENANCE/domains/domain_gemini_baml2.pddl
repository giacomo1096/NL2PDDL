(define (domain airplane-maintenance)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    airplane mechanic airport day
  )

  (:predicates
    (airplane-scheduled-at ?p - airplane ?a - airport ?d - day)
    (serviced ?p - airplane)
    (assigned-to ?m - mechanic ?a - airport ?d - day)
    (next-day ?d1 - day ?d2 - day)
  )

  (:action perform-maintenance
    :parameters (?m - mechanic ?p - airplane ?a - airport ?d - day)
    :precondition (and
      (assigned-to ?m ?a ?d)
      (airplane-scheduled-at ?p ?a ?d)
      (not (serviced ?p))
    )
    :effect (and
      (serviced ?p)
    )
  )

  (:action fly-mechanic
    :parameters (?m - mechanic ?from - airport ?to - airport ?d1 - day ?d2 - day)
    :precondition (and
      (assigned-to ?m ?from ?d1)
      (next-day ?d1 ?d2)
      (not (= ?from ?to))
    )
    :effect (and
      (assigned-to ?m ?to ?d2)
    )
  )

  (:action stay
    :parameters (?m - mechanic ?a - airport ?d1 - day ?d2 - day)
    :precondition (and
      (assigned-to ?m ?a ?d1)
      (next-day ?d1 ?d2)
    )
    :effect (and
      (assigned-to ?m ?a ?d2)
    )
  )
)