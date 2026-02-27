(define (domain blocks-world-domain)
  (:requirements :typing) ; :fluents is not a standard requirement, :typing is sufficient.

  (:types
    block - object
    roboticarm - object ; Simplified typing, as tool/table were not adding value.
  )

  (:predicates
    (on ?b1 - block ?b2 - block)
    (on-table ?b - block)
    (clear ?b - block)
    (holding ?arm - roboticarm ?b - block)
    (arm-empty ?arm - roboticarm)
  )

  (:action stack
    :parameters (?arm - roboticarm ?block_to_stack - block ?block_destination - block)
    :precondition (and
        (holding ?arm ?block_to_stack)
        (clear ?block_destination)
    )
    :effect (and
        (arm-empty ?arm)
        (not (holding ?arm ?block_to_stack))
        (clear ?block_to_stack)
        (not (clear ?block_destination))
        (on ?block_to_stack ?block_destination)
    )
  )

  (:action unstack
    :parameters (?arm - roboticarm ?block_to_move - block ?block_below - block)
    :precondition (and
        (on ?block_to_move ?block_below)
        (clear ?block_to_move)
        (arm-empty ?arm)
    )
    :effect (and
        (not (arm-empty ?arm))
        (holding ?arm ?block_to_move)
        (clear ?block_below)
        (not (on ?block_to_move ?block_below))
        ; CORRECTION: A block being held is no longer clear.
        (not (clear ?block_to_move))
    )
  )

  (:action pick-up
    ; CORRECTION: Removed unused '?table - table' parameter.
    :parameters (?arm - roboticarm ?block_to_pickup - block)
    :precondition (and
        (on-table ?block_to_pickup)
        (clear ?block_to_pickup)
        (arm-empty ?arm)
    )
    :effect (and
        (not (on-table ?block_to_pickup))
        (not (arm-empty ?arm))
        (holding ?arm ?block_to_pickup)
        ; CORRECTION: A block being held is no longer clear.
        (not (clear ?block_to_pickup))
    )
  )

  (:action put-down
    ; CORRECTION: Removed unused '?table - table' parameter.
    :parameters (?arm - roboticarm ?block_to_place - block)
    :precondition (and
        (holding ?arm ?block_to_place)
    )
    :effect (and
        (not (holding ?arm ?block_to_place))
        (arm-empty ?arm)
        (on-table ?block_to_place)
        (clear ?block_to_place)
    )
  )
)