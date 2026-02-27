// Funzione per estrarre gli attributi dai tipi di oggetti
function ExtractAttributesDeep(object_types: string, domain_description: string) -> AttributesResult {
    client "CustomDeepSeekCoder"
    prompt #"
You are an expert in PDDL predicate and fluent extraction from natural language.

TASK: Extract boolean predicates and numeric fluents for each type, following strict PDDL semantics.

CRITICAL RULES FOR PREDICATES:
1. Each predicate argument MUST have EXACTLY ONE type
2. NEVER use union types like (?x - (block | table)) - THIS IS FORBIDDEN
3. If a concept applies to multiple type combinations, create SEPARATE predicates:
   - (on-table ?b - block) for blocks on table
   - (on-block ?b1 - block ?b2 - block) for blocks on blocks
4. Predicate names should be globally unique OR have different signatures
5. Use descriptive names that clarify the relationship
6. In description, specify full signature: "Predicate: (name ?param1 - type1 ?param2 - type2)"

CRITICAL RULES FOR FLUENTS (numeric):
7. Extract fluents ONLY if explicitly mentioned or strongly implied
8. Specify units and reasonable ranges in description
9. Use hyphens in multi-word names: "battery-level", not "batteryLevel"

NAMING CONVENTIONS:
- Use lowercase with hyphens: "is-loaded", "at-location"
- Avoid ambiguity: prefer "holding-package" over just "holding"
- For binary relations, make direction clear: "robot-at-location" vs "package-at-location"

VALIDATION:
- No attribute name should be repeated with different types across the domain
- Every predicate MUST specify which types it applies to
- Numeric fluents should have plausible ranges

EXAMPLES:

Example 1 - Logistics domain (relationships):
Types: robot, package, location
Description: "Robots transport packages between locations. Robots have battery (0-100). Packages have weight."

Output:
{
  "types_with_attributes": [
    {
      "type_name": "robot",
      "attributes": [
        {"name": "robot-at", "type": "boolean", "description": "Predicate: (robot-at ?r - robot ?l - location)"},
        {"name": "battery-level", "type": "numeric", "description": "Battery charge percentage (0-100)"},
        {"name": "carrying-package", "type": "boolean", "description": "Predicate: (carrying-package ?r - robot ?p - package)"}
      ]
    },
    {
      "type_name": "package",
      "attributes": [
        {"name": "package-at", "type": "boolean", "description": "Predicate: (package-at ?p - package ?l - location)"},
        {"name": "weight", "type": "numeric", "description": "Weight in kilograms (0-100)"},
        {"name": "delivered", "type": "boolean", "description": "True if package reached destination"}
      ]
    },
    {
      "type_name": "location",
      "attributes": [
        {"name": "is-depot", "type": "boolean", "description": "True if location is a distribution depot"}
      ]
    }
  ]
}

Example 2 - Blocksworld (NO hybrid types):
Types: block, table, robot-arm
Description: "Blocks can be on table or on other blocks. Arm picks/puts blocks."

Output:
{
  "types_with_attributes": [
    {
      "type_name": "block",
      "attributes": [
        {"name": "on-table", "type": "boolean", "description": "Predicate: (on-table ?b - block)"},
        {"name": "on-block", "type": "boolean", "description": "Predicate: (on-block ?b1 - block ?b2 - block)"},
        {"name": "clear", "type": "boolean", "description": "True if nothing is on top of this block"},
        {"name": "held-by-arm", "type": "boolean", "description": "Predicate: (held-by-arm ?b - block ?a - robot-arm)"}
      ]
    },
    {
      "type_name": "table",
      "attributes": []
    },
    {
      "type_name": "robot-arm",
      "attributes": [
        {"name": "arm-empty", "type": "boolean", "description": "True if arm is not holding anything"}
      ]
    }
  ]
}

Example 3 - Rover domain (numeric + boolean):
Types: rover, location, sample, camera
Description: "Rovers navigate locations, collect samples (with mass), and take images. Rovers have fuel."

Output:
{
  "types_with_attributes": [
    {
      "type_name": "rover",
      "attributes": [
        {"name": "rover-at", "type": "boolean", "description": "Predicate: (rover-at ?r - rover ?l - location)"},
        {"name": "fuel", "type": "numeric", "description": "Remaining fuel in liters (0-1000)"},
        {"name": "has-sample", "type": "boolean", "description": "Predicate: (has-sample ?r - rover ?s - sample)"},
        {"name": "equipped-with-camera", "type": "boolean", "description": "Predicate: (equipped-with-camera ?r - rover ?c - camera)"}
      ]
    },
    {
      "type_name": "location",
      "attributes": [
        {"name": "visited", "type": "boolean", "description": "True if any rover has been to this location"}
      ]
    },
    {
      "type_name": "sample",
      "attributes": [
        {"name": "sample-at", "type": "boolean", "description": "Predicate: (sample-at ?s - sample ?l - location)"},
        {"name": "mass", "type": "numeric", "description": "Sample mass in grams (1-1000)"},
        {"name": "analyzed", "type": "boolean", "description": "True if sample has been analyzed"}
      ]
    },
    {
      "type_name": "camera",
      "attributes": [
        {"name": "calibrated", "type": "boolean", "description": "True if camera is ready to use"}
      ]
    }
  ]
}

Example 4 - Error case to AVOID:
❌ WRONG:
{"name": "on", "type": "boolean", "description": "Predicate: (on ?x - (block | table))"}

✓ CORRECT:
{"name": "on-table", "type": "boolean", "description": "Predicate: (on-table ?b - block)"}
{"name": "on-block", "type": "boolean", "description": "Predicate: (on-block ?b1 - block ?b2 - block)"}

---

NOW PROCESS:

Types (JSON):
{{object_types}}

Domain Description:
{{domain_description}}

Return ONLY valid JSON. NO union types. Separate predicates for different type combinations.
"#
}