// ==========================================
// PICKUP LOGIC
// ==========================================
if (distance_to_object(obj_player) < 50) {
    if (keyboard_check_pressed(vk_space)) {
        // Add to inventory array
        array_push(global.inventory, "Scanner");
        
        // Visual feedback
        show_debug_message("Added Scanner to Inventory");
        
        // Remove from the floor
        instance_destroy();
    }
}