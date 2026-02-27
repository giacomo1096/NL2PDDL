(define (problem sat-xor-problem)
    (:domain sat)

    (:objects
        ; Variabili e loro negazioni
        v1 v2 - object ; Variabili
        n1 n2 - object ; Rispettive negazioni (not-v1, not-v2)
    )

    (:init
        ; --- Definizione delle coppie variabile/negazione ---
        (is_neg v1 n1)
        (is_neg n1 v1)
        (is_neg v2 n2)
        (is_neg n2 v2)

        ; --- Stato iniziale (tutte le variabili sono "unset") ---
        (is_clear v1)
        (is_clear n1)
        (is_clear v2)
        (is_clear n2)
    )

    (:goal
        (and
            ; Obiettivo 1: C1 (v1 OR v2) deve essere soddisfatta
            ; (Rappresentata come "v1 OR v2 OR v2" per adattarsi al dominio)
            (sat_clause v1 v2 v2)

            ; Obiettivo 2: C2 (n1 OR n2) -> (NOT v1 OR NOT v2) deve essere soddisfatta
            ; (Rappresentata come "n1 OR n2 OR n2")
            (sat_clause n1 n2 n2)
        )
    )
)