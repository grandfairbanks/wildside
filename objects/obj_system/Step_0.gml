/// @description Insert description here
// You can write your code in this editor
#region Zoom

#endregion

#region TOGGLE DEBUG
if keyboard_check(vk_control) && keyboard_check_pressed(ord("D"))
	{
	debug = !debug;
	}
#endregion

#region WINDOW SIZE TOGGLE
if keyboard_check_pressed(vk_f2)
	{
	if window_scale>1
		{
		
		prev_scale=window_scale;
		
		if window_scale==4
		window_set_fullscreen(false);
		
		window_scale--;
		//set window size
		window_set_size(view_width*window_scale,view_height*window_scale);
		alarm[0]=1;
		}
	}
	
if keyboard_check_pressed(vk_f3)
	{
	if window_scale<=3
		{
		prev_scale=window_scale;
		window_scale++;
		//set window size
		window_set_size(view_width*window_scale,view_height*window_scale);
		alarm[0]=1;
		}
		
//if window_scale==4
//		{
//		window_set_fullscreen(true);
//		}
	}
#endregion

#region FULLSCREEN TOGGLE
if keyboard_check_pressed(vk_f4)
	{
	if window_get_fullscreen()==false
		{
		window_set_fullscreen(true);
		}
	else
		{
		window_set_fullscreen(false);
		}
	}
#endregion

#region END GAME KEY
//if escape key is pressed
if (keyboard_check_pressed(vk_escape))
	{
	game_end();	
	}
#endregion

#region MOUSE VIEW DRAG
// MOUSE VIEW DRAGGING (MIDDLE MOUSE BUTTON)
if (inEditor)
	{
    if (mouse_check_button_pressed(mb_middle)) 
        {
        v_drag=true;
        drag_x = mouse_x;
        drag_y = mouse_y;
        }
    // update:
    if (mouse_check_button(mb_middle) && v_drag=true)
        {
        // actual dragging logic:
		camera_set_view_pos(view, clamp(drag_x - (mouse_x - camera_get_view_x(view)),0,room_width-view_width/view_zoom),clamp(drag_y - (mouse_y - camera_get_view_y(view)),0,room_height-view_height/view_zoom));
        }
            
    if mouse_check_button_released(mb_middle)
        {
        v_drag=false;
        }
	}
#endregion

#region DOOR TEST

if (keyboard_check(vk_left))
	{
	/*
	if left_door_x>90
	left_door_x-=1;
	layer_sprite_x(left_door_sprite,left_door_x);
	
	if right_door_x<190
	right_door_x+=1;
	layer_sprite_x(right_door_sprite,right_door_x);
	*/
	}
	
if (keyboard_check(vk_right))
	{
	/*
	if left_door_x<124
	left_door_x+=1;
	layer_sprite_x(left_door_sprite,left_door_x);
	
	if right_door_x>156
	right_door_x-=1;
	layer_sprite_x(right_door_sprite,right_door_x);
	*/
	}
#endregion

#region FADE TEST
if keyboard_check_pressed(ord("F"))
	{
	if !(fade_active)
		{
		fade_active=true;
		alarm[1]=30;
		}
	else
		{	
		}
	}
if (fade_active)
	{
	fade_alpha+=0.1;
	}
#endregion

#region DESTROY INTRO SUFF AND CHANGE PROGRAM STATE

if (keyboard_check_pressed(vk_end))
	{
	//inIntro=false;
	//layer_tilemap_destroy(ws_tileset)
	//layer_destroy(ws_layer);
	//layer_destroy(ws_bkg_layer);
	//layer_destroy(inside_layer);
	//layer_destroy(door_layer);
	//inEditor=true;
	}
#endregion

#region SAVE TILEMAP
if keyboard_check_pressed(vk_insert)
	{
	for (var j=0; j<room_height/16; j++)
	    {
	    for (var i=0; i<room_width/16; i++)
	        {
			tile=tilemap_get_at_pixel(collision_tiles,i*TILE_SIZE,j*TILE_SIZE)
	        if tile!=-1
	            {
	            //var t_left=layer_tilemap_get_id(collision_tiles);
	            ds_grid_set(room_grid,i,j,tile);
	            show_debug_message("TILE ID: "+ string(tile) + "   CELL VALUE: " + string(ds_grid_get(room_grid,i,j)));
	            }
	        else
	            {
	            //show_debug_message("TILE X: 0" + "   TILE Y: 0" + "   CELL VALUE: 00");
	            }
	        }
	    }	
	}
