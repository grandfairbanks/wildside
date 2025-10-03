/// @description Insert description here
// You can write your code in this editor

#region EDITOR STUFF
if (inEditor)
	{	
	#region DRAW CURRENT TILE LAYER / PLACEMENT MODE
	if mode==0
		{
		var tile_layer_txt, str, strw;
		switch(tile_current_layer)
			{
			case 0: tile_layer_txt="Foreground"; break;
			case 1: tile_layer_txt="Background"; break;
			}
		str="Current Tile Layer: " + string(tile_layer_txt);
		strw=string_width(str);
		draw_text_transformed((view_width/2)-(strw/2),0,str,1,1,0);
		}
	else
 
	if mode==1
		{
		var str, strw, col_text;
		//tile_layer_txt="Foreground"; break;
		if !layer_get_visible(collision_layer)
			{
			str="Current Entity Selected: " + string(scr_entity_name(entity_selected));
			}
		else
			{
			switch(entity_selected)
			{
			default: col_text=""; break;
			case 7: col_text="Solid"; break;
			case 8: col_text="Hazard"; break;			
			case 16: col_text="Ramp Down"; break;
			case 17: col_text="Ramp Up"; break;
			}
			str="Current Collision Tile Selected: " + (string(col_text));
			}
		}
		strw=string_width(str);
		draw_text_transformed((view_width/2)-(strw/2),0,str,1,1,0);
		
	#endregion
		
	#region DRAW LEVEL INFO WINDOW
	draw_set_alpha(info_window_alpha);
	
	#region DRAW WINDOW SPRITE
	draw_sprite_ext(room_info_window,0,room_info_window_x,room_info_window_y,1,1,0,c_white,1);
	#endregion
	
	#region DRAW LEVEL INFO
	var str, strw, txt_x=16, txt_x2=144;
		
	#region SET ATTRIBUTE READABLE OUTPUT
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
	#endregion
		
	#region SET THEME READABLE OUTPUT
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
	#endregion
		
	#region DRAW WINDOW TITLE
	var str="LEVEL INFORMATION";
	var strw=string_width(str);
	draw_text(room_info_window_x+room_info_window_w/2-(strw/2),room_info_window_y+9,string(str));
	#endregion
		
	#region DRAW NAME OF LEVEL
	strw=string_width("NAME: ");

	var caret = (name_edit_active && current_time div 400 mod 2 == 0) ? "|" : ""; // blinking cursor
	draw_text(room_info_window_x+9,room_info_window_y+24,"NAME: ");
		
	var butn = scr_text_button(room_info_window_x+9+strw ,room_info_window_y+24,string(level_name)+ caret);
	if butn.clicked
		{
		name_edit_active=true;
		}
	#endregion
			
	#region DRAW WIDTH OF LEVEL (IN SCREENS)
	str="X SCREENS: ";
	strw=string_width(str);
	draw_text(room_info_window_x+txt_x,room_info_window_y+40,"X SCREENS: ");
	var _x_butn=scr_text_button(room_info_window_x+txt_x+strw,room_info_window_y+40,string(level_x));
	if _x_butn.clicked
		{
		show_debug_message("X=" + string(level_x) + " Y=" + string(level_y) + 
                   " future_total=" + string((level_x + 1) * level_y));
		if ((level_x + 1) * level_y > 30) 
			{
	        }
		else
			{
			level_x++;
			resize_room();
			}
		}
	else if _x_butn.right
		{
		if ((level_x - 1) < 1)
			{
				//
	        }
		else
			{
			level_x--;
			resize_room();
			}
		}
	#endregion
		
	#region DRAW THEME OF LEVEL
	str="THEME: ";
	strw=string_width(str);
	draw_text(room_info_window_x+txt_x2,room_info_window_y+40,str);
	var _theme_butn=scr_text_button(room_info_window_x+txt_x2+strw,room_info_window_y+40,string(theme_out));
	if _theme_butn.clicked
		{
		if level_theme<10
		level_theme++;
		scr_update_theme();
		}
	else if _theme_butn.right
		{
		if level_theme>1
		level_theme--;
		scr_update_theme();
		}
	#endregion
		
	#region DRAW HEIGHT OF LEVEL (IN SCREENS) 
	str="Y SCREENS: ";
	strw=string_width(str);
	draw_text(room_info_window_x+txt_x,room_info_window_y+50,str);
	var _y_butn=scr_text_button(room_info_window_x+txt_x+strw,room_info_window_y+50,string(level_y));
	if _y_butn.clicked
		{
		show_debug_message("X=" + string(level_x) + " Y=" + string(level_y) + 
                   " future_total=" + string((level_x + 1) * level_y));
		if (level_x * (level_y + 1) > 30) 
			{
	        }
		else
			{
			level_y++;
			resize_room();
			}
		}
	else if _y_butn.right
		{
		if ((level_y - 1) < 1)
			{
				//
	        }
		else
			{
			level_y--;
			resize_room();
			}
		}
	#endregion
		
	#region DRAW LEVEL ATTRIBUTE
	str=" TYPE: ";
	strw=string_width(str);
	draw_text(room_info_window_x+txt_x2,room_info_window_y+50,str);
	var _attr_butn=scr_text_button(room_info_window_x+txt_x2+strw,room_info_window_y+50,string(attr_out));
	if _attr_butn.clicked
		{
		if level_attr<7
		level_attr++;
		scr_entity_display();
		}
	else if _attr_butn.right
		{
		if level_attr>0
		level_attr--;
		scr_entity_display();
		}
	#endregion
		
	#region DRAW START X/Y
	if (instance_exists(obj_player))
		{
		//DRAW STARTING X POSITION
		draw_text(room_info_window_x+txt_x,room_info_window_y+68,"  START X: " + string(start_x));
		//DRAW STARTING Y POSITION
		draw_text(room_info_window_x+txt_x,room_info_window_y+78,"  START Y: " + string(start_y));
		}
	else
		{
		var _notset="";
		pal_swap_set(pal_font,4,false)
		//DRAW STARTING X POSITION
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+68,"START X: " + string(_notset),1,1,0);
		//DRAW STARTING Y POSITION
		draw_text_transformed(room_info_window_x+txt_x,room_info_window_y+78,"START Y: " + string(_notset),1,1,0);
		pal_swap_reset();
		}
	#endregion
		
	#region DRAW END X/Y
	if (flag_exist)
		{
		//DRAW FLAG X POSITION
		draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+68,"END X: " + string(end_x),1,1,0);
		//DRAW FLAG Y POSITION
		draw_text_transformed(room_info_window_x+txt_x2,room_info_window_y+78,"END Y: " + string(end_y),1,1,0);
		}
	else
		{
		var _notset="";
		pal_swap_set(pal_font,4,false);
		//DRAW FLAG X POSITION
		draw_text(room_info_window_x+txt_x2,room_info_window_y+68,"END X: " + string(_notset));
		//DRAW FLAG Y POSITION
		draw_text(room_info_window_x+txt_x2,room_info_window_y+78,"END Y: " + string(_notset));
		pal_swap_reset();
		}
	#endregion
		
	#region DRAW LEVEL PAR
	str="LEVEL PAR: ";
	strw=string_width(str);
	draw_text(room_info_window_x+txt_x,room_info_window_y+96,"LEVEL PAR: ");
	var par_butn=scr_text_button(room_info_window_x+txt_x+strw,room_info_window_y+96,string(par_text));
	if par_butn.clicked
		{
		par_edit_active=true;
		par_text+=string(level_par)
		}
	#endregion
		
	#region DRAW PATH BONUS
	draw_text(room_info_window_x+txt_x2,room_info_window_y+96,"PATH BONUS: " + string(path_bonus));
		
	#endregion
		
	#endregion
		
	draw_set_alpha(1);
	#endregion
	
	#region DRAW LEVEL LIST
	scrollbar_draw_ext(level_list_scroller,10,10,10,10,ds_list_size(map_list)-1);
	
	//scr_file_listbox(level_list_window_x,level_list_window_y,level_list,10,40,10,);
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
	theme_palette_window_x=tile_window_x;
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
	draw_text(entity_info_window_x+8,entity_info_window_y+8,string(current_ent.name));
	if current_ent.opt1!=""
		{
		
		draw_text(entity_info_window_x+8,entity_info_window_y+24,current_ent.opt1 + "" + string(current_ent.var1));
		
		}
		
	if current_ent.opt2!=""
	draw_text(entity_info_window_x+8,entity_info_window_y+40,current_ent.opt2 + "" + string(current_ent.var2));
	if current_ent.opt3!=""
	draw_text(entity_info_window_x+8,entity_info_window_y+56,current_ent.opt3 + "" + string(current_ent.var3));
	if current_ent.opt4!=""
	draw_text(entity_info_window_x+8,entity_info_window_y+72,current_ent.opt4 + "" + string(current_ent.var4));
	if current_ent.opt5!=""
	draw_text(entity_info_window_x+8,entity_info_window_y+88,current_ent.opt5 + "" + string(current_ent.var5));
	}
	#endregion
	}
