(define (problem book-reading-schedule-problem)
    (:domain book-reading-schedule)

    (:objects
        BookA BookB - book
        Month1 Month2 - month
    )

    (:init
        ; -- Initial state of books --
        ; By Closed-World Assumption, (is-read BookA), (is-read BookB), 
        ; (is-assigned BookA), and (is-assigned BookB) are false.

        ; -- Predecessor relationships --
        (predecessor BookA BookB)
        (no-predecessor BookA)

        ; -- Initial state of months --
        (current-month Month1)
        ; By Closed-World Assumption, (is-occupied Month1) and (is-occupied Month2) are false.

        ; -- Month sequence --
        (next-m Month1 Month2)
    )

    (:goal
        (and
            (is-read BookA)
            (is-read BookB)
        )
    )
)