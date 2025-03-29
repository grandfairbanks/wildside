///gridcol_quadrant_rectangle(ox,oy,xx,yy);
function gridcol_quadrant_rectangle(argument0, argument1, argument2, argument3) {

	var ox=argument0;   // origin of sprite,object
	var oy=argument1;
	var xx=argument2;   // target coordinates to check as determined by gridcol_place_meeting
	var yy=argument3;
	var ax=(TILE_SIZE-1)*(ox>xx);  // Quadrant intersections along border - see the visualization for this - on slopes we check more than 1 point per quadrant
	var ay=(TILE_SIZE-1)*(oy>yy);
	var tx = xx mod TILE_SIZE;
	var ty = yy mod TILE_SIZE;
	var col=false;

	switch (obj_system.room_grid[# xx div TILE_SIZE, yy div TILE_SIZE])
	    {
	    //45 degree slope 
	    case 1: col =  ( ( (TILE_SIZE-1)-tx >= ty)||  ( (TILE_SIZE-1)-tx >= ay) ||  ( (TILE_SIZE-1)-ax >= ty)); break;
	    //
	    case 2: col =  ( (tx >= ty)   ||  (tx >= ay)    ||  (ax >= ty)  );  break;  // 4 Slopes - MAGIC =D see pictures in tutorial for explanation
	    //
	    case 3: col =  ( (tx <= ty)   ||  (tx <= ay)    ||  (ax <= ty)  );  break;
	    //
	    case 4: col =  ( ( (TILE_SIZE-1)-tx <= ty)||  ( (TILE_SIZE-1)-tx <= ay) ||  ( (TILE_SIZE-1)-ax <= ty)); break; 
	    // solid tile
	    case 5: col = true;                                              break;  // and one square wall - easy peasy
	    }
	return col;


}
