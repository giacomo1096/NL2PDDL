(define (problem transport-paul-to-hospital)
  (:domain taxi-domain)
  (:objects
    Station Hospital - location
    Taxi1 - taxi
    Paul - person
  )
  (:init
    (taxi-at Taxi1 Station)
    (person-at Paul Station)
    (taxi-empty Taxi1)
  )
  (:goal (and
    (person-at Paul Hospital)
  ))
)