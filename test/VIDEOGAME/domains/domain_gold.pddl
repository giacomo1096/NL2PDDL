(define (domain vgdl-game)
  (:requirements :typing)

  (:types 
    num
    Object
    avatar wall sword dirt exitdoor diamond boulder crab butterfly - Object
  )

  (:predicates
    (oriented-up ?o - Object)
    (oriented-down ?o - Object)
    (oriented-left ?o - Object)
    (oriented-right ?o - Object)
    (oriented-none ?o - Object)
    (next ?x ?y - num)
    (previous ?x ?y - num)
    (at ?x ?y - num ?o - Object)
    (has-sword ?a - avatar)
  )

  (:action MOVE_UP
    :parameters (?a - avatar ?x1 ?x2 ?y1 ?y2 - num)
    :precondition (and 
      (at ?x1 ?y1 ?a)
      (next ?y1 ?y2)
      (not (exists (?w - wall) (at ?x1 ?y2 ?w)))
    )
    :effect (and
      (not (at ?x1 ?y1 ?a))
      (at ?x1 ?y2 ?a)
      (oriented-up ?a)
      (not (oriented-down ?a))
      (not (oriented-left ?a))
      (not (oriented-right ?a))
      (not (oriented-none ?a))
    )
  )

  (:action MOVE_DOWN
    :parameters (?a - avatar ?x1 ?x2 ?y1 ?y2 - num)
    :precondition (and 
      (at ?x1 ?y1 ?a)
      (next ?y2 ?y1)
      (not (exists (?w - wall) (at ?x1 ?y2 ?w)))
    )
    :effect (and
      (not (at ?x1 ?y1 ?a))
      (at ?x1 ?y2 ?a)
      (oriented-down ?a)
      (not (oriented-up ?a))
      (not (oriented-left ?a))
      (not (oriented-right ?a))
      (not (oriented-none ?a))
    )
  )

  (:action MOVE_LEFT
    :parameters (?a - avatar ?x1 ?x2 ?y1 ?y2 - num)
    :precondition (and 
      (at ?x1 ?y1 ?a)
      (next ?x2 ?x1)
      (not (exists (?w - wall) (at ?x2 ?y1 ?w)))
    )
    :effect (and
      (not (at ?x1 ?y1 ?a))
      (at ?x2 ?y1 ?a)
      (oriented-left ?a)
      (not (oriented-up ?a))
      (not (oriented-down ?a))
      (not (oriented-right ?a))
      (not (oriented-none ?a))
    )
  )

  (:action MOVE_RIGHT
    :parameters (?a - avatar ?x1 ?x2 ?y1 ?y2 - num)
    :precondition (and 
      (at ?x1 ?y1 ?a)
      (previous ?x2 ?x1)
      (not (exists (?w - wall) (at ?x2 ?y1 ?w)))
    )
    :effect (and
      (not (at ?x1 ?y1 ?a))
      (at ?x2 ?y1 ?a)
      (oriented-right ?a)
      (not (oriented-up ?a))
      (not (oriented-down ?a))
      (not (oriented-left ?a))
      (not (oriented-none ?a))
    )
  )

  (:action COLLECT_DIAMOND
    :parameters (?a - avatar ?d - diamond ?x ?y - num)
    :precondition (and
      (at ?x ?y ?a)
      (at ?x ?y ?d)
    )
    :effect (and
      (not (at ?x ?y ?d))
    )
  )

  (:action COLLECT_SWORD
    :parameters (?a - avatar ?s - sword ?x ?y - num)
    :precondition (and
      (at ?x ?y ?a)
      (at ?x ?y ?s)
      (not (has-sword ?a))
    )
    :effect (and
      (not (at ?x ?y ?s))
      (has-sword ?a)
    )
  )

  (:action KILL_CRAB
    :parameters (?a - avatar ?c - crab ?x ?y - num)
    :precondition (and
      (at ?x ?y ?a)
      (at ?x ?y ?c)
      (has-sword ?a)
    )
    :effect (and
      (not (at ?x ?y ?c))
    )
  )

  (:action KILL_BUTTERFLY
    :parameters (?a - avatar ?b - butterfly ?x ?y - num)
    :precondition (and
      (at ?x ?y ?a)
      (at ?x ?y ?b)
      (has-sword ?a)
    )
    :effect (and
      (not (at ?x ?y ?b))
    )
  )
)