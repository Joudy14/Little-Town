// Listen for Broadcast Messages
switch (event_data[? "message"]) {
    case "sequenceStart":
    {
        sequenceState = seqState.playing;
        if (layer_get_element_type(event_data[? "element_id"]) == layerelementtype_sequence) {
            curSeq = event_data[? "element_id"];
            show_debug_message("Sequence " + string(curSeq) + " is playing");
        }
    }
    break;
    
    case "sequenceEnd":
    {
        sequenceState = seqState.finished;
        show_debug_message("Sequence " + string(curSeq) + " has ended");
    }
    break;
    
    case "showGameOverMenu":  // ← ADD THIS CASE
    {
        show_debug_message("Showing Game Over Menu");
        menuActive = true;
        global.playerControl = false;
		alarm[2] = 30;
    }
    break;
}