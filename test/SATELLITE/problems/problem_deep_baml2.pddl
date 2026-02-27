(define (problem take-image-of-planetx)
  (:domain satellite)

  (:objects
    Sat1 - satellite
    Cam1 - instrument
    Spectrograph - mode
    StarA PlanetX - direction
    img1 - image
  )

  (:init
    (pointing Sat1 StarA)
    (on-board Cam1 Sat1)
    (not (powered-on Cam1))
    (not (calibrated Cam1))
    (image-direction img1 PlanetX)
    (image-mode img1 Spectrograph)
    (= (power-level Sat1) 100)
  )

  (:goal
    (captured img1)
  )
)