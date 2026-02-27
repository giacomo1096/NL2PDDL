
(define (domain book-assignment)
  (:requirements :strips :typing)
  (:types
    book
    month
  )

  (:predicates
    (is-assigned ?b - book ?m - month)
    (is-read ?b - book ?m - month)
    (has-predecessor ?b1 - book ?b2 - book)
    (is-parallel ?b1 - book ?b2 - book ?m - month)
    (is-active ?m - month)
  )

  (:action assigna
    :parameters (?b - book ?m - month)
    :precondition (and
      (is-active ?m)
      (not (is-assigned ?b ?m))
    )
    :effect (is-assigned ?b ?m)
  )

  (:action read
    :parameters (?b - book ?m - month)
    :precondition (and
      (is-assigned ?b ?m)
      (is-active ?m)
      (not (is-read ?b ?m))
      (forall (?b2 - book)
        (imply
          (has-predecessor ?b ?b2)
          (exists (?m2 - month)
            (and (is-read ?b2 ?m2) (is-active ?m2))
          )
        )
      )
    )
    :effect (is-read ?b ?m)
  )

  (:action set-predecessor
    :parameters (?b1 - book ?b2 - book)
    :precondition (and
      (not (has-predecessor ?b1 ?b2))
      (not (= ?b1 ?b2))
    )
    :effect (has-predecessor ?b1 ?b2)
  )

  (:action set-parallel
    :parameters (?b1 - book ?b2 - book ?m - month)
    :precondition (and
      (is-active ?m)
      (not (is-parallel ?b1 ?b2 ?m))
      (not (= ?b1 ?b2))
    )
    :effect (is-parallel ?b1 ?b2 ?m)
  )

  (:action activate-month
    :parameters (?m - month)
    :precondition (not (is-active ?m))
    :effect (is-active ?m)
  )

  (:action deactivate-month
    :parameters (?m - month)
    :precondition (is-active ?m)
    :effect (not (is-active ?m))
  )
)