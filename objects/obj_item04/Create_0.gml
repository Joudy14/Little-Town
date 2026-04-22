// Item state required by parent
myState = itemState.idle;

// Emitter variables
myEmitter = -1;  // Use -1 to indicate invalid

// Only create emitter if sound exists
if (asset_get_index("snd_key") != -1) {
    myEmitter = audio_emitter_create();
    if (myEmitter != -1) {
        audio_emitter_position(myEmitter, x, y, 0);
        audio_falloff_set_model(audio_falloff_exponent_distance);
        audio_emitter_falloff(myEmitter, 30, 80, 1);
        audio_play_sound_on(myEmitter, snd_key, 1, 1);
    }
} else {
    // Fallback: use an existing sound
    myEmitter = audio_emitter_create();
    if (myEmitter != -1) {
        audio_emitter_position(myEmitter, x, y, 0);
        audio_falloff_set_model(audio_falloff_exponent_distance);
        audio_emitter_falloff(myEmitter, 30, 80, 1);
        audio_play_sound_on(myEmitter, snd_pop01, 1, 1);
    }
}
itemName = "Key";
// Item properties
item_key = "item04";
itemWeight = 1;