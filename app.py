import gradio as gr
import json
from baml_client.sync_client import b

# --- FUNZIONI DI SUPPORTO ---

def get_model_suffix(model_name):
    """Restituisce il suffisso corretto per le funzioni BAML in base alla selezione."""
    if model_name == "Azure OpenAI": return "Azure"
    if model_name == "Google Gemini": return "Gemini"
    if model_name == "DeepSeek": return "Deep"
    return "Azure"

# --- LOGICA DEL DOMINIO ---

def step1_extract_types(domain_desc, model_name):
    suffix = get_model_suffix(model_name)
    func = getattr(b, f"ExtractObjectTypes{suffix}")
    
    try:
        res = func(domain_desc)
        output_dict = {
            "types": [{"name": t.name, "parent_type": t.parent_type, "description": t.description} for t in res.types]
        }
        return json.dumps(output_dict, indent=2), ""
    except Exception as e:
        return f"Error: {str(e)}", ""

def refine_types(current_json, feedback, model_name):
    if not feedback.strip(): return current_json
    suffix = get_model_suffix(model_name)
    func = getattr(b, f"ExtractObjectTypes{suffix}")
    
    prompt = f"""Current object types and hierarchies:\n{current_json}\n\nUser feedback:\n{feedback}\n\nUpdate the object types based on feedback. Maintain JSON structure."""
    try:
        res = func(prompt)
        output_dict = {"types": [{"name": t.name, "parent_type": t.parent_type, "description": t.description} for t in res.types]}
        return json.dumps(output_dict, indent=2)
    except Exception as e:
        return f"Error refining: {str(e)}"

def step2_extract_attributes(types_json, domain_desc, model_name):
    suffix = get_model_suffix(model_name)
    func = getattr(b, f"ExtractAttributes{suffix}")
    
    try:
        res = func(types_json, domain_desc)
        output_dict = {
            "types_with_attributes": [
                {
                    "type_name": t.type_name,
                    "attributes": [{"name": a.name, "type": a.type, "description": a.description} for a in t.attributes]
                } for t in res.types_with_attributes
            ]
        }
        return json.dumps(output_dict, indent=2), ""
    except Exception as e:
        return f"Error: {str(e)}", ""

def step3_extract_actions(types_json, attr_json, domain_desc, model_name):
    suffix = get_model_suffix(model_name)
    try:
        func = getattr(b, f"ExtractActions{suffix}")
        res = func(domain_description=domain_desc, object_types=types_json, object_attributes=attr_json)
        
        actions_list = []
        for action in res.actions:
            actions_list.append({
                "name": action.name,
                "actor": action.actor,
                "parameters": [{"name": p.name, "type": p.type} for p in action.parameters],
                "preconditions": [{"attribute": p.attribute, "condition": p.condition} for p in action.preconditions],
                "effects": [{"attribute": e.attribute, "change": e.change} for e in action.effects],
                "description": action.description
            })
            
        return json.dumps({"actions": actions_list}, indent=2), ""
    except Exception as e:
        return f"Error: {str(e)}", ""

# --- NUOVA FUNZIONE: Solo Refine Actions ---
def step4_refine_actions(domain_desc, types_json, attr_json, actions_json, model_name):
    suffix = get_model_suffix(model_name)
    try:
        refine_func = getattr(b, f"RefineAndAggregateDomain{suffix}")
        refined_res = refine_func(domain_description=domain_desc, object_types=types_json, attributes=attr_json, actions_list=actions_json)
        
        refined_actions_dict = {
            "actions": [
                {
                    "name": a.name, "actor": a.actor, 
                    "parameters": [{"name": p.name, "type": p.type} for p in a.parameters],
                    "preconditions": [{"attribute": p.attribute, "condition": p.condition} for p in a.preconditions],
                    "effects": [{"attribute": e.attribute, "change": e.change} for e in a.effects],
                    "description": a.description, "adl": a.requires_adl
                } for a in refined_res.actions
            ]
        }
        return json.dumps(refined_actions_dict, indent=2)
    except Exception as e:
        return f"Error: {str(e)}"

# --- NUOVA FUNZIONE: Solo Generazione PDDL ---
def step5_generate_pddl(domain_desc, types_json, attr_json, refined_actions_json, model_name):
    suffix = get_model_suffix(model_name)
    try:
        pddl_func = getattr(b, f"GeneratePDDLDomain{suffix}")
        pddl_res = pddl_func(domain_description=domain_desc, object_nl=types_json, attributes_nl=attr_json, actions_nl=refined_actions_json)
        return pddl_res.pddl_code
    except Exception as e:
        return f"Error generating PDDL: {str(e)}"

