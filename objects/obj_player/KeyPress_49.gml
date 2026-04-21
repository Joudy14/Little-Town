// Option 1: Give item from inventory
if (global.waiting_for_npc_choice) {
    
    if (array_length(global.inventory) == 0) {
        var _msg = instance_create_depth(x, y - 100, -10000, obj_textbox);
        _msg.textToShow = "Your inventory is empty! Go find some items first.";
        global.waiting_for_npc_choice = false;
    } else {
        // Show inventory for selection
        global.waiting_for_item_selection = true;
        global.show_inventory = true;
        global.inventory_selection = 0;
        global.waiting_for_npc_choice = false;
    }
}