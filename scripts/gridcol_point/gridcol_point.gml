///gridcol_point(x,y)
function gridcol_point(argument0, argument1) {

	//Determines if the given coordinates collide with a wall - much easier then the quadrant_rectangle!

	var tx = argument0 mod TILE_SIZE;
	var ty = argument1 mod TILE_SIZE;
	var col=false;

	switch (obj_system.room_grid[# argument0 div TILE_SIZE, argument1 div TILE_SIZE])
	    {
	    case 1:     col = ( (TILE_SIZE-1)-tx >= ty);    break;
	    case 2:     col = (tx >= ty);       break;      // 4 Slopes
	    case 3:     col = (tx <= ty);       break;
	    case 4:     col = ( (TILE_SIZE-1)-tx <= ty);    break;
	    case 5:     col = 1;                      break;      // 1 Square Wall
	    case 6:     col = (TILE_SIZE-1-tx/2 <= ty)
	    case 7:     col = ((TILE_SIZE-1+tx)/2 <= ty)
	    }
	return col;


}
