(define (problem fix-loose-nut)
    (:domain spanner-domain)

    (:objects
        ; Il protagonista
        bob - man

        ; Le posizioni
        shed garden gate - location

        ; L'attrezzo
        spanner1 - spanner

        ; L'obiettivo
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
 
        (loose nut1)             
        (usable spanner1)          
    )

    (:goal
        (and 
            (not (loose nut1))
        )
    )
)