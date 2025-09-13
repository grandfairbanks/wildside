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
		
if window_scale==4
		{
		window_set_fullscreen(true);
		}
	}
#endregion

#region FULLSCREEN TOGGLE
if keyboard_check_pressed(vk_f11)
	{
	fullscreen=!fullscreen;	
	}

if (fullscreen==true)
	{
	display_set_gui_size(display_get_width()/3,display_get_height()/3);
	surface_resize(application_surface,display_get_width(),display_get_height());
	}
else
	{
	display_set_gui_size(view_width*gui_scale,view_height*gui_scale);	
	surface_resize(application_surface,view_width*window_scale,view_height*window_scale);
	}
#endregion

#region THEME TOGGLE
if keyboard_check_pressed(vk_pageup)
	{
	if level_theme<10
	level_theme++;
	scr_update_theme();
	}
if keyboard_check_pressed(vk_pagedown)
	{
	if level_theme>1
	level_theme--;
	scr_update_theme();
	}
#endregion

#region ATTRIBUTE TOGGLE
if keyboard_check_pressed(vk_end)
	{
	if level_attr<7
	level_attr++;
	scr_entity_display();
	}
if keyboard_check_pressed(vk_home)
	{
	if level_attr>0
	level_attr--;
	scr_entity_display();
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

canPlace=true;
canPick=false;

#region DETECT IF MOUSE IS AT LEVEL INFO WINDOW

if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),room_info_window_x,room_info_window_y,room_info_window_x+(room_info_window_w+15),room_info_window_y+(room_info_window_h+15))
	{
	within_rinfo_window=true;	
	}
else
	{
	within_rinfo_window=false;
	}
	
if (within_rinfo_window)
	{
	canPlace=false;
	//show_debug_message("HOVERING OVER INFO WINDOW");
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
	within_tile_window=true;
	}
else
	{
	within_tile_window=false;
	}
	
if (within_tile_window)
	{
	canPlace=false;
	var _x, _y;
	_x=floor((device_mouse_x_to_gui(0)-tile_window_x+(sprite_get_width(spr_window))-16)/8);
	_y=floor((device_mouse_y_to_gui(0)-tile_window_y+(sprite_get_height(spr_window))-24)/8);

	if (_x>=0 && _x<=15) && (_y>=0 && _y<=15)
		{
		canPick=true;	
		}
	else
		{
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
			mode=0;
			}
		}
	}
else
	{
	while (tile_window_x<display_get_gui_width()-4)
		{
		tile_window_x=(tile_window_x+1);
		}
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
if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),entity_window_x,entity_window_y,entity_window_x+(entity_window_w+15),entity_window_y+(entity_window_h+15))
	{
	within_entity_window=true;
	}
else
	{
	within_entity_window=false;	
	}
	
if (within_entity_window)
	{
	canPlace=false
	var _x, _y;
	_x=floor((device_mouse_x_to_gui(0)-entity_window_x+sprite_get_width(spr_window)-16)/8);
	_y=floor((device_mouse_y_to_gui(0)-entity_window_y+sprite_get_height(spr_window)-24)/8);
	
	if (_x>=0 && _x<=8) && (_y>=0 && _y<=1) ^^ (_y>=4 && _y<=6)
		{
		canPick=true;	
		}
		
	if mouse_check_button_pressed(mb_left)
			{	
			while (entity_window_x<(display_get_gui_width()-display_get_gui_width()))
				{
				entity_window_x=(entity_window_x+1);
				}
				
			if (canPick)
				{
				var _sel;
			
				if _y>=4
					{
					if obj_system.level_attr<6
					_sel=_y-2;
					else
					if obj_system.level_attr==6
					entity_selected=45
					else
					if obj_system.level_attr==7
					entity_selected=46
					}
				else
				_sel=_y;
				
				entity_selected=_x+9*_sel;
				mode=1;
				}
			}
	}
else
	{
	while (entity_window_x>(display_get_gui_width()-display_get_gui_width())-entity_window_w-sprite_get_width(spr_window))
		{
		entity_window_x=(entity_window_x-1);
		}
	}
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
					tilemap_set(terrain_tiles_b,0,xx,yy);//delete tile on background layer at the position
					tilemap_set(terrain_tiles_f,current_tile,xx,yy);//add new tile on the foreground at position
					}
				if tile_current_layer==1
					{
					tilemap_set(terrain_tiles_f,0,xx,yy);
					tilemap_set(terrain_tiles_b,current_tile,xx,yy);
					}
				}
			else if mode==1
				{
				if ds_grid_get(entity_grid,xx,yy)==-4 && tilemap_get(collision_layer,xx,yy)==0
					{
					if (entity_selected != 7 && entity_selected != 8 && entity_selected != 16 && entity_selected != 17)
						{
						entity_info_window_visible=false;
						ds_grid_set(entity_grid,xx,yy,new entity());
						var _ent = ds_grid_get(entity_grid,xx,yy);
						_ent.x=xx*TILE_SIZE;
						_ent.y=yy*TILE_SIZE;
						_ent._type=entity_selected;
						_ent.update_entity();
						//tilemap_set(collision_tiles,2,xx,yy);
						}
					else
						{
						if entity_selected == 7
						tilemap_set(collision_tiles,5,xx,yy);
						
						if entity_selected == 8
						tilemap_set(collision_tiles,1,xx,yy);
						
						if entity_selected == 16
						tilemap_set(collision_tiles,3,xx,yy);
						
						if entity_selected ==17
						tilemap_set(collision_tiles,4,xx,yy);
						}
					}
				else
					{
					current_ent=ds_grid_get(entity_grid,xx,yy);
					entity_info_window_visible=true;
					entity_info_window_x= current_ent.x+ 16;
					entity_info_window_y= current_ent.y;
					}
				
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