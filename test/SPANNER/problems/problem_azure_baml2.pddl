(define (problem fix-gate-nut)
    (:domain spanner-nut)

    (:objects
        bob - man

        shed garden gate - location

        spanner1 - spanner
        nut1 - nut
    )

    (:init
        (connected shed garden)
        (connected garden shed)
        (connected garden gate)
        (connected gate garden)

        (man-at bob garden)      
        (spanner-at spanner1 shed)
        (nut-at nut1 gate)        
        
        (spanner-usable spanner1) 
    )

    (:goal
        (and
            (nut-tightened nut1)
        )
    )
)