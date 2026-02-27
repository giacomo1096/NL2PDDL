(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    block table tool - object
    roboticarm - tool
  )
  (:predicates
    (on ?b1 - block ?b2 - block)
    (ontable ?b - block)
    (clear ?b - block)
    (holding ?arm - roboticarm ?b - block)
    (armempty ?arm - roboticarm)
  )
  (:action stack
    :parameters (?arm - roboticarm ?blocktostack - block ?blockdestination - block)
    :precondition (and
        (holding ?arm ?blocktostack)
        (clear ?blockdestination)
    )
    :effect (and
        (armempty ?arm)
        (not (holding ?arm ?blocktostack))
        (clear ?blocktostack)
        (not (clear ?blockdestination))
        (on ?blocktostack ?blockdestination)
    )
  )
  (:action unstack
    :parameters (?arm - roboticarm ?blocktomove - block ?blockbelow - block)
    :precondition (and
        (on ?blocktomove ?blockbelow)
        (clear ?blocktomove)
        (armempty ?arm)
    )
    :effect (and
        (not (armempty ?arm))
        (holding ?arm ?blocktomove)
        (clear ?blockbelow)
        (not (on ?blocktomove ?blockbelow))
    )
  )
  (:action pickup
    :parameters (?arm - roboticarm ?blocktopickup - block ?table - table)
    :precondition (and
        (ontable ?blocktopickup)
        (clear ?blocktopickup)
        (armempty ?arm)
    )
    :effect (and
        (not (ontable ?blocktopickup))
        (not (armempty ?arm))
        (holding ?arm ?blocktopickup)
    )
  )
  (:action putdown
    :parameters (?arm - roboticarm ?blocktoplace - block ?table - table)
    :precondition (and
        (holding ?arm ?blocktoplace)
    )
    :effect (and
        (not (holding ?arm ?blocktoplace))
        (armempty ?arm)
        (ontable ?blocktoplace)
        (clear ?blocktoplace)
    )
  )
)