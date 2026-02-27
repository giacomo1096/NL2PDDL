```pddl
(define (domain mine-world)
  (:requirements :typing :fluents :equality)

  ;; Types
  (:types
    minebot cell item lift rock ore
  )

  ;; Predicates (Boolean Attributes)
  (:predicates
    (at ?b - minebot ?c - cell)                ; Bot is at cell
    (holding ?b - minebot ?i - item)           ; Bot holds item
    (near-lift ?b - minebot ?l - lift)         ; Bot is adjacent to lift
    (can-mine ?b - minebot)                    ; Bot is operational for mining
    (connected ?c1 - cell ?c2 - cell)          ; Cells are adjacent
    (has-rock ?c - cell)                       ; Cell contains a rock
    (has-ore ?c - cell)                        ; Cell contains ore
    (has-item ?c - cell ?i - item)             ; Cell contains item
    (has-lift ?c - cell ?l - lift)             ; Cell contains lift
    (is-mined ?i - item)                       ; Item was extracted from ore
    (is-placed ?i - item)                      ; Item was placed in a cell
    (operational ?l - lift)                    ; Lift is functional
  )

  ;; Functions (Numeric Attributes)
  (:functions
    (battery-level ?b - minebot)               ; Energy remaining
    (current-floor ?l - lift)                   ; Current floor of lift
  )

  ;; Actions
  (:action move
    :parameters (?b - minebot ?from - cell ?to - cell)
    :precondition (and
      (at ?b ?from)
      (connected ?from ?to)
      (> (battery-level ?b) 0)
    )
    :effect (and
      (not (at ?b ?from))
      (at ?b ?to)
      (decrease (battery-level ?b) 1)
    )
  )

  (:action mine-ore
    :parameters (?b - minebot ?c - cell ?i - item)
    :precondition (and
      (at ?b ?c)
      (has-ore ?c)
      (can-mine ?b)
      (> (battery-level ?b) 5)
    )
    :effect (and