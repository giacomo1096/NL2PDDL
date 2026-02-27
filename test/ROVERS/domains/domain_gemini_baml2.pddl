(define (domain mars-rover-exploration)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents :equality)

  (:types
    rover tool - object
    location - object
    waypoint lander - location
    collectible - object
    sample image - collectible
    soil-sample rock-sample - sample
  )

  (:predicates
    ; Rover state
    (rover-at ?r - rover ?w - waypoint)
    (has-sample ?r - rover ?s - sample)
    (has-image-data ?r - rover ?i - image)
    (equipped-with ?r - rover ?t - tool)

    ; Waypoint properties
    (can-travel ?from - waypoint ?to - waypoint)
    (visited ?w - waypoint)
    (can-communicate ?w - waypoint ?l - lander)

    ; Collectible state
    (communicated ?c - collectible)
    (sample-at ?s - sample ?w - waypoint)
    (analyzed ?s - sample)
    (image-target ?i - image ?w - waypoint)

    ; Tool state
    (calibrated ?t - tool)
    (supports-imaging ?t - tool)
    (supports-analysis ?t - tool)
  )

  (:functions
    (storage-used ?r - rover) - number
    (max-storage ?r - rover) - number
  )

  (:action navigate
    :parameters (?r - rover ?from - waypoint ?to - waypoint)
    :precondition (and
      (rover-at ?r ?from)
      (can-travel ?from ?to)
      (not (= ?from ?to))
    )
    :effect (and
      (not (rover-at ?r ?from))
      (rover-at ?r ?to)
      (visited ?to)
    )
  )

  (:action collect-sample
    :parameters (?r - rover ?w - waypoint ?s - sample)
    :precondition (and
      (rover-at ?r ?w)
      (sample-at ?s ?w)
      (not (has-sample ?r ?s))
      (< (storage-used ?r) (max-storage ?r))
    )
    :effect (and
      (not (sample-at ?s ?w))
      (has-sample ?r ?s)
      (increase (storage-used ?r) 1)
    )
  )

  (:action drop-sample
    :parameters (?r - rover ?w - waypoint ?s - sample)
    :precondition (and
      (rover-at ?r ?w)
      (has-sample ?r ?s)
      (not (sample-at ?s ?w))
    )
    :effect (and
      (not (has-sample ?r ?s))
      (sample-at ?s ?w)
      (decrease (storage-used ?r) 1)
    )
  )

  (:action take-image
    :parameters (?r - rover ?w - waypoint ?i - image ?t - tool)
    :precondition (and
      (rover-at ?r ?w)
      (image-target ?i ?w)
      (equipped-with ?r ?t)
      (supports-imaging ?t)
      (calibrated ?t)
      (not (has-image-data ?r ?i))
    )
    :effect (and
      (has-image-data ?r ?i)
      (not (calibrated ?t))
    )
  )

  (:action calibrate-tool
    :parameters (?r - rover ?t - tool)
    :precondition (and
      (equipped-with ?r ?t)
      (not (calibrated ?t))
    )
    :effect (and
      (calibrated ?t)
    )
  )

  (:action analyze-sample
    :parameters (?r - rover ?s - sample ?t - tool)
    :precondition (and
      (has-sample ?r ?s)
      (equipped-with ?r ?t)
      (supports-analysis ?t)
      (not (analyzed ?s))
    )
    :effect (and
      (analyzed ?s)
    )
  )

  (:action communicate-sample-data
    :parameters (?r - rover ?w - waypoint ?l - lander ?s - sample)
    :precondition (and
      (rover-at ?r ?w)
      (can-communicate ?w ?l)
      (has-sample ?r ?s)
      (analyzed ?s)
      (not (communicated ?s))
    )
    :effect (and
      (communicated ?s)
    )
  )

  (:action communicate-image-data
    :parameters (?r - rover ?w - waypoint ?l - lander ?i - image)
    :precondition (and
      (rover-at ?r ?w)
      (can-communicate ?w ?l)
      (has-image-data ?r ?i)
      (not (communicated ?i))
    )
    :effect (and
      (communicated ?i)
    )
  )
)