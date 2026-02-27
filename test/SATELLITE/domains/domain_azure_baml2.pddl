(define (domain satellite)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents)

  (:types
    satellite
    instrument
    direction
    mode
    image
    power
  )

  (:predicates
    (pointing ?s - satellite ?d - direction)
    (has-power ?s - satellite ?p - power)
    (on-board ?i - instrument ?s - satellite)
    (powered-on ?i - instrument)
    (calibrated ?i - instrument)
    (supports-mode ?i - instrument ?m - mode)
    (power-for-instrument ?p - power ?i - instrument)
    (image-captured ?img - image)
    (image-mode ?img - image ?m - mode)
    (image-direction ?img - image ?d - direction)
  )

  (:functions
    (power-available) - number
  )

  (:action turn
    :parameters (?s - satellite ?from - direction ?to - direction)
    :precondition (and
      (pointing ?s ?from)
      (not (pointing ?s ?to))
    )
    :effect (and
      (not (pointing ?s ?from))
      (pointing ?s ?to)
    )
  )

  (:action switch-on-instrument
    :parameters (?s - satellite ?i - instrument ?p - power)
    :precondition (and
      (on-board ?i ?s)
      (has-power ?s ?p)
      (power-for-instrument ?p ?i)
      (not (powered-on ?i))
    )
    :effect (and
      (powered-on ?i)
    )
  )

  (:action switch-off-instrument
    :parameters (?s - satellite ?i - instrument)
    :precondition (and
      (on-board ?i ?s)
      (powered-on ?i)
    )
    :effect (and
      (not (powered-on ?i))
      (not (calibrated ?i))
    )
  )

  (:action calibrate-instrument
    :parameters (?s - satellite ?i - instrument ?d - direction)
    :precondition (and
      (on-board ?i ?s)
      (powered-on ?i)
      (pointing ?s ?d)
      (not (calibrated ?i))
    )
    :effect (and
      (calibrated ?i)
    )
  )

  (:action decalibrate-instrument
    :parameters (?i - instrument)
    :precondition (calibrated ?i)
    :effect (and
      (not (calibrated ?i))
    )
  )

  (:action take-image
    :parameters (?s - satellite ?i - instrument ?img - image ?d - direction ?m - mode)
    :precondition (and
      (on-board ?i ?s)
      (powered-on ?i)
      (calibrated ?i)
      (pointing ?s ?d)
      (supports-mode ?i ?m)
      (image-mode ?img ?m)
      (image-direction ?img ?d)
      (not (image-captured ?img))
    )
    :effect (and
      (image-captured ?img)
      (not (calibrated ?i))
    )
  )

  (:action allocate-power
    :parameters (?s - satellite ?p - power)
    :precondition (and
      (> (power-available) 0)
      (not (has-power ?s ?p))
    )
    :effect (and
      (has-power ?s ?p)
      (decrease (power-available) 1)
    )
  )

  (:action release-power
    :parameters (?s - satellite ?p - power)
    :precondition (has-power ?s ?p)
    :effect (and
      (not (has-power ?s ?p))
      (increase (power-available) 1)
    )
  )
)
