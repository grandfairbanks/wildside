/// @description Insert description here
#region EDITOR PROPERTIES
mode=0;
load=0;
reSize=false;

if !directory_exists("Settings")
directory_create("Settings");

if !directory_exists("Levels")
directory_create("Levels");

//various states
inIntro=false;
open_door=false;
close_door=true;
inEditor=true;
inGame=false;
canPlace=false;
canPick=false;
level_list=ds_list_create();

#region MAP LIST STUFF
map_list=ds_list_create();
map_list_x=10;
map_list_y=10;

repeat (255)
	{
	ds_list_add(map_list,"UNUSED");
	}
map_list_scroller=scrollbar_create(1,spr_scrollbar,true);
map_list_window_w=300;
map_list_window_h=200;
map_list_window_x=100;
map_list_window_y=100;

function map_list_display()
	{
	////////hovering within list box
	//if window_mouse_get_x()>xx+width || window_mouse_get_y()>yy+height*size-1 || window_mouse_get_x()<xx || window_mouse_get_y()<yy
	if !point_in_rectangle(window_mouse_get_x(),window_mouse_get_y(),xx,yy,xx+width,yy+height*size-1)
	//if mouse is outside name text box hotspot
	{row_hl=0;}
	else	
	{}
	
spr_map_list_window=scr_create_window(map_list_window_w,map_list_window_h,false);
	}
#endregion

bufpos=0;//this is to record the room file buffer for loading a room. used to save buffer position after room_restart
		 //to continue to read collision/terrain/entity information after the header is rea
filename="";//used to save filename after room restart to read back into the file to continue loading room info

tempCT=ds_grid_create(1,1);
tempBT=ds_grid_create(1,1);
tempFT=ds_grid_create(1,1);
tempENT=ds_grid_create(1,1);
#endregion

#region LOAD LEVEL FILES TO LIST
function scr_load_files(_folder, _ext) {
    var _list = ds_list_create();
    var _pattern = working_directory + "/" + _folder + "/*" + _ext;

    var _file = file_find_first(_pattern, fa_readonly);
    while (_file != "") {
        ds_list_add(_list, _file);
        _file = file_find_next();
    }
    file_find_close();
    return _list;
}
#endregion

level_list=scr_load_files("levels",".bin");
level_list_window_x=10;
level_list_window_y=10;
level_list_window_w=40;
level_list_window_h=256;
scr_create_window(level_list_window_w,level_list_window_h,false);
level_list_scroller=scrollbar_create(1,spr_scrollbar,true);

#region DEBUG
debug=false;
#endregion

#region CREATE BACKGROUND COLOR OBJECT
instance_create_depth(0,0,4,obj_bkg_col);
#endregion

#region LEVEL PROPERTIES
enum THEME
	{
	NULL,
	SKY,
	ICE,
	HILLS,
	ISLAND,
	DESERT,
	SWAMP,
	MOUNTAIN,
	CAVE,
	WOODS,
	CITY
	}
	
enum ATTRIBUTE
	{
	NORMAL,
	LAVA,
	STORM,
	HAIL,
	CHASE,
	ELSEWHERE,
	BOSS,
	FINAL
	}

level_num=0;
level_name="TEST LEVELTEST LEVELTEST LEVEL";
level_x=room_width/SCREEN_WIDTH;
level_y=room_height/SCREEN_HEIGHT;
level_theme=THEME.SKY;
level_attr=ATTRIBUTE.NORMAL;
start_x=0;
start_y=0;
end_x=0;
end_y=0;
level_par=0;
path_bonus=0;

total_screens=(level_x*level_y);
grid_size=(room_width/TILE_SIZE)+(room_height/TILE_SIZE);
flag_exist=false;
speed_bonus=10000;
min_bonus=1000;
sec_bonus=10;
no_prize=5000;
#endregion

 #region SAVE LEVEL
