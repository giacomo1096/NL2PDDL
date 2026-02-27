(define (problem fix_machine)
    (:domain screw)

    (:objects
        ; Definiamo gli oggetti del problema
        workshop warehouse - object ; Trattati come 'object' generici
        machine1 - object
        g1 - object ; Il gripper del robot
    )

    (:init
        ; --- Definizione dei "tipi" (come da dominio) ---
        (ROOM workshop)
        (ROOM warehouse)
        (OBJECTS machine1)
        (GRIPPER g1)

        ; --- Stato iniziale ---
        (rob_room workshop)            ; Il robot è nell'officina
        (obj_room warehouse machine1)  ; La macchina è nel magazzino

        ; Il robot può riparare la macchina con la sua pinza
        (can_fix machine1 g1)

        ; (not (fixed_obj machine1)) ; Implicito (Closed World Assumption)
    )

    (:goal
        (and
            (fixed_obj machine1) ; L'obiettivo è che la macchina sia riparata
        )
    )
)