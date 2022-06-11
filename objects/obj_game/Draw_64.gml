/// @description Insert description here
/// @param
var gui_scale=obj_camera.gui_scale

var str="TILES";
var strw=string_width(str);

draw_sprite(spr_tile_window,0,tile_window_x,tile_window_y);
draw_text_transformed(tile_window_x+tile_window_w/2-strw,tile_window_y+8,string(str),2,2,0);
draw_sprite(spr_tile_display,0,tile_window_x+8,tile_window_y+24);


str = "BLOCKS";
var strw=string_width(str);
draw_sprite(spr_entity_window,0,entity_window_x,entity_window_y);
draw_text_transformed(entity_window_x+entity_window_w/2-strw,entity_window_y+8,string(str),2,2,0);

str = "ENEMIES";
var strw=string_width(str);
draw_text_transformed(entity_window_x+entity_window_w/2-strw,entity_window_y+56,string(str),2,2,0);

draw_sprite(spr_entity_display,0,entity_window_x+8,entity_window_y+24);