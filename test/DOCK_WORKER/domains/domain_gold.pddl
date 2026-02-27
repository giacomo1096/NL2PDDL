(define (domain dock-worker-robot-simple)
 (:requirements :strips :typing )
 (:types 
  location      
  robot         
  container)

 (:predicates
   (adjacent ?l1  ?l2 - location)       
   (atl ?r - robot ?l - location)       
   (loaded ?r - robot ?c - container )  
   (unloaded ?r - robot)                
   (in ?c - container ?l - location)    
   )

 (:action move                                
     :parameters (?r - robot ?from - location ?to - location)
     :precondition (and (adjacent ?from ?to) (atl ?r ?from) )
     :effect (and (atl ?r ?to)
                    (not (atl ?r ?from)) ))

 (:action load                                
     :parameters (?l - location ?c - container ?r - robot)
     :precondition (and (atl ?r ?l) (in ?c ?l) (unloaded ?r))
     :effect (and (loaded ?r ?c)
                    (not (in ?c ?l)) (not (unloaded ?r)) ))

 (:action unload                                 
     :parameters (?l - location ?c - container ?r - robot)
     :precondition (and (atl ?r ?l) (loaded ?r ?c) )
     :effect (and (unloaded ?r) (in ?c ?l)
                    (not (loaded ?r ?c)) )) )