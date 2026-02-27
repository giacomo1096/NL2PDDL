(define (problem plane1-maintenance)
  (:domain airplane-maintenance)

  (:objects
    Plane1 - airplane
    Mike - mechanic
    London-Heathrow Paris-CDG - airport
    Monday - day
  )

  (:init
    (scheduled-at Plane1 London-Heathrow Monday)
  )

  (:goal
    (and
      (maintenance-performed Plane1 London-Heathrow Monday)
    )
  )
)