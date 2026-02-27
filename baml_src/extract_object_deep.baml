
// Funzione per estrarre gli oggetti dal problema
function ExtractProblemObjectsDeep(
    problem_description: string,
    object_types: string,
    domain_description: string
) -> ObjectsResult {
    client "CustomDeepSeekCoder"
    prompt #"
You are an expert at identifying objects/instances for planning problems (PDDL style).

Task: Given the problem description text (`{{ problem_description }}`), the list of object types available in the domain (`{{ object_types }}`), and the domain description (`{{ domain_description }}`), extract **all** instances (objects) mentioned in the problem. For each object, provide: `name`, `type` (one of the domain types), and a very short `description` explaining the instance's role in the problem.

IMPORTANT RULES
1. Extract **EVERY** object explicitly mentioned in the problem (agents, items, locations, waypoints, etc.).
2. Match each object to the correct **type** among those in `{{ object_types }}`. Use the domain context (`{{ domain_description }}`) to resolve ambiguities.
3. If the problem uses names that clearly indicate the type (e.g., "Robby" for robot, "Pkg1" for package), map them directly.
4. If a name is ambiguous but the domain suggests the type, choose the most consistent type and explain it briefly in the `description`.
5. Also include objects that are locations (room, waypoint, city, depot) and resources (medicine, battery station) if mentioned.
6. Do not add objects not present in the problem text (no invented ones) unless they are **explicitly implied** and necessary: ​​in that case, include them only if strictly justified in the `description`.
7. `name` must be the exact token as it appears in the problem (case sensitive if used).
8. `description` must be short (1 sentence) and indicate the object's role in the problem.
9. **Output**: Return ONLY the JSON object that begins with `{` and ends with `}`, following the pattern shown exactly. NO additional text, NO markdown.

EXAMPLES (INPUT → OUTPUT)

Example 1:
Domain Types: airplane, person, city
Domain Description: (domain flight)
Problem Description: "A plane A1, of type airplane, is at the Rome airport. A passenger P1 is on board."

Expected JSON:
{ 
"objects": [ 
{"name": "A1", "type": "airplane", "description": "The aircraft involved in the problem."}, 
{"name": "Rome", "type": "city", "description": "Aircraft departure city."}, 
{"name": "P1", "type": "person", "description": "Passenger on board the plane."} 
]
}

Example 2:
Domain Types: robot, package, room
Domain Description: (delivery domain)
Problem Description: "The robot Robby is in RoomA. Must take Pkg1 and bring it to RoomB."

Expected JSON:
{
"objects": [
{"name": "Robby", "type": "robot", "description": "Agent that should perform the actions."},
{"name": "Pkg1", "type": "package", "description": "Package to be delivered."},
{"name": "RoomA", "type": "room", "description": "Robot's starting position."},
{"name": "RoomB", "type": "room", "description": "Destination of the package."}
]
}

NOW PROCESS ON THE PROVIDED INPUT:

Domain Object Types:
{{ object_types }}

Domain Description:
{{ domain_description }}

Problem Description:
---
{{ problem_description }}
---

REMEMBER: Return ONLY the JSON in this exact format:

{
"objects": [
{
"name": "instance_name",
"type": "domain_type",
"description": "brief description of the instance's role in the problem"
}
]
}
"#
}