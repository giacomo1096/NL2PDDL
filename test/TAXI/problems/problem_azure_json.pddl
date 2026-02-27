lisp
(define (problem taxi-paul-to-hospital)
  (:domain taxi-domain)
  (:objects
    Taxi1 - taxi
    Paul - person
    Station Hospital - location
  )
  (:init
    (at-location-taxi Taxi1 Station)
    (at-location-person Paul Station)
    (not (occupied Taxi1))
    ; Paul is not in the taxi (implicit, since not (in-taxi Paul Taxi1))
    ; Connections (if needed for planning, though not in domain predicates)
    ; (connected Station Hospital)
    ; (connected Hospital Station)
    ; Mark Hospital as a destination (if needed)
    (is-destination Hospital)
  )
  (:goal
    (at-location-person Paul Hospital)
  )
)