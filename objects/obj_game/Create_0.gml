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

#region SET UP INTRO VARIABLES
///PIECE TOGETHER BUILDING TILES AND ADD AS SPRITE
var _xx,_yy,_tile,_tile_count,_tilex,_tiley,_str;

//CREATE SURFACE FOR BUILDING
var _building_surface=surface_create(256,112);

//SET DRAWING TARGET TO NEWLY CREATED SURFACE
surface_set_target(_building_surface);

//SET TILE COUNTER TO ZERO
_tile_count=0;

//CREATE BUILDING TILE GRID
var _tile_grid=ds_grid_create(32*14,2);

//OPEN DATA FILE FOR TILE GRID
var _file=file_text_open_read("building.dat");

//WHILE THE FILE IS BEING READ
while (!file_text_eof(_file))
    {
    //READ DATA STRING INTO TILE GRID
    _str = file_text_read_string(_file)
    ds_grid_read(_tile_grid, _str);
    }

//WHEN THE END OF THE FILE IS REACHED, CLOSE FILE
file_text_close(_file);

//LOOP THROUGH X AND Y
for(_yy=0;_yy<14;_yy++)
    {
    for(_xx=0;_xx<32;_xx++)
        {
        //GET SAVED TILE LEFT VALUE
        _tilex=ds_grid_get(_tile_grid,_tile_count,0);
        //GET SAVED TILE TOP VALUE
        _tiley=ds_grid_get(_tile_grid,_tile_count,1);


		
        //IF VALUE NOT -1
        if _tilex != -1
            {
            //DRAW BACKGROUND TILES FOR SURFACE
            draw_sprite_part(spr_wildside,0,_tilex,_tiley,8,8,_xx*8,_yy*8);
			
            }
        //INCREMENT TILE COUNT
        _tile_count++;
        }
    }
	
	// Assuming `my_grid` is your ds_grid
var grid_width = ds_grid_width(_tile_grid);
var grid_height = ds_grid_height(_tile_grid);

// Loop through the grid and construct the output string
var output = "";
for (var _y = 0; _y < grid_height; _y++) {
    for (var _x = 0; _x < grid_width; _x++) {
        // Add each cell value to the string with a separator
        output += string(_tile_grid[# _x, _y]) + "\t"; // Tab-separated for better alignment
    }
    output += "\n"; // Newline after each row
}

// Print the output to the console
show_debug_message(output);

show_debug_message("spr_wildside ID: " + string(real(spr_wildside)));

//CREATE SPRITE FROM SURFACE
spr_building=sprite_create_from_surface(_building_surface,0,0,256,112,false,false,0,0);

//RESET DRAWING TARGET TO APPLICATION SURFACE
surface_reset_target();

//DESTROY TILE GRID, NO LONGER NEEDED
ds_grid_destroy(_tile_grid);

//DESTROY SURFACE, NO LONGER NEEDED
surface_free(_building_surface);
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
