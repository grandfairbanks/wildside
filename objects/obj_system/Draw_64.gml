/// @description Insert description here
// You can write your code in this editor



#region EDITOR STUFF

	#region DRAW CURRENT TILE LAYER
	var tile_layer_txt;
	switch(tile_current_layer)
		{
		case 0: tile_layer_txt="Foreground"; break;
		case 1: tile_layer_txt="Background"; break;
		}
	draw_text_transformed(0,0,"Current Tile Layer: " + string(tile_layer_txt),1,1,0);
	#endregion

	#region DRAW LEVEL INFO WINDOW
	draw_set_alpha(info_window_alpha);
	draw_sprite_ext(room_info_window,0,room_info_window_x,room_info_window_y,1,1,0,c_white,1);
	
		#region DRAW LEVEL INFO
		
		//attribute readable output
		switch(level_attr)
			{
			case 0: attr_out="Normal"; break;	
			case 1: attr_out="Lava"; break;	
			case 2: attr_out="Storm"; break;	
			case 3: attr_out="Hail"; break;	
			case 4: attr_out="Chase"; break;	
			case 5: attr_out="Elsewhere"; break;	
			case 6: attr_out="Boss"; break;
			case 7: attr_out="Final"; break;	
			}

		//theme readable output
		switch(level_theme)
			{
			 default:
			 case 0: theme_out=""; break;
			 case 1: theme_out="Sky"; break;
			 case 2: theme_out="Ice"; break;
			 case 3: theme_out="Hills"; break;
			 case 4: theme_out="Isle"; break;
			 case 5: theme_out="Desert"; break;
			 case 6: theme_out="Swamp"; break;
			 case 7: theme_out="Mountain"; break;
			 case 8: theme_out="Cave"; break;
			 case 9: theme_out="Woods"; break;
			case 10: theme_out="City"; break;
			}
		var txt_x=9, txt_x2=112;
		//DRAW WINDOW TITLE
		draw_text(room_info_window_x+48,room_info_window_y+9,"LEVEL INFORMATION");
		//DRAW NAME OF LEVEL
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+24,"NAME: " + string(level_name),1,1,0);
		//DRAW WIDTH OF LEVEL (IN SCREENS)
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+36,"X SCREENS: " + string(level_x),1,1,0);
		//DRAW HEIGHT OF LEVEL (IN SCREENS)
		draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+36,"Y SCREENS: " + string(level_y),1,1,0);
		//DRAW THEME OF LEVEL (IN SCREENS)
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+48,"THEME: " + string(theme_out),1,1,0);
		//DRAW LEVEL ATTRIBUTE
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+60,"TYPE: " + string(attr_out),1,1,0);
		
		if (instance_exists(obj_player))
			{
			pal_swap_set(pal_font,3,false);
			//DRAW STARTING X POSITION
			scr_text_button(room_info_window_x+txt_x,room_info_window_y+72,"START X: " + string(start_x));
			//DRAW STARTING Y POSITION
			draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+72,"START Y: " + string(start_y),1,1,0);
			pal_swap_reset();
			}
		else
			{
			var _notset="";
			pal_swap_set(pal_font,4,false)
			//DRAW STARTING X POSITION
			draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+72,"START X: " + string(_notset),1,1,0);
			//DRAW STARTING Y POSITION
			draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+72,"START Y: " + string(_notset),1,1,0);
			pal_swap_reset();
			}
			
		if (flag_exists)
			{
			pal_swap_set(pal_font,3,false);
			//DRAW STARTING X POSITION
			scr_text_button(room_info_window_x+txt_x,room_info_window_y+72,"START X: " + string(start_x));
			//DRAW STARTING Y POSITION
			draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+72,"START Y: " + string(start_y),1,1,0);
			pal_swap_reset();
			}
		else
			{
			var _notset="";
			pal_swap_set(pal_font,4,false)
			//DRAW STARTING X POSITION
			draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+72,"START X: " + string(_notset),1,1,0);
			//DRAW STARTING Y POSITION
			draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+72,"START Y: " + string(_notset),1,1,0);
			pal_swap_reset();
			}
		
		//DRAW FLAG X POSITION
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+84,"END X: " + string(end_x),1,1,0);
		//DRAW FLAG Y POSITION
		draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+84,"END Y: " + string(end_y),1,1,0);
		//DRAW LEVEL PAR
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+96,"LEVEL PAR: " + string(level_par),1,1,0);
		//DRAW PATH BONUS
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+108,"PATH BONUS: " + string(path_bonus),1,1,0);
	#endregion
		
	draw_set_alpha(1);
	#endregion

	#region DRAW TILE WINDOW
	draw_sprite(tile_window,0,tile_window_x,tile_window_y);
	
	draw_text(tile_window_x+32,tile_window_y+8,"LEVEL TILES");
	
	if !surface_exists(tile_theme_surface) 
		{
		scr_tile_display();
		}
	else 
		{
		draw_surface_ext(tile_theme_surface,tile_window_x+sprite_get_width(spr_window),tile_window_y+sprite_get_width(spr_window)*2,0.5,0.5,0,c_white,1);
		//draw_surface_stretched(tile_theme_surface,tile_window_x+sprite_get_width(spr_window),tile_window_y+sprite_get_width(spr_window)*2+1,128,128);
		}
		
	#region DRAW TILE CURSOR
	if (canPick==true) && (within_tile_window==true)
		{
		var xx=floor(device_mouse_x_to_gui(0)/(TILE_SIZE/2))*TILE_SIZE/2;
		var yy=floor(device_mouse_y_to_gui(0)/(TILE_SIZE/2))*TILE_SIZE/2;
		draw_set_alpha(0.5);
		draw_rectangle_color(xx+1,yy,xx+8,yy+7,c_white,c_white,c_white,c_white,false);
		draw_text(xx+1,yy+1,current_tile);
		draw_set_alpha(1);
		}
		else
		{	
		}
	#endregion
	#endregion
	
	#region THEME PALETTE WINDOW
	theme_palette_window_x=tile_window_x
	draw_sprite(theme_palette_window,0,theme_palette_window_x,theme_palette_window_y);
	draw_text(theme_palette_window_x+sprite_get_width(spr_window)+16,theme_palette_window_y+9,"THEME PALETTES");
	draw_text(theme_palette_window_x+sprite_get_width(spr_window),theme_palette_window_y+20,"FOREGROUND PALETTE");
	draw_text(theme_palette_window_x+sprite_get_width(spr_window),theme_palette_window_y+40,"BACKGROUND PALETTE");
	
	if level_theme!=-1
		{
		//draw foreground palette
		pal_swap_draw_palette_h(spr_theme_pal,level_theme-1,theme_palette_window_x+sprite_get_width(spr_window),theme_palette_window_y+36);
		//draw background palette
		pal_swap_draw_palette_h(spr_theme_bkg_pal,level_theme-1,theme_palette_window_x+sprite_get_width(spr_window),theme_palette_window_y+56);
		}
	#endregion
	
	#region ENTITY WINDOW
	draw_sprite(entity_window,0,entity_window_x,entity_window_y);
		if surface_exists(ent_display_surface) 
		{
		//draw block menu text
		draw_text(entity_window_x+sprite_get_width(spr_window)+16,entity_window_y+sprite_get_height(spr_window)+1,"BLOCKS");
		//draw entity display
		draw_surface_ext(ent_display_surface,entity_window_x+sprite_get_width(spr_window),entity_window_y+sprite_get_width(spr_window)*2+1,0.5,0.5,0,c_white,1);
		//draw enemy menu text
		var _en_txt;
		if level_attr <6
		_en_txt="ENEMIES";
		else
		if level_attr ==6
		_en_txt="BOSS";
		else
		if level_attr ==7
		_en_txt="FINAL BOSS";
		
		draw_text((entity_window_x+8)+(entity_window_w/2)-(string_width(_en_txt)/2),entity_window_y+sprite_get_height(spr_window)+33,string(_en_txt));
		
		#region DRAW ENTITY CURSOR
		if (canPick==true) && (within_entity_window==true)
			{
			var xx=floor(device_mouse_x_to_gui(0)/(TILE_SIZE/2))*TILE_SIZE/2;
			var yy=floor(device_mouse_y_to_gui(0)/(TILE_SIZE/2))*TILE_SIZE/2;
			draw_set_alpha(0.5);
			draw_rectangle_color(xx,yy+1,xx+7,yy+8,c_white,c_white,c_white,c_white,false);
			draw_text(xx+1,yy+1,entity_selected);
			draw_set_alpha(1);
			}
		else
			{	
			}
	#endregion
		}
	else 
		{
		scr_entity_display();
		}
	#endregion

	#region ENTITY INFO WINDOW
	if (entity_info_window_visible==true)
	{
	draw_sprite(spr_entity_info_window,0,entity_info_window_x,entity_info_window_y);
	draw_text(entity_info_window_x+4,entity_info_window_y+4,string(current_ent.name))
	draw_text(entity_info_window_x+4,entity_info_window_y+16,current_ent.opt1 + " " + string(current_ent.var1))
	}
	#endregion

