// --- CONVERSATION STATES ---
npc_state = 0; 

// --- ASSETS & TEXT ---
doneSprite = noone; 
desired_item = "Scale"; // <--- NOW HE WANTS THE SCALE

myText = "I can't sell my produce without my Scale! Have you found it?"; 
itemTextDone = "Thank you! Now I can finally measure my goods.";

// --- SEQUENCES ---
seqHappy = seq_grocer_happy;
seqSad = seq_grocer_sad;

// --- ANIMATION LOGIC ---
myState = npcState.normal;
loopRange01 = 60;
loopRange02 = 120;

itemTextThanks = "Thank you.";