// Mark NPC as done
if (nearbyNPC != noone && instance_exists(nearbyNPC)) {
    with (nearbyNPC) {
        myState = npcState.done;
    }
}

// Reset item variables (item already destroyed, just clear vars)
hasItem = noone;
carryLimit = 0;