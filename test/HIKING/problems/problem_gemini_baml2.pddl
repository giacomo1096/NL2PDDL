(define (problem escursione-belvedere)
  (:domain terrain-navigation)
  (:objects
    InizioSentiero Belvedere - terrain
    Fiume - waterbody
    PareteRocciosa - hill
    g1 - goallocation
  )
  (:init
    (at InizioSentiero)

    (connected InizioSentiero Fiume)
    (connected Fiume InizioSentiero)
    (connected InizioSentiero PareteRocciosa)
    (connected PareteRocciosa InizioSentiero)
    (connected PareteRocciosa Belvedere)
    (connected Belvedere PareteRocciosa)

    (is-walkable InizioSentiero)
    (is-walkable Belvedere)
    (is-climbable PareteRocciosa)
    
    (goal-is-at g1 Belvedere)
  )
  (:goal (and
    (is-reached g1)
  ))
)