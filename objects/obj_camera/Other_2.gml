/// @description SET UP CAMERA STUFF HERE

view_enabled=true;
view_visible[0]=true;

win_enl_key=vk_add;
win_red_key=vk_subtract;
fulscrn_key=vk_f4;
gui_scale=1;
window_scale=2;


display_set_gui_size(SCREEN_WIDTH*2,SCREEN_HEIGHT*2);
view_camera[0] = camera_create_view(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
#macro view view_camera[0]
window_set_size(SCREEN_WIDTH*window_scale,SCREEN_HEIGHT*window_scale);