(define (domain mydomain)
    (:requirements :typing :fluents)
    (:types
        robot area plate food customer - object
        buffet - area
    )

(:predicates
    (at-robot ?r - robot ?a - area)
    (hand-empty ?r - robot)
    (holding-plate ?r - robot ?p - plate)
    (adjacent ?a1 - area ?a2 - area)
    (at-plate ?p - plate ?a - area)
    (filled-with ?p - plate ?f - food)
    (available-at-buffet ?f - food ?b - buffet)
    (at-customer ?c - customer ?a - area)
    (wants-food ?c - customer ?f - food)
    (served ?c - customer)
)

(:action move
	:parameters (?r - robot ?from - area ?to - area)
	:precondition (and
		(at-robot ?r ?from)
		(adjacent ?from ?to)
	)
	:effect (and
		(not (at-robot ?r ?from))
		(at-robot ?r ?to)
	)
)
(:action pickup-plate
	:parameters (?r - robot ?p - plate ?a - area)
	:precondition (and
		(at-robot ?r ?a)
		(at-plate ?p ?a)
		(hand-empty ?r)
	)
	:effect (and
		(not (hand-empty ?r))
		(holding-plate ?r ?p)
		(not (at-plate ?p ?a))
	)
)
(:action fill-plate
	:parameters (?r - robot ?p - plate ?f - food ?b - buffet)
	:precondition (and
		(at-robot ?r ?b)
		(holding-plate ?r ?p)
		(available-at-buffet ?f ?b)
		(not (filled-with ?p ?f))
	)
	:effect (and
		(filled-with ?p ?f)
	)
)
(:action serve-customer
	:parameters (?r - robot ?p - plate ?c - customer ?f - food ?a - area)
	:precondition (and
		(at-robot ?r ?a)
		(at-customer ?c ?a)
		(holding-plate ?r ?p)
		(filled-with ?p ?f)
		(wants-food ?c ?f)
		(not (served ?c))
	)
	:effect (and
		(served ?c)
		(not (wants-food ?c ?f))
		(not (holding-plate ?r ?p))
		(hand-empty ?r)
		(at-plate ?p ?a)
		(not (filled-with ?p ?f))
	)
)
(:action drop-plate
	:parameters (?r - robot ?p - plate ?a - area)
	:precondition (and
		(at-robot ?r ?a)
		(holding-plate ?r ?p)
	)
	:effect (and
		(hand-empty ?r)
		(not (holding-plate ?r ?p))
		(at-plate ?p ?a)
	)
))
