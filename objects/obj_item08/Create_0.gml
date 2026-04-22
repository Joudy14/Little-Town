// ==========================================
// INITIALIZATION
// ==========================================
// 1. Run the parent's logic first (CRITICAL)
event_inherited();

// 2. Set the scanner's specific state and variables
myState = itemState.idle;
putDownY = 0;
putDownSp = 17;
pickUpSp = 17;

item_key = "item08";   // change the number for each item
itemName = "Scanner"; // <--- This tells the inventory you picked up an Apple