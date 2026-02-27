(define (domain scanalyzer3d)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    car segment
  )

  (:predicates
    (car-at ?c - car ?s - segment)
    (analyzed ?c - car)
  )

  (:action analyze_pair
    :parameters (?c1 - car ?c2 - car ?s1 - segment ?s2 - segment)
    :precondition (and
      (not (analyzed ?c1))
      (not (analyzed ?c2))
      (car-at ?c1 ?s1)
      (car-at ?c2 ?s2)
    )
    :effect (and
      (analyzed ?c1)
      (analyzed ?c2)
    )
  )

  (:action analyze_four
    :parameters (?c1 - car ?c2 - car ?c3 - car ?c4 - car ?s1 - segment ?s2 - segment ?s3 - segment ?s4 - segment)
    :precondition (and
      (not (analyzed ?c1))
      (not (analyzed ?c2))
      (not (analyzed ?c3))
      (not (analyzed ?c4))
      (car-at ?c1 ?s1)
      (car-at ?c2 ?s2)
      (car-at ?c3 ?s3)
      (car-at ?c4 ?s4)
    )
    :effect (and
      (analyzed ?c1)
      (analyzed ?c2)
      (analyzed ?c3)
      (analyzed ?c4)
    )
  )

  (:action rotate
    :parameters (?c - car ?from - segment ?to - segment)
    :precondition (and
      (car-at ?c ?from)
    )
    :effect (and
      (not (car-at ?c ?from))
      (car-at ?c ?to)
    )
  )
)