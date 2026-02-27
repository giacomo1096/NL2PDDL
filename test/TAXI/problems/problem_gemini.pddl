(define (problem taxi-problem-instance)
  (:domain taxi)
  (:objects
    Taxi1 - taxi
    Paul - person
    Station Hospital - location
  )
  (:init
    (at Taxi1 Station)
    (at Paul Station)
    (is-empty Taxi1)
    (destination Paul Hospital)
  )
  (:goal (and
    (at Paul Hospital)
  ))
)