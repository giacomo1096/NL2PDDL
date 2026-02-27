(define (problem process-datachunk-a)
  (:domain distributed-computing)

  (:objects
    Server1 Server2 - server
    DataChunkA - data
  )

  (:init
    (stored-on-disk DataChunkA Server1)

    (= (data-size DataChunkA) 500)
    (= (ram-available Server1) 1000)
    (= (ram-available Server2) 1000)
    ; Assuming large default values for unspecified functions
    (= (disk-available Server1) 10000)
    (= (disk-available Server2) 10000)
    (= (network-bandwidth Server1 Server2) 1000)
    (= (network-bandwidth Server2 Server1) 1000)
  )

  (:goal
    (and
      (is-processed DataChunkA)
      (stored-on-disk DataChunkA Server2)
    )
  )
)