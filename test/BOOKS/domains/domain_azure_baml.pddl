(define (domain book-assignment)
  (:requirements :strips :typing)
  (:types
    book
    month
  )

  (:predicates
    (assigned ?b - book)
    (read ?b - book)
    (prerequisite-of ?pre - book ?b - book)
    (parallel-with ?b1 - book ?b2 - book)
    (assigned-in ?b - book ?m - month)
    (has-assigned-book ?m - month ?b - book)
  )

  (:action assign-book-to-month
    :parameters (?b - book ?m - month)
    :precondition (and
      (not (assigned ?b))
      (not (assigned-in ?b ?m))
    )
    :effect (and
      (assigned ?b)
      (assigned-in ?b ?m)
      (has-assigned-book ?m ?b)
    )
  )

  (:action read-book
    :parameters (?b - book ?m - month)
    :precondition (and
      (assigned-in ?b ?m)
      (not (read ?b))
    )
    :effect (read ?b)
  )

  (:action assign-book-with-prerequisite
    :parameters (?b - book ?m - month ?pre - book ?mpre - month)
    :precondition (and
      (prerequisite-of ?pre ?b)
      (assigned-in ?pre ?mpre)
      (not (assigned-in ?b ?m))
      (not (assigned ?b))
    )
    :effect (and
      (assigned ?b)
      (assigned-in ?b ?m)
      (has-assigned-book ?m ?b)
    )
  )

  (:action assign-books-in-parallel
    :parameters (?b1 - book ?b2 - book ?m - month)
    :precondition (and
      (parallel-with ?b1 ?b2)
      (not (assigned-in ?b1 ?m))
      (not (assigned-in ?b2 ?m))
      (not (assigned ?b1))
      (not (assigned ?b2))
    )
    :effect (and
      (assigned ?b1)
      (assigned ?b2)
      (assigned-in ?b1 ?m)
      (assigned-in ?b2 ?m)
      (has-assigned-book ?m ?b1)
      (has-assigned-book ?m ?b2)
    )
  )

  (:action unassign-book-from-month
    :parameters (?b - book ?m - month)
    :precondition (and
      (assigned-in ?b ?m)
      (not (read ?b))
    )
    :effect (and
      (not (assigned-in ?b ?m))
      (not (has-assigned-book ?m ?b))
      (not (assigned ?b))
    )
  )
)