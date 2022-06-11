/// @description Insert description here
/// @param

#region SET UP GAME VARIBLES
#macro SCREEN_WIDTH 320
#macro SCREEN_HEIGHT 224
#macro TILE_SIZE 16
font=font_add_sprite(spr_font,ord("!"),false,0);
draw_set_font(font);
inGame=false;
#endregion

pal_swap_init_system(shd_pal_swapper);

#region LEVEL VARIABLES
lvl_name="NEW LEVEL";
lvl_numb=0;
lvl_x=room_width/SCREEN_WIDTH;
lvl_y=room_height/SCREEN_HEIGHT;
lvl_theme=0;
lvl_attr=0;
lvl_sx=0;
lvl_sy=0;
lvl_ex=0;
lvl_ey=0;
lvl_par=0;
lvl_path=0;
#endregion

#region TILE WINDOW
tile_window_w=256;
tile_window_x=0;
tile_window_y=32;
tile_window_h=272;
spr_tile_window=scr_create_window(tile_window_w,tile_window_h);
spr_tile_display=scr_tile_display();
#endregion

#region ENTITY WINDOW
entity_window_w=144;
entity_window_x=display_get_gui_width()-(entity_window_w+16);
entity_window_y=32;
entity_window_h=112;
spr_entity_window=scr_create_window(entity_window_w,entity_window_h);
spr_entity_display=scr_entity_display();
#endregion