// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrollbar_draw(_id,_x,_y,size,maxsize)
{
/*  CALL:        scrollbar_draw(id,x,y,w/h,maxw/h)

    INFO:        Draws the selected scrollbar. The value is measured in pixels.

    ARGUMENTS:   0 =  id      - The ID of the scrollbar to draw.
                 1 =  x       - The x starting position of the scrollbar.
                 2 =  y       - The y starting position of the scrollbar.
                 3 =  w/h     - The width or height of the scrollbar (buttons not included).
                 4 =  maxw/h  - The maximum width or height (buttons not included).

    WRITTEN BY:     Davve
    EDITTED BY:     Brian

*/
var scrollbar,xx,yy,wh,mwh,sprite,spr_width,spr_height,sel,sel2,a,sp,ep,tp;

scrollbar=_id;
xx=_x;
yy=_y;
wh=max(-16,size);
mwh=maxsize;
sprite=global.___sb[scrollbar,2];
spr_width=sprite_get_width(sprite);
spr_height=sprite_get_height(sprite);
tp=global.___sb[scrollbar,0];

if (global.___sbcurrent=scrollbar)
    {
    global.___sbtimer=max(0,(global.___sbtimer-1)*mouse_check_button(mb_left));
    }
    
for (a=((xx+spr_width)*(tp=0))+((yy+spr_height)*(tp>0)); a<((xx+wh+spr_width)*(tp=0))+((yy+wh+spr_height)*(tp>0)); a+=2) 
    {
    draw_sprite(sprite,(15*(tp=0))+(19*(tp>0)),(a*(tp=0))+(xx*(tp>0)),(yy*(tp=0))+(a*(tp>0)));
    }
    
if ((!mouse_check_button(mb_left) && global.___sbdrag>-1)) 
    {
    global.___sbdrag=-1;
    }
    
if (mwh>wh && wh>0) 
    {
    sp=((xx+spr_width)*(tp=0))+((yy+spr_height)*(tp>0))+(global.___sb[scrollbar,1]*(wh/mwh));
    ep=sp+max((wh*(wh/mwh)),4);
    
    if (global.___sbdrag=scrollbar && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=((xx+spr_width)*(tp=0))+((yy+spr_height)*(tp>0)) && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<((xx+(spr_width*2)+wh)*(tp=0))+((yy+(spr_height*2)+wh)*(tp>0))) 
        {
        global.___sb[scrollbar,1]+=(mwh/wh)*(((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))-((global.___mxprev*(tp=0))+(global.___myprev*(tp>0))));
        global.___mxprev=device_mouse_x_to_gui(0);
        global.___myprev=device_mouse_y_to_gui(0);
        }
        
    if (global.___sbcurrent=scrollbar && global.___sb[scrollbar,3]>0) 
        {
        global.___sb[scrollbar,1]+=((-1*mouse_wheel_up())+(1*mouse_wheel_down()))*ceil((mwh/wh)*((ep-sp)/3));
        }
        
    sel=(global.___sbdrag=-1 && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))>=((xx+spr_width)*(tp=0))+((yy+spr_height)*(tp>0)) && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))<sp && mouse_check_button(mb_left) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))>(yy*(tp=0))+(xx*(tp>0)) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))<((yy+spr_height)*(tp=0))+((xx+spr_height)*(tp>0)));
    sel+=2*(global.___sbdrag=-1 && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))>ep && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))<((xx+spr_width+wh)*(tp=0))+((yy+spr_height+wh)*(tp>0)) && mouse_check_button(mb_left) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))>(yy*(tp=0))+(xx*(tp>0)) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))<((yy+spr_height)*(tp=0))+((xx+spr_height)*(tp>0)));
    
    if (sel>0 && global.___sbtimer=0) 
        {
        global.___sb[scrollbar,1]+=((-1*(sel=1))+(1*(sel=2)))*ceil((mwh/wh)*((ep-sp)));
        global.___sb[scrollbar,1]=max(0,min(mwh-((ep-sp)*(mwh/wh)),global.___sb[scrollbar,1]));
        global.___sbtimer=ceil(fps/(15-(12*mouse_check_button_pressed(mb_left))));
        global.___sbcurrent=scrollbar;
        }
        
    global.___sb[scrollbar,1]=min(mwh-((ep-sp)*(mwh/wh)),max(0,global.___sb[scrollbar,1]))
    
    sp=((xx+spr_width)*(tp=0))+((yy+spr_height)*(tp>0))+(global.___sb[scrollbar,1]*(wh/mwh));
    ep=sp+max((wh*(wh/mwh)),4);
    
    for (a=floor(sp+1); a<=ceil(ep-2); a+=1) 
        {
        draw_sprite(sprite,(13*(tp=0))+(17*(tp>0)),(a*(tp=0))+(xx*(tp>0)),(yy*(tp=0))+(a*(tp>0)));
        }
        
    draw_sprite(sprite,(12*(tp=0))+(16*(tp>0)),(floor(sp)*(tp=0))+(xx*(tp>0)),(floor(sp)*(tp>0))+(yy*(tp=0)));
    draw_sprite(sprite,(14*(tp=0))+(18*(tp>0)),((ceil(ep)-2)*(tp=0))+(xx*(tp>0)),((ceil(ep)-2)*(tp>0))+(yy*(tp=0)));
    
    sel=(((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=sp && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<ep && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))>=(yy*(tp=0))+(xx*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))<((yy+spr_height)*(tp=0))+((xx+spr_width)*(tp>0)) && mouse_check_button_pressed(mb_left));
    
    if (sel=1 && global.___sbdrag=-1) 
        {
        global.___sbcurrent=scrollbar;
        global.___sbdrag=scrollbar;
        global.___mxprev=device_mouse_x_to_gui(0);
        global.___myprev=device_mouse_y_to_gui(0);
        }
    }
     
