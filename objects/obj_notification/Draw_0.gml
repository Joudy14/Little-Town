// ==========================================
// CLASSIC WHITE NOTIFICATION BOX
// ==========================================
draw_set_font(font_textbox);

// Calculate box size dynamically based on the text length
var _padding_x = 20;
var _padding_y = 15;
var _text_w = string_width(text) + _padding_x; 
var _text_h = string_height(text) + _padding_y;

var _left = x - (_text_w / 2);
var _right = x + (_text_w / 2);
var _top = y - (_text_h / 2);
var _bottom = y + (_text_h / 2);

// 1. Soft black drop-shadow
draw_set_color(c_black);
draw_set_alpha(0.3);
draw_rectangle(_left + 3, _top + 3, _right + 3, _bottom + 3, false);
draw_set_alpha(1.0);

// 2. Off-white background
draw_set_color(make_colour_rgb(255, 255, 245)); 
draw_rectangle(_left, _top, _right, _bottom, false);

// 3. UI-matching border
draw_set_color(make_colour_rgb(180, 160, 130)); 
draw_rectangle(_left, _top, _right, _bottom, true);

// 4. Centered text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black); 
draw_text(x, y, text);

// 5. Reset alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);