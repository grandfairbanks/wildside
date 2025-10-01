/// @description Insert description here
// You can write your code in this editor
///ROOM LOAD CHECK
if load==1 // IF THE ROOM RESTARTED AND LOAD IS SET TO 1, THAT MEANS WE ARE IN THE MIDDLE
          // OF LOADING A ROOM FROM A FILE. CALL THE scr_room_load SCRIPT TO ACTIVATE PART
          // TWO OF THE LOADING SCRIPT.
    {
    load_level(); //CALL ROOM LOADING SCRIPT
    }
else
	{
	}
	
if reSize=1
	{
	show_debug_message("script called from ROOM START event");
	collision_tiles = noone;
	terrain_tiles_b = noone;
	terrain_tiles_f = noone;
	resize_room(); //CALL RESIZE SCRIPT
	}
else
	{
		
	}
show_debug_message("ROOM WIDTH: " + string(level_x*SCREEN_WIDTH))
//turn on views
view_enabled=true;
//make view visible
view_visible[0]=true;