
// Function to generate the PDDL domain file
function GeneratePDDLDomainAzure(
  domain_description: string,    // "A world of blocks with a robot arm..."
  object_nl: string,   
  attributes_nl: string,
  actions_nl: string
) -> PDDLDomainResult {
  client "CustomAzure"
  prompt #"
You are a PDDL domain code generator with perfect syntax knowledge.

TASK: Generate a complete, valid, and executable PDDL domain file.

CRITICAL SYNTAX RULES:
1. Perfect parenthesis balance - every ( must have matching )
2. Proper spacing: (define (domain name)) NOT (define(domain name))
3. Types section: use " - " (space-dash-space) for inheritance
4. Predicate signatures: EXACTLY ONE type per parameter, NO union types
5. Action parameters: MUST have " - " before type
6. Effects: use (not (pred)) for deletion, NOT (delete (pred))

STRUCTURE REQUIREMENTS:
(define (domain DOMAIN-NAME)
  (:requirements :strips :typing :negative-preconditions :equality)
  
  (:types
    type1 type2 - parent-type
    type3 - object
  )
  
  (:predicates
    (pred-name ?param - type)
    (binary-pred ?p1 - type1 ?p2 - type2)
  )
  
  (:functions
    (func-name ?param - type) - number
  )  ;; ONLY if numeric fluents exist
  
  (:action action-name
    :parameters (?p1 - type1 ?p2 - type2)
    :precondition (and
      (pred1 ?p1)
      (pred2 ?p1 ?p2)
      (> (func ?p1) 0)  ;; for numeric
    )
    :effect (and
      (pred3 ?p2)
      (not (pred1 ?p1))
      (increase (func ?p1) 5)  ;; for numeric
    )
  )
)

PREDICATE CONVERSION RULES:
Input attribute format: "Predicate: (robot-at ?r - robot ?l - location)"
Output PDDL: (robot-at ?r - robot ?l - location)

EFFECT CONVERSION:
- "add (?r ?loc)" → (robot-at ?r ?loc)
- "delete (?r ?from)" → (not (robot-at ?r ?from))
- "increase by 5" → (increase (attribute-name ?param) 5)
- "decrease by 3" → (decrease (attribute-name ?param) 3)

COMMON ERRORS TO AVOID:
❌ (on ?b - (block | table))  →  ✓ Use separate predicates
❌ (on-table ?b - block)      →  ✓ Ensure consistent with attributes
   (on ?b1 ?b2 - block)       
❌ :parameters (?r robot)      →  ✓ :parameters (?r - robot)
❌ (delete (at ?r ?l))         →  ✓ (not (at ?r ?l))

REQUIREMENTS SELECTION:
- Always: :strips :typing
- If negated preconditions: :negative-preconditions
- If numeric fluents: :fluents :numeric-fluents
- If conditional effects: :conditional-effects
- If equality checks: :equality

EXAMPLE 1 - Blocksworld:
Input Types: block, robot-arm
Input Predicates: on-table(?b - block), on-block(?b1 - block ?b2 - block), clear(?b - block), arm-empty(?arm - robot-arm), held-by-arm(?b - block ?arm - robot-arm)
Input Actions: pickup(from table), stack, unstack, putdown

Output:
(define (domain blocksworld)
  (:requirements :strips :typing :negative-preconditions)
  
  (:types
    block
    robot-arm
  )
  
  (:predicates
    (on-table ?b - block)
    (on-block ?b1 - block ?b2 - block)
    (clear ?b - block)
    (arm-empty ?arm - robot-arm)
    (held-by-arm ?b - block ?arm - robot-arm)
  )
  
  (:action pickup-from-table
    :parameters (?arm - robot-arm ?b - block)
    :precondition (and
      (on-table ?b)
      (clear ?b)
      (arm-empty ?arm)
    )
    :effect (and
      (not (on-table ?b))
      (not (arm-empty ?arm))
      (held-by-arm ?b ?arm)
    )
  )
  
  (:action putdown-on-table
    :parameters (?arm - robot-arm ?b - block)
    :precondition (held-by-arm ?b ?arm)
    :effect (and
      (on-table ?b)
      (clear ?b)
      (arm-empty ?arm)
      (not (held-by-arm ?b ?arm))
    )
  )
  
  (:action stack
    :parameters (?arm - robot-arm ?b1 - block ?b2 - block)
    :precondition (and
      (held-by-arm ?b1 ?arm)
      (clear ?b2)
    )
    :effect (and
      (on-block ?b1 ?b2)
      (clear ?b1)
      (arm-empty ?arm)
      (not (held-by-arm ?b1 ?arm))
      (not (clear ?b2))
    )
  )
  
  (:action unstack
    :parameters (?arm - robot-arm ?b1 - block ?b2 - block)
    :precondition (and
      (on-block ?b1 ?b2)
      (clear ?b1)
      (arm-empty ?arm)
    )
    :effect (and
      (held-by-arm ?b1 ?arm)
      (clear ?b2)
      (not (on-block ?b1 ?b2))
      (not (clear ?b1))
      (not (arm-empty ?arm))
    )
  )
)

EXAMPLE 2 - Logistics with numeric (fuel):
Input includes: battery-level (numeric 0-100)

Output:
(define (domain logistics)
  (:requirements :strips :typing :fluents :numeric-fluents)
  
  (:types
    robot package location
  )
  
  (:predicates
    (robot-at ?r - robot ?l - location)
    (package-at ?p - package ?l - location)
    (carrying ?r - robot ?p - package)
  )
  
  (:functions
    (battery-level ?r - robot) - number
  )
  
  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (robot-at ?r ?from)
      (> (battery-level ?r) 0)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
      (decrease (battery-level ?r) 1)
    )
  )
  
  (:action pickup
    :parameters (?r - robot ?p - package ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (package-at ?p ?loc)
    )
    :effect (and
      (carrying ?r ?p)
      (not (package-at ?p ?loc))
    )
  )
)

---

NOW GENERATE PDDL FROM:

Domain Description:
{{domain_description}}

Types (NL):
{{object_nl}}

Predicates (NL):
{{attributes_nl}}

Actions (NL):
{{actions_nl}}

CRITICAL: Return ONLY valid JSON:
{
  "domain_name": "lowercase-name",
  "pddl_code": "complete PDDL code as single string with \\n for newlines",
  "explanation": "brief explanation of key design decisions"
}

Verify parenthesis balance before returning. Ensure types match across predicates and actions.
"#
}