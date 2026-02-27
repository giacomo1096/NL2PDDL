(define (problem escursione-belvedere)
  (:domain navigation)

  (:objects
    InizioSentiero - terrain
    Fiume - waterbody
    PareteRocciosa - hill
    Belvedere - goallocation
  )

  (:init
    ; Initial position of the hiker
    (at InizioSentiero)

    ; Connections between locations
    (connected InizioSentiero Fiume)
    (connected Fiume InizioSentiero)
    (connected InizioSentiero PareteRocciosa)
    (connected PareteRocciosa InizioSentiero)
    (connected PareteRocciosa Belvedere)
    (connected Belvedere PareteRocciosa)

    ; Properties of the terrain
    (is-walkable InizioSentiero)
    (is-walkable Belvedere)
    (is-climbable PareteRocciosa)
    ; Fiume is not crossable, so the (is-crossable Fiume) predicate is omitted.
  )

  (:goal
    (and
      (is-reached Belvedere)
    )
  )
)