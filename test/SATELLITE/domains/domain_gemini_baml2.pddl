(define (domain satellite)
  (:requirements :strips :typing :negative-preconditions :equality :fluents :numeric-fluents)

  (:types
    satellite direction instrument image mode
  )

  (:predicates
    (pointing ?s - satellite ?d - direction)
    (on-board ?i - instrument ?s - satellite)
    (power-on ?i - instrument)
    (calibrated ?i - instrument)
    (supports ?i - instrument ?m - mode)
    (calibration-target ?i - instrument ?d - direction)
    (image-requires ?img - image ?d - direction ?m - mode)
    (image-data-available ?img - image)
  )

  (:functions
    (power-available ?s - satellite) - number
  )

  (:action turn_to
    :parameters (?s - satellite ?d_from - direction ?d_to - direction)
    :precondition (and
      (pointing ?s ?d_from)
      (not (= ?d_from ?d_to))
      (>= (power-available ?s) 10)
    )
    :effect (and
      (not (pointing ?s ?d_from))
      (pointing ?s ?d_to)
      (decrease (power-available ?s) 10)
    )
  )

  (:action switch_on
    :parameters (?s - satellite ?i - instrument)
    :precondition (and
      (on-board ?i ?s)
      (not (power-on ?i))
      (>= (power-available ?s) 5)
    )
    :effect (and
      (power-on ?i)
      (decrease (power-available ?s) 5)
    )
  )

  (:action switch_off
    :parameters (?s - satellite ?i - instrument)
    :precondition (and
      (on-board ?i ?s)
      (power-on ?i)
    )
    :effect (and
      (not (power-on ?i))
      (not (calibrated ?i))
    )
  )

  (:action calibrate
    :parameters (?s - satellite ?i - instrument ?d - direction)
    :precondition (and
      (on-board ?i ?s)
      (calibration-target ?i ?d)
      (pointing ?s ?d)
      (power-on ?i)
      (not (calibrated ?i))
      (>= (power-available ?s) 5)
    )
    :effect (and
      (calibrated ?i)
      (decrease (power-available ?s) 5)
    )
  )

  (:action take_image
    :parameters (?s - satellite ?i - instrument ?d - direction ?m - mode ?img - image)
    :precondition (and
      (image-requires ?img ?d ?m)
      (not (image-data-available ?img))
      (on-board ?i ?s)
      (supports ?i ?m)
      (calibrated ?i)
      (power-on ?i)
      (pointing ?s ?d)
      (>= (power-available ?s) 2)
    )
    :effect (and
      (image-data-available ?img)
      (not (calibrated ?i))
      (decrease (power-available ?s) 2)
    )
  )
)
