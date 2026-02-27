// Define the class for a goal condition
class GoalCondition {
object_name string @description("Name of the object involved (e.g., med1, alice, robby)")
attribute string @description("Attribute that must be verified (e.g., delivered, location, loaded)")
required_value string @description("Value required to complete the goal (e.g., true, wp2, false)")
explanation string? @description("Explanation of why this condition is required")
}

// Define the class for a goal relationship
class GoalRelation {
relation_type string @description("Type of goal relationship (e.g., at, holding, delivered_to, equals)")
object1 string @description("First object involved")
object2 string @description("Second object involved")
explanation string? @description("Explanation of why this relationship is required in the goal")
}

// Define the main class for the results
class GoalResult {
conditions GoalCondition[] @description("Conditions that must be satisfied to achieve the goal")
relations GoalRelation[] @description("Relationships between objects that must be true in the goal")
goal_summary string @description("Brief and concise description of the overall goal")
}

// Function to extract the goal
function ExtractGoalGemini(
problem_description: string,
problem_objects: string,
initial_state: string,
domain_description: string
) -> GoalResult {
client "CustomGemini"
 prompt #"
You are an expert in formalizing goals in planning problems (PDDL style).

TASK:
Given a problem, the objects involved, and the initial state, extract the **goal state (goal)**.
The goal is the final state that must be Achieved from the initial state.

A goal consists of:
1. **Conditions** – required final values ​​for specific attributes.
2. **Relations** – required final relationships between objects that must be true.

---

### EXAMPLES

**Example 1**
Problem Description: "The objective is for plane A1 to reach Milan, and for its fuel level to be at least 50."
Problem Objects: A1 (plane), Milan (city)
Domain Attributes: (fuel-level ?a), (at ?o ?l)

Expected JSON:
{
"goal_summary": "A1 must be in Milan with sufficient fuel.",
"conditions": [
{"object_name": "A1", "attribute": "fuel-level", "required_value": ">= 50", "explanation": "Fluent constraint."}
],
"relations": [ 
{"relation_type": "at", "object1": "A1", "object2": "Milan", "explanation": "Target location."} 
]
}

**Example 2**
Problem Description: "Robot R1 must be in room S3. Also, room S1 must not be dirty."
Problem Objects: R1 (robot), S3 (room), S1 (room)
Domain Attributes: (is-clean ?s), (at ?o ?l)

Expected JSON:
{ 
"goal_summary": "R1 must move to S3 and S1 must be clean.", 
"conditions": [ 
{"object_name": "S1", "attribute": "is-clean", "required_value": "true", "explanation": "Room S1 must be clean."} 
], 
"relations": [ 
{"relation_type": "at", "object1": "R1", "object2": "S3", "explanation": "Robot must reach target location."} 
]
}

---

### DETAILED INSTRUCTIONS

1. Extract **all explicitly or clearly stated goal conditions and relationships** Implicit.
2. Compare to the initial state: include only what **changes from the initial**.
3. **Conditions** concern final attribute values ​​(boolean, numeric, or location).
4. **Relations** concern relationships between objects (e.g., at, holding, delivered_to).
5. Include everything necessary to consider the problem solved.
6. Be precise and complete, but don't invent non-implicit conditions.
7. Output should be **JSON only**, without additional text or markdown.

---

### INPUT

Problem Description:
---
{{ problem_description }}
---

Problem Objects:
{{ problem_objects }}

Initial State:
{{ initial_state }}

Domain Description:
{{ domain_description }}

---

### OUTPUT FORMAT (required)
{ 
"conditions": [ 
{ 
"object_name": "med1", 
"attribute": "location", 
"required_value": "wp2", 
"explanation": "Medicine must be delivered to the destination location wp2 where alice is." 
}, 
{ 
"object_name": "alice", 
"attribute": "received_medicine", 
"required_value": "true", 
"explanation": "Alice must have received the medicine to complete the delivery." 
} 
], 
"relations": [ 
{ 
"relation_type": "delivered_to", 
"object1": "med1", 
"object2": "alice", 
"explanation": "Medicine must be delivered to alice to satisfy the goal." 
}, 
{ 
"relation_type": "at", 
"object1": "robby", 
"object2": "wp2", 
"explanation": "Robot must be at destination location after delivery." 
} 
], 
"goal_summary": "Deliver medicine med1 to patient alice at location wp2"
}
"#
}