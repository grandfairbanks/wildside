///scr_text_button(x,y,text to display)
function scr_text_button(argument0, argument1, argument2) {
	var xx, yy, text, txt_width, txt_height;

	xx=argument0
	yy=argument1
	text=argument2

	txt_width=string_width(text)
	txt_height=string_height(text)

	//if mouse if NOT within box defined below
	if device_mouse_x_to_gui(0) > xx+txt_width || device_mouse_y_to_gui(0) > yy+txt_height || device_mouse_x_to_gui(0) <xx || device_mouse_y_to_gui(0) < yy
		{
		draw_text(xx,yy,text) //draw unhighlighted text
		}
	else
		{
		pal_swap_set(pal_font,2,false)//draw highlighted text using shader
		draw_text(xx,yy,text)
		pal_swap_reset(); //reset shader

		if mouse_check_button_pressed(mb_left)
		    {
		//left mouse click events go here
		return 0;
		    }
		    else
		    {
			}
    
		if mouse_check_button_pressed(mb_right)
		    {
		//right mouse click events go here
		return 1;
		    }
		    else
		    {
			}
		}
	return -1


}
