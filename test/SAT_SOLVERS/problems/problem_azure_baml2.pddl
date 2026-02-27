(define (problem xor-sat)
  (:domain sat)

  (:objects
    V1 V2 - variable
    C1 C2 - clause
  )

  (:init
    ; V1 and V2 are unset (not assigned true or false)
    (not (assigned-true V1))
    (not (assigned-false V1))
    (not (assigned-true V2))
    (not (assigned-false V2))
    ; Both clauses are unsatisfied
    (not (satisfied C1))
    (not (satisfied C2))
  )

  (:goal
    (and
      (satisfied C1)
      (satisfied C2)
    )
  )
)