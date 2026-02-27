(define (domain parking)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents)

  (:types
    car curb
  )

  (:predicates
    (parked-at-curb ?c - car ?k - curb)
    (parked-behind ?c1 - car ?c2 - car)
  )

  (:functions
    (curb-available-spaces ?k - curb) - number
    (car-available-rear-spaces ?c - car) - number
  )

  (:action move-curb-to-curb
    :parameters (?c - car ?from - curb ?to - curb)
    :precondition (and
      (parked-at-curb ?c ?from)
      (> (curb-available-spaces ?to) 0)
    )
    :effect (and
      (not (parked-at-curb ?c ?from))
      (parked-at-curb ?c ?to)
      (increase (curb-available-spaces ?from) 1)
      (decrease (curb-available-spaces ?to) 1)
    )
  )

  (:action move-curb-to-behind
    :parameters (?c - car ?from - curb ?to - car)
    :precondition (and
      (parked-at-curb ?c ?from)
      (> (car-available-rear-spaces ?to) 0)
    )
    :effect (and
      (not (parked-at-curb ?c ?from))
      (parked-behind ?c ?to)
      (increase (curb-available-spaces ?from) 1)
      (decrease (car-available-rear-spaces ?to) 1)
    )
  )

  (:action move-behind-to-curb
    :parameters (?c - car ?from - car ?to - curb)
    :precondition (and
      (parked-behind ?c ?from)
      (> (curb-available-spaces ?to) 0)
    )
    :effect (and
      (not (parked-behind ?c ?from))
      (parked-at-curb ?c ?to)
      (increase (car-available-rear-spaces ?from) 1)
      (decrease (curb-available-spaces ?to) 1)
    )
  )

  (:action move-behind-to-behind
    :parameters (?c - car ?from - car ?to - car)
    :precondition (and
      (parked-behind ?c ?from)
      (> (car-available-rear-spaces ?to) 0)
    )
    :effect (and
      (not (parked-behind ?c ?from))
      (parked-behind ?c ?to)
      (increase (car-available-rear-spaces ?from) 1)
      (decrease (car-available-rear-spaces ?to) 1)
    )
  )
)