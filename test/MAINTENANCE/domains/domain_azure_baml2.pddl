(define (domain airplane-maintenance)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    airplane
    mechanic
    airport
    day
  )

  (:predicates
    (airplane-at-airport ?a - airplane ?ap - airport)
    (maintenance-scheduled ?a - airplane ?d - day)
    (maintenance-completed ?a - airplane ?d - day)
    (mechanic-at-airport ?m - mechanic ?ap - airport)
    (assigned-to-maintenance ?m - mechanic ?a - airplane ?d - day)
    (airport-open-on-day ?ap - airport ?d - day)
  )

  (:action assign-mechanic-to-maintenance
    :parameters (?m - mechanic ?a - airplane ?ap - airport ?d - day)
    :precondition (and
      (mechanic-at-airport ?m ?ap)
      (airplane-at-airport ?a ?ap)
      (maintenance-scheduled ?a ?d)
      (airport-open-on-day ?ap ?d)
      (not (maintenance-completed ?a ?d))
      (not (assigned-to-maintenance ?m ?a ?d))
    )
    :effect (and
      (assigned-to-maintenance ?m ?a ?d)
    )
  )

  (:action unassign-mechanic-from-maintenance
    :parameters (?m - mechanic ?a - airplane ?d - day)
    :precondition (and
      (assigned-to-maintenance ?m ?a ?d)
      (not (maintenance-completed ?a ?d))
    )
    :effect (and
      (not (assigned-to-maintenance ?m ?a ?d))
    )
  )

  (:action perform-maintenance
    :parameters (?m - mechanic ?a - airplane ?ap - airport ?d - day)
    :precondition (and
      (assigned-to-maintenance ?m ?a ?d)
      (mechanic-at-airport ?m ?ap)
      (airplane-at-airport ?a ?ap)
      (maintenance-scheduled ?a ?d)
      (airport-open-on-day ?ap ?d)
      (not (maintenance-completed ?a ?d))
    )
    :effect (and
      (maintenance-completed ?a ?d)
      (not (assigned-to-maintenance ?m ?a ?d))
    )
  )

  (:action move-mechanic
    :parameters (?m - mechanic ?from - airport ?to - airport)
    :precondition (and
      (mechanic-at-airport ?m ?from)
      (not (mechanic-at-airport ?m ?to))
    )
    :effect (and
      (not (mechanic-at-airport ?m ?from))
      (mechanic-at-airport ?m ?to)
    )
  )

  (:action move-airplane
    :parameters (?a - airplane ?from - airport ?to - airport)
    :precondition (and
      (airplane-at-airport ?a ?from)
      (not (airplane-at-airport ?a ?to))
    )
    :effect (and
      (not (airplane-at-airport ?a ?from))
      (airplane-at-airport ?a ?to)
    )
  )
)
