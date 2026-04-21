if (nearbyNPC != noone && nearbyNPC.has_received_item == true && nearbyNPC.is_validated == false) {
    // Destroy old textbox
    if (instance_exists(obj_textbox)) {
        with (obj_textbox) { instance_destroy(); }
    }
    var _msg = instance_create_depth(nearbyNPC.x, nearbyNPC.y-400, -10000, obj_textbox);
    _msg.textToShow = "You want to know my opinion?";
    global.waiting_for_validation = true;
    global.npc_to_validate = nearbyNPC;
}