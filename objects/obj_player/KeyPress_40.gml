// DOWN key - move selection DOWN (increase number)
if (global.waiting_for_item_selection && global.show_inventory) {
    global.inventory_selection = global.inventory_selection + 1;
    if (global.inventory_selection >= array_length(global.inventory)) {
        global.inventory_selection = 0;
    }
    audio_play_sound(snd_pop02, 1, 0);
    show_debug_message("DOWN pressed - selection: " + string(global.inventory_selection));
}