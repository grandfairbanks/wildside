function scr_draw_map(){
	for (var i=0; i<ds_list_size(level_windows); i++) {
    var _level_window = ds_list_find_value(level_windows, i);
    var _level_window_x = map_window_x + 100;
    var _level_window_y = map_window_y + 40 + (40*i);
	pal_swap_set(spr_theme_win_pal,THEME.CITY,false);
    if (_level_window != -1 && sprite_exists(_level_window)) {
        draw_sprite(_level_window, 0, _level_window_x, _level_window_y);
    }
	pal_swap_reset();
    scr_text_button(_level_window_x+14, _level_window_y+12,
                    ds_list_find_value(game_map, i));
}
	
}