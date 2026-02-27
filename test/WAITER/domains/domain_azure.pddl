
(define (domain robot-waiter)
  (:requirements :strips :typing)
  
  (:types
    robotwaiter
    area
    plate
    food
    buffet
    customer
  )

  (:predicates
    ;; Robotwaiter predicates
    (is-holding-plate ?r - robotwaiter)
    
    ;; Area predicates
    (is-adjacent ?a1 - area ?a2 - area)
    
    ;; Plate predicates
    (is-filled ?p - plate)
    (is-held-by-robot ?p - plate)
    
    ;; Food predicates
    (is-available ?f - food)
    
    ;; Buffet predicates
    (has-food ?b - buffet)
    
    ;; Customer predicates
    (is-served ?c - customer)
    (is-waiting ?c - customer)
  )

  (:action move
    :parameters (?r - robotwaiter ?from - area ?to - area)
    :precondition (is-adjacent ?from ?to)
    :effect ()
  )

  (:action pick-up-plate
    :parameters (?r - robotwaiter ?p - plate)
    :precondition (and
      (not (is-holding-plate ?r))
      (not (is-held-by-robot ?p))
    )
    :effect (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
    )
  )

  (:action put-down-plate
    :parameters (?r - robotwaiter ?p - plate)
    :precondition (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
    )
    :effect (and
      (not (is-holding-plate ?r))
      (not (is-held-by-robot ?p))
    )
  )

  (:action fill-plate
    :parameters (?r - robotwaiter ?p - plate ?f - food ?b - buffet)
    :precondition (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
      (not (is-filled ?p))
      (is-available ?f)
      (has-food ?b)
    )
    :effect (is-filled ?p)
  )

  (:action serve-customer
    :parameters (?r - robotwaiter ?p - plate ?c - customer)
    :precondition (and
      (is-holding-plate ?r)
      (is-held-by-robot ?p)
      (is-filled ?p)
      (is-waiting ?c)
      (not (is-served ?c))
    )
    :effect (and
      (is-served ?c)
      (not (is-waiting ?c))
      (not (is-filled ?p))
    )
  )
)