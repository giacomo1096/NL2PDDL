(define (problem snake-3x3-scenario)
  (:domain snake-game)

  (:objects
    ; Griglia 3x3 (Coordinate R_C)
    l_1_1 l_1_2 l_1_3
    l_2_1 l_2_2 l_2_3
    l_3_1 l_3_2 l_3_3 - location

    ; Il Campo di gioco
    game_grid - field

    ; Il Serpente (Testa)
    snake_h - snake-head

    ; Le Mele
    apple1 apple2 - point
  )

  (:init
    ; --- Configurazione del Campo ---
    (field-active game_grid)
    
    ; Definizione delle celle valide nel campo
    (location-in-field game_grid l_1_1) (location-in-field game_grid l_1_2) (location-in-field game_grid l_1_3)
    (location-in-field game_grid l_2_1) (location-in-field game_grid l_2_2) (location-in-field game_grid l_2_3)
    (location-in-field game_grid l_3_1) (location-in-field game_grid l_3_2) (location-in-field game_grid l_3_3)

    ; --- Stato Iniziale del Serpente (Posizione 1,1) ---
    (snake-alive snake_h)
    (head-at snake_h l_1_1)
    (snake-at snake_h l_1_1)          ; Necessario per le precondizioni di movimento
    (occupied-by-snake l_1_1 snake_h) ; La casella è occupata
    (= (snake-length snake_h) 1)

    ; --- Stato Iniziale Mela 1 (Presente in 1,2) ---
    (point-at apple1 l_1_2)
    (occupied-by-point l_1_2 apple1)

    ; --- Stato Iniziale Mela 2 (In attesa) ---
    ; Apple2 non ha predicati 'point-at' o 'occupied' all'inizio.
    ; Il pianificatore dovrà usare l'azione 'spawn-point' per farla apparire
    ; in una posizione valida (es. 2,2) per poi raccoglierla.
    ; (not (point-collected apple2)) è implicito.
  )

  (:goal
    (and
      ; L'obiettivo è aver raccolto entrambe le mele
      (point-collected apple1)
      (point-collected apple2)
    )
  )
)