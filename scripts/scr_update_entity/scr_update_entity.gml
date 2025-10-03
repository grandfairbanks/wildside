// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_update_entity(){

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
		name="Iron Block"
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
		sprite=spr_elevator;
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
		name="Horizontal Platform";
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
		name="Vertical Platform"
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
		name="Vanishing Block";
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

	if argument_count!=0
	{
	return name;
	}
}