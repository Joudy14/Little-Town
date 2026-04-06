switch myState {
    case itemState.idle:
    {
        depth = -y;
        image_alpha = 1;
        mask_index = sprite_index;  // Restore collision
    };
    break;
    
    case itemState.taken:
    {
        mask_index = -1;  // Remove collision so player doesn't detect it
        
        var _result = scr_itemPosition();
        
        if (instance_exists(obj_player)) {
            if (obj_player.myState == playerState.puttingDown) {
                x = _result[0];
                y = _result[1];
                depth = _result[2];
                image_alpha = 1;
            }
            else {
                switch (obj_player.dir) {
                    case 0: case 2: case 3:
                        x = _result[0];
                        y = _result[1];
                        depth = _result[2];
                        image_alpha = 1;
                        break;
                    case 1:
                        image_alpha = 0;
                        break;
                }
            }
            
            if (obj_player.myState == playerState.pickingUp) {
                if (obj_player.image_index >= 2) {
                    if (y > _result[1]) {
                        y -= pickUpSp;
                    }
                }
            }
            else if (obj_player.myState != playerState.puttingDown) {
                if (obj_player.dir != 1) {
                    y = _result[1];
                }
            }
        }
    };
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
    };
    break;
}