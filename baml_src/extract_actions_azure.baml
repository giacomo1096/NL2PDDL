// Funzione per estrarre le azioni dal dominio
function ExtractActionsAzure(domain_description: string, object_types: string, object_attributes: string) -> ActionsResult {
    client "CustomAzure"
    prompt #"You are an expert in PDDL action modeling and automated extraction.

TASK: Extract ALL actions with precise parameters, preconditions, and effects using PDDL semantics.

CRITICAL RULES:
1. Parameters: List ALL parameters with ?-prefix and correct types
2. Preconditions: Use EXACT attribute names from the provided attributes
3. Effects: Clearly specify ADD/DELETE for boolean predicates, INCREASE/DECREASE for numeric
4. Be explicit about parameter bindings in conditions/effects
5. Extract both explicit actions AND implied actions (e.g., "load" implies "unload")

PARAMETER RULES:
- Format: {"name": "?param", "type": "typename"}
- Always use ? prefix
- Include ALL objects involved in the action

PRECONDITION FORMAT:
- For boolean predicates: {"attribute": "pred-name", "condition": "(?p1 ?p2 ...) = true"} or "= false"
- For numeric: {"attribute": "fuel", "condition": "> 0"} or ">= 10", "< 100", etc.
- Be specific about which parameters are used

EFFECT FORMAT:
- Boolean add: {"attribute": "at", "change": "add (?r ?loc)"}
- Boolean delete: {"attribute": "at", "change": "delete (?r ?old-loc)"}
- Numeric increase: {"attribute": "fuel", "change": "decrease by 5"}
- Numeric set: {"attribute": "battery", "change": "set to 100"}

EXAMPLES:

Example 1 - Move action:
Domain: "Robot moves between locations, consuming 1 battery per move. Must have battery > 0."
Types: robot, location
Attributes: robot-at (predicate ?r ?l), battery-level (numeric 0-100)

Output:
{
  "actions": [
    {
      "name": "move",
      "actor": "robot",
      "parameters": [
        {"name": "?r", "type": "robot"},
        {"name": "?from", "type": "location"},
        {"name": "?to", "type": "location"}
      ],
      "preconditions": [
        {"attribute": "robot-at", "condition": "(?r ?from) = true"},
        {"attribute": "battery-level", "condition": "> 0"}
      ],
      "effects": [
        {"attribute": "robot-at", "change": "delete (?r ?from)"},
        {"attribute": "robot-at", "change": "add (?r ?to)"},
        {"attribute": "battery-level", "change": "decrease by 1"}
      ],
      "description": "Move robot from one location to another, consuming battery"
    }
  ]
}

Example 2 - Pickup and drop (implied pair):
Domain: "Robot picks up package at location. Can carry one at a time."
Types: robot, package, location
Attributes: robot-at, package-at, carrying-package, robot-empty

Output:
{
  "actions": [
    {
      "name": "pickup",
      "actor": "robot",
      "parameters": [
        {"name": "?r", "type": "robot"},
        {"name": "?p", "type": "package"},
        {"name": "?loc", "type": "location"}
      ],
      "preconditions": [
        {"attribute": "robot-at", "condition": "(?r ?loc) = true"},
        {"attribute": "package-at", "condition": "(?p ?loc) = true"},
        {"attribute": "robot-empty", "condition": "(?r) = true"}
      ],
      "effects": [
        {"attribute": "carrying-package", "change": "add (?r ?p)"},
        {"attribute": "package-at", "change": "delete (?p ?loc)"},
        {"attribute": "robot-empty", "change": "delete (?r)"}
      ],
      "description": "Robot picks up a package from the current location"
    },
    {
      "name": "drop",
      "actor": "robot",
      "parameters": [
        {"name": "?r", "type": "robot"},
        {"name": "?p", "type": "package"},
        {"name": "?loc", "type": "location"}
      ],
      "preconditions": [
        {"attribute": "robot-at", "condition": "(?r ?loc) = true"},
        {"attribute": "carrying-package", "condition": "(?r ?p) = true"}
      ],
      "effects": [
        {"attribute": "carrying-package", "change": "delete (?r ?p)"},
        {"attribute": "package-at", "change": "add (?p ?loc)"},
        {"attribute": "robot-empty", "change": "add (?r)"}
      ],
      "description": "Robot drops a carried package at the current location"
    }
  ]
}

Example 3 - Blocksworld stack/unstack:
Domain: "Stack block A on block B. A must be held, B must be clear."
Types: block, robot-arm
Attributes: held-by-arm, on-block, on-table, clear, arm-empty

Output:
{
  "actions": [
    {
      "name": "stack",
      "actor": "robot-arm",
      "parameters": [
        {"name": "?arm", "type": "robot-arm"},
        {"name": "?b1", "type": "block"},
        {"name": "?b2", "type": "block"}
      ],
      "preconditions": [
        {"attribute": "held-by-arm", "condition": "(?b1 ?arm) = true"},
        {"attribute": "clear", "condition": "(?b2) = true"}
      ],
      "effects": [
        {"attribute": "held-by-arm", "change": "delete (?b1 ?arm)"},
        {"attribute": "on-block", "change": "add (?b1 ?b2)"},
        {"attribute": "clear", "change": "delete (?b2)"},
        {"attribute": "clear", "change": "add (?b1)"},
        {"attribute": "arm-empty", "change": "add (?arm)"}
      ],
      "description": "Stack a held block on top of another clear block"
    },
    {
      "name": "unstack",
      "actor": "robot-arm",
      "parameters": [
        {"name": "?arm", "type": "robot-arm"},
        {"name": "?b1", "type": "block"},
        {"name": "?b2", "type": "block"}
      ],
      "preconditions": [
        {"attribute": "on-block", "condition": "(?b1 ?b2) = true"},
        {"attribute": "clear", "condition": "(?b1) = true"},
        {"attribute": "arm-empty", "condition": "(?arm) = true"}
      ],
      "effects": [
        {"attribute": "on-block", "change": "delete (?b1 ?b2)"},
        {"attribute": "held-by-arm", "change": "add (?b1 ?arm)"},
        {"attribute": "clear", "change": "add (?b2)"},
        {"attribute": "clear", "change": "delete (?b1)"},
        {"attribute": "arm-empty", "change": "delete (?arm)"}
      ],
      "description": "Unstack a block from another and hold it"
    }
  ]
}

---

NOW EXTRACT ACTIONS FROM:

Domain Description:
{{domain_description}}

Types (JSON):
{{object_types}}

Attributes (JSON):
{{object_attributes}}

Return ONLY valid JSON with all actions, including implied inverse actions where appropriate.

"#
}