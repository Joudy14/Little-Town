// Only respond if player is within 100 pixels
if (point_distance(x, y, obj_player.x, obj_player.y) > 90) exit;

// If already deployed, show done text
if (global.mayor_deployed) {
    if (!instance_exists(obj_textbox)) {
        var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
        _msg.textToShow = itemTextDone;
    }
    exit;
}

// Check if player has talked to all three NPCs (using correct variable names)
if (!global.talked_to.baker || !global.talked_to.teacher || !global.talked_to.grocer) {
    if (!instance_exists(obj_textbox)) {
        var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
        _msg.textToShow = "You haven't met everyone yet. Go talk to the Baker, Teacher, and Grocer first.";
    }
    exit;
}

// Check if player has solved all problems (given correct items)
if (!global.correct_given.baker || !global.correct_given.teacher || !global.correct_given.grocer) {
    if (!instance_exists(obj_textbox)) {
        var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
        _msg.textToShow = "You haven't solved all their problems yet. Help each of them before returning to me.";
    }
    exit;
}

// All good – show deployment confirmation (only once)
if (!global.mayor_confirm_shown) {
    global.mayor_confirm_shown = true;
    var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
    _msg.textToShow = "You have helped everyone. Are you ready to deploy your solutions?\n\n1. Yes, deploy.\n2. No, let me check again.";
}