function show_next_design_question() {
    if (current_question < array_length(global.design_questions)) {
        var _q = global.design_questions[current_question];
        var _text = "Design Phase Question " + string(current_question+1) + " of " + string(array_length(global.design_questions)) + "\n\n";
        _text += _q.text + "\n\n";
        for (var i = 0; i < array_length(_q.options); i++) {
            _text += _q.options[i] + "\n";
        }
        _text += "\nPress 1, 2, or 3 to answer.";
        var _msg = instance_create_depth(obj_npc_mayor.x, obj_npc_mayor.y-300, -10000, obj_textbox);
        _msg.textToShow = _text;
        global.waiting_for_design_answer = true;
    }
}

function start_build_phase() {
    build_progress = 0;
    var _msg = instance_create_depth(obj_npc_mayor.x, obj_npc_mayor.y-300, -10000, obj_textbox);
    _msg.textToShow = "Build phase started. Building your system...";
}

function perform_final_evaluation() {
    var _base = 100;
    var _item_bonus = (global.correct_given.baker?20:0) + (global.correct_given.teacher?20:0) + (global.correct_given.grocer?20:0);
    var _validation_bonus = (global.validated.baker?10:0) + (global.validated.teacher?10:0) + (global.validated.grocer?10:0);
    var _design_bonus = design_correct * 10;
    var _wrong_penalty = (global.wrong_items_given || 0) * 20;
    var _final = _base + _item_bonus + _validation_bonus + _design_bonus - _wrong_penalty;
    if (_final < 0) _final = 0;
    global.score = _final;

    var _rating = "";
    if (_final >= 90) _rating = "EXCELLENT !!";
    else if (_final >= 70) _rating = "GOOD";
    else _rating = "NEEDS IMPROVEMENT";

    var _text = "=== FINAL EVALUATION ===\n\n";
    _text += "Your total score: " + string(_final) + "\n";
    _text += "Rating: " + _rating + "\n\n";
    _text += "Thank you for your service, Analyst!\n";
    _text += "The town is grateful.";
    var _msg = instance_create_depth(obj_npc_mayor.x, obj_npc_mayor.y-300, -10000, obj_textbox);
    _msg.textToShow = _text;

    if (_final >= 90) scr_unlock_achievement("excellent", "Excellent");

    global.mayor_deployed = true;
    alarm[0] = 60; // 1 second later show game over menu
}