function save_level()
	{
    // Enforce max combined screens
    if (level_x * level_y > 30) 
		{
        show_error("Level exceeds maximum allowed screens (30 total)!", true);
        exit;
		}

    // Create buffer
    var _buf = buffer_create(256, buffer_grow, 1);

    /// --- LEVEL HEADER ---
    buffer_write(_buf, buffer_u32, level_num);

    // Fixed 30-character name
    var _name_fixed = string_copy(level_name, 1, 30);
    var _name_len   = string_length(_name_fixed);
    for (var i = 1; i <= 30; i++) {
        if (i <= _name_len) {
            buffer_write(_buf, buffer_u8, ord(string_char_at(_name_fixed, i)));
        } else {
            buffer_write(_buf, buffer_u8, 0);
        }
    }

    buffer_write(_buf, buffer_u16, level_x);
    buffer_write(_buf, buffer_u16, level_y);
    buffer_write(_buf, buffer_u8,  level_theme);
    buffer_write(_buf, buffer_u8,  level_attr);
    buffer_write(_buf, buffer_u16, level_par);
    buffer_write(_buf, buffer_u16, path_bonus);

    /// --- TILEMAP + ENTITY DATA ---
    var tiles_x = room_width div 16;
    var tiles_y = room_height div 16;

    for (var _y = 0; _y < tiles_y; _y++) {
        for (var _x = 0; _x < tiles_x; _x++) {
			
			var colout, col, bg, fg;
			col = tilemap_get(collision_tiles, _x, _y);
			bg = tilemap_get(terrain_tiles_b, _x, _y);
			fg = tilemap_get(terrain_tiles_f, _x, _y);
			
			show_debug_message(string(colout) + "COLLISION TILE: " + " FOUND AT " + string(_x) + "/"  + string(_y)); 
			buffer_write(_buf, buffer_u8, col); 
			// Background
			show_debug_message("BACKGROUND TILE: " + string(bg) + " found at " + string(_x) + "/"  + string(_y));
			buffer_write(_buf, buffer_u8, bg); 
			// Foreground
			show_debug_message("FOREGROUND TILE: " + string(fg) + " found at " + string(_x) + "/"  + string(_y));
			buffer_write(_buf, buffer_u8, fg);

            // Entities (Blocks/Enemies/Player)
            var _ent = ds_grid_get(entity_grid, _x, _y);

            if (_ent == 255) {
                // Write "empty entity" placeholder (still 7 bytes!)
                buffer_write(_buf, buffer_u8, 255); // type
                buffer_write(_buf, buffer_u8, 0);   // sprite
                buffer_write(_buf, buffer_u8, 0);   // var1
                buffer_write(_buf, buffer_u8, 0);   // var2
                buffer_write(_buf, buffer_u8, 0);   // var3
                buffer_write(_buf, buffer_u8, 0);   // var4
                buffer_write(_buf, buffer_u8, 0);   // var5
				show_debug_message("NO ENTITY FOUND AT " + string(_x) + "/"  + string(_y));
            } else {
                // Write real entity
                buffer_write(_buf, buffer_u8, _ent._type);
                buffer_write(_buf, buffer_u8, _ent.sprite);
                buffer_write(_buf, buffer_u8, _ent.var1);
                buffer_write(_buf, buffer_u8, _ent.var2);
                buffer_write(_buf, buffer_u8, _ent.var3);
                buffer_write(_buf, buffer_u8, _ent.var4);
                buffer_write(_buf, buffer_u8, _ent.var5);
				show_debug_message(string(_ent.name) + "  FOUND AT " + string(_x) + "/"  + string(_y));
            }
        }
    }

    // Save buffer to file
    var _safe_name = string_replace_all(level_name, " ", "_");
    var _filename  = "levels/" + _safe_name + ".bin";
    buffer_save(_buf, _filename);
    buffer_delete(_buf);
	show_debug_message("LEVEL SAVED.");
	}
#endregion

