///brute_force_collision_line(x1,y1,x2,y2,granularity)
function brute_force_collision_line(argument0, argument1, argument2, argument3, argument4) {

	/*
	Note at at step size of 5 along a straight long line (around 600px) 
	gridcol_line performs ~7x better, at stepsize 10 around ~3-4x better and with absolute hairpin precision!
	*/

	// Input
	var sx=argument0;
	var sy=argument1;
	var tx=argument2;
	var ty=argument3;
	var step=argument4;

	// Check Start + End
	var col=(gridcol_point(sx,sy)||gridcol_point(tx,ty));
	if col return col;

	//Loop until collision or sx,y close to tx,ty
	var angle=point_direction(sx,sy,tx,ty);
	while ( abs(tx-sx)>step || abs(ty-sy)>step ) {
	    sx+=lengthdir_x(step,angle);
	    sy+=lengthdir_y(step,angle);
	    col = gridcol_point(sx,sy); if col return col;
	}



}
