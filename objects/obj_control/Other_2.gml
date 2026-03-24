// Game variables
global.playerControl = true;
global.gameOver = false;
global.gameStart = false;
townBGMvolume = audio_sound_get_gain(snd_townBGM);
townAmbienceVolume = audio_sound_get_gain(snd_townAmbience);
global.gameOver = false;
// Player states
enum playerState {
idle,
walking,
pickingUp,
carrying,
carryIdle,
puttingDown,
}
// Item states
enum itemState {
idle,
taken,
used,
puttingBack,
}
// NPC states
enum npcState {
normal,
done,
}