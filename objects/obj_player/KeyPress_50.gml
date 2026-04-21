// Option 2: I'll look for it
if (global.waiting_for_npc_choice) {
    var _msg = instance_create_depth(x, y - 100, -10000, obj_textbox);
    _msg.textToShow = "Good luck! Find the right item and come back.";
    global.waiting_for_npc_choice = false;
    global.current_npc = noone;
}