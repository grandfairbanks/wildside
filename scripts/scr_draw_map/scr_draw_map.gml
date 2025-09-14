function scr_draw_map(){
var _yy=0, _xx=0, _level_window_x, _level_window_y;
for (var _i=0; _i<ds_list_size(game_map); _i++)
	{
	//GET LEVEL NAME STRING FROM LIST
	var str=ds_list_find_value(game_map,_i);
	//GET THE WIDTH OF THE STRING
	var strw=string_width(str);
	//CREATE WINDOW LARGE ENOUGH FOR STRING
	var _level_window=scr_create_window((strw-1)+12,16,true);
	_level_window_x=map_window_x+100;
	_level_window_y=map_window_y+40+(40*_yy);
	
	///THIS PART RESERVED FOR FILE DATA LOOKUP (NAME, THEME, FLAGS, TELEPORTERS, ETC)
	
	///
	
	//TURN ON LEVEL PALETTE
	pal_swap_set(spr_theme_win_pal,THEME.DESERT,false);
	
	//DRAW LEVEL NAME WINDOW
	draw_sprite(_level_window,0,_level_window_x,_level_window_y)
	//TURN OFF LEVEL PALETTE
	pal_swap_reset();
	//DRAW LEVEL NAME STRING
	scr_text_button(_level_window_x+14,_level_window_y+12,str);
	_yy++;
	draw_sprite_stretched(spr_window,10,_level_window_x+14,_level_window_y+8,8,8)
	}
}