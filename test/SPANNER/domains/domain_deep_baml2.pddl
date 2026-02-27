(define (domain spanner-domain)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    man location spanner nut
  )

  (:predicates
    (man-at ?m - man ?l - location)
    (carrying-spanner ?m - man ?s - spanner)
    (connected ?l1 - location ?l2 - location)
    (spanner-at ?s - spanner ?l - location)
    (usable ?s - spanner)
    (nut-at ?n - nut ?l - location)
    (loose ?n - nut)
  )

  (:action walk
    :parameters (?m - man ?from - location ?to - location)
    :precondition (and
      (man-at ?m ?from)
      (connected ?from ?to)
    )
    :effect (and
      (not (man-at ?m ?from))
      (man-at ?m ?to)
    )
  )

  (:action pickup-spanner
    :parameters (?m - man ?s - spanner ?l - location)
    :precondition (and
      (man-at ?m ?l)
      (spanner-at ?s ?l)
    )
    :effect (and
      (carrying-spanner ?m ?s)
      (not (spanner-at ?s ?l))
    )
  )

  (:action tighten-nut
    :parameters (?m - man ?l - location ?n - nut ?s - spanner)
    :precondition (and
      (man-at ?m ?l)
      (nut-at ?n ?l)
      (carrying-spanner ?m ?s)
      (usable ?s)
      (loose ?n)
    )
    :effect (and
      (not (loose ?n))
      (not (usable ?s))
    )
  )
)