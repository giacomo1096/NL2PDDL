(define (domain navigation)
  (:requirements :typing)

  (:types
    hill waterbody goallocation terrain
  )

  (:predicates
    (at ?t - terrain)
    (connected ?from - terrain ?to - terrain)
    (is-walkable ?t - terrain)
    (is-climbable ?h - hill)
    (is-crossable ?w - waterbody)
    (is-reached ?g - goallocation)
  )

  (:action walk
    :parameters (?from - terrain ?to - terrain)
    :precondition (and
      (at ?from)
      (connected ?from ?to)
      (is-walkable ?to)
    )
    :effect (and
      (not (at ?from))
      (at ?to)
    )
  )

  (:action climb
    :parameters (?from - terrain ?to - hill)
    :precondition (and
      (at ?from)
      (connected ?from ?to)
      (is-climbable ?to)
    )
    :effect (and
      (not (at ?from))
      (at ?to)
    )
  )

  (:action cross
    :parameters (?from - terrain ?to - waterbody)
    :precondition (and
      (at ?from)
      (connected ?from ?to)
      (is-crossable ?to)
    )
    :effect (and
      (not (at ?from))
      (at ?to)
    )
  )

  (:action finish
    :parameters (?goal - goallocation)
    :precondition (and
      (at ?goal)
    )
    :effect (and
      (is-reached ?goal)
    )
  )
)