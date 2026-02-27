(define (domain libros)
	(:requirements :strips :adl :typing)

	(:types
		Libro Mes - Object
	)

	(:predicates
		(predecesor ?x - Libro ?y - Libro) 
		(anterior ?m - Mes ?n - Mes)
		(libro_asignado ?l - Libro)
		(libro_leido ?l - Libro)
		(libro_a_leer ?l - Libro)
		(asignado_en ?l - Libro ?m - Mes)
		(paralelo ?par - Libro ?libro - Libro)
	)

	(:action asignar
		:parameters (?libro - Libro ?mes - Mes)
		:precondition 
			(and
				(not (libro_asignado ?libro))
				(not (libro_leido ?libro))
				(forall (?pred - Libro)
					(or 
						(libro_leido ?pred)
						(and 
							(imply (predecesor ?pred ?libro) 
								(exists (?ant - Mes) (and (anterior ?ant ?mes) (asignado_en ?pred ?ant)))
							)
							(imply (paralelo ?pred ?libro) (asignado_en ?pred ?mes))
						)
					)
				)
			)
		:effect (and (asignado_en ?libro ?mes) (libro_asignado ?libro))
	)
)