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
	window_set_fullscreen(false);
	else
	window_set_fullscreen(true);
	}