(define (domain spanner-nut)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    man
    location
    spanner
    nut
    tool
  )

  (:predicates
    (man-at ?m - man ?l - location)
    (carrying-spanner ?m - man ?s - spanner)
    (connected ?l1 - location ?l2 - location)
    (spanner-at ?s - spanner ?l - location)
    (spanner-usable ?s - spanner)
    (nut-at ?n - nut ?l - location)
    (nut-tightened ?n - nut)
  )

  (:action walk
    :parameters (?m - man ?from - location ?to - location)
    :precondition (and
      (man-at ?m ?from)
      (connected ?from ?to)
      (not (man-at ?m ?to))
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
      (spanner-usable ?s)
      (not (carrying-spanner ?m ?s))
    )
    :effect (and
      (carrying-spanner ?m ?s)
      (not (spanner-at ?s ?l))
    )
  )

  (:action drop-spanner
    :parameters (?m - man ?s - spanner ?l - location)
    :precondition (and
      (man-at ?m ?l)
      (carrying-spanner ?m ?s)
    )
    :effect (and
      (not (carrying-spanner ?m ?s))
      (spanner-at ?s ?l)
    )
  )

  (:action tighten-nut
    :parameters (?m - man ?s - spanner ?n - nut ?l - location)
    :precondition (and
      (man-at ?m ?l)
      (carrying-spanner ?m ?s)
      (spanner-usable ?s)
      (nut-at ?n ?l)
      (not (nut-tightened ?n))
    )
    :effect (and
      (nut-tightened ?n)
      (not (spanner-usable ?s))
    )
  )
)
