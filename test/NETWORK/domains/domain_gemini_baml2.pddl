(define (domain distributed-computing)
  (:requirements :strips :typing :negative-preconditions :equality :numeric-fluents)

  (:types
    server
    data
  )

  (:predicates
    (stored-on-disk ?d - data ?s - server)
    (loaded-in-ram ?d - data ?s - server)
    (is-processed ?d - data)
  )

  (:functions
    (ram-available ?s - server) - number
    (disk-available ?s - server) - number
    (network-bandwidth ?s1 - server ?s2 - server) - number
    (data-size ?d - data) - number
  )

  (:action load-to-ram
    :parameters (?d - data ?s - server)
    :precondition (and
      (stored-on-disk ?d ?s)
      (not (loaded-in-ram ?d ?s))
      (>= (ram-available ?s) (data-size ?d))
    )
    :effect (and
      (loaded-in-ram ?d ?s)
      (decrease (ram-available ?s) (data-size ?d))
    )
  )

  (:action unload-from-ram
    :parameters (?d - data ?s - server)
    :precondition (and
      (loaded-in-ram ?d ?s)
      (stored-on-disk ?d ?s)
    )
    :effect (and
      (not (loaded-in-ram ?d ?s))
      (increase (ram-available ?s) (data-size ?d))
    )
  )

  (:action send-data
    :parameters (?d - data ?s1 - server ?s2 - server)
    :precondition (and
      (not (= ?s1 ?s2))
      (loaded-in-ram ?d ?s1)
      (not (stored-on-disk ?d ?s2))
      (>= (disk-available ?s2) (/ (data-size ?d) 1024))
    )
    :effect (and
      (stored-on-disk ?d ?s2)
      (decrease (disk-available ?s2) (/ (data-size ?d) 1024))
    )
  )

  (:action process-data
    :parameters (?d - data ?s - server)
    :precondition (and
      (loaded-in-ram ?d ?s)
      (not (is-processed ?d))
    )
    :effect (and
      (is-processed ?d)
    )
  )

  (:action delete-from-disk
    :parameters (?d - data ?s - server)
    :precondition (and
      (stored-on-disk ?d ?s)
      (not (loaded-in-ram ?d ?s))
    )
    :effect (and
      (not (stored-on-disk ?d ?s))
      (increase (disk-available ?s) (/ (data-size ?d) 1024))
    )
  )
)