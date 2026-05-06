// ==========================================
// INITIALIZATION & SETUP
// ==========================================
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);

var _sw = display_get_gui_width();
var _sh = display_get_gui_height();
var _centerX = _sw * 0.5;
var _centerY = _sh * 0.5;

// ==========================================
// GAME OVER MENU UI
// ==========================================
if (menuActive == true) {
    draw_set_color(make_colour_rgb(255, 248, 225));
    draw_rectangle(0, 0, _sw, _sh, false);
    
    draw_set_color(make_colour_rgb(240, 228, 200));
    for (var i = 0; i < _sw; i += 40) {
        for (var j = 0; j < _sh; j += 40) {
            draw_circle(i, j, 3, false);
        }
    }
    
    draw_set_color(make_colour_rgb(230, 215, 185));
    draw_set_alpha(0.3);
    for (var i = -_sh; i < _sw + _sh; i += 30) {
        draw_line(i, 0, i + _sh, _sh);
    }
    draw_set_alpha(1);
    
    draw_set_color(make_colour_rgb(180, 160, 130));
    draw_rectangle(_centerX - 400, _centerY - 300, _centerX + 400, _centerY + 300, false);
    
    draw_set_color(make_colour_rgb(255, 255, 245));
    draw_rectangle(_centerX - 395, _centerY - 295, _centerX + 395, _centerY + 295, false);
    
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_rectangle(_centerX - 390, _centerY - 290, _centerX + 390, _centerY + 290, true);
    draw_rectangle(_centerX - 385, _centerY - 285, _centerX + 385, _centerY + 285, true);
    
    draw_set_font(font_textbox);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_set_color(make_colour_rgb(255, 215, 0));
    for (var i = 0; i < 5; i++) {
        draw_text(_centerX - 300 + (i * 150), _centerY - 220, "★");
    }
    
    draw_set_color(make_colour_rgb(200, 100, 50));
    draw_text(_centerX, _centerY - 180, "✨ GAME COMPLETE! ✨");
    
    draw_set_color(make_colour_rgb(150, 80, 40));
    draw_text(_centerX, _centerY - 130, "You helped everyone in town!");
    
    if (global.menuChoice == 0) {
        draw_set_color(make_colour_rgb(100, 200, 100));
        draw_rectangle(_centerX - 150, _centerY - 20, _centerX + 150, _centerY + 40, false);
        draw_set_color(make_colour_rgb(255, 255, 255));
        draw_text(_centerX, _centerY + 10, "▶  PLAY AGAIN  ◀");
    } else {
        draw_set_color(make_colour_rgb(80, 80, 100));
        draw_text(_centerX, _centerY + 10, "PLAY AGAIN");
    }
    
    if (global.menuChoice == 1) {
        draw_set_color(make_colour_rgb(200, 100, 100));
        draw_rectangle(_centerX - 150, _centerY + 60, _centerX + 150, _centerY + 120, false);
        draw_set_color(make_colour_rgb(255, 255, 255));
        draw_text(_centerX, _centerY + 90, "▶  QUIT  ◀");
    } else {
        draw_set_color(make_colour_rgb(80, 80, 100));
        draw_text(_centerX, _centerY + 90, "QUIT");
    }
    
    draw_set_color(make_colour_rgb(255, 180, 100));
    draw_text(_centerX - 450, _centerY - 100, "✿");
    draw_text(_centerX + 450, _centerY - 100, "✿");
    draw_text(_centerX - 450, _centerY + 100, "✿");
    draw_text(_centerX + 450, _centerY + 100, "✿");
    
    draw_set_color(make_colour_rgb(255, 100, 150));
    draw_text(_centerX - 480, _centerY, "❤");
    draw_text(_centerX + 480, _centerY, "❤");
    
    draw_set_color(make_colour_rgb(120, 100, 80));
    draw_set_alpha(0.8);
    draw_text(_centerX, _sh - 80, "UP / DOWN  =  Select");
    draw_text(_centerX, _sh - 40, "ENTER / SPACE  =  Confirm");
    draw_set_alpha(1);
}

