/// @description Insert description here
// You can write your code in this editor

#region INTRODUCTION SEQUENCE
//draw neon sign
//if (inIntro)
//draw_sprite_part(spr_wild_sign,0,0,0,66,38,125,106);
#endregion

#region DRAW ENTITES
for (var i=0; i<room_width/16; i++)
	{
	for (var j=0; j<room_height/16; j++)
		{
		var _ent_struct=ds_grid_get(entity_grid,i,j)
		
		if _ent_struct!=-4
		_ent_struct.draw_entity();	
		else
		{}
		}
		
	}
	
#endregion

#region DRAW COLLISION VISUALIZATIONS
if (visual==1 && instance_exists(obj_player)) 
    {
    // Visualisation of gridcol_placemeeting checks
    var left,right,up,down;
    left = obj_player.x-(sprite_get_width(obj_player.sprite_index)/2);
    right= obj_player.x+(sprite_get_width(obj_player.sprite_index)/2)-1;
    up   = obj_player.y-sprite_get_height(obj_player.sprite_index)-1;
    down = obj_player.y//+(sprite_get_height(obj_player.sprite_index/2))-1;
    
    //DRAW COLLISION POINTS AT CORNERS
    draw_point_colour(left,up,c_lime);
    draw_point_colour(right,up,c_lime);
    draw_point_colour(left,down,c_lime);
    draw_point_colour(right,down,c_lime);
    
    ///DRAW OTHER DOTS
    draw_point_colour((left&~(TILE_SIZE-1))+(TILE_SIZE-1)*(left<obj_player.x),up,c_lime);
    draw_point_colour(left,(up&~(TILE_SIZE-2))+(TILE_SIZE-1)*(up<obj_player.y),c_lime);
    
    draw_point_colour((right&~(TILE_SIZE-1))+(TILE_SIZE-1)*(right<obj_player.x),down,c_lime);
    draw_point_colour(right,(down&~(TILE_SIZE-1))+(TILE_SIZE-1)*(down<obj_player.y),c_lime);
    
    draw_point_colour((left&~(TILE_SIZE-1))+(TILE_SIZE-1)*(left<obj_player.x),down,c_red);
    draw_point_colour(left,(down&~(TILE_SIZE-1))+(TILE_SIZE-1)*(down<obj_player.y),c_red);
    
    draw_point_colour((right&~(TILE_SIZE-1))+(TILE_SIZE-1)*(right<obj_player.x),up,c_red);
    draw_point_colour(right,(up&~(TILE_SIZE-1))+(TILE_SIZE-1)*(up<obj_player.y),c_red);
    }

if (visual==2) 
    {
    // Visualization collision line
    var sx=obj_player.x;
    var sy=obj_player.y;
    var tx=mouse_x;
    var ty=mouse_y;
    
    var deltax=abs((tx div TILE_SIZE) - (sx div TILE_SIZE));
    var deltay=abs((ty div TILE_SIZE) - (sy div TILE_SIZE));
    
    draw_point_colour(sx,sy,c_red);
    draw_point_colour(tx,ty,c_red);
    
    //X    
    if deltax>0
        {
        var xslope=((ty-sy)/(tx-sx));
        var cx=(sx&~(TILE_SIZE-1))+(TILE_SIZE-1)*(tx>sx);  // sx to nearest grid intersection
        var cy=sy+xslope*(cx-sx)     // adjust cx
        draw_point_colour(cx,cy,c_lime);                                                    
        draw_point_colour((tx&~(TILE_SIZE-1))+(TILE_SIZE-1)*(tx<sx),ty+xslope*(((tx&~(TILE_SIZE-1))+(TILE_SIZE-1)*(tx<sx))-tx),c_lime);                                 
        var dirx=(tx>sx)-(tx<sx);
        repeat(deltax-1)
            {
            draw_point_colour(cx+dirx,cy+xslope*dirx,c_lime);
            draw_point_colour(cx+TILE_SIZE*dirx,cy+xslope*TILE_SIZE*dirx,c_lime);
            cx+=TILE_SIZE*dirx;
            cy+=xslope*TILE_SIZE*dirx;
            }
        }
       
    //Y    
    if deltay>0
        {
        var yslope=((tx-sx)/(ty-sy));
        var cy=(sy&~(TILE_SIZE-1))+(TILE_SIZE-1)*(ty>sy);  // sx to nearest value
        var cx=sx+yslope*(cy-sy)     // adjust cx
        draw_point_colour(cx,cy,c_red);
        draw_point_colour(tx+yslope*(((ty&~(TILE_SIZE-1))+(TILE_SIZE-1)*(ty<sy))-ty),(ty&~(TILE_SIZE-1))+(TILE_SIZE-1)*(ty<sy),c_red);                                 
        var diry=(ty>sy)-(ty<sy);
        repeat(deltay-1)
            {
            draw_point_colour(cx+yslope*diry,cy+diry,c_red);
            draw_point_colour(cx+yslope*TILE_SIZE*diry,cy+TILE_SIZE*diry,c_red);
            cy+=TILE_SIZE*diry;
            cx+=yslope*TILE_SIZE*diry;
            }
        }
    }
#endregion

#region DRAW ROOM CURSOR
if (canPlace==true)
	{
	var xx=floor(mouse_x/TILE_SIZE)*TILE_SIZE;
	var yy=floor(mouse_y/TILE_SIZE)*TILE_SIZE;
	draw_set_alpha(0.5);
	draw_rectangle_color(xx,yy,xx+15,yy+15,c_white,c_white,c_white,c_white,false);
	draw_set_alpha(1);
	}
	else
	{	
	}
#endregion

