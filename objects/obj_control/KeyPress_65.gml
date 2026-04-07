// TEST KEY: Press A to trigger Game Over Menu
show_debug_message("TEST: A key pressed - triggering game over");

// Play the game over sequence
scr_playSequence(seq_gameOver);

// Mark game as over to prevent multiple triggers
global.gameOver = true;