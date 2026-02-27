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
    ; Area connectivity
    (adjacent Kitchen Buffet)
    (adjacent Buffet Kitchen)
    (adjacent Buffet Table1)
    (adjacent Table1 Buffet)

    ; Robot initial state
    (robot-at Lucki Kitchen)
    (hand-empty Lucki)

    ; Plate initial state
    (plate-at PlateA Kitchen)
    ; PlateA is empty, so (is-full PlateA) is false by default

    ; Customer initial state
    (customer-at Customer1 Table1)
    (is-waiting Customer1)

    ; Buffet state
    (food-available Buffet)
  )
  (:goal (and
    (not (is-waiting Customer1))
  ))
)