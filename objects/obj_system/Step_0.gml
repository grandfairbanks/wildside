/// @description Insert description here
// You can write your code in this editor

#region EDITOR

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
		
			if window_scale==window_max_scale
			window_set_fullscreen(false);
		
			window_scale--;
			//set window size
			window_set_size(view_width*window_scale,view_height*window_scale);
			alarm[0]=1;
			}
		}
	
	if keyboard_check_pressed(vk_f3)
		{
		if window_scale<=window_max_scale-1
			{
			prev_scale=window_scale;
			window_scale++;
			//set window size
			window_set_size(view_width*window_scale,view_height*window_scale);
			alarm[0]=1;
			}
		
		if window_scale==window_max_scale
			{
			window_set_fullscreen(true);
			//display_set_gui_size(1280,896);
			}
		}
	#endregion

	#region FULLSCREEN TOGGLE

	if keyboard_check_pressed(vk_f11)
		{
		//if (window_get_fullscreen())
		//	{
		//	window_set_fullscreen(false);
		//	}
		//else
		//	{
		//	window_set_fullscreen(true);	
		//	}
		}

	if (window_get_fullscreen())
		{
		//prev_scale=window_scale;
		//window_scale=window_max_scale;
		//display_set_gui_size(1280,896);
	//	display_set_gui_size(display_get_width()/3,display_get_height()/3);
	//	surface_resize(application_surface,display_get_width(),display_get_height());
		}
	else
		{
		//window_scale=
		//display_set_gui_size(320,224);
	//	display_set_gui_size(view_width*gui_scale,view_height*gui_scale);	
	//	surface_resize(application_surface,view_width*window_scale,view_height*window_scale);
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

	#region SAVE LEVEL
		// Check if Ctrl is held AND S is pressed
		if ((keyboard_check(vk_control) || keyboard_check(vk_lcontrol) || keyboard_check(vk_rcontrol)) 
	    && keyboard_check_pressed(ord("S"))) 
			{
		    save_level();
			}
	#endregion

	#region LOAD LEVEL
	// Check if Ctrl is held AND S is pressed
	if ((keyboard_check(vk_control) || keyboard_check(vk_lcontrol) || keyboard_check(vk_rcontrol)) 
	&& keyboard_check_pressed(ord("L"))) 
		{
		fromload=1;
		load_window_opened=true;
		}
	#endregion

	#region END LEVEL
	if ((keyboard_check(vk_control) || keyboard_check(vk_lcontrol) || keyboard_check(vk_rcontrol)) 
	&& keyboard_check_pressed(ord("E"))) 
		{
		endlvl_active=true;
		}
	#endregion
	
	#region OPEN MAP LIST SCREEN
	// Check if Ctrl is held AND S is pressed
	if ((keyboard_check(vk_control) || keyboard_check(vk_lcontrol) || keyboard_check(vk_rcontrol)) 
	&& keyboard_check_pressed(ord("M"))) 
		{
		map_list_window_visible=true;
		}
	#endregion
	
	#region MAP LIST SCREEN FUNCTIONS
	if (within_map_list_window)
		{
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
	
#endregion



#region GAME

	#region END LEVEL FUNCTIONS
	if (inGame)
		{
	
		}
	
	if (endlvl_active) 
		{
		//layer_set_visible(collision_layer,true);
		end_level();
		}
	#endregion

#endregion


#region Zoom

#endregion



#region WILDSIDE DOORS TEST (INTRO)

if (keyboard_check(vk_left))
	{
	if (inIntro)
		{
		if left_door_x>90
		left_door_x-=1;
		layer_sprite_x(left_door_sprite,left_door_x);
	
		if right_door_x<190
		right_door_x+=1;
		layer_sprite_x(right_door_sprite,right_door_x);
		}
	}
	
if (keyboard_check(vk_right))
	{
	if (inIntro)
		{
		if left_door_x<124
		left_door_x+=1;
		layer_sprite_x(left_door_sprite,left_door_x);
	
		if right_door_x>156
		right_door_x-=1;
		layer_sprite_x(right_door_sprite,right_door_x);
		}
	}
#endregion

#region FADE TEST
if (keyboard_check(vk_control) || keyboard_check(vk_lcontrol) || keyboard_check(vk_rcontrol)) && keyboard_check_pressed(ord("F"))
	{
	if !(fade_active)
		{
		fade_active=true;
		audio_play_sound(Teleport,1,false)
		alarm[1]=180;
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
	if (inIntro==true)
		{
		inIntro=false;
		layer_tilemap_destroy(ws_tileset)
		layer_destroy(ws_layer);
		layer_destroy(ws_bkg_layer);
		layer_destroy(inside_layer);
		layer_destroy(door_layer);
		inEditor=true;
		}
	}
#endregion

canPlace=true;
canPick=false;

	#region DETECT IF MOUSE IS AT MAP LIST WINDOW
	if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),map_list_window_x,map_list_window_y,map_list_window_x+(map_list_window_w+15),map_list_window_y+(map_list_window_h+15))
		{
		within_map_list_window=true;	
		}
	else
		{
		within_map_list_window=false;
		}
	#endregion

#region LEVEL INFO WINDOW
	#region DETECT IF MOUSE IS AT LEVEL INFO WINDOW
	if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),room_info_window_x,room_info_window_y,room_info_window_x+(room_info_window_w+15),room_info_window_y+(room_info_window_h+15))
		{
		within_rinfo_window=true;	
		}
	else
		{
		within_rinfo_window=false;
		}
	#endregion

	#region LEVEL INFO WINDOW FUNCTIONS
	if (within_rinfo_window)
		{
		canPlace=false;
	
		#region EXPAND THE WINDOW WHEN CLICKED
		if mouse_check_button_pressed(mb_left)
			{	
			while (room_info_window_y>display_get_gui_height()-(room_info_window_h+15))
				{
				room_info_window_y=(room_info_window_y-1);
				}
			}
		#endregion	
	
		#region EDIT LEVEL NAME
		if (name_edit_active) 
			{
			var ch = keyboard_lastchar;
			if (ch != "") 
				{
			    if (ord(ch) == vk_backspace) 
					{
			        if (string_length(level_name) > 0)
			        level_name = string_delete(level_name, string_length(level_name), 1);
					keyboard_lastchar="";
			        }
			    else if (ord(ch) >= 32 && ord(ch) <= 126) // printable chars
					{ 
			        if (string_length(level_name) < 30) 
						{
			            level_name += ch;
						keyboard_lastchar="";
			            }
			        }
			    }
			
				if keyboard_check(vk_enter)
					{
					level_name = level_name;
					name_edit_active=false;
					}
			}
		#endregion
	
		#region EDIT LEVEL PAR
		if (par_edit_active) 
			{
			var ch = keyboard_lastchar;
			if (ch != "") 
				{
			    if (ord(ch) == vk_backspace) 
					{
			        if (string_length(par_text) > 0)
			        par_text = string_delete(par_text, string_length(par_text), 1);
					keyboard_lastchar="";
			        }
			    else if (ord(ch) >= ord("0") && ord(ch) <= ord("9")) // printable chars
					{ 
			        if (string_length(par_text) < 5) 
						{
			            par_text += ch;
						keyboard_lastchar="";
			            }
			        }
			    }
			
				if keyboard_check(vk_enter)
					{
					level_par = real(par_text)
					par_edit_active=false;
					}
			}
		#endregion
	
		info_window_alpha=1;
		}
	else
		{
		#region RETRACT WINDOW IF MOUSE LEAVES WINDOW AREA
		while (room_info_window_y<display_get_gui_height()-4)
			{
			room_info_window_y=(room_info_window_y+1);
			}
	
		info_window_alpha=0.5;
		#endregion
		}
	#endregion
