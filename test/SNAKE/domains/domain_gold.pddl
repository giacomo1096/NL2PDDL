(define (domain snake)
	(:requirements :strips :negative-preconditions)

	(:constants dummyPoint)

	(:predicates 
		(isAdjacent ?x ?y) 
		(tailSnake ?x) 
		(headSnake ?x) 
                (nextSnake ?x ?y) 
		(blocked ?x) 
		(spawn ?x) 
		(nextSpawn ?x ?y) 
		(isPoint ?x) 
	)

	(:action move
		:parameters (?head ?newHead ?tail ?newTail)
		:precondition (and
			(headSnake ?head)
			(isAdjacent ?head ?newHead)
         		(tailSnake ?tail)
			(nextSnake ?newTail ?tail)
			(not (blocked ?newHead))
			(not (isPoint ?newHead))
		)
        	:effect (and
			(blocked ?newHead)
			(headSnake ?newHead)
			(nextSnake ?newHead ?head)
			(not (headSnake ?head))
			(not (blocked ?tail))
			(not (tailSnake ?tail))
			(not (nextSnake ?newTail ?tail))
			(tailSnake ?newTail)
			)
	)

	(:action move-and-eat-spawn
		:parameters  (?head ?newHead ?spawnPoint ?nextSpawnPoint)
		:precondition (and
			      (headSnake ?head)
			      (isAdjacent ?head ?newHead)
			      (not (blocked ?newHead))
			      (isPoint ?newHead)
			      (spawn ?spawnPoint)
			      (nextSpawn ?spawnPoint ?nextSpawnPoint)
			      (not (= ?spawnPoint dummyPoint))
		)
        	:effect (and
			(blocked ?newHead)
			(headSnake ?newHead)
			(nextSnake ?newHead ?head)
			(not (headSnake ?head))
			(not (isPoint ?newHead))
			(isPoint ?spawnPoint)
			(not (spawn ?spawnPoint))
			(spawn ?nextSpawnPoint)
			)
	)

	(:action move-and-eat-no-spawn
		:parameters  (?head ?newHead)
		:precondition (and
			(headSnake ?head)
			(isAdjacent ?head ?newHead)
			(not (blocked ?newHead))
			(isPoint ?newHead)
			(spawn dummyPoint)
		)
        	:effect (and
			(blocked ?newHead)
			(headSnake ?newHead)
			(nextSnake ?newHead ?head)
			(not (headSnake ?head))
			(not (isPoint ?newHead))
			)
	)
)