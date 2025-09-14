/// @scr_draw_window(x,y,length,height,round_corners)
/// @param length
/// @param height
/// @param round_corners_if_true
function scr_create_window(argument0, argument1, argument2)
	{
	var xx = 0;
	var yy = 0;
	var length = argument0; //Window Length
	var height = argument1; //Window Height
	var rounded = argument2;//Rounded corners if true, normal if flase
	var window=surface_create(length+16,height+16); //Create surface the size of the window
	var sprite;
	var ltc, rtc, lbc, rbc, i, j;

	if (rounded)
	    {
	    ltc=4;
	    rtc=5;
	    lbc=6;
	    rbc=7;
	    }
	else
	    {
	    ltc=0;
	    rtc=1;
	    lbc=2;
	    rbc=3;
	    }

	surface_set_target(window);

	//BLACK BACKGROUND
	draw_rectangle_color(xx+8,yy+8,length+8,height+8,c_black,c_black,c_black,c_black,false)

	//WINDOW SCREEN
	for(i=0; i<length; i+=2)
	    {
	    for(j=0; j<height; j+=2)
	        {
	        draw_sprite_part_ext(spr_window,12,0,0,2,2,(xx+8)+i,(yy+8)+j,1,1,c_white,1);
	        }
	    }


	//draw top left corner
	draw_sprite_ext(spr_window,ltc,xx,yy,1,1,0,c_white,1);


	//draw top bar
	for(i=0; i<(length); i++)
	    {
	    draw_sprite_part_ext(spr_window,8,0,0,1,8,(xx+8)+i,yy,1,1,c_white,1);
	    }

	//draw top right corner
	draw_sprite_ext(spr_window,rtc,(xx+8)+i,yy,1,1,0,c_white,1);


	//draw side bars
	for(j=0; j<(height); j++)
	    {
	    draw_sprite_part_ext(spr_window,10,0,0,8,1,xx,(yy+8)+j,1,1,c_white,1);
	    draw_sprite_part_ext(spr_window,11,0,0,8,1,(xx+8)+i,(yy+8)+j,1,1,c_white,1);
	    }

	//draw left bottom corner
	draw_sprite_ext(spr_window,lbc,xx,(yy+8)+j,1,1,0,c_white,1);

	for(i=0; i<(length); i++)
	    {
	    draw_sprite_part_ext(spr_window,9,0,0,1,8,(xx+8)+i,(yy+8)+j,1,1,c_white,1);
	    }
    
	draw_sprite_ext(spr_window,rbc,(xx+8)+i,(yy+8)+j,1,1,0,c_white,1);

	sprite=sprite_create_from_surface(window,0,0,length+16,height+16,false,false,0,0);

	surface_reset_target();
	surface_free(window);
	return sprite;
	}