#endregion

#region GAME STUFF
if (inGame)
	{
	#region DRAW HUD
	
	#endregion
	}
	
#endregion

#region SCREEN FADE
if (fade_active)
	{
	draw_set_alpha(fade_alpha);
	draw_rectangle_color(0,0,display_get_width(),display_get_height(),fade_color,fade_color,fade_color,fade_color,false);
	draw_set_alpha(1);
	}
#endregion

#region DRAW MAP
if (map_window_visible)
	{
	draw_sprite(map_window,0,map_window_x,map_window_y);
	draw_text(map_window_x+map_window_w/2+(8),map_window_y+8,"GAME MAP");	
	scr_draw_map();
	}
#endregion

#region DRAW DEBUGGING INFORMATION
if (debug)
	{
	#region DRAW WINDOW SCALING TEXT
	var _scale, _pscale, _itxt, _etxt, _gtxt, _cpltxt;
	switch(window_scale)
		{
		default: _scale=string(window_scale)+"X SCALE"; break
		case 1: _scale="1X SCALE"; break;
		case 2: _scale="2X SCALE"; break;
		case 3: _scale="3X SCALE"; break;
		case 4: _scale="4X SCALE"; break;
		}
	
	switch(prev_scale)
		{
		default: _pscale=string(window_scale)+"X SCALE"; break
		case 1: _pscale="1X SCALE"; break;
		case 2: _pscale="2X SCALE"; break;
		case 3: _pscale="3X SCALE"; break;
		case 4: _pscale="4X SCALE"; break;
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
	draw_text_transformed(0,143,"CURRENT TILE: " + string(current_tile),1,1,0);
	
	#endregion
	}
#endregion