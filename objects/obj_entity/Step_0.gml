/// @description Insert description here
// You can write your code in this editor
ent_pal=clamp(ent_pal,0,1);

if keyboard_check_pressed(vk_pageup)
	{
	ent_pal+=1;
	}
	
if keyboard_check_pressed(vk_pagedown)
	{
	ent_pal-=1;
	}
	
if keyboard_check_pressed(vk_left)
	{
	dir=-1;
	}
	
if keyboard_check_pressed(vk_right)
	{
	dir=1;
	}
	
if keyboard_check_pressed(vk_up)
	{
	vdir=-1;
	}
	
if keyboard_check_pressed(vk_down)
	{
	vdir=1;
	}