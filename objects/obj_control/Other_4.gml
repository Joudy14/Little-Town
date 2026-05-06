audio_stop_all();

// Play music based on Room (now only title and main room)
switch (room) {
    case rm_mainTitle:
        audio_play_sound(snd_seq_good02_BGM, 1, 1);
        break;
    case rm_gameMain:
        audio_play_sound(snd_townBGM, 1, 1);
        audio_play_sound(snd_townAmbience, 1, 1);
        break;
    // rm_forest and rm_river cases removed because they no longer exist
}

// Destroy items already picked up (keep one block, remove duplicate)
with (obj_par_item) {
    if (array_contains(global.picked_up_items, item_key)) {
        instance_destroy();
        show_debug_message("Destroyed " + string(object_index) + " (already picked up)");
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
} else {
    curSeqLayer = "Instances";
}

// Reset UI states
global.npc_dialogue_shown = false;
global.waiting_for_npc_choice = false;
global.waiting_for_item_selection = false;
global.show_inventory = false;