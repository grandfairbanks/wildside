// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_entity_name(opt){

	switch (opt)
		{
		default: 
		name="";
		break;
		case 0: 
		name="Prize Block";
		break;
		case 1: 
		name="Rock Block";
		break;
		case 2: 
		name="Iron Block";
		break;
		case 3: 
		name="Ice Block";
		break;
		case 4: 
		name="Rubber Block";
		break;
		case 5: 
		name="Shifting Block";
		break;
		case 6: 
		name="Mushroom Block";
		break;
		case 9: 
		name="Lift Block";
		break;
		case 10: 
		name="Ghost Block";
		break;
		case 11: 
		name="Horizontal Platform";
		break;
		case 12: 
		name="Vertical Platform";
		break;
		case 13: 
		name="Vanishing Block";
		break;
		case 14: 
		name="Teleporter";
		break;
		case 15: 
		name="Flag";
		break;
		case 18: 
		name="Dragon";
		break;
		case 19: 
		name="Tank";
		break;
		case 20: 
		name="Driller";
		break;
		case 21: 
		name="Drip";
		break;
		case 22: 
		name="Diving Rock";
		break;
		case 23: 
		name="Mini Hopping Skull";
		break;
		case 24: 
		name="Cloud";
		break;
		case 25: 
		name="Armadillo";
		break;
		case 26: 
		name="Big Hopping Skull";
		break;
		case 27: 
		name="Tar Monster";
		break;
		case 28: 
		name="Sphere";
		break;
		case 29: 
		name="Spinning Twins";
		break;
		case 30: 
		name="Scorpion";
		break;
		case 31: 
		name="Fireball";
		break;
		case 32: 
		name="Fire Walker";
		break;
		case 33: 
		name="Crab";
		break;
		case 34: 
		name="Archer Statue";
		break;
		case 35: 
		name="Lion";
		break;
		case 36: 
		name="Tornado";
		break;
		case 37: 
		name="Crystal";
		break;
		case 38: 
		name="Creeping Hand";
		break;
		case 39: 
		name="Ninja";
		break;
		case 40: 
		name="Ram";
		break;
		case 41: 
		name="Orca";
		break;
		case 42: 
		name="Robot";
		break;
		case 43: 
		name="UFO";
		break;
		case 44: 
		name="Alien";
		break;
		case 45: 
		name="Boss";
		break;
		case 46: 
		name="Final Boss";
		break;
		}//end switch

	if argument_count!=0
	{
	return name;
	}
}