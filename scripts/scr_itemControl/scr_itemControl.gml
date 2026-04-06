// @description Item control functions
// This script contains functions for positioning items relative to the player

function scr_itemPosition(){
    // Get player's current position
    var _x = obj_player.x;
    var _y = obj_player.y - 40;
    var _depth = obj_player.depth - 1;
    
    return [_x, _y, _depth];
}