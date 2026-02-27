(define (problem gold-mining-scenario)
  (:domain gold-miner-typed)
  
  (:objects
    Base Toolshed GoldVein - LOC
  )
  
  (:init
    (robot-at Base)
    (arm-empty)
    
    (bomb-at Toolshed)
    
    (soft-rock-at GoldVein)
    (gold-at GoldVein)
    
    (connected Base Toolshed)
    (connected Toolshed Base)
    (connected Toolshed GoldVein)
    (connected GoldVein Toolshed)
    
    (clear Base)
    (clear Toolshed)
  )
  
  (:goal
    (holds-gold)
  )
)