# --- LOGICA DEL PROBLEMA ---

def step_prob_objects(prob_desc, domain_desc, types_json, model_name):
    suffix = get_model_suffix(model_name)
    func = getattr(b, f"ExtractProblemObjects{suffix}")
    obj_types_wrapper = json.dumps({"objects_text": json.loads(types_json)})
    
    try:
        res = func(problem_description=prob_desc, object_types=obj_types_wrapper, domain_description=domain_desc)
        out = {"objects": [{"name": o.name, "type": o.type, "description": o.description} for o in res.objects]}
        return json.dumps(out, indent=2), ""
    except Exception as e:
        return f"Error: {str(e)}", ""

def step_prob_init(prob_desc, domain_desc, objects_json, attributes_json, model_name):
    suffix = get_model_suffix(model_name)
    func = getattr(b, f"ExtractInitialState{suffix}")
    obj_wrapper = json.dumps({"objects_text": json.loads(objects_json)})
    attr_wrapper = json.dumps({"attributes_text": json.loads(attributes_json)})
    
    try:
        res = func(problem_description=prob_desc, problem_objects=obj_wrapper, object_attributes=attr_wrapper, domain_description=domain_desc)
        out = {
            "facts": [{"object_name": f.object_name, "attribute": f.attribute, "value": f.value} for f in res.facts],
            "relations": [{"relation_type": r.relation_type, "object1": r.object1, "object2": r.object2} for r in res.relations]
        }
        return json.dumps(out, indent=2), ""
    except Exception as e:
        return f"Error: {str(e)}", ""

def step_prob_goal(prob_desc, domain_desc, objects_json, init_json, model_name):
    suffix = get_model_suffix(model_name)
    func = getattr(b, f"ExtractGoal{suffix}")
    try:
        res = func(problem_description=prob_desc, problem_objects=objects_json, initial_state=init_json, domain_description=domain_desc)
        out = {
            "goal_summary": res.goal_summary,
            "conditions": [{"object_name": c.object_name, "attribute": c.attribute, "required_value": c.required_value} for c in res.conditions],
            "relations": [{"relation_type": r.relation_type, "object1": r.object1, "object2": r.object2} for r in res.relations]
        }
        return json.dumps(out, indent=2), ""
    except Exception as e:
        return f"Error: {str(e)}", ""

def step_prob_pddl(prob_desc, objects_json, init_json, goal_json, domain_pddl, model_name):
    suffix = get_model_suffix(model_name)
    func = getattr(b, f"GeneratePDDLProblem{suffix}")
    obj_w = json.dumps({"objects_text": json.loads(objects_json)})
    init_w = json.dumps({"init_text": json.loads(init_json)})
    goal_w = json.dumps({"goal_text": json.loads(goal_json)})
    
    try:
        res = func(problem_description=prob_desc, objects_baml=obj_w, init_state_baml=init_w, goal_state_baml=goal_w, domain_pddl_code=domain_pddl)
        return res.pddl_code
    except Exception as e:
        return f"Error: {str(e)}"

# --- INTERFACCIA GRADIO ---