#endregion

#region TILE WINDOW

#region DETECT IF MOUSE IS AT TILE WINDOW
if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),tile_window_x,tile_window_y,tile_window_x+(tile_window_w+15),tile_window_y+(tile_window_h+15))
	{
	within_tile_window=true;
	}
else
	{
	within_tile_window=false;
	}
#endregion

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
			
		//open the window by moving it right from offscreen
		while (tile_window_x>display_get_gui_width()-(tile_window_w+15))
			{
			tile_window_x=(tile_window_x-1);
			}
		
		if (canPick)
			{
			current_tile=_x+16*_y;
			layer_set_visible(collision_layer,false);
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

#region OBJECT WINDOW
#region DETECT IF MOUSE IS AT OBJECT WINDOW
if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),entity_window_x,entity_window_y,entity_window_x+(entity_window_w+15),entity_window_y+(entity_window_h+15))
	{
	within_entity_window=true;
	}
else
	{
	within_entity_window=false;	
	}
#endregion	

if (within_entity_window)
	{
	canPlace=false
	
	#region DETERMINE MOUSE X/Y POSITION WITHIN ENTITY GRIDS AND ALLOW ENTITY SELECTION
	var _x, _y;
	_x=floor((device_mouse_x_to_gui(0)-entity_window_x+sprite_get_width(spr_window)-16)/8);
	_y=floor((device_mouse_y_to_gui(0)-entity_window_y+sprite_get_height(spr_window)-24)/8);
	
	if (_x>=0 && _x<=8) && (_y>=0 && _y<=1) ^^ (_y>=4 && _y<=6)
		{
		canPick=true;	
		}
	#endregion
	
	if mouse_check_button_pressed(mb_left)
		{	
		#region OPEN ENTITY WINDOW
		while (entity_window_x<(display_get_gui_width()-display_get_gui_width()))
			{
			entity_window_x=(entity_window_x+1);
			}
		#endregion
		
		#region PICK ENTITIES WITH MOUSE
		if (canPick)
			{
			var _sel;

		    // Normal block/collision selection (0–15)
		    if (_y < 4) 
				{
		        _sel = _y;
		        entity_selected = _x + 9 * _sel;
				}
		    else 
				{
		        // For other selections
		        if (obj_system.level_attr < 6)
					{
		            _sel = _y - 2;
		            entity_selected = _x + 9 * _sel;
					}
		        else if (obj_system.level_attr == 6)
					{
		            entity_selected = 45;
					}
		        else if (obj_system.level_attr == 7)
					{
		            entity_selected = 46;
					}
				}
				mode = 1;
			}
			#endregion
		}
	}
