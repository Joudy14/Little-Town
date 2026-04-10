// Game variables
global.playerControl = true;
townBGMvolume = audio_sound_get_gain(snd_townBGM);
townAmbienceVolume = audio_sound_get_gain(snd_townAmbience);
global.gameOver = false;
global.gameStart = false;

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

// Sequence states
enum seqState {
    notPlaying,
    waiting,
    playing,
    finished,
}

// Sequence variables
sequenceState = seqState.notPlaying;
curSeqLayer = noone;
curSeq = noone;

// NPC states
enum npcState {
    normal,
    done,
}

// Menu variables
global.menuChoice = 0;
menuActive = false;
// ==========================================
// SDLC TOWN: SCORING SYSTEM
// ==========================================
// Initialize global score (starts at 100)
global.score = 100;

// Track score changes for display
global.last_score_change = 0;
global.last_score_change_timer = 0;
global.last_score_x = 0;
global.last_score_y = 0;

// Track which NPCs gave correct items
global.mother_correct = false;
global.teacher_correct = false;
global.baker_correct = false;

// Track validations performed
global.mother_validated = false;
global.teacher_validated = false;
global.baker_validated = false;

// Track penalties
global.wrong_items_given = 0;
global.skipped_validations = 0;