gpu_set_blendmode(bm_normal);

// ==========================================
// SDLC SCORING UI
// ==========================================
// Only show in gameplay rooms, not on title screen
if (room == rm_gameMain ) {

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font_textbox);

draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(10, 10, 420, 90, false); 

draw_set_alpha(1.0);
draw_set_color(c_white);

draw_text(20, 20, "SDLC POINTS");
draw_set_color(c_yellow);
draw_text(20, 50, string(global.score));

draw_set_color(c_white);
if (global.score >= 90) {
    draw_text(120, 50, "🌟 EXCELLENT");
} else if (global.score >= 70) {
    draw_text(120, 50, "👍 GOOD");
} else {
    draw_text(120, 50, "⚠ NEEDS IMPROVEMENT");
}

// Score Pop-up effect
if (global.last_score_change_timer > 0) {
    global.last_score_change_timer -= 1;
    draw_set_alpha(global.last_score_change_timer / 30);
    
    if (global.last_score_change > 0) {
        draw_set_color(c_lime);
        draw_text(global.last_score_x, global.last_score_y - global.last_score_change_timer, "+" + string(global.last_score_change));
    } else {
        draw_set_color(c_red);
        draw_text(global.last_score_x, global.last_score_y - global.last_score_change_timer, string(global.last_score_change));
    }
    draw_set_alpha(1.0);
}

} // end of scoring UI room check


