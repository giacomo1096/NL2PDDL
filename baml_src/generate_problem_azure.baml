
// Function to generate the PDDL problem file
function GeneratePDDLProblemAzure(
  problem_description: string, // "Un problema per impilare tre blocchi..."
  domain_pddl_code: string,         // "blocksworld" (deve corrispondere al dominio)
  objects_baml: string,        // "a, b, c - block. r1 - robotarm"
  init_state_baml: string,     // "(on-table a) (clear a) (on-table b) (clear b) (arm-empty)..."
  goal_state_baml: string      // "(on a b) (on b c)"
) -> PDDLProblemResult {
  client "CustomAzure"
  prompt #"
You are an expert PDDL (Planning Domain Definition Language) problem engineer.

TASK:
Given a natural language description of a problem (objects, init, goal) and the
**complete PDDL domain code** it belongs to, generate a
**complete and syntactically valid PDDL problem file**.

---

### CONTEXT: DOMAIN PDDL

You must use the following PDDL Domain Code to validate types and predicates.
DO NOT generate this domain; use it as context.

{{ domain_pddl_code }}

---

### EXAMPLE

**Example 1: Blocksworld Problem**

Input Context:
(Domain PDDL is the one provided above, starting with '(define (domain blocksworld) ...')
Problem Description: "A simple task to stack three blocks in order."
Objects NL: "We have three blocks: b1, b2, and b3. We also have one robot arm, arm1."
Init State NL: "All three blocks (b1, b2, b3) are on the table. All blocks are clear. The robot arm is empty."
Goal State NL: "The goal is to have b1 on b2, and b2 on b3."

Expected Output:
{
  "problem_name": "stack-three-blocks",
  "domain_name": "blocksworld",
  "pddl_code": "(define (problem stack-three-blocks)\n  (:domain blocksworld)\n\n  (:objects\n    b1 b2 b3 - block\n    arm1 - robotarm\n  )\n\n  (:init\n    (on-table b1)\n    (on-table b2)\n    (on-table b3)\n    (clear b1)\n    (clear b2)\n    (clear b3)\n    (arm-empty)\n  )\n\n  (:goal\n    (and\n      (on b1 b2)\n      (on b2 b3)\n    )\n  )\n)",
  "explanation": "Generated a problem for the 'blocksworld' domain with three blocks, starting from the table and aiming for a 3-stack."
}

---

### DETAILED INSTRUCTIONS

1.  **Extract Domain Name (CRITICAL)**: Look at the `domain_pddl_code` input. Find the line `(define (domain ...))` and extract the exact `domain_name` (e.g., 'blocksworld').
2.  **Problem Name**: Infer a suitable, single-word problem name from the `problem_description` (e.g., 'task1', 'problem-stacking').
3.  **Domain Reference**: The problem definition *must* start with `(define (problem <problem_name>)` and *must* include `(:domain <domain_name>)`, where `<domain_name>` is the name you extracted in step 1.
4.  **Objects**:
    * Parse the `objects_nl` string to create the `(:objects ...)` section.
    * You **must** assign a type to every object (e.g., `b1 b2 - block`).
    * The types you use (e.g., `block`, `robotarm`) **must** be types defined in the `(:types ...)` section of the provided `domain_pddl_code`.
5.  **Init State**:
    * Translate the `init_state_nl` string into the `(:init ...)` section.
    * Each statement (e.g., `(on-table b1)`, `(arm-empty)`) **must** use a predicate that is defined in the `(:predicates ...)` section of the `domain_pddl_code`.
    * Pay close attention to arity (e.g., `(on-table b1)` vs `(on b1 b2)`).
6.  **Goal State**:
    * Translate the `goal_state_nl` string into the `(:goal (and ...))` section.
    * These predicates must also match the predicates defined in the `domain_pddl_code`.
7.  **Validity**: The generated PDDL code must be complete and syntactically correct, with balanced parentheses.
8.  **Output**: The output must be **only** the JSON object matching `PDDLProblemResult`. NO additional text or markdown.

---

### INPUT

Problem Description:
---
{{ problem_description }}
---

Objects NL:
{{ objects_baml }}

Init State NL:
{{ init_state_baml }}

Goal State NL:
{{ goal_state_baml }}

---

### OUTPUT FORMAT (required)
{
  "problem_name": "nome-del-problema",
  "domain_name": "nome-del-dominio-estratto",
  "pddl_code": "(define (problem nome-del-problema)\n  (:domain nome-del-dominio-estratto)\n\n  (:objects\n    ...\n  )\n\n  (:init\n    ...\n  )\n\n  (:goal\n    (and ...)\n  )\n)",
  "explanation": "Una breve spiegazione di ciò che è stato generato o di eventuali assunzioni fatte."
}

"#
}