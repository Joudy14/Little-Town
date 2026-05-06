// ==========================================
// 1. GAME OVER MENU LOGIC
// ==========================================
if (menuActive == true) {
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        global.menuChoice -= 1;
        if (global.menuChoice < 0) global.menuChoice = 1;
        audio_play_sound(snd_pop02, 1, 0);
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        global.menuChoice += 1;
        if (global.menuChoice > 1) global.menuChoice = 0;
        audio_play_sound(snd_pop02, 1, 0);
    }
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        audio_play_sound(snd_pop01, 1, 0);
        if (global.menuChoice == 0) game_restart(); else game_end();
    }
    exit; 
}

// ==========================================
// 2. INVENTORY SCROLLING LOGIC
// ==========================================
if (global.inventory_open == true) {
    var _item_count = array_length(global.inventory);
    if (_item_count > 0) {
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            global.selected_index -= 1;
            if (global.selected_index < 0) global.selected_index = _item_count - 1;
            audio_play_sound(snd_pop02, 1, 0);
        }
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            global.selected_index += 1;
            if (global.selected_index >= _item_count) global.selected_index = 0;
            audio_play_sound(snd_pop02, 1, 0);
        }
    }
}

// ==========================================
// 2.5 INVENTORY TOGGLE (NEW Q LOGIC)
// ==========================================
// This toggles the inventory and updates player control status
if (keyboard_check_pressed(ord("Q"))) {
    // Toggle the variable
    global.inventory_open = !global.inventory_open;
    
    // Safety: Reset selected index to top when opening
    if (global.inventory_open) {
        global.selected_index = 0;
        global.playerControl = false; // Freeze player
    } else {
        // Only give control back if no textbox or sequence is blocking it
        if (!instance_exists(obj_textbox) && sequenceState != seqState.playing) {
            global.playerControl = true;
        }
    }
}

// ==========================================
// 3. DEBUG TOOLS
// ==========================================
if (keyboard_check_pressed(ord("A"))) {
    show_debug_message("A pressed - menuActive = " + string(menuActive));
    show_debug_message("Inventory Open = " + string(global.inventory_open));
    show_debug_message("Player Control = " + string(global.playerControl));
}

// ==========================================
// 4. SEQUENCE AND END-GAME CHECK
// ==========================================
switch sequenceState {
    case seqState.playing:
    {
        if (audio_is_playing(snd_townBGM)) audio_sound_gain(snd_townBGM, 0, 60);
        if (audio_is_playing(snd_townAmbience)) audio_sound_gain(snd_townAmbience, 0, 60);
        global.playerControl = false;
    }
    break;
    
    case seqState.finished:
    {
        if (layer_sequence_exists(curSeqLayer, curSeq)) {
            layer_sequence_destroy(curSeq);
        }
        global.playerControl = true;
        sequenceState = seqState.notPlaying;
        curSeq = noone;
        
        if (audio_is_playing(snd_townBGM) && audio_sound_get_gain(snd_townBGM) < townBGMvolume) {
            audio_sound_gain(snd_townBGM, townBGMvolume, 60);
        }
        if (audio_is_playing(snd_townAmbience) && audio_sound_get_gain(snd_townAmbience) < townAmbienceVolume) {
            audio_sound_gain(snd_townAmbience, townAmbienceVolume, 60);
        }
        
        if (global.gameOver == false) {
            if (instance_exists(obj_npc_baker) && instance_exists(obj_npc_teacher) && instance_exists(obj_npc_grocer)) {
                if (obj_npc_baker.myState == npcState.done && 
                    obj_npc_teacher.myState == npcState.done && 
                    obj_npc_grocer.myState == npcState.done) {
                    scr_playSequence(seq_gameOver);
                    global.gameOver = true;
                }
            }
        }
    }
    break;
}

// ==========================================
// 5. MASTER UNFREEZE SAFETY (FREE MOVEMENT)
// ==========================================

// FORCE UNFREEZE CONDITION
// We only freeze if the Inventory is open, a Menu is active, or a Cutscene Sequence is playing.
// NPCs will no longer freeze your movement!
if (global.inventory_open || menuActive || sequenceState == seqState.playing) {
    global.playerControl = false;
} else {
    global.playerControl = true;
}

// ==========================================
// 6. Mouse click detection for button & popup
// ==========================================

if (room != rm_mainTitle && mouse_check_button_pressed(mb_left)) {

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // Button area
    var _btn_w = 200;
    var _btn_h = 70;
    var _btn_x = display_get_gui_width() - _btn_w - 50;
    var _btn_y = 20;
    
    // Popup area (if open)
    var _pop_w = 500;
    var _pop_h = 400;
    var _pop_x = (display_get_gui_width() - _pop_w) / 2;
    var _pop_y = (display_get_gui_height() - _pop_h) / 2;
    
    if (_mx >= _btn_x && _mx <= _btn_x + _btn_w && _my >= _btn_y && _my <= _btn_y + _btn_h) {
        // Toggle popup
        global.show_achievement_popup = !global.show_achievement_popup;
    } else if (global.show_achievement_popup) {
        // If click outside popup, close it
        if (!(_mx >= _pop_x && _mx <= _pop_x + _pop_w && _my >= _pop_y && _my <= _pop_y + _pop_h)) {
            global.show_achievement_popup = false;
        }
    }
}