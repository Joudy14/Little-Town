// Handle Game Over Menu input
if (menuActive == true) {
    // UP / W
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        global.menuChoice -= 1;
        if (global.menuChoice < 0) global.menuChoice = 1;
        audio_play_sound(snd_pop02, 1, 0);
    }
    
    // DOWN / S
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        global.menuChoice += 1;
        if (global.menuChoice > 1) global.menuChoice = 0;
        audio_play_sound(snd_pop02, 1, 0);
    }
    
    // ENTER / SPACE to confirm
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        audio_play_sound(snd_pop01, 1, 0);
        if (global.menuChoice == 0) {
            game_restart();  // Play Again
        } else {
            game_end();  // Quit
        }
    }
    
    exit;  // Don't process other game logic while menu is active
}

if (keyboard_check_pressed(ord("A"))) {
    show_debug_message("A pressed - menuActive = " + string(menuActive));
}
// Control Sequences
switch sequenceState {
    case seqState.playing:
    {
        // Fade out town music
        if (audio_is_playing(snd_townBGM)) {
            audio_sound_gain(snd_townBGM,0,60);
        }
        // Fade out town ambience
        if (audio_is_playing(snd_townAmbience)) {
            audio_sound_gain(snd_townAmbience,0,60);
        }
        global.playerControl = false;
    }
    break;
    
    case seqState.finished:
    {
        // Remove Sequence
        if (layer_sequence_exists(curSeqLayer,curSeq)) {
            layer_sequence_destroy(curSeq);
        }
        // Restore control to player, reset
        global.playerControl = true;
        sequenceState = seqState.notPlaying;
        curSeq = noone;
        
        // Restore town music
        if (audio_is_playing(snd_townBGM) && audio_sound_get_gain(snd_townBGM) < townBGMvolume) {
            audio_sound_gain(snd_townBGM,townBGMvolume,60);
        }
        // Restore town ambience
        if (audio_is_playing(snd_townAmbience) && audio_sound_get_gain(snd_townAmbience) < townAmbienceVolume) {
            audio_sound_gain(snd_townAmbience,townAmbienceVolume,60);
        }
        
// Check if NPCs are "done"
if (global.gameOver == false) {
    if (instance_exists(obj_npc_baker) && instance_exists(obj_npc_teacher) && instance_exists(obj_npc_grocer)) {
        if (obj_npc_baker.myState == npcState.done && obj_npc_teacher.myState == npcState.done && obj_npc_grocer.myState == npcState.done) {
            // PLAY GAME OVER SEQUENCE (not menu yet)
            scr_playSequence(seq_gameOver);
            global.gameOver = true;
        }
    }
}
    }
    break;
}

// Handle menu input when game over menu is active
if (menuActive == true) {
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        scr_menuUp();
        // Update visual highlight in sequence - you'll need to add broadcast messages
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        scr_menuDown();
        // Update visual highlight in sequence
    }
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        scr_menuSelect();
    }
}