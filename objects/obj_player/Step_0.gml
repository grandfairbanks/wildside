/// @description Insert description here
// You can write your code in this editor

obj_system.start_x=x;
obj_system.start_y=y;


#region PLATFORMING CODE
if ((keyboard_check(vk_right) - keyboard_check(vk_left)) != 0 )
dir=keyboard_check(vk_right) - keyboard_check(vk_left);

var horizontal = keyboard_check(vk_right) - keyboard_check(vk_left);
var vertical = keyboard_check(vk_down) - keyboard_check(vk_up);

var vx=horizontal*mspd;
var vy=vertical*mspd;

// Move with Collision checks
gridcol_move_speeds(vx,vy);

grav=grav+0.1
if grav > 10
grav=10;

//y=y+grav;
#endregion


p_pal=clamp(p_pal,0,1);

if keyboard_check_pressed(vk_pageup)
	{
	p_pal+=1;
	}
	
if keyboard_check_pressed(vk_pagedown)
	{
	p_pal-=1;
	}