#endregion

#region GAME STUFF

	#region DRAW HUD
	
	#endregion

	#region SCREEN FADE
	if (fade_active)
		{
		draw_set_alpha(fade_alpha);
		draw_rectangle_color(0,0,display_get_width(),display_get_height(),fade_color,fade_color,fade_color,fade_color,false);
		draw_set_alpha(1);
		}
	#endregion
	
#endregion

#region DRAW MAP

//var str="ELSEWHERE";
//var strw=string_width(str);
//var test_window=scr_create_window((strw-1)+12,16,true);
//pal_swap_set(spr_theme_win_pal,THEME.DESERT,false);
//draw_sprite(test_window,0,100,64)
//pal_swap_reset();
//scr_text_button(114,76,str);


//var str2="ELSEWHERE 23";
//var strw=string_width(str2);
//var test_window2=scr_create_window((strw-1)+12,16,true);
//pal_swap_set(spr_theme_win_pal,THEME.CAVE,false);
//draw_sprite(test_window2,0,100,112)
//pal_swap_reset();
//scr_text_button(114,124,str2);

#endregion

#region Draw Debug Info
if (debug)
	{
	#region DRAW WINDOW SCALING TEXT
	var _scale, _pscale, _itxt, _etxt, _gtxt, _cpltxt;
	switch(window_scale)
		{
		case 1: _scale="1X SCALE"; break;
		case 2: _scale="2X SCALE"; break;
		case 3: _scale="3X SCALE"; break;
		case 4: _scale="FULLSCREEN"; break;
		}
	
	switch(prev_scale)
		{
		case 1: _pscale="1X SCALE"; break;
		case 2: _pscale="2X SCALE"; break;
		case 3: _pscale="3X SCALE"; break;
		case 4: _pscale="FULLSCREEN"; break;
		}
		
	switch(inIntro)
		{
		case 0: _itxt="FALSE"; break;
		case 1: _itxt="TRUE"; break;
		}
		
	switch(inEditor)
		{
		case 0: _etxt="FALSE"; break;
		case 1: _etxt="TRUE"; break;
		}

	switch(inGame)
		{
		case 0: _gtxt="FALSE"; break;
		case 1: _gtxt="TRUE"; break;
		}
		
	switch(canPlace)
		{
		case 0: _cpltxt="FALSE"; break;
		case 1: _cpltxt="TRUE"; break;
		}
	
	draw_text_transformed(0,8,"WINDOW SCALE: " + string(_scale),1,1,0);
	draw_text_transformed(0,17,"PREVIOUS WINDOW SCALE: " + string(_pscale),1,1,0);
	draw_text_transformed(0,26,"RM INFO WINDOW Y POS: " + string(room_info_window_y),1,1,0);
	draw_text_transformed(0,35,"GUI WIDTH: " + string(display_get_gui_width()),1,1,0);
	draw_text_transformed(0,44,"GUI HEIGHT: " + string(display_get_gui_height()),1,1,0);
	draw_text_transformed(0,53,"Editor mode: " + string(_etxt),1,1,0);
	draw_text_transformed(0,62,"Game mode: " + string(_gtxt),1,1,0);
	draw_text_transformed(0,71,"MOUSE X: " + string(device_mouse_x_to_gui(0)),1,1,0);
	draw_text_transformed(0,80,"MOUSE Y: " + string(device_mouse_y_to_gui(0)),1,1,0);
	draw_text_transformed(0,89,"WINDOW X POS: " + string(window_get_x()),1,1,0);
	draw_text_transformed(0,98,"WINDOW Y POS: " + string(window_get_y()),1,1,0);
	draw_text_transformed(0,107,"WINDOW WIDTH: " + string(window_get_width()),1,1,0);
	draw_text_transformed(0,116,"WINDOW HEIGHT: " + string(window_get_height()),1,1,0);
	draw_text_transformed(0,125,"FPS: " + string(fps),1,1,0);
	draw_text_transformed(0,134,"CAN PLACE TILE/OBJECT?: " + string(_cpltxt),1,1,0);
	draw_text_transformed(0,143,"CAN CURRENT TILE: " + string(current_tile),1,1,0);
	
	#endregion
	}
#endregion