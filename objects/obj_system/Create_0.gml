/// @description Insert description here
// You can write your code in this editor

#region CREATE BACKGROUND COLOR OBJECT
instance_create_depth(0,0,4,obj_bkg_col);
#endregion

#region DEBUG
debug=false;
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

level_num=-1;
level_name="LEVEL NAME";
level_x=room_width/SCREEN_WIDTH;
level_y=room_height/SCREEN_HEIGHT;
level_theme=THEME.SKY;
level_attr=ATTRIBUTE.NORMAL;
start_x=-1;
start_y=-1;
end_x=-1;
end_y=-1;
flag_exists=false;
level_par=0;
path_bonus=0;
total_screens=(level_x*level_y);
grid_size=(level_x*TILE_SIZE)+(level_y*TILE_SIZE);
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
			}
		}
		
	#region DRAW EVENT
	function draw_entity() {
	//var _i;
	if _type>=0 && _type<=6 ^^ _type>=9 && _type<=15
	pal_swap_set(spr_theme_pal,obj_system.level_theme-1,false);
	
	draw_sprite(sprite,0,x,y);
	
	if _type==11
		{
		var _i;
		draw_sprite(sprite,0,x,y);
		if var2>0
			{
			for(_i=0; _i<var2; _i++)
				{
				draw_sprite(sprite,1,x+16+(16*_i),y);
				}
			}
		draw_sprite_ext(sprite,2,x+16+(16*_i),y,1,1,0,c_white,1)
		}
	
	if _type==12
		{
		var _i;
		draw_sprite(sprite,0,x,y);
		if var2>0
			{
			for(_i=0; _i<var2; _i++)
				{
				draw_sprite(sprite,1,x,y+16+(16*_i));
				}
			}
		draw_sprite_ext(sprite,2,x,y+16+(16*_i),1,1,0,c_white,1)
		}
		
	if _type==14
		{
		draw_sprite(sprite,0,x,y);
		draw_sprite_ext(sprite,0,x+32,y,-1,1,0,c_white,1)
		}
	
	if _type>=0 && _type<=6 ^^ _type>=9 && _type<=15
	pal_swap_reset();
	
	}
	#endregion


	}
#endregion

#region CREATE ENTITY GRID
entity_grid=ds_grid_create(room_width/16,room_height/16);
ds_grid_set_region(entity_grid,0,0,room_width/16,room_height/16,-4);
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

room_grid=ds_grid_create(room_width/TILE_SIZE,room_height/TILE_SIZE);
#endregion

#region EDITOR PROPERTIES
mode=0;

if !directory_exists("Settings")
directory_create("Settings");

if !directory_exists("Levels")
directory_create("Levels");

#endregion

#region VIEW SET UP
alarm[0]=1; //center the window
fullscreen=window_get_fullscreen();
//ideal width
view_width=320;

//ideal height
view_height=224;

//window scale
window_scale=2;
prev_scale=window_scale;

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

//teleport and demo fade colors
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
map_window_visible=true;
ds_list_add(game_map,"Blue Lake Woods I");
ds_list_add(game_map,"Blue Lake Woods II");
ds_list_add(game_map,"Highwater Pass I");
ds_list_add(game_map,"Highwater Pass II");

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