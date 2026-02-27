(define (domain data-network)
(:requirements :adl :typing :negative-preconditions :equality :action-costs)

(:types data script server numbers)

(:predicates (SCRIPT-IO ?s - script ?in1 - data ?in2 - data ?out - data)
             (CONNECTED ?from - server ?to - server)
             (DATA-SIZE ?d - data ?n - numbers)
             (CAPACITY ?s - server ?n - numbers)
             (SUM ?n1 - numbers ?n2 - numbers ?sum - numbers)
             (LESS-EQUAL ?n1 - numbers ?n2 - numbers)
             (saved ?d - data ?s - server)
             (cached ?d - data ?s - server)
             (usage ?s - server ?n - numbers))

(:functions (total-cost) - number
            (process-cost ?sc - script ?s - server) - number
            (send-cost ?from ?to - server ?size - numbers) - number
            (io-cost ?s - server ?size - numbers) - number)

(:action release
 :parameters (?d - data ?s - server ?size ?before ?after - numbers)
 :precondition (and (DATA-SIZE ?d ?size)
                    (SUM ?after ?size ?before)
                    (cached ?d ?s)
                    (usage ?s ?before))
 :effect (and (not (cached ?d ?s))
              (not (usage ?s ?before))
              (usage ?s ?after)
              (increase (total-cost) 0)))

(:action save
 :parameters (?d - data ?size - numbers ?s - server)
 :precondition (and (DATA-SIZE ?d ?size)
                    (cached ?d ?s))
 :effect (and (saved ?d ?s)
              (increase (total-cost) (io-cost ?s ?size))))

(:action load
 :parameters (?d - data ?s - server ?size ?limit ?before ?after - numbers)
 :precondition (and (DATA-SIZE ?d ?size)
                    (CAPACITY ?s ?limit)
                    (SUM ?before ?size ?after)
                    (LESS-EQUAL ?after ?limit)
                    (saved ?d ?s)
                    (not (cached ?d ?s))
                    (usage ?s ?before))
 :effect (and (cached ?d ?s)
              (not (usage ?s ?before))
              (usage ?s ?after)
              (increase (total-cost) (io-cost ?s ?size))))

(:action send
 :parameters (?d - data ?from ?to - server  ?size ?limit ?before ?after - numbers)
 :precondition (and (CONNECTED ?from ?to)
                    (DATA-SIZE ?d ?size)
                    (CAPACITY ?to ?limit)
                    (SUM ?before ?size ?after)
                    (LESS-EQUAL ?after ?limit)
                    (cached ?d ?from)
                    (not (cached ?d ?to))
                    (usage ?to ?before))
 :effect (and (cached ?d ?to)
              (not (usage ?to ?before))
              (usage ?to ?after)
              (increase (total-cost) (send-cost ?from ?to ?size))))

(:action process
 :parameters (?in1 ?in2 ?out - data ?sc - script ?s - server ?size ?limit ?before ?after - numbers)
 :precondition (and (SCRIPT-IO ?sc ?in1 ?in2 ?out)
                    (DATA-SIZE ?out ?size)
                    (CAPACITY ?s ?limit)
                    (SUM ?before ?size ?after)
                    (LESS-EQUAL ?after ?limit)
                    (cached ?in1 ?s)
                    (cached ?in2 ?s)
                    (not (cached ?out ?s))
                    (usage ?s ?before))
 :effect (and (cached ?out ?s)
              (not (usage ?s ?before))
              (usage ?s ?after)
              (increase (total-cost) (process-cost ?sc ?s))))
)