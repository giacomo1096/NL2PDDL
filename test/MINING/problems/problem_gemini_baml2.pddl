(define (problem get-the-gold)
  (:domain gold-miner)

  (:objects
    robot - robot
    base toolshed gold-vein - location
    bomb - bomb
    soft-rock - soft-rock
    gold - gold
  )

  (:init
    (robot-at robot base)
    (arm-empty robot)

    (connected base toolshed)
    (connected toolshed base)
    (connected toolshed gold-vein)
    (connected gold-vein toolshed)

    (clear base)
    (clear toolshed)

    (bomb-at bomb toolshed)
    (soft-rock-at soft-rock gold-vein)
    (gold-at gold gold-vein)
  )

  (:goal
    (and
      (holding-gold robot gold)
    )
  )
)