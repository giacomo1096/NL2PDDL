(define (domain spanner)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    man
    location
    spanner
    nut
  )

  (:predicates
    (man-at ?m - man ?l - location)
    (holding-spanner ?m - man ?s - spanner)
    (hands-empty ?m - man)
    (linked ?l1 - location ?l2 - location)
    (spanner-at ?s - spanner ?l - location)
    (is-usable ?s - spanner)
    (nut-at ?n - nut ?l - location)
    (is-loose ?n - nut)
    (is-tightened ?n - nut)
  )

  (:action walk
    :parameters (?m - man ?from - location ?to - location)
    :precondition (and
      (man-at ?m ?from)
      (linked ?from ?to)
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
      (hands-empty ?m)
      (is-usable ?s)
    )
    :effect (and
      (not (hands-empty ?m))
      (holding-spanner ?m ?s)
      (not (spanner-at ?s ?l))
    )
  )

  (:action drop-spanner
    :parameters (?m - man ?s - spanner ?l - location)
    :precondition (and
      (man-at ?m ?l)
      (holding-spanner ?m ?s)
    )
    :effect (and
      (hands-empty ?m)
      (not (holding-spanner ?m ?s))
      (spanner-at ?s ?l)
    )
  )

  (:action tighten-nut
    :parameters (?m - man ?s - spanner ?n - nut ?l - location)
    :precondition (and
      (man-at ?m ?l)
      (nut-at ?n ?l)
      (holding-spanner ?m ?s)
      (is-usable ?s)
      (is-loose ?n)
    )
    :effect (and
      (not (is-loose ?n))
      (is-tightened ?n)
      (not (is-usable ?s))
    )
  )
)
