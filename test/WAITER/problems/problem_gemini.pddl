(define (problem serve-customer1)
  (:domain robot-service)
  (:objects
    Lucki - robot
    PlateA - plate
    Customer1 - customer
    Kitchen Table1 - area
    Buffet - buffet
  )
  (:init
    ; Adjacency information
    (adjacent Kitchen Buffet)
    (adjacent Buffet Kitchen)
    (adjacent Buffet Table1)
    (adjacent Table1 Buffet)

    ; Robot's initial state
    (robot-at Lucki Kitchen)
    (hand-empty Lucki)

    ; Plate's initial state
    (plate-at PlateA Kitchen)
    ; PlateA is empty, so (is-full PlateA) is false.

    ; Buffet's state
    (food-available Buffet)

    ; Customer's initial state
    (customer-at Customer1 Table1)
    (is-waiting Customer1)
  )
  (:goal (and
    (not (is-waiting Customer1))
  ))
)