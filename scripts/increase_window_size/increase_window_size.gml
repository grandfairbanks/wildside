// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function increase_window_size(){
	
window_scale++;
window_set_size(SCREEN_WIDTH*window_scale,SCREEN_HEIGHT*window_scale);
show_debug_message("window_scale: " + string(window_scale));

alarm[0]=1;
}