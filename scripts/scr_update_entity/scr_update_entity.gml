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
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
        { label: "Disguised",   ref: "var2", type: "bool" },
        { label: "Prize Type",  ref: "var3", type: "enum", values: ["Diamond", "10,000 Points", "Skycutter", "Cyclone", "Red Stealth", "Eyeclops", "Juggernaut", "Iron Knight", "Berzerker", "Maniaxe", "Micromax", "1-UP", "Clock", "Continue", "10 Diamonds"] }
		];
		break;
		case 1: 
		sprite=spr_rock;
		name="Rock Block";
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
		];
		break;
		case 2: 
		sprite=spr_iron;
		name="Iron Block"
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
        { label: "Left Drill",   ref: "var2", type: "bool" },
		{ label: "Down Drill",      ref: "var3", type: "bool" },
        { label: "Right Drill",   ref: "var4", type: "bool" },
        { label: "Up Drill",      ref: "var5", type: "bool" },
		];
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
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
		];
		break;
		case 4: 
		sprite=spr_rubber;
		name="Rubber Block";
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
		];
		break;
		case 5: 
		sprite=spr_shift;
		name="Shifting Block";
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
		];
		break;
		case 6: 
		sprite=spr_mushroom;
		name="Mushroom Block";
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
		];
		break;
		case 9: 
		sprite=spr_elevator;
		name="Lift Block";
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
		];
		break;
		case 10: 
		sprite=spr_ghost;
		name="Ghost Block";
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
        { label: "Disappear Time",   ref: "var2", type: "bool" },
		{ label: "Appear Time",      ref: "var3", type: "bool" },
        { label: "Delay",   ref: "var4", type: "bool" },
		];
		break;
		case 11: 
		sprite=spr_h_platform;
		name="Horizontal Platform";
		fields = [
        { label: "Type",      ref: "var1", type: "bool" },
        { label: "Length",   ref: "var2", type: "bool" },
		];
		
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
		fields = [
        { label: "Type",      ref: "var1", type: "bool" },
        { label: "Height",   ref: "var2", type: "bool" },
		];
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
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
        { label: "Left Cannon",   ref: "var2", type: "bool" },
		{ label: "Down Cannon",      ref: "var3", type: "bool" },
        { label: "Right Cannon",   ref: "var4", type: "bool" },
        { label: "Up Cannon",      ref: "var5", type: "bool" },
		];
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
		fields = [
        { label: "Hidden",      ref: "var1", type: "bool" },
		{ label: "Map" ,       ref: "var2", type: "button", action: function() { scr_teleport_selection(); } },
		{ label: "X POS",      ref: "var3", type: "bool" },
        { label: "Y POS",   ref: "var4", type: "bool" },
		];
		break;
		case 15: 
		sprite=spr_flag;
		name="Flag";
		break;
		case 18: 
		sprite=spr_dragon_walk;
		name="Dragon";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
        { label: "Flying",   ref: "var2", type: "bool" },
		];
		break;
		case 19: 
		sprite=spr_tank_head;
		name="Tank";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
        { label: "Shooting",   ref: "var2", type: "bool" },
		];
		break;
		case 20: 
		sprite=spr_driller_head;
		name="Driller";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 21: 
		sprite=spr_drip;
		name="Drip";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 22: 
		sprite=spr_diving_rock_appear;
		name="Diving Rock";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 23: 
		sprite=spr_mini_hopping_skull_hang;
		name="Mini Hopping Skull";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 24: 
		sprite=spr_cloud_float;
		name="Cloud";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 25: 
		sprite=spr_armadillo_walk;
		name="Armadillo";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 26: 
		sprite=spr_big_hopping_skull_hop;
		name="Big Hopping Skull";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 27: 
		sprite=spr_tar_form;
		name="Tar Monster";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 28: 
		sprite=spr_sphere;
		name="Sphere";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 29: 
		sprite=spr_twin_walk;
		name="Spinning Twins";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 30: 
		sprite=spr_scorpion_walk;
		name="Scorpion";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 31: 
		sprite=spr_fireball;
		name="Fireball";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 32: 
		sprite=spr_fire_demon;
		name="Fire Walker";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 33: 
		sprite=spr_crab_walk;
		name="Crab";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 34: 
		sprite=spr_archer_shoot_forward;
		name="Archer Statue";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 35: 
		sprite=spr_lion_shoot;
		name="Lion";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 36: 
		sprite=spr_tornado;
		name="Tornado";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 37: 
		sprite=spr_crystal;
		name="Crystal";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 38: 
		sprite=spr_hand_crawl;
		name="Creeping Hand";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 39: 
		sprite=spr_ninja_block_up;
		name="Ninja";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 40: 
		sprite=spr_ram_walk;
		name="Ram";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 41: 
		sprite=spr_orca_walk;
		name="Orca";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 42: 
		sprite=spr_robot;
		name="Rpbot";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 43: 
		sprite=spr_ufo;
		name="UFO";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 44: 
		sprite=spr_alien_walk;
		name="Alien";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 45: 
		sprite=spr_boss;
		name="Boss";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		case 46: 
		sprite=spr_headdy_metal;
		name="Final Boss";
		fields = [
        { label: "Initial Dir",      ref: "var1", type: "bool" },
		];
		break;
		}//end switch

	if argument_count!=0
	{
	return name;
	}
}