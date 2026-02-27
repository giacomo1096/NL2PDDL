// Funzione per estrarre i tipi di oggetti
function ExtractObjectTypesDeep(domain_description: string) -> ObjectTypesResult {
    client "CustomDeepSeekCoder"
    prompt #"
You are an expert in PDDL domain modeling and type extraction.

TASK: Extract ALL object types from the domain description, including their hierarchical relationships.

CRITICAL RULES:
1. Extract EVERY distinct entity type mentioned (nouns representing classes of objects)
2. Identify parent-child relationships (e.g., "truck is a vehicle")
3. If no parent exists, set parent_type to null
4. Use lowercase, hyphenated names (e.g., "delivery-robot", not "DeliveryRobot")
5. Create descriptions that capture the PURPOSE of each type in planning
6. If the description mentions abstract categories (e.g., "vehicles"), extract them even if not explicitly used
7. Handle implicit hierarchies (e.g., "robots and drones" → both could be "agent" subtypes)

VALIDATION CHECKS:
- No cycles in hierarchy (a type cannot be its own ancestor)
- Parent types must be defined or be 'object'
- No duplicate type names
- Names must match regex: ^[a-z][a-z0-9-]*$

EXAMPLES:

Example 1 - Simple flat types:
Input: "There are robots, packages, and locations. Robots move and carry packages."
Output:
{
  "types": [
    {"name": "robot", "parent_type": null, "description": "Mobile agent that transports items"},
    {"name": "package", "parent_type": null, "description": "Object that can be transported"},
    {"name": "location", "parent_type": null, "description": "Physical position in the environment"}
  ]
}

Example 2 - Complex hierarchy:
Input: "Vehicles include trucks and airplanes. Trucks are ground vehicles, airplanes are aerial vehicles. Both transport cargo."
Output:
{
  "types": [
    {"name": "vehicle", "parent_type": null, "description": "General transport entity"},
    {"name": "ground-vehicle", "parent_type": "vehicle", "description": "Vehicle that operates on land"},
    {"name": "aerial-vehicle", "parent_type": "vehicle", "description": "Vehicle that operates in air"},
    {"name": "truck", "parent_type": "ground-vehicle", "description": "Ground vehicle for cargo transport"},
    {"name": "airplane", "parent_type": "aerial-vehicle", "description": "Aerial vehicle for cargo transport"},
    {"name": "cargo", "parent_type": null, "description": "Goods being transported"}
  ]
}

Example 3 - Implicit types:
Input: "Agents navigate a grid world with obstacles. Some cells contain items."
Output:
{
  "types": [
    {"name": "agent", "parent_type": null, "description": "Entity that can navigate and interact"},
    {"name": "cell", "parent_type": null, "description": "Single position in the grid"},
    {"name": "obstacle", "parent_type": null, "description": "Blocking object in the environment"},
    {"name": "item", "parent_type": null, "description": "Object that can be collected or manipulated"}
  ]
}

Example 4 - Domain with roles:
Input: "Players, goalies, and referees are on the field. Players and goalies are team members."
Output:
{
  "types": [
    {"name": "person", "parent_type": null, "description": "Human participant in the game"},
    {"name": "team-member", "parent_type": "person", "description": "Person belonging to a team"},
    {"name": "player", "parent_type": "team-member", "description": "Team member who plays the game"},
    {"name": "goalie", "parent_type": "team-member", "description": "Team member who defends the goal"},
    {"name": "referee", "parent_type": "person", "description": "Official who enforces rules"},
    {"name": "field", "parent_type": null, "description": "Playing area"}
  ]
}

---

NOW PROCESS THIS DOMAIN:

{{domain_description}}

Return ONLY valid JSON matching the schema. No markdown, no explanations.
"#
}