(define (problem robot_waiter_problem)
  (:domain robot_waiter)

  ;; Objects
  (:objects
    Lucki - robotwaiter
    PlateA - plate
    Food1 - food
    Customer1 - customer
    Kitchen Buffet Table1 - area
  )

  ;; Initial state
  (:init
    ;; Robot Waiter
    (is-at Lucki Kitchen)
    (is-empty Lucki)

    ;; Areas
    (is-adjacent Kitchen Buffet)
    (is-adjacent Buffet Table1)
    (has-buffet Buffet)
    (has-customer Table1 Customer1)

    ;; Plate
    (is-empty PlateA)

    ;; Food
    (is-available Food1 Buffet)

    ;; Customer
    (has-order Customer1 Food1)
  )

  ;; Goal
  (:goal
    (and
      (is-served PlateA Customer1)
      (is-filled PlateA Food1)
    )
  )
)