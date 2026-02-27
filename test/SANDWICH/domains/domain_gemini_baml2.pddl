(define (domain child-snack)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    child place tray
    sandwich - object
    gluten-sandwich gluten-free-sandwich - sandwich
  )

  (:predicates
    (allergic-to-gluten ?c - child)
    (has-been-served ?c - child)
    (child-at ?c - child ?p - place)
    (tray-at ?t - tray ?p - place)
    (holding-sandwich ?t - tray ?s - sandwich)
    (is-made ?s - sandwich)
    (sandwich-at ?s - sandwich ?p - place)
    (on-tray ?s - sandwich ?t - tray)
  )

  (:action make-gluten-free-sandwich
    :parameters (?s - gluten-free-sandwich ?p - place)
    :precondition (and
      (not (is-made ?s))
    )
    :effect (and
      (is-made ?s)
      (sandwich-at ?s ?p)
    )
  )

  (:action make-gluten-sandwich
    :parameters (?s - gluten-sandwich ?p - place)
    :precondition (and
      (not (is-made ?s))
    )
    :effect (and
      (is-made ?s)
      (sandwich-at ?s ?p)
    )
  )

  (:action put-on-tray
    :parameters (?s - sandwich ?t - tray ?p - place)
    :precondition (and
      (is-made ?s)
      (sandwich-at ?s ?p)
      (tray-at ?t ?p)
    )
    :effect (and
      (on-tray ?s ?t)
      (holding-sandwich ?t ?s)
      (not (sandwich-at ?s ?p))
    )
  )

  (:action take-off-tray
    :parameters (?s - sandwich ?t - tray ?p - place)
    :precondition (and
      (on-tray ?s ?t)
      (holding-sandwich ?t ?s)
      (tray-at ?t ?p)
    )
    :effect (and
      (sandwich-at ?s ?p)
      (not (on-tray ?s ?t))
      (not (holding-sandwich ?t ?s))
    )
  )

  (:action move-tray
    :parameters (?t - tray ?from - place ?to - place)
    :precondition (and
      (tray-at ?t ?from)
      (not (= ?from ?to))
    )
    :effect (and
      (not (tray-at ?t ?from))
      (tray-at ?t ?to)
    )
  )

  (:action serve-gluten-free-sandwich
    :parameters (?c - child ?s - gluten-free-sandwich ?t - tray ?p - place)
    :precondition (and
      (not (has-been-served ?c))
      (child-at ?c ?p)
      (tray-at ?t ?p)
      (on-tray ?s ?t)
      (holding-sandwich ?t ?s)
    )
    :effect (and
      (has-been-served ?c)
      (not (on-tray ?s ?t))
      (not (holding-sandwich ?t ?s))
      (not (is-made ?s))
    )
  )

  (:action serve-gluten-sandwich
    :parameters (?c - child ?s - gluten-sandwich ?t - tray ?p - place)
    :precondition (and
      (not (has-been-served ?c))
      (not (allergic-to-gluten ?c))
      (child-at ?c ?p)
      (tray-at ?t ?p)
      (on-tray ?s ?t)
      (holding-sandwich ?t ?s)
    )
    :effect (and
      (has-been-served ?c)
      (not (on-tray ?s ?t))
      (not (holding-sandwich ?t ?s))
      (not (is-made ?s))
    )
  )
)
