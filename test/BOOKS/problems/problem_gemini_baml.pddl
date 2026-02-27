(define (problem read-two-books-in-order)
  (:domain reading-planner)
  (:objects
    BookA BookB - book
    Month1 Month2 - month
  )
  (:init
    (predecessor BookA BookB)
    (next-month Month1 Month2)
  )
  (:goal (and
    (read BookA)
    (read BookB)
  ))
)