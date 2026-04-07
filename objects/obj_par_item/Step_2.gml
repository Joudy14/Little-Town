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
    mask_index = -1;  // Remove collision
    
    var _result = scr_itemPosition();
    
    if (instance_exists(obj_player)) {
        if (obj_player.myState == playerState.puttingDown) {
            x = _result[0];
            y = _result[1];
            depth = _result[2];
            image_alpha = 1;
        }
        else {
            // Always show the item, but adjust position based on direction
            x = _result[0];
            depth = _result[2];
            image_alpha = 1;
            
            switch (obj_player.dir) {
                case 0: // Right
                    x = _result[0] + 10;
                    y = _result[1];
                    break;
                case 1: // Up - move behind player
                    x = _result[0];
                    y = _result[1] + 5;
                    depth = _result[2] + 1;  // Behind player
                    break;
                case 2: // Left
                    x = _result[0] - 10;
                    y = _result[1];
                    break;
                case 3: // Down
                    x = _result[0];
                    y = _result[1];
                    break;
            }
        }
        
        // Picking up animation
        if (obj_player.myState == playerState.pickingUp) {
            if (obj_player.image_index >= 2) {
                if (y > _result[1]) {
                    y -= pickUpSp;
                }
            }
        }
        // Carrying position
        else if (obj_player.myState != playerState.puttingDown) {
            if (obj_player.dir == 1) {
                // When facing up, don't adjust y
            } else {
                y = _result[1];
            }
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