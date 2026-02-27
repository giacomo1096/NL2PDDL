(define (problem satellite-image-planetx)
  (:domain satellite)

  (:objects
    Sat1 - satellite
    Cam1 - instrument
    Spectrograph - mode
    StarA - direction
    PlanetX - direction
    image1 - image
  )

  (:init
    ;; Satellite state
    (pointing Sat1 StarA)
    (= (power-available Sat1) 100)

    ;; Instrument state and configuration
    (on-board Cam1 Sat1)
    ;; (power-on Cam1) is false
    ;; (calibrated Cam1) is false
    (supports Cam1 Spectrograph)
    (calibration-target Cam1 StarA)

    ;; Image requirements
    (image-requires image1 PlanetX Spectrograph)
    ;; (image-data-available image1) is false
  )

  (:goal
    (and
      (image-data-available image1)
    )
  )
)