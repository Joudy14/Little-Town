// ==========================================
// SDLC TOWN: SCORE CONTROL FUNCTIONS
// ==========================================
// Function to add points
function scr_add_points(_amount, _x, _y) {
    global.score += _amount;
    
    // Set up the floating popup
    global.last_score_change = _amount;
    global.last_score_change_timer = 30;
    global.last_score_x = _x;
    global.last_score_y = _y;

    // Play sound for point gain
    if (_amount > 0) {
        audio_play_sound(snd_pop01, 1, 0);
    }
    
    show_debug_message("Score: " + string(global.score) + " (" + string(_amount) + ")");
}

// Function to check and update rating
function scr_update_rating() {
    if (global.score >= 90) {
        return "🌟 Excellent Analyst";
    } else if (global.score >= 70) {
        return "👍 Good Recovery";
    } else {
        return "⚠ Needs Improvement";
    }
}

// Function to calculate final score
function scr_calculate_final_score() {
    var _final_score = 100;
    
    // +20 per correct item (max 60)
    if (global.mother_correct) _final_score += 20;
    if (global.teacher_correct) _final_score += 20;
    if (global.baker_correct) _final_score += 20;
    
    // +10 per validation (max 30)
    if (global.mother_validated) _final_score += 10;
    if (global.teacher_validated) _final_score += 10;
    if (global.baker_validated) _final_score += 10;
    
    // -20 per wrong item
    _final_score -= (global.wrong_items_given * 20);
    
    // -10 per skipped validation
    _final_score -= (global.skipped_validations * 10);
    
    if (_final_score < 0) _final_score = 0;
    
    global.score = _final_score;
    return _final_score;
}