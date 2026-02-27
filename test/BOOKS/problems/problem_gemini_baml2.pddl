(define (problem read-two-books-in-order)
  (:domain bookreading)

  (:objects
    BookA BookB - book
    Month1 Month2 - month
  )

  (:init
    ;; Temporal relationship between months
    (next-m Month1 Month2)

    ;; Book precedence constraint
    (predecessor BookA BookB)

    ;; Initial conditions for books
    (no-predecessor BookA)

    ;; Starting time
    (current-month Month1)
  )

  (:goal
    (and
      (is-read BookA)
      (is-read BookB)
    )
  )
)