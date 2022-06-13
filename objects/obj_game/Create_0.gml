/// @description Insert description here
/// @param

#region SET UP EDITOR VARIABLES
font=font_add_sprite(spr_font,ord("!"),false,0);
draw_set_font(font);
inGame=false;
current_tile=0;
current_ent=0;
DEBUG=true;
#endregion

#region SET UP GAME VARIBLES
#macro TILE_SIZE 16
#endregion

#region INITIALIZE PALETTE SWAPPING
pal_swap_init_system(shd_pal_swapper);
#endregion

#region SET UP LEVEL VARIABLES
lvl_name="NEW LEVEL";
lvl_numb=0;
lvl_x=room_width/SCREEN_WIDTH;
lvl_y=room_height/SCREEN_HEIGHT;
lvl_theme=0;
lvl_attr=0;
lvl_start_x=0;
lvl_start_y=0;
lvl_end_x=0;
lvl_end_y=0;
lvl_par=0;
lvl_path=0;//PATH BONUS DETERMINED BY INDIVIDUAL LEVEL
speed_bonus=10000;//BONUS FOR BEATING THE LEVEL UNDER LEVEL PAR
no_prize=true;
no_prize_bonus=5000;
no_hit=true;
no_hit_bonus=5000;
min_points=1000;
sec_points=10;
minutes=0;
seconds=0;
#endregion

#region SET UP TILE WINDOW VARIABLES
tile_window_w=256;
tile_window_x=0;
tile_window_y=32;
tile_window_h=272;
spr_tile_window=scr_create_window(tile_window_w,tile_window_h);
tile_display_x=tile_window_x+8;
tile_display_y=tile_window_y+24;
spr_tile_display=scr_tile_display();
tile_window_open=false;
tile_window_active=false;
within_tile_display=false;
#endregion

#region SET UP ENTITY WINDOW VARIABLES
entity_window_w=144;
entity_window_x=display_get_gui_width()-8;
entity_window_y=32;
entity_window_h=112;
spr_entity_window=scr_create_window(entity_window_w,entity_window_h);
entity_display_x=entity_window_x+8;
entity_display_y=entity_window_y+24;
spr_entity_display=scr_entity_display();
entity_window_open=false;
entity_window_active=false;
within_entity_display=false;
#endregion