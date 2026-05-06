function scr_unlock_achievement(_id, _custom_name = undefined) {
    for (var i = 0; i < array_length(global.achievements); i++) {
        if (global.achievements[i].id == _id && !global.achievements[i].unlocked) {
            global.achievements[i].unlocked = true;
            if (global.achievements[i].hidden && _custom_name != undefined) {
                global.achievements[i].name = _custom_name;
            }
            global.last_achievement = global.achievements[i].name;
            global.achievement_popup_timer = 180;
            audio_play_sound(snd_pop02, 1, 0);
            break;
        }
    }
}