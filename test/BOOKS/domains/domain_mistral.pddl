
(define (domain reading_plan)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    libro mes prerequisito
  )

  ;; Predicates
  (:predicates
    (is-assigned ?l - libro)
    (is-read ?l - libro)
    (has-prerequisite ?l - libro ?p - prerequisito)
    (has-assignment ?m - mes)
    (is-completed ?m - mes)
    (is-satisfied ?p - prerequisito)
  )

  ;; Actions
  (:action assigna
    :parameters (?l - libro ?m - mes)
    :precondition (and
      (not (is-assigned ?l))
      (not (is-read ?l))
      (not (has-assignment ?m))
      (forall (?p - prerequisito)
        (implies (has-prerequisite ?l ?p) (is-satisfied ?p))))
    :effect (and
      (is-assigned ?l)
      (has-assignment ?m)
    )
  )

  (:action mark_read
    :parameters (?l - libro)
    :precondition (and
      (is-assigned ?l)
      (not (is-read ?l))
      (forall (?p - prerequisito)
        (implies (has-prerequisite ?l ?p) (is-satisfied ?p)))
    )
    :effect (is-read ?l)
  )

  (:action satisfy_prerequisite
    :parameters (?p - prerequisito ?l - libro)
    :precondition (and
      (has-prerequisite ?l ?p)
      (is-read ?l)
    )
    :effect (is-satisfied ?p)
  )

  (:action complete_month
    :parameters (?m - mes)
    :precondition (and
      (has-assignment ?m)
      (forall (?l - libro)
        (implies (is-assigned ?l) (is-read ?l)))
    )
    :effect (is-completed ?m)
  )
)