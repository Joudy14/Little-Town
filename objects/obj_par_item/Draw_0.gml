// ==========================================
// 1. DRAW SPRITE
// ==========================================
draw_self(); 

// ==========================================
// 2. CLASSIC WHITE POP-UP BOX
// ==========================================
// The instance_nearest check guarantees this will NEVER overlap with another item!
if (distance_to_object(obj_player) < 50 && id == instance_nearest(obj_player.x, obj_player.y, obj_par_item)) {
    
    var _msg = "Press Space to collect";
    
    // Make sure we are using your game's font
    draw_set_font(font_textbox);
    
    // Calculate how big the box needs to be based on the text
    var _padding_x = 15;
    var _padding_y = 10;
    var _text_w = string_width(_msg) + _padding_x; 
    var _text_h = string_height(_msg) + _padding_y;
    
    var _box_x = x;
    var _box_y = y - 60; // Hovers exactly above the item
    
    // Calculate the corners of the box
    var _left = _box_x - (_text_w / 2);
    var _right = _box_x + (_text_w / 2);
    var _top = _box_y - (_text_h / 2);
    var _bottom = _box_y + (_text_h / 2);

    // 1. Draw a soft black drop-shadow behind the box
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_rectangle(_left + 3, _top + 3, _right + 3, _bottom + 3, false);
    draw_set_alpha(1.0);

    // 2. Draw the solid white textbox background
    draw_set_color(make_colour_rgb(255, 255, 245)); // Same off-white her UI uses
    draw_rectangle(_left, _top, _right, _bottom, false);

    // 3. Draw a neat border (Using her UI's border color)
    draw_set_color(make_colour_rgb(180, 160, 130)); 
    draw_rectangle(_left, _top, _right, _bottom, true);

    // 4. Draw the actual text perfectly centered inside
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black); // Dark text so you can read it on the white box
    draw_text(_box_x, _box_y, _msg);

    // 5. Reset alignment so we don't break the rest of the game's drawing
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}