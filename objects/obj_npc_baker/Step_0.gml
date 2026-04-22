// ==========================================
// 1. ANIMATION & DEPTH
// ==========================================
switch myState {
    case npcState.normal:
        if (image_speed > 0 && image_index >= image_number-1) {
            image_speed = 0;
            alarm[0] = irandom_range(loopRange01,loopRange02);
        }
        break;
    case npcState.done:
        if (doneSprite != noone && sprite_index != doneSprite) sprite_index = doneSprite;
        break;
}
depth = -y;

// ==========================================
// 2. INTERACTION LOGIC
// ==========================================
if (distance_to_object(obj_player) < 60) {
    
    // ------------------------------------------
    // PATH A: ALREADY SOLVED
    // ------------------------------------------
    if (myState == npcState.done) {
        if (keyboard_check_pressed(vk_space)) {
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
            
            // Toggle text using state so the prompt doesn't trick it!
            if (npc_state == 0) {
                var _inst = instance_create_depth(x, y - 300, -10000, obj_textbox);
                _inst.textToShow = itemTextDone; 
                npc_state = 9; // State 9 = "Done" text is active
            } else {
                npc_state = 0; 
            }
        }
    } 
    // ------------------------------------------
    // PATH B: STILL NEEDS THE ITEM
    // ------------------------------------------
    else {
        if (keyboard_check_pressed(vk_space)) {
            
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
            
            // THE STATE MACHINE:
            if (npc_state == 1) { npc_state = 8; exit; } 
            if (npc_state == 2) { npc_state = 8; exit; } 
            if (npc_state == 6) { npc_state = 8; exit; } 

            var _text = "";
            if (npc_state == 0)      { _text = myText; npc_state = 1; }
            else if (npc_state == 8) { _text = "1. Give Item   2. I'll look for it."; npc_state = 2; }

            if (_text != "") {
                var _inst = instance_create_depth(x, y - 300, -10000, obj_textbox);
                _inst.textToShow = _text; 
            }
        }

        // ==========================================
        // 3. MENU LOGIC
        // ==========================================
        if (npc_state == 2) {
            if (keyboard_check_pressed(ord("1"))) {
                if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
                global.inventory_open = true; 
                npc_state = 3; 
                var _inst = instance_create_depth(x, y - 300, -10000, obj_textbox);
                _inst.textToShow = "Pick an item and press ENTER or SPACE.";
            }
            if (keyboard_check_pressed(ord("2"))) {
                if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
                global.inventory_open = false; 
                npc_state = 8; // Safely drops back to Standby
            }
        }

        // ==========================================
        // 4. GIVE ITEM (Hold and Wait)
        // ==========================================
        if ((keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) && npc_state == 3) {
            if (array_length(global.inventory) > 0) {
                
                given_item = global.inventory[global.selected_index];
                array_delete(global.inventory, global.selected_index, 1);
                global.inventory_open = false; 
                
                if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
                
                var _inst = instance_create_depth(x, y - 300, -10000, obj_textbox);
                _inst.textToShow = itemTextThanks ;
                
                npc_state = 7; 
                exit; 
            }
        }

        // ==========================================
        // 5. V KEY VALIDATION & SCORE
        // ==========================================
        if (keyboard_check_pressed(ord("V")) && npc_state == 7) {
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);

            var _targetLayer = "Sequences";
            if (!layer_exists(_targetLayer)) _targetLayer = "Instances";
            layer_depth(_targetLayer, -15000);

            var _val1 = string_replace_all(string_lower(string(given_item)), " ", "");
            var _val2 = string_replace_all(string_lower(string(desired_item)), " ", "");

            var _inst = instance_create_depth(x, y - 300, -10000, obj_textbox);

            if (_val1 == _val2) {
                // SUCCESS
                global.score += 10; 
                global.last_score_change = 10;
                myState = npcState.done; 
                if (sequenceHappy != noone) layer_sequence_create(_targetLayer, x, y, sequenceHappy);
                
                _inst.textToShow = "Yes! This is exactly what I needed!";
                npc_state = 0; 
                
            } else {
                // FAILURE
                global.score -= 5;
                global.last_score_change = -5;
                myState = npcState.normal;
                if (sequenceSad != noone) layer_sequence_create(_targetLayer, x, y, sequenceSad);
                
                _inst.textToShow = itemTextThanks 
                npc_state = 6; 
            }
            
            global.last_score_change_timer = 30;
            global.last_score_x = 100;
            global.last_score_y = 50;
        }
    }
} else {
    // ==========================================
    // 6. WALK-AWAY RESET
    // ==========================================
    if (myState != npcState.done && npc_state > 0) {
        if (npc_state != 7) {
            npc_state = 0;
        }
        if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
    }
}