(define (problem serve-customer1)
  (:domain restaurantwaiter)

  (:objects
    Lucki - robotwaiter
    Kitchen Buffet Table1 - area
    PlateA - plate
    Customer1 - customer
    
    BuffetCounter - buffet  
    Steak - food            
  )

  (:init
    (at-robotwaiter-area Lucki Kitchen)
    (at-plate-area PlateA Kitchen)
    (adjacent Kitchen Buffet)
    (adjacent Buffet Kitchen)
    (adjacent Buffet Table1)
    (adjacent Table1 Buffet)
    (at-customer-area Customer1 Table1)

    
    (at-buffet-area BuffetCounter Buffet) 
    
    (at-food-buffet Steak BuffetCounter)

    ;; Lucki is not holding a plate
    ;; PlateA is not held by anyone
    ;; PlateA is not filled with food
    ;; Customer1 is not served
  )

  (:goal
    (and
      (served Customer1)
    )
  )
)