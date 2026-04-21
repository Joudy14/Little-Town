switch myState {
    case itemState.idle:
    {

        depth = -y;
        image_alpha = 1;
        mask_index = sprite_index;  // Restore collision
    }
    break;
    

case itemState.taken:
{
    // FORCE the sprite to be visible
    visible = true;
    image_alpha = 1;
    
    // DEBUG: Check what sprite it's using
    show_debug_message("ITEM SPRITE: " + string(sprite_index) + " VISIBLE: " + string(visible));

    
    if (instance_exists(obj_player)) {
        var _result = scr_itemPosition();
        
        // ALWAYS update position
        x = _result[0];
        y = _result[1];
        depth = _result[2];
        
        // Picking up animation (optional)
        if (obj_player.myState == playerState.pickingUp && obj_player.image_index >= 2) {
            y -= 5;  // Slight lift during pickup
        }
    }
}
break;
    
    case itemState.puttingBack:
    {
        image_alpha = 1;
        
        if (instance_exists(obj_player) && obj_player.myState == playerState.puttingDown) {
            if (y < putDownY) {
                y += putDownSp;
            }
            if (y >= putDownY) {
                myState = itemState.idle;
                image_alpha = 1;
                mask_index = sprite_index;  // Restore collision
            }
        }
    }
    break;
}