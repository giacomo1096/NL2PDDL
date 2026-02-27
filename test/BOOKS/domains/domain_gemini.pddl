(define (domain book-reading-schedule)
    (:requirements :strips :typing)

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
        (predecessor ?p - book ?b - book)
        (next-m ?m1 - month ?m2 - month)
    )

    (:action assign-book
        :parameters (?b - book ?m - month)
        :precondition (and
            (not (is-assigned ?b))
            (not (is-occupied ?m))
        )
        :effect (and
            (is-assigned ?b)
            (is-occupied ?m)
            (assigned-in ?b ?m)
        )
    )

    (:action read-first-book
        :parameters (?b - book ?m - month)
        :precondition (and
            (current-month ?m)
            (assigned-in ?b ?m)
            (not (is-read ?b))
            (no-predecessor ?b)
        )
        :effect (and
            (is-read ?b)
        )
    )

    (:action read-successor-book
        :parameters (?b - book ?p - book ?m - month)
        :precondition (and
            (current-month ?m)
            (assigned-in ?b ?m)
            (not (is-read ?b))
            (predecessor ?p ?b)
            (is-read ?p)
        )
        :effect (and
            (is-read ?b)
        )
    )

    (:action advance-from-empty-month
        :parameters (?from - month ?to - month)
        :precondition (and
            (current-month ?from)
            (not (is-occupied ?from))
            (next-m ?from ?to)
        )
        :effect (and
            (not (current-month ?from))
            (current-month ?to)
        )
    )

    (:action advance-after-reading
        :parameters (?from - month ?to - month ?b - book)
        :precondition (and
            (current-month ?from)
            (assigned-in ?b ?from)
            (is-read ?b)
            (next-m ?from ?to)
        )
        :effect (and
            (not (current-month ?from))
            (current-month ?to)
        )
    )
)