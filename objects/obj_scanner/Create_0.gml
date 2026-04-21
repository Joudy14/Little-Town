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