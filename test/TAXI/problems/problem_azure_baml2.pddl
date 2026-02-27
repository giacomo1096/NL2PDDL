(define (problem paul-to-hospital)
  (:domain taxi)

  (:objects
    Station Hospital - location
    Taxi1 - taxi
    Paul - person
  )

  (:init
    (at Taxi1 Station)
    (at-person Paul Station)
    ;; Paul is not in the taxi, so no (in-taxi Paul Taxi1)
    ;; Taxi is unoccupied, so no (occupied Taxi1)
    ;; Connections are not represented as predicates in the domain, so omitted
  )

  (:goal
    (and
      (at-person Paul Hospital)
    )
  )
)