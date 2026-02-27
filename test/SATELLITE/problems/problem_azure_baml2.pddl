(define (problem planetx-photo)
  (:domain satellite)

  (:objects
    Sat1 - satellite
    Cam1 - instrument
    Spectrograph - mode
    StarA PlanetX - direction
    img1 - image
    pwr1 - power
  )

  (:init
    (pointing Sat1 StarA)
    (on-board Cam1 Sat1)
    (supports-mode Cam1 Spectrograph)
    (not (powered-on Cam1))
    (not (calibrated Cam1))
    (image-mode img1 Spectrograph)
    (image-direction img1 PlanetX)
    (power-for-instrument pwr1 Cam1)
    (= (power-available) 1)
  )

  (:goal
    (and
      (image-captured img1)
    )
  )
)