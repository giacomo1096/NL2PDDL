
(define (domain robotwaiter)
  (:requirements :typing :fluents)

  (:types
    robotwaiter area plate food customer buffet
  )

  (:predicates
    (isholdingplate ?r - robotwaiter ?p - plate)
    (isat ?r - robotwaiter ?a - area)
    (isempty ?r - robotwaiter)
    (isadjacent ?a1 - area ?a2 - area)
    (hasbuffet ?a - area)
    (hascustomer ?a - area ?c - customer)
    (isemptyplate ?p - plate)
    (isfilled ?p - plate ?f - food)
    (isservedplate ?p - plate ?c - customer)
    (isavailable ?f - food ?b - buffet)
    (isserved ?c - customer)
    (hasorder ?c - customer ?f - food)
    (hasfood ?b - buffet ?f - food)
  )

  (:functions
    (batterylevel ?r - robotwaiter)
  )

  (:action move
    :parameters (?r - robotwaiter ?from - area ?to - area)
    :precondition (and (isat ?r ?from) (isadjacent ?from ?to) (> (batterylevel ?r) 0))
    :effect (and (not (isat ?r ?from)) (isat ?r ?to) (decrease (batterylevel ?r) 1))
  )

  (:action pickupplate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and (isat ?r ?a) (not (isholdingplate ?r ?p)) (isemptyplate ?p) (isempty ?r))
    :effect (and (isholdingplate ?r ?p) (not (isempty ?r)) (not (isemptyplate ?p)))
  )

  (:action putdownplate
    :parameters (?r - robotwaiter ?p - plate ?a - area)
    :precondition (and (isat ?r ?a) (isholdingplate ?r ?p))
    :effect (and (not (isholdingplate ?r ?p)))))