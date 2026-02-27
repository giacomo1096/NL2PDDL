lisp
(define (problem taxi-paul-to-hospital)
  (:domain taxi-domain)
  (:objects
    Station Hospital - location
    Taxi1 - taxi
    Paul - person
  )
  (:init
    (at Taxi1 Station)
    (at Paul Station)
    ; Paul is not in the taxi, so (in-taxi Paul) is not included
    ; Taxi1 is not occupied, so (occupied Taxi1) is not included
    ; Connections (if needed for move preconditions) are not in the domain predicates, so omitted
  )
  (:goal
    (at Paul Hospital)
  )
)