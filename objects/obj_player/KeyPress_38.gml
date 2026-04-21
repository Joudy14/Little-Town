// UP key - move selection UP (decrease number)
if (global.waiting_for_item_selection && global.show_inventory) {
    global.inventory_selection = global.inventory_selection - 1;
    if (global.inventory_selection < 0) {
        global.inventory_selection = array_length(global.inventory) - 1;
    }
    audio_play_sound(snd_pop02, 1, 0);
    show_debug_message("UP pressed - selection: " + string(global.inventory_selection));
}