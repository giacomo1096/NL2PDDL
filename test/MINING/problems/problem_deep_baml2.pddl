(define (problem gold-mining-problem)
  (:domain gold-mining)

  (:objects
    Robot - robot
    Base Toolshed Gold-Vein - location
    Bomb - bomb
    Soft-Rock - soft-rock
    Gold - gold
  )

  (:init
    (arm-empty Robot)
    (clear Base)
    (clear Toolshed)
    (robot-at Robot Base)
    (object-at Bomb Toolshed)
    (object-at Gold Gold-Vein)
    (obstacle-at Soft-Rock Gold-Vein)
    (connected Base Toolshed)
    (connected Toolshed Base)
    (connected Toolshed Gold-Vein)
    (connected Gold-Vein Toolshed)
  )

  (:goal
    (holding Robot Gold)
  )
)