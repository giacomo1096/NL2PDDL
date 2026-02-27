(define (domain floor-tile)

	(:requirements :typing)

	(:types robot tile - object)

	(:predicates  

    (robot-at ?robot - robot ?robotTile - tile)

    (up ?tileAbove - tile ?tileBelow - tile)

    (down ?tileBelow - tile ?tileAbove - tile)

    (right ?tileOnRight - tile ?tileOnLeft - tile)

    (left ?tileOnLeft - tile ?tileOnRight - tile)

    (clear ?clearedTile - tile)

    (cleaned ?cleanedTile - tile)
 	)

  (:action clean-up

        :parameters (?robot - robot ?robotTile - tile ?tileToBeCleaned - tile)

        :precondition (and

                       (robot-at ?robot ?robotTile) 

                       (up ?tileToBeCleaned ?robotTile) 

                       (clear ?tileToBeCleaned)

                       (not(cleaned ?tileToBeCleaned))
                  )

    :effect (and 

               ( cleaned ?tileToBeCleaned)

               (not(clear ?tileToBeCleaned))
            )
  )

  (:action clean-down

     :parameters (?robot - robot ?robotTile - tile ?tileToBeCleaned - tile )

   :precondition (and 

                      (robot-at ?robot ?robotTile)

                      (down ?tileToBeCleaned ?robotTile)

                      (clear ?tileToBeCleaned) 

                      (not(cleaned ?tileToBeCleaned))
                  )

    :effect (and 

              ( cleaned ?tileToBeCleaned)

              (not(clear ?tileToBeCleaned))
          )
  )

  (:action up

         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)

         :precondition (and 

                        (robot-at ?robot ?robotTile)

                        (up ?moveToNextTile ?robotTile)

                        (clear ?moveToNextTile)

                        (not(cleaned ?moveToNextTile))
                       )

         :effect (and 

                  (not(robot-at ?robot ?robotTile)) 

                  (robot-at ?robot ?moveToNextTile)

                  (not(clear ?moveToNextTile)) 

                  ( clear ?robotTile)
                 )  
  )

  (:action down

         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)

         :precondition (and 

                        (robot-at ?robot ?robotTile)

                        (down ?moveToNextTile ?robotTile)

                        (clear ?moveToNextTile)

                        (not(cleaned ?moveToNextTile))
                       )

         :effect (and 

                  (not(robot-at ?robot ?robotTile)) 

                  (robot-at ?robot ?moveToNextTile)

                  (not(clear ?moveToNextTile)) 

                  ( clear ?robotTile)
                 )  
  )

  (:action right

         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)

         :precondition (and 

                        (robot-at ?robot ?robotTile)

                        (right ?moveToNextTile ?robotTile)

                        (clear ?moveToNextTile)

                        (not(cleaned ?moveToNextTile))
                       )

         :effect (and 

                  (not(robot-at ?robot ?robotTile)) 

                  (robot-at ?robot ?moveToNextTile)

                  (not(clear ?moveToNextTile)) 

                  ( clear ?robotTile)
                 )  
  )

  (:action left

         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)

         :precondition (and 

                        (robot-at ?robot ?robotTile)

                        (left ?moveToNextTile ?robotTile)

                        (clear ?moveToNextTile)

                        (not(cleaned ?moveToNextTile))
                       )

         :effect (and 

                  (not(robot-at ?robot ?robotTile)) 

                  (robot-at ?robot ?moveToNextTile)

                  (not(clear ?moveToNextTile)) 

                  ( clear ?robotTile)
                 )  
  )
)