(define (problem deliver-icecream-order1)
  (:domain icecream)

  (:objects
    Order1 - icecreamorder
    Vanilla-Flavor - ingredient
  )

  (:init
    ; The initial state is that the order is not assembled, has no ingredients, is not packaged, and not delivered.
    ; In PDDL, this is represented by the absence of these positive facts.
  )

  (:goal
    (and
      (delivered Order1)
    )
  )
)