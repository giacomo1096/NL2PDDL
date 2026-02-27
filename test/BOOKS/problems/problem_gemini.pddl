(define (problem book-reading-schedule-problem)
    (:domain book-reading-schedule)
    (:objects
        BookA BookB - book
        Month1 Month2 - month
    )
    (:init
        (current-month Month1)
        (next-m Month1 Month2)
        (no-predecessor BookA)
        (predecessor BookA BookB)
    )
    (:goal (and
        (is-read BookA)
        (is-read BookB)
    ))
)