#region LOAD LEVEL
function load_level(_filename)	
	{
	if load==0
		{
	    if (!file_exists("levels/" + string(_filename))) 
			{
	        show_error("Level file not found: " + _filename, true);
	        return;
			} 
		else 
			{
	        show_debug_message("LEVEL FILE FOUND");
			}

	    var _buf = buffer_load("levels/" + string(_filename));

	    /// --- HEADER ---
	    level_num = buffer_read(_buf, buffer_u32);

	    var _name_chars = "";
	    for (var _i = 1; _i <= 30; _i++) 
			{
	        var _c = buffer_read(_buf, buffer_u8);
	        if (_c != 0) _name_chars += chr(_c);
			}
			
	    level_name  = _name_chars;
	    level_x     = buffer_read(_buf, buffer_u16);
	    level_y     = buffer_read(_buf, buffer_u16);
	    level_theme = buffer_read(_buf, buffer_u8);
	    level_attr  = buffer_read(_buf, buffer_u8);
	    level_par   = buffer_read(_buf, buffer_u16);
	    path_bonus  = buffer_read(_buf, buffer_u16);
	
		bufpos = buffer_tell(_buf)
		load=1;
		filename=_filename;
		room_set_width(room,level_x*SCREEN_WIDTH);
		room_set_height(room,level_y*SCREEN_HEIGHT);
		room_restart();
		}
	else if load==1
		{
		var _buf = buffer_load("levels/" + string(filename));
		buffer_seek(_buf,buffer_seek_start,bufpos);
	    /// --- TILEMAP + ENTITY DATA ---
	    var _tiles_x = room_width div 16;
	    var _tiles_y = room_height div 16;
		
		create_tilemaps();

	    for (var _y = 0; _y < _tiles_y; _y++) 
			{
	        for (var _x = 0; _x < _tiles_x; _x++) 
				{
				var _coll = buffer_read(_buf, buffer_u8);
				tilemap_set(collision_tiles, _coll, _x, _y);
			
				var _bg = buffer_read(_buf, buffer_u8); 
				tilemap_set(terrain_tiles_b, _bg, _x, _y);
			
				var _fg = buffer_read(_buf, buffer_u8); 
				tilemap_set(terrain_tiles_f, _fg, _x, _y);
			
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
	                ds_grid_set(entity_grid, _x, _y, 255);
					} 
				else 
					{
	                var _ent = new entity();
					ds_grid_set(entity_grid, _x, _y, _ent);
					_ent.x=_x*TILE_SIZE;
					_ent.y=_y*TILE_SIZE;
	                _ent._type  = _type;
	                _ent.sprite = _sprite;
	                _ent.var1   = _v1;
	                _ent.var2   = _v2;
	                _ent.var3   = _v3;
	                _ent.var4   = _v4;
	                _ent.var5   = _v5;
	                _ent.update_entity();	
					}
				}
			}

	    buffer_delete(_buf);
		}
}
#endregion

