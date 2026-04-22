audio_stop_all();

// Play music based on Room
switch (room) {
	    case rm_mainTitle:
    {
        audio_play_sound(snd_seq_good02_BGM,1,1);  // Title music
    }
    break;
    case rm_gameMain:
        // Town music and ambience
        audio_play_sound(snd_townBGM, 1, 1);
        audio_play_sound(snd_townAmbience, 1, 1);
        break;
        
    case rm_forest:
        // Forest music (different from town)
        audio_play_sound(snd_townAmbience, 1, 1);  // Or any forest-themed sound
        // Optional: forest ambience (birds, wind)
        break;
        
    case rm_river:
        // River music (different from town and forest)
        audio_play_sound(snd_fountain, 1, 1);  // Or any river-themed sound
        // Optional: water flowing sound
        break;
        
}

// Destroy items already picked up
with (obj_par_item) {
    if (array_contains(global.picked_up_items, item_key)) {
        instance_destroy();
        show_debug_message("Destroyed " + string(object_index) + " (already picked up)");
    }
}

with (obj_par_item) {
    show_debug_message("Checking item " + string(object_index) + " key=" + string(item_key) + " picked_up list=" + string(global.picked_up_items));
    if (array_contains(global.picked_up_items, item_key)) {
        instance_destroy();
        show_debug_message("Destroyed " + string(object_index));
    }
}
// Restore NPC states from global data
with (obj_par_npc) {
    var _state = global.npc_states[$ object_index];
    if (_state != undefined) {
        myState = (_state.done ? npcState.done : npcState.normal);
        has_received_item = _state.has_item;
        gave_wrong_item = _state.gave_wrong;
        is_validated = _state.validated;
        if (myState == npcState.done && doneSprite != noone) {
            sprite_index = doneSprite;
        }
    }
}
// Mark Sequences layer
if (layer_exists("Cutscenes")) {
    curSeqLayer = "Cutscenes";
}
else {
    curSeqLayer = "Instances";
}




if (room == rm_river && !global.river_message_shown) {
    global.river_message_shown = true;
 var _msg = instance_create_depth(640, 850, -10000, obj_textbox);  // Better
    _msg.textToShow = "To cross the river, you need to build a bridge.";
}




global.npc_dialogue_shown = false;
global.waiting_for_npc_choice = false;
global.waiting_for_item_selection = false;
global.show_inventory = false;