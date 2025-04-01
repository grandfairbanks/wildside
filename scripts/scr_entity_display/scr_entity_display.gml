// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_entity_display(){
	ent_display_surface=surface_create(256,256);
	surface_set_target(ent_display_surface);
	pal_swap_set(spr_theme_pal,level_theme-1,false);
	draw_sprite(spr_prize,0,0,0);
	draw_sprite(spr_rock,0,16,0);
	draw_sprite(spr_iron,0,32,0);
	draw_sprite(spr_ice,0,48,0);
	draw_sprite(spr_rubber,0,64,0);
	draw_sprite(spr_shift,0,80,0);
	draw_sprite(spr_mushroom,0,96,0);
	draw_sprite(spr_elevator,1,0,16);
	draw_sprite(spr_ghost,0,16,16);
	draw_sprite(spr_h_platform,0,32,16);
	draw_sprite(spr_v_platform,0,48,16);
	draw_sprite(spr_vanishing,0,64,16);
	draw_sprite(spr_teleporter,0,80,16);
	
	if level_attr!=5
	draw_sprite_part(spr_flag,0,0,0,16,16,96,16);
	
	pal_swap_reset();
	
		var _layer, _tmap;
	_layer=layer_create(-99);
	_tmap=layer_tilemap_create(_layer,112,0,holo_tiles,2,2);
	tilemap_set(_tmap,5,0,0);
	tilemap_set(_tmap,1,1,0);
	tilemap_set(_tmap,3,0,1);
	tilemap_set(_tmap,4,1,1);
	draw_tilemap(_tmap,112,0)
	
	if (level_attr!=6) && (level_attr!=7)
		{
		draw_sprite_part(spr_dragon_walk,0,0,8,16,16,0,64);
		draw_sprite_part(spr_tank_head,0,0,8,16,16,16,64);
		draw_sprite_part(spr_driller_head,0,0,0,16,16,32,64);
		draw_sprite_part(spr_drip_form,4,0,0,16,16,48,64);
	
		draw_sprite_part(spr_diving_rock_h,0,0,8,16,16,64,64);
		draw_sprite_part(spr_mini_hopping_skull_hang,0,0,0,16,16,80,64);
		draw_sprite_part(spr_cloud_float,0,0,8,16,16,96,64);
		draw_sprite_part(spr_armadillo_walk,0,0,8,16,16,112,64);
		draw_sprite_part(spr_big_hopping_skull_hop,0,8,12,16,16,128,64);
	
		draw_sprite_part(spr_tar_form,6,0,4,16,16,0,80);
		draw_sprite_part(spr_sphere,0,0,0,16,16,16,80);
		draw_sprite_part(spr_twin_walk,0,0,0,16,16,32,80);
		draw_sprite_part(spr_scorpion_walk,0,0,8,16,16,48,80);
	
		draw_sprite_part(spr_fireball,12,3,4,16,16,64,80);
		draw_sprite_part(spr_fire_demon,0,0,4,16,16,80,80);
		draw_sprite_part(spr_crab_walk,0,0,0,16,16,96,80);
		draw_sprite_part(spr_archer_shoot_forward,0,4,0,16,16,112,80);
		draw_sprite_part(spr_lion_shoot,0,8,12,16,16,128,80);
	
		draw_sprite_part(spr_tornado,0,0,16,16,16,0,96);
		draw_sprite_part(spr_crystal,0,0,0,16,16,16,96);
		draw_sprite_part(spr_hand_grab,0,0,8,16,16,32,96);
		draw_sprite_part(spr_ninja_block_up,0,0,8,16,16,48,96);
	
		draw_sprite_part(spr_ram_walk,0,4,0,16,16,64,96);
		draw_sprite_part(spr_orca_walk,0,0,8,16,16,80,96);
		draw_sprite_part(spr_robot,0,0,0,16,16,96,96);
		draw_sprite_part(spr_ufo,0,0,0,16,16,112,96);
		draw_sprite_part(spr_alien_walk,6,0,0,16,16,128,96);
		}
		
	if level_attr==6
		{
		var boss_x, boss_y;
		boss_x=8;
		boss_y=64;
		draw_sprite_part_ext(spr_boss,0,0,19,64,24,boss_x,boss_y,2,2,c_white,1);
		draw_sprite_part_ext(spr_boss_eye,1,0,0,16,16,boss_x+24,boss_y,2,2,c_white,1);
		draw_sprite_part_ext(spr_boss_eye,1,0,0,16,16,boss_x+72,boss_y,2,2,c_white,1);
		}
		
	if level_attr==7
		{
		draw_sprite_part_ext(spr_headdy_metal,0,0,100,64,24,8,64,2,2,c_white,1);
		}
		
	surface_reset_target();
	layer_tilemap_destroy(_tmap);
	layer_destroy(_layer);
	}