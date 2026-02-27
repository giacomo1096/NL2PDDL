lisp
(define (problem serve-customer1-plateA)
  (:domain robotwaiter-domain)

  (:objects
    Lucki - robotwaiter
    Kitchen Table1 - area
    Buffet - buffet
    PlateA - plate
    Customer1 - customer
  )

  (:init
    ;; Robot and plate locations
    (at-robotwaiter-area Lucki Kitchen)
    (at-plate-area PlateA Kitchen)
    ;; Plate is not held and not filled
    ;; (not (held-by PlateA Lucki)) -- implied by absence
    ;; (not (filled-with-food PlateA)) -- implied by absence
    ;; Robot is not holding a plate
    ;; (not (holding-plate Lucki)) -- implied by absence

    ;; Buffet location
    (at-buffet-area Buffet Buffet)

    ;; Customer location and not served
    (at-customer-area Customer1 Table1)
    ;; (not (served Customer1)) -- implied by absence

    ;; Area adjacencies (bidirectional)
    (adjacent Kitchen Buffet)
    (adjacent Buffet Kitchen)
    (adjacent Buffet Table1)
    (adjacent Table1 Buffet)
  )

  (:goal
    (and
      (served Customer1)
      (filled-with-food PlateA)
      (at-plate-area PlateA Table1)
    )
  )
)