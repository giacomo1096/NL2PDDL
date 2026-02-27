(define (domain n-puzzle)
  (:requirements :strips)
  (:predicates
    (tile ?x)
    (position ?x)
    (at ?t ?x)
    (blank ?x)
    (valid-up ?p1 ?p2)
    (valid-down ?p1 ?p2)
    (valid-left ?p1 ?p2)
    (valid-right ?p1 ?p2))

  (:action move-up
    :parameters (?t ?p1 ?p2)
    :precondition (and 
      (tile ?t)
      (position ?p1)
      (position ?p2)
      (at ?t ?p1)
      (blank ?p2)
      (valid-up ?p1 ?p2))
    :effect (and
      (not (at ?t ?p1))
      (not (blank ?p2))
      (at ?t ?p2)
      (blank ?p1)))

  (:action move-down
    :parameters (?t ?p1 ?p2)
    :precondition (and
      (tile ?t)
      (position ?p1)
      (position ?p2)
      (at ?t ?p1)
      (blank ?p2)
      (valid-down ?p1 ?p2))
    :effect (and
      (not (at ?t ?p1))
      (not (blank ?p2))
      (at ?t ?p2)
      (blank ?p1)))

  (:action move-left
    :parameters (?t ?p1 ?p2)
    :precondition (and
      (tile ?t)
      (position ?p1)
      (position ?p2)
      (at ?t ?p1)
      (blank ?p2)
      (valid-left ?p1 ?p2))
    :effect (and
      (not (at ?t ?p1))
      (not (blank ?p2))
      (at ?t ?p2)
      (blank ?p1)))

  (:action move-right
    :parameters (?t ?p1 ?p2)
    :precondition (and
      (tile ?t)
      (position ?p1)
      (position ?p2)
      (at ?t ?p1)
      (blank ?p2)
      (valid-right ?p1 ?p2))
    :effect (and
      (not (at ?t ?p1))
      (not (blank ?p2))
      (at ?t ?p2)
      (blank ?p1))))