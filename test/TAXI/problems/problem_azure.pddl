lisp
(define (problem taxi-problem-paul-hospital)
  (:domain taxi-domain)
  (:objects
    Taxi1 - taxi
    Paul - person
    Station Hospital - location
  )
  (:init
    (at-location Taxi1 Station)
    (at-location Paul Station)
    (not (in-taxi Paul Taxi1))
    (not (occupied Taxi1))
    (is-destination Hospital Paul)
  )
  (:goal
    (at-location Paul Hospital)
  )
)