(define (problem simple-icecream-delivery)
  (:domain icecream)

  (:objects
    Order1 - icecreamorder
    VanillaFlavor - ingredient
    Lab - order
    CustomerHome - order
    Package1 - package
    Delivery1 - delivery
  )

  (:init
    ;; Order1 is empty (no ingredients yet)
    ;; No (has-ingredient Order1 VanillaFlavor) fact
    ;; Order1 not packaged
    ;; Order1 not delivered
    ;; VanillaFlavor is available (availability is assumed implicit)
    ;; Order1 is at Lab (location not modeled in predicates, so omitted)
    ;; All predicates must match domain
    ;; Package and Delivery objects are introduced for packaging/delivery actions
  )

  (:goal
    (and
      (has-ingredient Order1 VanillaFlavor)
      (packaged Order1)
      (delivered Order1)
    )
  )
)