// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mouse_drag_view(){
	
#region MOUSE VIEW DRAG
	if !(obj_game.inGame)
		//{
		//IF LEFT MOUSE BUTTON IS CLICKED
	    if (mouse_check_button_pressed(mb_middle)) 
	        {
			//ENABLE VIEW DRAGGING WITH MOUSE
	        v_drag=true;
			//VIEW DRAGGING COORDINATE SETUP
	        drag_x = mouse_x;
	        drag_y = mouse_y;
	        }
	    // update:
	    if (mouse_check_button(mb_middle) && v_drag==true)
	        {
	        // actual dragging logic:
			camera_set_view_pos(view, clamp(drag_x - (mouse_x - camera_get_view_x(view)),0,room_width-SCREEN_WIDTH),clamp(drag_y - (mouse_y - camera_get_view_y(view)),0,room_height-SCREEN_HEIGHT));
	        }
            
	    if mouse_check_button_released(mb_middle)
	        {
	        v_drag=false;
	        }
		//}
	#endregion
}