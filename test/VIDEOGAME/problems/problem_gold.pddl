(define (problem collect-diamond-2x2)
    (:domain vgdl-game)

    (:objects
        ; Numeri per le coordinate (num)
        n1 n2 - num

        ; Oggetti del gioco (Object, avatar, wall, diamond, exitdoor)
        ava - avatar
        wall1 - wall
        diamond1 - diamond
        exit1 - exitdoor
        o - Object
        dummy-crab - crab
        dummy-sword - sword
        dummy-dirt - dirt
        dummy-boulder - boulder
    )

    (:init
        ; --- Mappa (Definizione delle coordinate) ---
        (next n1 n2)     ; La posizione 2 segue la posizione 1 (per assi X e Y)
        (previous n2 n1) ; La posizione 1 precede la posizione 2

        ; --- Posizioni Iniziali (Coordinate X, Y) ---
        ; Ava (x=1, y=1)
        (at n1 n1 ava)

        ; Diamond1 (x=2, y=1)
        (at n2 n1 diamond1)

        ; Wall1 (x=1, y=2)
        (at n1 n2 wall1)

        ; Exit1 (x=2, y=2)
        (at n2 n2 exitdoor) ; Nota: Nonostante il tipo sia 'exitdoor', lo chiamo exitdoor per evitare conflitti con 'exit1'

        ; --- Stato Iniziale dell'Avatar (Orientamento) ---
        ; Ava guarda a destra (oriented-right)
        (oriented-right ava) 
        
        ; (Gli altri orientamenti sono implicitamente falsi)
        
        ; --- Inventario Avatar ---
        ; Ava non ha la spada (implicitamente)
        ; Ava non ha il diamante (implicitamente)
    )

    (:goal
        (and
            ; L'obiettivo è che Avatar Ava non abbia più il diamante nella sua posizione
            ; L'effetto dell'azione COLLECT_DIAMOND è (not (at ?x ?y ?d)), che simula Ava che lo raccoglie.
            (not (at n2 n1 diamond1)) 
        )
    )
)