with gr.Blocks(title="BAML PDDL Generator") as app:
    gr.Markdown("# 🤖 BAML PDDL Generator Studio")
    
    with gr.Row():
        model_selector = gr.Dropdown(
            choices=["Azure OpenAI", "Google Gemini", "DeepSeek"], 
            value="Azure OpenAI", 
            label="Select AI Model"
        )

    with gr.Tabs():
        # --- TAB DOMINIO ---
        with gr.TabItem("1. Domain Generation"):
            domain_desc_input = gr.Textbox(lines=5, label="Domain Description", placeholder="Describe your domain (e.g., Gold mining robot...)")
            
            with gr.Accordion("Step A: Object Types", open=True):
                btn_types = gr.Button("Extract Types")
                types_json = gr.Code(language="json", label="Extracted Types", interactive=True)
                types_feedback = gr.Textbox(label="Feedback for Types")
                btn_types_refine = gr.Button("Refine Types")
            
            with gr.Accordion("Step B: Attributes (Predicates)", open=False):
                btn_attrs = gr.Button("Extract Attributes")
                attrs_json = gr.Code(language="json", label="Extracted Attributes", interactive=True)
                attrs_feedback = gr.Textbox(label="Feedback for Attributes")
                
            with gr.Accordion("Step C: Actions (Initial Extraction)", open=False):
                btn_actions = gr.Button("Extract Actions")
                actions_json = gr.Code(language="json", label="Extracted Actions", interactive=True)
                actions_feedback = gr.Textbox(label="Feedback for Actions")
            
            # --- MODIFICA: Step D separato ---
            with gr.Accordion("Step D: Refine Actions (Consolidate)", open=False):
                gr.Markdown("This step consolidates actions and checks for consistency before PDDL generation.")
                btn_refine = gr.Button("Refine Actions")
                refined_actions_json = gr.Code(language="json", label="Refined Actions (Ready for PDDL)", interactive=True)

            # --- MODIFICA: Step E separato ---
            with gr.Accordion("Step E: Final PDDL Domain", open=False):
                btn_domain_pddl = gr.Button("Generate PDDL Domain Code", variant="primary")
                domain_pddl_output = gr.Code(label="PDDL Domain Code", interactive=True)

            # Eventi Dominio
            btn_types.click(step1_extract_types, inputs=[domain_desc_input, model_selector], outputs=[types_json, types_feedback])
            btn_types_refine.click(refine_types, inputs=[types_json, types_feedback, model_selector], outputs=types_json)
            
            btn_attrs.click(step2_extract_attributes, inputs=[types_json, domain_desc_input, model_selector], outputs=[attrs_json, attrs_feedback])
            
            btn_actions.click(step3_extract_actions, inputs=[types_json, attrs_json, domain_desc_input, model_selector], outputs=[actions_json, actions_feedback])
            
            # Click su "Refine Actions" -> Output nel JSON raffinato
            btn_refine.click(step4_refine_actions, 
                             inputs=[domain_desc_input, types_json, attrs_json, actions_json, model_selector],
                             outputs=refined_actions_json)

            # Click su "Generate PDDL" -> Prende il JSON raffinato come input
            btn_domain_pddl.click(step5_generate_pddl, 
                                  inputs=[domain_desc_input, types_json, attrs_json, refined_actions_json, model_selector], 
                                  outputs=domain_pddl_output)

        # --- TAB PROBLEMA ---
        with gr.TabItem("2. Problem Generation"):
            gr.Markdown("Ensure you have generated the Domain PDDL in the previous tab first.")
            prob_desc_input = gr.Textbox(lines=5, label="Problem Description", placeholder="Describe the specific problem instance...")
            
            with gr.Accordion("Step A: Objects", open=False):
                btn_prob_objs = gr.Button("Extract Objects")
                prob_objs_json = gr.Code(language="json", label="Problem Objects", interactive=True)
            
            with gr.Accordion("Step B: Initial State", open=False):
                btn_prob_init = gr.Button("Extract Initial State")
                prob_init_json = gr.Code(language="json", label="Initial State", interactive=True)
                
            with gr.Accordion("Step C: Goal", open=False):
                btn_prob_goal = gr.Button("Extract Goal")
                prob_goal_json = gr.Code(language="json", label="Goal", interactive=True)
                
            with gr.Accordion("Step D: Final PDDL Problem", open=False):
                btn_prob_pddl = gr.Button("Generate PDDL Problem", variant="primary")
                prob_pddl_output = gr.Code(label="PDDL Problem Code")

            # Eventi Problema
            btn_prob_objs.click(step_prob_objects, 
                                inputs=[prob_desc_input, domain_desc_input, types_json, model_selector], 
                                outputs=[prob_objs_json, types_feedback])
            
            btn_prob_init.click(step_prob_init,
                                inputs=[prob_desc_input, domain_desc_input, prob_objs_json, attrs_json, model_selector],
                                outputs=[prob_init_json, types_feedback])
            
            btn_prob_goal.click(step_prob_goal,
                                inputs=[prob_desc_input, domain_desc_input, prob_objs_json, prob_init_json, model_selector],
                                outputs=[prob_goal_json, types_feedback])
            
            btn_prob_pddl.click(step_prob_pddl,
                                inputs=[prob_desc_input, prob_objs_json, prob_init_json, prob_goal_json, domain_pddl_output, model_selector],
                                outputs=prob_pddl_output)

if __name__ == "__main__":
    app.launch()