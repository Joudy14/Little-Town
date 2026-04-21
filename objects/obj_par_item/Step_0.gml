// ==========================================
// UNIVERSAL PICKUP (100% FREEZE-FREE)
// ==========================================
var _dist = distance_to_object(obj_player);

// Check if close AND if this is the nearest item
if (_dist < 50 && id == instance_nearest(obj_player.x, obj_player.y, obj_par_item)) {
    
    if (keyboard_check_pressed(vk_space)) {
        
var _finalName = variable_instance_exists(id, "itemName") ? itemName : sprite_get_name(sprite_index);
        array_push(global.inventory, _finalName);
        
        // ADD THIS LINE: It destroys old notifications so they never overlap!
        if (instance_exists(obj_notification)) instance_destroy(obj_notification);
        
        var _inst = instance_create_depth(obj_player.x, obj_player.y - 100, -15000, obj_notification);
        _inst.text = "Got " + _finalName + "! Press Q for Inventory.";
        
        instance_destroy();
	}
}