(define (problem navigation_problem)
  (:domain navigation_domain)

  ;; Objects
  (:objects
    InizioSentiero Fiume PareteRocciosa Belvedere - location
    flat_terrain hill_terrain water_terrain - terrain
  )

  ;; Initial state
  (:init
    ;; Terrain types
    (is-traversable flat_terrain)
    (is-traversable hill_terrain)
    (is-traversable water_terrain)

    ;; Terrain requirements
    (requires-climbing hill_terrain)
    (requires-swimming water_terrain)

    ;; Location connections and terrain assignments
    (is-visited InizioSentiero)
    (not (is-visited Fiume))
    (not (is-visited PareteRocciosa))
    (not (is-visited Belvedere))

    ;; Terrain assignments for connections
    ;; InizioSentiero (flat) -> Fiume (water)
    ;; InizioSentiero (flat) -> PareteRocciosa (hill)
    ;; PareteRocciosa (hill) -> Belvedere (flat)
  )

  ;; Goal
  (:goal (and
    (is-reached Belvedere)
  ))
)