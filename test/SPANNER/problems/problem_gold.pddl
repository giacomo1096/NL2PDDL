(define (problem fix-garden-gate)
    (:domain spanner)

    (:objects
        ; Definiamo le tre location
        shed garden gate - location

        ; Il protagonista
        bob - man

        ; Gli oggetti
        spanner1 - spanner
        nut1 - nut
    )

    (:init
        ; --- Connessioni (Bidirezionali) ---
        ; Shed collegato al Garden
        (link shed garden)
        (link garden shed)

        ; Garden collegato al Gate
        (link garden gate)
        (link gate garden)

        ; --- Posizioni Iniziali ---
        (at bob garden)      ; Bob è in giardino
        (at spanner1 shed)   ; La chiave inglese è nel capanno
        (at nut1 gate)       ; Il dado è sul cancello

        ; --- Stato degli Oggetti ---
        (loose nut1)         ; Il dado è allentato
        (useable spanner1)   ; La chiave è utilizzabile (necessario per l'azione tighten_nut)

        ; Bob non sta trasportando nulla (implicito per Closed World Assumption)
        ; Il dado non è stretto (implicito)
    )

    (:goal
        (and
            ; L'obiettivo è stringere il dado
            (tightened nut1)
        )
    )
)