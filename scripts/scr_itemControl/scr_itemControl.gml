function scr_itemPosition(){
    var _x = obj_player.x;
    var _y = obj_player.y -65 // Changed from -40 to -35 (adjust as needed)
    var _depth = obj_player.depth - 1;  // This puts item IN FRONT of player
    
    return [_x, _y, _depth];
}