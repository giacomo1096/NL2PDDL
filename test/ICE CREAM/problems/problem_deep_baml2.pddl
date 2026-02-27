(define (problem ice-cream-delivery)
  (:domain ice-cream-assembly)

  (:objects
    Order1 - ice-cream-order
    VanillaFlavor - ingredient
    a1 - assembled-ice-cream
  )

  (:init
    (not (has-ingredient Order1 VanillaFlavor))
    (not (packaged a1))
    (not (delivered a1))
  )

  (:goal
    (and
      (has-ingredient Order1 VanillaFlavor)
      (assembled-from a1 Order1)
      (packaged a1)
      (delivered a1)
    )
  )
)