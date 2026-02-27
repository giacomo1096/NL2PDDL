```pddl
(define (domain cleaning-robot)
  (:requirements :typing :fluents)

  ;; Types
  (:types
    robot tile grid direction - object
  )

  ;; Predicates
  (:predicates
    (at ?r - robot ?t - tile)          ; Robot is at tile
    (is-cleaning ?r - robot)           ; Robot is actively cleaning
    (is-clean ?t - tile)               ; Tile is clean
    (is-dirty ?t - tile)               ; Tile is dirty
    (adjacent ?t1 - tile ?t2 - tile ?d - direction) ; Adjacency relation
  )

  ;; Functions (Fluents)
  (:functions
    (battery-level ?r - robot) - number ; Remaining battery level
  )

  ;; Action: Move
  (:action move
    :parameters (?r - robot ?from - tile ?to - tile ?d - direction)
    :precondition (and
      (at ?r ?from)                     ; Robot is at 'from'
      (adjacent ?from ?to ?d)          ; 'to' is adjacent to 'from' in direction 'd'
      (> (battery-level ?r) 0)         ; Battery > 0
      (not (is-cleaning ?r))           ; Robot is not cleaning
    )
    :effect (and
      (not (at ?r ?from))              ; Robot leaves 'from'
      (at ?r ?to)                      ; Robot moves to 'to'
      (decrease (battery-level ?r) 1)  ; Battery decreases by 1
    )
  )

  ;; Action: Start Cleaning
  (:action start-cleaning
    :parameters (?r - robot ?t - tile)
    :precondition (and
      (at ?r ?t)                       ; Robot is at tile
      (is-dirty ?t)                   ; Tile is dirty
      (> (battery-level ?r) 0)         ; Battery > 0
      (not (is-cleaning ?r))           ; Robot is not already cleaning
    )
    :effect (and
      (is-cleaning ?r)                 ; Robot starts cleaning
      (not (is-dirty ?t))              ; Tile is no longer dirty
      (is