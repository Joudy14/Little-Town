// --- Keep Appearance & Depth at the top ---
depth = -y;

// ==========================================
// UNIFIED INTERACTION LOGIC
// ==========================================
if (distance_to_object(obj_player) < 50) {
    
    // 1. SPACE BAR: STEP THROUGH DIALOGUE
    if (keyboard_check_pressed(vk_space)) {
        
        // Clear old box
        if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);

        var _text = "";
        
        if (npc_state == 0)      { _text = myText; npc_state = 1; }
        else if (npc_state == 1) { _text = "1. Give item   2. Go look"; npc_state = 2; }
        else if (npc_state == 4) { _text = itemTextDone; npc_state = 5; }
        else if (npc_state == 5) { npc_state = 4; }

        if (_text != "") {
            var _inst = instance_create_depth(x, y - 300, -10000, obj_textbox);
            _inst.textToShow = _text; 
        }
    }

    // 2. ITEM SELECTION (1 to Open, 2 to Cancel)
    if (npc_state == 2) {
        if (keyboard_check_pressed(ord("1"))) {
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
            
            global.inventory_open = true; // FREEZE
            npc_state = 3; 
            
            var _inst = instance_create_depth(x, y - 300, -10000, obj_textbox);
            _inst.textToShow = "You want to know my opinion? (Press V)";
        }
        
        if (keyboard_check_pressed(ord("2"))) {
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
            global.inventory_open = false; // UNFREEZE
            npc_state = 0; 
        }
    }

    // 3. V KEY VALIDATION (The "Unfreeze" Zone)
    if (keyboard_check_pressed(ord("V")) && npc_state == 3) {
        
        // --- FORCED UNFREEZE ---
        global.inventory_open = false; 
        global.selected_index = 0;
        
        if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);

        if (array_length(global.inventory) > 0) {
            var _selected_item_name = global.inventory[global.selected_index];

            if (_selected_item_name == desired_item) {
                global.score += 10; 
                array_delete(global.inventory, global.selected_index, 1);
                npc_state = 4; 
                myState = npcState.done; 
            } else {
                global.score -= 5;
                npc_state = 0; 
            }
        } else {
            npc_state = 0;
        }
    }
} else {
    // 4. DISTANCE SAFETY (If you walk away somehow)
    if (npc_state == 3) {
        global.inventory_open = false;
        npc_state = 0;
        if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
    }
}