#endregion

#region TOGGLE CURRENT TILE LAYER
if (keyboard_check_pressed(vk_f5))
	{
	if tile_current_layer==0
	tile_current_layer=1;
	else
	if tile_current_layer==1
	tile_current_layer=0
	}
#endregion

#region DETECT IF MOUSE IS AT LEVEL INFO WINDOW

if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),room_info_window_x,room_info_window_y,room_info_window_x+(room_info_window_w+15),room_info_window_y+(room_info_window_h+15))
	{
	canPlace=false;
	show_debug_message("HOVERING OVER INFO WINDOW");
	if mouse_check_button_pressed(mb_left)
		{	
		while (room_info_window_y>display_get_gui_height()-(room_info_window_h+15))
			{
			room_info_window_y=(room_info_window_y-1);
			}
		}
	info_window_alpha=1;
	}
else
	{
	canPlace=true;
	
	while (room_info_window_y<display_get_gui_height()-4)
		{
		room_info_window_y=(room_info_window_y+1);
		}
	
	info_window_alpha=0.5;
	}
#endregion

#region DETECT IF MOUSE IS AT TILE WINDOW
if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),tile_window_x,tile_window_y,tile_window_x+(tile_window_w+15),tile_window_y+(tile_window_h+15))
	{
	canPlace=false;
	var _x, _y;
	_x=floor((device_mouse_x_to_gui(0)-tile_window_x+sprite_get_width(spr_window)-16)/8);
	_y=floor((device_mouse_y_to_gui(0)-tile_window_y+sprite_get_height(spr_window)-24)/8);
	show_debug_message("MOUSE X WITHIN TILE WINDOW: " + string(_x));
	show_debug_message("MOUSE Y WITHIN TILE WINDOW: " + string(_y));
	//show_debug_message("HOVERING OVER TILE WINDOW");
	if (_x>=0 && _x<=15) && (_y>=0 && _y<=15)
		{
		canPick=true;	
		}
	else
		{
		canPick=false;
		}
	
	if mouse_check_button_pressed(mb_left)
		{	
		while (tile_window_x>display_get_gui_width()-(tile_window_w+15))
			{
			tile_window_x=(tile_window_x-1);
			}
		if (canPick)
			{
			current_tile=_x+16*_y;
			}
		}
	}
else
	{
	while (tile_window_x<display_get_gui_width()-4)
		{
		tile_window_x=(tile_window_x+1);
		}
	canPick=false;
	canPlace=true;
	}
#endregion

#region DETECT IF MOUSE IS AT PALETTE WINDOW 

if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),theme_palette_window_x,theme_palette_window_y,theme_palette_window_x+(theme_palette_window_w+15),theme_palette_window_y+(theme_palette_window_h+15))
	{
	if mouse_check_button_pressed(mb_left)
		{	
		while (theme_palette_window_x>display_get_gui_width()-(theme_palette_window_w+15))
			{
			theme_palette_window_x=(theme_palette_window_x-1);
			}
		}
	}
	else
	{
	while (theme_palette_window_x<display_get_gui_width()-4)
		{
		theme_palette_window_x=(theme_palette_window_x+1);
		}
	}

#endregion

#region DETECT IF MOUSE IS AT OBJECT WINDOW
/*
if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),entity_window_x,entity_window_y,entity_window_x+(entity_window_w+15)*2,entity_window_y+(entity_window_h+15)*2)
	{
	canPlace=false;
	}
else
	{
	canPlace=true;
	}
*/
#endregion

#region TILE/OBJECT/COLLISION PLACEMENT
if (inEditor)
	{
	//Set up mouse grid coordinates
	var xx=floor(mouse_x/16)
	var yy=floor(mouse_y/16)
	
	if (canPlace)
		{
		if mouse_check_button_pressed(mb_left)
			{
			if mode==0
				{
				if tile_current_layer==0
					{
					tilemap_set(terrain_tiles_b,0,xx,yy);
					tilemap_set(terrain_tiles_f,current_tile,xx,yy);
					}
				if tile_current_layer==1
					{
					tilemap_set(terrain_tiles_f,0,xx,yy);
					tilemap_set(terrain_tiles_b,current_tile,xx,yy);
					}
				}
			else if mode==1
				{
				tilemap_set(collision_tiles,5,xx,yy);
				}
			}
		}
	}// if inEditor 
#endregion
	
#region GAME RESTART
if (keyboard_check_pressed(ord("R")))
	{
	room_restart();
	}
#endregion