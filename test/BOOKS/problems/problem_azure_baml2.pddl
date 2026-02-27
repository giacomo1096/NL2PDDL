(define (problem read-books-two-months)
  (:domain bookassignment)

  (:objects
    Month1 Month2 - month
    BookA BookB - book
  )

  (:init
    (not (read BookA))
    (not (read BookB))
    (not (assigned BookA))
    (not (assigned BookB))
    (prerequisite-of BookA BookB)
  )

  (:goal
    (and
      (read BookA)
      (read BookB)
      (prerequisite-of BookA BookB)
    )
  )
)