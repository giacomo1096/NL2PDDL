(define (problem taxi_problem_1)
  (:domain taxi)

  (:objects
    Taxi1 - taxi
    Paul - person
    Station Hospital - location
  )

  (:init
    (has-taxi Station Taxi1)
    (has-person Station Paul)
    (= (fuel-level Taxi1) 100)
    (is-empty Taxi1)
    (not (in-transit Taxi1))
    (not (in-taxi Paul Taxi1))
    (not (at-destination Paul))
    (not (has-taxi Hospital Taxi1))
    (not (has-person Hospital Paul))
  )

  (:goal
    (and
      (has-person Hospital Paul)
      (at-destination Paul)
    )
  )
)