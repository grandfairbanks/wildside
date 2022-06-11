// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_entity_display(){
	
	//CREATE THE SURFACE FOR THE ENTITY DISPLAY
	var ent_display_surface=surface_create(256,256);
	//SET FURTHER DRAWING TO NEWLY CREATED SURFACE
	surface_set_target(ent_display_surface);
	//TURN ON PALETTE SWAPPING FOR LEVEL THEME
	pal_swap_set(spr_theme_pal,lvl_theme-1,false);
	
	//DRAW BLOCK SPRITES ON SURFACE
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
	
	if (lvl_attr!=5) //IF THE LEVEL IS NOT AN ELSEWHERE
	{draw_sprite_part(spr_flag,0,0,0,16,16,96,16);}//DRAW THE FLAG NORMALLY
	else //IF IT IS AN ELSEWHERE LEVEL
	{draw_sprite_part_ext(spr_flag,0,0,0,16,16,96,16,1,1,c_white,0.5);}//DRAW THE FLAG BUT TRANSPARENT
	
	
	//TURN OFF PALETTE SWAPPING
	pal_swap_reset();
	
		var _layer, _tmap, spr; //CREATE VARIABLES
	_layer=layer_create(-99);//CREATE TEMP TILE LAYER
	_tmap=layer_tilemap_create(_layer,112,0,holo_tiles,2,2);//CREATE TEMPORARY TILEMAP TO DRAW HOLO TILES
	
	//PLACE HOLO TILES
	tilemap_set(_tmap,5,0,0);
	tilemap_set(_tmap,1,1,0);
	tilemap_set(_tmap,3,0,1);
	tilemap_set(_tmap,4,1,1);
	
	//DRAW HOLO TILEMAP
	draw_tilemap(_tmap,112,0)
	
	//IF THIS IS A BOSS LEVEL
	if (lvl_attr==6)
		{
		//DRAW BOSS EYES
		draw_sprite(spr_boss_eyes,14,60,59);
		draw_sprite(spr_boss_eyes,14,84,59);
		//DRAW BOSS SPRITE
		draw_sprite_part(spr_boss,0,0,16,64,48,40,48);
		}
	else if (lvl_attr==7)
		{
		draw_sprite_part(spr_heady_metal,0,0,16,64,48,40,48);
		}
	else
		{
		draw_sprite_part(spr_dragon_walk,0,0,8,16,16,0,48);
		draw_sprite_part(spr_tank_head,0,0,8,16,16,16,48);
		draw_sprite_part(spr_driller_head,0,0,0,16,16,32,48);
		draw_sprite_part(spr_drip_form,4,0,0,16,16,48,48);
	
		draw_sprite_part(spr_diving_rock_h,0,0,8,16,16,64,48);
		draw_sprite_part(spr_mini_hopping_skull_hang,0,0,0,16,16,80,48);
		draw_sprite_part(spr_cloud_float,0,0,8,16,16,96,48);
		draw_sprite_part(spr_armadillo_walk,0,0,8,16,16,112,48);
		draw_sprite_part(spr_big_hopping_skull_hop,0,8,12,16,16,128,48);
	
		draw_sprite_part(spr_tar_form,6,0,4,16,16,0,64);
		draw_sprite_part(spr_sphere,0,0,0,16,16,16,64);
		draw_sprite_part(spr_twin_walk,0,0,0,16,16,32,64);
		draw_sprite_part(spr_scorpion_walk,0,0,8,16,16,48,64);
	
		draw_sprite_part(spr_fireball,12,3,4,16,16,64,64);
		draw_sprite_part(spr_fire_demon,0,0,4,16,16,80,64);
		draw_sprite_part(spr_crab_walk,0,0,0,16,16,96,64);
		draw_sprite_part(spr_archer_shoot_forward,0,4,0,16,16,112,64);
		draw_sprite_part(spr_lion_shoot,0,8,12,16,16,128,64);
	
		draw_sprite_part(spr_tornado,0,0,16,16,16,0,80);
		draw_sprite_part(spr_crystal,0,0,0,16,16,16,80);
		draw_sprite_part(spr_hand_grab,0,0,8,16,16,32,80);
		draw_sprite_part(spr_ninja_block_up,0,0,8,16,16,48,80);
	
		draw_sprite_part(spr_ram_walk,0,4,0,16,16,64,80);
		draw_sprite_part(spr_orca_walk,0,0,8,16,16,80,80);
		draw_sprite_part(spr_robot,0,0,0,16,16,96,80);
		draw_sprite_part(spr_ufo,0,0,0,16,16,112,80);
		draw_sprite_part(spr_alien_walk,6,0,0,16,16,128,80);
		}
	surface_reset_target();
	spr=sprite_create_from_surface(ent_display_surface,0,0,144,112,false,false,0,0);
	layer_tilemap_destroy(_tmap);
	layer_destroy(_layer);
	surface_free(ent_display_surface);
	return spr;
	}