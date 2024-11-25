/// @description Insert description here
/// @param
#region DRAG CAMERA AROUND ROOM WITH MIDDLE MOUSE BUTTON
mouse_drag_view();
#endregion
 
#region CHANGE WINDOW SIZE
	
	#region INCREASE WINDOW SIZE
	if keyboard_check_pressed(win_enl_key)
		{
		if window_scale<max_window_scale
		{increase_window_size();}
		else if window_scale >= max_window_scale
		{window_set_fullscreen(true);}
		}
	#endregion
	
	#region DECREASE WINDOW SIZE
	if keyboard_check_pressed(win_red_key)
		{
		if window_scale == max_window_scale
		{window_set_fullscreen(false); window_scale=max_window_scale-1;}
		else
		if window_scale>2
		{decrease_window_size();}
		}
	#endregion
	
#endregion

#region FULLSCREEN TOGGLE AND SETTINGS
if keyboard_check_pressed(fulscrn_key)
	{
	if window_get_fullscreen()
		{
		window_set_fullscreen(false);
		//display_set_gui_size(640,448);
		}
	else
		{
		window_set_fullscreen(true);
		//window_set_size(display_get_width(),display_get_height());
		//surface_resize(application_surface,window_width*window_scale,window_height*window_scale);
		
		//surface_resize(application_surface,320,240)
		//gui_scale=window_scale;
		}
	}
#endregion