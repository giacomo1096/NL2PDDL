(define (domain mprime-strips)
  (:requirements :strips :typing :negative-preconditions :equality :fluents :numeric-fluents)

  (:types
    vehicle
    cargo
    location
    fuel
    space
  )

  (:predicates
    (vehicle-at ?v - vehicle ?l - location)
    (vehicle-has-fuel ?v - vehicle ?f - fuel)
    (vehicle-has-space ?v - vehicle ?s - space)
    (vehicle-loaded-with-cargo ?v - vehicle ?c - cargo)
    (cargo-at ?c - cargo ?l - location)
    (cargo-loaded-in-vehicle ?c - cargo ?v - vehicle)
    (location-has-fuel ?l - location ?f - fuel)
    (location-has-space ?l - location ?s - space)
    (location-has-cargo ?l - location ?c - cargo)
    (fuel-at-location ?f - fuel ?l - location)
    (fuel-in-vehicle ?f - fuel ?v - vehicle)
    (space-at-location ?s - space ?l - location)
    (space-in-vehicle ?s - space ?v - vehicle)
  )

  (:functions
    (fuel-level ?v - vehicle) - number
    (space-available ?v - vehicle) - number
    (cargo-size ?c - cargo) - number
    (fuel-available ?l - location) - number
    (space-available ?l - location) - number
    (fuel-amount ?f - fuel) - number
    (space-amount ?s - space) - number
  )

  (:action move-vehicle
    :parameters (?v - vehicle ?from - location ?to - location ?f - fuel ?s - space)
    :precondition (and
      (vehicle-at ?v ?from)
      (vehicle-has-fuel ?v ?f)
      (> (fuel-level ?v) 0)
      (location-has-space ?to ?s)
      (> (space-available ?to) 0)
    )
    :effect (and
      (not (vehicle-at ?v ?from))
      (vehicle-at ?v ?to)
      (decrease (fuel-level ?v) 1)
    )
  )

  (:action load-cargo
    :parameters (?v - vehicle ?c - cargo ?l - location ?s - space)
    :precondition (and
      (vehicle-at ?v ?l)
      (cargo-at ?c ?l)
      (vehicle-has-space ?v ?s)
      (>= (space-available ?v) (cargo-size ?c))
      (not (cargo-loaded-in-vehicle ?c ?v))
    )
    :effect (and
      (vehicle-loaded-with-cargo ?v ?c)
      (cargo-loaded-in-vehicle ?c ?v)
      (not (cargo-at ?c ?l))
      (not (vehicle-has-space ?v ?s))
      (decrease (space-available ?v) (cargo-size ?c))
      (not (location-has-cargo ?l ?c))
    )
  )

  (:action unload-cargo
    :parameters (?v - vehicle ?c - cargo ?l - location ?s - space)
    :precondition (and
      (vehicle-at ?v ?l)
      (vehicle-loaded-with-cargo ?v ?c)
      (not (vehicle-has-space ?v ?s))
    )
    :effect (and
      (not (vehicle-loaded-with-cargo ?v ?c))
      (not (cargo-loaded-in-vehicle ?c ?v))
      (cargo-at ?c ?l)
      (vehicle-has-space ?v ?s)
      (increase (space-available ?v) (cargo-size ?c))
      (location-has-cargo ?l ?c)
    )
  )

  (:action transfer-fuel-to-vehicle
    :parameters (?l - location ?v - vehicle ?f - fuel)
    :precondition (and
      (vehicle-at ?v ?l)
      (location-has-fuel ?l ?f)
      (> (fuel-available ?l) 0)
      (not (vehicle-has-fuel ?v ?f))
    )
    :effect (and
      (vehicle-has-fuel ?v ?f)
      (fuel-in-vehicle ?f ?v)
      (not (fuel-at-location ?f ?l))
      (increase (fuel-level ?v) (fuel-amount ?f))
      (decrease (fuel-available ?l) (fuel-amount ?f))
    )
  )

  (:action transfer-fuel-to-location
    :parameters (?v - vehicle ?l - location ?f - fuel)
    :precondition (and
      (vehicle-at ?v ?l)
      (vehicle-has-fuel ?v ?f)
      (> (fuel-level ?v) 0)
      (fuel-in-vehicle ?f ?v)
    )
    :effect (and
      (not (vehicle-has-fuel ?v ?f))
      (not (fuel-in-vehicle ?f ?v))
      (fuel-at-location ?f ?l)
      (decrease (fuel-level ?v) (fuel-amount ?f))
      (increase (fuel-available ?l) (fuel-amount ?f))
    )
  )

  (:action transfer-space-to-vehicle
    :parameters (?l - location ?v - vehicle ?s - space)
    :precondition (and
      (vehicle-at ?v ?l)
      (location-has-space ?l ?s)
      (> (space-available ?l) 0)
      (not (vehicle-has-space ?v ?s))
    )
    :effect (and
      (vehicle-has-space ?v ?s)
      (space-in-vehicle ?s ?v)
      (not (space-at-location ?s ?l))
      (increase (space-available ?v) (space-amount ?s))
      (decrease (space-available ?l) (space-amount ?s))
    )
  )

  (:action transfer-space-to-location
    :parameters (?v - vehicle ?l - location ?s - space)
    :precondition (and
      (vehicle-at ?v ?l)
      (vehicle-has-space ?v ?s)
      (> (space-available ?v) 0)
      (space-in-vehicle ?s ?v)
    )
    :effect (and
      (not (vehicle-has-space ?v ?s))
      (not (space-in-vehicle ?s ?v))
      (space-at-location ?s ?l)
      (decrease (space-available ?v) (space-amount ?s))
      (increase (space-available ?l) (space-amount ?s))
    )
  )
)
