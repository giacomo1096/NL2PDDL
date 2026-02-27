(define (domain book-reading-planner)
  (:requirements :typing)
  (:types
    book
    month
  )
  (:predicates
    (is-read ?b - book)
    (is-assigned ?b - book)
    (no-predecessor ?b - book)
    (current-month ?m - month)
    (is-occupied ?m - month)
    (assigned-in ?b - book ?m - month)
    (predecessor ?b1 - book ?b2 - book)
    (next-m ?m1 - month ?m2 - month)
  )

  (:action assign-book
    :parameters (?b - book ?m - month)
    :precondition (and (not (is-assigned ?b)) (not (is-occupied ?m)))
    :effect (and (is-assigned ?b) (is-occupied ?m) (assigned-in ?b ?m))
  )

  (:action read-first-book
    :parameters (?b - book ?m - month)
    :precondition (and (current-month ?m) (assigned-in ?b ?m) (not (is-read ?b)) (no-predecessor ?b))
    :effect (and (is-read ?b))
  )

  (:action read-successor-book
    :parameters (?b - book ?p - book ?m - month)
    :precondition (and (current-month ?m) (assigned-in ?b ?m) (not (is-read ?b)) (predecessor ?p ?b) (is-read ?p))
    :effect (and (is-read ?b))
  )

  (:action advance-from-empty-month
    :parameters (?from - month ?to - month)
    :precondition (and (current-month ?from) (next-m ?from ?to) (not (is-occupied ?from)))
    :effect (and (not (current-month ?from)) (current-month ?to))
  )

  (:action advance-after-reading
    :parameters (?b - book ?from - month ?to - month)
    :precondition (and (current-month ?from) (next-m ?from ?to) (assigned-in ?b ?from) (is-read ?b))
    :effect (and (not (current-month ?from)) (current-month ?to))
  )
)