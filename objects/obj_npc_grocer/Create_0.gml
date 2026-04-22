// --- CONVERSATION STATES ---
npc_state = 0; 

// --- ASSETS & TEXT ---
doneSprite = noone; 
desired_item = "Pencil"; // <--- NOW HE WANTS THE SCALE

myText = "I hate being a teacher. Wait, what are you doing outside?"; 
itemTextDone = "Finally! Now I can finish grading these papers.";

// --- SEQUENCES ---
seqHappy = seq_grocer_happy;
seqSad = seq_grocer_sad;

// --- ANIMATION LOGIC ---
myState = npcState.normal;
loopRange01 = 60;
loopRange02 = 120;

itemTextThanks = "Thank you.";