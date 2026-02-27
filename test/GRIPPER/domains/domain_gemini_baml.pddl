(define (domain robot-world)
  (:requirements :typing)

  (:types
    robot gripper object room
  )

  (:predicates
    (robot-at ?r - robot ?l - room)
    (equipped ?r - robot ?g - gripper)
    (gripper-free ?g - gripper)
    (holding ?g - gripper ?o - object)
    (fixed ?o - object)
    (object-at ?o - object ?l - room)
    (connected ?r1 - room ?r2 - room)
  )

  (:action move
    :parameters (?r - robot ?from_room - room ?to_room - room)
    :precondition (and
      (robot-at ?r ?from_room)
      (connected ?from_room ?to_room)
    )
    :effect (and
      (not (robot-at ?r ?from_room))
      (robot-at ?r ?to_room)
    )
  )

  (:action pickup
    :parameters (?r - robot ?target_object - object ?tool_gripper - gripper ?location_room - room)
    :precondition (and
      (equipped ?r ?tool_gripper)
      (robot-at ?r ?location_room)
      (object-at ?target_object ?location_room)
      (gripper-free ?tool_gripper)
    )
    :effect (and
      (not (gripper-free ?tool_gripper))
      (holding ?tool_gripper ?target_object)
      (not (object-at ?target_object ?location_room))
    )
  )

  (:action drop
    :parameters (?r - robot ?held_object - object ?tool_gripper - gripper ?location_room - room)
    :precondition (and
      (equipped ?r ?tool_gripper)
      (robot-at ?r ?location_room)
      (holding ?tool_gripper ?held_object)
    )
    :effect (and
      (gripper-free ?tool_gripper)
      (not (holding ?tool_gripper ?held_object))
      (object-at ?held_object ?location_room)
    )
  )

  (:action fix
    :parameters (?r - robot ?target_object - object ?tool_gripper - gripper ?location_room - room)
    :precondition (and
      (equipped ?r ?tool_gripper)
      (robot-at ?r ?location_room)
      (object-at ?target_object ?location_room)
      (gripper-free ?tool_gripper)
      (not (fixed ?target_object))
    )
    :effect (and
      (fixed ?target_object)
    )
  )
)