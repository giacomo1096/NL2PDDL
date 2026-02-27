(define (problem passenger-to-third-floor)
  (:domain miconic)

  (:objects
    Floor0 Floor1 Floor2 - floor
    Elevator1 - elevator
    PassengerA - passenger
  )

  (:init
    (elevator-at-floor Elevator1 Floor0)
    (passenger-at-floor PassengerA Floor0)
    (passenger-destination PassengerA Floor2)
    (floor-has-passenger Floor0 PassengerA)
  )

  (:goal
    (and
      (passenger-at-floor PassengerA Floor2)
      (passenger-served PassengerA)
      (floor-has-passenger Floor2 PassengerA)
    )
  )
)