/// @description Insert description here
/// @param

//var gui_scale=obj_camera.gui_scale

#region DRAW TILE WINDOW AND TILE DISPLAY
var str="TILES";
var strw=string_width(str);

draw_sprite(spr_tile_window,0,tile_window_x,tile_window_y);//DRAW TILE WINDOW

draw_text_transformed(tile_window_x+tile_window_w/2-strw,tile_window_y+8,string(str),2,2,0);//TILES TEXT

if tile_window_open==true
draw_sprite(spr_tile_display,0,tile_window_x+8,tile_window_y+24);

if (DEBUG)
	{
	draw_text_transformed(tile_window_x,tile_window_y+tile_window_h+16,string(current_tile),2,2,0);//TILES TEXT
	}
#endregion

#region DRAW ENTITY WINDOW

str = "BLOCKS";
var strw=string_width(str);
draw_sprite(spr_entity_window,0,entity_window_x,entity_window_y);
draw_text_transformed(entity_window_x+entity_window_w/2-strw,entity_window_y+8,string(str),2,2,0);

str = "ENEMIES";
var strw=string_width(str);
draw_text_transformed(entity_window_x+entity_window_w/2-strw,entity_window_y+56,string(str),2,2,0);

draw_sprite(spr_entity_display,0,entity_window_x+8,entity_window_y+24);

if (DEBUG)
	{
	draw_text_transformed(entity_window_x,entity_window_y+entity_window_h+16,string(current_ent),2,2,0);//TILES TEXT
	}

#endregion

#region DRAW TILE/OBJECT SELECTION CURSOR
if (within_tile_display==true && tile_window_open==true)
	{
	draw_set_alpha(0.5);
	draw_rectangle_color((_tx*TILE_SIZE)+8,(_ty*TILE_SIZE)+8,_tx*TILE_SIZE+23,_ty*TILE_SIZE+23,c_white,c_white,c_white,c_white,false);
	draw_set_alpha(1);
	}
	
if (within_entity_display==true && entity_window_open==true)
	{
	draw_set_alpha(0.5);
	draw_rectangle_color((_ex*TILE_SIZE)+8,(_ey*TILE_SIZE)+8,_ex*TILE_SIZE+23,_ey*TILE_SIZE+23,c_white,c_white,c_white,c_white,false);
	draw_set_alpha(1);
	}
#endregion