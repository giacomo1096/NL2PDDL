(define (problem taxi-transport-paul)
  (:domain taxi-service)

  (:objects
    Station Hospital - location
    Taxi1 - taxi
    Paul - person
  )

  (:init
    (taxi-at Taxi1 Station)
    (person-at Paul Station)
    (destination Paul Hospital)
  )

  (:goal
    (and
      (person-at Paul Hospital)
    )
  )
)