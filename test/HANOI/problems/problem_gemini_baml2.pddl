(define (problem hanoi-3-disks-3-pegs)
  (:domain hanoi)

  (:objects
    D1 D2 D3 - disc
    Peg1 Peg2 Peg3 - peg
  )

  (:init
    (on-peg D3 Peg1)
    (on-disc D2 D3)
    (on-disc D1 D2)
    (clear D1)
    (empty Peg2)
    (empty Peg3)
    (hand-empty)
    (smaller D1 D2)
    (smaller D2 D3)
    (smaller D1 D3)
  )

  (:goal
    (and
      (on-peg D3 Peg3)
      (on-disc D2 D3)
      (on-disc D1 D2)
    )
  )
)