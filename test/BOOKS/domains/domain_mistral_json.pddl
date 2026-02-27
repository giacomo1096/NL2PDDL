
(define (domain reading_planner)
  (:requirements :typing :fluents)

  (:types
    libro mes prerequisito
  )

  (:predicates
    (is-assigned ?l - libro)
    (is-read ?l - libro)
    (has-prerequisite ?l - libro ?p - prerequisito)
    (has-assignment ?m - mes)
    (is-completed ?m - mes)
    (is-satisfied ?p - prerequisito)
  )

  (:action assign
    :parameters (?l - libro ?m - mes)
    :precondition (and
      (not (is-assigned ?l))
      (not (is-read ?l))
      (not (has-assignment ?m))
      (forall (?p - prerequisito)
        (implies (has-prerequisite ?l ?p)
          (is-satisfied ?p)))
    )
    :effect (and
      (is-assigned ?l)
      (has-assignment ?m)
    )
  )

  (:action mark-as-read
    :parameters (?l - libro)
    :precondition (and
      (is-assigned ?l)
      (not (is-read ?l))
    )
    :effect (and
      (is-read ?l)
      (forall (?p - prerequisito)
        (when (has-prerequisite ?l ?p)
          (is-satisfied ?p)))
    )
  )

  (:action complete-month
    :parameters (?m - mes)
    :precondition (and
      (has-assignment ?m)
      (not (is-completed ?m))
      (forall (?l - libro)
        (implies (is-assigned ?l)
          (is-read ?l)))
    )
    :effect (is-completed ?m)
  )
)