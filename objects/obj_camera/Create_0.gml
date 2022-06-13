/// @description Insert description here
/// @param

#region CAMERA DRAGGING WITH MOUSE
v_drag=false; //view dragging toggle
drag_x=0; //dragged view x position (while view drag button is pressed)
drag_y=0; //dragged view y position (while view drag button is pressed)
#endregion

#region INITIAL SYSTEM DISPLAY SETTINGS
display_width=display_get_width();//get the display width
display_height=display_get_height();//get the display height
gui_width=display_get_gui_width();
gui_height=display_get_gui_height();
window_width=window_get_width();
window_height=window_get_height();
window_scale=2;
max_window_scale=4;
#endregion

#region VIEW/CAMERA SETTINGS
#macro SCREEN_WIDTH 320
#macro SCREEN_HEIGHT 224
view_width=SCREEN_WIDTH;
view_height=SCREEN_HEIGHT;
old_scale=true;//toggle typical fullscreen behavior
#endregion

#region CREATE CAMERA
view_camera[0] = camera_create_view(0,0,view_width,view_height);
#macro view view_camera[0]
#endregion

gui_scale=2;

window_set_size(SCREEN_WIDTH*window_scale,SCREEN_HEIGHT*window_scale);
surface_resize(application_surface,window_width*window_scale,window_height*window_scale);
display_set_gui_size(SCREEN_WIDTH*2,SCREEN_HEIGHT*2);


