var _text, _seq;

// If player has control
if (global.playerControl == true) {
    
    // PRIORITY 1: TALK TO NPC
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
                    _text = nearbyNPC.itemTextHappy;
                    _seq = nearbyNPC.sequenceHappy;
                    
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
                    _text = nearbyNPC.itemTextSad;
                    _seq = nearbyNPC.sequenceSad;
                    
                    // Create textbox with sequence
                    if (!instance_exists(obj_textbox)) {
                        iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                        iii.textToShow = _text;
                        iii.sequenceToShow = _seq;
                    }
                    
                    // IMPORTANT: Item STAYS in player's hand
                    // Do NOT destroy item
                    // Do NOT clear hasItem
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
    
    // PRIORITY 2: PUT DOWN ITEM (holding item, not near NPC)
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
    
    // PRIORITY 3: PICK UP ITEM (near item, not holding anything)
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
        carryLimit = hasItem.itemWeight * 0.1;
        with (hasItem) {
            myState = itemState.taken;
            mask_index = -1;  // Remove collision
        }
        audio_play_sound(snd_itemPickup,1,0);
    }
}