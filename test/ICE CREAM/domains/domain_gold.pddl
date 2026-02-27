(define (domain myDomain)
    (:predicates (packaging)(assemble)(delivered)
        (have-sprinkle)(have-chocolate)(have-vanilla)(have-cone)(have-order)
        (sprinkle ?x)(chocolate ?x)(vanilla ?x)(cone ?x)(order ?x))

    (:action packaging
        :parameters ()
	    :precondition (and (assemble)
	    	    	   (not (delivered))) 
        :effect (and (packaging)
                (not (assemble)))) 

    (:action delivery
        :parameters ()
        :precondition (and(not (delivered)) 
                      (packaging))
        :effect (and (delivered)
                 (not (packaging))))

    (:action add-sprinkle
        :parameters (?x)
        :precondition (sprinkle ?x)
        :effect (have-sprinkle))

    (:action add-chocolate
        :parameters (?x)
        :precondition (chocolate ?x)
        :effect (have-chocolate))

    (:action add-vanilla
        :parameters (?x)
        :precondition (vanilla ?x)
        :effect (have-vanilla))

    (:action add-cone
        :parameters (?x)
        :precondition (cone ?x)
        :effect (have-cone))
    (:action order
        :parameters (?x)
        :precondition (order ?x)
        :effect (have-order))

)