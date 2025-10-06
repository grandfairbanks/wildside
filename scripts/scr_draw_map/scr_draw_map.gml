function scr_draw_map()
	{
	show_debug_message("scr_draw_map() called");
	for (var i=0; i<ds_list_size(level_windows); i++) 
		{
	    var _level_window = ds_list_find_value(level_windows, i);
	    var _level_window_x = map_window_x + 100;
	    var _level_window_y = map_window_y + 40 + (40*i);
		
		var _buf = undefined;
		var _filename = ds_list_find_value(map_list, i)
		var _filepath = "levels/" + string(_filename);
		show_debug_message("_FILEPATH: " + string(_filepath));
		show_debug_message("_FILENAME: " + string(_filename));
		
		if (!file_exists(_filepath)) || _filename=="UNUSED"
			{
			show_debug_message("FILE NOT FOUND FOR LEVEL MAP");
			exit;
			}
		else
			{
			show_debug_message("FILE FOUND FOR LEVEL MAP");
			var _buf = buffer_load(_filepath);
			buffer_seek(_buf,buffer_seek_start,0);
				
			var _num = buffer_read(_buf,buffer_u32);
				
			var _name_chars = "";
			for (var _i = 1; _i <= 30; _i++) 
				{
			    var _c = buffer_read(_buf, buffer_u8);
			    if (_c != 0) _name_chars += chr(_c);
				}
				
			var _name = _name_chars;
			var _level_x = buffer_read(_buf, buffer_u16);
			var _level_y = buffer_read(_buf, buffer_u16);
			var _theme = buffer_read(_buf, buffer_u8);
			var _attr  = buffer_read(_buf, buffer_u8);
			var _par   = buffer_read(_buf, buffer_u16);
			var _bonus  = buffer_read(_buf, buffer_u16);
			
			show_debug_message("LEVEL NAME " + string(_name));
			show_debug_message("LEVEL THEME " + string(_theme));
			
			var _tiles_x = _level_x*SCREEN_WIDTH div 16;
			var _tiles_y = _level_x*SCREEN_HEIGHT div 16;
			
			for (var _y = 0; _y < _tiles_y; _y++) 
			{
	        for (var _x = 0; _x < _tiles_x; _x++) 
				{
				var _coll = buffer_read(_buf, buffer_u8);
				//tilemap_set(collision_tiles, _coll, _x, _y);
				var _bg = buffer_read(_buf, buffer_u8); 
				//tilemap_set(terrain_tiles_b, _bg, _x, _y);
				var _fg = buffer_read(_buf, buffer_u8); 
				//tilemap_set(terrain_tiles_f, _fg, _x, _y);
			
	            var _type   = buffer_read(_buf, buffer_u8);
	            var _sprite = buffer_read(_buf, buffer_u8);
	            var _v1     = buffer_read(_buf, buffer_u8);
	            var _v2     = buffer_read(_buf, buffer_u8);
	            var _v3     = buffer_read(_buf, buffer_u8);
	            var _v4     = buffer_read(_buf, buffer_u8);
	            var _v5     = buffer_read(_buf, buffer_u8);

	            if (_type == 255) 
					{
	                // Keep cell as empty
	                //ds_grid_set(entity_grid, _x, _y, 255);
					} 
					
				else if _type==14 //teleporter detected
					{
					show_debug_message("TELEPORTER DETECTED IN LEVEL");
					}
				
				else if _type==15
					{
					show_debug_message("FLAG DETECTED IN LEVEL");
					}
			}
			

			}
		
		pal_swap_set(spr_theme_win_pal,_theme,false);
		if (_level_window != -1 && sprite_exists(_level_window)) 
			{
			draw_sprite(_level_window, 0, _level_window_x, _level_window_y);
			}
		pal_swap_reset();
		scr_text_button(_level_window_x+14, _level_window_y+12,_name);
		}	
	}}