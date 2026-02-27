(define (problem serve-customer-1)
  (:domain restaurant-robot)
  (:objects
    Lucki - robot
    Kitchen Table1 - area
    Buffet - buffet
    PlateA - plate
    Customer1 - customer
    sushi - food
  )
  (:init
    (at-robot Lucki Kitchen)
    (hand-empty Lucki)
    (at-plate PlateA Kitchen)
    (at-customer Customer1 Table1)
    (adjacent Kitchen Buffet)
    (adjacent Buffet Kitchen)
    (adjacent Buffet Table1)
    (adjacent Table1 Buffet)
    (available-at-buffet sushi Buffet)
    (wants-food Customer1 sushi)
  )
  (:goal (and
    (served Customer1)
  ))
)