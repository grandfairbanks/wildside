/// @description Insert description here
/// @param

mouse_drag_view(); //DRAG CAMERA AROUND ROOM WITH MIDDLE MOUSE BUTTON
 
if keyboard_check_pressed(win_enl_key)
	{
	if window_scale<4
	increase_window_size();
	}
	
if keyboard_check_pressed(win_red_key)
	{
	if window_scale>2
	decrease_window_size();
	}

if keyboard_check_pressed(fulscrn_key)
	{
	if window_get_fullscreen()
		{
		window_set_fullscreen(false);
		display_set_gui_size(640,448);
		}
	else
		{
		window_set_fullscreen(true);
		display_set_gui_size(display_get_gui_width(),display_get_gui_height());
		//display_set_gui_maximize();
		gui_scale=window_scale;//*2;
		}
	}