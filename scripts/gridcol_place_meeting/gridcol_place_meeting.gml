///gridcol_place_meeting(xx,yy);
function gridcol_place_meeting(argument0, argument1) {

	// works akin to place_meeting, but we need to determine the borders to check for first

	var xx=argument0;
	var yy=argument1;
	var col=false;

	// Adjust for object dimensions => find the borders from the sprite-origin given by xx,yy
	var left,right,up,down;
	left = xx-(sprite_width/2);
	right= xx+(sprite_width/2)-1;
	up   = yy-sprite_height-1;
	down = yy;

	// Check object/sprite borders
	col =  ( 
	        gridcol_quadrant_rectangle(xx,yy,left,up)   ||  // Left top corner
	        gridcol_quadrant_rectangle(xx,yy,right,up)  ||  // right top corner
	        gridcol_quadrant_rectangle(xx,yy,left,down) ||  // left bottom corner
	        gridcol_quadrant_rectangle(xx,yy,right,down)//||  // right bottom corner 
	       //gridcol_point(xx,down) // middle bottom    
	      );
	return col;


}
