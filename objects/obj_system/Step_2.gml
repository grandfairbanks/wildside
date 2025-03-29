/// @description Insert description here
// You can write your code in this editor
#region SET VIEW SIZE AND POSITION
//create camera macro
#macro view view_camera[0]

//zoom stuff
view_zoom=clamp(view_zoom,1,view_max_zoom);

if (inIntro)
	{
	var zrate= 0.2;
	var zoom_speed = .1;
	if view_zoom<10
		{
		view_zoom+=keyboard_check(vk_add)*zoom_speed;
		}

		if view_zoom>1
		{
		view_zoom-=keyboard_check(vk_subtract)*zoom_speed;
		}
		
	}
//end zoom stuff

//set view size
camera_set_view_size(view,view_width/view_zoom,view_height/view_zoom);

//center view on player
if ( instance_exists(obj_player) &&  inGame==true )
	{
	//get x offset
	var _x = clamp(obj_player.x-view_width/2,0,room_width-view_width);
	//get y offset
	var _y = clamp(obj_player.y=view_height/2,0,room_height-view_height);
	
	//get current view position x
	var _cur_x = camera_get_view_x(view);
	//get current view position y
	var _cur_y = camera_get_view_y(view);
	
	//set camera follow speed
	_spd =.1;
	
	//set view position
	camera_set_view_pos(view,lerp(_cur_x,_x,_spd),lerp(_cur_y,_y,_spd));
	}
#endregion