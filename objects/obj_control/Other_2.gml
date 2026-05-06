// Game variables
global.playerControl = true;
townBGMvolume = audio_sound_get_gain(snd_townBGM);
townAmbienceVolume = audio_sound_get_gain(snd_townAmbience);
global.gameOver = false;
global.gameStart = false;
global.river_message_shown_near = false;

global.pending_item_name = "";
global.pending_item_key = "";
global.pending_reward_x = noone;
global.pending_reward_y = noone;
global.pending_reward_item = noone;

global.picked_up_items = [];   // Stores keys like "item01", "item02", etc.

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

global.npc_states = {
    obj_npc_baker: { done: false, has_item: false, gave_wrong: false, validated: false },
    obj_npc_teacher: { done: false, has_item: false, gave_wrong: false, validated: false },
    obj_npc_grocer: { done: false, has_item: false, gave_wrong: false, validated: false }
};

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

global.river_message_shown = false;


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


// Inventory system
global.inventory = [];
global.inventory_keys = [];
global.show_inventory = false;
global.inventory_selection = 0;
global.waiting_for_npc_choice = false;
global.waiting_for_item_selection = false;
global.current_npc = noone;
global.temp_held_item = noone;
global.temp_held_item_name = "";



// ==========================================
// ACHIEVEMENT SYSTEM
// ==========================================
global.achievements = [
    { id: "networker", name: "Networker", desc: "Talk to all three stakeholders", unlocked: false, hidden: false },
    { id: "collector", name: "Collector", desc: "Find all 6 hidden items", unlocked: false, hidden: false },
    { id: "treasure_hunter", name: "Treasure Hunter", desc: "Open the chest", unlocked: false, hidden: false },
    { id: "engineer", name: "Engineer", desc: "Build the bridge", unlocked: false, hidden: false },
    { id: "problem_solver", name: "Problem Solver", desc: "Give correct item to each NPC", unlocked: false, hidden: false },
    { id: "fixer", name: "Fixer", desc: "Give a wrong item then later correct it", unlocked: false, hidden: false },
    { id: "validation_master", name: "Validation Master", desc: "Press V near a stakeholder", unlocked: false, hidden: true },
    { id: "master_analyst", name: "Master Analyst", desc: "Give correct items and validate all", unlocked: false, hidden: true },
    { id: "excellent", name: "Excellent", desc: "Finish with score >= 90", unlocked: false, hidden: true }
];
global.last_achievement = "";
global.achievement_popup_timer = 0;
global.show_achievement_popup = false;

global.validated = { baker: false, teacher: false, grocer: false };
global.first_validation_done = false;
global.correct_given = { baker: false, teacher: false, grocer: false };
global.gave_wrong_before = { baker: false, teacher: false, grocer: false };
global.items_collected = [];
global.chest_opened = false;
global.bridge_built = false;

// ==========================================
// MAYOR DESIGN QUESTIONS
// ==========================================
global.design_questions = [
    { text: "What is the first step of the System Development Life Cycle?", 
      options: ["A) Write code", "B) Identify the problem", "C) Deploy the system"], 
      correct: 1 },
    { text: "Why is validation important before deployment?", 
      options: ["A) It saves time", "B) It prevents costly bugs", "C) It looks professional"], 
      correct: 1 },
    { text: "What does the 'Build' phase produce?", 
      options: ["A) Requirements document", "B) Working software/system", "C) Test plan"], 
      correct: 1 }
];
global.build_progress_max = 60;
global.waiting_for_design_answer = false;
global.mayor_deployed = false;

global.talked_to = { baker: false, teacher: false, grocer: false };
global.correct_given = { baker: false, teacher: false, grocer: false };
global.validated = { baker: false, teacher: false, grocer: false };