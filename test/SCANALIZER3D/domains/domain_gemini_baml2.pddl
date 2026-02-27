(define (domain scanalyzer3d)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    car segment
  )

  (:predicates
    (car-at ?c - car ?s - segment)
    (analyzed ?c - car)
    (segment-empty ?s - segment)
  )

  (:action analyze-pair
    :parameters (?c1 - car ?s1 - segment ?c2 - car ?s2 - segment)
    :precondition (and
      (car-at ?c1 ?s1)
      (car-at ?c2 ?s2)
      (not (analyzed ?c1))
      (not (analyzed ?c2))
      (not (= ?c1 ?c2))
    )
    :effect (and
      (analyzed ?c1)
      (analyzed ?c2)
    )
  )

  (:action analyze-group-of-four
    :parameters (?c1 - car ?s1 - segment ?c2 - car ?s2 - segment ?c3 - car ?s3 - segment ?c4 - car ?s4 - segment)
    :precondition (and
      (car-at ?c1 ?s1)
      (car-at ?c2 ?s2)
      (car-at ?c3 ?s3)
      (car-at ?c4 ?s4)
      (not (analyzed ?c1))
      (not (analyzed ?c2))
      (not (analyzed ?c3))
      (not (analyzed ?c4))
      (not (= ?c1 ?c2))
      (not (= ?c1 ?c3))
      (not (= ?c1 ?c4))
      (not (= ?c2 ?c3))
      (not (= ?c2 ?c4))
      (not (= ?c3 ?c4))
    )
    :effect (and
      (analyzed ?c1)
      (analyzed ?c2)
      (analyzed ?c3)
      (analyzed ?c4)
    )
  )

  (:action rotate-swap
    :parameters (?c1 - car ?s1 - segment ?c2 - car ?s2 - segment)
    :precondition (and
      (car-at ?c1 ?s1)
      (car-at ?c2 ?s2)
      (not (= ?s1 ?s2))
      (not (= ?c1 ?c2))
    )
    :effect (and
      (not (car-at ?c1 ?s1))
      (car-at ?c1 ?s2)
      (not (car-at ?c2 ?s2))
      (car-at ?c2 ?s1)
    )
  )

  (:action rotate-move
    :parameters (?c - car ?from - segment ?to - segment)
    :precondition (and
      (car-at ?c ?from)
      (segment-empty ?to)
      (not (= ?from ?to))
    )
    :effect (and
      (segment-empty ?from)
      (not (car-at ?c ?from))
      (not (segment-empty ?to))
      (car-at ?c ?to)
    )
  )

  (:action place-car
    :parameters (?c - car ?s - segment)
    :precondition (and
      (segment-empty ?s)
    )
    :effect (and
      (not (segment-empty ?s))
      (car-at ?c ?s)
      (not (analyzed ?c))
    )
  )

  (:action remove-car
    :parameters (?c - car ?s - segment)
    :precondition (and
      (car-at ?c ?s)
    )
    :effect (and
      (not (car-at ?c ?s))
      (segment-empty ?s)
    )
  )
)
