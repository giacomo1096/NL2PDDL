(define (domain satellite)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents)

  (:types
    satellite
    instrument
    direction
    mode
    image
  )

  (:predicates
    (pointing ?s - satellite ?d - direction)
    (on-board ?i - instrument ?s - satellite)
    (powered-on ?i - instrument)
    (calibrated ?i - instrument)
    (captured ?img - image)
    (image-direction ?img - image ?d - direction)
    (image-mode ?img - image ?m - mode)
  )

  (:functions
    (power-level ?s - satellite) - number
  )

  (:action turn_to
    :parameters (?s - satellite ?d_old - direction ?d_new - direction)
    :precondition (and
      (pointing ?s ?d_old)
      (> (power-level ?s) 0)
    )
    :effect (and
      (not (pointing ?s ?d_old))
      (pointing ?s ?d_new)
      (decrease (power-level ?s) 5)
    )
  )

  (:action switch_on
    :parameters (?s - satellite ?i - instrument)
    :precondition (and
      (on-board ?i ?s)
      (not (powered-on ?i))
      (> (power-level ?s) 0)
    )
    :effect (and
      (powered-on ?i)
      (decrease (power-level ?s) 5)
    )
  )

  (:action switch_off
    :parameters (?s - satellite ?i - instrument)
    :precondition (and
      (on-board ?i ?s)
      (powered-on ?i)
    )
    :effect (and
      (not (powered-on ?i))
    )
  )

  (:action calibrate
    :parameters (?s - satellite ?i - instrument ?d - direction)
    :precondition (and
      (on-board ?i ?s)
      (powered-on ?i)
      (pointing ?s ?d)
      (> (power-level ?s) 0)
    )
    :effect (and
      (calibrated ?i)
      (decrease (power-level ?s) 10)
    )
  )

  (:action take_image
    :parameters (?s - satellite ?i - instrument ?d - direction ?img - image ?m - mode)
    :precondition (and
      (on-board ?i ?s)
      (powered-on ?i)
      (calibrated ?i)
      (pointing ?s ?d)
      (image-direction ?img ?d)
      (image-mode ?img ?m)
      (> (power-level ?s) 0)
    )
    :effect (and
      (captured ?img)
      (decrease (power-level ?s) 15)
    )
  )
)