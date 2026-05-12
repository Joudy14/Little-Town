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

if (!global.stakeholder_received_item.baker || !global.stakeholder_received_item.teacher || !global.stakeholder_received_item.grocer) {
    if (!instance_exists(obj_textbox)) {
        var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
        _msg.textToShow = "You haven't given anything to everyone yet. Help each of them before returning to me.";
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

// If we reach here, all have received at least one item
if (!global.mayor_confirm_shown) {
    global.mayor_confirm_shown = true;
    show_choice("You have given something to everyone. Are you ready to deploy?\n\n1. Yes, deploy.\n2. No, let me check again.");
    exit;
}