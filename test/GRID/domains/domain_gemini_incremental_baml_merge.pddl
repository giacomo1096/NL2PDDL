(define (domain mydomain)
  (:requirements :typing :fluents)
  (:types
    robot   ; An agent that performs actions in the environment.
    place   ; A physical location where a robot can be.
    key     ; An object used to unlock a door.
    door    ; A barrier connecting two places that can be locked or unlocked.
    lock    ; A mechanism associated with a door that requires a key.
    shape   ; A property used to match keys with locks.
  )

(:predicates
	(at-robot ?r - robot ?p - place)
	(handempty ?r - robot)
	(holding ?r - robot ?k - key)
	(connected ?from - place ?to - place ?d - door)
	(at-key ?k - key ?p - place)
	(key-shape ?k - key ?s - shape)
	(unlocked ?d - door)
	(door-has-lock ?d - door ?l - lock)
	(lock-shape ?l - lock ?s - shape)
)

(:action move
    :parameters (?r - robot ?from - place ?to - place ?d - door)
    :precondition (and
        (at-robot ?r ?from)
        (connected ?from ?to ?d)
        (unlocked ?d)
    )
    :effect (and
        (not (at-robot ?r ?from))
        (at-robot ?r ?to)
    )
)
(:action pickup-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
        (at-robot ?r ?p)
        (at-key ?k ?p)
        (handempty ?r)
    )
    :effect (and
        (holding ?r ?k)
        (not (handempty ?r))
        (not (at-key ?k ?p))
    )
)
(:action drop-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
        (at-robot ?r ?p)
        (holding ?r ?k)
    )
    :effect (and
        (not (holding ?r ?k))
        (handempty ?r)
        (at-key ?k ?p)
    )
)
(:action unlock-door
    :parameters (?r - robot ?k - key ?d - door ?l - lock ?s - shape ?p - place ?p2 - place)
    :precondition (and
        (at-robot ?r ?p)
        (connected ?p ?p2 ?d)
        (holding ?r ?k)
        (door-has-lock ?d ?l)
        (key-shape ?k ?s)
        (lock-shape ?l ?s)
        (not (unlocked ?d))
    )
    :effect (and
        (unlocked ?d)
    )
))
