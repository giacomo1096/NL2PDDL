(define (problem escursione-problem)
  (:domain navigation)

  (:objects
    InizioSentiero - terrain
    Fiume - waterbody
    PareteRocciosa - hill
    Belvedere - goallocation
  )

  (:init
    ; Initial location of the hiker
    (at InizioSentiero)

    ; Connections between locations (bidirectional)
    (connected InizioSentiero Fiume)
    (connected Fiume InizioSentiero)
    (connected InizioSentiero PareteRocciosa)
    (connected PareteRocciosa InizioSentiero)
    (connected PareteRocciosa Belvedere)
    (connected Belvedere PareteRocciosa)

    ; Properties of the terrain
    (is-walkable InizioSentiero)
    (is-climbable PareteRocciosa)
    (is-walkable Belvedere)
    ; Fiume is not crossable, so the (is-crossable Fiume) predicate is omitted.
  )

  (:goal
    (and
      (is-reached Belvedere)
    )
  )
)