(define (problem sat-xor-problem)
  (:domain sat)

  (:objects
    V1 V2 - variable
    C1 C2 - clause
  )

  (:init
    ;; Clause C1: (V1 or V2)
    (in-clause-pos V1 C1)
    (in-clause-pos V2 C1)

    ;; Clause C2: (not V1 or not V2)
    (in-clause-neg V1 C2)
    (in-clause-neg V2 C2)
  )

  (:goal
    (and
      (satisfied C1)
      (satisfied C2)
    )
  )
)