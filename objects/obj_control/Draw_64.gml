// Force draw settings
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);

// Get screen size
var _sw = display_get_gui_width();
var _sh = display_get_gui_height();
var _centerX = _sw * 0.5;
var _centerY = _sh * 0.5;

// Draw Game Over Menu
if (menuActive == true) {
    
    // === BACKGROUND PATTERN ===
    // Soft cream background
    draw_set_color(make_colour_rgb(255, 248, 225));  // Cream
    draw_rectangle(0, 0, _sw, _sh, false);
    
    // Dot pattern
    draw_set_color(make_colour_rgb(240, 228, 200));  // Slightly darker cream
    for (var i = 0; i < _sw; i += 40) {
        for (var j = 0; j < _sh; j += 40) {
            draw_circle(i, j, 3, false);
        }
    }
    
    // Diagonal line pattern overlay
    draw_set_color(make_colour_rgb(230, 215, 185));
    draw_set_alpha(0.3);
    for (var i = -_sh; i < _sw + _sh; i += 30) {
        draw_line(i, 0, i + _sh, _sh);
    }
    draw_set_alpha(1);
    
    // === MAIN CARD ===
    // Soft shadow
    draw_set_color(make_colour_rgb(180, 160, 130));
    draw_rectangle(_centerX - 400, _centerY - 300, _centerX + 400, _centerY + 300, false);
    
    // Main white card with rounded corners effect (using rectangles)
    draw_set_color(make_colour_rgb(255, 255, 245));  // Off-white
    draw_rectangle(_centerX - 395, _centerY - 295, _centerX + 395, _centerY + 295, false);
    
    // Decorative border
    draw_set_color(make_colour_rgb(255, 200, 100));  // Warm gold
    draw_rectangle(_centerX - 390, _centerY - 290, _centerX + 390, _centerY + 290, true);
    draw_rectangle(_centerX - 385, _centerY - 285, _centerX + 385, _centerY + 285, true);
    
    // === TITLE ===
    draw_set_font(font_textbox);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Star decorations
    draw_set_color(make_colour_rgb(255, 215, 0));  // Gold
    for (var i = 0; i < 5; i++) {
        draw_text(_centerX - 300 + (i * 150), _centerY - 220, "★");
    }
    
    // Main title
    draw_set_color(make_colour_rgb(200, 100, 50));  // Warm orange-brown
    draw_set_font(font_textbox);
    draw_text(_centerX, _centerY - 180, "✨ GAME COMPLETE! ✨");
    
    draw_set_color(make_colour_rgb(150, 80, 40));
    draw_text(_centerX, _centerY - 130, "You helped everyone in town!");
    
    // === MENU OPTIONS ===
    // Play Again button background
    if (global.menuChoice == 0) {
        // Highlighted - colorful
        draw_set_color(make_colour_rgb(100, 200, 100));  // Soft green
        draw_rectangle(_centerX - 150, _centerY - 20, _centerX + 150, _centerY + 40, false);
        draw_set_color(make_colour_rgb(255, 255, 255));
        draw_text(_centerX, _centerY + 10, "▶  PLAY AGAIN  ◀");
    } else {
        // Normal
        draw_set_color(make_colour_rgb(80, 80, 100));
        draw_text(_centerX, _centerY + 10, "PLAY AGAIN");
    }
    
    // Quit button background
    if (global.menuChoice == 1) {
        // Highlighted - colorful
        draw_set_color(make_colour_rgb(200, 100, 100));  // Soft red
        draw_rectangle(_centerX - 150, _centerY + 60, _centerX + 150, _centerY + 120, false);
        draw_set_color(make_colour_rgb(255, 255, 255));
        draw_text(_centerX, _centerY + 90, "▶  QUIT  ◀");
    } else {
        // Normal
        draw_set_color(make_colour_rgb(80, 80, 100));
        draw_text(_centerX, _centerY + 90, "QUIT");
    }
    
    // === DECORATIVE ELEMENTS ===
    // Small flowers/stars around the card
    draw_set_color(make_colour_rgb(255, 180, 100));
    draw_text(_centerX - 450, _centerY - 100, "✿");
    draw_text(_centerX + 450, _centerY - 100, "✿");
    draw_text(_centerX - 450, _centerY + 100, "✿");
    draw_text(_centerX + 450, _centerY + 100, "✿");
    
    draw_set_color(make_colour_rgb(255, 100, 150));
    draw_text(_centerX - 480, _centerY, "❤");
    draw_text(_centerX + 480, _centerY, "❤");
    
    // === INSTRUCTIONS ===
    draw_set_color(make_colour_rgb(120, 100, 80));
    draw_set_alpha(0.8);
    draw_text(_centerX, _sh - 80, "UP / DOWN  =  Select");
    draw_text(_centerX, _sh - 40, "ENTER / SPACE  =  Confirm");
    draw_set_alpha(1);
    
    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

gpu_set_blendmode(bm_normal);