else
	{
	#region CLOSE WINDOW WHEN MOUSE IS OUTSIDE WINDOW
	while (entity_window_x>(display_get_gui_width()-display_get_gui_width())-entity_window_w-sprite_get_width(spr_window))
		{
		entity_window_x=(entity_window_x-1);
		}
	#endregion
	}
#endregion	

#region DETECT IF MOUSE IS AT OBJECT INFO WINDOW
if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),entity_info_window_x,entity_info_window_y,entity_info_window_x+(entity_info_window_w+15),entity_info_window_y+(entity_info_window_h+15))
	{
	within_entity_info_window=true;
	}
else
	{
	within_entity_info_window=false;	
	}
	
if (within_entity_info_window)
	{
	canPlace=false
	if mouse_check_button_pressed(mb_left)
		{	
		#region OPEN ENTITY INFO WINDOW
		while (entity_info_window_x<(display_get_gui_width()-display_get_gui_width()))
			{
			entity_info_window_x=(entity_info_window_x+1);
			}
		#endregion
		}
	}
else
	{
		
	}

#endregion

#region TURN ON COLLISION LAYER IF COLLISION TILES SELECTED
if (within_entity_window)
	{
	if entity_selected==7 || entity_selected==8 || entity_selected==16 || entity_selected==17
		{
		layer_set_visible(collision_layer,true);
		layer_depth(collision_layer,-2)
		}
	else
		{
		layer_set_visible(collision_layer,false);
		layer_depth(collision_layer,2)
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
				if ds_grid_get(entity_grid,xx,yy)==255// && tilemap_get(collision_layer,xx,yy)==0
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
						
						if (_ent._type>=0 && _ent._type<=6) || (_ent._type>=9 && _ent._type<=14)
							{
							tilemap_set(collision_tiles,2,xx,yy);
							
							if _ent._type==11//horizontal platform
								{
								var _i;
								if _ent.var2>0
									{
									for(_i=0; _i<_ent.var2; _i++)
										{
										tilemap_set(collision_tiles,2,xx+_i,yy);
										}
									}
								tilemap_set(collision_tiles,2,xx+_ent.var2,yy);
								}
							
							if _ent._type==14
							tilemap_set(collision_tiles,2,xx+1,yy);
							}
						}
					else
						{
						if entity_selected == 7
							{
							tilemap_set(collision_tiles,5,xx,yy);
							}
						
						if entity_selected == 8
							{
							tilemap_set(collision_tiles,1,xx,yy);
							}
						
						if entity_selected == 16
							{
							tilemap_set(collision_tiles,3,xx,yy);
							}
						
						if entity_selected ==17
							{
							tilemap_set(collision_tiles,4,xx,yy);
							}
						}
					}
				else
					{
					current_ent=ds_grid_get(entity_grid,xx,yy);
					if current_ent!=255
						{
						entity_info_window_visible=true;
						entity_info_window_x=0;
						//entity_info_window_y= current_ent.y;
						}	
					}
				}
			}
		if mouse_check_button_pressed(mb_right)
			{
			if mode==1
				{
				if ds_grid_get(entity_grid,xx,yy)==255// && tilemap_get(collision_layer,xx,yy)==0
					{
					tilemap_set(collision_tiles,0,xx,yy)
					}
				else
					{
					ds_grid_set(entity_grid,xx,yy,255);	
					tilemap_set(collision_tiles,0,xx,yy)
					}
				}
			}
		}
	}// if inEditor 
#endregion
	
#region GAME RESTART
if (keyboard_check(vk_control) || keyboard_check(vk_lcontrol) || keyboard_check(vk_rcontrol)) && keyboard_check_pressed(ord("R"))
	{
	//room_restart();
	}
#endregion