/// @description Insert description here
// You can write your code in this editor


#region EDITOR PROPERTIES
mode=0;

if !directory_exists("Settings")
directory_create("Settings");

if !directory_exists("Levels")
directory_create("Levels");

#endregion

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
level_name="TEST LEVEL";
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
grid_size=(level_x*TILE_SIZE)+(level_y*TILE_SIZE);
flag_exists=false;
speed_bonus=10000;
min_bonus=1000;
sec_bonus=10;
no_prize=5000;
#endregion

#region SAVE LEVEL
function save_level()
{
    // Enforce max combined screens
    if (level_x + level_y > 30) {
        show_error("Level exceeds maximum allowed screens (30 total)!", true);
        return;
    }

    var _level_num   = 42;
    var _level_name  = "BAGEL BROTHERS";
    var _level_x     = room_width / SCREEN_WIDTH;
    var _level_y     = room_height / SCREEN_HEIGHT;
    var _level_theme = THEME.CITY;
    var _level_attr  = ATTRIBUTE.BOSS;
    var _level_par   = 220;
    var _path_bonus  = 0;

    // Create buffer
    var _buf = buffer_create(256, buffer_grow, 1);

    /// --- LEVEL HEADER ---
    buffer_write(_buf, buffer_u32, _level_num);

    // Fixed 30-character name
    var _name_fixed = string_copy(_level_name, 1, 30);
    var _name_len   = string_length(_name_fixed);
    for (var i = 1; i <= 30; i++) {
        if (i <= _name_len) {
            buffer_write(_buf, buffer_u8, ord(string_char_at(_name_fixed, i)));
        } else {
            buffer_write(_buf, buffer_u8, 0);
        }
    }

    buffer_write(_buf, buffer_u16, _level_x);
    buffer_write(_buf, buffer_u16, _level_y);
    buffer_write(_buf, buffer_u8,  _level_theme);
    buffer_write(_buf, buffer_u8,  _level_attr);
    buffer_write(_buf, buffer_u16, _level_par);
    buffer_write(_buf, buffer_u16, _path_bonus);

    /// --- TILEMAP + ENTITY DATA ---
    var tiles_x = room_width div 16;
    var tiles_y = room_height div 16;

    for (var _y = 0; _y < tiles_y - 1; _y++) {
        for (var _x = 0; _x < tiles_x - 1; _x++) {

			// Collision 
			
			var colout, col, bg, fg;
			col = tilemap_get(collision_tiles, _x, _y);
			bg = tilemap_get(terrain_tiles_b, _x, _y);
			fg = tilemap_get(terrain_tiles_f, _x, _y);
			
			if col == 0
			colout = "NO ";
			if col == 1
			colout = 
			
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
    var _safe_name = string_replace_all(_level_name, " ", "_");
    var _filename  = "levels/" + _safe_name + ".bin";
    buffer_save(_buf, _filename);
    buffer_delete(_buf);
	show_debug_message("LEVEL SAVED.");
}
#endregion

#region LOAD LEVEL
function load_level(_filename)
{
    if (!file_exists("levels/" + string(_filename))) {
        show_error("Level file not found: " + _filename, true);
        return;
    } else {
        show_debug_message("LEVEL FILE FOUND");
    }

    // Clear old data
    tilemap_clear(collision_layer, 0);
    tilemap_clear(terrain_tiles_b, 0);
    tilemap_clear(terrain_tiles_f, 0);
    ds_grid_clear(entity_grid, 255);

    var _buf = buffer_load("levels/" + string(_filename));

    /// --- HEADER ---
    level_num = buffer_read(_buf, buffer_u32);

    var _name_chars = "";
    for (var _i = 1; _i <= 30; _i++) {
        var _c = buffer_read(_buf, buffer_u8);
        if (_c != 0) _name_chars += chr(_c);
    }
    level_name  = _name_chars;

    level_x     = buffer_read(_buf, buffer_u16);
    level_y     = buffer_read(_buf, buffer_u16);
    level_theme = buffer_read(_buf, buffer_u8);
    level_attr  = buffer_read(_buf, buffer_u8);
    scr_update_theme();
    level_par   = buffer_read(_buf, buffer_u16);
    path_bonus  = buffer_read(_buf, buffer_u16);

    /// --- TILEMAP + ENTITY DATA ---
    var _tiles_x = room_width div 16;
    var _tiles_y = room_height div 16;

    for (var _y = 0; _y < _tiles_y - 1; _y++) {
        for (var _x = 0; _x < _tiles_x - 1; _x++) {

			var _coll = buffer_read(_buf, buffer_u8);
			tilemap_set(collision_tiles, _coll, _x, _y);
			
			var _bg = buffer_read(_buf, buffer_u8); 
			tilemap_set(terrain_tiles_b, _bg, _x, _y);
			
			var _fg = buffer_read(_buf, buffer_u8); 
			tilemap_set(terrain_tiles_f, _fg, _x, _y);
			
			//var _type = buffer_read(_buf, buffer_u8); 
			//show_debug_message("LOAD COLLISION TILE: " + string(_coll));  

            var _type   = buffer_read(_buf, buffer_u8);
            var _sprite = buffer_read(_buf, buffer_u8);
            var _v1     = buffer_read(_buf, buffer_u8);
            var _v2     = buffer_read(_buf, buffer_u8);
            var _v3     = buffer_read(_buf, buffer_u8);
            var _v4     = buffer_read(_buf, buffer_u8);
            var _v5     = buffer_read(_buf, buffer_u8);

            if (_type == 255) {
                // Keep cell as empty
                ds_grid_set(entity_grid, _x, _y, 255);
            } else {
                var _ent = new entity();
				ds_grid_set(entity_grid, _x, _y, _ent);
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
#endregion

#region ENTITY/OBJECT STRUCT
function entity() constructor
	{
	show_debug_message("ENTITY CREATED")
	
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
	
	function update_entity()
		{
		switch (_type)
			{
			default: 
			sprite=spr_null; 
			name="";
			opt1="";
			opt2="";
			opt3="";
			opt4="";
			opt5="";
			break;
			case 0: 
			sprite=spr_prize;
			name="Prize Block";
			opt1="Hidden: ";
			opt2="Disguised: ";
			opt3="Prize: ";
			break;
			case 1: 
			sprite=spr_rock;
			name="Rock Block";
			opt1="Hidden: ";
			break;
			case 2: 
			sprite=spr_iron;
			opt1="Hidden: ";
			opt2="Left Drill";
			opt3="Down Drill";
			opt4="Right Drill";
			opt5="Up Drill";
			if var2==0 && var3==0 && var4==0 && var5==0
				{
				name="Iron Block";
				}
			else
				{
				name="Drill Block";
				}
			break;
			case 3: 
			sprite=spr_ice
			name="Ice Block";
			opt1="Hidden: ";
			break;
			case 4: 
			sprite=spr_rubber;
			name="Rubber Block";
			opt1="Hidden: ";
			break;
			case 5: 
			sprite=spr_shift;
			name="Shifting Block";
			opt1="Hidden: ";
			break;
			case 6: 
			sprite=spr_mushroom;
			name="Mushroom Block";
			opt1="Hidden: ";
			break;
			case 9: 
			sprite=spr_lift;
			name="Lift Block";
			opt1="Hidden: ";
			break;
			case 10: 
			sprite=spr_ghost;
			name="Ghost Block";
			opt1="Hidden: ";
			opt2="Disappear Time: ";
			opt3="Appear Time: ";
			opt4="Delay Time: ";
			break;
			case 11: 
			sprite=spr_h_platform;
			//name="Horizontal Platform";
			opt1="Type: ";
			opt2="Length: ";
			if var1==0
				{
				name="Horizontal Platform";
				}
			else
				{
				name="Horizontal Fake Steel";
				}
			break;
			case 12: 
			sprite=spr_v_platform;
			opt1="Type: ";
			opt2="Height: ";
			if var1==0
				{
				name="Vertical Platform";
				}
			else
				{
				name="Vertical Fake Steel";
				}
			break;
			case 13: 
			sprite=spr_vanishing;
			opt1="Hidden: ";
			opt2="Left Cannon: ";
			opt3="Down Cannon: ";
			opt4="Right Cannon: ";
			opt5="Up Cannon: ";
			if var2==0 && var3==0 && var4==0 && var5==0
				{
				name="Vanishing Block";
				}
			else
				{
				name="Shooting Block";
				}
			break;
			case 14: 
			sprite=spr_teleporter;
			name="Teleporter";
			opt1="Hidden: ";
			opt2="MAP: ";
			opt3="X POS: ";
			opt4="Y POS: ";
			break;
			case 15: 
			sprite=spr_flag;
			name="Flag";
			opt1="Hidden: ";
			break;
			case 18: 
			sprite=spr_dragon_walk;
			name="Dragon";
			opt1="Initial Direction: ";
			opt2="Flying: ";
			break;
			case 19: 
			sprite=spr_tank_head;
			name="Tank";
			opt1="Initial Direction: ";
			opt2="Shooting: ";
			break;
			case 20: 
			sprite=spr_driller_head;
			name="Driller";
			opt1="Initial Direction: ";
			break;
			case 21: 
			sprite=spr_drip;
			name="Drip";
			opt1="Initial Direction: ";
			break;
			case 22: 
			sprite=spr_diving_rock_appear;
			name="Diving Rock";
			opt1="Initial Direction: ";
			break;
			case 23: 
			sprite=spr_mini_hopping_skull_hang;
			name="Mini Hopping Skull";
			opt1="Initial Direction: ";
			break;
			case 24: 
			sprite=spr_cloud_float;
			name="Cloud";
			opt1="Initial Direction: ";
			break;
			case 25: 
			sprite=spr_armadillo_walk;
			name="Armadillo";
			opt1="Initial Direction: ";
			break;
			case 26: 
			sprite=spr_big_hopping_skull_hop;
			name="Big Hopping Skull";
			opt1="Initial Direction: ";
			break;
			case 27: 
			sprite=spr_tar_form;
			name="Tar Monster";
			opt1="Initial Direction: ";
			break;
			case 28: 
			sprite=spr_sphere;
			name="Sphere";
			opt1="Initial Direction: ";
			break;
			case 29: 
			sprite=spr_twin_walk;
			name="Spinning Twins";
			opt1="Initial Direction: ";
			break;
			case 30: 
			sprite=spr_scorpion_walk;
			name="Scorpion";
			opt1="Initial Direction: ";
			break;
			case 31: 
			sprite=spr_fireball;
			name="Fireball";
			opt1="Initial Direction: ";
			break;
			case 32: 
			sprite=spr_fire_demon;
			name="Fire Walker";
			opt1="Initial Direction: ";
			break;
			case 33: 
			sprite=spr_crab_walk;
			name="Crab";
			opt1="Initial Direction: ";
			break;
			case 34: 
			sprite=spr_archer_shoot_forward;
			name="Archer Statue";
			opt1="Initial Direction: ";
			break;
			case 35: 
			sprite=spr_lion_shoot;
			name="Lion";
			opt1="Initial Direction: ";
			break;
			case 36: 
			sprite=spr_tornado;
			name="Tornado";
			opt1="Initial Direction: ";
			break;
			case 37: 
			sprite=spr_crystal;
			name="Crystal";
			opt1="Initial Direction: ";
			break;
			case 38: 
			sprite=spr_hand_crawl;
			name="Creeping Hand";
			opt1="Initial Direction: ";
			break;
			case 39: 
			sprite=spr_ninja_block_up;
			name="Ninja";
			opt1="Initial Direction: ";
			break;
			case 40: 
			sprite=spr_ram_walk;
			name="Ram";
			opt1="Initial Direction: ";
			break;
			case 41: 
			sprite=spr_orca_walk;
			name="Orca";
			opt1="Initial Direction: ";
			break;
			case 42: 
			sprite=spr_robot;
			name="Rpbot";
			opt1="Initial Direction: ";
			break;
			case 43: 
			sprite=spr_ufo;
			name="UFO";
			opt1="Initial Direction: ";
			break;
			case 44: 
			sprite=spr_alien_walk;
			name="Alien";
			opt1="Initial Direction: ";
			break;
			case 45: 
			sprite=spr_boss;
			name="Boss";
			opt1="Initial Direction: ";
			break;
			case 46: 
			sprite=spr_headdy_metal;
			name="Final Boss";
			opt1="Initial Direction: ";
			break;
			}//end switch
		}
		
	#region DRAW EVENT
	function draw_entity() {
	if _type>=0 && _type<=6 ^^ _type>=9 && _type<=15
	pal_swap_set(spr_theme_pal,obj_system.level_theme-1,false);
	
	draw_sprite(sprite,0,x,y);
	
	if _type==11
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
	
	if _type==12
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
		
	if _type==14
		{
		draw_sprite_ext(sprite,0,x+32,y,-1,1,0,c_white,1)
		}
		
	if _type==19
		{
		draw_sprite(spr_tank_tread,0,x,y+8)
		}
		
	if _type==20
		{
		draw_sprite_ext(spr_driller_drill,0,x+16,y,-1,1,0,c_white,1);
		draw_sprite_ext(spr_driller_drill,0,x-16,y,1,1,0,c_white,1);
		}
		
	if _type==27
		{
		draw_sprite(sprite,6,x,y);	
		}
	
	if _type>=0 && _type<=6 ^^ _type>=9 && _type<=15
	pal_swap_reset();
	
	}
	#endregion

	}
#endregion

#region CREATE ENTITY GRID
entity_grid=ds_grid_create(room_width div 16,room_height div 16);
ds_grid_set_region(entity_grid,0,0,room_width div 16,room_height div 16,255);
current_ent=undefined;
#endregion

#region CREATE COLLISION AND TERRAIN TILEMAPS
collision_layer=layer_create(-2);
terrain_back_layer=layer_create(1);
terrain_front_layer=layer_create(0);

tile_theme_surface=-4
ent_display_surface=-4
scr_update_theme();

collision_tiles=layer_tilemap_create(collision_layer,0,0,holo_tiles,room_width/TILE_SIZE,room_height/TILE_SIZE);
terrain_tiles_b=layer_tilemap_create(terrain_back_layer,0,0,tileset,room_width/TILE_SIZE,room_height/TILE_SIZE);
terrain_tiles_f=layer_tilemap_create(terrain_front_layer,0,0,tileset,room_width/TILE_SIZE,room_height/TILE_SIZE);

tilemap_clear(collision_layer,0);
tilemap_clear(terrain_tiles_b,0);
tilemap_clear(terrain_tiles_f,0);

room_grid=ds_grid_create(room_width/TILE_SIZE,room_height/TILE_SIZE);
#endregion

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

#region teleport and demo fade colors
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
/*
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
*/
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
room_info_window_w=200;
room_info_window_x=display_get_gui_width()/2-(room_info_window_w/2);
room_info_window_h=108;
within_rinfo_window=false;
info_window_alpha=0.5;
room_info_window=scr_create_window(room_info_window_w,room_info_window_h,false)
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
entity_info_window_y=0;
entity_info_window_x=0;
spr_entity_info_window=scr_create_window(entity_window_w,entity_window_h,false);
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