/// @description Insert description here
/// @param
if (keyboard_check_pressed(vk_escape))
	{
	game_end();	
	}
	
#region TILE WINDOW

	#region DETERMINE IF CURSOR IS WITHIN TILE WINDOW
	if (point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),tile_window_x,tile_window_y,tile_window_x+tile_window_w+16,tile_window_y+tile_window_h+16))
		{
		tile_window_active=true;//set status to true indicating mouse cursor is within tile window
		}
	else
		{
		tile_window_active=false;
		tile_window_x=-264;
		tile_window_open=false;
		}
	#endregion
		
	#region DETERMINE IF CURSOR IS WITHIN TILE DISPLAY
	if (point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),tile_window_x+8,tile_window_y+24,tile_window_x+tile_window_w+7,tile_window_y+tile_window_h+7))
		{
		within_tile_display=true;//set status to true indicating mouse cursor is within tile display
		}
	else
		{
		within_tile_display=false;	
		}
	#endregion
			
	#region DETERMINE MOUSE POSITION WITHIN TILE DISPLAY
	if (within_tile_display)
		{
		//MOUSE X POSITION WITHIN THE TILE WINDOW GRID (0-15)
		_tx=floor((device_mouse_x_to_gui(0)-tile_display_x)/16);
		
		//MOUSE Y POSITION WITHIN THE TILE WINDOW GRID (0-15)
		_ty=floor((device_mouse_y_to_gui(0)-tile_display_y+48)/16);
		
		if mouse_check_button_pressed(mb_left)
			{
			current_tile = _tx+16*_ty-48;
			}
		}
	#endregion

	#region IF TILE WINDOW X IS LESS THAN ZERO, WINDOW IS CLOSED
	if tile_window_x>=0
		{
		tile_window_open=true;
		}
	else
		{
		tile_window_open=false;	
		}
	#endregion
	
	#region OPEN THE TILE WINDOW WHEN CLICKED IF NOT OPEN
	if (mouse_check_button_pressed(mb_left) && tile_window_active==true)
			{
			tile_window_x=0;
			tile_window_open=true;
			}
	#endregion
		
#endregion

#region ENTITY WINDOW

	#region DETERMINE IF CURSOR IS WITHIN ENTITY WINDOW
	if (point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),entity_window_x,entity_window_y,entity_window_x+entity_window_w+16,entity_window_y+entity_window_h+16))
		{
		entity_window_active=true;//set status to true indicating mouse cursor is within tile window
		}
	else
		{
		entity_window_active=false;
		entity_window_x=display_get_gui_width()-8;
		entity_window_open=false;
		}
	#endregion
	
	#region DETERMINE IF CURSOR IS WITHIN ENTITY DISPLAY
	if (point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),entity_window_x+8,entity_window_y+24,entity_window_x+entity_window_w+7,entity_window_y+entity_window_h+7))
		{
		within_entity_display=true;//set status to true indicating mouse cursor is within tile display
		}
	else
		{
		within_entity_display=false;
		}
	#endregion
	
	#region DETERMINE MOUSE POSITION WITHIN TILE DISPLAY
	if (within_entity_display)
		{
		//MOUSE X POSITION WITHIN THE TILE WINDOW GRID (0-15)
		_ex=floor((device_mouse_x_to_gui(0)-entity_display_x)/16);
		
		//MOUSE Y POSITION WITHIN THE TILE WINDOW GRID (0-15)
		_ey=floor((device_mouse_y_to_gui(0)-entity_display_y)/16);
		
		if mouse_check_button_pressed(mb_left)
			{
			current_ent = _ex+16*_ey;
			}
		}
	#endregion

	#region OPEN THE ENTITY WINDOW WHEN CLICKED IF NOT OPEN
	if (mouse_check_button_pressed(mb_left) && entity_window_active==true)
			{
			entity_window_x=display_get_gui_width()-(entity_window_w+16);
			entity_window_open=true;
			}
	#endregion
	
#endregion