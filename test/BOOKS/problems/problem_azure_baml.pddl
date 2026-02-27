lisp
(define (problem read-three-books-in-two-months)
  (:domain book-assignment)

  (:objects
    BookA BookB BookC - book
    Month1 Month2 - month
  )

  (:init
    ;; No books are assigned or read at the start
    ;; (assigned ...) and (read ...) are false by default (not present)
    
    ;; Prerequisite: BookA must be read before BookB
    (prerequisite-of BookA BookB)
    
    ;; BookA and BookC can be read in parallel
    (parallel-with BookA BookC)
    (parallel-with BookC BookA)
    
    ;; BookB cannot be read in parallel with any other book (so no parallel-with for BookB)
    
    ;; No books assigned to any month yet
    ;; (assigned-in ...) and (has-assigned-book ...) are false by default (not present)
  )

  (:goal
    (and
      (read BookA)
      (read BookB)
      (read BookC)
    )
  )
)