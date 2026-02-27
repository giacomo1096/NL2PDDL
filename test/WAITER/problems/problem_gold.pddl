(define (problem serve_customer_lucki)
    (:domain robot_waiter_2)

    (:objects
        ; Aree
        kitchen buffet_area table1 - area

        ; Robot
        lucki - robot

        ; Piatto
        platea - plate

        ; Buffet (l'entità, richiesta dall'azione 'fill')
        buffet_entity - buffet

        ; Cliente (usando 'costumer' come definito nel dominio)
        customer1 - costumer
    )

    (:init
        ; --- Connessioni tra le aree ---
        ; (Bidirezionali grazie a (or) nell'azione 'move')
        (adjacent kitchen buffet_area)
        (adjacent buffet_area table1)

        ; --- Posizioni iniziali degli oggetti ---
        (at lucki kitchen)       ; Il robot è in cucina
        (at platea kitchen)     ; Il piatto è in cucina
        (at customer1 table1)   ; Il cliente è al tavolo 1
        (at buffet_entity buffet_area) ; L'entità buffet si trova nell'area buffet

        ; --- Stati iniziali (impliciti) ---
        ; (not (has_food platea))     ; Il piatto è vuoto (implicito per CWA)
        ; (not (served customer1))  ; Il cliente non è servito (implicito per CWA)
        ; (not (hands_full))        ; Il robot ha le mani libere (implicito per CWA)
    )

    (:goal
        (and
            (served customer1) ; L'obiettivo è che il cliente sia servito
        )
    )
)