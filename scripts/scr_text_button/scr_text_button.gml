///scr_text_button(x,y,text to display)
function scr_text_button(argument0, argument1, argument2) 
	{
	var xx, yy, text, hover, txt_width, txt_height, clicked, right;

	xx=argument0
	yy=argument1
	text=argument2
	txt_width=string_width(text)
	txt_height=string_height(text)
	hover=(device_mouse_x_to_gui(0) >= xx && device_mouse_x_to_gui(0) <= xx + txt_width && device_mouse_y_to_gui(0) >= yy && device_mouse_y_to_gui(0) <= yy + txt_height);
	clicked=false;
	right=false;
	
	#region DRAW TEXT
	if (hover)
		{
		pal_swap_set(pal_font,2,false);//draw highlighted text using shader
		draw_text(xx,yy,text) //draw unhighlighted text
		pal_swap_reset(); //reset shader
		}
	else
		{
		draw_text(xx,yy,text);
		}
	#endregion
	
	#region INTERACTIVITY
	if (hover)
		{
		if mouse_check_button_pressed(mb_left)
			{
			//left mouse click events go here
			clicked=true;
			}
    
		if mouse_check_button_pressed(mb_right)
			{
			//right mouse click events go here
			right=true;
			}
		}	
	#endregion
	
	return 
		{
	    hover: hover,
	    clicked: clicked,
	    right: right,
	    text: text
		};
	}

