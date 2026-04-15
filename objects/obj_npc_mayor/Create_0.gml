// ==========================================
// NPC INTERACTION VARIABLES
// ==========================================
npc_state = 0; // Starts the state machine at 0

// You also need these for the dialogue and validation to work!
myText = "I need my [insert item here]."; 
itemTextDone = "Thank you, Mayor's duties are saved!";
desired_item = "MayorItemName"; // Change this to the exact name of the item he wants
item_received = "";