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
    
    case "showGameOverMenu":  // ← ADD THIS CASE
    {
        show_debug_message("Showing Game Over Menu");

        global.playerControl = false;
		alarm[2] = 30;
    }
    break;
	case "showFinalScore": {
		global.playerControl = false;
		show_debug_message("=== FINAL SCORE ===");
		show_debug_message("Score: " + string(global.score));
		show_debug_message("Rating: " + scr_update_rating());
		show_debug_message("Correct Items: " + string(global.mother_correct + global.teacher_correct + global.baker_correct) + "/3");
		show_debug_message("Validations: " + string(global.mother_validated + global.teacher_validated + global.baker_validated) + "/3");
	}; break;
}
