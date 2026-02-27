(define (domain miconic)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    elevator - vehicle
    passenger - person
    vip-passenger - passenger
    attendant-passenger - passenger
    floor
    conflict-group
    never-alone-group
    person
    vehicle
  )

  (:predicates
    (elevator-at-floor ?e - elevator ?f - floor)
    (elevator-has-passenger ?e - elevator ?p - passenger)
    (elevator-has-vip-passenger ?e - elevator ?v - vip-passenger)
    (elevator-has-attendant-passenger ?e - elevator ?a - attendant-passenger)
    (door-open ?e - elevator ?f - floor)

    (passenger-at-floor ?p - passenger ?f - floor)
    (passenger-in-elevator ?p - passenger ?e - elevator)
    (passenger-destination ?p - passenger ?f - floor)
    (passenger-served ?p - passenger)

    (vip-passenger-at-floor ?v - vip-passenger ?f - floor)
    (vip-passenger-in-elevator ?v - vip-passenger ?e - elevator)
    (vip-passenger-destination ?v - vip-passenger ?f - floor)
    (vip-passenger-served ?v - vip-passenger)

    (attendant-passenger-at-floor ?a - attendant-passenger ?f - floor)
    (attendant-passenger-in-elevator ?a - attendant-passenger ?e - elevator)
    (attendant-passenger-destination ?a - attendant-passenger ?f - floor)
    (attendant-passenger-served ?a - attendant-passenger)

    (floor-has-call ?f - floor)
    (floor-has-passenger ?f - floor ?p - passenger)

    (in-conflict-group ?p - passenger ?cg - conflict-group)
    (conflict-group-active ?cg - conflict-group)

    (in-never-alone-group ?p - passenger ?nag - never-alone-group)
    (never-alone-group-active ?nag - never-alone-group)
  )

  (:action move-elevator
    :parameters (?e - elevator ?from - floor ?to - floor)
    :precondition (and
      (elevator-at-floor ?e ?from)
      (not (door-open ?e ?from))
    )
    :effect (and
      (not (elevator-at-floor ?e ?from))
      (elevator-at-floor ?e ?to)
    )
  )

  (:action open-door
    :parameters (?e - elevator ?f - floor)
    :precondition (and
      (elevator-at-floor ?e ?f)
      (not (door-open ?e ?f))
    )
    :effect (and
      (door-open ?e ?f)
    )
  )

  (:action close-door
    :parameters (?e - elevator ?f - floor)
    :precondition (and
      (elevator-at-floor ?e ?f)
      (door-open ?e ?f)
    )
    :effect (and
      (not (door-open ?e ?f))
    )
  )

  (:action board-passenger
    :parameters (?p - passenger ?e - elevator ?f - floor)
    :precondition (and
      (passenger-at-floor ?p ?f)
      (elevator-at-floor ?e ?f)
      (door-open ?e ?f)
    )
    :effect (and
      (not (passenger-at-floor ?p ?f))
      (passenger-in-elevator ?p ?e)
      (elevator-has-passenger ?e ?p)
      (not (floor-has-passenger ?f ?p))
    )
  )

  (:action alight-passenger
    :parameters (?p - passenger ?e - elevator ?f - floor)
    :precondition (and
      (passenger-in-elevator ?p ?e)
      (elevator-at-floor ?e ?f)
      (door-open ?e ?f)
      (passenger-destination ?p ?f)
    )
    :effect (and
      (not (passenger-in-elevator ?p ?e))
      (not (elevator-has-passenger ?e ?p))
      (passenger-at-floor ?p ?f)
      (passenger-served ?p)
      (floor-has-passenger ?f ?p)
    )
  )

  (:action board-vip-passenger
    :parameters (?v - vip-passenger ?e - elevator ?f - floor)
    :precondition (and
      (vip-passenger-at-floor ?v ?f)
      (elevator-at-floor ?e ?f)
      (door-open ?e ?f)
    )
    :effect (and
      (not (vip-passenger-at-floor ?v ?f))
      (vip-passenger-in-elevator ?v ?e)
      (elevator-has-vip-passenger ?e ?v)
      (not (floor-has-passenger ?f ?v))
    )
  )

  (:action alight-vip-passenger
    :parameters (?v - vip-passenger ?e - elevator ?f - floor)
    :precondition (and
      (vip-passenger-in-elevator ?v ?e)
      (elevator-at-floor ?e ?f)
      (door-open ?e ?f)
      (vip-passenger-destination ?v ?f)
    )
    :effect (and
      (not (vip-passenger-in-elevator ?v ?e))
      (not (elevator-has-vip-passenger ?e ?v))
      (vip-passenger-at-floor ?v ?f)
      (vip-passenger-served ?v)
      (floor-has-passenger ?f ?v)
    )
  )

  (:action board-attendant-passenger
    :parameters (?a - attendant-passenger ?e - elevator ?f - floor)
    :precondition (and
      (attendant-passenger-at-floor ?a ?f)
      (elevator-at-floor ?e ?f)
      (door-open ?e ?f)
    )
    :effect (and
      (not (attendant-passenger-at-floor ?a ?f))
      (attendant-passenger-in-elevator ?a ?e)
      (elevator-has-attendant-passenger ?e ?a)
      (not (floor-has-passenger ?f ?a))
    )
  )

  (:action alight-attendant-passenger
    :parameters (?a - attendant-passenger ?e - elevator ?f - floor)
    :precondition (and
      (attendant-passenger-in-elevator ?a ?e)
      (elevator-at-floor ?e ?f)
      (door-open ?e ?f)
      (attendant-passenger-destination ?a ?f)
    )
    :effect (and
      (not (attendant-passenger-in-elevator ?a ?e))
      (not (elevator-has-attendant-passenger ?e ?a))
      (attendant-passenger-at-floor ?a ?f)
      (attendant-passenger-served ?a)
      (floor-has-passenger ?f ?a)
    )
  )

  (:action activate-conflict-group
    :parameters (?cg - conflict-group ?p - passenger ?e - elevator)
    :precondition (and
      (in-conflict-group ?p ?cg)
      (passenger-in-elevator ?p ?e)
      (not (conflict-group-active ?cg))
    )
    :effect (and
      (conflict-group-active ?cg)
    )
  )

  (:action deactivate-conflict-group
    :parameters (?cg - conflict-group)
    :precondition (conflict-group-active ?cg)
    :effect (and
      (not (conflict-group-active ?cg))
    )
  )

  (:action activate-never-alone-group
    :parameters (?nag - never-alone-group ?p - passenger ?e - elevator)
    :precondition (and
      (in-never-alone-group ?p ?nag)
      (passenger-in-elevator ?p ?e)
      (not (never-alone-group-active ?nag))
    )
    :effect (and
      (never-alone-group-active ?nag)
    )
  )

  (:action deactivate-never-alone-group
    :parameters (?nag - never-alone-group)
    :precondition (never-alone-group-active ?nag)
    :effect (and
      (not (never-alone-group-active ?nag))
    )
  )

  (:action call-elevator
    :parameters (?p - passenger ?f - floor)
    :precondition (and
      (passenger-at-floor ?p ?f)
      (not (floor-has-call ?f))
    )
    :effect (and
      (floor-has-call ?f)
    )
  )

  (:action clear-elevator-call
    :parameters (?f - floor)
    :precondition (floor-has-call ?f)
    :effect (and
      (not (floor-has-call ?f))
    )
  )
)
