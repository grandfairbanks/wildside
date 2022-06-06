/// @description Insert description here
/// @param
//center view on player
if ( instance_exists(obj_player) && inGame==true)//
	{
	//get x offset
	var _x = clamp(obj_player.x-view_width/2,0,room_width-view_width);
	//get y offset
	var _y = clamp( (obj_player.y-15)-view_height/2,0,room_height-view_height);
	
	//get current view position x
	var _cur_x = camera_get_view_x(view);
	//get current view position y
	var _cur_y = camera_get_view_y(view);
	
	//set camera follow speed
	_spd =.1;
	
	//set view position
	camera_set_view_pos(view,lerp(_cur_x,_x,_spd),lerp(_cur_y,_y,_spd));
	}