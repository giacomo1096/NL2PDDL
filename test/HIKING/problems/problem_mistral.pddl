(define (problem hiking_problem)
  (:domain hiking)

  (:objects
    InizioSentiero Fiume PareteRocciosa Belvedere - location
    flat - terrain
    hill - hill
    water - waterbody
  )

  (:init
    ;; Terrain properties
    (is-traversable flat)
    (not (requires-climbing flat))
    (not (requires-swimming flat))

    (is-traversable hill)
    (requires-climbing hill)
    (not (requires-swimming hill))

    (is-traversable water)
    (not (requires-climbing water))
    (requires-swimming water)

    ;; Location connections and initial state
    (is-visited InizioSentiero)
    (not (is-visited Fiume))
    (not (is-visited PareteRocciosa))
    (not (is-visited Belvedere))

    ;; Goal state
    (not (is-reached Belvedere))
  )

  (:goal
    (is-reached Belvedere)
  )
)