// Toggle inventory - only if not in selection mode
if (!global.waiting_for_item_selection) {
    global.show_inventory = !global.show_inventory;

} else {
    // If in selection mode, just close without selecting
    global.waiting_for_item_selection = false;
    global.show_inventory = false;
    global.current_npc = noone;
}