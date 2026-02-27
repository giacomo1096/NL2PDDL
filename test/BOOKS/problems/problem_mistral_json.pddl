(define (problem reading_plan_problem)
  (:domain reading_planner)

  (:objects
    BookA BookB - libro
    Month1 Month2 - mes
    Prereq_A_for_B - prerequisito
  )

  (:init
    ; Books are not assigned or read initially
    (not (is-assigned BookA))
    (not (is-assigned BookB))
    (not (is-read BookA))
    (not (is-read BookB))

    ; Months have no assignments and are not completed
    (not (has-assignment Month1))
    (not (has-assignment Month2))
    (not (is-completed Month1))
    (not (is-completed Month2))

    ; Prerequisite: BookB requires BookA to be read first
    (has-prerequisite BookB Prereq_A_for_B)
    (not (is-satisfied Prereq_A_for_B))
  )

  (:goal (and
    ; Both books must be read
    (is-read BookA)
    (is-read BookB)

    ; Both months must be completed
    (is-completed Month1)
    (is-completed Month2)

    ; Prerequisite must be satisfied
    (is-satisfied Prereq_A_for_B)
  ))
)