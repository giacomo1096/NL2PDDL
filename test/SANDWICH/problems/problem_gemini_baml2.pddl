(define (problem snack-time-for-two)
  (:domain child-snack)

  (:objects
    Marco Anna - child
    Kitchen Table - place
    tray1 - tray
    sandwich_gf - gluten-free-sandwich
    sandwich_regular - gluten-sandwich
  )

  (:init
    (allergic-to-gluten Marco)
    (child-at Marco Table)
    (child-at Anna Table)
    (tray-at tray1 Kitchen)
  )

  (:goal
    (and
      (has-been-served Marco)
      (has-been-served Anna)
    )
  )
)