(define (domain distributed-computing)
  (:requirements :strips :typing :negative-preconditions :equality :fluents :numeric-fluents)

  (:types
    server
    data
    ram
    disk
    network
    resource
    action
  )

  (:predicates
    (server-has-ram ?s - server ?r - ram)
    (server-has-disk ?s - server ?dsk - disk)
    (server-connected-to-network ?s - server ?n - network)
    (data-on-disk ?d - data ?srv - server ?disk - disk)
    (data-in-ram ?d - data ?srv - server ?ram - ram)
    (data-processed ?d - data ?srv - server)
    (ram-on-server ?r - ram ?s - server)
    (disk-on-server ?dsk - disk ?s - server)
    (network-connects-servers ?n - network ?s1 - server ?s2 - server)
  )

  (:functions
    (ram-available ?s - server) - number
    (disk-available ?s - server) - number
    (data-size ?d - data) - number
    (ram-capacity ?r - ram) - number
    (disk-capacity ?dsk - disk) - number
    (bandwidth ?n - network) - number
    (action-cost ?a - action) - number
  )

  (:action load-data-to-ram
    :parameters (?srv - server ?d - data ?disk - disk ?ram - ram)
    :precondition (and
      (server-has-disk ?srv ?disk)
      (server-has-ram ?srv ?ram)
      (data-on-disk ?d ?srv ?disk)
      (disk-on-server ?disk ?srv)
      (ram-on-server ?ram ?srv)
      (not (data-in-ram ?d ?srv ?ram))
      (>= (ram-available ?srv) (data-size ?d))
    )
    :effect (and
      (data-in-ram ?d ?srv ?ram)
      (decrease (ram-available ?srv) (data-size ?d))
      (not (data-on-disk ?d ?srv ?disk))
    )
  )

  (:action save-data-to-disk
    :parameters (?srv - server ?d - data ?ram - ram ?disk - disk)
    :precondition (and
      (server-has-ram ?srv ?ram)
      (server-has-disk ?srv ?disk)
      (data-in-ram ?d ?srv ?ram)
      (disk-on-server ?disk ?srv)
      (ram-on-server ?ram ?srv)
      (not (data-on-disk ?d ?srv ?disk))
      (>= (disk-available ?srv) (data-size ?d))
    )
    :effect (and
      (data-on-disk ?d ?srv ?disk)
      (decrease (disk-available ?srv) (data-size ?d))
      (not (data-in-ram ?d ?srv ?ram))
    )
  )

  (:action unload-data-from-ram
    :parameters (?srv - server ?d - data ?ram - ram)
    :precondition (and
      (server-has-ram ?srv ?ram)
      (data-in-ram ?d ?srv ?ram)
      (ram-on-server ?ram ?srv)
    )
    :effect (and
      (not (data-in-ram ?d ?srv ?ram))
      (increase (ram-available ?srv) (data-size ?d))
    )
  )

  (:action delete-data-from-disk
    :parameters (?srv - server ?d - data ?disk - disk)
    :precondition (and
      (server-has-disk ?srv ?disk)
      (data-on-disk ?d ?srv ?disk)
      (disk-on-server ?disk ?srv)
    )
    :effect (and
      (not (data-on-disk ?d ?srv ?disk))
      (increase (disk-available ?srv) (data-size ?d))
    )
  )

  (:action process-data
    :parameters (?srv - server ?d - data ?ram - ram)
    :precondition (and
      (server-has-ram ?srv ?ram)
      (data-in-ram ?d ?srv ?ram)
      (ram-on-server ?ram ?srv)
      (not (data-processed ?d ?srv))
    )
    :effect (and
      (data-processed ?d ?srv)
    )
  )

  (:action send-data
    :parameters (?src - server ?dst - server ?d - data ?ram_src - ram ?ram_dst - ram ?net - network)
    :precondition (and
      (server-has-ram ?src ?ram_src)
      (server-has-ram ?dst ?ram_dst)
      (data-in-ram ?d ?src ?ram_src)
      (ram-on-server ?ram_src ?src)
      (ram-on-server ?ram_dst ?dst)
      (server-connected-to-network ?src ?net)
      (server-connected-to-network ?dst ?net)
      (network-connects-servers ?net ?src ?dst)
      (not (data-in-ram ?d ?dst ?ram_dst))
      (>= (ram-available ?dst) (data-size ?d))
    )
    :effect (and
      (data-in-ram ?d ?dst ?ram_dst)
      (decrease (ram-available ?dst) (data-size ?d))
    )
  )

  (:action receive-data
    :parameters (?dst - server ?d - data ?ram_dst - ram)
    :precondition (and
      (server-has-ram ?dst ?ram_dst)
      (ram-on-server ?ram_dst ?dst)
      (not (data-in-ram ?d ?dst ?ram_dst))
      (>= (ram-available ?dst) (data-size ?d))
    )
    :effect (and
      (data-in-ram ?d ?dst ?ram_dst)
      (decrease (ram-available ?dst) (data-size ?d))
    )
  )
)