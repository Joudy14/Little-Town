// --- CONVERSATION STATES ---
npc_state = 0; 

// --- ASSETS & TEXT ---
doneSprite = noone; 
desired_item = "Checklist"; 

myText = "what should i do with all this howswork"; 
itemTextDone = "Finally! Now I can orgnize my things";

// --- SEQUENCES ---
seqHappy = seq_teacher_happy;
seqSad = seq_teacher_sad;

// --- ANIMATION LOGIC ---
myState = npcState.normal;
loopRange01 = 60;
loopRange02 = 120;
given_item = ""; // The holding area for the item before pressing V