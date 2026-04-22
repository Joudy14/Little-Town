var _text, _seq;

// Ensure inventory exists
if (!variable_global_exists("inventory_keys")) {
    global.inventory = [];
    global.inventory_keys = [];
}

// If player has control
if (global.playerControl == true) {
    
    // ==========================================
    // INTERACT WITH CHEST
    // ==========================================
    if (nearbyChest && !nearbyNPC) {
        
        if (!nearbyChest.is_open) {
            
            // Check if player has Key in inventory
            var _has_key = false;
            for (var i = 0; i < array_length(global.inventory); i++) {
                if (global.inventory[i] == "Key") {
                    _has_key = true;
                    break;
                }
            }
            var _key_index = -1;
            
            for (var i = 0; i < array_length(global.inventory_keys); i++) {
                show_debug_message("Checking key: " + string(global.inventory_keys[i]));
                if (global.inventory_keys[i] == "item04") {
                    _has_key = true;
                    _key_index = i;
                    break;
                }
            }
            show_debug_message("Has key? " + string(_has_key));
            
            show_debug_message("=== CHEST INTERACTION ===");
            show_debug_message("global.inventory_keys: " + string(global.inventory_keys));
            
if (_has_key) {
    // Remove key, open chest, play sound (as before)
    array_delete(global.inventory, _key_index, 1);
    array_delete(global.inventory_keys, _key_index, 1);
    nearbyChest.is_open = true;
    audio_play_sound(snd_pop01, 1, 0);
    
    // Show success message (but do NOT spawn reward yet)
    var _msg = instance_create_depth(x, y - 100, -10000, obj_textbox);
    _msg.textToShow = "You unlocked the chest! A reward appears!";
    
    // Store reward position and item for later
    global.pending_reward_x = nearbyChest.x;
    global.pending_reward_y = nearbyChest.y - 90;  // adjust as needed
    global.pending_reward_item = obj_item03;       // or whatever reward object
    
    // Mark that chest reward has been queued (so we don't queue again)
    nearbyChest.reward_spawned = true;   // prevent double spawning
} else {
                // No key message
                var _msg = instance_create_depth(x, y - 100, -10000, obj_textbox);
                _msg.textToShow = "This chest is locked. You need a KEY to open it.";
            }
            
        } else {
            // Chest already open
            var _msg = instance_create_depth(x, y - 100, -10000, obj_textbox);
            _msg.textToShow = "The chest is already open.";
        }
        
        exit; // Stop here
    }
    
// ==========================================
// BUILD BRIDGE
// ==========================================
if (nearbyBridge && !nearbyBridge.is_built && !nearbyNPC) {
    
    // Check by item name instead of key
    var _has_wood = false;
    var _wood_index = -1;
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == "Wood") {
            _has_wood = true;
            _wood_index = i;
            break;
        }
    }
    
    if (_has_wood) {
        // Remove wood from inventory
        array_delete(global.inventory, _wood_index, 1);
        array_delete(global.inventory_keys, _wood_index, 1);
        
        // Build bridge
        nearbyBridge.is_built = true;
        nearbyBridge.visible = true;
        
        // Destroy river blocks
        with (obj_river_block_2) {
            if (distance_to_point(other.nearbyBridge.x, other.nearbyBridge.y) < 100) {
                instance_destroy();
            }
        }
        
        audio_play_sound(snd_pop01, 1, 0);
        var _msg = instance_create_depth(x, y - 100, -10000, obj_textbox);
        _msg.textToShow = "You built a bridge! Now you can cross the river.";
        
    } else {
        var _msg = instance_create_depth(x, y - 100, -10000, obj_textbox);
        _msg.textToShow = "The river is too wide. You need WOOD to build a bridge.";
    }
    
    exit;
}
    
    // ==========================================
    // PRIORITY 1: TALK TO NPC
    // ==========================================
    if (nearbyNPC) {
        show_debug_message("DEBUG: Near NPC");
        
        // If NPC is still available (not done)
        if (nearbyNPC.myState == npcState.normal) {
            
            // Case A: Player has NO item - just talk
            if (hasItem == noone) {
                show_debug_message("DEBUG: No item - talking only");
                _text = nearbyNPC.myText;
                if (!instance_exists(obj_textbox)) {
                    iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                    iii.textToShow = _text;
                }
            }
            
            // Case B: Player HAS an item - give it to NPC
            else if (hasItem != noone && instance_exists(hasItem)) {
                show_debug_message("DEBUG: Giving item to NPC");
                
                // Check if item is CORRECT
                if (hasItem.object_index == nearbyNPC.myItem) {
                    show_debug_message("DEBUG: CORRECT item!");
                    
                    // --- INSIDE CORRECT ITEM SECTION ---
                    // Add +20 points
                    scr_add_points(20, x, y - 50);
                    
                    // Mark which NPC got correct item (USING OLD NAMES FOR LOCAL TEST)
                    if (nearbyNPC.object_index == obj_npc_teacher) global.mother_correct = true; // Old name for Mother
                    if (nearbyNPC.object_index == obj_npc_grocer) global.teacher_correct = true;  // Old name for Teacher
                    if (nearbyNPC.object_index == obj_npc_baker) global.baker_correct = true;     // Stays the same
                    // -----------------------------------------------------
                    
                    _text = nearbyNPC.itemTextHappy;
                    _seq = nearbyNPC.sequenceHappy;
                    
                    // --- ADD: Update global NPC state (has correct item, not validated yet) ---
                    var _npc_obj = nearbyNPC.object_index;
                    if (global.npc_states[$ _npc_obj] == undefined) {
                        global.npc_states[$ _npc_obj] = { done: false, has_item: false, gave_wrong: false, validated: false };
                    }
                    global.npc_states[$ _npc_obj].has_item = true;
                    global.npc_states[$ _npc_obj].gave_wrong = false;
                    // ------------------------------------------------------------------------
                    
                    // Destroy the item
                    with (hasItem) {
                        instance_destroy();
                    }
                    
                    // Create textbox with sequence
                    if (!instance_exists(obj_textbox)) {
                        iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                        iii.textToShow = _text;
                        iii.sequenceToShow = _seq;
                    }
                    
                    // Mark NPC as done
                    alarm[1] = 10;
                    hasItem = noone;
                    carryLimit = 0;
                }
                else {
                    show_debug_message("DEBUG: WRONG item!");
                    
                    // --- INSIDE WRONG ITEM SECTION ---
                    // Subtract 20 points
                    scr_add_points(-20, x, y - 50);
                    global.wrong_items_given += 1;
                    // ---------------------------------------------------
                    
                    _text = nearbyNPC.itemTextSad;
                    _seq = nearbyNPC.sequenceSad;
                    
                    // --- ADD: Update global NPC state (has wrong item) ---
                    var _npc_obj = nearbyNPC.object_index;
                    if (global.npc_states[$ _npc_obj] == undefined) {
                        global.npc_states[$ _npc_obj] = { done: false, has_item: false, gave_wrong: false, validated: false };
                    }
                    global.npc_states[$ _npc_obj].has_item = true;
                    global.npc_states[$ _npc_obj].gave_wrong = true;
                    // -----------------------------------------------------
                    
                    // Create textbox with sequence
                    if (!instance_exists(obj_textbox)) {
                        iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                        iii.textToShow = _text;
                        iii.sequenceToShow = _seq;
                    }
                    
                    // IMPORTANT: Item STAYS in player's hand
                }
            }
        }
        // If NPC is already "done"
        else if (nearbyNPC.myState == npcState.done) {
            show_debug_message("DEBUG: NPC already done");
            _text = nearbyNPC.itemTextDone;
            if (!instance_exists(obj_textbox)) {
                iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                iii.textToShow = _text;
            }
        }
    }
    
    // ==========================================
    // PRIORITY 2: PUT DOWN ITEM (holding item, not near NPC)
    // ==========================================
    else if (hasItem != noone && !nearbyNPC) {
        show_debug_message("DEBUG: Putting down item - dir = " + string(dir));
        myState = playerState.puttingDown;
        image_index = 0;
        global.playerControl = false;
        with (hasItem) {
            putDownY = obj_player.y + 5;
            myState = itemState.puttingBack;
            image_alpha = 1;
        }
        audio_play_sound(snd_itemPutDown,1,0);
        hasItem = noone;
        carryLimit = 0;
    }
    
    // ==========================================
    // PRIORITY 3: PICK UP ITEM (near item, not holding anything)
    // ==========================================
    else if (nearbyItem && !nearbyNPC && (hasItem == noone)) {
        show_debug_message("DEBUG: Picking up item");
        
        // Destroy prompt if exists
        if (itemPrompt != noone) {
            with (itemPrompt) {
                instance_destroy();
            }
            itemPrompt = noone;
        }
        
        global.playerControl = false;
        myState = playerState.pickingUp;
        image_index = 0;
        hasItem = nearbyItem;
		global.pending_item_name = hasItem.itemName;
global.pending_item_key = hasItem.item_key;
show_debug_message("Stored pending item: name=" + global.pending_item_name + " key=" + global.pending_item_key);
        carryLimit = hasItem.itemWeight * 0.1;
        with (hasItem) {
            myState = itemState.taken;
            mask_index = -1;  // Remove collision
        }
        audio_play_sound(snd_itemPickup,1,0);
    }
}