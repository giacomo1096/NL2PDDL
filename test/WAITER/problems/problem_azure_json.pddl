(define (problem serve-customer1)
  (:domain robotwaiter-domain)
  (:objects
    Lucki - robotwaiter
    Kitchen Table1 - area
    Buffet - buffet
    PlateA - plate
    Customer1 - customer
  )
  (:init
    ;; Adjacency relations (bidirectional)
    (is-adjacent Kitchen Buffet)
    (is-adjacent Buffet Kitchen)
    (is-adjacent Buffet Table1)
    (is-adjacent Table1 Buffet)

    ;; Initial facts
    ;; Lucki is not holding a plate
    ;; PlateA is not held by robot
    ;; PlateA is empty
    ;; Buffet has food
    ;; Customer1 is waiting, not served

    ;; Lucki and PlateA are in Kitchen (location tracking is implicit in this domain)
    ;; Customer1 is at Table1

    (not (is-holding-plate Lucki))
    (not (is-held-by-robot PlateA))
    (not (is-filled PlateA))
    (has-food Buffet)
    (is-waiting Customer1)
    (not (is-served Customer1))
  )
  (:goal (and
    (is-served Customer1)
    (not (is-waiting Customer1))
  ))
)