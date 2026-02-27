(define (domain vgdl)
  (:requirements :strips :typing)

  (:types
    object
    avatar wall sword dirt exitdoor diamond boulder crab butterfly - object
    grid
  )

  (:predicates
    (at-avatar ?a - avatar ?g - grid)
    (holding-sword ?a - avatar ?s - sword)
    (holding-diamond ?a - avatar ?d - diamond)
    (at-wall ?w - wall ?g - grid)
    (at-sword ?s - sword ?g - grid)
    (at-dirt ?d - dirt ?g - grid)
    (at-exitdoor ?e - exitdoor ?g - grid)
    (at-diamond ?d - diamond ?g - grid)
    (collected ?d - diamond)
    (at-boulder ?b - boulder ?g - grid)
    (at-crab ?c - crab ?g - grid)
    (at-butterfly ?b - butterfly ?g - grid)
    (is-clear ?g - grid)
    (up-of ?g1 - grid ?g2 - grid)
    (down-of ?g1 - grid ?g2 - grid)
    (left-of ?g1 - grid ?g2 - grid)
    (right-of ?g1 - grid ?g2 - grid)
  )

  (:action move-up
    :parameters (?a - avatar ?from - grid ?to - grid)
    :precondition (and (at-avatar ?a ?from) (up-of ?to ?from) (is-clear ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to))
  )

  (:action move-down
    :parameters (?a - avatar ?from - grid ?to - grid)
    :precondition (and (at-avatar ?a ?from) (down-of ?to ?from) (is-clear ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to))
  )

  (:action move-left
    :parameters (?a - avatar ?from - grid ?to - grid)
    :precondition (and (at-avatar ?a ?from) (left-of ?to ?from) (is-clear ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to))
  )

  (:action move-right
    :parameters (?a - avatar ?from - grid ?to - grid)
    :precondition (and (at-avatar ?a ?from) (right-of ?to ?from) (is-clear ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to))
  )

  (:action pickup-sword
    :parameters (?a - avatar ?s - sword ?g - grid)
    :precondition (and (at-avatar ?a ?g) (at-sword ?s ?g))
    :effect (and (holding-sword ?a ?s) (not (at-sword ?s ?g)))
  )

  (:action pickup-diamond
    :parameters (?a - avatar ?d - diamond ?g - grid)
    :precondition (and (at-avatar ?a ?g) (at-diamond ?d ?g))
    :effect (and (holding-diamond ?a ?d) (collected ?d) (not (at-diamond ?d ?g)))
  )

  (:action dig-up
    :parameters (?a - avatar ?from - grid ?to - grid ?d - dirt)
    :precondition (and (at-avatar ?a ?from) (up-of ?to ?from) (at-dirt ?d ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to) (not (at-dirt ?d ?to)))
  )

  (:action dig-down
    :parameters (?a - avatar ?from - grid ?to - grid ?d - dirt)
    :precondition (and (at-avatar ?a ?from) (down-of ?to ?from) (at-dirt ?d ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to) (not (at-dirt ?d ?to)))
  )

  (:action dig-left
    :parameters (?a - avatar ?from - grid ?to - grid ?d - dirt)
    :precondition (and (at-avatar ?a ?from) (left-of ?to ?from) (at-dirt ?d ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to) (not (at-dirt ?d ?to)))
  )

  (:action dig-right
    :parameters (?a - avatar ?from - grid ?to - grid ?d - dirt)
    :precondition (and (at-avatar ?a ?from) (right-of ?to ?from) (at-dirt ?d ?to))
    :effect (and (not (at-avatar ?a ?from)) (at-avatar ?a ?to) (not (at-dirt ?d ?to)))
  )

  (:action push-up
    :parameters (?a - avatar ?b - boulder ?g_avatar - grid ?g_boulder - grid ?g_dest - grid)
    :precondition (and (at-avatar ?a ?g_avatar) (at-boulder ?b ?g_boulder) (up-of ?g_boulder ?g_avatar) (up-of ?g_dest ?g_boulder) (is-clear ?g_dest))
    :effect (and (not (at-avatar ?a ?g_avatar)) (at-avatar ?a ?g_boulder) (not (at-boulder ?b ?g_boulder)) (at-boulder ?b ?g_dest) (is-clear ?g_boulder) (not (is-clear ?g_dest)))
  )

  (:action push-down
    :parameters (?a - avatar ?b - boulder ?g_avatar - grid ?g_boulder - grid ?g_dest - grid)
    :precondition (and (at-avatar ?a ?g_avatar) (at-boulder ?b ?g_boulder) (down-of ?g_boulder ?g_avatar) (down-of ?g_dest ?g_boulder) (is-clear ?g_dest))
    :effect (and (not (at-avatar ?a ?g_avatar)) (at-avatar ?a ?g_boulder) (not (at-boulder ?b ?g_boulder)) (at-boulder ?b ?g_dest) (is-clear ?g_boulder) (not (is-clear ?g_dest)))
  )

  (:action push-left
    :parameters (?a - avatar ?b - boulder ?g_avatar - grid ?g_boulder - grid ?g_dest - grid)
    :precondition (and (at-avatar ?a ?g_avatar) (at-boulder ?b ?g_boulder) (left-of ?g_boulder ?g_avatar) (left-of ?g_dest ?g_boulder) (is-clear ?g_dest))
    :effect (and (not (at-avatar ?a ?g_avatar)) (at-avatar ?a ?g_boulder) (not (at-boulder ?b ?g_boulder)) (at-boulder ?b ?g_dest) (is-clear ?g_boulder) (not (is-clear ?g_dest)))
  )

  (:action push-right
    :parameters (?a - avatar ?b - boulder ?g_avatar - grid ?g_boulder - grid ?g_dest - grid)
    :precondition (and (at-avatar ?a ?g_avatar) (at-boulder ?b ?g_boulder) (right-of ?g_boulder ?g_avatar) (right-of ?g_dest ?g_boulder) (is-clear ?g_dest))
    :effect (and (not (at-avatar ?a ?g_avatar)) (at-avatar ?a ?g_boulder) (not (at-boulder ?b ?g_boulder)) (at-boulder ?b ?g_dest) (is-clear ?g_boulder) (not (is-clear ?g_dest)))
  )

  (:action kill-crab
    :parameters (?a - avatar ?s - sword ?c - crab ?from - grid ?to - grid)
    :precondition (and (at-avatar ?a ?from) (holding-sword ?a ?s) (at-crab ?c ?to) (up-of ?to ?from))
    :effect (and (not (at-crab ?c ?to)))
  )

  (:action kill-butterfly
    :parameters (?a - avatar ?s - sword ?b - butterfly ?from - grid ?to - grid)
    :precondition (and (at-avatar ?a ?from) (holding-sword ?a ?s) (at-butterfly ?b ?to) (up-of ?to ?from))
    :effect (and (not (at-butterfly ?b ?to)))
  )

  (:action exit-game
    :parameters (?a - avatar ?e - exitdoor ?g - grid)
    :precondition (and (at-avatar ?a ?g) (at-exitdoor ?e ?g))
    :effect (and)
  )
)