#region RESIZE LEVEL
function resize_room()
{
    if !reSize
    {
        show_debug_message("saving current room contents");

        // old grid size BEFORE resizing
        var old_tiles_x = room_width div 16;
        var old_tiles_y = room_height div 16;

        ds_grid_resize(tempCT, old_tiles_x, old_tiles_y);
        ds_grid_resize(tempBT, old_tiles_x, old_tiles_y);
        ds_grid_resize(tempFT, old_tiles_x, old_tiles_y);
        ds_grid_resize(tempENT, old_tiles_x, old_tiles_y);

        for (var _y = 0; _y < old_tiles_y; _y++) {
            for (var _x = 0; _x < old_tiles_x; _x++) {
                tempCT[# _x, _y]  = tilemap_get(collision_tiles, _x, _y);
                tempBT[# _x, _y]  = tilemap_get(terrain_back_layer, _x, _y);
                tempFT[# _x, _y]  = tilemap_get(terrain_front_layer, _x, _y);
                tempENT[# _x, _y] = ds_grid_get(entity_grid, _x, _y);
            }
        }

        // now resize the room
        show_debug_message("resizing room...");
        room_set_width(room, level_x * SCREEN_WIDTH);
        room_set_height(room, level_y * SCREEN_HEIGHT);

        reSize = true;
        room_restart();
    }
    else
    {
        show_debug_message("restoring room contents");
        create_tilemaps();

        var new_tiles_x = room_width div 16;
        var new_tiles_y = room_height div 16;

        // loop only up to whichever is smaller (saved or new)
        var max_x = min(ds_grid_width(tempCT), new_tiles_x);
        var max_y = min(ds_grid_height(tempCT), new_tiles_y);

        for (var _y = 0; _y < max_y; _y++) {
            for (var _x = 0; _x < max_x; _x++) {
                tilemap_set(collision_tiles,     tempCT[# _x, _y], _x, _y);
                tilemap_set(terrain_back_layer,  tempBT[# _x, _y], _x, _y);
                tilemap_set(terrain_front_layer, tempFT[# _x, _y], _x, _y);
                ds_grid_set(entity_grid, _x, _y, tempENT[# _x, _y]);
            }
        }

        reSize = false;
    }
}
#endregion

#region CHECK IF FLAG EXISTS IN LEVEL
function flag_exists() 
	{
    for (var yy = 0; yy < ds_grid_height(entity_grid)-1; yy++) 
		{
        for (var xx = 0; xx < ds_grid_width(entity_grid)-1; xx++) 
			{
            var _ent = entity_grid[# xx, yy];
            if (is_undefined(_ent)) continue;
            if (_ent._type == 15) flag_exist=true;
			}
		}
    flag_exist=false;
	}
#endregion

#region ENTITY/OBJECT STRUCT
function entity() constructor
	{
	show_debug_message("ENTITY CREATED")
	
	#region ENTITY VARIABLES
	_type=0;
	x=0;
	y=0;
	name="";
	sprite=spr_null;
	opt1="";
	opt2="";
	opt3="";
	opt4="";
	opt5="";
	var1=0;
	var2=0;
	var3=0;
	var4=0;
	var5=0;
	#endregion
	
	#region UPDATE ENTITY
	function update_entity()
		{
		scr_update_entity();
		}
	#endregion
	
	#region DRAW EVENT
	function draw_entity() {
	if _type>=0 && _type<=6 ^^ _type>=9 && _type<=15
	pal_swap_set(spr_theme_pal,obj_system.level_theme-1,false);
	
	draw_sprite(sprite,0,x,y);
	
	if _type==11 //horizontal platform
		{
		var _i;
		if var2>0
			{
			for(_i=0; _i<var2; _i++)
				{
				draw_sprite(sprite,1,x+16+(16*_i),y);
				}
			}
		draw_sprite_ext(sprite,2,x+16+(16*var2),y,1,1,0,c_white,1)
		}
	
	if _type==12 //vertical platform
		{
		var _i;
		if var2>0
			{
			for(_i=0; _i<var2; _i++)
				{
				draw_sprite(sprite,1,x,y+16+(16*_i));
				}
			}
		draw_sprite_ext(sprite,2,x,y+16+(16*var2),1,1,0,c_white,1)
		}
		
	if _type==14 //teleporter
		{
		draw_sprite_ext(sprite,0,x+32,y,-1,1,0,c_white,1)
		}
		
	if _type==15 //flag
		{
		//draw_sprite(sprite,0,x,y+16)
		}
		
	if _type==19 //tank
		{
		draw_sprite(spr_tank_tread,0,x,y+8)
		}
		
	if _type==20 //driller
		{
		draw_sprite_ext(spr_driller_drill,0,x+16,y,-1,1,0,c_white,1);
		draw_sprite_ext(spr_driller_drill,0,x-16,y,1,1,0,c_white,1);
		}
		
	if _type==27 //tar monster
		{
		draw_sprite(sprite,6,x,y);	
		}
		
	if _type==45 //boss
		{
		// Offsets relative to boss origin
		var left_eye_x  = x - 12;
		var left_eye_y  = y - 37;
		var right_eye_x = x + 12;
		var right_eye_y = y - 37;

		// Determine if boss is dead/dilated
		var dilated = false; // Replace with your condition

		// Initialize blink timer if it doesn't exist
		blink_timer = 0;

		// Randomly trigger blink when not already blinking
		if (blink_timer <= 0 && irandom(100) < 2) 
			{
		    blink_timer = 900; // duration of blink in steps
			}

		// Helper function to get eye frame from angle
		function get_eye_frame(_ex, _ey, _dilated)
			{
		    if (_dilated) return 1; // Dilated pupil

		    if (blink_timer > 0) return 0; // blink frame

		    var dx = mouse_x - _ex;
		    var dy = _ey - mouse_y; // invert y if needed
		    var angle = point_direction(0, 0, dx, dy);
		    var frame = 2 + floor((angle / 360) * 15); // Map 0–360° to frames 2–16
		    return clamp(frame, 2, 16);
			}

		// Draw eyes at their offsets
		draw_sprite(spr_boss_eye, get_eye_frame(left_eye_x, left_eye_y, dilated), left_eye_x, left_eye_y);
		draw_sprite(spr_boss_eye, get_eye_frame(right_eye_x, right_eye_y, dilated), right_eye_x, right_eye_y);

		// Decrease blink timer
		if (blink_timer > 0) blink_timer -= 1;

		// Draw boss sprite
		draw_sprite(sprite, 0, x, y);
		}
	
	if _type>=0 && _type<=6 ^^ _type>=9 && _type<=15 //collision tiles
	pal_swap_reset();
	
	}
	#endregion

	}
#endregion

#region CREATE COLLISION AND TERRAIN TILEMAPS AND ENTITY GRID
function create_tilemaps()
	{
	tile_theme_surface=surface_create(256,256);
	ent_display_surface=surface_create(256,256);
		
	collision_layer=layer_create(2);
	terrain_back_layer=layer_create(1);
	terrain_front_layer=layer_create(0);
	scr_update_theme();
	collision_tiles=layer_tilemap_create(collision_layer,0,0,holo_tiles,room_width/TILE_SIZE,room_height/TILE_SIZE);
	terrain_tiles_b=layer_tilemap_create(terrain_back_layer,0,0,tileset,room_width/TILE_SIZE,room_height/TILE_SIZE);
	terrain_tiles_f=layer_tilemap_create(terrain_front_layer,0,0,tileset,room_width/TILE_SIZE,room_height/TILE_SIZE);
		
	#region CREATE ENTITY GRID
	entity_grid=ds_grid_create(room_width div 16,room_height div 16);
	ds_grid_set_region(entity_grid,0,0,room_width div 16,room_height div 16,255);
	current_ent=undefined;
	#endregion
	}
#endregion

create_tilemaps();

#region VIEW SET UP

fullscreen=window_get_fullscreen();
//ideal width
view_width=320;

//ideal height
view_height=224;

//window scale
window_scale=2;
prev_scale=window_scale;
window_max_scale=5;
//view zoom
view_zoom=1;
view_max_zoom=10;

//gui scale
gui_scale=1;

//set window size
window_set_size(view_width*window_scale,view_height*window_scale);
display_set_gui_size(view_width*gui_scale,view_height*gui_scale);
//center window
alarm[0]=1;

//resize application surface to window size
surface_resize(application_surface,view_width*window_scale,view_height*window_scale);

//toggle for view dragging in editor
v_drag=false;

//view drag x
drag_x=0;

//view drag y
drag_y=0;
#endregion

#region TELEPORTER AND DEMO FADE COLORS
c_tele=make_color_rgb(224,224,0);
c_demo=make_color_rgb(160,32,128);
fade_active=false;
fade_color=choose(c_tele,c_demo);
fade_alpha=0;
#endregion

#region GAME MAP
game_map=ds_list_create();
map_window_x=0;
map_window_y=0;
map_window_w=304;
map_window_h=208;
map_window=scr_create_window(map_window_w,map_window_h,false);
within_map_window=false;
map_window_visible=false;
scr_create_orig_map();
level_windows = ds_list_create();
for (var _i=0; _i<ds_list_size(game_map); _i++) 
	{
    var _str = ds_list_find_value(game_map, _i);
    var _strw = string_width(_str);
    var _level_window = scr_create_window((_strw-1)+12, 16, true);
    ds_list_add(level_windows, _level_window);
	}
#endregion

#region INTRO DEMO SET UP (CURRENTLY DISABLED)
if (inIntro)
	{
	//create tile grid to store tile data inside
	var ws_grid=ds_grid_create(32,16);
	//door x position variables
	left_door_x=124;
	right_door_x=156;
	//create tile layer for building
	ws_layer=layer_create(0);
	sign_layer=layer_create(0);

	//create tilemap for building tile layer
	ws_tileset=layer_tilemap_create(ws_layer,0,0,wildside_tiles,40,26);
	//create tile layer for intro background behind building
	ws_bkg_layer=layer_create(3);
	//create tilemap for intro background behind building
	wsb_tileset=layer_tilemap_create(ws_bkg_layer,0,0,wildside_back_tiles,20,14);
	//inside building
	inside_layer=layer_create(2)
	inside_sprite=layer_sprite_create(inside_layer,128,151,spr_holo_insert);

	door_layer=layer_create(1);
	left_door_sprite=layer_sprite_create(door_layer,left_door_x,152,spr_wsl_door);
	right_door_sprite=layer_sprite_create(door_layer,right_door_x,152,spr_wsr_door);

	//draw background for intro
	for (var b=0; b<14; b++)
		{
		for (var a=0; a<20; a++)
			{
			switch(b)
				{
				case 0: tilemap_set(wsb_tileset,1,a,b); break;
				case 1: tilemap_set(wsb_tileset,2,a,b); break;
				case 2: tilemap_set(wsb_tileset,3,a,b); break;
				case 3: tilemap_set(wsb_tileset,4,a,b); break;
				case 4: tilemap_set(wsb_tileset,5,a,b); break;
				case 5: tilemap_set(wsb_tileset,5,a,b); break;
				case 6: tilemap_set(wsb_tileset,5,a,b); break;
				case 7: tilemap_set(wsb_tileset,5,a,b); break;
				case 8: tilemap_set(wsb_tileset,6,a,b); break;
				case 9: tilemap_set(wsb_tileset,7,a,b); break;
				case 10: tilemap_set(wsb_tileset,8,a,b); break;
				case 11: tilemap_set(wsb_tileset,9,a,b); break;
				case 12: tilemap_set(wsb_tileset,9,a,b); break;
				case 13: tilemap_set(wsb_tileset,9,a,b); break;
				}
			}
		}

	file=file_text_open_read("wildside.dat");
	ds_grid_read(ws_grid,file_text_read_string(file));
	file_text_close(file);

	for (var d=0; d<16; d++)
		{
		for (var c=0; c<32; c++)
			{
			//show_debug_message("READING DS GRID: " + string(ds_grid_get(ws_grid,c,d)));
			tilemap_set(ws_tileset, ds_grid_get(ws_grid,c,d),c+4,d+10);
			}
		}
	//layer_destroy(door_layer);
	ds_grid_destroy(ws_grid);
	}
#endregion

#region TILE WINDOW STUFF
tile_window_x=display_get_gui_width()-4;
tile_window_y=0;
tile_window_w=128;
tile_window_h=136;
tile_window=scr_create_window(tile_window_w,tile_window_h,false);
current_tile=0;
tile_current_layer=0// 0 - forground, 1, background, -2 collision
within_tile_window=false;
#endregion

#region THEME PALETTE WINDOW STUFF
theme_palette_window_w=128;
theme_palette_window_h=48;
theme_palette_window_x = tile_window_x;
theme_palette_window_y = ((tile_window_y+tile_window_h+sprite_get_height(spr_window)*2)-1);
theme_palette_window=scr_create_window(theme_palette_window_w,theme_palette_window_h,false);
#endregion

#region ROOM INFO WINDOW STUFF
room_info_window_y=display_get_gui_height()-4;
room_info_window_w=256;
room_info_window_x=display_get_gui_width()/2-(room_info_window_w/2)-6;
room_info_window_h=108;
within_rinfo_window=false;
info_window_alpha=0.5;
room_info_window=scr_create_window(room_info_window_w,room_info_window_h,false)
name_edit_active=false;
par_edit_active=false;
par_text=string(level_par);
#endregion

#region ENTITY WINDOW STUFF
entity_window_w=72;
entity_window_h=64;
entity_window_y=0;
entity_window_x=(display_get_gui_width()-display_get_gui_width())-entity_window_w-sprite_get_width(spr_window);//entity_window_w-sprite_get_width(spr_window)-1;
entity_window=scr_create_window(entity_window_w,entity_window_h,false);
within_entity_window=false;
entity_selected=0;
#endregion

#region ENTITY INFO WINDOW
entity_info_window_w=72;
entity_info_window_h=64;
entity_info_window_y=88;
entity_info_window_x=(display_get_gui_width()-display_get_gui_width())-entity_info_window_w-sprite_get_width(spr_window);
spr_entity_info_window=scr_create_window(entity_info_window_w,entity_info_window_h,false);
within_entity_info_window=false;
entity_info_window_visible=false;
#endregion

#region COLLISION VISUALS
// Tutorial Purpose Only
zoom=1;
spd_plus=0.25;
line=false;// Collision Line display
visual=1;
line_origin=obj_player;
#endregion

#region END LEVEL STUFF
current_index = 0;
// Control speed (frames between deletions)
erase_speed = 0.5;
timer = 0;
endlvl_active = false; // don’t start until flag touched
endfade_active = false;
end_alpha = 1;
start_end_fade=false;

	#region REMOVE TILES AND ENTITES IN VIEW
	function end_level()
		{
		layer_set_visible(collision_layer,true)
		// Initialize starting tile based on current view
		var view_x = camera_get_view_x(view);
		var view_y = camera_get_view_y(view);
		var tiles_w = (room_width/TILE_SIZE);
		var tiles_h = (room_height/TILE_SIZE);
		start_tile_x = view_x div 16;
		start_tile_y = view_y div 16;
		view_w_tiles = ceil(camera_get_view_width(view) div TILE_SIZE) + 1;
		view_h_tiles = ceil(camera_get_view_height(view) div TILE_SIZE) + 1;
	
		if (endlvl_active) 
			{
		    timer++;
		    if (timer >= erase_speed) 
				{
		        timer = 0;

		        // Tile coordinates in view
		        var tx = start_tile_x + (current_index mod view_w_tiles);
		        var ty = start_tile_y + (current_index div view_w_tiles);

		        // Safety check: don’t go out of room bounds
		        if (tx < tiles_w && ty < tiles_h) 
					{
		            tilemap_set(terrain_tiles_b, 0, tx, ty); // erase tile
					tilemap_set(terrain_tiles_f, 0, tx, ty); // erase tile
					ds_grid_set(entity_grid,tx,ty,255);
					}

					current_index++;

		        // Stop when all tiles in view are erased
		        if (current_index >= view_w_tiles * view_h_tiles) 
					{
		            endlvl_active=false;
					timer=0;
					}
				}
			}
		
		}//end function
	#endregion

#endregion