else if (global.___sbdrag=scrollbar) 
    {
    global.___sbdrag=-1;
    }
    
sel=(((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=(xx*(tp=0))+(yy*(tp>0)) && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<((xx+spr_width)*(tp=0))+((yy+spr_height)*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))>=(yy*(tp=0))+(xx*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))<((yy+spr_height)*(tp=0))+((xx+spr_width)*(tp>0)) && mouse_check_button(mb_left) && global.___sbdrag=-1 && mwh>wh);
sel2=(((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=((xx+wh+spr_width)*(tp=0))+((yy+wh+spr_height)*(tp>0)) && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<((xx+(spr_width*2)+wh)*(tp=0))+((yy+(spr_height*2)+wh)*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))>=(yy*(tp=0))+(xx*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))<((yy+spr_height)*(tp=0))+((xx+spr_width)*(tp>0)) && mouse_check_button(mb_left) && global.___sbdrag=-1 && mwh>wh);

if (sel+sel2>0 && global.___sbtimer=0) 
    {
    global.___sb[scrollbar,1]+=((-1*(sel=1))+(1*(sel2=1)))*ceil((mwh/wh)*((ep-sp)/3));
    global.___sb[scrollbar,1]=max(0,min(mwh-((ep-sp)*(mwh/wh)),global.___sb[scrollbar,1]));
    global.___sbtimer=ceil(fps/(15-(12*mouse_check_button_pressed(mb_left))));
    global.___sbcurrent=scrollbar;
    }

draw_sprite(sprite,(0*(tp=0))+(6*(tp>0))+(sel>0 || mwh<=wh)+(mwh<=wh),xx,yy);
draw_sprite(sprite,(3*(tp=0))+(9*(tp>0))+(sel2>0 || mwh<=wh)+(mwh<=wh),((xx+wh+spr_width)*(tp=0))+(xx*(tp>0)),(yy*(tp=0))+((yy+wh+spr_height)*(tp>0)));
}