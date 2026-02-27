(define (domain parking)
  (:requirements :strips :typing :negative-preconditions :equality :fluents :numeric-fluents)

  (:types
    car
    curb
    space
    location
    vehicle
  )

  (:predicates
    (car-at-curb ?c - car ?cu - curb)
    (car-at-behind-car ?c1 - car ?c2 - car)
    (car-at-space ?c - car ?s - space)
    (car-at-location ?c - car ?l - location)
    (parked ?c - car)
    (curb-has-space ?cu - curb ?s - space)
    (space-at-curb ?s - space ?cu - curb)
    (space-behind-car ?s - space ?c - car)
    (space-available ?s - space)
    (is-curb-location ?l - location ?cu - curb)
    (is-behind-car-location ?l - location ?c - car)
    (is-car ?v - vehicle ?c - car)
  )

  (:functions
    (total-cost) - number
  )

  (:action park-at-curb
    :parameters (?c - car ?cu - curb ?s - space ?l - location)
    :precondition (and
      (space-at-curb ?s ?cu)
      (space-available ?s)
      (curb-has-space ?cu ?s)
      (is-curb-location ?l ?cu)
      (not (parked ?c))
    )
    :effect (and
      (car-at-curb ?c ?cu)
      (car-at-space ?c ?s)
      (car-at-location ?c ?l)
      (parked ?c)
      (not (space-available ?s))
      (increase (total-cost) 1)
    )
  )

  (:action unpark-from-curb
    :parameters (?c - car ?cu - curb ?s - space ?l - location)
    :precondition (and
      (car-at-curb ?c ?cu)
      (car-at-space ?c ?s)
      (car-at-location ?c ?l)
      (is-curb-location ?l ?cu)
      (parked ?c)
    )
    :effect (and
      (not (car-at-curb ?c ?cu))
      (not (car-at-space ?c ?s))
      (not (car-at-location ?c ?l))
      (not (parked ?c))
      (space-available ?s)
      (increase (total-cost) 1)
    )
  )

  (:action park-behind-car
    :parameters (?c1 - car ?c2 - car ?s - space ?l - location)
    :precondition (and
      (space-behind-car ?s ?c2)
      (space-available ?s)
      (is-behind-car-location ?l ?c2)
      (not (parked ?c1))
      (parked ?c2)
    )
    :effect (and
      (car-at-behind-car ?c1 ?c2)
      (car-at-space ?c1 ?s)
      (car-at-location ?c1 ?l)
      (parked ?c1)
      (not (space-available ?s))
      (increase (total-cost) 1)
    )
  )

  (:action unpark-from-behind-car
    :parameters (?c1 - car ?c2 - car ?s - space ?l - location)
    :precondition (and
      (car-at-behind-car ?c1 ?c2)
      (car-at-space ?c1 ?s)
      (car-at-location ?c1 ?l)
      (is-behind-car-location ?l ?c2)
      (parked ?c1)
    )
    :effect (and
      (not (car-at-behind-car ?c1 ?c2))
      (not (car-at-space ?c1 ?s))
      (not (car-at-location ?c1 ?l))
      (not (parked ?c1))
      (space-available ?s)
      (increase (total-cost) 1)
    )
  )

  (:action move-car-curb-to-curb
    :parameters (?c - car ?from_curb - curb ?to_curb - curb ?from_space - space ?to_space - space ?from_loc - location ?to_loc - location)
    :precondition (and
      (car-at-curb ?c ?from_curb)
      (car-at-space ?c ?from_space)
      (car-at-location ?c ?from_loc)
      (is-curb-location ?from_loc ?from_curb)
      (is-curb-location ?to_loc ?to_curb)
      (space-at-curb ?to_space ?to_curb)
      (space-available ?to_space)
      (curb-has-space ?to_curb ?to_space)
      (parked ?c)
    )
    :effect (and
      (not (car-at-curb ?c ?from_curb))
      (not (car-at-space ?c ?from_space))
      (not (car-at-location ?c ?from_loc))
      (car-at-curb ?c ?to_curb)
      (car-at-space ?c ?to_space)
      (car-at-location ?c ?to_loc)
      (space-available ?from_space)
      (not (space-available ?to_space))
      (increase (total-cost) 2)
    )
  )

  (:action move-car-curb-to-behind-car
    :parameters (?c - car ?from_curb - curb ?to_car - car ?from_space - space ?to_space - space ?from_loc - location ?to_loc - location)
    :precondition (and
      (car-at-curb ?c ?from_curb)
      (car-at-space ?c ?from_space)
      (car-at-location ?c ?from_loc)
      (is-curb-location ?from_loc ?from_curb)
      (is-behind-car-location ?to_loc ?to_car)
      (space-behind-car ?to_space ?to_car)
      (space-available ?to_space)
      (parked ?c)
      (parked ?to_car)
    )
    :effect (and
      (not (car-at-curb ?c ?from_curb))
      (not (car-at-space ?c ?from_space))
      (not (car-at-location ?c ?from_loc))
      (car-at-behind-car ?c ?to_car)
      (car-at-space ?c ?to_space)
      (car-at-location ?c ?to_loc)
      (space-available ?from_space)
      (not (space-available ?to_space))
      (increase (total-cost) 2)
    )
  )

  (:action move-car-behind-car-to-curb
    :parameters (?c - car ?from_car - car ?to_curb - curb ?from_space - space ?to_space - space ?from_loc - location ?to_loc - location)
    :precondition (and
      (car-at-behind-car ?c ?from_car)
      (car-at-space ?c ?from_space)
      (car-at-location ?c ?from_loc)
      (is-behind-car-location ?from_loc ?from_car)
      (is-curb-location ?to_loc ?to_curb)
      (space-at-curb ?to_space ?to_curb)
      (space-available ?to_space)
      (curb-has-space ?to_curb ?to_space)
      (parked ?c)
    )
    :effect (and
      (not (car-at-behind-car ?c ?from_car))
      (not (car-at-space ?c ?from_space))
      (not (car-at-location ?c ?from_loc))
      (car-at-curb ?c ?to_curb)
      (car-at-space ?c ?to_space)
      (car-at-location ?c ?to_loc)
      (space-available ?from_space)
      (not (space-available ?to_space))
      (increase (total-cost) 2)
    )
  )

  (:action move-car-behind-car-to-behind-car
    :parameters (?c - car ?from_car - car ?to_car - car ?from_space - space ?to_space - space ?from_loc - location ?to_loc - location)
    :precondition (and
      (car-at-behind-car ?c ?from_car)
      (car-at-space ?c ?from_space)
      (car-at-location ?c ?from_loc)
      (is-behind-car-location ?from_loc ?from_car)
      (is-behind-car-location ?to_loc ?to_car)
      (space-behind-car ?to_space ?to_car)
      (space-available ?to_space)
      (parked ?c)
      (parked ?to_car)
    )
    :effect (and
      (not (car-at-behind-car ?c ?from_car))
      (not (car-at-space ?c ?from_space))
      (not (car-at-location ?c ?from_loc))
      (car-at-behind-car ?c ?to_car)
      (car-at-space ?c ?to_space)
      (car-at-location ?c ?to_loc)
      (space-available ?from_space)
      (not (space-available ?to_space))
      (increase (total-cost) 2)
    )
  )
)