// Build phase progress bar (only if mayor_state == 4)
if (instance_exists(obj_npc_mayor) && obj_npc_mayor.mayor_state == 4 && obj_npc_mayor.build_progress < global.build_progress_max) {
    var _bar_x = display_get_gui_width()/2 - 150;
    var _bar_y = display_get_gui_height()/2 + 100;
    draw_set_color(c_black);
    draw_rectangle(_bar_x-2, _bar_y-2, _bar_x+302, _bar_y+22, false);
    draw_set_color(c_blue);
    draw_rectangle(_bar_x, _bar_y, _bar_x + (obj_npc_mayor.build_progress / global.build_progress_max)*300, _bar_y+20, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(display_get_gui_width()/2, _bar_y-10, "Building system... " + string(floor(obj_npc_mayor.build_progress*100/global.build_progress_max)) + "%");
    draw_set_halign(fa_left);
}

// ==========================================
// INVENTORY DISPLAY (THE NEW CREAM UI)
// ==========================================
if (global.inventory_open) {
    
    // Soft cream background
    draw_set_color(make_colour_rgb(255, 248, 225));
    draw_rectangle(_centerX - 300, _centerY - 200, _centerX + 300, _centerY + 200, false);
    
    // Dot pattern
    draw_set_color(make_colour_rgb(240, 228, 200));
    for (var i = 0; i < 600; i += 40) {
        for (var j = 0; j < 400; j += 40) {
            draw_circle(_centerX - 300 + i, _centerY - 200 + j, 3, false);
        }
    }
    
    // Diagonal line pattern
    draw_set_color(make_colour_rgb(230, 215, 185));
    draw_set_alpha(0.3);
    for (var i = -400; i < 600; i += 30) {
        draw_line(_centerX - 300 + i, _centerY - 200, _centerX - 300 + i + 400, _centerY + 200);
    }
    draw_set_alpha(1);
    
    // Main card with shadow
    draw_set_color(make_colour_rgb(180, 160, 130));
    draw_rectangle(_centerX - 290, _centerY - 190, _centerX + 290, _centerY + 190, false);
    
    draw_set_color(make_colour_rgb(255, 255, 245));
    draw_rectangle(_centerX - 285, _centerY - 185, _centerX + 285, _centerY + 185, false);
    
    // Decorative border
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_rectangle(_centerX - 280, _centerY - 180, _centerX + 280, _centerY + 180, true);
    draw_rectangle(_centerX - 275, _centerY - 175, _centerX + 275, _centerY + 175, true);
    
    // Title
    draw_set_font(font_textbox);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_set_color(make_colour_rgb(200, 100, 50));
    draw_text(_centerX, _centerY - 130, "INVENTORY");
    
    // Separator line
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_line(_centerX - 200, _centerY - 100, _centerX + 200, _centerY - 100);
    
 // Items list
    draw_set_halign(fa_center);
    
    if (array_length(global.inventory) == 0) {
        draw_set_color(make_colour_rgb(150, 120, 90));
        draw_text(_centerX, _centerY - 30, "Your inventory is empty");
        draw_set_color(make_colour_rgb(180, 150, 120));
        draw_text(_centerX, _centerY, "Find items by exploring the town!");
    } else {
        var _startY = _centerY - 70;
        
        // --- SLIDING WINDOW LOGIC ---
        var _max_visible = 6; // The maximum number of items that fit in the box
        var _start_i = 0;     // Where the list starts drawing
        
        // If your cursor goes lower than the visible window, push the window down
        if (global.selected_index >= _max_visible) {
            _start_i = global.selected_index - _max_visible + 1;
        }
        
        // Ensure we don't try to draw more items than actually exist
        var _end_i = min(array_length(global.inventory), _start_i + _max_visible);
        
        // Draw "Scroll Up" indicator if items are hidden above
        if (_start_i > 0) {
            draw_set_color(make_colour_rgb(200, 150, 100));
            draw_text(_centerX, _startY - 25, "▲ . . . ▲");
        }
        
        var _draw_slot = 0; // Tracks which row (0 through 5) we are currently drawing
        
        // Only loop through the items inside our visible window
        for (var i = _start_i; i < _end_i; i++) {
            var _yPos = _startY + (_draw_slot * 30); // 30 is the spacing between items
            
            // The Highlight Logic
            if (i == global.selected_index) {
                draw_set_color(make_colour_rgb(255, 215, 0));
                draw_rectangle(_centerX - 220, _yPos - 12, _centerX + 220, _yPos + 18, false);
                draw_set_color(make_colour_rgb(80, 40, 20));
                draw_text(_centerX, _yPos, "> " + global.inventory[i] + " <");
            } else {
                draw_set_color(make_colour_rgb(100, 70, 40));
                draw_text(_centerX, _yPos, "- " + global.inventory[i]);
            }
            
            _draw_slot += 1; // Move down to the next row in the menu
        }
        
        // Draw "Scroll Down" indicator if items are hidden below
        if (_end_i < array_length(global.inventory)) {
            draw_set_color(make_colour_rgb(200, 150, 100));
            draw_text(_centerX, _startY + (_max_visible * 30), "▼ . . . ▼");
        }
    }
    
    // Bottom separator
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_line(_centerX - 200, _centerY + 100, _centerX + 200, _centerY + 100);
    
    // Instructions
    draw_set_color(make_colour_rgb(120, 100, 80));
    draw_set_alpha(0.8);
    draw_text(_centerX, _centerY + 120, "W / S  =  Scroll");
    draw_text(_centerX, _centerY + 150, "Q  =  Close Inventory");
    draw_set_alpha(1);
    
    // Reset alignment
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// ==========================================
// ACHIEVEMENT POPUP (temporary unlock notification)
// ==========================================
if (room != rm_mainTitle) {


if (global.achievement_popup_timer > 0) {
    global.achievement_popup_timer--;
    var _alpha = min(1, global.achievement_popup_timer / 20); // fade faster
    var _text = "ACHIEVEMENT UNLOCKED: " + global.last_achievement;
    var _w = string_width(_text) + 60;
    var _h = 40;
    var _x = (display_get_gui_width() - _w) / 2;   // horizontally centered
    var _y = (display_get_gui_height() - _h) / 2;   // vertically centered
                               
    
    draw_set_alpha(_alpha * 0.9);
    
    // Shadow
    draw_set_color(make_colour_rgb(180, 160, 130));
    draw_rectangle(_x + 4, _y + 4, _x + _w + 4, _y + _h + 4, false);
    
    // Cream background
    draw_set_color(make_colour_rgb(255, 248, 225));
    draw_rectangle(_x, _y, _x + _w, _y + _h, false);
    
    // Gold border
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_rectangle(_x, _y, _x + _w, _y + _h, true);
    
    // Text
    draw_set_color(make_colour_rgb(200, 100, 50));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(font_textbox);
    draw_text(_x + _w/2, _y + _h/2, _text);
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// ==========================================
// ACHIEVEMENT BUTTON (cream/gold style)
// ==========================================
var _btn_w = 200;
var _btn_h = 70;
var _btn_x = display_get_gui_width() - _btn_w - 50;
var _btn_y = 20;

// Button background (cream)
draw_set_color(make_colour_rgb(255, 248, 225));
draw_rectangle(_btn_x, _btn_y, _btn_x + _btn_w, _btn_y + _btn_h, false);

// Gold border
draw_set_color(make_colour_rgb(255, 200, 100));
draw_rectangle(_btn_x, _btn_y, _btn_x + _btn_w, _btn_y + _btn_h, true);

// Button text
draw_set_font(font_small);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_colour_rgb(200, 100, 50));
draw_text(_btn_x + _btn_w/2, _btn_y + _btn_h/2, "ACHIEVEMENTS");
draw_set_font(font_textbox);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// ==========================================
// ACHIEVEMENT POPUP (same style as inventory)
// ==========================================
if (global.show_achievement_popup) {
    var _pw = 1000;
    var _ph = 800;
    var _px = (display_get_gui_width() - _pw) / 2;
    var _py = (display_get_gui_height() - _ph) / 2;
    
    // Shadow
    draw_set_color(make_colour_rgb(180, 160, 130));
    draw_rectangle(_px + 8, _py + 8, _px + _pw + 8, _py + _ph + 8, false);
    
    // Main card
    draw_set_color(make_colour_rgb(255, 248, 225));
    draw_rectangle(_px, _py, _px + _pw, _py + _ph, false);
    
    // Gold border
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_rectangle(_px + 4, _py + 4, _px + _pw - 4, _py + _ph - 4, true);
    draw_rectangle(_px + 8, _py + 8, _px + _pw - 8, _py + _ph - 8, true);
    
    // Title
    draw_set_font(font_textbox);
    draw_set_halign(fa_center);
    draw_set_color(make_colour_rgb(200, 100, 50));
    draw_text(_px + _pw/2, _py + 35, "ACHIEVEMENTS");
    

    
    // List
    draw_set_halign(fa_left);
    var _line_h = 50;
    var _start_y = _py + 100;
    var _visible_idx = 0;
    for (var i = 0; i < array_length(global.achievements); i++) {
        var _ach = global.achievements[i];
        if (_ach.hidden && !_ach.unlocked) continue;
        
        var _color = _ach.unlocked ? make_colour_rgb(100, 200, 100) : make_colour_rgb(160, 160, 160);
        draw_set_color(_color);
        var _status = _ach.unlocked ? "V " : "X ";
        var _name = _ach.name;
        var _desc = _ach.desc;
        if (_ach.hidden && !_ach.unlocked) {
            _name = "???";
            _desc = "Hidden - complete a secret task";
        }
        draw_text(_px + 20, _start_y + _visible_idx * _line_h, _status + _name);
        draw_set_color(make_colour_rgb(120, 100, 80));
        draw_text(_px + 170, _start_y + _visible_idx * _line_h, "                " + _desc);
        _visible_idx++;
    }
    
    // Close instruction
    draw_set_color(make_colour_rgb(120, 100, 80));
    draw_set_halign(fa_center);
    draw_text(_px + _pw/2, _py + _ph - 50, "Click outside to close");
    draw_set_halign(fa_left);
}
}