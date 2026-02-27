// Definisci la classe per un'Azione Raffinata e Aggregata
class RefinedAction {
    name string @description("Nome dell'azione, spesso aggregato (es: 'enter', 'deliver', 'move-safely').")
    description string @description("Descrizione concisa dell'azione raffinata.")
    actor string @description("Tipo di oggetto che esegue l'azione (es: robot, agent)")
    parameters Parameters[] @description("Lista completa dei parametri necessari per l'azione.")
    preconditions Precondition[] @description("Lista di tutte le precondizioni logiche, incluse quelle implicite (es: no ostacoli, porta aperta).")
    effects Effect[] @description("Lista di tutti gli effetti prodotti, aggregati (es: cambia stato, posizione, risorsa).")
    requires_adl string @description("Imposta a true se l'azione usa logica complessa come FORALL/WHEN (che saranno generati nella fase PDDL).")
}

// Definisci la classe principale per i risultati
class RefinedActionsResult {
    actions RefinedAction[] @description("Lista di tutte le azioni semplificate, aggregate e semanticamente raffinate.")
}

// Funzione BAML di Refactoring
function RefineAndAggregateDomainGemini(
    domain_description: string,
    object_types: string,
    attributes: string,
    actions_list: string 
) -> RefinedActionsResult {
    client "CustomGemini"
    prompt #"
You are an expert PDDL domain engineer specializing in semantic inference and action refinement.

CRITICAL TASK RULES:
1. **PRESERVE ALL ACTIONS**: Output count MUST equal or exceed input count. NEVER remove actions.
2. **INFER IMPLICIT CONSTRAINTS**: Add missing preconditions based on domain semantics
3. **COMPLETE EFFECTS**: Ensure all state changes are explicitly listed
4. **CONSISTENT NAMING**: Use EXACT attribute names from the provided attributes

---

INPUTS:

Domain Description:
{{ domain_description }}

Valid Types (JSON):
{{ object_types }}

Valid Attributes/Predicates (JSON):
{{ attributes }}

Actions to Refine (JSON):
{{ actions_list }}

---

REFINEMENT RULES:

A. PRECONDITION INFERENCE:
   - If domain mentions "obstacles", "blocked", "occupied" → add clearance checks
   - If domain mentions "capacity", "limit", "full" → add resource constraints
   - If action modifies object state → check current state first
   - If action needs empty/available resource → add availability check
   - If locations/positions matter → add location preconditions

B. EFFECT COMPLETENESS:
   - For movement: delete old location, add new location
   - For pickup: change holder, remove from previous location
   - For resource consumption: decrease/increase numeric fluents
   - For state changes: add new state, delete old state

C. ADL DETECTION:
   Set requires_adl = "true" if:
   - Action affects ALL objects of a type (e.g., "unload all packages")
   - Effects depend on conditions (e.g., "damage if collision")
   - Quantifiers needed (forall, exists)
   Otherwise: requires_adl = "false"

D. PARAMETER FORMAT:
   - Always include ? prefix: "?r", "?from", "?to"
   - Match types exactly from object_types input
   - Include ALL objects involved in the action

E. CONDITION/EFFECT FORMAT:
   Preconditions:
   - Predicates: "(?param1 ?param2) = true" or "(?param) = false"
   - Numeric: "> 0", ">= 5", "< 100", "!= 0"
   
   Effects:
   - Add predicate: "add (?p1 ?p2)"
   - Delete predicate: "delete (?p1 ?p2)"
   - Increase: "increase by 5"
   - Decrease: "decrease by 3"
   - Set: "set to 100"

---

EXAMPLES:

Example 1: Simple movement with inferred clearance
Input Action:
{
  "name": "move",
  "actor": "robot",
  "parameters": [{"name": "?r", "type": "robot"}, {"name": "?from", "type": "location"}, {"name": "?to", "type": "location"}],
  "preconditions": [{"attribute": "at", "condition": "(?r ?from) = true"}],
  "effects": [{"attribute": "at", "change": "delete (?r ?from)"}, {"attribute": "at", "change": "add (?r ?to)"}],
  "description": "Move robot"
}

Domain mentions: "Some locations are blocked by obstacles"

Expected Output:
{
  "name": "move",
  "description": "Move robot from one location to another if destination is clear",
  "actor": "robot",
  "parameters": [
    {"name": "?r", "type": "robot"},
    {"name": "?from", "type": "location"},
    {"name": "?to", "type": "location"}
  ],
  "preconditions": [
    {"attribute": "at", "condition": "(?r ?from) = true"},
    {"attribute": "clear", "condition": "(?to) = true"}
  ],
  "effects": [
    {"attribute": "at", "change": "delete (?r ?from)"},
    {"attribute": "at", "change": "add (?r ?to)"}
  ],
  "requires_adl": "false"
}

---

Example 2: Pickup with implicit preconditions
Input Action:
{
  "name": "pickup",
  "actor": "robot",
  "parameters": [{"name": "?r", "type": "robot"}, {"name": "?p", "type": "package"}],
  "preconditions": [],
  "effects": [{"attribute": "holding", "change": "add (?r ?p)"}],
  "description": "Pick up package"
}

Domain mentions: "Robot can carry one package at a time. Robot and package must be at same location."

Expected Output:
{
  "name": "pickup",
  "description": "Robot picks up a package from the same location if hands are empty",
  "actor": "robot",
  "parameters": [
    {"name": "?r", "type": "robot"},
    {"name": "?p", "type": "package"},
    {"name": "?loc", "type": "location"}
  ],
  "preconditions": [
    {"attribute": "at", "condition": "(?r ?loc) = true"},
    {"attribute": "at", "condition": "(?p ?loc) = true"},
    {"attribute": "hands-empty", "condition": "(?r) = true"}
  ],
  "effects": [
    {"attribute": "holding", "change": "add (?r ?p)"},
    {"attribute": "at", "change": "delete (?p ?loc)"},
    {"attribute": "hands-empty", "change": "delete (?r)"}
  ],
  "requires_adl": "false"
}

---

Example 3: Action with numeric fluent
Input Action:
{
  "name": "drive",
  "actor": "truck",
  "parameters": [{"name": "?t", "type": "truck"}, {"name": "?from", "type": "city"}, {"name": "?to", "type": "city"}],
  "preconditions": [{"attribute": "truck-at", "condition": "(?t ?from) = true"}],
  "effects": [{"attribute": "truck-at", "change": "delete (?t ?from)"}, {"attribute": "truck-at", "change": "add (?t ?to)"}],
  "description": "Drive truck"
}

Domain mentions: "Trucks consume 10 fuel per trip. Fuel ranges 0-100."

Expected Output:
{
  "name": "drive",
  "description": "Drive truck between cities consuming fuel",
  "actor": "truck",
  "parameters": [
    {"name": "?t", "type": "truck"},
    {"name": "?from", "type": "city"},
    {"name": "?to", "type": "city"}
  ],
  "preconditions": [
    {"attribute": "truck-at", "condition": "(?t ?from) = true"},
    {"attribute": "fuel", "condition": ">= 10"}
  ],
  "effects": [
    {"attribute": "truck-at", "change": "delete (?t ?from)"},
    {"attribute": "truck-at", "change": "add (?t ?to)"},
    {"attribute": "fuel", "change": "decrease by 10"}
  ],
  "requires_adl": "false"
}

---

Example 4: ADL action (affects multiple objects)
Input Action:
{
  "name": "unload-all",
  "actor": "truck",
  "parameters": [{"name": "?t", "type": "truck"}, {"name": "?loc", "type": "location"}],
  "preconditions": [{"attribute": "truck-at", "condition": "(?t ?loc) = true"}],
  "effects": [{"attribute": "in-truck", "change": "delete all packages from ?t"}],
  "description": "Unload all packages"
}

Expected Output:
{
  "name": "unload-all",
  "description": "Unload all packages from truck to current location (requires ADL for forall)",
  "actor": "truck",
  "parameters": [
    {"name": "?t", "type": "truck"},
    {"name": "?loc", "type": "location"}
  ],
  "preconditions": [
    {"attribute": "truck-at", "condition": "(?t ?loc) = true"}
  ],
  "effects": [
    {"attribute": "in-truck", "change": "delete (?p ?t) for all ?p"},
    {"attribute": "package-at", "change": "add (?p ?loc) for all ?p in ?t"}
  ],
  "requires_adl": "true"
}

---

VALIDATION CHECKLIST:
☑ Output has AT LEAST as many actions as input (never fewer)
☑ Every parameter has ? prefix and valid type
☑ Every attribute name exists in the attributes input
☑ Preconditions use correct format: "(?p1 ?p2) = true/false" or "> N"
☑ Effects use correct format: "add/delete (?p1 ?p2)" or "increase/decrease by N"
☑ ADL flag is "true" or "false" (string, not boolean)

---

NOW REFINE THE ACTIONS:

Step 1: Count input actions
Step 2: For EACH action, infer missing preconditions from domain semantics
Step 3: Complete all effects
Step 4: Determine if ADL is needed
Step 5: Verify output count >= input count

Return ONLY valid JSON matching the RefinedActionsResult schema:
{
  "actions": [
    {
      "name": "action-name",
      "description": "what it does",
      "actor": "type-name",
      "parameters": [{"name": "?param", "type": "type"}],
      "preconditions": [{"attribute": "pred-name", "condition": "(?p) = true"}],
      "effects": [{"attribute": "pred-name", "change": "add (?p1 ?p2)"}],
      "requires_adl": "false"
    }
  ]
}
"#
}
