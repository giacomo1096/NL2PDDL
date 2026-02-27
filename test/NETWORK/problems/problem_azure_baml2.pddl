(define (problem process-data-on-remote-server)
  (:domain distributed-computing)

  (:objects
    Server1 Server2 - server
    DataChunkA - data
    Server1_RAM Server2_RAM - ram
    Server1_Disk - disk
    network - network
  )

  (:init
    (server-has-ram Server1 Server1_RAM)
    (server-has-disk Server1 Server1_Disk)
    (server-connected-to-network Server1 network)
    (server-has-ram Server2 Server2_RAM)
    (server-connected-to-network Server2 network)
    (disk-on-server Server1_Disk Server1)
    (ram-on-server Server1_RAM Server1)
    (ram-on-server Server2_RAM Server2)
    (data-on-disk DataChunkA Server1 Server1_Disk)
    (network-connects-servers network Server1 Server2)
    (= (ram-available Server1) 1000)
    (= (ram-available Server2) 1000)
    (= (ram-capacity Server1_RAM) 1000)
    (= (ram-capacity Server2_RAM) 1000)
    (= (data-size DataChunkA) 500)
    (= (disk-capacity Server1_Disk) 1000)
    (not (data-in-ram DataChunkA Server1 Server1_RAM))
    (not (data-in-ram DataChunkA Server2 Server2_RAM))
    (not (data-processed DataChunkA Server2))
  )

  (:goal
    (and
      (data-in-ram DataChunkA Server2 Server2_RAM)
      (data-processed DataChunkA Server2)
    )
  )
)