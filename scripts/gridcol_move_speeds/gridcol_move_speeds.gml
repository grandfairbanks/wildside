///gridcol_move_speeds(vx,vy)
function gridcol_move_speeds(argument0, argument1) {

	//Input
	avx+=argument0;// Input of uneven number velocities
	avy+=argument1;
	var vx=avx div 1;// velocity x vector
	var vy=avy div 1;// velocity y vector
	avx-=vx;// calculate remainder
	avy-=vy;// calculate remainder

	// Y + X AXIS
	// The purpose of this is to adjust for correct angular movement, 
	//and save alot of collision checks - see IF,ELSE below

	// Determine total movement angle
	var angle=point_direction(0,0,vx,vy);

	// adjust movement vector (x)
	var pvx=vx*abs(dcos(angle)); 
	// adjust movement vector (y)                                                                   
	var pvy=vy*abs(dsin(angle));  

	// IF there is no collision in combined direction of travel, move there                                                                  
	if !gridcol_place_meeting(x+pvx,y+pvy) 
	    {
	    x=round(x+pvx);y=round(y+pvy);
	    }                         
	else
	{  // ELSE: seperate axis checks required
	// X AXIS
	if vx!=0{                                                                                       // Do we need to move in X direction at all?
	    if vy!=0 {vy=((vy>0)-(vy<0))*abs(vx)}                                                       // !!!OPTIONAL LINE!!!: Eliminates janky decimal movement - but can only handle 8 directional movement - not required in Y code!
	    var sx=x;                                                                                   // Save current x location - why? to calculate remaining vx - more on that further on
	    var svx=(vx>0)-(vx<0);                                                                      // calculate the sign of vx - only once to save ressources - will always stay the same!
	    repeat(abs(vx)){                                                                            // LOOP: repeat as often as vx:
	        if !gridcol_place_meeting(x+svx,y) {x+=svx;}                                            // no collision in direction of travel: move one pixel in that direction!
	        else {break;}                                                                           // otherwise break out of repeat loop
	    }                                                                                           // END LOOP
	    vx=round((vx-(x-sx))*dsin(45));                                                             // determine whats left of vx. Now, if at all, move at an angle - so reduce speed by 45° (=> 45° slopes);
	    if vx!=0{                                                                                   // IF the rounded vx remainder is not zero:
	        var ydir=(!gridcol_place_meeting(x+svx,y+1))-(!gridcol_place_meeting(x+svx,y-1));       // determine direction on y axis that we need to go: down free? - up free?: result determines direction - akin to sign function
	        if ydir!=0{                                                                             // IF direction along y axis is not zero, theres a free spot => it's  a slope!   If zero: no decision can be made based on input.
	            x+=svx;y+=ydir;                                                                     // As the direction check already checked one px ahead in each direction, move that step.
	            repeat(abs(vx)-1){                                                                  // LOOP: same procedure as before! Loop remaining vx-1, -1 as object already moved one px in each direction - see 2 lines above (IF...)
	                if (!gridcol_place_meeting(x+svx,y+ydir)) {x+=svx;y+=ydir;}                     // No collision ahead? Move! Technically this may move beyond the slope, effects minor and less collision check
	                else {break;}                                                                   // break out of the loop if collision along slope encountered, such as wall.
	            }                                                                                   // END - technically there might be some vx remaining, add to this if you like ;)
	        }                                                                   
	    }
	}

	// Y AXIS
	if vy!=0{
	    var sy=y;
	    var svy=(vy>0)-(vy<0);
	    repeat(abs(vy)){
	        if !gridcol_place_meeting(x,y+svy) {y+=svy;}
	        else {break;}
	    }
	    vy=round((vy-(y-sy))*dsin(45)); 
	    if vy!=0{
	        var xdir=(!gridcol_place_meeting(x+1,y+svy))-(!gridcol_place_meeting(x-1,y+svy));
	        if xdir!=0{
	            x+=xdir;y+=svy;
	            repeat(abs(vy)-1){
	                if (!gridcol_place_meeting(x+xdir,y+svy))
	                    {x+=xdir;y+=svy;}
	                else {break;}
	            }
	        }
	    }
	}

	} //END ELSE SEPERATE MOVEMENT CHECKS


}
