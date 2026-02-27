(define (domain miconic)
  (:requirements :adl :typing)
  (:types passenger
          going_up going_down vip going_nonstop attendant never_alone 
          conflict_A conflict_B
          floor)
  (:predicates 
   (origin ?person - passenger ?floor - floor) 
   (destin ?person - passenger ?floor - floor) 
   (above ?floor1 - floor  ?floor2 - floor)    
   (boarded ?person - passenger) 
   (served ?person - passenger)  
   (lift-at ?floor - floor)      
   )

  (:action stop
    :parameters (?f - floor)
    :precondition (lift-at ?f)
    :effect (and 
	     (forall (?p - passenger) 
		     (when (and (boarded ?p) 
				            (destin ?p ?f))
		           (and (not (boarded ?p)) 
			              (served  ?p))
         )
       )
	     (forall (?p - passenger)                
		     (when (and (origin ?p ?f) (not (served ?p)))
		       (boarded ?p)))))

  (:action up
    :parameters (?f1 - floor ?f2 - floor)
    :precondition (and (lift-at ?f1) (above ?f1 ?f2))
    :effect (and (lift-at ?f2) (not (lift-at ?f1))))

  (:action down
    :parameters (?f1 - floor ?f2 - floor)
    :precondition (and (lift-at ?f1) (above ?f2 ?f1))
    :effect (and (lift-at ?f2) (not (lift-at ?f1))))
  )