/// @description Insert description here
// You can write your code in this editor
//draw background color theme
draw_sprite(spr_holo_back,0,camera_get_view_x(view),camera_get_view_y(view))

draw_sprite_part_ext(spr_theme_bkg_pal,0,obj_system.level_theme-1,0,1,1,0,0,room_width,room_height,c_white,obj_system.end_alpha);