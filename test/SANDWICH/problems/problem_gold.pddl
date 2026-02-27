(define (problem serve-celiac-snack)
  (:domain child-snack)

  (:objects
    ; Definizione dei luoghi (kitchen è una costante nel dominio)
    table - place

    ; Definizione degli ingredienti
    bread_a bread_b - bread-portion
    filling1 filling2 - content-portion

    ; Definizione dei panini (potenziali, non ancora esistenti)
    sandw1 sandw2 - sandwich

    ; Definizione dei bambini
    marco anna - child

    ; Definizione del vassoio
    tray1 - tray
  )

  (:init
    ; --- Posizioni iniziali degli ingredienti (in Cucina) ---
    (at_kitchen_bread bread_a)
    (at_kitchen_bread bread_b)
    (at_kitchen_content filling1)
    (at_kitchen_content filling2)

    ; --- Proprietà degli ingredienti ---
    ; Bread_A è senza glutine
    (no_gluten_bread bread_a)
    ; (Bread_B non ha il predicato, quindi contiene glutine)

    ; Assumiamo che i ripieni siano adatti ai celiaci (altrimenti Marco non mangia)
    (no_gluten_content filling1)
    (no_gluten_content filling2)

    ; --- Stato dei panini ---
    ; I panini non esistono ancora
    (notexist sandw1)
    (notexist sandw2)

    ; --- Stato del vassoio ---
    (at tray1 kitchen)

    ; --- Stato dei bambini ---
    ; Marco è al tavolo ed è allergico
    (waiting marco table)
    (allergic_gluten marco)

    ; Anna è al tavolo e non è allergica
    (waiting anna table)
    (not_allergic_gluten anna)
  )

  (:goal
    (and
      ; Entrambi i bambini devono essere serviti
      (served marco)
      (served anna)
    )
  )
)