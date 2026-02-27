(define (domain reading-planner)
  (:requirements :typing)
  (:types
    book
    month
  )
  (:predicates
    (read ?b - book)
    (assigned-to-read-in ?b - book ?m - month)
    (predecessor ?b1 - book ?b2 - book)
    (can-read-parallel ?b1 - book ?b2 - book)
    (next-month ?m1 - month ?m2 - month)
  )

  (:action assign_book_to_month
    :parameters (?b - book ?m - month)
    :precondition (and
      (not (read ?b))
    )
    :effect (and
      (assigned-to-read-in ?b ?m)
    )
  )

  (:action add_parallel_book_to_month
    :parameters (?b_new - book ?b_existing - book ?m - month)
    :precondition (and
      (assigned-to-read-in ?b_existing ?m)
      (can-read-parallel ?b_new ?b_existing)
      (not (read ?b_new))
      (not (assigned-to-read-in ?b_new ?m))
    )
    :effect (and
      (assigned-to-read-in ?b_new ?m)
    )
  )

  (:action read_foundational_book
    :parameters (?b - book ?m - month)
    :precondition (and
      (assigned-to-read-in ?b ?m)
      (not (read ?b))
    )
    :effect (and
      (read ?b)
    )
  )

  (:action read_successor_book
    :parameters (?pred_b - book ?successor_b - book ?pred_m - month ?successor_m - month)
    :precondition (and
      (predecessor ?pred_b ?successor_b)
      (read ?pred_b)
      (assigned-to-read-in ?pred_b ?pred_m)
      (assigned-to-read-in ?successor_b ?successor_m)
      (next-month ?pred_m ?successor_m)
      (not (read ?successor_b))
    )
    :effect (and
      (read ?successor_b)
    )
  )
)