(define (problem monday-maintenance-lhr)
  (:domain airplane-maintenance)

  (:objects
    Plane1 - airplane
    Mike - mechanic
    LHR CDG - airport
    Monday - day
  )

  (:init
    (airplane-at-airport Plane1 LHR)
    (maintenance-scheduled Plane1 Monday)
    (mechanic-at-airport Mike LHR)
    (airport-open-on-day LHR Monday)
  )

  (:goal
    (and
      (maintenance-completed Plane1 Monday)
    )
  )
)