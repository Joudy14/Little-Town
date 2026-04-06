show_debug_message("Space pressed - hasItem = " + string(hasItem) + " | nearbyItem = " + string(nearbyItem) + " | nearbyNPC = " + string(nearbyNPC) + " | dir = " + string(dir));
var _text, _seq;

// If player has control
if (global.playerControl == true) {
    
    // PRIORITY 1: TALK TO NPC
    if (nearbyNPC) {
        show_debug_message("DEBUG: Talking to NPC");
        
        if (nearbyNPC.myState == npcState.normal) {
            // No item - just talk
            if (hasItem == noone || hasItem == undefined) {
                _text = nearbyNPC.myText;
                if (!instance_exists(obj_textbox)) {
                    iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                    iii.textToShow = _text;
                }
            }
            // Has item - GIVE IT
            else if (hasItem != noone && instance_exists(hasItem)) {
                if (hasItem.object_index == nearbyNPC.myItem) {
                    _text = nearbyNPC.itemTextHappy;
                    _seq = nearbyNPC.sequenceHappy;
                    
                    // DESTROY THE ITEM
                    with (hasItem) {
                        instance_destroy();
                    }
                    
                    alarm[1] = 10;
                }
                else {
                    _text = nearbyNPC.itemTextSad;
                    _seq = nearbyNPC.sequenceSad;
                }
                
                if (!instance_exists(obj_textbox)) {
                    iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                    iii.textToShow = _text;
                    iii.sequenceToShow = _seq;
                }
                
                // Clear item from player
                hasItem = noone;
                carryLimit = 0;
            }
        }
        else if (nearbyNPC.myState == npcState.done) {
            _text = nearbyNPC.itemTextDone;
            if (!instance_exists(obj_textbox)) {
                iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400,-10000,obj_textbox);
                iii.textToShow = _text;
            }
        }
    }
    
    // PRIORITY 2: PICK UP ITEM
else if (nearbyItem && !nearbyNPC) {
    if (hasItem == noone || hasItem == undefined) {
        // FORCE DESTROY PROMPT
        if (itemPrompt != noone) {
            with (itemPrompt) {
                instance_destroy();
            }
            itemPrompt = noone;
        }
        
        // Then pick up code...
        global.playerControl = false;
        myState = playerState.pickingUp;
        image_index = 0;
        hasItem = nearbyItem;
        carryLimit = hasItem.itemWeight * 0.1;
        with (hasItem) {
            myState = itemState.taken;
        }
        audio_play_sound(snd_itemPickup,1,0);
    }
}
    
// PUT DOWN - ONLY check if holding item (ignore nearbyItem!)
else if (hasItem != noone && !nearbyNPC) {
    show_debug_message("DEBUG: Putting down item!");
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
}