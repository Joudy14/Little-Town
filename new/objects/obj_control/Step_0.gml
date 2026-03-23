// Control Sequences
switch (global.sequenceState) {

    case seqState.playing:

        // Fade out town music
        if (audio_is_playing(snd_townBGM)) {
            audio_sound_gain(snd_townBGM, 0, 60);
        }

        // Fade out ambience
        if (audio_is_playing(snd_townAmbience)) {
            audio_sound_gain(snd_townAmbience, 0, 60);
        }

if (audio_is_playing(snd_fountain)) {
    audio_sound_gain(snd_fountain, 0, 60);
}

        // Disable player
        global.playerControl = false;

        // Check if sequence finished
        if (!layer_sequence_exists(curSeqLayer, curSeq)) {
            global.sequenceState = seqState.finished;
        }

    break;


    case seqState.finished:

        // Restore music
        audio_sound_gain(snd_townBGM, townBGMvolume, 60);

        // Restore ambience
        audio_sound_gain(snd_townAmbience, townAmbienceVolume, 60);

        // Enable player again
        global.playerControl = true;

        // Reset everything
        global.sequenceState = seqState.notPlaying;
        curSeq = noone;

    break;
}