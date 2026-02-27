(define (problem read-two-books-sequential)
    (:domain libros)

    (:objects
        ; Libri (i compiti)
        booka bookb - Libro

        ; Mesi (gli slot temporali)
        month1 month2 - Mes
    )

    (:init
        ; --- Definizione della linea temporale ---
        (anterior month1 month2) ; Il mese 1 viene prima del mese 2

        ; --- Vincoli di Precedenza ---
        ; Per assegnare BookB, BookA deve essere in un mese precedente.
        (predecesor booka bookb)
    )

    (:goal
        (and
            ; L'obiettivo è aver assegnato (quindi "letto") entrambi i libri
            (libro_asignado booka)
            (libro_asignado bookb)
        )
    )
)