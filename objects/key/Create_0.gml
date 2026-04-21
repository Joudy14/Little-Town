// Set my state
myState = itemState.idle;
putDownY = 0;
putDownSp = 17;
pickUpSp = 17;

// Store which item this is (will be set by spawn script)
item_key = "item04"; 

// Sound emitter for key proximity
myEmitter = 0;
sound_radius = 100;  // Small radius (fountain was 400)
sound_volume = 0.5;  // Half volume

// Create emitter
myEmitter = audio_emitter_create();
audio_emitter_position(myEmitter, x, y, 0);
audio_falloff_set_model(audio_falloff_exponent_distance);
audio_emitter_falloff(myEmitter, 50, sound_radius, 1);  // Start falloff at 50, max at 100
audio_play_sound_on(myEmitter, snd_sparkle, 1, 1);  // Loop