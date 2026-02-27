lisp
(define (problem read-three-books-in-two-months)
  (:domain book-assignment)

  (:objects
    BookA BookB BookC - book
    Month1 Month2 - month
  )

  (:init
    (is-active Month1)
    (is-active Month2)

    ; No books have been assigned yet
    (not (is-assigned BookA Month1))
    (not (is-assigned BookA Month2))
    (not (is-assigned BookB Month1))
    (not (is-assigned BookB Month2))
    (not (is-assigned BookC Month1))
    (not (is-assigned BookC Month2))

    ; No books have been read yet
    (not (is-read BookA Month1))
    (not (is-read BookA Month2))
    (not (is-read BookB Month1))
    (not (is-read BookB Month2))
    (not (is-read BookC Month1))
    (not (is-read BookC Month2))

    ; Prerequisite: BookA must be read before BookB
    (has-predecessor BookB BookA)

    ; Parallel reading: BookA and BookC can be read in the same month
    (is-parallel BookA BookC Month1)
    (is-parallel BookA BookC Month2)

    ; BookB cannot be read in parallel with any other book (no is-parallel facts for BookB)
  )

  (:goal (and
    (is-read BookA Month1)
    (is-read BookB Month2)
    (is-read BookC Month1)
  ))
)