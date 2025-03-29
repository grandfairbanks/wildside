/// @description Insert description here
// You can write your code in this editor

#region INTRODUCTION SEQUENCE
//draw neon sign
//if (inIntro)
//draw_sprite_part(spr_wild_sign,0,0,0,66,38,125,106);
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

#region DRAW CURSOR
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

#region DRAW MAP
/*
var str="ELSEWHERE";
var strw=string_width(str);
var test_window=scr_create_window((strw-1)+12,16,true);
pal_swap_set(spr_theme_win_pal,THEME.DESERT,false);
draw_sprite(test_window,0,100,64)
pal_swap_reset();
scr_text_button(114,76,str);


var str2="ELSEWHERE 23";
var strw=string_width(str2);
var test_window2=scr_create_window((strw-1)+12,16,true);
pal_swap_set(spr_theme_win_pal,THEME.CAVE,false);
draw_sprite(test_window2,0,100,112)
pal_swap_reset();
scr_text_button(114,124,str2);
*/
#endregion