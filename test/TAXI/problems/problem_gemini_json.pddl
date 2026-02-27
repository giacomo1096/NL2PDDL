(define (problem taxi-problem-instance)
  (:domain taxi)
  (:objects
    Station Hospital - location
    Taxi1 - taxi
    Paul - person
  )
  (:init
    (at Taxi1 Station)
    (is-empty Taxi1)
    (at Paul Station)
    (destination Paul Hospital)
  )
  (:goal (and
    (at-destination Paul)
  ))
)