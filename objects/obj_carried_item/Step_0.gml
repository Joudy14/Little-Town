// Follow the player
if (instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y - 20;
    depth = obj_player.depth - 1;
}