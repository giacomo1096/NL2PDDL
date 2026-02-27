
// Funzione per estrarre lo stato iniziale
function ExtractInitialStateDeep(
    problem_description: string,
    problem_objects: string,
    object_attributes: string,
    domain_description: string
) -> InitialStateResult {
    client "CustomDeepSeekCoder"
    prompt #"
You are an expert in formalizing initial states in planning problems (PDDL-like).

TASK:
Given a problem described in natural language, with its objects, attributes, and domain description,
extract the **initial state** composed of:
1. **Facts** – initial attribute values ​​or fluents for each object.
2. **Relations** – binary or n-ary relations that are true at the initial time (e.g., at, in, connected, holding).

---

### EXAMPLES

**Example 1**
Problem Context:
"An airplane A1 is in Rome. Its fuel level is 50. Passenger P1 is not on board.

Problem Objects:
A1 (plane), Rome (city), P1 (person)

Domain Attributes:
(fuel-level ?a), (on-board ?p), (at ?o ?l)

Expected Output:
{
"facts": [
{"object_name": "A1", "attribute": "fuel-level", "value": "50", "explanation": "The text explicitly indicates the fuel level."},
{"object_name": "P1", "attribute": "on-board", "value": "false", "explanation": "The passenger is not on board."}
],
"relations": [
{"relation_type": "at", "object1": "A1", "object2": "Rome", "explanation": "The plane is located in Rome at the start."},
{"relation_type": "at", "object1": "P1", "object2": "Rome", "explanation": "The passenger is initially in the same city."}
]
}

---

**Example 2**
Problem Context:
"Robot R1 is in room S1. The room is clean. The robot's battery is charged."

Problem Objects:
R1 (robot), S1 (room)

Domain Attributes:
(battery-charged ?r), (is-clean ?s), (in ?o ?l)

Expected Output:
{
"facts": [
{"object_name": "R1", "attribute": "battery-charged", "value": "true", "explanation": "The battery is described as charged."},
{"object_name": "S1", "attribute": "is-clean", "value": "true", "explanation": "The room is clean at the start."}
],
"relations": [
{"relation_type": "in", "object1": "R1", "object2": "S1", "explanation": "The robot is inside room S1 initially."}
]
}

---

###  DETAILED INSTRUCTIONS

1. Extract **all initial facts** mentioned or clearly implied in the problem.
- If an attribute is numeric (e.g., fuel level, energy), specify the initial value.
- If it is Boolean (e.g., loaded, clean, available), use `true` or `false`.
2. Extract **all relationships** between objects.
- `at(X,Y)` if an object is in a location.
- `holding(X,Y)` if an agent owns something.
- `connected(X,Y)` if two locations are connected.
3. If the text doesn't specify a value but clearly implies one, write a plausible value and explain it in the `explanation`.
4. If an attribute isn't mentioned, **do not invent** superfluous facts or relationships.
5. The initial state must be **consistent and minimal**.
6. The output must contain **only** the JSON, **no additional text or markdown**.

---

### 🔹 INPUT

Problem Description:
---
{{ problem_description }}
---

Problem Objects:
{{ problem_objects }}

Object Attributes:
{{ object_attributes }}

Domain Description:
{{ domain_description }}

---

### OUTPUT FORMAT (required)
{ 
"facts": [ 
{ 
"object_name": "robby", 
"attribute": "location", 
"value": "wp1", 
"explanation": "The text says that Robby is in wp1." 
}, 
{ 
"object_name": "robby", 
"attribute": "loaded", 
"value": "false", 
"explanation": "Robby starts unloaded since he hasn't picked up the package yet." 
},
{
"object_name": "med1",
"attribute": "location",
"value": "wp1",
"explanation": "The medicine is located in wp1 at the beginning."
}
],
"relations": [
{
"relation_type": "at",
"object1": "robby",
"object2": "wp1",
"explanation": "Robby is initially at wp1."
},
{
"relation_type": "at",
"object1": "alice",
"object2": "wp2",
"explanation": "Alice is initially at wp2."
},
{
"relation_type": "available_at",
"object1": "med1",
"object2": "wp1",
"explanation": "The medicine is available at the initial wp1."
}
]
}
"#
}