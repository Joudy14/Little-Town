// Play sequence after validation text
if (global.pending_npc != noone) {
    
    if (global.pending_npc.gave_wrong_item == false) {
        // Correct item - HAPPY sequence
        scr_playSequence(global.pending_npc.sequenceHappy);
        
        global.pending_npc.is_validated = true;
        global.pending_npc.myState = npcState.done;
        
        // Remove item from inventory
        for (var i = 0; i < array_length(global.inventory_keys); i++) {
            if (global.inventory_keys[i] == global.pending_npc.received_item_key) {
                array_delete(global.inventory, i, 1);
                array_delete(global.inventory_keys, i, 1);
                break;
            }
        }
        
        // Add validation points
        scr_add_points(10, x, y - 50);
        
        // Change to happy sprite
        if (global.pending_npc.doneSprite != noone) {
            global.pending_npc.sprite_index = global.pending_npc.doneSprite;
        }
        
    } else {
        // Wrong item - SAD sequence
        scr_playSequence(global.pending_npc.sequenceSad);
        
        // Reset NPC state so player can try again
        global.pending_npc.has_received_item = false;
        global.pending_npc.gave_wrong_item = false;
        global.pending_npc.has_been_talked_to = false;
        // Keep is_validated as false
    }
    
    global.pending_npc = noone;
}