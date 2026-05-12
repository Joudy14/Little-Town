// Toggle inventory - only if not in selection mode
if (!global.waiting_for_item_selection) {
    global.show_inventory = !global.show_inventory;

} else {
    // If in selection mode, just close without selecting
    global.waiting_for_item_selection = false;
    global.show_inventory = false;
    global.current_npc = noone;
}

global.inventory_open = !global.inventory_open;
// Immediately set a flag to prevent reset for one step
global.prevent_inventory_reset = 30; // 30 steps

show_debug_message("Q pressed - toggling inventory_open to: " + string(!global.inventory_open));
global.inventory_open = !global.inventory_open;
show_debug_message("After toggle, inventory_open = " + string(global.inventory_open));